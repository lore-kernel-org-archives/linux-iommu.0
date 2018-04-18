From: Peter Xu <peterx-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 1/3] intel-iommu: add some traces for PSIs
Date: Wed, 18 Apr 2018 16:39:51 +0800
Message-ID: <20180418083953.21492-2-peterx@redhat.com>
References: <20180418083953.21492-1-peterx@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180418083953.21492-1-peterx-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Linux IOMMU Mailing List <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Alexander Witte <alexander.witte-eh6l0D9wmvKB+jHODAdFcQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jintack Lim <jintack-eQaUEPhvms7ENvBUuze7eA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

It is helpful to debug and triage PSI notification missings.

Signed-off-by: Peter Xu <peterx-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/dmar.c        | 3 +++
 drivers/iommu/intel-iommu.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 9a7ffd13c7f0..62ae26c3f7b7 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1325,6 +1325,9 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 	struct qi_desc desc;
 	int ih = 0;
 
+	pr_debug("%s: iommu %d did %u addr 0x%llx order %u type %llx\n",
+		 __func__, iommu->seq_id, did, addr, size_order, type);
+
 	if (cap_write_drain(iommu->cap))
 		dw = 1;
 
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 582fd01cb7d1..a64da83e867c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1396,6 +1396,9 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
 	u64 val = 0, val_iva = 0;
 	unsigned long flag;
 
+	pr_debug("%s: iommu %d did %u addr 0x%llx order %u type %llx\n",
+		 __func__, iommu->seq_id, did, addr, size_order, type);
+
 	switch (type) {
 	case DMA_TLB_GLOBAL_FLUSH:
 		/* global flush doesn't need set IVA_REG */
-- 
2.14.3
