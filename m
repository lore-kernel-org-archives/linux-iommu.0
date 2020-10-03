Return-Path: <SRS0=7D56=DK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9B0C4727F
	for <iommu@archiver.kernel.org>; Sat,  3 Oct 2020 07:06:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1BF6208A9
	for <iommu@archiver.kernel.org>; Sat,  3 Oct 2020 07:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyB0pDpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BF6208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 86012873A7;
	Sat,  3 Oct 2020 07:06:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QqYD-+FEDv64; Sat,  3 Oct 2020 07:06:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 74746872B8;
	Sat,  3 Oct 2020 07:06:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AA11C0889;
	Sat,  3 Oct 2020 07:06:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F2B6C0051
 for <iommu@lists.linux-foundation.org>; Sat,  3 Oct 2020 07:05:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7970C86C66
 for <iommu@lists.linux-foundation.org>; Sat,  3 Oct 2020 07:05:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PBpW3jMY6efd for <iommu@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 07:05:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CD87D86C0E
 for <iommu@lists.linux-foundation.org>; Sat,  3 Oct 2020 07:05:58 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id u24so2406685pgi.1
 for <iommu@lists.linux-foundation.org>; Sat, 03 Oct 2020 00:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=GKKFXutVq6JBEK8XjRJaqT5wjVrg16/0GsaLUpb8/ig=;
 b=UyB0pDppZuQygRa+/u02Y+YAu6ZQwnMMjnCIjVjZePLFuomQDp0ZEb8cIUvhuHP4ke
 qQJOxYhY5Rhc8/EPjXmP0zXixURSkXyHeHhZ2094zCvaw4dZx6DY6IqPF4WdziB3PA9V
 FmzOaugAvFQeOHyTh2DH+DrK1xgnzqUTq6nkfklmCdCbjncww5BZFCIJlCX/dPys/hMe
 flG61XM+YygIZfxgSDOKeE2xf0vC7QvsKGiBoVlrNg3I2Mf5V/tqmx00FwTVOpyFhIXM
 lsUi9JFVW2OOLPxysZJVWNwsvuOpANw4cVihDYt6vNs1nOfbS+ddtQVlv1xBqGA/tNIP
 3rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=GKKFXutVq6JBEK8XjRJaqT5wjVrg16/0GsaLUpb8/ig=;
 b=Ff8fqycJNnlNdtSSjLboeyGjBe4TTa83B0UVoyqvF7pnAmNOHD/uLLOtJEhhdeI+J7
 OW06kfcHC4UXXKcFL/DxeWRrcK2hf0P7CEvSS+22YUpcVXL4hTuBx+gxDo87GbYmwRjf
 bswVinWfx+CIbWYwQOUzvxU3mk/4hmFSJBE9wKorgNno72kWaaow7fetWhrBEXK68OzF
 5uATaIhSdKgrfdiaMd7CFJSn7XOq0U/kvvN48lpNP/nDrpE92Mny/z4c/x82WRdLWh75
 8tKGicvDACksLTLx3yPM0RctfnmKxiKv0Uo5yhIEtl2eOnd1ismxzzF6Dkl1MbqV3q1O
 G1qg==
X-Gm-Message-State: AOAM530RuBQPcGWcYbzQXlTQ8O42GdNIjITReHeffaWhEDDgqKHVrWnx
 EhouCrU13UeWIQPj1JConts=
X-Google-Smtp-Source: ABdhPJwWzCXCHgBMr3ABCAvMnsMEPZC0oefI+R/nGRotFLhuEtUwjYo0LbgwizMaVm/tkfxCQT64HA==
X-Received: by 2002:a63:4451:: with SMTP id t17mr5707137pgk.32.1601708758277; 
 Sat, 03 Oct 2020 00:05:58 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id d25sm3854498pgl.23.2020.10.03.00.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2020 00:05:57 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com,
	joro@8bytes.org,
	digetx@gmail.com
Subject: [PATCH v5 0/3] iommu/tegra-smmu: Add PCI support
Date: Fri,  2 Oct 2020 23:59:44 -0700
Message-Id: <20201003065947.18671-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com
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

This series is to add PCI support in tegra-smmu driver.

Changelog (Detail in each patch)
v4->v5
 * PATCH-1 Cleaned two variables inits
 * PATCH-2 Fixed put() in ->of_xlate() and Updated commit message
 * PATCH-3 Added Dmitry's Reviewed-by
v3->v4
 * Dropped helper function
 * Found another way to get smmu pointer
v2->v3
 * Replaced with devm_tegra_get_memory_controller
 * Updated changes by following Dmitry's comments
v1->v2
 * Added PATCH-1 suggested by Dmitry
 * Reworked PATCH-2 to unify certain code

Nicolin Chen (3):
  iommu/tegra-smmu: Use fwspec in tegra_smmu_(de)attach_dev
  iommu/tegra-smmu: Rework tegra_smmu_probe_device()
  iommu/tegra-smmu: Add PCI support

 drivers/iommu/tegra-smmu.c | 183 ++++++++++++-------------------------
 1 file changed, 59 insertions(+), 124 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
