From: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v1 0/3] iommu/amd: AMD IOMMU performance updates 2017-06-05
Date: Mon, 05 Jun 2017 14:52:03 -0500
Message-ID: <20170605195203.11512.20579.stgit@tlendack-t1.amdoffice.net>
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
Cc: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch series addresses some performance issues in the AMD IOMMU
driver:

- Reduce the amount of MMIO performed during command submission
- When the command queue is (near) full, only wait till there is enough
  room for the command rather than wait for the whole queue to be empty
- Limit the flushing of protection domain TLBs to only the protection
  domains associated with the iova data being freed

This patch series is based on the master branch of the iommu tree.

---

Tom Lendacky (3):
      iommu/amd: Reduce amount of MMIO when submitting commands
      iommu/amd: Reduce delay waiting for command buffer space
      iommu/amd: Optimize the IOMMU queue flush


 drivers/iommu/amd_iommu.c       |  100 ++++++++++++++++++++++++++++-----------
 drivers/iommu/amd_iommu_init.c  |    2 +
 drivers/iommu/amd_iommu_types.h |    2 +
 3 files changed, 77 insertions(+), 27 deletions(-)

-- 
Tom Lendacky
