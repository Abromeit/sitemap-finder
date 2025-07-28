#!/usr/bin/env bash

#
# Abro's Sitemap Finder
# discover sitemap.xml files of a website
#
# Usage:
# ./sitemap-finder.sh 'https://www.example.com/'
#


set -o nounset
set -o errtrace
set -o pipefail


readonly QUIT_ON_FIRST_RESULT="0"

declare -a ARR_FILETYPES=(
    'xml'
    'xml.gz'
    'txt'
)

declare -a ARR_FILENAMES=(
    '1'
    '1-1'
    '01'
    '001'
    '0001'
    '2015'
    '2016'
    '2017'
    '2018'
    '2019'
    '2020'
    '2021'
    '2022'
    '2023'
    '2024'
    '2025'
    'index'
    'index-files'
    's_1'
    's_01'
    's_001'
    's_0001'
    's-1'
    's-01'
    's-001'
    's-0001'
    's_1-1'
    's1'
    's01'
    's001'
    's0001'
    's1-1'
    'site_1'
    'site_01'
    'site_001'
    'site_0001'
    'site-1'
    'site-01'
    'site-001'
    'site-0001'
    'site-1-1'
    'site'
    'site1'
    'site01'
    'site001'
    'site0001'
    'sites'
    'siteindex'
    'siteindex1'
    'siteindex01'
    'siteindex001'
    'siteindex0001'
    'site-map'
    'sitemap'
    'sitemapmain'
    'sitemapMain'
    'sitemap.all'
    'sitemap.index'
    'sitemap.website'
    'sitemap.pages'
    'sitemap.default'
    'sitemap.main'
    'sitemap.ssl'
    'sitemap.root'
    'sitemap.de'
    'sitemap.en'
    'sitemap.1'
    'sitemap.01'
    'sitemap.001'
    'sitemap.0001'
    'sitemap_1'
    'sitemap_01'
    'sitemap_001'
    'sitemap_0001'
    'sitemap_1_1'
    'sitemap_01_01'
    'sitemap_default'
    'sitemap_en'
    'sitemap_de'
    'sitemap_index_de'
    'sitemap_index_en'
    'sitemap_index'
    'sitemap_sites'
    'sitemap_ssl'
    'sitemap-1'
    'sitemap-1-1'
    'sitemap-01'
    'sitemap-001'
    'sitemap-0001'
    'sitemapindex'
    'sitemap-index'
    'sitemap-index-1'
    'sitemap-index-de'
    'sitemap-index-en'
    'sitemap-default'
    'sitemap-root'
    'sitemap-root-1'
    'sitemap-main'
    'sitemap-pages'
    'sitemap-posts'
    'sitemap-sections'
    'sitemap-sites'
    'sitemap-ssl'
    'sitemap-de'
    'sitemap-de-de'
    'sitemap-de_de'
    'sitemap-deu'
    'sitemap-en'
    'sitemap-en-us'
    'sitemap-en_us'
    'sitemap-eng'
    'sitemap-web'
    'sitemap-website'
    'sitemap-www'
    'sitemap-secure'
    'sitemap-secure-www'
    'secure-sitemap'
    'sitemaps'
    'sitemaps-1-sitemap'
    'Sitemap'
    'SiteMap'
    'sitemap1'
    'sitemap2'
    'sitemap01'
    'sitemap001'
    'sitemap0001'
    'sitemap-files'
    'sitemap-items'
    'sitemap-items-1'
    'sitemappages'
    'sitemapproducts'
    'default'
    'standard_sitemap'
    'items'
    'files'
    'sm'
    'google-sitemap'
    'google-sitemap-index'
    'google-sitemap-1'
    'google_sitemap'
    'googlesitemap'
    'gsitemap'
    'GSiteMap'
    'xml-sitemap'
    'main-sitemap'
    'news-sitemap'
    'newssitemap'
    'googleNewsList'
    'gNewsSiteMap'
    'googlenews'
    'google-news-sitemap'
    'googlenews-sitemap'
    'sitemap-google-news'
    'sitemap-googlenews'
    'sitemap-news'
    'sitemap_news'
    'sitemapnews'
    'sitemapNews'
    'sitemap_articles'
    'sitemap_static'
    'sitemap-global'
    'sitemap_global'
    'List'
    'list'
    'website'
    'web'
    'main'
    'map'
    'maps'
    'global'
    'geositemap'
    'content'
    'page'
    'pages'
    'page-sitemap'
    'root-sitemap'
    'all'
    'de'
    'en'
    'map/1'
    'map/index'
    'map/global'
    'map/default'
    'map/s_1'
    'map/s-1'
    'map/s1'
    'map/site_1'
    'map/site-1'
    'map/site'
    'map/siteindex'
    'map/site1'
    'map/sitemap_1'
    'map/sitemap_index_de'
    'map/sitemap_index'
    'map/sitemap_sites'
    'map/sitemap-1'
    'map/sitemap-index'
    'map/sitemap-sites'
    'map/sitemap'
    'map/sitemap1'
    'map/sitemap01'
    'map/sitemap001'
    'map/sitemap0001'
    'map/sm'
    'map/main'
    'sitemap/1'
    'sitemap/01'
    'sitemap/001'
    'sitemap/0001'
    'sitemap/index'
    'sitemap/index-files'
    'sitemap/global'
    'sitemap/s_1'
    'sitemap/s-1'
    'sitemap/s1'
    'sitemap/site_1'
    'sitemap/site-1'
    'sitemap/site'
    'sitemap/siteindex'
    'sitemap/site1'
    'sitemap/sitemap'
    'sitemap/sitemap_1'
    'sitemap/sitemap_01'
    'sitemap/sitemap_001'
    'sitemap/sitemap_0001'
    'sitemap/sitemap_index_de'
    'sitemap/sitemap_index'
    'sitemap/sitemap_sites'
    'sitemap/sitemap-1'
    'sitemap/sitemap-01'
    'sitemap/sitemap-001'
    'sitemap/sitemap-0001'
    'sitemap/sitemap-index'
    'sitemap/sitemap-sections'
    'sitemap/sitemap-sites'
    'sitemap/sitemap-main'
    'sitemap/sitemap-de'
    'sitemap/sitemap_de'
    'sitemap/sitemap-en'
    'sitemap/sitemap_en'
    'sitemap/sitemap1'
    'sitemap/sitemap01'
    'sitemap/sitemap001'
    'sitemap/sitemap0001'
    'sitemap/map'
    'sitemap/map1'
    'sitemap/map01'
    'sitemap/map001'
    'sitemap/map0001'
    'sitemap/main'
    'sitemap/sitemap_global'
    'sitemap/sitemapmain'
    'sitemap/default'
    'sitemap/full'
    'sitemap/items'
    'sitemap/root'
    'sitemap/sm'
    'sitemap/web'
    'sitemap/pages'
    'sitemap/page-a'
    'sitemap/files'
    'sitemap/file-a'
    'sitemap/de/sitemap'
    'sitemap/en/sitemap'
    'sitemaps/1'
    'sitemaps/01'
    'sitemaps/001'
    'sitemaps/0001'
    'sitemaps/index'
    'sitemaps/pages'
    'sitemaps/default'
    'sitemaps/main'
    'sitemaps/s_1'
    'sitemaps/s-1'
    'sitemaps/s1'
    'sitemaps/site_1'
    'sitemaps/site-1'
    'sitemaps/site'
    'sitemaps/siteindex'
    'sitemaps/site1'
    'sitemaps/sitemap_1'
    'sitemaps/sitemap_01'
    'sitemaps/sitemap_001'
    'sitemaps/sitemap_0001'
    'sitemaps/sitemap_1_1'
    'sitemaps/sitemap_index_de'
    'sitemaps/sitemap_index'
    'sitemaps/sitemap_sites'
    'sitemaps/sitemap-1'
    'sitemaps/sitemap-01'
    'sitemaps/sitemap-001'
    'sitemaps/sitemap-0001'
    'sitemaps/sitemap-index'
    'sitemaps/sitemap-sites'
    'sitemaps/sitemap-main'
    'sitemaps/sitemap'
    'sitemaps/sitemap1'
    'sitemaps/sitemap01'
    'sitemaps/sitemap001'
    'sitemaps/sitemap0001'
    'sitemaps/sitemappages'
    'sitemaps/sm'
    'sitemaps2/index'
    'sitemaps-2/index'
    'sitemapxmllist/1'
    'sitemapxmllist/index'
    'sitemapxmllist/s_1'
    'sitemapxmllist/s-1'
    'sitemapxmllist/s1'
    'sitemapxmllist/site_1'
    'sitemapxmllist/site-1'
    'sitemapxmllist/site'
    'sitemapxmllist/siteindex'
    'sitemapxmllist/site1'
    'sitemapxmllist/sitemap_1'
    'sitemapxmllist/sitemap_index_de'
    'sitemapxmllist/sitemap_index'
    'sitemapxmllist/sitemap_sites'
    'sitemapxmllist/sitemap-1'
    'sitemapxmllist/sitemap-index'
    'sitemapxmllist/sitemap-sites'
    'sitemapxmllist/Sitemap'
    'sitemapxmllist/sitemap'
    'sitemapxmllist/sitemap1'
    'sitemapxmllist/sitemap01'
    'sitemapxmllist/sitemap001'
    'sitemapxmllist/sitemap0001'
    'sitemapxmllist/sm'
    'sitemapxmllist-var/index'
    'sm/1'
    'sm/index'
    'sm/s_1'
    'sm/s-1'
    'sm/s1'
    'sm/site_1'
    'sm/site-1'
    'sm/site'
    'sm/siteindex'
    'sm/site1'
    'sm/sitemap_1'
    'sm/sitemap_index_de'
    'sm/sitemap_index'
    'sm/sitemap_sites'
    'sm/sitemap-1'
    'sm/sitemap-index'
    'sm/sitemap-sites'
    'sm/Sitemap'
    'sm/sitemap'
    'sm/sitemap1'
    'sm/sitemap01'
    'sm/sitemap001'
    'sm/sitemap0001'
    'sm/sm'
    'xml/1'
    'xml/index'
    'xml/s_1'
    'xml/s-1'
    'xml/s1'
    'xml/site_1'
    'xml/site-1'
    'xml/site'
    'xml/siteindex'
    'xml/site1'
    'xml/sitemap_1'
    'xml/sitemap_index_de'
    'xml/sitemap_index'
    'xml/sitemap_sites'
    'xml/sitemap-1'
    'xml/sitemap-index'
    'xml/sitemap-sites'
    'xml/sitemap-pages'
    'xml/sitemappages'
    'xml/Sitemap'
    'xml/sitemap'
    'xml/sitemap1'
    'xml/sitemap01'
    'xml/sitemap001'
    'xml/sitemap0001'
    'xml/sm'
    'xml/main'
    'xml/sitemapmain.xml'
    'xml/SitemapMain.xml'
    'files/sitemap'
    'files/sitemap-index'
    'files/sitemap_index'
    'files/sitemap/sitemap'
    'files/sitemap/sitemap-index'
    'files/sitemap/sitemap_index'
    'files/sitemap/index'
    'files/xml/sitemap-index'
    'files/xml/sitemap'
    'files/xml/sitemap.pages'
    'files/others/sitemap'
    'sites/default/files/sitemap'
    'sites/default/files/sitemap/1'
    'sites/default/files/sitemap/sitemap'
    'sites/default/files/sitemap/sitemap_1'
    'sites/default/files/sitemaps'
    'sites/default/files/sitemaps/sitemap'
    'sites/default/files/sitemaps/sitemapindex'
    'sites/default/files/sitemaps/sitemap-index'
    'sites/default/files/sitemaps/sitemap_index'
    'sites/default/files/sitemaps/sitemapmonthly-1'
    'de/main'
    'de/sitemap-de'
    'de/sitemap_index'
    'de/sitemap'
    'de/sitemaps-1-sitemap'
    'de/googlesitemap'
    'de-de/main'
    'de-de/sitemap'
    'en/main'
    'en/sitemap-en'
    'en/sitemap_index'
    'en/sitemap'
    'en/sitemaps-1-sitemap'
    'en/googlesitemap'
    'en-us/main'
    'en-us/sitemap'
    'share/sitemap'
    'share/sitemap-de'
    'share/sitemap-en'
    'public/sitemap'
    'public/sitemap-main'
    'public/sitemap-de'
    'public/sitemap-en'
    'public/sitemap-1'
    'public/sitemap-01'
    'public/sitemap-001'
    'public/sitemap-0001'
    'public/sitemap/index'
    'public/sitemap/de/siteindex'
    'public/sitemap/en/siteindex'
    'public/sitemap-xml/sitemap'
    'pub/sitemap'
    'pub/sitemap-1'
    'pub/sitemap-01'
    'pub/sitemap-001'
    'pub/sitemap-0001'
    'pub/sitemap-1-1'
    'pub/sitemap_de'
    'pub/sitemap_en'
    'pub/sitemap/sitemap'
    'pub/sitemaps/sitemap'
    'pub/media/sitemap'
    'pub/media/sitemap-1-1'
    'pub/media/sitemap/sitemap'
    'items/sitemap'
    'myinterfaces/cms/googlesitemap-overview'
    'full'
    'rss'
    'rss2'
    'atom'
    'feed'
)


