Return-Path: <SRS0=0/ZC=DY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B0FC433E7
	for <iommu@archiver.kernel.org>; Sat, 17 Oct 2020 04:39:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB88C207C4
	for <iommu@archiver.kernel.org>; Sat, 17 Oct 2020 04:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HVEf5OkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB88C207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 819DA8896D;
	Sat, 17 Oct 2020 04:39:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QyI4VAGPaevA; Sat, 17 Oct 2020 04:39:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2252B88923;
	Sat, 17 Oct 2020 04:39:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08F3DC1AD4;
	Sat, 17 Oct 2020 04:39:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2B33C0051
 for <iommu@lists.linux-foundation.org>; Sat, 17 Oct 2020 04:39:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C7790204CE
 for <iommu@lists.linux-foundation.org>; Sat, 17 Oct 2020 04:39:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7WqTUCOeUOop for <iommu@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 04:39:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com
 [209.85.161.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 53DD02E1FC
 for <iommu@lists.linux-foundation.org>; Sat, 17 Oct 2020 04:38:27 +0000 (UTC)
Received: by mail-oo1-f67.google.com with SMTP id z1so1148638ooj.3
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 21:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jVnRyUolr4BwE4IUvjoP1hOl3uNRFzt0UHkql5BKxNw=;
 b=HVEf5OkLA30lu7upPvgEAndNVgt9ByZLqZTN/3I7N0TGKpMYQPhEsQYecMcOoebQyM
 bKuU+MbxXCtvME9FcPcSHZV4Yt7sBLvFW3+q5Jq2f96uBFzyvZuIspFmN4HKnzxjwZlp
 e848Pu0nxdhikSe2csuI84B7/P23eaagd0nvZcVINR5cG1eNf4aD/05JzmpkjI1hR5cT
 LxQbczsWlIIm5rviRJQiPAx1r5Ay/DrGNjtfo1dq2NyBymD6oxyeKP2fEszZJTvZU/0k
 YnxCii5fSMpJN8VG+vsEW4NereiOoihx+FNYJgAEi+bRBaWZjELqL9Ie9l51k9C3Casa
 KdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jVnRyUolr4BwE4IUvjoP1hOl3uNRFzt0UHkql5BKxNw=;
 b=eWShxTrWKl7ILSUzB9uE8hr3G4R6ytQd1H0b38UWn1tDJxxM+E5Sm7jPUGineyFtTi
 B1gRfNoNjo3EM12mhTQuZswNcL3OF7sASpzo6X1yIDzwGfIAmKP+UJhdhr6YmKVfGgYa
 d4xxDbFovJR8OvpsKAEBvIpM9QZgtLF3SL06KRiFRoppbCQR8FKhdr/rqoxzyvAgPNZk
 AX14WynmLzZSyZwJZquV+OCMMogba1zNPIDiHs2apY2uy7dMEZxSEwVLt4Z+k82LRPcS
 70J0TbmLQMH8VXO5HeTvvjhqKD8KcvoKCsiqWH2RHMf1INoFlKmsnLF6fRqTdOXgqdS/
 myZQ==
X-Gm-Message-State: AOAM531WM46Uc0O6E2m+VXGZ/7Pl9U4orHyH1ba7al2ODEC9vpbx3dwh
 YxtFZzyKqEQZPZIQIelJEySv4A==
X-Google-Smtp-Source: ABdhPJwK8Wa0Cux+ocIv9R1uy4sNW7NQ7SRmBhK1inNU0eLZjbU5Tvm0NB7XDk+asw3bkJ7gicxBHg==
X-Received: by 2002:a4a:d654:: with SMTP id y20mr5047456oos.90.1602909506462; 
 Fri, 16 Oct 2020 21:38:26 -0700 (PDT)
Received: from localhost.localdomain
 (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id t65sm1640038oib.50.2020.10.16.21.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 21:38:25 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Jordan Crouse <jcrouse@codeaurora.org>,
 Thierry Reding <treding@nvidia.com>, Rob Clark <robdclark@chromium.org>
Subject: [PATCH v4 0/3] iommu/arm-smmu-qcom: Support maintaining bootloader
 mappings
Date: Fri, 16 Oct 2020 21:39:04 -0700
Message-Id: <20201017043907.2656013-1-bjorn.andersson@linaro.org>
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

This is the fourth attempt of inheriting the stream mapping for the framebuffer
on many Qualcomm platforms, in order to not hit catastrophic faults during
arm-smmu initialization.

The new approach does, based on Robin's suggestion, take a much more direct
approach with the allocation of a context bank for bypass emulation and use of
this context bank pretty much isolated to the Qualcomm specific implementation.

As before the patchset has been tested to boot DB845c (with splash screen) and
Lenovo Yoga C630 (with EFI framebuffer).

Bjorn Andersson (3):
  iommu/arm-smmu: Allow implementation specific write_s2cr
  iommu/arm-smmu-qcom: Read back stream mappings
  iommu/arm-smmu-qcom: Implement S2CR quirk

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 92 ++++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 22 ++++--
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  1 +
 3 files changed, 107 insertions(+), 8 deletions(-)

-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
