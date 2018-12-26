From: Souptick Joarder <jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 0/9] Use vm_insert_range
Date: Wed, 26 Dec 2018 19:11:57 +0530
Message-ID: <CAFqt6za-vq4GihKbSJjF1_=_xnWvBbpCQDf8iuhF0e8XJY4JVA@mail.gmail.com>
References: <20181224131841.GA22017@jordon-HP-15-Notebook-PC>
	<20181224152059.GA26090@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181224152059.GA26090-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: Michal Hocko <mhocko-IBi9RG/b67k@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-MM <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, linux1394-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, oleksandr_andrushchenko-uRwfk40T5oI@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, airlied-cv59FeDIM0c@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, pawel-FA/gS7QP4orQT0dZR+AlfA@public.gmane.org, Rik van Riel <riel-ebMLmSuQjDVBDgjK7y7TUQ@public.gmane.org>, rppt-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, Boris Ostrovsky <boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iamjoonsoo.kim-Hm3cg6mZ9cc@public.gmane.org, vbabka-AlSwsSmVLrQ@public.gmane.org, Juergen Gross <jgross-IBi9RG/b67k@public.gmane.org>, hjc-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xen-devel-GuqFBffKawuEi8DpZVb4nw@public.gmane.org, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, stefanr-MtYdepGKPcDRv0WFA/ZhaQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 24, 2018 at 8:51 PM Russell King - ARM Linux
<linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org> wrote:
>
> Having discussed with Matthew offlist, I think we've come to the
> following conclusion - there's a number of drivers that buggily
> ignore vm_pgoff.
>
> So, what I proposed is:
>
> static int __vm_insert_range(struct vm_struct *vma, struct page *pages,
>                              size_t num, unsigned long offset)
> {
>         unsigned long count = vma_pages(vma);
>         unsigned long uaddr = vma->vm_start;
>         int ret;
>
>         /* Fail if the user requested offset is beyond the end of the object */
>         if (offset > num)
>                 return -ENXIO;
>
>         /* Fail if the user requested size exceeds available object size */
>         if (count > num - offset)
>                 return -ENXIO;
>
>         /* Never exceed the number of pages that the user requested */
>         for (i = 0; i < count; i++) {
>                 ret = vm_insert_page(vma, uaddr, pages[offset + i]);
>                 if (ret < 0)
>                         return ret;
>                 uaddr += PAGE_SIZE;
>         }
>
>         return 0;
> }
>
> /*
>  * Maps an object consisting of `num' `pages', catering for the user's
>  * requested vm_pgoff
>  */
> int vm_insert_range(struct vm_struct *vma, struct page *pages, size_t num)
> {
>         return __vm_insert_range(vma, pages, num, vma->vm_pgoff);
> }
>
> /*
>  * Maps a set of pages, always starting at page[0]
>  */
> int vm_insert_range_buggy(struct vm_struct *vma, struct page *pages, size_t num)
> {
>         return __vm_insert_range(vma, pages, num, 0);
> }
>
> With this, drivers such as iommu/dma-iommu.c can be converted thusly:
>
>  int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma+)
>  {
> -       unsigned long uaddr = vma->vm_start;
> -       unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -       int ret = -ENXIO;
> -
> -       for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
> -               ret = vm_insert_page(vma, uaddr, pages[i]);
> -               if (ret)
> -                       break;
> -               uaddr += PAGE_SIZE;
> -       }
> -       return ret;
> +       return vm_insert_range(vma, pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
> }
>
> and drivers such as firewire/core-iso.c:
>
>  int fw_iso_buffer_map_vma(struct fw_iso_buffer *buffer,
>                           struct vm_area_struct *vma)
>  {
> -       unsigned long uaddr;
> -       int i, err;
> -
> -       uaddr = vma->vm_start;
> -       for (i = 0; i < buffer->page_count; i++) {
> -               err = vm_insert_page(vma, uaddr, buffer->pages[i]);
> -               if (err)
> -                       return err;
> -
> -               uaddr += PAGE_SIZE;
> -       }
> -
> -       return 0;
> +       return vm_insert_range_buggy(vma, buffer->pages, buffer->page_count);
> }
>
> and this gives us something to grep for to find these buggy drivers.
>
> Now, this may not look exactly equivalent, but if you look at
> fw_device_op_mmap(), buffer->page_count is basically vma_pages(vma)
> at this point, which means this should be equivalent.
>
> We _could_ then at a later date "fix" these drivers to behave according
> to the normal vm_pgoff offsetting simply by removing the _buggy suffix
> on the function name... and if that causes regressions, it gives us an
> easy way to revert (as long as vm_insert_range_buggy() remains
> available.)
>
> In the case of firewire/core-iso.c, it currently ignores the mmap offset
> entirely, so making the above suggested change would be tantamount to
> causing it to return -ENXIO for any non-zero mmap offset.
>
> IMHO, this approach is way simpler, and easier to get it correct at
> each call site, rather than the current approach which seems to be
> error-prone.

Thanks Russell.
I will drop this patch series and rework on it as suggested.
