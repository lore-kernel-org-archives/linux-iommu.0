Return-Path: <SRS0=QSWf=I3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2EDC433DB
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:10:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40BC36193D
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BC36193D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03875838F7;
	Mon, 29 Mar 2021 00:10:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KUwIPLrlIeZW; Mon, 29 Mar 2021 00:10:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id E069683641;
	Mon, 29 Mar 2021 00:10:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1AD5C000B;
	Mon, 29 Mar 2021 00:10:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED259C000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:55:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D43BB605BE
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:55:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LDksCbw9AidM for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 23:55:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F2CF6605A7
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:55:58 +0000 (UTC)
Received: by mail-qk1-x736.google.com with SMTP id v70so10930839qkb.8
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 16:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NUiuzRmCI317NNPwOQd3D4rWQdmGZHrpIjp/qwsCZIQ=;
 b=uXWQRahp3gbzRLIyyNL0YRXhVCZtEuZiHzn/PIsuzG8877k5bJgwYQURdeOdvHz4vf
 UtOWDRp8hFHb4tkPHczneiCk1Dp3BAPe8nPUJPWphJIe8eEQsUMHA9EhMcfHmCfBv63h
 Cc6qgUFx9EvyH/PxY7kVGPUt16C7C6GHqSlgWmk/W3Nlz01gtqMgxdPyzK93UMSj/j8K
 RPiLrdcZHQGN/UMvJlD5XTJKRT5dQdkBl2Ur7I1OR5KPUc6a7GsZQevDW3l5YxrmCI0z
 r1yTXrRR5jXQtJQZlSGfd5Ol7iXIub51CMMgWplOjMM8chkK0lsTJMIbROp7cwk4m0P1
 +qgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NUiuzRmCI317NNPwOQd3D4rWQdmGZHrpIjp/qwsCZIQ=;
 b=m6SIdCpv856U0CxJ2KvFSYcT3SRGZPom1Apk53wvL9o1UskMYLEHQTQDLdwalIidXg
 OTDEG/yp7d9X6XBwlTFuQ04Ybs5BpRRH5OTGRdTrHcP5Ni2/Gzq/nEJWoa/hu+V+ZK7h
 +wLkd5OlJl9DzdEWe9Phg4Pb8G44Geqoyu3NJjriUZMU0p5YeTgzKqqj7QAZwI+s0p20
 qKEkXdVJfouToSpGGf8xpacvFoBjOLNUFQOV67wbUD6S4MkcvnoEl3vMjt2IymuKXDsf
 UaqQ/Rn/t9xYHyiw61ITIfDAImWHj3wgAjHAcHhmgZjXN11MY3uM3JUyKg6vylr197ZX
 pCZg==
X-Gm-Message-State: AOAM531NeXZNtTfhMVgYcN0JsFQzkiafzwKh31AZLQiePWUR07VFkIpE
 OIByl9n3CYGGD2Nmqebe5ek=
X-Google-Smtp-Source: ABdhPJyKaE6xu37zVH3z/CjmV3TkU5t17RBcANW7BpVJXHO+pgWwNEwtWueIieluVNk3R4I3c1/mYg==
X-Received: by 2002:a05:620a:cf4:: with SMTP id
 c20mr22554064qkj.134.1616975757870; 
 Sun, 28 Mar 2021 16:55:57 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:55:57 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 00/30] DMA: Mundane typo fixes
Date: Mon, 29 Mar 2021 05:22:56 +0530
Message-Id: <cover.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 29 Mar 2021 00:10:51 +0000
Cc: rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>,
 linux-kernel@vger.kernel.org
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

This patch series fixes some trivial and rudimentary spellings in the COMMENT
sections.

Bhaskar Chowdhury (30):
  acpi-dma.c: Fix couple of typos
  altera-msgdma.c: Couple of typos fixed
  amba-pl08x.c: Fixed couple of typos
  bcm-sba-raid.c: Few typos fixed
  bcm2835-dma.c: Fix a typo
  idma64.c: Fix couple of typos
  iop-adma.c: Few typos fixed
  mv_xor.c: Fix a typo
  mv_xor.h: Fixed a typo
  mv_xor_v2.c: Fix a typo
  nbpfaxi.c: Fixed a typo
  of-dma.c: Fixed a typo
  s3c24xx-dma.c: Fix a typo
  Revert "s3c24xx-dma.c: Fix a typo"
  s3c24xx-dma.c: Few typos fixed
  st_fdma.h: Fix couple of typos
  ste_dma40_ll.h: Fix a typo
  tegra20-apb-dma.c: Fixed a typo
  xgene-dma.c: Few spello fixes
  at_hdmac.c: Quite a few spello fixes
  owl-dma.c: Fix a typo
  at_hdmac_regs.h: Couple of typo fixes
  dma-jz4780.c: Fix a typo
  Kconfig: Change Synopsys to Synopsis
  ste_dma40.c: Few spello fixes
  dw-axi-dmac-platform.c: Few typos fixed
  dpaa2-qdma.c: Fix a typo
  usb-dmac.c: Fix a typo
  edma.c: Fix a typo
  xilinx_dma.c: Fix a typo

 drivers/dma/Kconfig                            |  8 ++++----
 drivers/dma/acpi-dma.c                         |  4 ++--
 drivers/dma/altera-msgdma.c                    |  4 ++--
 drivers/dma/amba-pl08x.c                       |  4 ++--
 drivers/dma/at_hdmac.c                         | 14 +++++++-------
 drivers/dma/at_hdmac_regs.h                    |  4 ++--
 drivers/dma/bcm-sba-raid.c                     |  8 ++++----
 drivers/dma/bcm2835-dma.c                      |  2 +-
 drivers/dma/dma-jz4780.c                       |  2 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c |  8 ++++----
 drivers/dma/idma64.c                           |  4 ++--
 drivers/dma/iop-adma.c                         |  6 +++---
 drivers/dma/mv_xor.c                           |  2 +-
 drivers/dma/mv_xor.h                           |  2 +-
 drivers/dma/mv_xor_v2.c                        |  2 +-
 drivers/dma/nbpfaxi.c                          |  2 +-
 drivers/dma/of-dma.c                           |  2 +-
 drivers/dma/owl-dma.c                          |  2 +-
 drivers/dma/s3c24xx-dma.c                      |  6 +++---
 drivers/dma/sh/shdmac.c                        |  2 +-
 drivers/dma/sh/usb-dmac.c                      |  2 +-
 drivers/dma/st_fdma.h                          |  4 ++--
 drivers/dma/ste_dma40.c                        | 10 +++++-----
 drivers/dma/ste_dma40_ll.h                     |  2 +-
 drivers/dma/tegra20-apb-dma.c                  |  2 +-
 drivers/dma/ti/edma.c                          |  2 +-
 drivers/dma/xgene-dma.c                        |  6 +++---
 drivers/dma/xilinx/xilinx_dma.c                |  2 +-
 28 files changed, 59 insertions(+), 59 deletions(-)

--
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
