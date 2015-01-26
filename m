From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 00/15] iommu: Move domain allocation into drivers
Date: Tue, 27 Jan 2015 00:51:30 +0100
Message-ID: <1422316305-19216-1-git-send-email-joro@8bytes.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Hi,

here is patch-set to replace the existing domain_init and
domain_destroy iommu-ops with the new domain_alloc and
domain_free callbacks

The new callbacks move the allocation of iommu domains into
the iommu driver, allowing them to put a generic
iommu_domain struct into their own domain struct. This makes
domain handling in the drivers more cache efficient and
prepares the introduction of default domains in another
patch-set.

While at it, this patch-set also introduces domain types.
These are internal to the iommu core code for now, there are
three of them:

	* DMA-API domains
	* Identity mapped domains
	* Domains unmanaged by the iommu-core, used for
	  iommu-api so that the users can create their own
	  mappings

The patches have been compile tested for x86, ARM and PPC
and runtime tested on x86 (Intel VT-d and AMD IOMMU).

Please review.

Thanks,

	Joerg

Joerg Roedel (15):
  iommu: Introduce domain_alloc and domain_free iommu_ops
  iommu: Introduce iommu domain types
  iommu/amd: Make use of domain_alloc and domain_free
  iommu/vt-d: Make use of domain_alloc and domain_free
  iommu/omap: Make use of domain_alloc and domain_free
  iommu/arm-smmu: Make use of domain_alloc and domain_free
  iommu/exynos: Make use of domain_alloc and domain_free
  iommu/tegra-smmu: Make use of domain_alloc and domain_free
  iommu/tegra-gart: Make use of domain_alloc and domain_free
  iommu/msm: Make use of domain_alloc and domain_free
  iommu/shmobile: Make use of domain_alloc and domain_free
  iommu/ipmmu-vmsa: Make use of domain_alloc and domain_free
  iommu/rockchip: Make use of domain_alloc and domain_free
  iommu/fsl: Make use of domain_alloc and domain_free
  iommu: Remove domain_init and domain_free iommu_ops

 drivers/iommu/amd_iommu.c       | 84 +++++++++++++++++++++------------------
 drivers/iommu/amd_iommu_types.h |  7 ++--
 drivers/iommu/arm-smmu.c        | 46 +++++++++++++---------
 drivers/iommu/exynos-iommu.c    | 87 ++++++++++++++++++++++-------------------
 drivers/iommu/fsl_pamu_domain.c | 60 +++++++++++++++-------------
 drivers/iommu/fsl_pamu_domain.h |  2 +-
 drivers/iommu/intel-iommu.c     | 48 +++++++++++++----------
 drivers/iommu/iommu.c           | 20 ++--------
 drivers/iommu/ipmmu-vmsa.c      | 43 +++++++++++---------
 drivers/iommu/msm_iommu.c       | 73 +++++++++++++++++-----------------
 drivers/iommu/omap-iommu.c      | 49 +++++++++++++----------
 drivers/iommu/rockchip-iommu.c  | 40 +++++++++++--------
 drivers/iommu/shmobile-iommu.c  | 40 +++++++++++--------
 drivers/iommu/tegra-gart.c      | 67 +++++++++++++++++++++----------
 drivers/iommu/tegra-smmu.c      | 41 ++++++++++---------
 include/linux/iommu.h           | 17 ++++++--
 16 files changed, 407 insertions(+), 317 deletions(-)

-- 
1.8.4.5
