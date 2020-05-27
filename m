Return-Path: <SRS0=MQAj=7J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B036EC433DF
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 11:53:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90792207CB
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 11:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90792207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2BAF388799;
	Wed, 27 May 2020 11:53:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BYs7LDV8jEEA; Wed, 27 May 2020 11:53:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F3D6A88781;
	Wed, 27 May 2020 11:53:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF77AC0891;
	Wed, 27 May 2020 11:53:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CA7AC016F
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 11:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F2FB788773
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 11:53:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x+TdRwyKdMCP for <iommu@lists.linux-foundation.org>;
 Wed, 27 May 2020 11:53:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7CCA988767
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 11:53:29 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 7B2F24A6; Wed, 27 May 2020 13:53:24 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 08/10] iommu/amd: Merge private header files
Date: Wed, 27 May 2020 13:53:11 +0200
Message-Id: <20200527115313.7426-9-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527115313.7426-1-joro@8bytes.org>
References: <20200527115313.7426-1-joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, jroedel@suse.de,
 linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Joerg Roedel <jroedel@suse.de>

Merge amd_iommu_proto.h into amd_iommu.h.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/amd_iommu.h       | 96 +++++++++++++++++++++++++++-
 drivers/iommu/amd/amd_iommu_proto.h | 97 -----------------------------
 drivers/iommu/amd/debugfs.c         |  5 +-
 drivers/iommu/amd/init.c            |  4 +-
 drivers/iommu/amd/iommu.c           |  4 +-
 drivers/iommu/amd/iommu_v2.c        |  4 +-
 6 files changed, 100 insertions(+), 110 deletions(-)
 delete mode 100644 drivers/iommu/amd/amd_iommu_proto.h

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 12d540d9b59b..f892992c8744 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -1,9 +1,103 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2009-2010 Advanced Micro Devices, Inc.
+ * Author: Joerg Roedel <jroedel@suse.de>
+ */
 
 #ifndef AMD_IOMMU_H
 #define AMD_IOMMU_H
 
-int __init add_special_device(u8 type, u8 id, u16 *devid, bool cmd_line);
+#include <linux/iommu.h>
+
+#include "amd_iommu_types.h"
+
+extern int amd_iommu_get_num_iommus(void);
+extern int amd_iommu_init_dma_ops(void);
+extern int amd_iommu_init_passthrough(void);
+extern irqreturn_t amd_iommu_int_thread(int irq, void *data);
+extern irqreturn_t amd_iommu_int_handler(int irq, void *data);
+extern void amd_iommu_apply_erratum_63(u16 devid);
+extern void amd_iommu_reset_cmd_buffer(struct amd_iommu *iommu);
+extern int amd_iommu_init_devices(void);
+extern void amd_iommu_uninit_devices(void);
+extern void amd_iommu_init_notifier(void);
+extern int amd_iommu_init_api(void);
+
+#ifdef CONFIG_AMD_IOMMU_DEBUGFS
+void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
+#else
+static inline void amd_iommu_debugfs_setup(struct amd_iommu *iommu) {}
+#endif
+
+/* Needed for interrupt remapping */
+extern int amd_iommu_prepare(void);
+extern int amd_iommu_enable(void);
+extern void amd_iommu_disable(void);
+extern int amd_iommu_reenable(int);
+extern int amd_iommu_enable_faulting(void);
+extern int amd_iommu_guest_ir;
+
+/* IOMMUv2 specific functions */
+struct iommu_domain;
+
+extern bool amd_iommu_v2_supported(void);
+extern int amd_iommu_register_ppr_notifier(struct notifier_block *nb);
+extern int amd_iommu_unregister_ppr_notifier(struct notifier_block *nb);
+extern void amd_iommu_domain_direct_map(struct iommu_domain *dom);
+extern int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids);
+extern int amd_iommu_flush_page(struct iommu_domain *dom, int pasid,
+				u64 address);
+extern int amd_iommu_flush_tlb(struct iommu_domain *dom, int pasid);
+extern int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, int pasid,
+				     unsigned long cr3);
+extern int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, int pasid);
+extern struct iommu_domain *amd_iommu_get_v2_domain(struct pci_dev *pdev);
+
+#ifdef CONFIG_IRQ_REMAP
+extern int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
+#else
+static inline int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
+{
+	return 0;
+}
+#endif
+
+#define PPR_SUCCESS			0x0
+#define PPR_INVALID			0x1
+#define PPR_FAILURE			0xf
+
+extern int amd_iommu_complete_ppr(struct pci_dev *pdev, int pasid,
+				  int status, int tag);
+
+static inline bool is_rd890_iommu(struct pci_dev *pdev)
+{
+	return (pdev->vendor == PCI_VENDOR_ID_ATI) &&
+	       (pdev->device == PCI_DEVICE_ID_RD890_IOMMU);
+}
+
+static inline bool iommu_feature(struct amd_iommu *iommu, u64 f)
+{
+	if (!(iommu->cap & (1 << IOMMU_CAP_EFR)))
+		return false;
+
+	return !!(iommu->features & f);
+}
+
+static inline u64 iommu_virt_to_phys(void *vaddr)
+{
+	return (u64)__sme_set(virt_to_phys(vaddr));
+}
+
+static inline void *iommu_phys_to_virt(unsigned long paddr)
+{
+	return phys_to_virt(__sme_clr(paddr));
+}
+
+extern bool translation_pre_enabled(struct amd_iommu *iommu);
+extern bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
+					 struct device *dev);
+extern int __init add_special_device(u8 type, u8 id, u16 *devid,
+				     bool cmd_line);
 
 #ifdef CONFIG_DMI
 void amd_iommu_apply_ivrs_quirks(void);
