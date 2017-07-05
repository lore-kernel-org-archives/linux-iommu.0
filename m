From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v1 0/4] iommu/tegra: gart: Couple corrections
Date: Wed,  5 Jul 2017 19:29:44 +0300
Message-ID: <cover.1499270277.git.digetx@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

I've added an experimental support of the GART to the Tegra DRM driver
and it ended up with a very positive result. During the testing of the
GART driver I've noticed couple of its minor shortcomings, so here the
patches to remedy them.

Dmitry Osipenko (4):
  iommu/tegra: gart: Don't unnecessarily allocate registers context
  iommu/tegra: gart: Check whether page is already mapped
  iommu/tegra: gart: Move PFN validation out of spinlock
  iommu/tegra: gart: Correct number of unmapped bytes

 drivers/iommu/tegra-gart.c | 49 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 14 deletions(-)

-- 
2.13.2
