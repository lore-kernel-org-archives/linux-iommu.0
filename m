From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/2] iommu/vt-d: Make RMRR matching compatible with older
	kernels
Date: Thu,  2 Oct 2014 12:09:06 +0200
Message-ID: <1412244548-27617-1-git-send-email-joro@8bytes.org>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

here is a patch-set to make RMRR matching in the Intel IOMMU
driver compatible with older kernels. This is needed because
some BIOS vendors build RMRR entries to work with older
kernels, but that will break on newer ones that implement
the correct PCI device scope matching scheme defined in the
VT-d specification.

Make the current Intel IOMMU driver work with the old RMRR
entries too.

These patches have been tested in an affected system and fix
the issue seen there (newer kernel did not setup RMRR
entries for a plugged in device).

Regards,

	Joerg

Joerg Roedel (2):
  iommu/vt-d: Store bus information in RMRR PCI device path
  iommu/vt-d: Work around broken RMRR firmware entries

 drivers/iommu/dmar.c | 23 ++++++++++++++++++++---
 include/linux/dmar.h |  8 +++++++-
 2 files changed, 27 insertions(+), 4 deletions(-)

-- 
1.9.1