diff --git a/drivers/iommu/amd/amd_iommu_proto.h b/drivers/iommu/amd/amd_iommu_proto.h
deleted file mode 100644
index 1c6c12c11368..000000000000
--- a/drivers/iommu/amd/amd_iommu_proto.h
+++ /dev/null
@@ -1,97 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2009-2010 Advanced Micro Devices, Inc.
- * Author: Joerg Roedel <jroedel@suse.de>
- */
-
-#ifndef _ASM_X86_AMD_IOMMU_PROTO_H
-#define _ASM_X86_AMD_IOMMU_PROTO_H
-
-#include "amd_iommu_types.h"
-
-extern int amd_iommu_get_num_iommus(void);
-extern int amd_iommu_init_dma_ops(void);
-extern int amd_iommu_init_passthrough(void);
-extern irqreturn_t amd_iommu_int_thread(int irq, void *data);
-extern irqreturn_t amd_iommu_int_handler(int irq, void *data);
-extern void amd_iommu_apply_erratum_63(u16 devid);
-extern void amd_iommu_reset_cmd_buffer(struct amd_iommu *iommu);
-extern int amd_iommu_init_devices(void);
-extern void amd_iommu_uninit_devices(void);
-extern void amd_iommu_init_notifier(void);
-extern int amd_iommu_init_api(void);
-
-#ifdef CONFIG_AMD_IOMMU_DEBUGFS
-void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
-#else
-static inline void amd_iommu_debugfs_setup(struct amd_iommu *iommu) {}
-#endif
-
-/* Needed for interrupt remapping */
-extern int amd_iommu_prepare(void);
-extern int amd_iommu_enable(void);
-extern void amd_iommu_disable(void);
-extern int amd_iommu_reenable(int);
-extern int amd_iommu_enable_faulting(void);
-extern int amd_iommu_guest_ir;
-
-/* IOMMUv2 specific functions */
-struct iommu_domain;
-
-extern bool amd_iommu_v2_supported(void);
-extern int amd_iommu_register_ppr_notifier(struct notifier_block *nb);
-extern int amd_iommu_unregister_ppr_notifier(struct notifier_block *nb);
-extern void amd_iommu_domain_direct_map(struct iommu_domain *dom);
-extern int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids);
-extern int amd_iommu_flush_page(struct iommu_domain *dom, int pasid,
-				u64 address);
-extern int amd_iommu_flush_tlb(struct iommu_domain *dom, int pasid);
-extern int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, int pasid,
-				     unsigned long cr3);
-extern int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, int pasid);
-extern struct iommu_domain *amd_iommu_get_v2_domain(struct pci_dev *pdev);
-
-#ifdef CONFIG_IRQ_REMAP
-extern int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
-#else
-static inline int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
-{
-	return 0;
-}
-#endif
-
-#define PPR_SUCCESS			0x0
-#define PPR_INVALID			0x1
-#define PPR_FAILURE			0xf
-
-extern int amd_iommu_complete_ppr(struct pci_dev *pdev, int pasid,
-				  int status, int tag);
-
-static inline bool is_rd890_iommu(struct pci_dev *pdev)
-{
-	return (pdev->vendor == PCI_VENDOR_ID_ATI) &&
-	       (pdev->device == PCI_DEVICE_ID_RD890_IOMMU);
-}
-
-static inline bool iommu_feature(struct amd_iommu *iommu, u64 f)
-{
-	if (!(iommu->cap & (1 << IOMMU_CAP_EFR)))
-		return false;
-
-	return !!(iommu->features & f);
-}
-
-static inline u64 iommu_virt_to_phys(void *vaddr)
-{
-	return (u64)__sme_set(virt_to_phys(vaddr));
-}
-
-static inline void *iommu_phys_to_virt(unsigned long paddr)
-{
-	return phys_to_virt(__sme_clr(paddr));
-}
-
-extern bool translation_pre_enabled(struct amd_iommu *iommu);
-extern bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
-					 struct device *dev);
-#endif /* _ASM_X86_AMD_IOMMU_PROTO_H  */
diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index c6a5c737ef09..545372fcc72f 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -8,10 +8,9 @@
  */
 
 #include <linux/debugfs.h>
