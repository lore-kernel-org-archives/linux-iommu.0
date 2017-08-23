From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/2 v2] Introduce IOMMU-API TLB Flushing Interface
Date: Wed, 23 Aug 2017 15:50:02 +0200
Message-ID: <1503496204-2527-1-git-send-email-joro@8bytes.org>
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
Cc: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

here is the second version of the patch-set to introduce an
explicit TLB-flushing interface to the IOMMU-API. This
version changed the interface quite a lot compared to the
first version.

This version does not change the semantics of the
iommu_map() and iommu_unmap() functions anymore. The reason
is that the semantic-change doesn't make sense for
iommu_map(), as this path does not require a TLB-flush in
almost all cases. And only changing the semantics of the
iommu_unmap() path would introduce an asymmetry to the
IOMMU-API, which makes it harder to use.

This series introduces the new function iommu_unmap_fast()
instead, which is allowed to return with dirty TLBs. The
three functions for TLB-flushing have not changed compared
to the first version of this patch-set.

Since the iommu_map()/unmap() functions don't change their
semantics anymore, I've also dropped all patches which
convert the existing users.

Please review.

Thanks,

	Joerg

Joerg Roedel (2):
  iommu/amd: Rename a few flush functions
  iommu: Introduce Interface for IOMMU TLB Flushing

 drivers/iommu/amd_iommu.c | 16 +++++------
 drivers/iommu/iommu.c     | 32 ++++++++++++++++++---
 include/linux/iommu.h     | 72 ++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 107 insertions(+), 13 deletions(-)

-- 
2.7.4
