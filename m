Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2FBC4332F
	for <iommu@archiver.kernel.org>; Mon, 11 Apr 2022 08:01:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45FBF83F7C;
	Mon, 11 Apr 2022 08:01:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2tzu6PirfPxh; Mon, 11 Apr 2022 08:01:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3C57583E82;
	Mon, 11 Apr 2022 08:01:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0712FC0092;
	Mon, 11 Apr 2022 08:01:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABFEBC002C
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 07:02:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 99DCD4025D
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 07:02:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=quicinc.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O2MT9q2-ADK5 for <iommu@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 07:02:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 004F34018D
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 07:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1649660539; x=1681196539;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=8WoLxVpJwsGyepr056PagqgtM+agMi/R0Cz0UrtHKc0=;
 b=I09iFbjZLa1s6+Zw1Nwc5JGo1tOYYtibj6cigMuqaXFbT6nmglIzHL50
 twP1RUQ9Hg4OmDvelqnfN4TXHZrFJDOTv9dEjYMO44A0NhIxif9sJe8km
 bfOsroj04pHcjoG4B2DMm0EG4DRdmtyQWQGzif0speHexuC5e8iQX0bEG c=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
 by alexa-out.qualcomm.com with ESMTP; 10 Apr 2022 23:56:14 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
 by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 10 Apr 2022 23:56:12 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO
 hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
 by ironmsg01-blr.qualcomm.com with ESMTP; 11 Apr 2022 12:25:52 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
 id 31C2D3A9B; Mon, 11 Apr 2022 12:25:51 +0530 (+0530)
From: Rohit Agarwal <quic_rohiagar@quicinc.com>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
 krzk+dt@kernel.org, ulf.hansson@linaro.org, agross@kernel.org,
 bjorn.andersson@linaro.org
Subject: [PATCH 1/7] ARM: dts: qcom: sdx65: Add reserved memory nodes
Date: Mon, 11 Apr 2022 12:25:37 +0530
Message-Id: <1649660143-22400-2-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649660143-22400-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1649660143-22400-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailman-Approved-At: Mon, 11 Apr 2022 08:01:02 +0000
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rohit Agarwal <quic_rohiagar@quicinc.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Add reserved memory nodes to the SDX65 dtsi as defined by
the memory map.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65-mtp.dts | 21 +++++++++++++++++
 arch/arm/boot/dts/qcom-sdx65.dtsi    | 45 ++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
index ad99f56..5d51cc4 100644
--- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
@@ -23,6 +23,27 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		mpss_dsm: mpss_dsm_region@8c400000 {
+			no-map;
+			reg = <0x8c400000 0x3200000>;
+		};
+
+		ipa_fw_mem: ipa_fw_region@8fced000 {
+			no-map;
+			reg = <0x8fced000 0x10000>;
+		};
+
+		mpss_adsp_mem: mpss_adsp_region@90800000 {
+			no-map;
+			reg = <0x90800000 0x10000000>;
+		};
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vph_pwr";
diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index 7e2697f..365df74 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -66,6 +66,51 @@
 			reg = <0x8fee0000 0x20000>;
 			no-map;
 		};
+
+		secdata_mem: secdata_region@8fcfd000 {
+			no-map;
+			reg = <0x8fcfd000 0x1000>;
+		};
+
+		hyp_mem: hyp_region@8fd00000 {
+			no-map;
+			reg = <0x8fd00000 0x80000>;
+		};
+
+		aop_mem: aop_regions@8fe00000 {
+			no-map;
+			reg = <0x8fe00000 0x20000>;
+		};
+
+		access_control_mem: access_control_region@8fd80000 {
+			no-map;
+			reg = <0x8fd80000 0x80000>;
+		};
+
+		smem_mem: smem_region@8fe20000 {
+			no-map;
+			reg = <0x8fe20000 0xc0000>;
+		};
+
+		tz_mem: tz_mem_region@8ff00000 {
+			no-map;
+			reg = <0x8ff00000 0x100000>;
+		};
+
+		tz_apps_mem: tz_apps_mem_region@90000000 {
+			no-map;
+			reg = <0x90000000 0x500000>;
+		};
+
+		tz_heap_mem: tz_heap_region@8fcad000 {
+			no-map;
+			reg = <0x8fcad000 0x40000>;
+		};
+
+		llcc_tcm_mem: llcc_tcm_region@15800000 {
+			no-map;
+			reg = <0x15800000 0x800000>;
+		};
 	};
 
 	soc: soc {
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
