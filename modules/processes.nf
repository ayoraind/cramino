process MINIMAP2_SAM {
    tag "$meta"

   // publishDir "${params.output_dir}", mode:'copy'

    errorStrategy { task.attempt <= 5 ? "retry" : "finish" }
    maxRetries 5

    input:
    tuple val(meta), path(reads), path(assembly)

    output:
    tuple val(meta), path("*.sam"), emit: sam_ch
    path "versions.yml" , emit: versions_ch

    when:
    task.ext.when == null || task.ext.when

    script:
    """
    minimap2 -ax map-ont -t 12 $assembly $reads  > ${meta}.sam

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        minimap2: \$(minimap2 --version 2>&1)
    END_VERSIONS
    """
}

process SAM_SORT_AND_INDEX {
    tag "$meta"

   // publishDir "${params.output_dir}", mode:'copy'
   
    errorStrategy { task.attempt <= 5 ? "retry" : "finish" }
    maxRetries 5

    input:
    tuple val(meta), path(sam), path(assembly)

    output:
    tuple val(meta), path("*.bam"), path("${meta}.alignment.sorted.bam.bai"), path("${meta}.fasta.fai"), emit: bam_ch
    path "versions.yml",                                                                                 emit: versions_ch

    when:
    task.ext.when == null || task.ext.when

    script:
    """

    samtools sort $sam > ${meta}.alignment.sorted.bam
    samtools faidx $assembly
    samtools index -b ${meta}.alignment.sorted.bam

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        samtools: \$(echo \$(samtools --version 2>&1) | sed 's/^.*samtools //; s/Using.*\$//')
	 END_VERSIONS
    """
}

process CRAMINO {
    tag "qc of $meta bam output"
    
    
  //  publishDir "${params.output_dir}", mode:'copy'
    
    
    errorStrategy { task.attempt <= 5 ? "retry" : "finish" }
    maxRetries 5
    
    input:
    tuple val(meta), path(bam), path(bai), path(fai)
    
    output:
    tuple val(meta), path("*.txt"),         emit: txt_ch
    path "versions.yml"                   , emit: versions_ch

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta}"
    """
       
    cramino $bam -t $task.cpus > ${meta}.cramino.txt    
     
    
    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        cramino: \$(echo \$(cramino --version 2>&1) | sed 's/^.*cramino //; s/ .*\$//') 
    END_VERSIONS
    """
}

process CRAMINO_TRANSPOSE {
   // publishDir "${params.output_dir}", mode:'copy'
    tag "$sample_id"
    
    
    input:
    tuple val(sample_id), path(txt)
    
    output:
    path("*.transposed.craminoStats.txt"), emit: craminostats_ch

    
    script:
    """ 
    transpose_cramino.sh ${sample_id}

    """
}

process COMBINE_CRAMINO {
    publishDir "${params.output_dir}", mode:'copy'
    tag { 'combine cramino files'} 
    
    
    input:
    path(cramino_files)
    val(sequencing_date)

    output:
    path("combined_cramino_${sequencing_date}.txt"), emit: cramino_comb_ch

    
    script:
    """ 
    CRAMINO_FILES=(${cramino_files})
    
    for index in \${!CRAMINO_FILES[@]}; do
    CRAMINO_FILE=\${CRAMINO_FILES[\$index]}
    
    # add header line if first file
    if [[ \$index -eq 0 ]]; then
      echo "\$(head -1 \${CRAMINO_FILE})" >> combined_cramino_${sequencing_date}.txt
    fi
    echo "\$(awk 'FNR==2 {print}' \${CRAMINO_FILE})" >> combined_cramino_${sequencing_date}.txt
    done

    """
}
