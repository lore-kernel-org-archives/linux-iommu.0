From: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: RE: [PATCH 1/1] iommu/vt-d : clear old root entry for dump kernel
Date: Mon, 18 Aug 2014 23:01:56 +0000
Message-ID: <1267BB84A242B24E81E0C0C8955CFFC061A4BA26@G9W0343.americas.hpqcorp.net>
References: <1408352352-14449-1-git-send-email-zhen-hual@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1408352352-14449-1-git-send-email-zhen-hual-VXdhtT5mjnY@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

There is a bug when Linux running on an HP large system: 
	when kdump kernel runs, the hardware is still using the old 
root entry. This causes error message when iommu not finished initialization.

-----Original Message-----
From: Li, Zhen-Hua 
Sent: Monday, August 18, 2014 4:59 PM
To: David Woodhouse; Joerg Roedel; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Li, Zhen-Hua
Subject: [PATCH 1/1] iommu/vt-d : clear old root entry for dump kernel

If intel_iommu is enabled, when kdump kernel boots, the old root entry
 should be cleared, otherwise it may cause DMAR error.

To make it works for more enviroments, this patch does not use 
is_kdump_kernel() to check it,  but reads the register to check whether 
hardware is using old root entry.

Signed-off-by: Li, Zhen-Hua <zhen-hual-VXdhtT5mjnY@public.gmane.org>
---
 drivers/iommu/dmar.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 60ab474..7b4fa90 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -66,6 +66,8 @@ static int dmar_dev_scope_status = 1;
 static int alloc_iommu(struct dmar_drhd_unit *drhd);
 static void free_iommu(struct intel_iommu *iommu);
 
+static int iommu_check_root_entry(struct intel_iommu *iommu);
+
 static void __init dmar_register_drhd_unit(struct dmar_drhd_unit *drhd)
 {
 	/*
@@ -987,6 +989,8 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 						       intel_iommu_groups,
 						       iommu->name);
 
+	iommu_check_root_entry(iommu);
+
 	return 0;
 
  err_unmap:
@@ -1666,5 +1670,32 @@ static int __init dmar_free_unused_resources(void)
 	return 0;
 }
 
+static int iommu_check_root_entry(struct intel_iommu *iommu)
+{
+	u64 re_pa;
+
+	re_pa = dmar_readq(iommu->reg + DMAR_RTADDR_REG);
+
+	/* This only works for hardware error and kdump kernel */
+	if (unlikely(re_pa != 0)) {
+		u32 sts;
+		unsigned long flag;
+
+		raw_spin_lock_irqsave(&iommu->register_lock, flag);
+		dmar_writeq(iommu->reg + DMAR_RTADDR_REG, 0);
+
+		writel(iommu->gcmd | DMA_GCMD_SRTP, iommu->reg + DMAR_GCMD_REG);
+
+		/* Make sure hardware complete it */
+		IOMMU_WAIT_OP(iommu, DMAR_GSTS_REG,
+			      readl, (sts & DMA_GSTS_RTPS), sts);
+
+		raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
+
+	}
+
+	return 0;
+}
+
 late_initcall(dmar_free_unused_resources);
 IOMMU_INIT_POST(detect_intel_iommu);
-- 
2.0.0-rc0
