From: Souptick Joarder <jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/9] mm: Introduce new vm_insert_range API
Date: Sat, 8 Dec 2018 03:18:49 +0530
Message-ID: <CAFqt6zbuT3mhLCSas=EO38NW+M4KAARKeBpMqDz6xwkVbw=FGA@mail.gmail.com>
References: <20181206183945.GA20932@jordon-HP-15-Notebook-PC>
	<53bbc095-c9f5-5d6a-6e50-6e060d17eb68@arm.com>
	<20181207171116.GA29923@bombadil.infradead.org>
	<CAFqt6zYCWOK-uS85GqCzcgT=+YKn1nBrRPq+M9y6eJjmXEKH+g@mail.gmail.com>
	<67495f8f-2092-e42d-321e-5216c346513f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <67495f8f-2092-e42d-321e-5216c346513f-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: robin.murphy-5wv7dgnIgG8@public.gmane.org
Cc: Michal Hocko <mhocko-IBi9RG/b67k@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-MM <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, linux1394-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, oleksandr_andrushchenko-uRwfk40T5oI@public.gmane.org, Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, airlied-cv59FeDIM0c@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, pawel-FA/gS7QP4orQT0dZR+AlfA@public.gmane.org, Rik van Riel <riel-ebMLmSuQjDVBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, rppt-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, Boris Ostrovsky <boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iamjoonsoo.kim-Hm3cg6mZ9cc@public.gmane.org, vbabka-AlSwsSmVLrQ@public.gmane.org, Juergen Gross <jgross-IBi9RG/b67k@public.gmane.org>, hjc-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xen-devel-GuqFBffKawuEi8DpZVb4nw@public.gmane.org, Kyungmin
List-Id: iommu@lists.linux-foundation.org

On Sat, Dec 8, 2018 at 2:40 AM Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>
> On 2018-12-07 7:28 pm, Souptick Joarder wrote:
> > On Fri, Dec 7, 2018 at 10:41 PM Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> wrote:
> >>
> >> On Fri, Dec 07, 2018 at 03:34:56PM +0000, Robin Murphy wrote:
> >>>> +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> >>>> +                   struct page **pages, unsigned long page_count)
> >>>> +{
> >>>> +   unsigned long uaddr = addr;
> >>>> +   int ret = 0, i;
> >>>
> >>> Some of the sites being replaced were effectively ensuring that vma and
> >>> pages were mutually compatible as an initial condition - would it be worth
> >>> adding something here for robustness, e.g.:
> >>>
> >>> +     if (page_count != vma_pages(vma))
> >>> +             return -ENXIO;
> >>
> >> I think we want to allow this to be used to populate part of a VMA.
> >> So perhaps:
> >>
> >>          if (page_count > vma_pages(vma))
> >>                  return -ENXIO;
> >
> > Ok, This can be added.
> >
> > I think Patch [2/9] is the only leftover place where this
> > check could be removed.
>
> Right, 9/9 could also have relied on my stricter check here, but since
> it's really testing whether it actually managed to allocate vma_pages()
> worth of pages earlier, Matthew's more lenient version won't help for
> that one.


(Why privcmd_buf_mmap() doesn't clean up and return an error
> as soon as that allocation loop fails, without taking the mutex under
> which it still does a bunch more pointless work to only undo it again,
> is a mind-boggling mystery, but that's not our problem here...)

I think some clean up can be done here in a separate patch.
