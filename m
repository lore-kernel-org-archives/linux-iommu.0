Return-Path: <SRS0=3ib5=D2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4108BC433E7
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 18:22:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2FD92231B
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 18:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zs9NWLNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2FD92231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 20B0F20354;
	Mon, 19 Oct 2020 18:22:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eOcYmzGYfXg2; Mon, 19 Oct 2020 18:22:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 836CB2E0EE;
	Mon, 19 Oct 2020 18:22:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58B0AC088B;
	Mon, 19 Oct 2020 18:22:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53552C0051
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 18:22:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4190087478
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 18:22:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Qif7aAzo3AV for <iommu@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 18:22:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com
 [209.85.161.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 892B987472
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 18:22:45 +0000 (UTC)
Received: by mail-oo1-f66.google.com with SMTP id f26so89184oou.11
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 11:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VpsiELiguu+j+d75TlHy7UatTKslEhtvU0VNkiyQTHE=;
 b=zs9NWLNI035QlA/VBI7c1W2y029/5QTx9et8nFbd2vTWzWmoW13w6gut5QKiSLyOcv
 /iVj0TrBKUDnDE5OOK6vn+u60m6BrHtX1IRsXHLSviusPu5cfGfTElzcPftNUTIyqb+5
 E+su2boKZjvNwFFmNS8aqEDOo0Jjbtg1gtVyM2FL7Ms+J9RzDLhxfGSWfp834QlaIY1m
 ijmyO8/Y7KSAJINJ4woLIJF1CDp4YRJ16sEY7erjyyciGpT1sF22495HxPKYwvnZZs7I
 +KkR94uCA3tX2dGV2S1EAS/MB6Zq605p5Z8vOgZ8QAa8Vw1VqM/BsgZyAnHlOwoamCvs
 nngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VpsiELiguu+j+d75TlHy7UatTKslEhtvU0VNkiyQTHE=;
 b=Tw+3fpZGIHWGKIZh82i1zZYbYdqbdjK2Bg0FjuWKyE3KWFvV5XsvONBGt9Ic8jLBEx
 b57071qxQXwQyfM0li/rZwWqzDyCftRRL5jjMGnFtSgt6yJT5Y5QdpJBQsuPA9OsyE2i
 CV9vmY0MdZyat1eYUkakCWKcPsE6GSj87tl+8aPTDXVJuEgnetmwEjUMcEgX1bNgiN8S
 FcXQrteZOOjmYoIceQ9YgIW9SWWm2y9FFXdS1XiXJofsrGYV0JP1BRfxGwKtb/hnDvFA
 uJWOOYKzOmg1wlOo3QcZ9GeStz8PpItKSlvlsTkUmDUGU4O9qsh1ZbMd655t/vWG4bRD
 x+LQ==
X-Gm-Message-State: AOAM531EPOB4PZvJjSyTKrfuen8mbe5tXUop/7+GLQS6H9AUACs9NgK8
 JVkZ51yxH/QaQ2OUmMbqjLlb3A==
X-Google-Smtp-Source: ABdhPJxsCpy/TBGLYx5Vl3+4B9L49mmC4/H7jkek9a/kPGO0kiKyGGtmak7p5gL4UV1db2SW7QYkbA==
X-Received: by 2002:a4a:972c:: with SMTP id u41mr931370ooi.10.1603131764686;
 Mon, 19 Oct 2020 11:22:44 -0700 (PDT)
Received: from localhost.localdomain
 (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id o8sm175296oog.47.2020.10.19.11.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 11:22:44 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Jordan Crouse <jcrouse@codeaurora.org>,
 Thierry Reding <treding@nvidia.com>, Rob Clark <robdclark@chromium.org>
Subject: [PATCH v5 0/3] iommu/arm-smmu-qcom: Support maintaining bootloader
 mappings
Date: Mon, 19 Oct 2020 11:23:20 -0700
Message-Id: <20201019182323.3162386-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
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

This is the revised fourth attempt of inheriting the stream mapping for
the framebuffer on many Qualcomm platforms, in order to not hit
catastrophic faults during arm-smmu initialization.

The new approach does, based on Robin's suggestion, take a much more
direct approach with the allocation of a context bank for bypass
emulation and use of this context bank pretty much isolated to the
Qualcomm specific implementation.

The patchset has been tested to boot DB845c and RB5 (with splash screen)
and Lenovo Yoga C630 (with EFI framebuffer).

Bjorn Andersson (3):
  iommu/arm-smmu: Allow implementation specific write_s2cr
  iommu/arm-smmu-qcom: Read back stream mappings
  iommu/arm-smmu-qcom: Implement S2CR quirk

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 90 ++++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 13 +++-
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  1 +
 3 files changed, 101 insertions(+), 3 deletions(-)

-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
