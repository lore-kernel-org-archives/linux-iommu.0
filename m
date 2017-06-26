From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/5] arm-smmu: performance optimization
Date: Mon, 26 Jun 2017 21:38:45 +0800
Message-ID: <1498484330-10840-1-git-send-email-thunder.leizhen@huawei.com>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Zefan Li <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tianhong Ding <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

I described the optimization more detail in patch 1 and 2, and patch 3-5 are
the implementation on arm-smmu/arm-smmu-v3 of patch 2.

Patch 1 is v2. In v1, I directly replaced writel with writel_relaxed in
queue_inc_prod. But Robin figured that it may lead SMMU consume stale
memory contents. I thought more than 3 whole days and got this one.

This patchset is based on Robin Murphy's [PATCH v2 0/8] io-pgtable lock removal.

Zhen Lei (5):
  iommu/arm-smmu-v3: put off the execution of TLBI* to reduce lock
    confliction
  iommu: add a new member unmap_tlb_sync into struct iommu_ops
  iommu/arm-smmu-v3: add support for unmap an iova range with only one
    tlb sync
  iommu/arm-smmu: add support for unmap a memory range with only one tlb
    sync
  iommu/io-pgtable: delete member tlb_sync_pending of struct io_pgtable

 drivers/iommu/arm-smmu-v3.c        | 52 ++++++++++++++++++++++++++++++++++----
 drivers/iommu/arm-smmu.c           | 10 ++++++++
 drivers/iommu/io-pgtable-arm-v7s.c | 32 +++++++++++++++--------
 drivers/iommu/io-pgtable-arm.c     | 30 ++++++++++++++--------
 drivers/iommu/io-pgtable.h         |  9 ++-----
 drivers/iommu/iommu.c              |  3 +++
 include/linux/iommu.h              |  1 +
 7 files changed, 104 insertions(+), 33 deletions(-)

-- 
2.5.0
