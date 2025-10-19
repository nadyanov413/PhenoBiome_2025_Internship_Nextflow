
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
process CalculateSequenceLength{

    input:
    path protein_fasta_file
  

    output:
    stdout

    script:
    """
    python3 /Users/nadyanovichkova/Projects/PhenoBiome2025/slides/scripts/calc_sequence_length.py ${protein_fasta_file}
    """
}

workflow{
    def protein_ch = Channel.fromPath('data/protein_ids.csv')
        .splitCsv()
        .map{row -> row[0]}
        
    DownloadProtein(protein_ch)
    CalculateSequenceLength(DownloadProtein.out)

    CalculateSequenceLength.out
        .collectFile(name: 'result/combined_lengths.csv', newLine: false)
       
    

}