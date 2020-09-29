Return-Path: <SRS0=l9dJ=DG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB66C47420
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 06:18:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEDDC20BED
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 06:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUx7CMc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDDC20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7DDEF84E8F;
	Tue, 29 Sep 2020 06:18:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1p9KzxoZv9IO; Tue, 29 Sep 2020 06:18:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B451C84DB8;
	Tue, 29 Sep 2020 06:18:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A40E8C0889;
	Tue, 29 Sep 2020 06:18:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC5A9C0051
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 06:18:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D24AB204FF
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 06:18:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eSGmgFwBW0Yw for <iommu@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 06:18:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
 [209.85.216.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 29332204FA
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 06:18:55 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id md22so3282066pjb.0
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 23:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=bR1c5zVE1/wtGNRr4qAxGHHpVpEDG879HmZTYWlE/G8=;
 b=fUx7CMc2F01xKbLmoLOoCpj/jkDlUK5sAdtumwTJWzrSIpPfAAEs4WVMaMmzXJfwuf
 W5W/mq16+8r6JKDur6Zdc7IehJAbBu7y2seYQWXnRhHAIMeJg4Z2ZzCgGBliT6t9N8TA
 LGTrxiKobVEpcojQg9Jv2g8paOfVdkk2NMNyGuDL4AARbl75lirK/vdu1tlkUvnIy7hJ
 Pny1ylEvtffgCTj0bSkihmjdmaBZ5DiDc+++4RbD80cxfkpsAm/0g8lXbWon62XsqxBM
 sJExeBaF7IDpPl/U+aRTX1Ltp0UNeQyyH/9Aujy/vhrC3zEd3hwYAJo7aoJyQFPtXrDl
 22Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=bR1c5zVE1/wtGNRr4qAxGHHpVpEDG879HmZTYWlE/G8=;
 b=hzo9iL0oBaPhc5RMF6rbOnwO1nNvuyDVpiSU9eEHsXxYV7GBay0bT6mSe+ruYU57Z2
 a2s8rnPvRR4/WbPnjXJEpHyBvi+3HpliMRVCVzc2fiTs9ZBrdZ/H1/NW0TOf+sQrwsTC
 jPId1B3544aVApNKY+JiPQA9pELRzlZmumpd7CQ+dKFvF5EQe3Z1MeHkH0E+SAIiKf7h
 cqafhgsutwiDIYANYmcwfmwkn/i8R9hU9KoPwySRoFdLQv90BtaxjyJDwn20/SbspoQC
 m85a8+pd9wRTU54SGqDkKjh91TI4Nrl+cJT3D6EmURI59LqjSIW0PBBPhR5CK20Z3cJ4
 p18Q==
X-Gm-Message-State: AOAM5320Gy/tBD3a7nsHHNyq1ONGPlMlULAGx5XqlWLehtoyhefpYjFZ
 +jSucp7cm/ul/8K4ZchPDJM=
X-Google-Smtp-Source: ABdhPJzQmA4H34YEh2eRTAYZ9Szt4fmd9lwDaFSywAcg4Rghwf09cTORXan9bkhbsq+oer8yiNUXbw==
X-Received: by 2002:a17:90a:b314:: with SMTP id d20mr458540pjr.7.1601360334679; 
 Mon, 28 Sep 2020 23:18:54 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id cf7sm3280562pjb.52.2020.09.28.23.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 23:18:54 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com,
	joro@8bytes.org
Subject: [PATCH v4 0/2] iommu/tegra-smmu: Two followup changes
Date: Mon, 28 Sep 2020 23:13:23 -0700
Message-Id: <20200929061325.10197-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, hch@infradead.org, linux-tegra@vger.kernel.org,
 digetx@gmail.com
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
v3->v4:
 * PATCH-2: Fixed typo in subject
v2->v3:
 * PATCH-2: renamed "err_unlock" to "unlock"
v1->v2:
 * Separated first two changs of V1 so they may get applied first,
   since the other three changes need some extra time to finalize.

Nicolin Chen (2):
  iommu/tegra-smmu: Unwrap tegra_smmu_group_get
  iommu/tegra-smmu: Expand mutex protection range

 drivers/iommu/tegra-smmu.c | 53 ++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
