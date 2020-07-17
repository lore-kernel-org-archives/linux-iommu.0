Return-Path: <SRS0=Ppoz=A4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27ABFC433E3
	for <iommu@archiver.kernel.org>; Fri, 17 Jul 2020 00:16:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E304F20787
	for <iommu@archiver.kernel.org>; Fri, 17 Jul 2020 00:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BowF3PwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E304F20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8B47088089;
	Fri, 17 Jul 2020 00:16:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5jNw0c0i4bpg; Fri, 17 Jul 2020 00:16:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DE8F487FB0;
	Fri, 17 Jul 2020 00:16:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C18DEC07FF;
	Fri, 17 Jul 2020 00:16:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 351E7C0733
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 00:16:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2870A87FB0
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 00:16:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A2ARdRhK8DbL for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jul 2020 00:16:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5126C8805C
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 00:16:22 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id s189so5762686pgc.13
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 17:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Sl4GNsmArDLipzZLi4IQVk0TOodt16D37OUgWF5KbPo=;
 b=BowF3PwOju4VnW5jUNBztNr1QHxUEqy6HgjuXfuKh5dztvWW9CDzCYmzt53X4es9xV
 RlSOQ69RWaykSCNTQqfIuQTyahoqTJ1Qq+wjNd4t3mq49H33azZSu94Wo3tTp/EzNMSV
 Y7UAuPuqAEvl7l9bkXQPh6qsQiSrCiD4TjJykBMTSgncyJJM0WV9KQ+tzStfHur3Qed+
 yW2tN0Ig6kRObfnuHsbUU6oHen8rYu7+FKCPneQuomx9XugKY1Jzu2LOxVUi+TupWX+z
 MIKZFc9U6nQIH+p0hDJ+v8GeWcFYgfr4eM2FCi1Loloh4liZ0bxGo7kKE1bkyL7CHWQ+
 kJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Sl4GNsmArDLipzZLi4IQVk0TOodt16D37OUgWF5KbPo=;
 b=iZPCzLMW3EAZsUwawe/7cmSa1vs6yzclKZmR8nGJm19ZdkY+eUYCKryihy/3NgjoqD
 yDhgB7LQUolwwJmqlAMZ++mDJSGzn2VKk1BGB1iNwVUYhJyILdOv8eg1qV2IhdyiHKRj
 a9iq0ei4d6dMwvD9S/bFSTOkudIGIGmbV5NNUpF9UVb565O1EAQRBhaTbbQbTjkuntJ4
 EW22wx7XCc76a/AUCShC3+EPMAHqcdgCAPAihcSz5Z0HgLbtDex5OerPibatPQYNojrN
 Bpnl4V++zjAhxX+UMsq034ShFd9n2bbkv3qQSA5+upuOtx9QMvFDtrUlRyLDXQrYMhna
 wNwQ==
X-Gm-Message-State: AOAM531k9sr70n+NlYOGyOiXizbCLjliyVM9kip6x04E82Swax+CYqeZ
 G7ZgibLr8FOJIg0D1CiCupseyQ==
X-Google-Smtp-Source: ABdhPJyyEAViHTA6jZ1fWkKlx3Fq/q+F6yP4gOxKkTTTvDCGA+QkPdiuE8amuhBa7Q2HIfcbSX2LeA==
X-Received: by 2002:a65:6089:: with SMTP id t9mr6633639pgu.236.1594944981548; 
 Thu, 16 Jul 2020 17:16:21 -0700 (PDT)
Received: from localhost.localdomain
 (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id r7sm6211950pgu.51.2020.07.16.17.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 17:16:20 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Thierry Reding <thierry.reding@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 0/5] iommu/arm-smmu: Support maintaining bootloader mappings
Date: Thu, 16 Jul 2020 17:16:14 -0700
Message-Id: <20200717001619.325317-1-bjorn.andersson@linaro.org>
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
  iommu/arm-smmu-qcom: Consistently initialize stream mappings
  iommu/arm-smmu: Setup identity domain for boot mappings

 drivers/iommu/arm-smmu-qcom.c |  48 +++++++++++++
 drivers/iommu/arm-smmu.c      | 123 +++++++++++++++++++++++++++++-----
 drivers/iommu/arm-smmu.h      |  21 ++++++
 3 files changed, 174 insertions(+), 18 deletions(-)

-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
