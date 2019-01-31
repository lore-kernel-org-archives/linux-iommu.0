From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCHv2 0/9] Use vm_insert_range and vm_insert_range_buggy
Date: Thu, 31 Jan 2019 08:36:31 +0530
Message-ID: <20190131030631.GA1868@jordon-HP-15-Notebook-PC>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com, kirill.shutemov@linux.intel.com, vbabka@suse.cz, riel@surriel.com, sfr@canb.auug.org.au, rppt@linux.vnet.ibm.com, peterz@infradead.org, linux@armlinux.org.uk, robin.murphy@arm.com, iamjoonsoo.kim@lge.com, treding@nvidia.com, keescook@chromium.org, m.szyprowski@samsung.com, stefanr@s5r6.in-berlin.de, hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie, oleksandr_andrushchenko@epam.com, joro@8bytes.org, pawel@osciak.com, kyungmin.park@samsung.com, mchehab@kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux1394-devel@lists.sourceforge.net, dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, xen-devel@lists.xen.org, iommu@lists.linux-foundation.org, linux-media@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Previouly drivers have their own way of mapping range of
kernel pages/memory into user vma and this was done by
invoking vm_insert_page() within a loop.

As this pattern is common across different drivers, it can
be generalized by creating new functions and use it across
the drivers.

vm_insert_range() is the API which could be used to mapped
kernel memory/pages in drivers which has considered vm_pgoff

vm_insert_range_buggy() is the API which could be used to map
range of kernel memory/pages in drivers which has not considered
vm_pgoff. vm_pgoff is passed default as 0 for those drivers.

We _could_ then at a later "fix" these drivers which are using
vm_insert_range_buggy() to behave according to the normal vm_pgoff
offsetting simply by removing the _buggy suffix on the function
name and if that causes regressions, it gives us an easy way to revert.

v1 -> v2:
	Few Reviewed-by.

        Updated the change log in [8/9]

	In [7/9], vm_pgoff is treated in V4L2 API as a 'cookie'
	to select a buffer, not as a in-buffer offset by design
	and it always want to mmap a whole buffer from its beginning.
	Added additional changes after discussing with Marek and
	vm_insert_range could be used instead of vm_insert_range_buggy.

Souptick Joarder (9):
  mm: Introduce new vm_insert_range and vm_insert_range_buggy API
  arch/arm/mm/dma-mapping.c: Convert to use vm_insert_range
  drivers/firewire/core-iso.c: Convert to use vm_insert_range_buggy
  drm/rockchip/rockchip_drm_gem.c: Convert to use vm_insert_range
  drm/xen/xen_drm_front_gem.c: Convert to use vm_insert_range
  iommu/dma-iommu.c: Convert to use vm_insert_range
  videobuf2/videobuf2-dma-sg.c: Convert to use vm_insert_range
  xen/gntdev.c: Convert to use vm_insert_range
  xen/privcmd-buf.c: Convert to use vm_insert_range_buggy

 arch/arm/mm/dma-mapping.c                          | 22 ++----
 drivers/firewire/core-iso.c                        | 15 +---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        | 17 +----
 drivers/gpu/drm/xen/xen_drm_front_gem.c            | 18 ++---
 drivers/iommu/dma-iommu.c                          | 12 +---
 drivers/media/common/videobuf2/videobuf2-core.c    |  7 ++
 .../media/common/videobuf2/videobuf2-dma-contig.c  |  6 --
 drivers/media/common/videobuf2/videobuf2-dma-sg.c  | 22 ++----
 drivers/xen/gntdev.c                               | 16 ++---
 drivers/xen/privcmd-buf.c                          |  8 +--
 include/linux/mm.h                                 |  4 ++
 mm/memory.c                                        | 81 ++++++++++++++++++++++
 mm/nommu.c                                         | 14 ++++
 13 files changed, 136 insertions(+), 106 deletions(-)

-- 
1.9.1