-#include <linux/iommu.h>
 #include <linux/pci.h>
-#include "amd_iommu_proto.h"
-#include "amd_iommu_types.h"
+
+#include "amd_iommu.h"
 
 static struct dentry *amd_iommu_debugfs;
 static DEFINE_MUTEX(amd_iommu_debugfs_lock);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index fda80fd1d9a6..6ebd4825e320 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -18,7 +18,6 @@
 #include <linux/msi.h>
 #include <linux/amd-iommu.h>
 #include <linux/export.h>
-#include <linux/iommu.h>
 #include <linux/kmemleak.h>
 #include <linux/mem_encrypt.h>
 #include <asm/pci-direct.h>
@@ -32,9 +31,8 @@
 #include <asm/irq_remapping.h>
 
 #include <linux/crash_dump.h>
+
 #include "amd_iommu.h"
-#include "amd_iommu_proto.h"
-#include "amd_iommu_types.h"
 #include "../irq_remapping.h"
 
 /*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 7c87ef78f26a..e3fdc7a0e853 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -22,7 +22,6 @@
 #include <linux/dma-direct.h>
 #include <linux/dma-iommu.h>
 #include <linux/iommu-helper.h>
-#include <linux/iommu.h>
 #include <linux/delay.h>
 #include <linux/amd-iommu.h>
 #include <linux/notifier.h>
@@ -43,8 +42,7 @@
 #include <asm/gart.h>
 #include <asm/dma.h>
 
-#include "amd_iommu_proto.h"
-#include "amd_iommu_types.h"
+#include "amd_iommu.h"
 #include "../irq_remapping.h"
 
 #define CMD_SET_TYPE(cmd, t) ((cmd)->data[1] |= ((t) << 28))
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 9b6e038150c1..c8a7b6b39222 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -13,13 +13,11 @@
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
-#include <linux/iommu.h>
 #include <linux/wait.h>
 #include <linux/pci.h>
 #include <linux/gfp.h>
 
-#include "amd_iommu_types.h"
-#include "amd_iommu_proto.h"
+#include "amd_iommu.h"
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Joerg Roedel <jroedel@suse.de>");
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
