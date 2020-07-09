Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF90C433E0
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 05:01:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CD9D2070E
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 05:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXPSxo5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD9D2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5281023235;
	Thu,  9 Jul 2020 05:01:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id peeeAN6YvMNM; Thu,  9 Jul 2020 05:01:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 237C12275A;
	Thu,  9 Jul 2020 05:01:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1584C0865;
	Thu,  9 Jul 2020 05:01:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF7FAC016F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 05:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9BDE1884CA
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 05:01:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YGxGi4LniqfJ for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 05:01:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DE31E883A7
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 05:01:40 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id d4so449199pgk.4
 for <iommu@lists.linux-foundation.org>; Wed, 08 Jul 2020 22:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uN2T4CF/tRygg+rOfQBDGtucvrJg7l2si9rKgMZR/j0=;
 b=BXPSxo5VbjQ5clTT5R39r8mnuahuMmSnFAX8dVZrldk0UdIVgqWclLWUaFgB9EEvGs
 5iz3KpwAkAgn90jBHAhrbXixnEOIEYtjcRThFOHPaMP1iW7G5A9VtiBNmc4MAkl+PePn
 X8Qxrz9Owin3O+N62O6MOn8S4A+iGJ6Wxb9sX2WIiLAY51C87Q29o3eXidoSP6ooqh+D
 qS6uu3fHwmtVABvqz/lvBdCP/QxOAANNR/YrgTRHreSoizLsqM/gfFPjeLgGJoCsorW3
 bcPBMKwdryQ+Fp3uaE4IZn7ZWggNMNBSXgKfxkkYCqUvqDoX7YBNX084BbbLThuTS7Ou
 LIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uN2T4CF/tRygg+rOfQBDGtucvrJg7l2si9rKgMZR/j0=;
 b=hshW4KYks0K5hSzflZAb+dMRZpiB+lidxtsgnRu8DJfGLripl68woE1lLnpZIM+iqc
 YTNW8g/jEXfYAMn/VTmFd84RzN9QXjbdiw/A+DwZ4sI4VMfxiG1L0EfqVqFeVUSIsmv3
 S+27O9xzkfQ1InTF1KgWrCRQitPTEqtMGqeTPwawPp9lYUehQtr0NJv/11nIfBxB63Gq
 uU4I+ndpj3BcMABfy5hpEzjNw2YLUfmYU5PvYBTXfAzn6QpknxYhyWWZbs9yjg/lU1Bf
 Q4Exyk+APn6Z4Vw40ZLK3Y/v8Cn4MN0BUd5HsCX6L2HHTQ5q/mPYvp8IhBMlORr5aJTG
 OJEQ==
X-Gm-Message-State: AOAM531JxjV5XGPk2E15ixyFYib2sMraAA/yxowMy71kZN8jkSYJ/Lo/
 qVPZwRx3PyGF9spSPqVmAKyEcw==
X-Google-Smtp-Source: ABdhPJyYxb2sGMCNEAHm5ala37cPOSV+iadH/fkL3XmUf96HbWpfFw5r1l8q9UAC1q8UkeO/UH2wlA==
X-Received: by 2002:a62:346:: with SMTP id 67mr14522608pfd.111.1594270900163; 
 Wed, 08 Jul 2020 22:01:40 -0700 (PDT)
Received: from localhost.localdomain
 (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id h15sm999974pjc.14.2020.07.08.22.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 22:01:39 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Thierry Reding <thierry.reding@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 0/5] iommu/arm-smmu: Support maintaining bootloader mappings
Date: Wed,  8 Jul 2020 22:01:40 -0700
Message-Id: <20200709050145.3520931-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jonathan Marek <jonathan@marek.ca>, linux-kernel@vger.kernel.org,
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

Based on previous attempts and discussions this is the latest attempt at
inheriting stream mappings set up by the bootloader, for e.g. boot splash or
efifb.

The first patch is an implementation of Robin's suggestion that we should just
mark the relevant stream mappings as BYPASS. Relying on something else to set
up the stream mappings wanted - e.g. by reading it back in platform specific
implementation code.

The series then tackles the problem seen in most versions of Qualcomm firmware,
that the hypervisor intercepts BYPASS writes and turn them into FAULTs. It does
this by allocating context banks for identity domains as well, with translation
disabled.

Lastly it amends the stream mapping initialization code to allocate a specific
identity domain that is used for any mappings inherited from the bootloader, if
above Qualcomm quirk is required.


The series has been tested and shown to allow booting SDM845, SDM850, SM8150,
SM8250 with boot splash screen setup by the bootloader. Specifically it also
allows the Lenovo Yoga C630 to boot with SMMU and efifb enabled.

Bjorn Andersson (5):
  iommu/arm-smmu: Make all valid stream mappings BYPASS
  iommu/arm-smmu: Emulate bypass by using context banks
  iommu/arm-smmu: Move SMR and S2CR definitions to header file
  iommu/arm-smmu-qcom: Consstently initialize stream mappings
  iommu/arm-smmu: Setup identity domain for boot mappings

 drivers/iommu/arm-smmu-qcom.c |  48 +++++++++++++
 drivers/iommu/arm-smmu.c      | 124 +++++++++++++++++++++++++++++-----
 drivers/iommu/arm-smmu.h      |  21 ++++++
 3 files changed, 175 insertions(+), 18 deletions(-)

-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
