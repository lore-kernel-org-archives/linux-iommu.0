From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/5] iommu/omap: Add support for iommu-groups and 'struct
	iommu_device'
Date: Fri, 31 Mar 2017 14:10:43 +0200
Message-ID: <1490962248-12602-1-git-send-email-joro@8bytes.org>
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
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

here is a small patch-set for the omap-iommu driver to make
it use new features of the iommu-core. Please review.

Thanks,

	Joerg

Joerg Roedel (5):
  iommu/omap: Move data structures to omap-iommu.h
  iommu/omap: Permanently keep iommu_dev pointer in arch_data
  iommu/omap: Set dev->archdata.iommu = NULL in omap_iommu_remove_device
  iommu/omap: Make use of 'struct iommu_device'
  iommu/omap: Add iommu-group support

 drivers/iommu/omap-iommu.c               | 137 ++++++++++++++++++++-----------
 drivers/iommu/omap-iommu.h               |  35 ++++++++
 include/linux/platform_data/iommu-omap.h |  15 ----
 3 files changed, 124 insertions(+), 63 deletions(-)

-- 
1.9.1
