From: Olav Haugan <ohaugan@codeaurora.org>
Subject: [PATCH v2 0/1] Add iommu map_range/unmap_range calls
Date: Wed, 16 Jul 2014 18:01:56 -0700
Message-ID: <1405558917-7597-1-git-send-email-ohaugan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: joro@8bytes.org
Cc: robdclark@gmail.com, will.deacon@arm.com, thierry.reding@gmail.com, iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org, mitchelh@codeaurora.org, Olav Haugan <ohaugan@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

Patch for adding map_range/unmap range to the generic IOMMU API.

v1 -> v2:
* Added support for "option" argument to unmap call. This can be used by
  IOMMU driver implentations to allow clients to signal to the driver not
  to do TLB invalidate for example.
* Added fallback in case iommu_{map,unmap}_range is called for an IOMMU driver
  that does not have these implemented.
* Rebased on top of Joerg's tree.
* Split out patch from the rest of the patches.

Olav Haugan (1):
  iommu-api: Add map_range/unmap_range functions

 drivers/iommu/iommu.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h | 25 +++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

--
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
