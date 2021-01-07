Return-Path: <SRS0=iLvA=GK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18975C433DB
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 14:54:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89BFA22B2B
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 14:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BFA22B2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 249DD8065D;
	Thu,  7 Jan 2021 14:54:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4fFwiFNdti-W; Thu,  7 Jan 2021 14:54:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9003886962;
	Thu,  7 Jan 2021 14:54:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75B5AC088B;
	Thu,  7 Jan 2021 14:54:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2069C013A
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 14:31:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 819DE273E1
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 14:31:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KrwxfpckddYr for <iommu@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 14:31:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by silver.osuosl.org (Postfix) with ESMTPS id 8E3852042D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 14:31:41 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id i7so5050214pgc.8
 for <iommu@lists.linux-foundation.org>; Thu, 07 Jan 2021 06:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RsDTMrWv7jSxdT5ji0Wdtt9x9xjaZ1j3PSJSmTMWzAg=;
 b=LFmqRtkapVLHAIwS9SwEiH0wOugFQUWyHlXt409uUhmVadFEvWL+UTSux0ywaxjTIL
 qPGwDIR8l3xvvhPvKZqcH81QyML6nYN2gQ9PlLPbicKSgn3g6y4FyFG21l83GjqbxFe/
 Y1SvEhPYdyHVTiS8T8D9nyKiD9/MCS7bvruMES2BHC5yfq3VUobOa8bSsSPj9OBNHphi
 0pT0vA85FIZSzzv6NdOBukjatPxyL1xaGfO6w3hP56XSg5w6L2x4efpfRXfiX+eFPCz3
 S+g1ZPdGLmmGNpUQZsA7ZWNeagdfXw8PVAHujJ6k33M6Huy4auqTVqMquaILFD8WTImK
 sRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RsDTMrWv7jSxdT5ji0Wdtt9x9xjaZ1j3PSJSmTMWzAg=;
 b=l0gprdgvVecePdFv3U3LPk1tBmj0J1gNt5+bUZcEhXl4nWPNrfPWfqgm/F3OrjFaSL
 P9TXjzk1arBaOfANyNTidaexPa1x3yQQndOtM6ij9CQSe8qG5xyyWhgELxxqsj3W4Szu
 PINdR4OmKS2Fk+X1lU2sNlVyeOMp98uzDRjyaEtdA1Dflx+VgCdyLH22qysSVmlrzPe0
 BnLSOwzKqL6z9+oWlUoNdm1Z4+teeJCw3Wq18sd26FvBSJlxJek8lwZlC0DFrgFBmgK/
 HGQ7HJnJ9tK6T0LaQ3w7GkZTv2PExXuHSUfm2/39qYigJqV+Znp+wcpg5LPx8yCXf4KR
 8HNw==
X-Gm-Message-State: AOAM531pVnoBsIcy3N95aa2X2CJ7gYWP/T6ozTWJXb0ZthnclP4tExiM
 PF4339URYhFuMPvZ9/qBI2tX
X-Google-Smtp-Source: ABdhPJzSG7+An9o4M0cfAK/FdgBFCAQmBgulcSq3UwEZdeNDf3A/qo5+aNub8hfE5ryNYIOPDwVeNg==
X-Received: by 2002:a62:7fc1:0:b029:19f:1dab:5029 with SMTP id
 a184-20020a627fc10000b029019f1dab5029mr8813824pfd.13.1610029901346; 
 Thu, 07 Jan 2021 06:31:41 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.128])
 by smtp.gmail.com with ESMTPSA id 19sm6096465pfu.85.2021.01.07.06.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Jan 2021 06:31:40 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: robh+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: arm-smmu: Add binding for Qcom SDX55 SMMU
Date: Thu,  7 Jan 2021 20:01:18 +0530
Message-Id: <20210107143118.2386-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107143118.2386-1-manivannan.sadhasivam@linaro.org>
References: <20210107143118.2386-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 07 Jan 2021 14:54:04 +0000
Cc: Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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

Add devicetree binding for Qualcomm SDX55 SMMU.

Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 3b63f2ae24db..3a1cefce8bc4 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -35,6 +35,7 @@ properties:
           - enum:
               - qcom,sc7180-smmu-500
               - qcom,sdm845-smmu-500
+              - qcom,sdx55-smmu-500
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
           - const: arm,mmu-500
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
