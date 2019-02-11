From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: [PATCHv2 1/9] mm: Introduce new vm_insert_range and
 vm_insert_range_buggy API
Date: Mon, 11 Feb 2019 22:36:15 +0530
Message-ID: <CAFqt6zYGSn1dA8tdiH16Mq0bzkx5DmpUo+2RUZ0nTPm+nvZS7Q@mail.gmail.com>
References: <20190131030812.GA2174@jordon-HP-15-Notebook-PC>
 <20190131083842.GE28876@rapoport-lnx> <CAFqt6za9xA_8OKiaaHXcO9go+RtPdjLY5Bz_fgQL+DZbermNhA@mail.gmail.com>
 <20190207164739.GX21860@bombadil.infradead.org> <CAFqt6zawBP5Yyy7nfoKz_6ugw8e4MVopvBaeKvaKoXcS-_oSNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFqt6zawBP5Yyy7nfoKz_6ugw8e4MVopvBaeKvaKoXcS-_oSNg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, vbabka@suse.cz, Rik van Riel <riel@surriel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, rppt@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, robin.murphy@arm.com, iamjoonsoo.kim@lge.com, treding@nvidia.com, Kees Cook <keescook@chromium.org>, Marek Szyprowski <m.szyprowski@samsung.com>, stefanr@s5r6.in-berlin.de, hjc@rock-chips.com, Heiko Stuebner <heiko@sntech.de>, airlied@linux.ie, oleksandr_andrushchenko@epam.com, joro@8bytes.org, pawel@osciak.com, Kyungmin Park <kyungmin.park@samsung.com>, mchehab@kernel.org, Boris Ostrovsky <boris.ostro>
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 8, 2019 at 10:52 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Thu, Feb 7, 2019 at 10:17 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Feb 07, 2019 at 09:19:47PM +0530, Souptick Joarder wrote:
> > > Just thought to take opinion for documentation before placing it in v3.
> > > Does it looks fine ?
> > >
> > > +/**
> > > + * __vm_insert_range - insert range of kernel pages into user vma
> > > + * @vma: user vma to map to
> > > + * @pages: pointer to array of source kernel pages
> > > + * @num: number of pages in page array
> > > + * @offset: user's requested vm_pgoff
> > > + *
> > > + * This allow drivers to insert range of kernel pages into a user vma.
> > > + *
> > > + * Return: 0 on success and error code otherwise.
> > > + */
> > > +static int __vm_insert_range(struct vm_area_struct *vma, struct page **pages,
> > > +                               unsigned long num, unsigned long offset)
> >
> > For static functions, I prefer to leave off the second '*', ie make it
> > formatted like a docbook comment, but not be processed like a docbook
> > comment.  That avoids cluttering the html with descriptions of internal
> > functions that people can't actually call.
> >
> > > +/**
> > > + * vm_insert_range - insert range of kernel pages starts with non zero offset
> > > + * @vma: user vma to map to
> > > + * @pages: pointer to array of source kernel pages
> > > + * @num: number of pages in page array
> > > + *
> > > + * Maps an object consisting of `num' `pages', catering for the user's
> >
> > Rather than using `num', you should use @num.
> >
> > > + * requested vm_pgoff
> > > + *
> > > + * If we fail to insert any page into the vma, the function will return
> > > + * immediately leaving any previously inserted pages present.  Callers
> > > + * from the mmap handler may immediately return the error as their caller
> > > + * will destroy the vma, removing any successfully inserted pages. Other
> > > + * callers should make their own arrangements for calling unmap_region().
> > > + *
> > > + * Context: Process context. Called by mmap handlers.
> > > + * Return: 0 on success and error code otherwise.
> > > + */
> > > +int vm_insert_range(struct vm_area_struct *vma, struct page **pages,
> > > +                               unsigned long num)
> > >
> > >
> > > +/**
> > > + * vm_insert_range_buggy - insert range of kernel pages starts with zero offset
> > > + * @vma: user vma to map to
> > > + * @pages: pointer to array of source kernel pages
> > > + * @num: number of pages in page array
> > > + *
> > > + * Similar to vm_insert_range(), except that it explicitly sets @vm_pgoff to
> >
> > But vm_pgoff isn't a parameter, so it's misleading to format it as such.
> >
> > > + * 0. This function is intended for the drivers that did not consider
> > > + * @vm_pgoff.
> > > + *
> > > + * Context: Process context. Called by mmap handlers.
> > > + * Return: 0 on success and error code otherwise.
> > > + */
> > > +int vm_insert_range_buggy(struct vm_area_struct *vma, struct page **pages,
> > > +                               unsigned long num)
> >
> > I don't think we should call it 'buggy'.  'zero' would make more sense
> > as a suffix.
>
> suffix can be *zero or zero_offset* whichever suits better.
>
> >
> > Given how this interface has evolved, I'm no longer sure than
> > 'vm_insert_range' makes sense as the name for it.  Is it perhaps
> > 'vm_map_object' or 'vm_map_pages'?
> >
>
> I prefer vm_map_pages. Considering it, both the interface name can be changed
> to *vm_insert_range -> vm_map_pages* and *vm_insert_range_buggy ->
> vm_map_pages_{zero/zero_offset}.
>
> As this is only change in interface name and rest of code remain same
> shall I post it in v3 ( with additional change log mentioned about interface
> name changed) ?
>
> or,
>
> It will be a new patch series ( with carry forward all the Reviewed-by
> / Tested-by on
> vm_insert_range/ vm_insert_range_buggy ) ?

Any suggestion on this minor query ?
