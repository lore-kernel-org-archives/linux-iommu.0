From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: [RESEND PATCH v4 0/9] mm: Use vm_map_pages() and
 vm_map_pages_zero() API
Date: Tue, 9 Apr 2019 11:47:37 +0530
Message-ID: <CAFqt6zbDk7OAdk-WXG50Frppny0DOpdwR1vnTS7pCpjf66j3aQ@mail.gmail.com>
References: <cover.1552921225.git.jrdr.linux@gmail.com> <CAFqt6zaV5zcc495BBk1Wi7p+zOF8y=P5KRfKkvwY=stagUFKWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFqt6zaV5zcc495BBk1Wi7p+zOF8y=P5KRfKkvwY=stagUFKWQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Vlastimil Babka <vbabka@suse.cz>, Rik van Riel <riel@surriel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, rppt@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, robin.murphy@arm.com, iamjoonsoo.kim@lge.com, treding@nvidia.com, Kees Cook <keescook@chromium.org>, Marek Szyprowski <m.szyprowski@samsung.com>, stefanr@s5r6.in-berlin.de, hjc@rock-chips.com, Heiko Stuebner <heiko@sntech.de>, airlied@linux.ie, oleksandr_andrushchenko@epam.com, joro@8bytes.org, pawel@osciak.com, Kyungmin Park <kyungmin.park@samsung.com>, mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arm-kernel@lists.infradead.org, linux1394-devel@lists.sourceforge.net, dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, xen-devel@lists.xen.org, iommu@lists.linux-foundation.org, linux-media@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Andrew/ Michal,

On Mon, Apr 1, 2019 at 10:56 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Hi Andrew,
>
> On Tue, Mar 19, 2019 at 7:47 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > Previouly drivers have their own way of mapping range of
> > kernel pages/memory into user vma and this was done by
> > invoking vm_insert_page() within a loop.
> >
> > As this pattern is common across different drivers, it can
> > be generalized by creating new functions and use it across
> > the drivers.
> >
> > vm_map_pages() is the API which could be used to map
> > kernel memory/pages in drivers which has considered vm_pgoff.
> >
> > vm_map_pages_zero() is the API which could be used to map
> > range of kernel memory/pages in drivers which has not considered
> > vm_pgoff. vm_pgoff is passed default as 0 for those drivers.
> >
> > We _could_ then at a later "fix" these drivers which are using
> > vm_map_pages_zero() to behave according to the normal vm_pgoff
> > offsetting simply by removing the _zero suffix on the function
> > name and if that causes regressions, it gives us an easy way to revert.
> >
> > Tested on Rockchip hardware and display is working fine, including talking
> > to Lima via prime.
> >
> > v1 -> v2:
> >         Few Reviewed-by.
> >
> >         Updated the change log in [8/9]
> >
> >         In [7/9], vm_pgoff is treated in V4L2 API as a 'cookie'
> >         to select a buffer, not as a in-buffer offset by design
> >         and it always want to mmap a whole buffer from its beginning.
> >         Added additional changes after discussing with Marek and
> >         vm_map_pages() could be used instead of vm_map_pages_zero().
> >
> > v2 -> v3:
> >         Corrected the documentation as per review comment.
> >
> >         As suggested in v2, renaming the interfaces to -
> >         *vm_insert_range() -> vm_map_pages()* and
> >         *vm_insert_range_buggy() -> vm_map_pages_zero()*.
> >         As the interface is renamed, modified the code accordingly,
> >         updated the change logs and modified the subject lines to use the
> >         new interfaces. There is no other change apart from renaming and
> >         using the new interface.
> >
> >         Patch[1/9] & [4/9], Tested on Rockchip hardware.
> >
> > v3 -> v4:
> >         Fixed build warnings on patch [8/9] reported by kbuild test robot.
> >
> > Souptick Joarder (9):
> >   mm: Introduce new vm_map_pages() and vm_map_pages_zero() API
> >   arm: mm: dma-mapping: Convert to use vm_map_pages()
> >   drivers/firewire/core-iso.c: Convert to use vm_map_pages_zero()
> >   drm/rockchip/rockchip_drm_gem.c: Convert to use vm_map_pages()
> >   drm/xen/xen_drm_front_gem.c: Convert to use vm_map_pages()
> >   iommu/dma-iommu.c: Convert to use vm_map_pages()
> >   videobuf2/videobuf2-dma-sg.c: Convert to use vm_map_pages()
> >   xen/gntdev.c: Convert to use vm_map_pages()
> >   xen/privcmd-buf.c: Convert to use vm_map_pages_zero()
>
> Is it fine to take these patches into mm tree for regression ?

v4 of this series has not received any further comments/ kbuild error
in last 8 weeks (including
the previously posted v4).

Any suggestion, if it safe to take these changes through mm tree ? or any
other tree is preferred ?

>
> >
> >  arch/arm/mm/dma-mapping.c                          | 22 ++----
> >  drivers/firewire/core-iso.c                        | 15 +---
> >  drivers/gpu/drm/rockchip/rockchip_drm_gem.c        | 17 +----
> >  drivers/gpu/drm/xen/xen_drm_front_gem.c            | 18 ++---
> >  drivers/iommu/dma-iommu.c                          | 12 +---
> >  drivers/media/common/videobuf2/videobuf2-core.c    |  7 ++
> >  .../media/common/videobuf2/videobuf2-dma-contig.c  |  6 --
> >  drivers/media/common/videobuf2/videobuf2-dma-sg.c  | 22 ++----
> >  drivers/xen/gntdev.c                               | 11 ++-
> >  drivers/xen/privcmd-buf.c                          |  8 +--
> >  include/linux/mm.h                                 |  4 ++
> >  mm/memory.c                                        | 81 ++++++++++++++++++++++
> >  mm/nommu.c                                         | 14 ++++
> >  13 files changed, 134 insertions(+), 103 deletions(-)
> >
> > --
> > 1.9.1
> >
