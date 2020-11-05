Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AECC4741F
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 11:32:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EECD2083B
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 11:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="Tj3+jhEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EECD2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B6877204AF;
	Thu,  5 Nov 2020 11:32:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KMgoOM9eFdZe; Thu,  5 Nov 2020 11:32:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 801FA20361;
	Thu,  5 Nov 2020 11:32:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63DF8C088B;
	Thu,  5 Nov 2020 11:32:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0673DC0889
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 11:32:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E534C85886
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 11:32:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rjHbHl0sY5AB for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 11:32:44 +0000 (UTC)
X-Greylist: delayed 00:06:13 by SQLgrey-1.7.6
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
 [209.85.208.182])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1B9C08587E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 11:32:44 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id t13so1185227ljk.12
 for <iommu@lists.linux-foundation.org>; Thu, 05 Nov 2020 03:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iSxmQF561iTHdGCA/cHum/Fv1sq0ROCzHR9p5rpuQPE=;
 b=Tj3+jhEassI/I2HH7WsRmbxOzIhZDV9sWuz+HQwTn3NHNoAH0nXilClUWzee7xM8MR
 TBSE2dxkKaCkNpVcdl6870CqaQcwIMfEAYFb+XaVaRlqrrA72ucxBrlTxYATlfRRrpxR
 t4lajGzvmjJEHmni3VlztTQFJ1q9q4i08KhP4Yn8f4UtIk3i+fuLFrdTrt5bWIPz3/Bs
 toRT5mRT5d8+8drbJgIMYCNW7BjrebF6xSE4SYPG8dviS/rmLun7y8vZJacnPlFV2Z4E
 bcV4xXi0RA2kY1UcqD3pao6tHBPlinWf/e3KZ8Lh/EkE8g6n3BYptgGNWm0J0sl/cjWE
 r9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iSxmQF561iTHdGCA/cHum/Fv1sq0ROCzHR9p5rpuQPE=;
 b=YpDRz6Fv7olpSBWL/Eud8lXvDXTV6K4KbjkyZmPL06h+rqVutQedV8IFSORxoz/OwZ
 KrtJtxp6KN4kTn3D3KpGGEGGIpn0rNAF0MCtTkFWsz3zpciEItU01y7kWIrf3w35UnoS
 7LjAT0NPgc6Uy444C8b31Lrx57pULRfIuwDl8F8nxg0Kf8ifkyfgbDrOZSbCPRbLcr+6
 fUq4BYrkhekW0w4h76gX3eNHR5JKgLgK5ezJtP4Bpm7PZL9I6+M3HJeGZ3X3IjOnQbqR
 GTX2Qh0NVB/ZaarJk0wGEqVO5ua+GTlnLk41D3h5g77fLWX/F1Tmhh3gNP3Mx7E6VcIc
 xxLg==
X-Gm-Message-State: AOAM530ayl6aIc4Xc3acZ4dJzpq+iDbtXIpYVS5SN+KpO4o0jB0xGxFS
 Iu224WoUZ4HIUNxfWL0oKAIX5KQWaUxABpLU
X-Google-Smtp-Source: ABdhPJzkyFaXymPlZnIpRWWGlYJiJMDYR6NbVs4zbOo5E/L4R2m209MTtI9Iq+RX0cMyQcqsN396kQ==
X-Received: by 2002:aa7:c358:: with SMTP id j24mr2033015edr.265.1604575589996; 
 Thu, 05 Nov 2020 03:26:29 -0800 (PST)
Received: from localhost.localdomain ([83.68.95.66])
 by smtp.gmail.com with ESMTPSA id d11sm700072edu.2.2020.11.05.03.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 03:26:29 -0800 (PST)
From: Tomasz Nowicki <tn@semihalf.com>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
Subject: [PATCH 1/1] arm64: dts: marvell: keep SMMU disabled by default for
 Armada 7040 and 8040
Date: Thu,  5 Nov 2020 12:26:02 +0100
Message-Id: <20201105112602.164739-1-tn@semihalf.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, catalin.marinas@arm.com,
 d.odintsov@traviangames.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, nadavh@marvell.com, iommu@lists.linux-foundation.org,
 mw@semihalf.com, linux-arm-kernel@lists.infradead.org
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

FW has to configure devices' StreamIDs so that SMMU is able to lookup
context and do proper translation later on. For Armada 7040 & 8040 and
publicly available FW, most of the devices are configured properly,
but some like ap_sdhci0, PCIe, NIC still remain unassigned which
results in SMMU faults about unmatched StreamID (assuming
ARM_SMMU_DISABLE_BYPASS_BY_DEFAUL=y).

Since there is dependency on custom FW let SMMU be disabled by default.
People who still willing to use SMMU need to enable manually and
use ARM_SMMU_DISABLE_BYPASS_BY_DEFAUL=n (or via kernel command line)
with extra caution.

Fixes: 83a3545d9c37 ("arm64: dts: marvell: add SMMU support")
Cc: <stable@vger.kernel.org> # 5.9+
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 arch/arm64/boot/dts/marvell/armada-7040.dtsi | 4 ----
 arch/arm64/boot/dts/marvell/armada-8040.dtsi | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040.dtsi b/arch/arm64/boot/dts/marvell/armada-7040.dtsi
index 7a3198cd7a07..2f440711d21d 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-7040.dtsi
@@ -15,10 +15,6 @@ / {
 		     "marvell,armada-ap806";
 };
 
-&smmu {
-	status = "okay";
-};
-
 &cp0_pcie0 {
 	iommu-map =
 		<0x0   &smmu 0x480 0x20>,
diff --git a/arch/arm64/boot/dts/marvell/armada-8040.dtsi b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
index 79e8ce59baa8..22c2d6ebf381 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
@@ -15,10 +15,6 @@ / {
 		     "marvell,armada-ap806";
 };
 
-&smmu {
-	status = "okay";
-};
-
 &cp0_pcie0 {
 	iommu-map =
 		<0x0   &smmu 0x480 0x20>,
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