readonly SET_COLOR_BOLD=$(tput bold)
readonly SET_COLOR_RED=$(tput setaf 1)
readonly SET_COLOR_GREEN=$(tput setaf 2)
readonly SET_COLOR_YELLOW=$(tput setaf 3)
readonly SET_COLOR_GREY=$(tput setaf 243)
readonly SET_COLOR_DEFAULT=$(tput sgr0)

# UA was introduced by some website, that returned 200 statuscodes for nonexistent sitemap files, for curl's own UA.
readonly CURL_USER_AGENT='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0'
readonly tstamp_start=$(date +'%s')
declare -i requests_done=0

# we don't normalize much here. just lowercase + remove trailing slashes 'n' stuff.
readonly starturl=$(echo "${1:-}" | tr '[:upper:]' '[:lower:]' | grep -o -P '^https?\://[^/]+')


function br() {

    echo ''

}


function str-repeat() {

    local string_to_repeat="${1}"
    local number_of_repetitions="${2}"

    printf "%*s" "${number_of_repetitions}" "" | tr ' ' "${string_to_repeat}"
    br

}


function maybe-exit() {

    if [[ "${QUIT_ON_FIRST_RESULT}" == "1" ]]; then
        exit 0
    fi

}


if [[ -z "${starturl}" ]]; then
    br
    echo "- ${SET_COLOR_RED}ERROR${SET_COLOR_DEFAULT}: no valid url given"
    br
    exit 1
