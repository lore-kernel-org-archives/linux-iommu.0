Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBA7C433FE
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 08:38:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF58D8289B;
	Mon,  2 May 2022 08:38:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6nnwy64nnOLL; Mon,  2 May 2022 08:38:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9D0738271D;
	Mon,  2 May 2022 08:38:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38A0FC007F;
	Mon,  2 May 2022 08:38:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBA1DC002D
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 08:38:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B9070404F7
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 08:38:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=quicinc.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4DGHGmDJuWbO for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 08:38:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 106824035E
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 08:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1651480694; x=1683016694;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=4sArmmPqK1fpsAra+ctcw1Mg8/kPFO/JwQ40cELNy00=;
 b=kdglfGdJqDlwkF94djI3Dp5IbVYmLdgQ8212vXhLXDoxIkUSOxgonO9w
 13c11J2TIGuie/4buSlqcge9tWcgdNDPH2l6IgVeWjMh5vgYM5tlPd1Mu
 AQ+C6gdPru8PZfE9kB5rs/HHhtrzlbw3JqNUCx83QoYmDk9MFSl6P7zzs 8=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
 by alexa-out.qualcomm.com with ESMTP; 02 May 2022 01:38:13 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
 by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA;
 02 May 2022 01:38:12 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO
 hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
 by ironmsg02-blr.qualcomm.com with ESMTP; 02 May 2022 14:07:50 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
 id 9621E3BE9; Mon,  2 May 2022 14:07:49 +0530 (+0530)
From: Rohit Agarwal <quic_rohiagar@quicinc.com>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, ulf.hansson@linaro.org,
 agross@kernel.org, bjorn.andersson@linaro.org, adrian.hunter@intel.com,
 bhupesh.sharma@linaro.org
Subject: [PATCH 3/4] dt-bindings: arm-smmu: Add binding for SDX65 SMMU
Date: Mon,  2 May 2022 14:07:44 +0530
Message-Id: <1651480665-14978-4-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651480665-14978-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1651480665-14978-1-git-send-email-quic_rohiagar@quicinc.com>
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

Add devicetree binding for Qualcomm SDX65 SMMU.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index da5381c..1f99bff 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -39,6 +39,7 @@ properties:
               - qcom,sc8180x-smmu-500
               - qcom,sdm845-smmu-500
               - qcom,sdx55-smmu-500
+              - qcom,sdx65-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
