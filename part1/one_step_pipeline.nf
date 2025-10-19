process DownloadProtein{   
    publishDir 'protein_sequence', mode: 'copy'
    
    input:
    val protein_id

    output:
    path "${protein_id}_proteins.fa"

    script:
    """
    efetch -db protein -id ${protein_id} -format fasta > ${protein_id}_proteins.fa
    """
}

workflow{
    def protein_ch = Channel.of('NP_001186746', 'NP_001186747', 'NP_001186748')
    DownloadProtein(protein_ch)
}