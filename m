From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/6 v2] IOMMU: Make IOMMU-API ready for GART-like hardware
Date: Thu, 26 Jan 2012 19:40:51 +0100
Message-ID: <1327603257-17028-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

here is the second version of this patch-set. For a full description
please see the first post:

	https://lkml.org/lkml/2012/1/19/170

Changes from v1->v2:

	* Changed u64 to dma_addr_t as suggested by Laurent Pinchart
	* Moved description of new iommu_ops members to first patch
	* Added the necessary changes for the Tegra IOMMUs as posted by
	  Hiroshi Doyu

As always, any feedback is appreciated :-)

Thanks,

	Joerg

Diffstat:

 drivers/iommu/amd_iommu.c   |    4 ++++
 drivers/iommu/intel-iommu.c |    4 ++++
 drivers/iommu/iommu.c       |   33 +++++++++++++++++++++++++++++++++
 drivers/iommu/msm_iommu.c   |    5 +++++
 drivers/iommu/omap-iommu.c  |    4 ++++
 drivers/iommu/tegra-gart.c  |    5 +++++
 drivers/iommu/tegra-smmu.c  |    5 +++++
 include/linux/iommu.h       |   36 +++++++++++++++++++++++++++++++++++-
 8 files changed, 95 insertions(+), 1 deletions(-)
