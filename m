Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6B4C433E0
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 08:05:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20432206CD
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 08:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPhYRScc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20432206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D388D86D23;
	Mon,  6 Jul 2020 08:05:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vmwEtUmkOvaW; Mon,  6 Jul 2020 08:05:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0759286D2A;
	Mon,  6 Jul 2020 08:05:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE386C1818;
	Mon,  6 Jul 2020 08:05:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B982C0733
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 12:28:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 861E120BF9
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 12:28:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z4FIkmC86etk for <iommu@lists.linux-foundation.org>;
 Sat,  4 Jul 2020 12:28:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 932E020415
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 12:28:23 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id by13so20331749edb.11
 for <iommu@lists.linux-foundation.org>; Sat, 04 Jul 2020 05:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i+PMOq5Al6StIBzFo1wcc3naFIWV4JdGXcD4ZNngMYA=;
 b=hPhYRSccHjEE/ShMqbPzxgOdCzDHXjA4b8SawVRhXNUUP+zf2Zwez4er/xTE1Ca5uj
 mcfmRVtdHXqBvDsIXbwijSfi+FBiunNeXv8qhhPAbCPrXliUSZiDksu6/uj8i+7X9A9k
 Qs0zcFPfSbKd9Te0JqUwW0M6A7p4KzfnrZjLnIalinkY2YDklLZst1m31vG+rxMTeuV4
 Wj3yTiwBtFzM15NLWPa7JB0yeiAwRefq0LCBA8K9fDP3oiFoDW99RCzwMQ0kGw8rI+fe
 kHsdHKBlGScRmD4f9yRo3O9gGuVemAbp1MrOdMKgtoWmxRKUDkLycxUZ4BSwznkz/Fbk
 zuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i+PMOq5Al6StIBzFo1wcc3naFIWV4JdGXcD4ZNngMYA=;
 b=flc0OMjIdQgH4U5ZY7VDFl4hlqgdYpI0Vgp1JjXGFlHX0sYNrcdxJEqnjeXgHL3ypv
 M1X/FdCN7JnGSeXcUbJUNV3L3B+8Tl+KmhtpnlrpucY22LMCvAbf8sPOnwnB1VRwtAMk
 nftUEQwteWAB05d6DeuUFfkaSBwXSyMI72Ei9zP3YUwrxbJaohvYSxm1jToD2UhnfL7J
 J0CNfqqYoZDAgOQA6HHd+lpCWrgptz7ICYGgxoYWzaizxLm0ZCsJ3xvYG4Dn1gIxFV/M
 DPYsU/eyCM2DxaVWNuHdPeHIgEZrVHAiJ0Rg+UaS1MEi13xaXqfLBZ3wifvYgxn4NTxI
 SXiw==
X-Gm-Message-State: AOAM532xQYBIe84VGDaGERMPbY20dkERNrUvDpFY36YLD+PQ4DI18DmE
 EIIYLKQUPo8iRVI+AORoH3Q=
X-Google-Smtp-Source: ABdhPJxNoGpPWfHtk5GtUWgId+YmOEKnhvbIaHUdtxzXA+oC0iIVpg7GUe70uTMDbAHPmrfK5PCATw==
X-Received: by 2002:a05:6402:1778:: with SMTP id
 da24mr33863987edb.126.1593865701817; 
 Sat, 04 Jul 2020 05:28:21 -0700 (PDT)
Received: from localhost.localdomain (abab73.neoplus.adsl.tpnet.pl.
 [83.6.165.73])
 by smtp.googlemail.com with ESMTPSA id be2sm15861831edb.92.2020.07.04.05.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 05:28:21 -0700 (PDT)
From: Konrad Dybcio <konradybcio@gmail.com>
To: skrzynka@konradybcio.pl
Subject: [PATCH 1/1] iommu/arm-smmu: Implement qcom,skip-init
Date: Sat,  4 Jul 2020 14:28:09 +0200
Message-Id: <20200704122809.73794-1-konradybcio@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 06 Jul 2020 08:05:12 +0000
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 Konrad Dybcio <konradybcio@gmail.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
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

This adds the downstream property required to support
SMMUs on SDM630 and other platforms (the need for it
most likely depends on firmware configuration).

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 .../devicetree/bindings/iommu/arm,smmu.yaml       | 10 ++++++++++
 drivers/iommu/arm-smmu.c                          | 15 +++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index d7ceb4c34423..9abd6d41a32c 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -102,6 +102,16 @@ properties:
       access to SMMU configuration registers. In this case non-secure aliases of
       secure registers have to be used during SMMU configuration.
 
+  qcom,skip-init:
+    description: |
+      Disable resetting configuration for all context banks
+      during device reset.  This is useful for targets where
+      some context banks are dedicated to other execution
+      environments outside of Linux and those other EEs are
+      programming their own stream match tables, SCTLR, etc.
+      Without setting this option we will trample on their
+      configuration.
+
   stream-match-mask:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 243bc4cb2705..a5c623d4caf9 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1655,13 +1655,16 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	 * Reset stream mapping groups: Initial values mark all SMRn as
 	 * invalid and all S2CRn as bypass unless overridden.
 	 */
-	for (i = 0; i < smmu->num_mapping_groups; ++i)
-		arm_smmu_write_sme(smmu, i);
 
-	/* Make sure all context banks are disabled and clear CB_FSR  */
-	for (i = 0; i < smmu->num_context_banks; ++i) {
-		arm_smmu_write_context_bank(smmu, i);
-		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_FSR, ARM_SMMU_FSR_FAULT);
+	if (!of_find_property(smmu->dev->of_node, "qcom,skip-init", NULL)) {
+		for (i = 0; i < smmu->num_mapping_groups; ++i)
+			arm_smmu_write_sme(smmu, i);
+
+		/* Make sure all context banks are disabled and clear CB_FSR  */
+		for (i = 0; i < smmu->num_context_banks; ++i) {
+			arm_smmu_write_context_bank(smmu, i);
+			arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_FSR, ARM_SMMU_FSR_FAULT);
+		}
 	}
 
 	/* Invalidate the TLB, just in case */
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
