Return-Path: <SRS0=7VEr=CT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55935C433E2
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 05:40:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E1C6207EA
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 05:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rXra2los"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1C6207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BDA2F204B0;
	Thu, 10 Sep 2020 05:40:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eClbdYKMltUn; Thu, 10 Sep 2020 05:40:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2706820471;
	Thu, 10 Sep 2020 05:40:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0494DC0859;
	Thu, 10 Sep 2020 05:40:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F27D0C0051
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 05:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C9B8A204A2
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 05:40:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4UQ4Ej5kmsG5 for <iommu@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 05:40:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by silver.osuosl.org (Postfix) with ESMTPS id 6A3D720471
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 05:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=GAlHdOT6xNBIXoRJTGjDfO8yxN+XWkHMSyYrbndYoes=; b=rXra2losZTDAUND7ZVSHxWZYp9
 O0bLx1ptf6BcC5QeKhuW38Lf8UWBywKGkwCs/qUGI5fa6K3Wo47yLmh+ur6K/PaChoT/tGFAxhcfB
 ub0IkMkCNn8zmoDDxv5Ga1FM9H3Llnp4yAc4H38rVR/D87e4VVNPsmj3sTrqj4NY/ll95s+l7RlB0
 aeZms3/a23jfo8wlpZ1fWP3dtIV+nqpRDfJEM1YB/0RAcM9KRXd9eflYS3vfBKqRTkX8ewEJaAWKu
 EB2yqu8Vmg5QAIVSz+rH5SsKaWoc/Avpgn0ZFhqfwiDyyGYPXlholm/TZWUcvLJuu7lgJQ3Z+5U2M
 v9Uq/JMA==;
Received: from [2001:4bb8:184:af1:d8d0:3027:a666:4c4e] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGFK2-0001sv-Sk; Thu, 10 Sep 2020 05:40:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>,
 Santosh Shilimkar <ssantosh@kernel.org>
Subject: support range based offsets in dma-direct
Date: Thu, 10 Sep 2020 07:40:35 +0200
Message-Id: <20200910054038.324517-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 linux-sh@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nathan Chancellor <natechancellor@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Hi all,

this series adds range-based offsets to the dma-direct implementation.  The
guts of the change are a patch from Jim with some modifications from me,
but to do it nicely we need to ARM patches to prepare for it as well.

Diffstat:
 arch/arm/common/dmabounce.c                        |    2 
 arch/arm/include/asm/dma-direct.h                  |   69 +++++++++++++++++
 arch/arm/include/asm/dma-mapping.h                 |   70 ------------------
 arch/arm/mach-keystone/keystone.c                  |   21 +++--
 arch/sh/drivers/pci/pcie-sh7786.c                  |    9 +-
 arch/x86/pci/sta2x11-fixup.c                       |    6 +
 drivers/acpi/arm64/iort.c                          |    6 +
 drivers/base/core.c                                |    2 
 drivers/gpu/drm/sun4i/sun4i_backend.c              |    8 +-
 drivers/iommu/io-pgtable-arm.c                     |    2 
 drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c |    9 ++
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c |   11 ++
 drivers/of/address.c                               |   73 ++++++++----------
 drivers/of/device.c                                |   44 +++++++----
 drivers/of/of_private.h                            |   11 +-
 drivers/of/unittest.c                              |   34 ++++++--
 drivers/remoteproc/remoteproc_core.c               |    4 -
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c     |   10 ++
 drivers/usb/core/message.c                         |    5 -
 drivers/usb/core/usb.c                             |    3 
 include/linux/device.h                             |    4 -
 include/linux/dma-direct.h                         |   52 +++++++++++--
 include/linux/dma-mapping.h                        |   19 ++++
 kernel/dma/coherent.c                              |    7 -
 kernel/dma/direct.c                                |   81 ++++++++++++++++++++-
 25 files changed, 373 insertions(+), 189 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
