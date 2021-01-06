Return-Path: <SRS0=DPil=GJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF216C433E0
	for <iommu@archiver.kernel.org>; Wed,  6 Jan 2021 03:41:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE5F208C3
	for <iommu@archiver.kernel.org>; Wed,  6 Jan 2021 03:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE5F208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E287F22D10;
	Wed,  6 Jan 2021 03:41:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m+QAqluO+nLp; Wed,  6 Jan 2021 03:41:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D0FD52048A;
	Wed,  6 Jan 2021 03:41:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0E97C0891;
	Wed,  6 Jan 2021 03:41:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86C1DC013A
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 03:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 656A586AF8
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 03:41:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tv7bzMPO7iXD for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 03:41:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DCEC1869F2
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 03:41:32 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id p12so239982pju.5
 for <iommu@lists.linux-foundation.org>; Tue, 05 Jan 2021 19:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=U3TpLfW+vImhvH0nGRTRbZCkU/q6uvDGxQ/ffdS/DVM=;
 b=akatZ9qvuVqvk7jTIGmhjfDVt/R+fkDe7KGtuV2FiL0W9X0lfcwuxwQ5SDHkDWvo/Y
 OU4FPQJAhXwq03c8Ys0HNgl+IupiV5k8xFok85r5ImLAz1DYG9c87lF8ePniw4ZUVnDj
 udHjYJ0V3gqIMjH0S4jHAYa5kPGyqU1QS8adQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=U3TpLfW+vImhvH0nGRTRbZCkU/q6uvDGxQ/ffdS/DVM=;
 b=Yga/Odh8GFqoEAx4cSjVIFLCHuTzuZB5wxC8JZJbIQ6RoZcSwGUjZtfxJFeqD8ugxN
 8rAaNqRSAQ3qTOCuJgbGW+vjP1/xMwIpEdoJ0ycQ75cfClTOtJWXRGyk8Jt/lp9sHkQH
 K1BOpKcdM8e6VA0NMTzfmoXG9Q3VprzETNa2dj73ZOgiv1fm7nAK1jTCNteJvGjexke4
 35ciOumVddJuXwYn9b/wL72KCOxoucyPVydkwg1GjODgisZGPLlpodIFJhvCD4OWViLA
 gAjB6hxz0WsHMyZxdsGikzitQGBWkKQE57Wm8hNWciZktG1vuzzbgxNzqydutQZXeRwU
 KEsw==
X-Gm-Message-State: AOAM533LPKLCFTh+mihr9OisU723bcQjkO2/qWA02TAQBQi07SrLCmnW
 UzUmOEbzayGfpxeLSLql9zIBwg==
X-Google-Smtp-Source: ABdhPJzMVJXWuHdnqMMSkgz9jt5n+Akn+pP0QJigxunJGEBd/ODEkJmP1Ra/LRA2SYqMSUv/fxQHkA==
X-Received: by 2002:a17:90a:4582:: with SMTP id
 v2mr1714522pjg.58.1609904492458; 
 Tue, 05 Jan 2021 19:41:32 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
 by smtp.gmail.com with ESMTPSA id v10sm544816pjr.47.2021.01.05.19.41.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Jan 2021 19:41:31 -0800 (PST)
From: Claire Chang <tientzu@chromium.org>
To: robh+dt@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 paulus@samba.org, joro@8bytes.org, will@kernel.org, frowand.list@gmail.com,
 konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com,
 sstabellini@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
 robin.murphy@arm.com
Subject: [RFC PATCH v3 0/6] Restricted DMA
Date: Wed,  6 Jan 2021 11:41:18 +0800
Message-Id: <20210106034124.30560-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org, grant.likely@arm.com,
 mingo@kernel.org, drinkcat@chromium.org, saravanak@google.com,
 xypron.glpk@gmx.de, rafael.j.wysocki@intel.com, bgolaszewski@baylibre.com,
 xen-devel@lists.xenproject.org, treding@nvidia.com, devicetree@vger.kernel.org,
 Claire Chang <tientzu@chromium.org>, dan.j.williams@intel.com,
 andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
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

This series implements mitigations for lack of DMA access control on
systems without an IOMMU, which could result in the DMA accessing the
system memory at unexpected times and/or unexpected addresses, possibly
leading to data leakage or corruption.

For example, we plan to use the PCI-e bus for Wi-Fi and that PCI-e bus is
not behind an IOMMU. As PCI-e, by design, gives the device full access to
system memory, a vulnerability in the Wi-Fi firmware could easily escalate
to a full system exploit (remote wifi exploits: [1a], [1b] that shows a
full chain of exploits; [2], [3]).

To mitigate the security concerns, we introduce restricted DMA. Restricted
DMA utilizes the existing swiotlb to bounce streaming DMA in and out of a
specially allocated region and does memory allocation from the same region.
The feature on its own provides a basic level of protection against the DMA
overwriting buffer contents at unexpected times. However, to protect
against general data leakage and system memory corruption, the system needs
to provide a way to restrict the DMA to a predefined memory region (this is
usually done at firmware level, e.g. in ATF on some ARM platforms).

[1a] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_4.html
[1b] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_11.html
[2] https://blade.tencent.com/en/advisories/qualpwn/
[3] https://www.bleepingcomputer.com/news/security/vulnerabilities-found-in-highly-popular-firmware-for-wifi-chips/

Claire Chang (6):
  swiotlb: Add io_tlb_mem struct
  swiotlb: Add restricted DMA pool
  swiotlb: Use restricted DMA pool if available
  swiotlb: Add restricted DMA alloc/free support.
  dt-bindings: of: Add restricted DMA pool
  of: Add plumbing for restricted DMA pool

 .../reserved-memory/reserved-memory.txt       |  24 +
 arch/powerpc/platforms/pseries/svm.c          |   4 +-
 drivers/iommu/dma-iommu.c                     |  12 +-
 drivers/of/address.c                          |  21 +
 drivers/of/device.c                           |   4 +
 drivers/of/of_private.h                       |   5 +
 drivers/xen/swiotlb-xen.c                     |   4 +-
 include/linux/device.h                        |   4 +
 include/linux/swiotlb.h                       |  61 +-
 kernel/dma/Kconfig                            |   1 +
 kernel/dma/direct.c                           |  20 +-
 kernel/dma/direct.h                           |  10 +-
 kernel/dma/swiotlb.c                          | 576 +++++++++++-------
 13 files changed, 514 insertions(+), 232 deletions(-)

-- 
2.29.2.729.g45daf8777d-goog

v3: 
  Using only one reserved memory region for both streaming DMA and memory
  allocation.

v2:
  Building on top of swiotlb.
  https://lore.kernel.org/patchwork/cover/1280705/

v1:
  Using dma_map_ops.
  https://lore.kernel.org/patchwork/cover/1271660/
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
