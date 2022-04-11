Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC43C433FE
	for <iommu@archiver.kernel.org>; Mon, 11 Apr 2022 09:50:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BDAB60E74;
	Mon, 11 Apr 2022 09:50:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OIRSGXdSKa_4; Mon, 11 Apr 2022 09:50:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 71A2660EB7;
	Mon, 11 Apr 2022 09:50:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B12C2C008C;
	Mon, 11 Apr 2022 09:50:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17126C002C
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 09:50:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 155DA83FAE
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 09:50:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=quicinc.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oYSPJW52_d7A for <iommu@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 09:50:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8DEDB82909
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 09:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1649670648; x=1681206648;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=xzRH/Ivs+0i07Ts6lK6bing4ar3/peg9rJMOQp2xa08=;
 b=lx2neHYPKEEPdM/xraKrOMMGa6rIs0Lw0jhSD0ITm9UnapROKXb1+LUG
 r+7F8iuUXMRvsYWg8Wb3SivWWDSIDg4uLf51lD6x+D4CqJFHDQyIX9GBI
 cHNGBLkHHtNpvZ8X4knkBfiVnjxybyBh1Z2XUbvhnngLXTxarnhaxIdQX g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
 by alexa-out.qualcomm.com with ESMTP; 11 Apr 2022 02:50:48 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
 by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA;
 11 Apr 2022 02:50:47 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO
 hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
 by ironmsg02-blr.qualcomm.com with ESMTP; 11 Apr 2022 15:20:26 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
 id 32E343AB9; Mon, 11 Apr 2022 15:20:25 +0530 (+0530)
From: Rohit Agarwal <quic_rohiagar@quicinc.com>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
 krzk+dt@kernel.org, ulf.hansson@linaro.org, agross@kernel.org,
 bjorn.andersson@linaro.org
Subject: [PATCH v2 5/7] ARM: dts: qcom: sdx65: Enable ARM SMMU
Date: Mon, 11 Apr 2022 15:20:13 +0530
Message-Id: <1649670615-21268-6-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649670615-21268-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1649670615-21268-1-git-send-email-quic_rohiagar@quicinc.com>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rohit Agarwal <quic_rohiagar@quicinc.com>,
 manivannan.sadhasivam@linaro.org, linux-arm-kernel@lists.infradead.org
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

Add a node for the ARM SMMU found in the SDX65.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65.dtsi | 40 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index 77bca58..f50a8a4 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -190,6 +190,46 @@
 			interrupt-controller;
 		};
 
+		apps_smmu: iommu@15000000 {
+			compatible = "qcom,sdx65-smmu-500", "arm,mmu-500";
+			reg = <0x15000000 0x40000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+			interrupts =	<GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 301 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		intc: interrupt-controller@17800000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
