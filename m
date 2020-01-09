Return-Path: <SRS0=4b30=26=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29145C282DD
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 00:26:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD113206DA
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 00:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="TK7LNbfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD113206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B461985F0B;
	Thu,  9 Jan 2020 00:26:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iw-REyUMdSk9; Thu,  9 Jan 2020 00:26:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 13B3385C9F;
	Thu,  9 Jan 2020 00:26:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 093C8C1796;
	Thu,  9 Jan 2020 00:26:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C714BC0881
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 00:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C17522048C
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 00:26:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id StaZi1+AZVcH for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jan 2020 00:26:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from onstation.org (onstation.org [52.200.56.107])
 by silver.osuosl.org (Postfix) with ESMTPS id C76CC2039E
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 00:26:25 +0000 (UTC)
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net
 [98.239.145.235])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: masneyb)
 by onstation.org (Postfix) with ESMTPSA id 0E27B3EE6F;
 Thu,  9 Jan 2020 00:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
 s=default; t=1578529584;
 bh=bSP4GLHNIkw9HeeIY0NybAJJvEgnnxZaLRa3yG6+E1Q=;
 h=From:To:Cc:Subject:Date:From;
 b=TK7LNbfLzwC1F6wyfJLhAZh/bLnMAMGWyPQ+53Ef9F9qfGO8LdHQdNxZzdN/ApgLQ
 spnXD0HCF2D5BgqAqnzHtGmbgkilGBxb8HwbfZjcP8Jtx2F3pGL+IMEfcms3ov2jp4
 CwsIsk1ZiP73Lrd5/c1t4wIJrKy7VCeU3zbrKz+U=
From: Brian Masney <masneyb@onstation.org>
To: robdclark@gmail.com,
	bjorn.andersson@linaro.org
Subject: [PATCH RFC] ARM: dts: qcom: msm8974: add mdp5 iommu support
Date: Wed,  8 Jan 2020 19:26:06 -0500
Message-Id: <20200109002606.35653-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 agross@kernel.org, freedreno@lists.freedesktop.org
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

This adds preliminary IOMMU support for the MDP5 on msm8974. It appears
that the qcom-iommu driver in upstream can be used on this SoC. I marked
this patch as a RFC since the frame buffer becomes corrupted when I boot
the Nexus 5 phone with this patch:

https://raw.githubusercontent.com/masneyb/nexus-5-upstream/master/images/broken-mdp5-iommu.jpg

A quick note about the ranges of the context banks below: Based on the
downstream sources, I believe that the memory addresses should be mapped
out like this:

	mdp_iommu: iommu@fd928000 {
		reg = <0xfd928000 0x8000>;
		ranges = <0 0xfd930000 0x8000>;
		...

		iommu-ctx@0 {
			reg = <0x0 0x1000>;
			...
		};

		iommu-ctx@1000 {
			reg = <0x1000 0x1000>;
			...
		};

		iommu-ctx@2000 {
			reg = <0x2000 0x1000>;
			...
		};
	};

However, the qcom-iommu driver in upstream expects the first context
bank to exist at address 0x1000, and the address space identifier
(asid) to be greater than 0. See get_asid() and qcom_iommu_of_xlate()
in the upstream qcom-iommu.c driver. I put in the patch below what the
driver expects. I modified the driver in my local tree to allow the
mapping that I have above so that the extra 0x1000 of memory is mapped
into the global address space and still experience the same screen
corruption issue.

Downstream MSM 3.4 IOMMU dts snippet for reference:
https://github.com/AICP/kernel_lge_hammerhead/blob/n7.1/arch/arm/boot/dts/msm-iommu-v1.dtsi#L110

I'm hoping that someone that's more familiar with this hardware has a
suggestion for something to try.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 44 +++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 4b161b809dd5..2515a3bd4aa7 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -1305,6 +1305,46 @@ etm3_out: endpoint {
 			};
 		};
 
+		mdp_iommu: iommu@fd928000 {
+			compatible = "qcom,msm8974-iommu",
+			             "qcom,msm-iommu-v1";
+			reg = <0xfd928000 0x7000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#iommu-cells = <1>;
+			ranges = <0 0xfd92f000 0x9000>;
+
+			clocks = <&mmcc MDSS_AHB_CLK>,
+			         <&mmcc MDSS_AXI_CLK>;
+			clock-names = "iface",
+			              "bus";
+
+			qcom,iommu-secure-id = <1>;
+
+			// mdp_0
+			iommu-ctx@1000 {
+				compatible = "qcom,msm-iommu-v1-ns";
+				reg = <0x1000 0x1000>;
+				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			// mdp_1
+			iommu-ctx@2000 {
+				compatible = "qcom,msm-iommu-v1-sec";
+				reg = <0x2000 0x1000>;
+				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
+				             <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			// mdp_2
+			iommu-ctx@3000 {
+				compatible = "qcom,msm-iommu-v1-sec";
+				reg = <0x3000 0x1000>;
+				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
+				             <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+			};
+                };
+
 		ocmem@fdd00000 {
 			compatible = "qcom,msm8974-ocmem";
 			reg = <0xfdd00000 0x2000>,
@@ -1427,6 +1467,10 @@ mdp: mdp@fd900000 {
 				interconnects = <&mmssnoc MNOC_MAS_MDP_PORT0 &bimc BIMC_SLV_EBI_CH0>;
 				interconnect-names = "mdp0-mem";
 
+				iommus = <&mdp_iommu 1
+				          &mdp_iommu 2
+				          &mdp_iommu 3>;
+
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
-- 
2.24.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
