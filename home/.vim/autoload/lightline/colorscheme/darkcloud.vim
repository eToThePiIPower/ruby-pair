let s:base0 = '#262626'
let s:base1 = '#303030'
let s:base2 = '#767676'
let s:base3 = '#949494'
let s:base4 = '#b2b2b2'
let s:base5 = '#c6c6c6'
let s:base6 = '#eaeaea'

let s:rcol = '#d75f5f'
let s:ycol = '#ffd787'
let s:bcol = '#87d7ff'

let s:p = {'normal':{},'inactive':{},'insert':{},'replace':{},'visual':{},'tabline':{}}

let s:p.normal.left = [[ s:bcol,s:base1 ],[ s:base6,s:base0 ]]
let s:p.normal.right = [[ s:base4,s:base1 ],[ s:base6,s:base0 ]]
let s:p.inactive.left =  [[ s:base6,s:base0 ],[ s:base4,s:base1 ]]
let s:p.inactive.right = [[ s:base4,s:base1 ],[ s:base6,s:base0 ]]
let s:p.insert.left = [[ s:rcol,s:base1 ],[ s:base6,s:base0 ]]
let s:p.replace.left = [[ s:base1,s:rcol ],[ s:base6,s:base0 ]]
let s:p.visual.left = [[ s:ycol,s:base1 ],[ s:base6,s:base0 ]]

let s:p.normal.middle = [[ s:base4,s:base1 ]]
let s:p.inactive.abmiddle = [[ s:base3,s:base1 ]]
let s:p.tabline.left = [[ s:base5,s:base1 ]]
let s:p.tabline.tabsel = [[ s:bcol,s:base0 ]]
let s:p.tabline.middle = [[ s:base0,s:base4 ]]
let s:p.tabline.right = copy(s:p.normal.right)
let s:p.normal.error = [[ s:rcol,s:base1 ]]
let s:p.normal.warning = [[ s:ycol,s:base1 ]]

let g:lightline#colorscheme#darkcloud#palette = lightline#colorscheme#fill(s:p)
