import { Controller } from "@hotwired/stimulus"
import $ from 'jquery'

export default class extends Controller {
    static targets = ['sidebarList']

    connect() {
        let menus = document.querySelectorAll('#sidebar-list>li');
        for (let menu of menus) {
            if (menu.lastElementChild.childElementCount === 0) {
                menu.lastElementChild.innerHTML = `<li>
                                             <a href="javascript:void(0)">
                                               <span class="text-secondary">您无浏览权限</span>
                                             </a>
                                           </li>`;
            }
        }
    }

    toggle(e){
        let toggleButton = $(e.target).closest('button');
        if (!toggleButton.length) return;
        let buttonClasses = toggleButton[0].classList;
        if(buttonClasses && $.inArray('sidebar-toggle', buttonClasses) !== -1) {
            toggleButton.next().toggleClass('d-none');
        }
    }
}
