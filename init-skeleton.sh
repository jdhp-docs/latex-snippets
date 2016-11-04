#!/bin/sh

# DEFINE TEMPLATES ############################################################

TODO_AUTHOR_NAME="Jérémie DECOCK"
TODO_AUTHOR_EMAIL="jd.jdhp@gmail.com"
TODO_AUTHOR_WEB_SITE="www.jdhp.org"

TODO_COPYRIGHT_NOTICE="Copyright (c) 2016 ${TODO_AUTHOR_NAME} (${TODO_AUTHOR_WEB_SITE})"

TODO_AUTHORS_TITLE_PAGE="Jérémie \\textsc{Decock} \\\\ \\url{http://www.jdhp.org}"

TODO_DOCUMENT_DATE="November 4, 2016"

#TODO_INSTITUTE="\\textsuperscript{1}TAO, INRIA-CNRS-LRI, Univ. Paris-Sud, 91190 Gif-sur-Yvette, France"
#TODO_INSTITUTE="CEA Saclay - Irfu/SAp"
TODO_INSTITUTE=""

TODO_DOCUMENT_SUBJECT="Latex snippets"
TODO_DOCUMENT_KEYWORDS="latex,snippets,demo,memento"

TODO_DOCUMENT_TITLE="Latex snippets"
TODO_DOCUMENT_SUBTITLE=""
TODO_DOCUMENT_FILE_BASE_NAME="latex_snippets"

TODO_DOCUMENT_GITHUB_ACCOUNT="jdhp-docs"
TODO_DOCUMENT_GITHUB_REPOSITORY_NAME="latex-snippets"

TODO_DOCUMENT_GITHUB_URL="https://github.com/${TODO_DOCUMENT_GITHUB_ACCOUNT}/${TODO_DOCUMENT_GITHUB_REPOSITORY_NAME}"
TODO_DOCUMENT_ISSUE_TRACKER_URL="https://github.com/${TODO_DOCUMENT_GITHUB_ACCOUNT}/${TODO_DOCUMENT_GITHUB_REPOSITORY_NAME}/issues"

TODO_DOCUMENT_WEB_SITE_URL="http://www.jdhp.org/documentation_en.html#${TODO_DOCUMENT_FILE_BASE_NAME}"
TODO_DOCUMENT_HTML_URL="http://www.jdhp.org/docs/${TODO_DOCUMENT_FILE_BASE_NAME}/${TODO_DOCUMENT_FILE_BASE_NAME}.html"
TODO_DOCUMENT_PDF_URL="http://www.jdhp.org/dl/pdf/${TODO_DOCUMENT_FILE_BASE_NAME}.pdf"


# SETUP GIT ###################################################################

git remote rename origin skeleton
git remote add origin git@github.com:${TODO_DOCUMENT_GITHUB_ACCOUNT}/${TODO_DOCUMENT_GITHUB_REPOSITORY_NAME}.git
git push -u origin english-version

git submodule init
git submodule update


# MAKE SUBSTITUTIONS ##########################################################

sed -i "" \
    -e "s/TODO_AUTHOR_NAME/${TODO_AUTHOR_NAME}/g" \
    -e "s|TODO_AUTHORS_TITLE_PAGE|${TODO_AUTHORS_TITLE_PAGE}|g" \
    -e "s/TODO_AUTHOR_EMAIL/${TODO_AUTHOR_EMAIL}/g" \
    -e "s TODO_AUTHOR_WEB_SITE ${TODO_AUTHOR_WEB_SITE} g" \
    -e "s|TODO_COPYRIGHT_NOTICE|${TODO_COPYRIGHT_NOTICE}|g" \
    -e "s|TODO_DOCUMENT_DATE|${TODO_DOCUMENT_DATE}|g" \
    -e "s|TODO_INSTITUTE|${TODO_INSTITUTE}|g" \
    -e "s|TODO_DOCUMENT_SUBJECT|${TODO_DOCUMENT_SUBJECT}|g" \
    -e "s|TODO_DOCUMENT_KEYWORDS|${TODO_DOCUMENT_KEYWORDS}|g" \
    -e "s;TODO_DOCUMENT_TITLE;${TODO_DOCUMENT_TITLE};g" \
    -e "s;TODO_DOCUMENT_SUBTITLE;${TODO_DOCUMENT_SUBTITLE};g" \
    -e "s/TODO_DOCUMENT_FILE_BASE_NAME/${TODO_DOCUMENT_FILE_BASE_NAME}/g" \
    -e "s TODO_DOCUMENT_WEB_SITE_URL ${TODO_DOCUMENT_WEB_SITE_URL} g" \
    -e "s TODO_DOCUMENT_HTML_URL ${TODO_DOCUMENT_HTML_URL} g" \
    -e "s TODO_DOCUMENT_PDF_URL ${TODO_DOCUMENT_PDF_URL} g" \
    -e "s/TODO_DOCUMENT_GITHUB_ACCOUNT/${TODO_DOCUMENT_GITHUB_ACCOUNT}/g" \
    -e "s/TODO_DOCUMENT_GITHUB_REPOSITORY_NAME/${TODO_DOCUMENT_GITHUB_REPOSITORY_NAME}/g" \
    -e "s TODO_DOCUMENT_GITHUB_URL ${TODO_DOCUMENT_GITHUB_URL} g" \
    -e "s TODO_DOCUMENT_ISSUE_TRACKER_URL ${TODO_DOCUMENT_ISSUE_TRACKER_URL} g" \
    AUTHORS meta.make README.rst .gitignore meta.tex


# FIX TITLES UNDERLINE LENGTH IN RESTRUCTUREDTEXT FILES #######################

DOCUMENT_TITLE_UNDERLINE=$(echo "${TODO_DOCUMENT_TITLE}" | tr '[:print:]' '=')

sed -i "" \
    -e "s/^====$/${DOCUMENT_TITLE_UNDERLINE}/" \
    README.rst

