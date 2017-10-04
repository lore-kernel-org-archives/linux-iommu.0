From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/2] TEGRA GART cleanup and new debug option
Date: Wed,  4 Oct 2017 04:02:29 +0300
Message-ID: <cover.1507078770.git.digetx@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is a continuation of the "iommu/tegra: gart: Couple corrections"
patchset that was send out quite some time ago and reviewed by Thierry Reding
recently.

Change log:

v2:
	- Dropped "Don't unnecessarily allocate registers context" patch
	  as it is not entirely correct.

	- Replaced "Correct number of unmapped bytes" and "Check whether page
	  is already mapped" patches with a new GART debug Kconfig option
	  patch.

Dmitry Osipenko (2):
  iommu/tegra: gart: Optionally check for overwriting of page mappings
  iommu/tegra: gart: Move PFN validation out of spinlock

 drivers/iommu/Kconfig      |  9 +++++++++
 drivers/iommu/tegra-gart.c | 20 +++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

-- 
2.14.1
