Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3B2C433B4
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 17:25:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D39D2613C0
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 17:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39D2613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B45460AC4;
	Tue, 20 Apr 2021 17:25:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eJceqYb-zcTz; Tue, 20 Apr 2021 17:25:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 522C260ACA;
	Tue, 20 Apr 2021 17:25:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31789C000E;
	Tue, 20 Apr 2021 17:25:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 540F8C0020
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 36720405CC
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U4xKBJ98QQQs for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 17:25:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B8B6E405C8
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:46 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id mh2so37911333ejb.8
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 10:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fK4kfWRtqlQ6vIoyRrov57PspjW7vhkuyE8BA4mAeb8=;
 b=WhL1BPNeZ5a2IX9j90mRpN+imU32bNQi4SzreJr9Wg5mQk8JTllq0LdVMUkoN6kS5A
 vDJzGPvH/mFNaKSGROA9dGN2hAH5lgk9YCwUUWsD9FQh5b8iLR9XLSHdMrR+MgyQB9Jh
 8lHqtmk4UbzklAZ4VKghHdPCdBowFTXCA2E53dPsAE4EcetOI7AqZ2CEyimR7TNs4LZt
 lTQfh9x86lLWAOmsf33Nt4biMSdvjL7R/yDBjbdnoSvqUORSbja521klVVFUV1lgXlCY
 Cp5pB1ol77HfSVwr5wPt1EUfHrrV0yD/aq+vzAmE5S3nP8sestMEspJgAEBQBYMY/sq8
 Ztbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fK4kfWRtqlQ6vIoyRrov57PspjW7vhkuyE8BA4mAeb8=;
 b=ADn/yneFO+ENdE+b90DYZAYKlqlS2a05DJzV+ofC9ozXJsD4BXH46Y71aDNv9mSXTJ
 z5qheLnyCHsa3XjUeH7J0ocRu+1fUa8utZ7F0j3egPx6hGTmuMvceAzJvIbVAAA/8EoK
 oBdjEPGeY6jg7wVvdBNvXWnSB3Wq4wd4iFU8BFklUBHhczre8F4NRAD3P2TzU6OvMTn8
 EGnH9ilgKOw+C5zbGqddHyP6J9rN5QnXv3sO2xFE0A0FsDgDHgwS9y1oZVb0VK2nYYLY
 2kCiG4vQ7TzKkI/vB9KEgvs708mpy0A+spemvfYizn8rPu1AXX/omspl1pDZux3CMcri
 FmhQ==
X-Gm-Message-State: AOAM533Qu8Sk98ww3FrQY81yOzxVWvQ6jztuBmg+PybkWx5ia+gb7bCs
 ROBTAP0QFWV0kpAiVm+/+LU=
X-Google-Smtp-Source: ABdhPJy0IRuIdzcHJGqqBHme2I09VtTa+12s85CdaDkVuGUyC0rSBvQ77xOu2JZezYZ6RqULbBxobQ==
X-Received: by 2002:a17:906:a0d4:: with SMTP id
 bh20mr28752997ejb.348.1618939545017; 
 Tue, 20 Apr 2021 10:25:45 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id b22sm16377719edv.96.2021.04.20.10.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Apr 2021 10:25:44 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 04/10] iommu/arm-smmu: tegra: Detect number of instances at
 runtime
Date: Tue, 20 Apr 2021 19:26:13 +0200
Message-Id: <20210420172619.3782831-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420172619.3782831-1-thierry.reding@gmail.com>
References: <20210420172619.3782831-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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
Changes in v2:
- provide a separate implementation to simplify single instances
---
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c | 58 ++++++++++++++------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
index 29117444e5a0..0e547b29143d 100644
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
@@ -235,12 +248,17 @@ static const struct arm_smmu_impl nvidia_smmu_impl = {
 	.context_fault = nvidia_smmu_context_fault,
 };
 
+static const struct arm_smmu_impl nvidia_smmu_single_impl = {
+	.probe_finalize = nvidia_smmu_probe_finalize,
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
@@ -248,16 +266,24 @@ struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
 
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
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
