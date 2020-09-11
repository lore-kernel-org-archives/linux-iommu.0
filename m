Return-Path: <SRS0=FRM4=CU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D980C2BC11
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 07:19:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED4152075A
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 07:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVitylsm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4152075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 98EF48774F;
	Fri, 11 Sep 2020 07:19:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BncY4B44JY1U; Fri, 11 Sep 2020 07:19:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9EC5287739;
	Fri, 11 Sep 2020 07:19:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A44EC0052;
	Fri, 11 Sep 2020 07:19:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91B16C0051
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 07:18:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8E1B186CF4
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 07:18:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YtdiJaiah6ji for <iommu@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 07:18:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com
 [209.85.216.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E1EA086AAA
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 07:18:58 +0000 (UTC)
Received: by mail-pj1-f66.google.com with SMTP id o16so1283445pjr.2
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 00:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=OyHRsDWTwMRTyzulbmLLOJZ2mID3gfkA/ty0RlUCJDw=;
 b=pVitylsmiIGpR7HJJYY+nmTP75Y8dGdivC+iP1craDz+Dt7dNeAW33YhMpCfl/ALzH
 X1NKkc2of3AFerdp6Vp03RAftGPfK/b8FaAqXj6TKEK+xyv+sH1HJxnhwBtECw9YS8sh
 5zddi9kzFe5Rq/mV03md5v8erurxvNYOSvbO9IxeCweylCYSOLw9tkUxnmFF0zYAo7Xn
 lc0eEJIdLYqpX7XBzlMpPli3iE3tOxG3wtFeTWQGgn4si6Nhe9iTnBG98nw++YXXGrSn
 4ndsfHUHjtYIiiho94cByNpq+7dqBuj1PH5FAuQdDMwdMItO4BgRQjcVLrBZ9D0bcFrc
 W+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=OyHRsDWTwMRTyzulbmLLOJZ2mID3gfkA/ty0RlUCJDw=;
 b=UH8XN/8vuatHW9NQDsmgDi/HhaXROtgm7ii+/HYw0AMCrM9bdzRVfELyVruhI81JYg
 GTXXvjtjteP/3TpFYh6Vd+t1800cUSHBZjsnDDado9WW/PuOcNF662J0m1Bj/AhqSEBU
 O7ckDyCCtg1ZD0Ce0Vfp0P9hljKOOhNgUJIVQP5AJPMv3Ht8VF43MdvWmkhmzXjRG02k
 m4x5y5NGPTt0/AXoCtoeYj3iuC8AoTiut2rqqp9VGxTUqqW+N8pyTX/nIeL5s/rOBfKN
 2m1IfNbZJVtwKa2Xekp/AK15uhSnI8KJhscPN4tXDCwew4uD05/2mQD4u6DxRqxuVkqb
 f2MA==
X-Gm-Message-State: AOAM530+MTXVsSEiEe+h5xCtF4pqzUeNhIewDLPEKFYgyNCcf39VL9iE
 jNu09vkPw+i2aFcyPAMOatU=
X-Google-Smtp-Source: ABdhPJxpn9KKgWHFYtD1mbU4KfkmnA+nP3POOmf8qz3WmWNf6rhS2ojWFubv5+VmZDNXVESJrncxQQ==
X-Received: by 2002:a17:90b:80a:: with SMTP id
 bk10mr997358pjb.53.1599808738474; 
 Fri, 11 Sep 2020 00:18:58 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id 131sm1264692pfc.20.2020.09.11.00.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 00:18:58 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: joro@8bytes.org,
	thierry.reding@gmail.com
Subject: [PATCH 0/3] iommu/tegra-smmu: Some small fixes
Date: Fri, 11 Sep 2020 00:16:40 -0700
Message-Id: <20200911071643.17212-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com
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

These are a series of small fixes for tegra-smmu driver.
They might not be critial bugs as current mainline does
not enable a lot of clients, but be nicer to have since
we are going to enable the DMA domain for other clients
in the near future.

Nicolin Chen (3):
  iommu/tegra-smmu: Do not use PAGE_SHIFT and PAGE_MASK
  iommu/tegra-smmu: Fix iova->phys translation
  iommu/tegra-smmu: Allow to group clients in same swgroup

 drivers/iommu/tegra-smmu.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
