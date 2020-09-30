Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1665EC4741F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 08:48:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9409620738
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 08:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tawEvSKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9409620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2E80A84763;
	Wed, 30 Sep 2020 08:48:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HgUQ09RsEcPp; Wed, 30 Sep 2020 08:48:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9870584540;
	Wed, 30 Sep 2020 08:48:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7742CC0890;
	Wed, 30 Sep 2020 08:48:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F934C016F
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:48:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6C987203D0
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:48:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zHTJk78lcBOu for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 08:48:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by silver.osuosl.org (Postfix) with ESMTPS id AB5032035D
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:48:33 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id n14so708587pff.6
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 01:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=OeUNQJgXL6ADU3aSWn4q3FZBak46MGLmLY/1uCciSlU=;
 b=tawEvSKl8fLarJ1MeDSqmrrB/ZZe6NOzks0sfiE+mDFUB2q1PI8ELw4CMfK37xlB/v
 T7CrKPQCCmiF4B7QQo2pMjnsZnie39Dd68KkXI5D/SB5Hji+uS/WchCI55AqLMIX/8ho
 WF3dWY3NOSFG2wrauz2uncIiX6D1Z+lGsMQXUUHGPZsU5wZmKpgkTd5/0ymzw9aRXyOL
 qfnn//KXvnbALaAhVLxZzgoZppuWF7GDB7AaZyo0sF4ewSyJxMIfN7XXYYm+FHzUC+7I
 bEG2Cxp95EAuTKob8qMWY7p+ojNYO+BJ6kIBm0HNC5o8A4+4uD0ArOXBhWtKfqbQxoSW
 EHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=OeUNQJgXL6ADU3aSWn4q3FZBak46MGLmLY/1uCciSlU=;
 b=T6itX8aB8OHPgoulkGSNvDBMa/NE5urB+s6L0K0gNkDM0+iKUWrfGnT4yAzKlNtn5z
 6JHpil1b8BUa23x1RGBAXj7HWB1uDHMDFpITip2tTBAErlnMs61/fByQqoY8XH4qIZ2Q
 zEURLulkAdQ4Xs1WA7ObdA3bm/a3e5JMFgrFKrkLu7InlgTMVPjkf/FHY2e7ZbSl1ITj
 mAJRVt3KPaHB71kxMjeCNNn+ZzxlrP8dNIQ8u+eAJjg6eC0PL3ZWJBZq6YerCVH3E5u2
 QMBZKPn6p1pH10yI2bGDrbp6mGVu7qu+s4ZA8Ytrk/nG+5CSWIMsrmokz9R5K2e0zB8P
 58aA==
X-Gm-Message-State: AOAM5323/pqDF49gf2Q5x/W5x1ZqqfBiT8AhheaZkCBBAvT0BTQEJG+X
 md8iDSs/lPPTmh+nGL30coA=
X-Google-Smtp-Source: ABdhPJybvq/YLDpzffptolcGtF/N5En8KDtDWjqMjJ0PrfoI6Iuyksm+pPyBWDUvgijpRC7zcN6x3Q==
X-Received: by 2002:a62:301:0:b029:13c:1611:6528 with SMTP id
 1-20020a6203010000b029013c16116528mr1365997pfd.8.1601455713095; 
 Wed, 30 Sep 2020 01:48:33 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id d17sm1505830pfq.157.2020.09.30.01.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 01:48:32 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com, joro@8bytes.org, krzk@kernel.org,
 digetx@gmail.com
Subject: [PATCH v3 0/3] iommu/tegra-smmu: Add PCI support
Date: Wed, 30 Sep 2020 01:42:55 -0700
Message-Id: <20200930084258.25493-1-nicoleotsuka@gmail.com>
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

This series is to add PCI support with three changes:
PATCH-1 adds a helper function to get mc pointer
PATCH-2 adds support for clients that don't exist in DTB
PATCH-3 adds PCI support accordingly

Changelog (Detail in each patch)
v2->v3
 * Replaced with devm_tegra_get_memory_controller
 * Updated changes by following Dmitry's comments
v1->v2
 * Added PATCH-1 suggested by Dmitry
 * Reworked PATCH-2 to unify certain code

Dmitry Osipenko (1):
  memory: tegra: Add devm_tegra_get_memory_controller()

Nicolin Chen (2):
  iommu/tegra-smmu: Rework .probe_device and .attach_dev
  iommu/tegra-smmu: Add PCI support

 drivers/iommu/tegra-smmu.c | 179 +++++++++++++------------------------
 drivers/memory/tegra/mc.c  |  39 ++++++++
 include/soc/tegra/mc.h     |  17 ++++
 3 files changed, 118 insertions(+), 117 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
