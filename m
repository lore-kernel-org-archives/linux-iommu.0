From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/9] iommu: Fix some static checker warnings
Date: Thu, 13 Aug 2015 19:33:47 +0200
Message-ID: <1439487236-14098-1-git-send-email-joro@8bytes.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

here are some patches to fix various static checker warnings
I have seen through testing other code. Main intention
behind these is to reduce the noise. In particular I used
these checkers:

	* coccinelle scripts in the kernel tree
	* smatch
	* sparse

Please review.

Thanks,

	Joerg

Joerg Roedel (9):
  iommu/amd: Simplify allocation in irq_remapping_alloc()
  iommu/amd: Make a symbol static
  iommu/amd: Use BUG_ON instead of if () BUG()
  iommu/vt-d: Return false instead of 0 in irq_remapping_cap()
  iommu/vt-d: Use BUG_ON instead of if () BUG()
  iommu/vt-d: Make two functions static
  iommu/vt-d: Access iomem correctly
  iommu/msm: Use BUG_ON instead of if () BUG()
  iommu/io-pgtable-arm: Move init-fn declarations to io-pgtable.h

 drivers/iommu/amd_iommu.c           | 21 ++++++++-------------
 drivers/iommu/amd_iommu_init.c      |  2 +-
 drivers/iommu/amd_iommu_v2.c        |  4 ++--
 drivers/iommu/intel-iommu.c         | 26 ++++++++++++++------------
 drivers/iommu/intel_irq_remapping.c |  4 ++--
 drivers/iommu/io-pgtable.c          |  5 -----
 drivers/iommu/io-pgtable.h          |  5 +++++
 drivers/iommu/irq_remapping.c       |  2 +-
 drivers/iommu/msm_iommu.c           |  4 ++--
 9 files changed, 35 insertions(+), 38 deletions(-)

-- 
1.9.1
