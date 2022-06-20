Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C592C433EF
	for <iommu@archiver.kernel.org>; Mon, 20 Jun 2022 18:36:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F98783E2A;
	Mon, 20 Jun 2022 18:36:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8F98783E2A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anholt-net.20210112.gappssmtp.com header.i=@anholt-net.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=H+lKfc53
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n2Rk-Fa8biq1; Mon, 20 Jun 2022 18:36:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 753F5832BF;
	Mon, 20 Jun 2022 18:36:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 753F5832BF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F444C002D;
	Mon, 20 Jun 2022 18:36:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8217C002D
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 18:36:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B30F283E17
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 18:36:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B30F283E17
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lFY_fiVPuvEa for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 18:36:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F0469832BF
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F0469832BF
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 18:36:44 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 k12-20020a17090a404c00b001eaabc1fe5dso11526665pjg.1
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 11:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anholt-net.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=r8NdoW5AddDmipkvsjih16CXPQjsU0eZxi3OxKkBmN8=;
 b=H+lKfc53MfoKWbnqFT89h/mhsoe7NhhEKrckelerE5pE/432Z3iaw7F1SU5lSMGrqJ
 FnKa6NPxdxUeaC+s00glxACfjiGk/WGnMJlbQIH6u00gpgD9cckUxtxVCnf1jyvOPQoU
 +fOslEDBVTSL1Gy7THBQtu2BMSdTLxqQeFir4ZRti+VfxfwhPYYzcwujuor+6XA5+K6l
 MO5/6PRdBvYtwVWe+/26N26yUtMeZgxY8fqyDx3J3uqp8zTy0Cu2L3YwStQF9WTEZpAb
 DWpePaBt/jlMP9L50HQ27nqGppXu167xQ65N079vLwRk9Ybn982GujmmWrz52Kjfdw0x
 84xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=r8NdoW5AddDmipkvsjih16CXPQjsU0eZxi3OxKkBmN8=;
 b=AJVPnmDXjOThhNe+NjeMjhh67NIv5Jw0/cIqtPgWcmAAV7eupbFmfaU2W6G2nGkwHv
 sX1TYnJCx2t4oh4ufFAJw1KUIEHy7R2ruAmCgbqpTGM9Sunhaon/3OvmImWpJnkUm30v
 NNzs/1VfjrqLbSKSJUxkPbrrkRWgwxuVbKj+JfQ66cH+yO1oSgDnopGPxrOUrav5JMuy
 GT0xA0C2WQVoJ6lYvBrWxVx3u6oxPkg+Gn9/flYxOUeq5qI/j6wbThEh+27NdvOX0iWM
 XV9r4LfFLWFRjAm645hGAUplXAtZ/2xKIdHVwQ7XPZNj4s1jTfZ11Xo3rjo21gAsSw9j
 umMw==
X-Gm-Message-State: AJIora8IJ0ldN9gGZVke4rS1HtvXDEFzbsokNhi3wad8rousPAYjzV5v
 ak2jMaKxD8Pwj9/nKhb1prXrew==
X-Google-Smtp-Source: AGRyM1uQfz7pZ9DWLMJTwN2MFiyDfq/jBEgrSB5FWoXIJh1Yc8zL8k5KuFSfqFGI+JOH70LUpG/riQ==
X-Received: by 2002:a17:902:d718:b0:168:d9df:4f1c with SMTP id
 w24-20020a170902d71800b00168d9df4f1cmr25205344ply.41.1655750204246; 
 Mon, 20 Jun 2022 11:36:44 -0700 (PDT)
Received: from wildbow.anholt.net ([97.115.187.17])
 by smtp.gmail.com with ESMTPSA id
 ds12-20020a17090b08cc00b001e0c1044ceasm8500041pjb.43.2022.06.20.11.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jun 2022 11:36:43 -0700 (PDT)
From: Emma Anholt <emma@anholt.net>
To: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
 Jordan Crouse <jordan@cosmicpenguin.net>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 0/2] per-process page tables for qcom 8250
Date: Mon, 20 Jun 2022 11:36:31 -0700
Message-Id: <20220620183633.1131760-1-emma@anholt.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Emma Anholt <emma@anholt.net>
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

This enable per-process page tables on the Qualcomm RB5 boards I'm
setting up for Mesa CI.  Has survived a full deqp-vk run.

v2: moved qcom,adreno-smmu compatible earlier

Emma Anholt (2):
  iommu: arm-smmu-impl: Add 8250 display compatible to the client list.
  arm64: dts: qcom: sm8250: Enable per-process page tables.

 arch/arm64/boot/dts/qcom/sm8250.dtsi       | 2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
