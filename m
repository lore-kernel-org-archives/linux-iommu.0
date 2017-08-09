From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/2] iommu/tegra*: Add support for struct iommu_device
Date: Thu, 10 Aug 2017 00:29:10 +0200
Message-ID: <1502317752-8792-1-git-send-email-joro@8bytes.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

here are two patches to add support for 'struct iommu_device'
to the tegra iommu-drivers. This will make the iommu-core
code aware of the hardware iommus that a driver manages.

It will also add the iommus to sysfs and link them to the
devices managed by them.

The patches apply on-top of Robin's iommu-group patches.

Please review.

Regards,

	Joerg

Joerg Roedel (2):
  iommu/tegra: Add support for struct iommu_device
  iommu/tegra-gart: Add support for struct iommu_device

 drivers/iommu/tegra-gart.c | 26 ++++++++++++++++++++++++++
 drivers/iommu/tegra-smmu.c | 25 +++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

-- 
2.7.4
