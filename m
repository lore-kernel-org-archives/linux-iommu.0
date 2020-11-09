Return-Path: <SRS0=JucZ=EP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5DFC2D0A3
	for <iommu@archiver.kernel.org>; Mon,  9 Nov 2020 18:48:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26453206F1
	for <iommu@archiver.kernel.org>; Mon,  9 Nov 2020 18:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="NbuP3zx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26453206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A74C82044D;
	Mon,  9 Nov 2020 18:48:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TDJaB1CkN56s; Mon,  9 Nov 2020 18:48:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B4CAC2041F;
	Mon,  9 Nov 2020 18:48:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9CCF4C088B;
	Mon,  9 Nov 2020 18:48:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81040C016F
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 18:48:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6F6FE87242
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 18:48:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FqBvXgDq36PN for <iommu@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 18:48:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from z5.mailgun.us (z5.mailgun.us [104.130.96.5])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1B0F68723F
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 18:48:26 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1604947707; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=hb6djRwuA4jBWtS7WMTEeEQmesAOMYwuWNvwYqxJWBY=;
 b=NbuP3zx3Q/irY8vZL8QZ18YEJNslG1gNLFZo2BXPmM7rcn2q2xFBhwiVcyOnAz//7fpQxi6E
 wBw5mcYksZGOGRNN5RPzdZMjLvlqhtxFhBQDVeh/s2h6ju7pPZimS+nDAs3tKThxqKuj5WZO
 0hhvLCJBHIoufeceuBA9CTWdn/s=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5fa98ecf23a1a2b32d4a9c65 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 09 Nov 2020 18:47:43
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 79F4EC433CB; Mon,  9 Nov 2020 18:47:43 +0000 (UTC)
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id CECDAC433F0;
 Mon,  9 Nov 2020 18:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CECDAC433F0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH v19 3/4] dt-bindings: arm-smmu: Add compatible string for
 Adreno GPU SMMU
Date: Mon,  9 Nov 2020 11:47:27 -0700
Message-Id: <20201109184728.2463097-4-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109184728.2463097-1-jcrouse@codeaurora.org>
References: <20201109184728.2463097-1-jcrouse@codeaurora.org>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
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

Every Qcom Adreno GPU has an embedded SMMU for its own use. These
devices depend on unique features such as split pagetables,
different stall/halt requirements and other settings. Identify them
with a compatible string so that they can be identified in the
arm-smmu implementation specific code.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 503160a7b9a0..3b63f2ae24db 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -28,8 +28,6 @@ properties:
           - enum:
               - qcom,msm8996-smmu-v2
               - qcom,msm8998-smmu-v2
-              - qcom,sc7180-smmu-v2
-              - qcom,sdm845-smmu-v2
           - const: qcom,smmu-v2
 
       - description: Qcom SoCs implementing "arm,mmu-500"
@@ -40,6 +38,13 @@ properties:
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
           - const: arm,mmu-500
+      - description: Qcom Adreno GPUs implementing "arm,smmu-v2"
+        items:
+          - enum:
+              - qcom,sc7180-smmu-v2
+              - qcom,sdm845-smmu-v2
+          - const: qcom,adreno-smmu
+          - const: qcom,smmu-v2
       - description: Marvell SoCs implementing "arm,mmu-500"
         items:
           - const: marvell,ap806-smmu-500
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
