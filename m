From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/9] AMD IOMMUv2 driver updates and fixes
Date: Thu, 10 Jul 2014 15:25:41 +0200
Message-ID: <1404998750-15536-1-git-send-email-joro@8bytes.org>
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
List-Id: iommu@lists.linux-foundation.org

Hi,

here is a queue of patches for the AMD IOMMUv2 driver that came up
during development of the radeon_kfd driver. The enhance the semantics
and fix a number of bugs found in the code.


	Joerg

Diffstat:

 drivers/iommu/amd_iommu_v2.c |  104 ++++++++++++++++++++++++++++--------------
 1 file changed, 71 insertions(+), 33 deletions(-)

Shortlog:

Joerg Roedel (9):
      iommu/amd: Fix typo in amd_iommu_v2 driver
      iommu/amd: Don't call mmu_notifer_unregister in __unbind_pasid
      iommu/amd: Don't free pasid_state in mn_release path
      iommu/amd: Get rid of __unbind_pasid
      iommu/amd: Drop pasid_state reference in ppr_notifer error path
      iommu/amd: Add pasid_state->invalid flag
      iommu/amd: Don't hold a reference to mm_struct
      iommu/amd: Don't hold a reference to task_struct
      iommu/amd: Don't call the inv_ctx_cb when pasid is not set up