fi


br
str-repeat '=' '47'
printf '= %-43s =\n' 'sitemap finder started for:'
printf '= %-43s =\n' ' '
printf '= %s%-43s%s =\n' "${SET_COLOR_BOLD}" "${starturl}" "${SET_COLOR_DEFAULT}"
printf '= %-43s =\n' ' '
printf '= %-45s\n' "$(date +'%Y-%m-%d %H:%M:%S')h" | perl -pe 's/(?<!\S)[ ](?!\S)/=/g'
br
br


echo "- checking robots.txt..."

url="${starturl}/robots.txt"
res=$(curl -G --location --silent --fail --stderr /dev/null --max-time 10 --insecure --user-agent "${CURL_USER_AGENT}" --url "${url}" | grep -i -P '^\s*Sitemap\s*\:' | cut -f 2- -d':' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
requests_done=$((requests_done + 1))

if [[ -n "${res}" ]]; then
    # the following sed command indents the 2nd+ lines,
    # for robots.txt files that contain multiple sitemaps.
    echo "- ${SET_COLOR_GREEN}FOUND${SET_COLOR_DEFAULT}: ${SET_COLOR_GREY}${res}${SET_COLOR_DEFAULT}" | sed -e '2,$s/^/         /'
    br
    maybe-exit
else
    echo "- no hint in robots.txt"
    br
fi


echo "- starting try & error run..."

for filetype in "${ARR_FILETYPES[@]}"
do

    echo "- testing *.${filetype}..."

    for filename in "${ARR_FILENAMES[@]}"
    do

        url="${starturl}/${filename}.${filetype}"
        res=$(curl -I --silent --fail --output /dev/null --stderr /dev/null --max-time 5 --insecure --write-out "%{http_code}\\n%{content_type}" --user-agent "${CURL_USER_AGENT}" --url "${url}")
        requests_done=$((requests_done + 1))

        res_status_code=$(echo "${res}" | awk 'NR==1')
        res_content_type=$(echo "${res}" | awk 'NR==2')

        # print all urls with a http status code of '2xx'
        if [[ "${res_status_code:0:1}" == "2" ]]; then
            case "${res_content_type}" in 
                *"xml"*   | \
                *"gzip"*  | \
                *"plain"* )
                    echo "- Found URL with code ${SET_COLOR_GREEN}${res_status_code}${SET_COLOR_DEFAULT} and type ${SET_COLOR_GREEN}${res_content_type}${SET_COLOR_DEFAULT}: ${SET_COLOR_GREY}${url}${SET_COLOR_DEFAULT}"
                    maybe-exit
                    ;;
            esac
        fi

    done

done


runtime_sec=$(bc <<< "$(date +'%s') - ${tstamp_start}")
runtime_min=$(bc <<< "scale=2; ${runtime_sec} / 60")
requests_per_sec=$(bc <<< "scale=2; ${requests_done} / ${runtime_sec}")


br
br
printf '= %-45s\n' "$(date +'%Y-%m-%d %H:%M:%S')h" | perl -pe 's/(?<!\S)[ ](?!\S)/=/g'
printf '= %-43s =\n' ' '
printf '= %-43s =\n' 'done.'
printf '= %-43s =\n' ' '
printf '= %-43s =\n' "script runtime:       ${runtime_sec}sec. ~= ${runtime_min}min."
printf '= %-43s =\n' "sum of http-requests: ${requests_done} "
printf '= %-43s =\n' "avg. requests / sec:  ${requests_per_sec} "
str-repeat '=' '47'
br
