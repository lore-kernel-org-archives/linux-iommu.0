Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C962C433EF
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 16:32:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9D5F040469;
	Tue,  3 May 2022 16:32:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b8Oa8L0GWTzy; Tue,  3 May 2022 16:32:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 903F4400BF;
	Tue,  3 May 2022 16:32:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 494A4C0032;
	Tue,  3 May 2022 16:32:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC9DFC002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 16:32:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ADF7A81B36
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 16:32:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jnQry0TsIUVr for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 16:32:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 03835817A9
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 16:32:45 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 z15-20020a9d65cf000000b00605f064482cso9178660oth.6
 for <iommu@lists.linux-foundation.org>; Tue, 03 May 2022 09:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=04yCZmGU5lzqSzWtLJBB88QnMJDZZhNGZmMLSUs6I88=;
 b=dLEzH+9nn42NpH9bp99fDk9o5mkKZIcYnxCBOKQGouxka2F4MSSjRNZhNb0Si8y9Sc
 70ud6rEYUP4HkVo6/wzp9yRcJRHmD4gFTLZUwJXVrVLFsvucctGevfPap7Yl2wT5CCL0
 FhNNP4zM2iICGBHY0TQ4C1vInUNTRBcHT32zKf5hBDcWQIVR9ErcIBjE1fB1vYgmPsQ2
 1cdQs6vehNNQ9nZbj0WRVqfzghWEGRtIsuRGrCT3ljv3ZELdqmRvA7PsdxF0yKF3dFlk
 cug3+bTG1pjOtdIcPDbL3xw/ODrwWrnDOj3BCTurkEXIfGa9Zxi0s7Cg33dZkDyMhayj
 vksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=04yCZmGU5lzqSzWtLJBB88QnMJDZZhNGZmMLSUs6I88=;
 b=AtL4JCRpAvnyFwLbUmzkEcRBjdshvBBj7WPO83IAbvE3F2Y1SS7r6/kPAI8FrFONEO
 EDGtDR50Hu4lzqwfBQpJv8MHmvwc8gyHFfYH2fzXceJvLXHKIogYcu6CydxJJCIa+O/8
 uA7n2FCRKGxOCuU3FXisL3Dj4DItB+EsK9T9SKQHbJeoEa8LBzXLQZlUUDcyhRJjpE72
 YoNfmQfeGHFwnAZCfmGbeHMeLRkKNtzNEb02QgrKhgsCLv6VfBKdWgFdHEJ6eTwDX3it
 G/8y/BtXZYKe5XqB/ts1HL2E3VGjwuf17zC1fxMrwhMFgB0JVZl/lbaf0seGbEP1aBuD
 Bvvw==
X-Gm-Message-State: AOAM532TuCdtWXErK/vqPGarRAAeIOac9GCNFEdNSqNoC8ulF36+pNqd
 VGFBirH/xcM6BPI3zClYH3n7Cg==
X-Google-Smtp-Source: ABdhPJywDb/F99erOQU7c9Pw2zLureldWnS8L5dkzeqKygYCexJlFz0vSdciswu6uJcP2b2UdmE59w==
X-Received: by 2002:a9d:68cd:0:b0:606:13c7:97c4 with SMTP id
 i13-20020a9d68cd000000b0060613c797c4mr4377387oto.312.1651595565017; 
 Tue, 03 May 2022 09:32:45 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186]) by smtp.gmail.com with ESMTPSA id
 v15-20020a4ae6cf000000b0035eb4e5a6cdsm5027404oot.35.2022.05.03.09.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 May 2022 09:32:44 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH 0/2] iommu/arm-smmu-qcom: Add SC8280XP support
Date: Tue,  3 May 2022 09:34:27 -0700
Message-Id: <20220503163429.960998-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

This adds the compatible for the Qualcomm SC8280XP platform and associate the
Qualcomm impl in the ARM SMMU driver to it.

Bjorn Andersson (2):
  dt-bindings: arm-smmu: Add compatible for Qualcomm SC8280XP
  iommu/arm-smmu-qcom: Add SC8280XP support

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c            | 1 +
 2 files changed, 2 insertions(+)

-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
