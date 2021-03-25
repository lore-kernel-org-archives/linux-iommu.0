Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCAFC433C1
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 13:03:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7901561A17
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 13:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7901561A17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50A6184A0B;
	Thu, 25 Mar 2021 13:03:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dtaNQ-y2m7Hj; Thu, 25 Mar 2021 13:03:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1BA4284A0F;
	Thu, 25 Mar 2021 13:03:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0351C000D;
	Thu, 25 Mar 2021 13:03:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92B40C000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 13:03:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 74C2C84A10
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 13:03:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jh6caGnL4Kvg for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 13:03:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 76B6984A0F
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 13:03:38 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 d8-20020a1c1d080000b029010f15546281so3050658wmd.4
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 06:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t7X2GpeVAQTwaWmJIXgCOprGMJUs+fHxOldIInNR7C4=;
 b=ditqyyApwpDUxItLfBmACbDfKsq2ugMGl3n2IuO9zqv+6bJ1L9hnPv6Fjqck4JK8uH
 pc13cPz8pqL18QiPc0/9G2EfkpafjXhCJfENVv+GBpvM6LossmsdOe1V8tgiktAxTuym
 erdCO/bZLCnVXqil+KZzVWJfx1RXbqowbOTHW9YQUCs3RjMglbAJE/IbYvCsZd46kzH4
 Cl/gJrJG5S80T/rAjjCMIkxeWRo6aEyLuzKcneT9HGLOln0tWSQKl5NXcGo0Ij6T345o
 fJ0KGLroJ4T+k4PCrJ3q4CotsaInUEzuYD9hTVejuWeYq0MTxhGINmSWmSL9EijHP5ZL
 q3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t7X2GpeVAQTwaWmJIXgCOprGMJUs+fHxOldIInNR7C4=;
 b=kGgZNliRZJVwuNG/J3oSsLrF8SjGPqWbW5inOfgjQSUltwxwr5rvA5Hl2y/v8T6N0j
 /92Wghq92d1NCSCempE4sTDUyRV/URyJsFnO5tz8ZP08ZV062fT5ES1VAGOBynMlw6zq
 oiOTileDtlCeI7+0fLBpaRtcqYydqcfwBMYQRojU0JeT7thOuY2jgMl0yXlmjE1mihPh
 kNtLeCZ5xbptrjf6YRtG4ZamxN2jxb3E28coJ4njjVxBRHRMOkN65yf4T9F7v2GiW1qV
 fSdVlpPYMVknH5hHQIosz6j9oLEsInb1dbK4CIVZKEQhVy0uN335jT1hIlfcfL0J95yE
 NvKA==
X-Gm-Message-State: AOAM532PcX+wC0I2ikWbhlnpnrSUTSzBYkogENM8p5/rolbXd/SCz5Gz
 88BniObh2pHvYAjwS+p0ZKE=
X-Google-Smtp-Source: ABdhPJykjubPhrd+aJHeZrbaADCVdsfZrEwKLL9/dZC5ZHubIgnBOHVOQai7Uptd7XQ/CH85srzGrA==
X-Received: by 2002:a1c:3d8a:: with SMTP id k132mr7759885wma.71.1616677415510; 
 Thu, 25 Mar 2021 06:03:35 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id o7sm7803676wrs.16.2021.03.25.06.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 06:03:34 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 5/9] iommu/arm-smmu: tegra: Detect number of instances at
 runtime
Date: Thu, 25 Mar 2021 14:03:28 +0100
Message-Id: <20210325130332.778208-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325130332.778208-1-thierry.reding@gmail.com>
References: <20210325130332.778208-1-thierry.reding@gmail.com>
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
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c | 49 ++++++++++++++------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
index 29117444e5a0..5b1170b028f0 100644
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
@@ -241,6 +254,7 @@ struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
 	struct device *dev = smmu->dev;
 	struct nvidia_smmu *nvidia_smmu;
 	struct platform_device *pdev = to_platform_device(dev);
+	unsigned int i;
 
 	nvidia_smmu = devm_krealloc(dev, smmu, sizeof(*nvidia_smmu), GFP_KERNEL);
 	if (!nvidia_smmu)
@@ -248,14 +262,19 @@ struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
 
 	/* Instance 0 is ioremapped by arm-smmu.c. */
 	nvidia_smmu->bases[0] = smmu->base;
+	nvidia_smmu->num_instances++;
+
+	for (i = 1; i < MAX_SMMU_INSTANCES; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (!res)
+			break;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res)
-		return ERR_PTR(-ENODEV);
+		nvidia_smmu->bases[i] = devm_ioremap_resource(dev, res);
+		if (IS_ERR(nvidia_smmu->bases[i]))
+			return ERR_CAST(nvidia_smmu->bases[i]);
 
-	nvidia_smmu->bases[1] = devm_ioremap_resource(dev, res);
-	if (IS_ERR(nvidia_smmu->bases[1]))
-		return ERR_CAST(nvidia_smmu->bases[1]);
+		nvidia_smmu->num_instances++;
+	}
 
 	nvidia_smmu->smmu.impl = &nvidia_smmu_impl;
 
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
