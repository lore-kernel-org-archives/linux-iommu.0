Return-Path: <SRS0=HAoA=WF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B6AC433FF
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 17:09:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20B3C20820
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 17:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B3C20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0F48CE04;
	Fri,  9 Aug 2019 17:08:34 +0000 (UTC)
Received: from smtp2.linuxfoundation.org (smtp2.linux-foundation.org
	[172.17.192.36])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C6B13CA5
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 17:08:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp2.linuxfoundation.org (Postfix) with ESMTP id EB3C01DD19
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 17:08:30 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 718861684;
	Fri,  9 Aug 2019 10:08:30 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
	[10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3454F3F575; 
	Fri,  9 Aug 2019 10:08:29 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Subject: [PATCH 12/15] iommu/arm-smmu: Move Secure access quirk to
	implementation
Date: Fri,  9 Aug 2019 18:07:49 +0100
Message-Id: <6c16c65e43bf583d082c8b29d6dd7dbb3dc642bc.1565369764.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <cover.1565369764.git.robin.murphy@arm.com>
References: <cover.1565369764.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org,
	gregory.clement@bootlin.com, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Move detection of the Secure access quirk to its new home, trimming it
down in the process - time has proven that boolean DT flags are neither
ideal nor necessarily sufficient, so it's highly unlikely we'll ever add
more, let alone enough to justify the frankly overengineered parsing
machinery.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu-impl.c | 44 +++++++++++++++++
 drivers/iommu/arm-smmu.c      | 89 -----------------------------------
 drivers/iommu/arm-smmu.h      | 64 ++++++++++++++++++++++++-
 3 files changed, 106 insertions(+), 91 deletions(-)

diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
index efeb6d78da17..f8b8895e1bbe 100644
--- a/drivers/iommu/arm-smmu-impl.c
+++ b/drivers/iommu/arm-smmu-impl.c
@@ -4,10 +4,54 @@
 
 #define pr_fmt(fmt) "arm-smmu: " fmt
 
+#include <linux/of.h>
+
 #include "arm-smmu.h"
 
 
+static int arm_smmu_gr0_ns(int offset)
+{
+	switch(offset) {
+	case ARM_SMMU_GR0_sCR0:
+	case ARM_SMMU_GR0_sACR:
+	case ARM_SMMU_GR0_sGFSR:
+	case ARM_SMMU_GR0_sGFSYNR0:
+	case ARM_SMMU_GR0_sGFSYNR1:
+	case ARM_SMMU_GR0_sGFSYNR2:
+		return offset + 0x400;
+	default:
+		return offset;
+	}
+}
+
+static u32 arm_smmu_read_ns(struct arm_smmu_device *smmu, int page,
+			    int offset)
+{
+	if (page == 0)
+		offset = arm_smmu_gr0_ns(offset);
+	return readl_relaxed(arm_smmu_page(smmu, page) + offset);
+}
+
+static void arm_smmu_write_ns(struct arm_smmu_device *smmu, int page,
+			      int offset, u32 val)
+{
+	if (page == 0)
+		offset = arm_smmu_gr0_ns(offset);
+	writel_relaxed(val, arm_smmu_page(smmu, page) + offset);
+}
+
+/* Since we don't care for sGFAR, we can do without 64-bit accessors */
+const struct arm_smmu_impl calxeda_impl = {
+	.read_reg = arm_smmu_read_ns,
+	.write_reg = arm_smmu_write_ns,
+};
+
+
 struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 {
+	if (of_property_read_bool(smmu->dev->of_node,
+				  "calxeda,smmu-secure-config-access"))
+		smmu->impl = &calxeda_impl;
+
 	return smmu;
 }
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 86e11141a0bb..03159a1da4c9 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -155,83 +155,10 @@ struct arm_smmu_domain {
 	struct iommu_domain		domain;
 };
 
-static int arm_smmu_gr0_ns(int offset)
-{
-	switch(offset) {
-	case ARM_SMMU_GR0_sCR0:
-	case ARM_SMMU_GR0_sACR:
-	case ARM_SMMU_GR0_sGFSR:
-	case ARM_SMMU_GR0_sGFSYNR0:
-	case ARM_SMMU_GR0_sGFSYNR1:
-	case ARM_SMMU_GR0_sGFSYNR2:
-		return offset + 0x400;
-	default:
-		return offset;
-	}
-}
-
-static void __iomem *arm_smmu_page(struct arm_smmu_device *smmu, int n)
-{
-	return smmu->base + (n << smmu->pgshift);
-}
-
-static u32 arm_smmu_readl(struct arm_smmu_device *smmu, int page, int offset)
-{
-	if ((smmu->options & ARM_SMMU_OPT_SECURE_CFG_ACCESS) && page == 0)
-		offset = arm_smmu_gr0_ns(offset);
-
-	return readl_relaxed(arm_smmu_page(smmu, page) + offset);
-}
-
-static void arm_smmu_writel(struct arm_smmu_device *smmu, int page, int offset,
-			    u32 val)
-{
-	if ((smmu->options & ARM_SMMU_OPT_SECURE_CFG_ACCESS) && page == 0)
-		offset = arm_smmu_gr0_ns(offset);
-
-	writel_relaxed(val, arm_smmu_page(smmu, page) + offset);
-}
-
-static u64 arm_smmu_readq(struct arm_smmu_device *smmu, int page, int offset)
-{
-	return readq_relaxed(arm_smmu_page(smmu, page) + offset);
-}
-
-static void arm_smmu_writeq(struct arm_smmu_device *smmu, int page, int offset,
-			    u64 val)
-{
-	writeq_relaxed(val, arm_smmu_page(smmu, page) + offset);
-}
-
-#define arm_smmu_read_gr0(s, r)		arm_smmu_readl((s), 0, (r))
-#define arm_smmu_write_gr0(s, r, v)	arm_smmu_writel((s), 0, (r), (v))
-
-#define arm_smmu_read_gr1(s, r)		arm_smmu_readl((s), 1, (r))
-#define arm_smmu_write_gr1(s, r, v)	arm_smmu_writel((s), 1, (r), (v))
-
-#define arm_smmu_read_cb(s, n, r)				\
-	arm_smmu_readl((s), (s)->cb_base + (n), (r))
-#define arm_smmu_write_cb(s, n, r, v)				\
-	arm_smmu_writel((s), (s)->cb_base + (n), (r), (v))
-#define arm_smmu_read_cb_q(s, n, r)				\
-	arm_smmu_readq((s), (s)->cb_base + (n), (r))
-#define arm_smmu_write_cb_q(s, n, r, v)				\
-	arm_smmu_writeq((s), (s)->cb_base + (n), (r), (v))
-
-struct arm_smmu_option_prop {
-	u32 opt;
-	const char *prop;
-};
-
 static atomic_t cavium_smmu_context_count = ATOMIC_INIT(0);
 
 static bool using_legacy_binding, using_generic_binding;
 
-static struct arm_smmu_option_prop arm_smmu_options[] = {
-	{ ARM_SMMU_OPT_SECURE_CFG_ACCESS, "calxeda,smmu-secure-config-access" },
-	{ 0, NULL},
-};
-
 static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
 {
 	if (pm_runtime_enabled(smmu->dev))
@@ -251,20 +178,6 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 	return container_of(dom, struct arm_smmu_domain, domain);
 }
 
-static void parse_driver_options(struct arm_smmu_device *smmu)
-{
-	int i = 0;
-
-	do {
-		if (of_property_read_bool(smmu->dev->of_node,
-						arm_smmu_options[i].prop)) {
-			smmu->options |= arm_smmu_options[i].opt;
-			dev_notice(smmu->dev, "option %s\n",
-				arm_smmu_options[i].prop);
-		}
-	} while (arm_smmu_options[++i].opt);
-}
-
 static struct device_node *dev_get_dev_node(struct device *dev)
 {
 	if (dev_is_pci(dev)) {
@@ -2083,8 +1996,6 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	smmu->version = data->version;
 	smmu->model = data->model;
 
-	parse_driver_options(smmu);
-
 	legacy_binding = of_find_property(dev->of_node, "mmu-masters", NULL);
 	if (legacy_binding && !using_generic_binding) {
 		if (!using_legacy_binding)
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 460a29075bf8..0485ee7fd4c1 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -242,10 +242,9 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_EXIDS		(1 << 12)
 	u32				features;
 
-#define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)
-	u32				options;
 	enum arm_smmu_arch_version	version;
 	enum arm_smmu_implementation	model;
+	const struct arm_smmu_impl	*impl;
 
 	u32				num_context_banks;
 	u32				num_s2_context_banks;
@@ -281,6 +280,67 @@ struct arm_smmu_device {
 
 
 /* Implementation details, yay! */
+struct arm_smmu_impl {
+	u32 (*read_reg)(struct arm_smmu_device *smmu, int page, int offset);
+	void (*write_reg)(struct arm_smmu_device *smmu, int page, int offset,
+			  u32 val);
+	u64 (*read_reg64)(struct arm_smmu_device *smmu, int page, int offset);
+	void (*write_reg64)(struct arm_smmu_device *smmu, int page, int offset,
+			    u64 val);
+};
+
+static inline void __iomem *arm_smmu_page(struct arm_smmu_device *smmu, int n)
+{
+	return smmu->base + (n << smmu->pgshift);
+}
+
+static inline u32 arm_smmu_readl(struct arm_smmu_device *smmu, int page, int offset)
+{
+	if (smmu->impl && unlikely(smmu->impl->read_reg))
+		return smmu->impl->read_reg(smmu, page, offset);
+	return readl_relaxed(arm_smmu_page(smmu, page) + offset);
+}
+
+static inline void arm_smmu_writel(struct arm_smmu_device *smmu, int page,
+				   int offset, u32 val)
+{
+	if (smmu->impl && unlikely(smmu->impl->write_reg))
+		smmu->impl->write_reg(smmu, page, offset, val);
+	else
+		writel_relaxed(val, arm_smmu_page(smmu, page) + offset);
+}
+
+static inline u64 arm_smmu_readq(struct arm_smmu_device *smmu, int page, int offset)
+{
+	if (smmu->impl && unlikely(smmu->impl->read_reg64))
+		return smmu->impl->read_reg64(smmu, page, offset);
+	return readq_relaxed(arm_smmu_page(smmu, page) + offset);
+}
+
+static inline void arm_smmu_writeq(struct arm_smmu_device *smmu, int page,
+				   int offset, u64 val)
+{
+	if (smmu->impl && unlikely(smmu->impl->write_reg64))
+		smmu->impl->write_reg64(smmu, page, offset, val);
+	else
+		writeq_relaxed(val, arm_smmu_page(smmu, page) + offset);
+}
+
+#define arm_smmu_read_gr0(s, r)		arm_smmu_readl((s), 0, (r))
+#define arm_smmu_write_gr0(s, r, v)	arm_smmu_writel((s), 0, (r), (v))
+
+#define arm_smmu_read_gr1(s, r)		arm_smmu_readl((s), 1, (r))
+#define arm_smmu_write_gr1(s, r, v)	arm_smmu_writel((s), 1, (r), (v))
+
+#define arm_smmu_read_cb(s, n, r)				\
+	arm_smmu_readl((s), (s)->cb_base + (n), (r))
+#define arm_smmu_write_cb(s, n, r, v)				\
+	arm_smmu_writel((s), (s)->cb_base + (n), (r), (v))
+#define arm_smmu_read_cb_q(s, n, r)				\
+	arm_smmu_readq((s), (s)->cb_base + (n), (r))
+#define arm_smmu_write_cb_q(s, n, r, v)			\
+	arm_smmu_writeq((s), (s)->cb_base + (n), (r), (v))
+
 struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu);
 
 #endif /* _ARM_SMMU_H */
-- 
2.21.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
