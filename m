Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A70C47098
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 16:45:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1132613B1
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 16:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1132613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D07788426E;
	Thu,  3 Jun 2021 16:45:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Ayas9rvUoS7; Thu,  3 Jun 2021 16:45:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id E221084267;
	Thu,  3 Jun 2021 16:45:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEA74C000D;
	Thu,  3 Jun 2021 16:45:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F6B2C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 16:45:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1A82D40550
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 16:45:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kiNzIxF2EjOj for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 16:45:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AF8B740553
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 16:45:09 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id i13so7889415edb.9
 for <iommu@lists.linux-foundation.org>; Thu, 03 Jun 2021 09:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+HPQE7Wu/U0PWuANbUnRRMUxt8XYMXfvMeqtWgsxX2A=;
 b=DWF1ND1JoYhbiNCUKUNApwzdJwbAPEEjKJCscMNFabqzF0tNNXz7EcVUvM1Tu4YRBn
 2yvREMF0gPfCEqXIj3VITXosJ7x4mqAfHFUIF4saEgKMCDPuTr4luvSAw3NLt3uyaCsD
 zSRt6d1AAvqam5MRDt0PVUfvuRkUshgG8UNWbtq4RY5Qjud+PKV7ncvC5MlLcoEC+vOQ
 kBNatm2qVH9LKug8VOBfojI1yfvtyfwCl6KP/HwEx0pUWmr3pv8hgyQHVWmM7Wzf2HY4
 Ccko9vjgsRbuqVaw+GwvlJmG1rKA3p2TNiI5MVsk9rovNCzTmn6PxEFmpYknh9BQKKIj
 Nb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+HPQE7Wu/U0PWuANbUnRRMUxt8XYMXfvMeqtWgsxX2A=;
 b=KaK1qbFh2a1qUdPfxDHg3L8Shw/AXx0MNOXl2Tlf16qcfwHvyIZ7acYlvqLg43EviU
 Em+UeKWG+1MWnocwLKYdVq1a6K0/Cg5fvvc7myBKCs7dOjIMKlKdQqkofT9Bc2yUqi35
 K64BpnPslxW/eai/shC0WVmMi9fIxdL8/AGzfXShwOOJPFVtFhfGy+px8+7Uh4xeF4Bl
 frBb5O37bKdV8ReC88oThn8HbXF2I/1jXyh7pkY0G0pO7JSpPWJo+U1PsktlnRZBNgJf
 7H8jiFivV/c4jKmgGn2Z3q1w17RCILg6P2rR1FHyR+USanEaK2sX5wg6hkihGkrBL7Ib
 gwyQ==
X-Gm-Message-State: AOAM531rk1SVEjYp+POzXFdZpINCjC/MxnIMHbWC2B1tssfjeq4PVTN1
 Mk6ul0VqQcS4RS6/n1mNe+8=
X-Google-Smtp-Source: ABdhPJyAuiwn93zwB01paf3aYl4lIS4qBDAzg3kRCeqosdXGXGE/rGMikrDkYrapoNqHcGJ3U/ZmSA==
X-Received: by 2002:aa7:cdd8:: with SMTP id h24mr407362edw.276.1622738707944; 
 Thu, 03 Jun 2021 09:45:07 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id i15sm1743989ejk.30.2021.06.03.09.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jun 2021 09:45:06 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v3 4/9] iommu/arm-smmu: tegra: Detect number of instances at
 runtime
Date: Thu,  3 Jun 2021 18:46:27 +0200
Message-Id: <20210603164632.1000458-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603164632.1000458-1-thierry.reding@gmail.com>
References: <20210603164632.1000458-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Thierry Reding <treding@nvidia.com>

Parse the reg property in device tree and detect the number of instances
represented by a device tree node. This is subsequently needed in order
to support single-instance SMMUs with the Tegra implementation because
additional programming is needed to properly configure the SID override
registers in the memory controller.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- move .probe_finalize initialization to later patch

Changes in v2:
- provide a separate implementation to simplify single instances

 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c | 57 ++++++++++++++------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
index 29117444e5a0..23889090eb01 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
@@ -20,13 +20,19 @@
  * The third instance usage is through standard arm-smmu driver itself and
  * is out of scope of this implementation.
  */
-#define NUM_SMMU_INSTANCES 2
+#define MAX_SMMU_INSTANCES 2
 
 struct nvidia_smmu {
-	struct arm_smmu_device	smmu;
-	void __iomem		*bases[NUM_SMMU_INSTANCES];
+	struct arm_smmu_device smmu;
+	void __iomem *bases[MAX_SMMU_INSTANCES];
+	unsigned int num_instances;
 };
 
