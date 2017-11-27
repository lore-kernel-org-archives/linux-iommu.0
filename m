From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] iommu/tegra: Add IOMMU group support
Date: Mon, 27 Nov 2017 10:50:53 +0100
Message-ID: <20171127095055.21486-1-thierry.reding@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Hi Joerg,

Both patches in this series are built-time dependent and therefore it
would be easiest if they went in via the same tree (either the IOMMU
tree, or the Tegra tree with your Acked-by on patch 1). Alternatively,
I could put patch two in a separate branch and provide a stable tag for
you to pull in, in order to resolve the dependency.

Do you have any preference?

Thierry

Thierry Reding (2):
  iommu/tegra: Allow devices to be grouped
  memory: tegra: Create SMMU display groups

 drivers/iommu/tegra-smmu.c      | 124 ++++++++++++++++++++++++++++++++++++++--
 drivers/memory/tegra/tegra114.c |  15 +++++
 drivers/memory/tegra/tegra124.c |  17 ++++++
 drivers/memory/tegra/tegra210.c |  15 +++++
 drivers/memory/tegra/tegra30.c  |  15 +++++
 include/soc/tegra/mc.h          |   9 +++
 6 files changed, 191 insertions(+), 4 deletions(-)

-- 
2.15.0
