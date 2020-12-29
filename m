Return-Path: <SRS0=AIYf=GB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4647CC433E0
	for <iommu@archiver.kernel.org>; Tue, 29 Dec 2020 01:49:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 090D9221F8
	for <iommu@archiver.kernel.org>; Tue, 29 Dec 2020 01:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090D9221F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C0014844D4;
	Tue, 29 Dec 2020 01:49:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E5bbMNCb_-2K; Tue, 29 Dec 2020 01:49:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 87A54844EA;
	Tue, 29 Dec 2020 01:49:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 638FCC1DA7;
	Tue, 29 Dec 2020 01:49:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13240C0174
 for <iommu@lists.linux-foundation.org>; Tue, 29 Dec 2020 01:49:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0CBB3844E2
 for <iommu@lists.linux-foundation.org>; Tue, 29 Dec 2020 01:49:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zpqCf-7EKupH for <iommu@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 01:49:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from so254-31.mailgun.net (so254-31.mailgun.net [198.61.254.31])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 676A38445E
 for <iommu@lists.linux-foundation.org>; Tue, 29 Dec 2020 01:49:18 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1609206560; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=0B3zKdf9FkvtJgpXxelylee2gJybjJX9T1Q1FeVXnR0=;
 b=T7bYBSfdgiOdQCcTK5jfcdUOWAN/U4IpieOGYrgvZZnWLZmmA4R+J+3xjAef6DZCScHLg5Id
 9vOs0gmQ0PfDWeOCOu43bMMDVqjDzPnt3VFBLYoAFg9qHR8qwVK6yoNiIOgMlXD3Q0LOwKA7
 Y9/+WBAYrCUzgLPxlZ5vrYat7ew=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5fea8b187bc801dc4f42735e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 29 Dec 2020 01:49:12
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id C1400C433CA; Tue, 29 Dec 2020 01:49:11 +0000 (UTC)
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 5191EC433C6;
 Tue, 29 Dec 2020 01:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5191EC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=isaacm@codeaurora.org
From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 robdclark@gmail.com, sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
 steven.price@arm.com, alyssa.rosenzweig@collabora.com, robh@kernel.org,
 tomeu.vizoso@collabora.com
Subject: [PATCH 1/7] iommu/io-pgtable: Introduce dynamic io-pgtable format
 registration
Date: Mon, 28 Dec 2020 17:48:55 -0800
Message-Id: <1609206541-14562-2-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609206541-14562-1-git-send-email-isaacm@codeaurora.org>
References: <1609206541-14562-1-git-send-email-isaacm@codeaurora.org>
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 freedreno@lists.freedesktop.org, pdaly@codeaurora.org, pratikp@codeaurora.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org
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

The io-pgtable code constructs an array of init functions for each
page table format at compile time. This is not ideal, as it prevents
io-pgtable formats from being built as kernel modules.

In preparation for modularizing the io-pgtable formats, switch to a
dynamic registration scheme, where each io-pgtable format can register
their init functions with the io-pgtable code at boot or module
insertion time.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 33 ++++++++++++-
 drivers/iommu/io-pgtable-arm.c     | 97 ++++++++++++++++++++++++++++----------
 drivers/iommu/io-pgtable.c         | 44 +++++++++++------
 include/linux/io-pgtable.h         | 50 ++++++++++++--------
 4 files changed, 164 insertions(+), 60 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 1d92ac9..080881b 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -28,6 +28,7 @@
 #include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/kmemleak.h>
+#include <linux/module.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -835,7 +836,7 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 	return NULL;
 }
 
-struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns = {
+static struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns = {
 	.alloc	= arm_v7s_alloc_pgtable,
 	.free	= arm_v7s_free_pgtable,
 };
@@ -982,5 +983,33 @@ static int __init arm_v7s_do_selftests(void)
 	pr_info("self test ok\n");
 	return 0;
 }
-subsys_initcall(arm_v7s_do_selftests);
+#else
+static int arm_v7s_do_selftests(void)
+{
+	return 0;
+}
 #endif
+
+static int __init arm_v7s_init(void)
+{
+	int ret;
+
+	ret = io_pgtable_ops_register(ARM_V7S, &io_pgtable_arm_v7s_init_fns);
+	if (ret < 0) {
+		pr_err("Failed to register ARM v7s fmt ret = %d\n", ret);
+		return ret;
+	}
+
+	ret = arm_v7s_do_selftests();
+	if (ret < 0)
+		io_pgtable_ops_unregister(ARM_V7S);
+
+	return ret;
+}
+core_initcall(arm_v7s_init);
+
+static void __exit arm_v7s_exit(void)
+{
+	io_pgtable_ops_unregister(ARM_V7S);
+}
+module_exit(arm_v7s_exit);
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 87def58..e1f8d54 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -13,6 +13,7 @@
 #include <linux/bitops.h>
 #include <linux/io-pgtable.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -145,6 +146,11 @@ struct arm_lpae_io_pgtable {
 	void			*pgd;
 };
 
