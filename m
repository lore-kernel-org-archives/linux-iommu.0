From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: [PATCH 1/9] mm: Introduce new vm_insert_range API
Date: Mon, 19 Nov 2018 20:43:09 +0530
Message-ID: <CAFqt6zbOWX5LUTWwoGDJsGdf+pTR6N1yTPVxyr1W3-6Fte39ww@mail.gmail.com>
References: <20181115154530.GA27872@jordon-HP-15-Notebook-PC>
 <20181116182836.GB17088@rapoport-lnx> <CAFqt6zYp0j999WXw9Jus0oZMjADQQkPfso8btv6du6L9CE3PXA@mail.gmail.com>
 <20181117143742.GB7861@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181117143742.GB7861@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>, rppt@linux.ibm.com
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, vbabka@suse.cz, Rik van Riel <riel@surriel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, rppt@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, robin.murphy@arm.com, iamjoonsoo.kim@lge.com, treding@nvidia.com, Kees Cook <keescook@chromium.org>, Marek Szyprowski <m.szyprowski@samsung.com>, stefanr@s5r6.in-berlin.de, hjc@rock-chips.com, Heiko Stuebner <heiko@sntech.de>, airlied@linux.ie, oleksandr_andrushchenko@epam.com, joro@8bytes.org, pawel@osciak.com, Kyungmin Park <kyungmin.park@samsung.com>, mchehab@kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgr>
List-Id: iommu@lists.linux-foundation.org

Hi Mike,

On Sat, Nov 17, 2018 at 8:07 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, Nov 17, 2018 at 12:26:38PM +0530, Souptick Joarder wrote:
> > On Fri, Nov 16, 2018 at 11:59 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > > > + * vm_insert_range - insert range of kernel pages into user vma
> > > > + * @vma: user vma to map to
> > > > + * @addr: target user address of this page
> > > > + * @pages: pointer to array of source kernel pages
> > > > + * @page_count: no. of pages need to insert into user vma
> > > > + *
> > > > + * This allows drivers to insert range of kernel pages they've allocated
> > > > + * into a user vma. This is a generic function which drivers can use
> > > > + * rather than using their own way of mapping range of kernel pages into
> > > > + * user vma.
> > >
> > > Please add the return value and context descriptions.
> > >
> >
> > Sure I will wait for some time to get additional review comments and
> > add all of those requested changes in v2.
>
> You could send your proposed wording now which might remove the need
> for a v3 if we end up arguing about the wording.

Does this description looks good ?

/**
 * vm_insert_range - insert range of kernel pages into user vma
 * @vma: user vma to map to
 * @addr: target user address of this page
 * @pages: pointer to array of source kernel pages
 * @page_count: number of pages need to insert into user vma
 *
 * This allows drivers to insert range of kernel pages they've allocated
 * into a user vma. This is a generic function which drivers can use
 * rather than using their own way of mapping range of kernel pages into
 * user vma.
 *
 * Context - Process context. Called by mmap handlers.
 * Return - int error value
 * 0                    - OK
 * -EINVAL              - Invalid argument
 * -ENOMEM              - No memory
 * -EFAULT              - Bad address
 * -EBUSY               - Device or resource busy
 */
