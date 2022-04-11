Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38514C433EF
	for <iommu@archiver.kernel.org>; Mon, 11 Apr 2022 09:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6A1A83FBA;
	Mon, 11 Apr 2022 09:50:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qyekqo2WPmdK; Mon, 11 Apr 2022 09:50:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E527183F77;
	Mon, 11 Apr 2022 09:50:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD33EC0083;
	Mon, 11 Apr 2022 09:50:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E189C002C
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 09:50:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 282DB82909
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 09:50:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CEayhWVoFdpI for <iommu@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 09:50:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A277082951
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 09:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1649670646; x=1681206646;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=pz9Q9tfygcswvzxpNlt2xnEXl7RY0zN/Xm6yTTTTrBU=;
 b=iFTcFC4M2zeNNS46PuMct7zCHPFPod4TF6hul30OjJOp2W3GE/ORy47H
 mMlDqUh1RPEy4ZcqSLy48d644Z5poSjGpmFwzWNYHjEBoz4Q49muGcjKg
 oglnDlZt6AMDCL9+UxxcU00Qf5/ccRR5MH2Fzal1UG9hQopk6oel0xrrj I=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
 by alexa-out.qualcomm.com with ESMTP; 11 Apr 2022 02:50:45 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
 by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA;
 11 Apr 2022 02:50:44 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO
 hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
 by ironmsg02-blr.qualcomm.com with ESMTP; 11 Apr 2022 15:20:28 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
 id 0968D3AA3; Mon, 11 Apr 2022 15:20:27 +0530 (+0530)
From: Rohit Agarwal <quic_rohiagar@quicinc.com>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
 krzk+dt@kernel.org, ulf.hansson@linaro.org, agross@kernel.org,
 bjorn.andersson@linaro.org
Subject: [PATCH v2 7/7] ARM: dts: qcom: sdx65: Add Shared memory manager
 support
Date: Mon, 11 Apr 2022 15:20:15 +0530
Message-Id: <1649670615-21268-8-git-send-email-quic_rohiagar@quicinc.com>
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

Add smem node to support shared memory manager on SDX65 platform.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index 210e55c..8fef644 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -113,6 +113,12 @@
 		};
 	};
 
+	smem {
+		compatible = "qcom,smem";
+		memory-region = <&smem_mem>;
+		hwlocks = <&tcsr_mutex 3>;
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