+struct arm_lpae_io_pgtable_init_fns {
+	enum io_pgtable_fmt fmt;
+	struct io_pgtable_init_fns init_fns;
+};
+
 typedef u64 arm_lpae_iopte;
 
 static inline bool iopte_leaf(arm_lpae_iopte pte, int lvl,
@@ -1043,29 +1049,32 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 	return NULL;
 }
 
-struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns = {
-	.alloc	= arm_64_lpae_alloc_pgtable_s1,
-	.free	= arm_lpae_free_pgtable,
-};
-
-struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns = {
-	.alloc	= arm_64_lpae_alloc_pgtable_s2,
-	.free	= arm_lpae_free_pgtable,
-};
-
-struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s1_init_fns = {
-	.alloc	= arm_32_lpae_alloc_pgtable_s1,
-	.free	= arm_lpae_free_pgtable,
-};
-
-struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s2_init_fns = {
-	.alloc	= arm_32_lpae_alloc_pgtable_s2,
-	.free	= arm_lpae_free_pgtable,
-};
-
-struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
-	.alloc	= arm_mali_lpae_alloc_pgtable,
-	.free	= arm_lpae_free_pgtable,
+static struct arm_lpae_io_pgtable_init_fns arm_lpae_init_fns_table[] = {
+	{
+		.fmt		= ARM_32_LPAE_S1,
+		.init_fns.alloc	= arm_32_lpae_alloc_pgtable_s1,
+		.init_fns.free	= arm_lpae_free_pgtable,
+	},
+	{
+		.fmt		= ARM_32_LPAE_S2,
+		.init_fns.alloc	= arm_32_lpae_alloc_pgtable_s2,
+		.init_fns.free	= arm_lpae_free_pgtable,
+	},
+	{
+		.fmt		= ARM_64_LPAE_S1,
+		.init_fns.alloc	= arm_64_lpae_alloc_pgtable_s1,
+		.init_fns.free	= arm_lpae_free_pgtable,
+	},
+	{
+		.fmt		= ARM_64_LPAE_S2,
+		.init_fns.alloc	= arm_64_lpae_alloc_pgtable_s2,
+		.init_fns.free	= arm_lpae_free_pgtable,
+	},
+	{
+		.fmt		= ARM_MALI_LPAE,
+		.init_fns.alloc	= arm_mali_lpae_alloc_pgtable,
+		.init_fns.free	= arm_lpae_free_pgtable,
+	},
 };
 
 #ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST
@@ -1250,5 +1259,45 @@ static int __init arm_lpae_do_selftests(void)
 	pr_info("selftest: completed with %d PASS %d FAIL\n", pass, fail);
 	return fail ? -EFAULT : 0;
 }
-subsys_initcall(arm_lpae_do_selftests);
+#else
+static int __init arm_lpae_do_selftests(void)
+{
+	return 0;
+}
 #endif
