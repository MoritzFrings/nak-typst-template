#import "../dependencies.typ": custom-date-format

#let dark_blue = color.rgb(8, 31, 92)

#let confidentiality_clause(language, nr, company, location) = {
  align(horizon)[
    #set text(font: "PT Sans")
    #let texts
    #if language == "en" {
      texts = (
        header: "Confidentiality Clause",
        work_title: "Theory/practice transfer paper",
      )
    } else if language == "de" {
      texts = (
        header: "Sperrvermerk",
        work_title: "Transferleistung Theorie/Praxis",
      )
    } else {
      return "Language must be English (\"en\") or German (\"de\")"
    }
    #set text(font: "PT Sans")


    #text(weight: "bold", fill: dark_blue, size: 15pt)[#texts.header]

    #set par(justify: true, spacing: 1.75em)
    #set text(size: 11pt)

    #if language == "en" {
      text()[The present paper titled *#texts.work_title No. #nr* contains internal and confidential information belonging to the company *#company*.\
        The disclosure of the content of this work, including any accompanying drawings and data,
        in whole or in part, is strictly prohibited. No copies or transcripts -- including in
        digital form -- may be produced. Any exceptions require the express written consent
        of the company.

        #location, #custom-date-format(datetime.today(), pattern: "d MMMM, yyyy", lang: language)]
    } else if language == "de" {
      text()[vorliegende Hausarbeit mit dem Titel *#texts.work_title Nr. #nr* beinhaltet interne und vertrauliche Informationen des Unternehmens *#company*.\
        Die Weitergabe des Inhalts der Arbeit und eventuell beiliegender Zeichnungen und Daten, im
        Gesamten oder in Teilen, ist grundsätzlich untersagt. Es dürfen keinerlei Kopien oder Abschriften --
        auch in digitaler Form -- gefertigt werden. Ausnahmen bedürfen der schriftlichen Genehmigung des
        Unternehmens.

        #location, den #custom-date-format(datetime.today(), pattern: "d. MMMM yyyy", lang: language)]
    }
  ]
}
