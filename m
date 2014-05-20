From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/5] AMD IOMMUv2 Cleanups and Fixes
Date: Tue, 20 May 2014 23:18:21 +0200
Message-ID: <1400620706-21031-1-git-send-email-joro@8bytes.org>
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
Cc: Jay.Cornwall-5C7GfCeVMHo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

here is a small patch-set with some clean-ups for the AMD IOMMUv2
driver. The most important change is the conversion to use the
mmu_notifier release call-back instead of the task_exit notifier to get
notified when a MM dies. Please review.

Thanks,

	Joerg

Diffstat:

 drivers/iommu/amd_iommu_v2.c |  184 +++++++++++++++++-------------------------

Shortlog:

Joerg Roedel (5):
      iommu/amd: Don't access IOMMUv2 state_table directly
      iommu/amd: Convert IOMMUv2 state_table into state_list
      iommu/amd: Implement mmu_notifier_release call-back
      iommu/amd: Remove IOMMUv2 pasid_state_list
      iommu/amd: Handle parallel invalidate_range_start/end calls correctly

 1 file changed, 74 insertions(+), 110 deletions(-)
