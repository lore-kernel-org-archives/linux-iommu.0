From: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v3 0/1] Add iommu map_sg/unmap_sg calls
Date: Mon, 28 Jul 2014 11:38:50 -0700
Message-ID: <1406572731-6216-1-git-send-email-ohaugan@codeaurora.org>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Patch for adding map_sg/unmap_sg to the generic IOMMU API.

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

 drivers/iommu/iommu.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h | 25 +++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

--
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
