From: Mike Rapoport <rppt-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Subject: Re: [PATCH 1/9] mm: Introduce new vm_insert_range API
Date: Mon, 19 Nov 2018 08:26:24 -0800
Message-ID: <20181119162623.GA13200@rapoport-lnx>
References: <20181115154530.GA27872@jordon-HP-15-Notebook-PC>
	<20181116182836.GB17088@rapoport-lnx>
	<CAFqt6zYp0j999WXw9Jus0oZMjADQQkPfso8btv6du6L9CE3PXA@mail.gmail.com>
	<20181117143742.GB7861@bombadil.infradead.org>
	<CAFqt6zbOWX5LUTWwoGDJsGdf+pTR6N1yTPVxyr1W3-6Fte39ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFqt6zbOWX5LUTWwoGDJsGdf+pTR6N1yTPVxyr1W3-6Fte39ww-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Souptick Joarder <jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Michal Hocko <mhocko-IBi9RG/b67k@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-MM <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, linux1394-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, oleksandr_andrushchenko-uRwfk40T5oI@public.gmane.org, Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, airlied-cv59FeDIM0c@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, pawel-FA/gS7QP4orQT0dZR+AlfA@public.gmane.org, Rik van Riel <riel-ebMLmSuQjDVBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, rppt-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, Boris Ostrovsky <boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iamjoonsoo.kim-Hm3cg6mZ9cc@public.gmane.org, vbabka-AlSwsSmVLrQ@public.gmane.org, Juergen Gross <jgross-IBi9RG/b67k@public.gmane.org>, hjc-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xen-devel-GuqFBffKawuEi8DpZVb4nw@public.gmane.org, Kyungmin
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 19, 2018 at 08:43:09PM +0530, Souptick Joarder wrote:
> Hi Mike,
> 
> On Sat, Nov 17, 2018 at 8:07 PM Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> wrote:
> >
> > On Sat, Nov 17, 2018 at 12:26:38PM +0530, Souptick Joarder wrote:
> > > On Fri, Nov 16, 2018 at 11:59 PM Mike Rapoport <rppt-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org> wrote:
> > > > > + * vm_insert_range - insert range of kernel pages into user vma
> > > > > + * @vma: user vma to map to
> > > > > + * @addr: target user address of this page
> > > > > + * @pages: pointer to array of source kernel pages
> > > > > + * @page_count: no. of pages need to insert into user vma
> > > > > + *
> > > > > + * This allows drivers to insert range of kernel pages they've allocated
> > > > > + * into a user vma. This is a generic function which drivers can use
> > > > > + * rather than using their own way of mapping range of kernel pages into
> > > > > + * user vma.
> > > >
> > > > Please add the return value and context descriptions.
> > > >
> > >
> > > Sure I will wait for some time to get additional review comments and
> > > add all of those requested changes in v2.
> >
> > You could send your proposed wording now which might remove the need
> > for a v3 if we end up arguing about the wording.
> 
> Does this description looks good ?
> 
> /**
>  * vm_insert_range - insert range of kernel pages into user vma
>  * @vma: user vma to map to
>  * @addr: target user address of this page
>  * @pages: pointer to array of source kernel pages
>  * @page_count: number of pages need to insert into user vma
>  *
>  * This allows drivers to insert range of kernel pages they've allocated
>  * into a user vma. This is a generic function which drivers can use
>  * rather than using their own way of mapping range of kernel pages into
>  * user vma.
>  *
>  * Context - Process context. Called by mmap handlers.

Context:

>  * Return - int error value

Return:

>  * 0                    - OK
>  * -EINVAL              - Invalid argument
>  * -ENOMEM              - No memory
>  * -EFAULT              - Bad address
>  * -EBUSY               - Device or resource busy

I don't think that elaborate description of error values is needed, just "0
on success and error code otherwise" would be sufficient.

>  */
> 

-- 
Sincerely yours,
Mike.
