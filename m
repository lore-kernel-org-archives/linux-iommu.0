Return-Path: <SRS0=NM95=BQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47052C433DF
	for <iommu@archiver.kernel.org>; Thu,  6 Aug 2020 15:54:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C0223136
	for <iommu@archiver.kernel.org>; Thu,  6 Aug 2020 15:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6SO5z7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C0223136
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C5A0986F77;
	Thu,  6 Aug 2020 15:54:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vGS7GNC2Ghct; Thu,  6 Aug 2020 15:54:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A06FF86F7E;
	Thu,  6 Aug 2020 15:54:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8578FC0050;
	Thu,  6 Aug 2020 15:54:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57F97C004C
 for <iommu@lists.linux-foundation.org>; Thu,  6 Aug 2020 15:54:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3A3F58814A
 for <iommu@lists.linux-foundation.org>; Thu,  6 Aug 2020 15:54:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fGOUwP5ukKek for <iommu@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 15:54:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 46C1888120
 for <iommu@lists.linux-foundation.org>; Thu,  6 Aug 2020 15:54:08 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id di22so28339955edb.12
 for <iommu@lists.linux-foundation.org>; Thu, 06 Aug 2020 08:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=O+ufeIly26hH0HVmgJKBo9pM+PAzFRO+Yv7COUuQIJo=;
 b=R6SO5z7N72KtfknpWpSlCKTbeB/0zDuyBWmEmGrL/iBpFU2SRozwszNFSBCuGR8ZMf
 XdTFXpawMMuAuNV/6/EDPgAJVxePs27K7gYczFkiMWA6plwzAoLcrWHQAMzVaBJzfVtQ
 zMsr5F9GOrBNwGm3zMRmIOswiuzaebXIQnOcIaa6FWX0oVWN6FQIY2+5Qudu2eyLV16t
 WEdasvBvmfLPXI40zDN2OYfMsV/TABIXiXPSVVid5Z5n7hmprxD63WkG8wGjMttmJCuq
 nuQxMp1bBWW9eKWsaw8TGjWyEyB+hJaT5e4UdyV9RRz30iInDqb55QpUcHTgfOO302/T
 ClmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=O+ufeIly26hH0HVmgJKBo9pM+PAzFRO+Yv7COUuQIJo=;
 b=BN80xr1WRbLZqmgpYQ4rC0Dg4ZtIHBoDjOEz+OC4460bunz1zJw+q8qHYFdkbnJbO8
 Umr32g+RQKTrPS3Hm9/492w1RL0PRP16TGViyhBpjr+GcgHdH3r+MorCaC5lua0eoW3b
 REUwzXlK2xm6qWR7l2ID7zoFtSeFkKVD6ZIhYzf8trceGAFkJ8jx2KQzu2VVCGYy9iiG
 16wjmC+YH0xwoXtr8DL26e+1F1/PlvCCENI4sbc/fPRp0DG1k1Pbo8Pd8JGV6/BPWDWh
 i7tZYRGLNb0epbSLVdVvj8+tnk/jjv45aAH1Xw+vKH2OazVSK53We0bwdvKBgcqGFm2T
 lWRg==
X-Gm-Message-State: AOAM533hzLV/559xobSHgltrgm37QrCuqRzNVpdCkT6T7rz1FsYE15pA
 ok6DnnDN3Uj2+pE02ULpmCE=
X-Google-Smtp-Source: ABdhPJyPwZ6Q04MNu67pZ1O1nuhWiXIm8oC4MsQ55Qogir4NVqKRn01KwQylpRo9pqoFSDhTqVkaJg==
X-Received: by 2002:a05:6402:33a:: with SMTP id
 q26mr4973328edw.8.1596729246587; 
 Thu, 06 Aug 2020 08:54:06 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id b16sm3741696edy.73.2020.08.06.08.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 08:54:05 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/3] iommu/tegra-smmu: Reference count fixes
Date: Thu,  6 Aug 2020 17:54:01 +0200
Message-Id: <20200806155404.3936074-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jon Hunter <jonathanh@nvidia.com>
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

From: Thierry Reding <treding@nvidia.com>

I was running into some use-after-free conditions after recent changes
to the host1x driver cause the child devices to be destroyed upon driver
unloading. This in turn caused the IOMMU groups associated with the
child devices to also get released and that uncovered a subtle reference
count unbalance.

This contains two fixes for these issues and also includes a patch that
sets the IOMMU group name for "static" groups to help with debugging.

Thierry

Thierry Reding (3):
  iommu/tegra-smmu: Set IOMMU group name
  iommu/tegra-smmu: Balance IOMMU group reference count
  iommu/tegra-smmu: Prune IOMMU group when it is released

 drivers/iommu/tegra-smmu.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