+static inline struct nvidia_smmu *to_nvidia_smmu(struct arm_smmu_device *smmu)
+{
+	return container_of(smmu, struct nvidia_smmu, smmu);
+}
+
 static inline void __iomem *nvidia_smmu_page(struct arm_smmu_device *smmu,
 					     unsigned int inst, int page)
 {
@@ -47,9 +53,10 @@ static u32 nvidia_smmu_read_reg(struct arm_smmu_device *smmu,
 static void nvidia_smmu_write_reg(struct arm_smmu_device *smmu,
 				  int page, int offset, u32 val)
 {
+	struct nvidia_smmu *nvidia = to_nvidia_smmu(smmu);
 	unsigned int i;
 
-	for (i = 0; i < NUM_SMMU_INSTANCES; i++) {
+	for (i = 0; i < nvidia->num_instances; i++) {
 		void __iomem *reg = nvidia_smmu_page(smmu, i, page) + offset;
 
 		writel_relaxed(val, reg);
@@ -67,9 +74,10 @@ static u64 nvidia_smmu_read_reg64(struct arm_smmu_device *smmu,
 static void nvidia_smmu_write_reg64(struct arm_smmu_device *smmu,
 				    int page, int offset, u64 val)
 {
+	struct nvidia_smmu *nvidia = to_nvidia_smmu(smmu);
 	unsigned int i;
 
-	for (i = 0; i < NUM_SMMU_INSTANCES; i++) {
+	for (i = 0; i < nvidia->num_instances; i++) {
 		void __iomem *reg = nvidia_smmu_page(smmu, i, page) + offset;
 
 		writeq_relaxed(val, reg);
@@ -79,6 +87,7 @@ static void nvidia_smmu_write_reg64(struct arm_smmu_device *smmu,
 static void nvidia_smmu_tlb_sync(struct arm_smmu_device *smmu, int page,
 				 int sync, int status)
 {
+	struct nvidia_smmu *nvidia = to_nvidia_smmu(smmu);
 	unsigned int delay;
 
 	arm_smmu_writel(smmu, page, sync, 0);
@@ -90,7 +99,7 @@ static void nvidia_smmu_tlb_sync(struct arm_smmu_device *smmu, int page,
 			u32 val = 0;
 			unsigned int i;
 
-			for (i = 0; i < NUM_SMMU_INSTANCES; i++) {
+			for (i = 0; i < nvidia->num_instances; i++) {
 				void __iomem *reg;
 
 				reg = nvidia_smmu_page(smmu, i, page) + status;
@@ -112,9 +121,10 @@ static void nvidia_smmu_tlb_sync(struct arm_smmu_device *smmu, int page,
 
 static int nvidia_smmu_reset(struct arm_smmu_device *smmu)
 {
+	struct nvidia_smmu *nvidia = to_nvidia_smmu(smmu);
 	unsigned int i;
 
-	for (i = 0; i < NUM_SMMU_INSTANCES; i++) {
+	for (i = 0; i < nvidia->num_instances; i++) {
 		u32 val;
 		void __iomem *reg = nvidia_smmu_page(smmu, i, ARM_SMMU_GR0) +
 				    ARM_SMMU_GR0_sGFSR;
@@ -157,8 +167,9 @@ static irqreturn_t nvidia_smmu_global_fault(int irq, void *dev)
 	unsigned int inst;
 	irqreturn_t ret = IRQ_NONE;
 	struct arm_smmu_device *smmu = dev;
+	struct nvidia_smmu *nvidia = to_nvidia_smmu(smmu);
 
-	for (inst = 0; inst < NUM_SMMU_INSTANCES; inst++) {
+	for (inst = 0; inst < nvidia->num_instances; inst++) {
 		irqreturn_t irq_ret;
 
 		irq_ret = nvidia_smmu_global_fault_inst(irq, smmu, inst);
@@ -202,11 +213,13 @@ static irqreturn_t nvidia_smmu_context_fault(int irq, void *dev)
 	struct arm_smmu_device *smmu;
 	struct iommu_domain *domain = dev;
 	struct arm_smmu_domain *smmu_domain;
+	struct nvidia_smmu *nvidia;
 
 	smmu_domain = container_of(domain, struct arm_smmu_domain, domain);
 	smmu = smmu_domain->smmu;
+	nvidia = to_nvidia_smmu(smmu);
 
-	for (inst = 0; inst < NUM_SMMU_INSTANCES; inst++) {
+	for (inst = 0; inst < nvidia->num_instances; inst++) {
 		irqreturn_t irq_ret;
 
 		/*
@@ -235,12 +248,16 @@ static const struct arm_smmu_impl nvidia_smmu_impl = {
 	.context_fault = nvidia_smmu_context_fault,
 };
 
+static const struct arm_smmu_impl nvidia_smmu_single_impl = {
+};
+
 struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
 {
 	struct resource *res;
 	struct device *dev = smmu->dev;
 	struct nvidia_smmu *nvidia_smmu;
 	struct platform_device *pdev = to_platform_device(dev);
+	unsigned int i;
 
 	nvidia_smmu = devm_krealloc(dev, smmu, sizeof(*nvidia_smmu), GFP_KERNEL);
 	if (!nvidia_smmu)
@@ -248,16 +265,24 @@ struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
 
 	/* Instance 0 is ioremapped by arm-smmu.c. */
 	nvidia_smmu->bases[0] = smmu->base;
+	nvidia_smmu->num_instances++;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res)
-		return ERR_PTR(-ENODEV);
+	for (i = 1; i < MAX_SMMU_INSTANCES; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (!res)
+			break;
 
-	nvidia_smmu->bases[1] = devm_ioremap_resource(dev, res);
-	if (IS_ERR(nvidia_smmu->bases[1]))
-		return ERR_CAST(nvidia_smmu->bases[1]);
+		nvidia_smmu->bases[i] = devm_ioremap_resource(dev, res);
+		if (IS_ERR(nvidia_smmu->bases[i]))
+			return ERR_CAST(nvidia_smmu->bases[i]);
+
+		nvidia_smmu->num_instances++;
+	}
 
-	nvidia_smmu->smmu.impl = &nvidia_smmu_impl;
+	if (nvidia_smmu->num_instances == 1)
+		nvidia_smmu->smmu.impl = &nvidia_smmu_single_impl;
+	else
+		nvidia_smmu->smmu.impl = &nvidia_smmu_impl;
 
 	return &nvidia_smmu->smmu;
 }
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
