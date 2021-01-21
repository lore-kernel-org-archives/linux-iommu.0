Return-Path: <SRS0=oIyp=GY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4A3C433E6
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 01:40:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 118DB23719
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 01:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118DB23719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B08538714E;
	Thu, 21 Jan 2021 01:40:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9likIP-ZG4qN; Thu, 21 Jan 2021 01:40:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 304E08714A;
	Thu, 21 Jan 2021 01:40:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2F3CC088B;
	Thu, 21 Jan 2021 01:40:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3E2EC013A
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 01:39:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CB05586B9E
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 01:39:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SGh7cnYz2dkC for <iommu@lists.linux-foundation.org>;
 Thu, 21 Jan 2021 01:39:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 093D986B9D
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 01:39:59 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id k8so159990otr.8
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 17:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mTIkLf8P7rQ1csosNj9MYUkt9q/vHpvdvB2piAeWYvg=;
 b=vhLT4V2HYiuaF9zhU4e6fcDxilz0aj429uzh1g2Z6NkymbGcO+tJxJ861jlAOraYgr
 DCBG0R+yHMznzEVyIEe5pJpX6Yf1qSAK4BMdj2ZE0FzGXeo+UVxwF7yxjyRpBb8V2BaD
 n1IuRU/tqoyintLDZsJJyqM4jXlSuScmngjD3uBy6lTfI/V+8gHCi+fI+BsM983KXLcx
 DT9Z/NIAjkD/GgVuLNFd91mwNaQFxD4B2fSqm+kPbwMrDvdspRZn4vvhyz3kCvALApYz
 Nv06cvwlyydo5TqGIAXlEWo/ENmJY/xfEfHhlPcInADzxx4OsHkxPsWqgpOxzQYCDj8y
 l+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mTIkLf8P7rQ1csosNj9MYUkt9q/vHpvdvB2piAeWYvg=;
 b=mZBaKvnp5kHikG/mIaxjRWqk0viMHT4rp0rPt/Hplg0Am4vJHUmBNqPuhMc9wb/omM
 9APSnif9ddK3ZYN3EjJEVmqfcS3Ab7AaF9UeVjwLgU9wbRWJ1va9wRDD4CcrLIKnuYU2
 1TVSKG+HEIowAenO7KbZVWgc7/Ygv+jFMFDDeH2gZt+7Pko/PbMZCXazp2ThkRNoq1bT
 G+0fxxY1gkGjBLrGeqGxo2T/s4kPEj7yeG5qSs6kI5kriMdqbV9MGC/HHlxN4/Rvv+iQ
 0QNkQxml3KnbrOf37YZrZs22wK86PFr2DtyUC//7b59V++Qs8zGFEilKN0J0fDELY/fM
 VYZw==
X-Gm-Message-State: AOAM5326hN+G8lJXgwuJ93+t3vw0tOPq8/lNtKTGfoCV+S0mjYERGuhp
 tMzlWZI12VtFRo2xek3z1ZtmNg==
X-Google-Smtp-Source: ABdhPJyBR58mQmQLd8XYcUP0EsBRHHD8FexvMM+wKw949cEidpIIPaHyDJpA57juJjwwsTdOX2Ujvg==
X-Received: by 2002:a9d:688:: with SMTP id 8mr2431369otx.22.1611193198020;
 Wed, 20 Jan 2021 17:39:58 -0800 (PST)
Received: from localhost.localdomain
 (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id s2sm729597oov.35.2021.01.20.17.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Jan 2021 17:39:57 -0800 (PST)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/2] dt-bindings: arm-smmu-qcom: Add Qualcomm SC8180X
 compatible
Date: Wed, 20 Jan 2021 17:40:04 -0800
Message-Id: <20210121014005.1612382-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
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

Add compatible for the ARM SMMU found in the Qualcomm SC8180x platform.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 3b63f2ae24db..c50198e17d52 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -34,6 +34,7 @@ properties:
         items:
           - enum:
               - qcom,sc7180-smmu-500
+              - qcom,sc8180x-smmu-500
               - qcom,sdm845-smmu-500
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
