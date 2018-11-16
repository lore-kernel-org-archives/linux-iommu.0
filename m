From: Slavomir Kaslev <kaslevs@vmware.com>
Subject: Re: [PATCH 1/9] mm: Introduce new vm_insert_range API
Date: Fri, 16 Nov 2018 17:48:09 +0000
Message-ID: <CAE0o1NuTR1x2u9aJVo3-u9yPAESQqLRZNrjxDJSugTF6qo+pbA@mail.gmail.com>
References: <20181115154530.GA27872@jordon-HP-15-Notebook-PC>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181115154530.GA27872@jordon-HP-15-Notebook-PC>
Content-Language: en-US
Content-ID: <73CE58359D441447BA044FFA2115AE6B@namprd05.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "jrdr.linux@gmail.com" <jrdr.linux@gmail.com>
Cc: "mhocko@suse.com" <mhocko@suse.com>, "heiko@sntech.de" <heiko@sntech.de>, "peterz@infradead.org" <peterz@infradead.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux1394-devel@lists.sourceforge.net" <linux1394-devel@lists.sourceforge.net>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, "oleksandr_andrushchenko@epam.com" <oleksandr_andrushchenko@epam.com>, "joro@8bytes.org" <joro@8bytes.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "willy@infradead.org" <willy@infradead.org>, "airlied@linux.ie" <airlied@linux.ie>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, tredi
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 15, 2018 at 5:42 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Previouly drivers have their own way of mapping range of
> kernel pages/memory into user vma and this was done by
> invoking vm_insert_page() within a loop.
>
> As this pattern is common across different drivers, it can
> be generalized by creating a new function and use it across
> the drivers.
>
> vm_insert_range is the new API which will be used to map a
> range of kernel memory/pages to user vma.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <willy@infradead.org>
> ---
>  include/linux/mm_types.h |  3 +++
>  mm/memory.c              | 28 ++++++++++++++++++++++++++++
>  mm/nommu.c               |  7 +++++++
>  3 files changed, 38 insertions(+)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5ed8f62..15ae24f 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -523,6 +523,9 @@ extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
>  extern void tlb_finish_mmu(struct mmu_gather *tlb,
>                                 unsigned long start, unsigned long end);
>
> +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> +                       struct page **pages, unsigned long page_count);
> +
>  static inline void init_tlb_flush_pending(struct mm_struct *mm)
>  {
>         atomic_set(&mm->tlb_flush_pending, 0);
> diff --git a/mm/memory.c b/mm/memory.c
> index 15c417e..da904ed 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1478,6 +1478,34 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
>  }
>
>  /**
> + * vm_insert_range - insert range of kernel pages into user vma
> + * @vma: user vma to map to
> + * @addr: target user address of this page
> + * @pages: pointer to array of source kernel pages
> + * @page_count: no. of pages need to insert into user vma
> + *
> + * This allows drivers to insert range of kernel pages they've allocated
> + * into a user vma. This is a generic function which drivers can use
> + * rather than using their own way of mapping range of kernel pages into
> + * user vma.
> + */
> +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> +                       struct page **pages, unsigned long page_count)
> +{
> +       unsigned long uaddr = addr;
> +       int ret = 0, i;
> +
> +       for (i = 0; i < page_count; i++) {
> +               ret = vm_insert_page(vma, uaddr, pages[i]);
> +               if (ret < 0)
> +                       return ret;
> +               uaddr += PAGE_SIZE;
> +       }
> +
> +       return ret;
> +}

+ EXPORT_SYMBOL(vm_insert_range);

> +
> +/**
>   * vm_insert_page - insert single page into user vma
>   * @vma: user vma to map to
>   * @addr: target user address of this page
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 749276b..d6ef5c7 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -473,6 +473,13 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
>  }
>  EXPORT_SYMBOL(vm_insert_page);
>
> +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> +                       struct page **pages, unsigned long page_count)
> +{
> +       return -EINVAL;
> +}
> +EXPORT_SYMBOL(vm_insert_range);
> +
>  /*
>   *  sys_brk() for the most part doesn't need the global kernel
>   *  lock, except when an application is doing something nasty
> --
> 1.9.1
>
