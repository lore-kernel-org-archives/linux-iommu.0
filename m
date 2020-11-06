Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE94C2D0A3
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 15:53:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 659EB22202
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 15:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hjfmsyRe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659EB22202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0ABC186A46;
	Fri,  6 Nov 2020 15:53:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D8rjliWKxk2Z; Fri,  6 Nov 2020 15:53:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C10CA86A4E;
	Fri,  6 Nov 2020 15:53:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA286C1AD6;
	Fri,  6 Nov 2020 15:53:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 130DFC1AD4
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 15:53:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 01E4620483
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 15:53:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W+PQOJBtO-xY for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 15:53:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by silver.osuosl.org (Postfix) with ESMTPS id EDA7820386
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 15:53:19 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id s25so2584420ejy.6
 for <iommu@lists.linux-foundation.org>; Fri, 06 Nov 2020 07:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aCmYESCWdUDIsMdymeogP1/5qm+ZjvKp4ksn7abIdX8=;
 b=hjfmsyReTdoMJGEHLf0pSfWCp8PwYnoLg7ik/pRJYOYwIVgvWMJto442xC9XSAJanx
 TrzMUXvkjDhGlKWu/tmstaA8zIJrGMAXTeFfcAK21y1+8IX5J2vclrn5TXz3/OrISp0g
 b7Ww68l4WaACGkzbPx49w0aTdKTOTqUPfe7aXht5dbf0nqfeGnr/n5nXJsuV2WCgq0YD
 kLvl4E43hdc1FYQ7L7GdeeaohJNO8VMnkhvsHxEiFztHEybT+jObRYuU3n9UIUFXK2tZ
 zUrYWqvXe5Rz0ge5w62GTXs/63Kfl4cc33MHw0mrn8otgsmYDXw4NR2Tlh9EEedZ5VGC
 CAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aCmYESCWdUDIsMdymeogP1/5qm+ZjvKp4ksn7abIdX8=;
 b=PtzYREAeB2k/pJ5jPgF/4YBbNOEE+2HJnfGw/Yjv6XogCxEYBROgDUQNk1Rlm7/lKW
 G/Zd1WOKpNnEZwJTamtrdnzmk/bprnO+wPetR7RzMG251Op2teGaX75JGwiolt7+fI0U
 9MIgBj3KSlAib2mAxESinRrw3VadvHyIVOKMj2qBVL6B+X2aKpDSq7sPaIF4FO2aG5tH
 nomgVAKZr/PoP+EEt9GxLMBnVviWmAQp6uAk4noAbDBgRa/jYwajyMkx42V7aM83TpDw
 S0KxreUh9LEzsHxPUm9Zx9Nbnk/DKoQ6MqujMcoY9b3zzsD81s7wNWOLm0BG6adAmg5O
 MXLw==
X-Gm-Message-State: AOAM5328z4lqloU3gU6CGz/l1dHJ0QjWL8SVltpKvnDpm8W75pspME68
 l+XWFKptft3+SO8orUhyCJxzZGnEuE8ukA==
X-Google-Smtp-Source: ABdhPJz44VKBog74/PF6QWsQ+kOgaAhJKxdTsStVxT++f9UpVxqRwTSl4aGcKSQ7CQw1z/o9KcemvQ==
X-Received: by 2002:a17:906:6545:: with SMTP id
 u5mr2631563ejn.346.1604677998053; 
 Fri, 06 Nov 2020 07:53:18 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id lz27sm1249262ejb.39.2020.11.06.07.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 07:53:17 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH RESEND v10 4/4] iommu/arm-smmu-v3: Hook up ATC invalidation to
 mm ops
Date: Fri,  6 Nov 2020 16:50:50 +0100
Message-Id: <20201106155048.997886-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201106155048.997886-1-jean-philippe@linaro.org>
References: <20201106155048.997886-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, will@kernel.org,
 zhangfei.gao@linaro.org, robin.murphy@arm.com
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

The invalidate_range() notifier is called for any change to the address
space. Perform the required ATC invalidations.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h    |  2 ++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    | 16 +++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c    | 18 ++++++++++++++++--
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index e03ca01e0908..96c2e9565e00 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -695,6 +695,8 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 			    struct arm_smmu_ctx_desc *cd);
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
 bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
+int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
+			    unsigned long iova, size_t size);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 4d03481289ff..e13b092e6004 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -177,6 +177,16 @@ static void arm_smmu_free_shared_cd(struct arm_smmu_ctx_desc *cd)
 	}
 }
 
+static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
+					 struct mm_struct *mm,
+					 unsigned long start, unsigned long end)
+{
+	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
+
+	arm_smmu_atc_inv_domain(smmu_mn->domain, mm->pasid, start,
+				end - start + 1);
+}
+
 static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
@@ -195,6 +205,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, &quiet_cd);
 
 	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
+	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
 
 	smmu_mn->cleared = true;
 	mutex_unlock(&sva_lock);
@@ -206,6 +217,7 @@ static void arm_smmu_mmu_notifier_free(struct mmu_notifier *mn)
 }
 
 static struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
+	.invalidate_range	= arm_smmu_mm_invalidate_range,
 	.release		= arm_smmu_mm_release,
 	.free_notifier		= arm_smmu_mmu_notifier_free,
 };
@@ -278,8 +290,10 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	 * If we went through clear(), we've already invalidated, and no
 	 * new TLB entry can have been formed.
 	 */
-	if (!smmu_mn->cleared)
+	if (!smmu_mn->cleared) {
 		arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
+		arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
+	}
 
 	/* Frees smmu_mn */
 	mmu_notifier_put(&smmu_mn->mn);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 769845c34503..73c26e68e12e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1524,6 +1524,20 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 	size_t inval_grain_shift = 12;
 	unsigned long page_start, page_end;
 
+	/*
+	 * ATS and PASID:
+	 *
+	 * If substream_valid is clear, the PCIe TLP is sent without a PASID
+	 * prefix. In that case all ATC entries within the address range are
+	 * invalidated, including those that were requested with a PASID! There
+	 * is no way to invalidate only entries without PASID.
+	 *
+	 * When using STRTAB_STE_1_S1DSS_SSID0 (reserving CD 0 for non-PASID
+	 * traffic), translation requests without PASID create ATC entries
+	 * without PASID, which must be invalidated with substream_valid clear.
+	 * This has the unpleasant side-effect of invalidating all PASID-tagged
+	 * ATC entries within the address range.
+	 */
 	*cmd = (struct arm_smmu_cmdq_ent) {
 		.opcode			= CMDQ_OP_ATC_INV,
 		.substream_valid	= !!ssid,
@@ -1582,8 +1596,8 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 	return arm_smmu_cmdq_issue_sync(master->smmu);
 }
 
-static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
-				   int ssid, unsigned long iova, size_t size)
+int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
+			    unsigned long iova, size_t size)
 {
 	int i;
 	unsigned long flags;
-- 
2.29.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
