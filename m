Return-Path: <SRS0=h1an=BY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C385CC433E1
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 02:41:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 972C02224D
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 02:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZ5AfjFt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972C02224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7BC8786FDE;
	Fri, 14 Aug 2020 02:41:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K9ZqQhEz1Tng; Fri, 14 Aug 2020 02:41:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0FFC48705B;
	Fri, 14 Aug 2020 02:41:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE1DAC07FF;
	Fri, 14 Aug 2020 02:41:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD1CCC004D
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 02:41:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9BD21878C8
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 02:41:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PjAtqLM85xYz for <iommu@lists.linux-foundation.org>;
 Fri, 14 Aug 2020 02:41:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
 [209.85.216.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 034F38788D
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 02:41:44 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id t6so3706133pjr.0
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 19:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kKA+x0uy5NlO00Iqox0wh7pVzFT+/CgBiD5qZahgaMc=;
 b=OZ5AfjFtazVgCqyUoQKl0fVe4Zv1HBrkEcINpNZ4TF+rbwR3vfDA9C9hHNqhcfyovd
 hZ0VTlsSUQGx3HzvF866Vm87XoGiPc05zzEE8XuM080SPnyPJg7B7rLW8KmgJ70BHHF4
 zuSCrRo/Feri8CzJPWbSPNyKWMQRNkaZqHnQXvB4FIe1sWs2HoP3IZfCaJ3jHHjohB91
 R7iNeBNBpJM8lEn6KPKCMvKuUiUHWOk6KDMEIgZjNiiA8cPE9SSyOHHs45CBiftnkt2D
 cxK4wqvStzkpHkn2HCgopkUqnND6mu/tHLkHdk8vgl6ZBEIWrRjfD7ip/MJGFtVsGphZ
 sXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kKA+x0uy5NlO00Iqox0wh7pVzFT+/CgBiD5qZahgaMc=;
 b=asffMRa3wHlp+e26XMsPyEcG6JLseVL0xR89WSmIRIeS1iN4aJGfgclBz2uLVrxaX8
 6tlW7F3czELT7XiHfN1WmZ/c3W2Rayv5FaEdud0GpVnrNLTNDlvzdLuJHzQCqmkB/ya/
 rtkVAWzT4JrWdMfzWbUoxxA8125Kh1b2H2aVlFsm9gQcVo3EdK9a7IRPPzdKc89QrbJU
 1Ge8tw2dB0xHvryboeMjY/ZNMUxhjebk8FZB8jzHW0VQ5cni1g5VYTUDGwfBxTWJmJWu
 dkSvNhOdMC9/B+R4pJgPg9bks05q+JugOfWPn93I6WMqs/9ZfgH5UCnHzbIh97be+vDw
 Rl/Q==
X-Gm-Message-State: AOAM5338Mt004OmoCqn2Dhkh0luf3MackGmYV9Ve1CnVr+BBOJWlc43j
 0N2OvIPTCa9cV17N5fCKg4M=
X-Google-Smtp-Source: ABdhPJxRU2uTcC7U1hC33YEDToytochFsUhJDPj0RKliYV1Cr2UAtF1I/WVfqPUwtN3PZCCpa2huaw==
X-Received: by 2002:a17:90a:2207:: with SMTP id
 c7mr557865pje.206.1597372903537; 
 Thu, 13 Aug 2020 19:41:43 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
 by smtp.gmail.com with ESMTPSA id e8sm7219856pfd.34.2020.08.13.19.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 19:41:42 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org
Subject: [PATCH 10/19] dt-bindings: arm-smmu: Add compatible string for Adreno
 GPU SMMU
Date: Thu, 13 Aug 2020 19:41:05 -0700
Message-Id: <20200814024114.1177553-11-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200810222657.1841322-1-jcrouse@codeaurora.org>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, Rob Herring <robh@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Stephen Boyd <swboyd@chromium.org>, freedreno@lists.freedesktop.org,
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

From: Jordan Crouse <jcrouse@codeaurora.org>

Every Qcom Adreno GPU has an embedded SMMU for its own use. These
devices depend on unique features such as split pagetables,
different stall/halt requirements and other settings. Identify them
with a compatible string so that they can be identified in the
arm-smmu implementation specific code.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 503160a7b9a0..5ec5d0d691f6 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -40,6 +40,10 @@ properties:
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
           - const: arm,mmu-500
+      - description: Qcom Adreno GPUs implementing "arm,smmu-v2"
+        items:
+          - const: qcom,adreno-smmu
+          - const: qcom,smmu-v2
       - description: Marvell SoCs implementing "arm,mmu-500"
         items:
           - const: marvell,ap806-smmu-500
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
