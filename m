From: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v6 0/1] Add iommu map_sg API
Date: Sat, 25 Oct 2014 09:55:15 -0700
Message-ID: <1414256116-26933-1-git-send-email-ohaugan@codeaurora.org>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, s-anna-l0cyMroinI0@public.gmane.org
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Patch for adding map_sg to the generic IOMMU API.

v5 -> v6:
* Removed unmap_sg
* Removed flag argument
* Changed return type to size_t returning the amount mapped

v4 -> v5:
* Simplified logic in map_sg on error
* Moved fallback to separate function for both map an unmap and pointed
  all drivers to these fallbacks.

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
  iommu-api: Add map_sg function

 drivers/iommu/amd_iommu.c      |  1 +
 drivers/iommu/arm-smmu.c       |  1 +
 drivers/iommu/exynos-iommu.c   |  1 +
 drivers/iommu/intel-iommu.c    |  1 +
 drivers/iommu/iommu.c          | 25 +++++++++++++++++++++++++
 drivers/iommu/ipmmu-vmsa.c     |  1 +
 drivers/iommu/msm_iommu.c      |  1 +
 drivers/iommu/omap-iommu.c     |  1 +
 drivers/iommu/shmobile-iommu.c |  1 +
 drivers/iommu/tegra-smmu.c     |  1 +
 include/linux/iommu.h          | 22 ++++++++++++++++++++++
 11 files changed, 56 insertions(+)

-- 
Olav

Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
