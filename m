From: Olav Haugan <ohaugan@codeaurora.org>
Subject: [PATCH v4 0/1] Add iommu map_sg/unmap_sg API
Date: Thu, 31 Jul 2014 17:54:43 -0700
Message-ID: <1406854484-3848-1-git-send-email-ohaugan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: joro@8bytes.org
Cc: robdclark@gmail.com, will.deacon@arm.com, thierry.reding@gmail.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, mitchelh@codeaurora.org, Olav Haugan <ohaugan@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

Patch for adding map_sg/unmap_sg to the generic IOMMU API.

v3 -> v4:
* Removed BUG_ON in both map_sg and unmap_sg
* Removed PAGE_ALIGN of length of mapping

v2 -> v3:
* Updated commit text
* Simplifed fallback code and fixed variable types in map_sg function.
* Renamed and changed arguments to map and unmap functions

v1 -> v2:
* Added support for "option" argument to unmap call. This can be used by
  IOMMU driver implentations to allow clients to signal to the driver not
  to do TLB invalidate for example.
* Added fallback in case iommu_{map,unmap}_range is called for an IOMMU driver
  that does not have these implemented.
* Rebased on top of Joerg's tree.
* Split out patch from the rest of the patches.



Olav Haugan (1):
  iommu-api: Add map_sg/unmap_sg functions

 drivers/iommu/iommu.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

--
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