+
+static int __init arm_lpae_init(void)
+{
+	int ret, i;
+
+	for (i = 0; i < ARRAY_SIZE(arm_lpae_init_fns_table); i++) {
+		ret = io_pgtable_ops_register(arm_lpae_init_fns_table[i].fmt,
+					      &arm_lpae_init_fns_table[i].init_fns);
+		if (ret < 0) {
+			pr_err("Failed to register ARM LPAE fmt: %d ret: %d\n",
+			       arm_lpae_init_fns_table[i].fmt, ret);
+			goto err_io_pgtable_register;
+		}
+	}
+
+	ret = arm_lpae_do_selftests();
+	if (ret < 0)
+		goto err_io_pgtable_register;
+
+	return 0;
+
+err_io_pgtable_register:
+	while (i--)
+		io_pgtable_ops_unregister(arm_lpae_init_fns_table[i].fmt);
+	return ret;
+}
+core_initcall(arm_lpae_init);
+
+static void __exit arm_lpae_exit(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(arm_lpae_init_fns_table); i++)
+		io_pgtable_ops_unregister(arm_lpae_init_fns_table[i].fmt);
+}
+module_exit(arm_lpae_exit);
diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index 94394c8..95e872d 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -12,26 +12,14 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 
-static const struct io_pgtable_init_fns *
-io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
-#ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE
-	[ARM_32_LPAE_S1] = &io_pgtable_arm_32_lpae_s1_init_fns,
-	[ARM_32_LPAE_S2] = &io_pgtable_arm_32_lpae_s2_init_fns,
-	[ARM_64_LPAE_S1] = &io_pgtable_arm_64_lpae_s1_init_fns,
-	[ARM_64_LPAE_S2] = &io_pgtable_arm_64_lpae_s2_init_fns,
-	[ARM_MALI_LPAE] = &io_pgtable_arm_mali_lpae_init_fns,
-#endif
-#ifdef CONFIG_IOMMU_IO_PGTABLE_ARMV7S
-	[ARM_V7S] = &io_pgtable_arm_v7s_init_fns,
-#endif
-};
+static struct io_pgtable_init_fns *io_pgtable_init_table[IO_PGTABLE_NUM_FMTS];
 
 struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
 					    struct io_pgtable_cfg *cfg,
 					    void *cookie)
 {
 	struct io_pgtable *iop;
-	const struct io_pgtable_init_fns *fns;
+	struct io_pgtable_init_fns *fns;
 
 	if (fmt >= IO_PGTABLE_NUM_FMTS)
 		return NULL;
@@ -59,12 +47,38 @@ EXPORT_SYMBOL_GPL(alloc_io_pgtable_ops);
 void free_io_pgtable_ops(struct io_pgtable_ops *ops)
 {
 	struct io_pgtable *iop;
+	struct io_pgtable_init_fns *fns;
 
 	if (!ops)
 		return;
 
 	iop = io_pgtable_ops_to_pgtable(ops);
 	io_pgtable_tlb_flush_all(iop);
-	io_pgtable_init_table[iop->fmt]->free(iop);
+	fns = io_pgtable_init_table[iop->fmt];
+	if (fns)
+		fns->free(iop);
 }
 EXPORT_SYMBOL_GPL(free_io_pgtable_ops);
+
+int io_pgtable_ops_register(enum io_pgtable_fmt fmt,
+			    struct io_pgtable_init_fns *init_fns)
+{
+	if (fmt >= IO_PGTABLE_NUM_FMTS || !init_fns || !init_fns->alloc ||
+	    !init_fns->free)
+		return -EINVAL;
+	else if (io_pgtable_init_table[fmt])
+		return -EEXIST;
+
+	io_pgtable_init_table[fmt] = init_fns;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(io_pgtable_ops_register);
+
+void io_pgtable_ops_unregister(enum io_pgtable_fmt fmt)
+{
+	if (fmt >= IO_PGTABLE_NUM_FMTS)
+		return;
+
+	io_pgtable_init_table[fmt] = NULL;
+}
+EXPORT_SYMBOL_GPL(io_pgtable_ops_unregister);
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index ea727eb..a460ae1 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -163,6 +163,37 @@ struct io_pgtable_ops {
 };
 
 /**
+ * struct io_pgtable_init_fns - Alloc/free a set of page tables for a
+ *                              particular format.
+ *
+ * @alloc: Allocate a set of page tables described by cfg.
+ * @free:  Free the page tables associated with iop.
+ */
+struct io_pgtable_init_fns {
+	struct io_pgtable *(*alloc)(struct io_pgtable_cfg *cfg, void *cookie);
+	void (*free)(struct io_pgtable *iop);
+};
+
+/**
+ * io_pgtable_ops_register() - Register the page table routines for a page table
+ *                             format.
+ *
+ * @fmt:      The page table format for which we are registering ops for.
+ * @init_fns: The functions for allocating and freeing the page tables of
+ *            a particular format.
+ */
+int io_pgtable_ops_register(enum io_pgtable_fmt fmt,
+			    struct io_pgtable_init_fns *init_fns);
+
+/**
+ * io_pgtable_ops_unregister() - Unregister the page table routines for a page
+ *                               table format.
+ *
+ * @fmt: The format for which we are unregistering ops for.
+ */
+void io_pgtable_ops_unregister(enum io_pgtable_fmt fmt);
+
+/**
  * alloc_io_pgtable_ops() - Allocate a page table allocator for use by an IOMMU.
  *
  * @fmt:    The page table format.
@@ -233,23 +264,4 @@ io_pgtable_tlb_add_page(struct io_pgtable *iop,
 		iop->cfg.tlb->tlb_add_page(gather, iova, granule, iop->cookie);
 }
 
-/**
- * struct io_pgtable_init_fns - Alloc/free a set of page tables for a
- *                              particular format.
- *
- * @alloc: Allocate a set of page tables described by cfg.
- * @free:  Free the page tables associated with iop.
- */
-struct io_pgtable_init_fns {
-	struct io_pgtable *(*alloc)(struct io_pgtable_cfg *cfg, void *cookie);
-	void (*free)(struct io_pgtable *iop);
-};
-
-extern struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s1_init_fns;
-extern struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s2_init_fns;
-extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns;
-extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns;
-extern struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns;
-extern struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns;
-
 #endif /* __IO_PGTABLE_H */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
