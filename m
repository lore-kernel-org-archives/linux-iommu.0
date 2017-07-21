From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/4] IOMMU group cleanup
Date: Fri, 21 Jul 2017 13:12:34 +0100
Message-ID: <cover.1500637633.git.robin.murphy@arm.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

Prompted by some discussion around the questionable usefulness of
iommu_present() for SoC topologies, I took a look at what was left to
finish off the intention of making groups mandatory. Turns out it
wasn't much, so here it is. As well as the general rationalisation
aspect, between this and the probe-deferral changes in 4.12, we should
now be able to rely on the presence of a group unambiguously indicating
whether a given device is associated with an IOMMU or not.

Robin.

Robin Murphy (4):
  iommu/msm: Add iommu_group support
  iommu/tegra-smmu: Add iommu_group support
  iommu/tegra-gart: Add iommu_group support
  iommu: Finish making iommu_group support mandatory

 drivers/iommu/iommu.c      | 19 ++++---------------
 drivers/iommu/msm_iommu.c  | 15 ++++++++++++++-
 drivers/iommu/tegra-gart.c | 19 +++++++++++++++++++
 drivers/iommu/tegra-smmu.c |  9 +++++++++
 4 files changed, 46 insertions(+), 16 deletions(-)

-- 
2.12.2.dirty
