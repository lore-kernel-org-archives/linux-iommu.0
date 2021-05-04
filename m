Return-Path: <SRS0=4008=J7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43AFC43600
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 08:42:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F0B2611AD
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 08:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0B2611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3EA6D40F9D;
	Tue,  4 May 2021 08:42:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oz9SA4XSPz-4; Tue,  4 May 2021 08:42:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DCA640FA2;
	Tue,  4 May 2021 08:42:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBEBFC000F;
	Tue,  4 May 2021 08:41:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BED1DC0001
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 08:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9FF2660698
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 08:41:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wxhPVGWHpvNt for <iommu@lists.linux-foundation.org>;
 Tue,  4 May 2021 08:41:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 03393605AB
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 08:41:57 +0000 (UTC)
Received: from localhost.localdomain (unknown
 [IPv6:2a01:e0a:4cb:a870:3951:839d:24c0:e20d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: benjamin.gaignard)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C2DC01F423F6;
 Tue,  4 May 2021 09:41:55 +0100 (BST)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org, will@kernel.org, robh+dt@kernel.org, heiko@sntech.de,
 xxm@rock-chips.com
Subject: [PATCH v3 3/4] ARM: dts: rockchip: rk322x: Fix iommu-cells properties
 name
Date: Tue,  4 May 2021 10:41:23 +0200
Message-Id: <20210504084124.131884-4-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210504084124.131884-1-benjamin.gaignard@collabora.com>
References: <20210504084124.131884-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux-foundation.org, kernel@collabora.com,
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

Add '#" to iommu-cells properties

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index a4dd50aaf3fc..8af2e9288029 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -564,7 +564,7 @@ vpu_mmu: iommu@20020800 {
 		interrupt-names = "vpu_mmu";
 		clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
 		clock-names = "aclk", "iface";
-		iommu-cells = <0>;
+		#iommu-cells = <0>;
 		status = "disabled";
 	};
 
@@ -575,7 +575,7 @@ vdec_mmu: iommu@20030480 {
 		interrupt-names = "vdec_mmu";
 		clocks = <&cru ACLK_RKVDEC>, <&cru HCLK_RKVDEC>;
 		clock-names = "aclk", "iface";
-		iommu-cells = <0>;
+		#iommu-cells = <0>;
 		status = "disabled";
 	};
 
@@ -629,7 +629,7 @@ iep_mmu: iommu@20070800 {
 		interrupt-names = "iep_mmu";
 		clocks = <&cru ACLK_IEP>, <&cru HCLK_IEP>;
 		clock-names = "aclk", "iface";
-		iommu-cells = <0>;
+		#iommu-cells = <0>;
 		status = "disabled";
 	};
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
