Return-Path: <SRS0=l9dJ=DG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B625C47420
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 04:58:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C212E208FE
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 04:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUW4NrwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C212E208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7CD5A204F5;
	Tue, 29 Sep 2020 04:58:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wvKpgOAuTUAM; Tue, 29 Sep 2020 04:58:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7F36F2046A;
	Tue, 29 Sep 2020 04:58:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 601C8C0889;
	Tue, 29 Sep 2020 04:58:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EF1BC0051
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 04:58:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 286F385BD3
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 04:58:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SjAUtAUaHu1e for <iommu@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 04:58:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D833C847AC
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 04:58:21 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id k13so3361815pfg.1
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=WcAzkOGZ9dG56NRxUJHzwDEuHInbnX4+CA+UxuupEp0=;
 b=jUW4NrwIs8MohyGXB00UM3IYkVbNLJrSbtsx+ak2jvFMxkiLP5OThwhdzydCBj+4aO
 1A2JKQx6dZzPII++txHZexC0KSNT4RuG0ZnGi0swjX0iOGXQ6AV+qOjH28a6km+MrZnW
 bGDhzvyiURSz2mk57bNFM8/Udd5Uq9q4pF8YdupE1uMC9NZnnXUEepv3KrSxObm0Xc+t
 cKnufRpf2PwL17nfy2STHYbzqZPWJta+GGiFwIIMzIXtJ5cEjOXqpVQu2Pyyul00q44Z
 Tf/zcCox22dqYsFFZF/mk9P8lm40WmPfNeL63PdIUAVbfqb1aC9YISt4c3/xrCci6mjJ
 XuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=WcAzkOGZ9dG56NRxUJHzwDEuHInbnX4+CA+UxuupEp0=;
 b=rw43hvIjbWzjYdlOWD7dVS2WuR3tnkhEcwX/TVR3wUCLVnFSfmJCfdVWPEecVRtA7Q
 lNgTDiOZwCT8Z1HlNVGsPFwPA7SeBVD8ZW4P1mV5AlYr1cKga0xa3EiUvx9AExAuUr0F
 nhHT/GF1NmuMiSk3dL8EE7zFuXJS2SxaCdjQ6Np7spNQisjAxOeomSVzsLrLR0e/FOWQ
 KNIBcP0l+LObHu9VeOgcxPDvswxA84GSThNR506poAFXO0XfNVFbYH2FUR3YxTbIBBsN
 DEfcbUdFbgMROIdydwvekIbok5mYAo9Y3vcReATr1xYlpQwey3g6WBZ/660JE3d8hV9M
 XcMw==
X-Gm-Message-State: AOAM5311hzgvNBXgZcAqlVtZGiot4M8uN/aoBLGkmtX6duN1ZovfO6rX
 AcaP6QUUeQBBjwFotnBuCfA=
X-Google-Smtp-Source: ABdhPJw1G14Ap4d06yym2CPFSTcMb1VvQeJfuKHlk49EQq1LAZ3bmf8jgRBcjURIS3ZDNqEAeHBSUQ==
X-Received: by 2002:a63:1b57:: with SMTP id b23mr1806815pgm.81.1601355501207; 
 Mon, 28 Sep 2020 21:58:21 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id f207sm3739028pfa.54.2020.09.28.21.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 21:58:20 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com,
	joro@8bytes.org
Subject: [PATCH v3 0/2] iommu/tegra-smmu: Two followup changes
Date: Mon, 28 Sep 2020 21:52:45 -0700
Message-Id: <20200929045247.15596-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org, digetx@gmail.com
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

Two followup patches for tegra-smmu:
PATCH-1 is a clean-up patch for the recently applied SWGROUP change.
PATCH-2 fixes a potential race condition

Changelog
v2->v3:
 * PATCH-2: renamed "err_unlock" to "unlock"
v1->v2:
 * Separated first two changs of V1 so they may get applied first,
   since the other three changes need some extra time to finalize.

Nicolin Chen (2):
  iommu/tegra-smmu: Unwrap tegra_smmu_group_get
  iommu/tegra-smmu: Expend mutex protection range

 drivers/iommu/tegra-smmu.c | 53 ++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
