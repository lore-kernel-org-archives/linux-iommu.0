Return-Path: <SRS0=iPMr=L7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB89C07E9C
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 07:55:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC18461C71
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 07:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC18461C71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B462B60676;
	Wed,  7 Jul 2021 07:55:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sVqLkDuTsrjr; Wed,  7 Jul 2021 07:55:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9376760665;
	Wed,  7 Jul 2021 07:55:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F77DC0010;
	Wed,  7 Jul 2021 07:55:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFCC6C000E
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 07:55:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BBC09831F2
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 07:55:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Is_1l7YfPKYZ for <iommu@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 07:55:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 19D8F831CB
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 07:55:27 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id g24so1044317pji.4
 for <iommu@lists.linux-foundation.org>; Wed, 07 Jul 2021 00:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PjKXBl1vkDCm5R1vUHFUBvPB60cGM9WwHmcZqOYFaT4=;
 b=OayDt65iTOThBSFcmD4oh4oPzMyU404O/oIJtWEBk2BRjGNINk4/xDEsCAFAZTe6JJ
 1II9FjTUeBHaGfRKcT5MKHRNfQrtmmyw+dcZhHo9t03MhaIKFlUSLvLuR88OeTzxnPZg
 j8I+hEoAqxDeJ11bruOBthi4wmvWdsdu1lo34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PjKXBl1vkDCm5R1vUHFUBvPB60cGM9WwHmcZqOYFaT4=;
 b=OZSQVRzCnPUtTQVZNH2xr3JoovGqGI0ctlWgh+Yo8THQr517Fxzu5NAE3TiTTzl+U6
 0UDhEOHYKv/v3d8uWYx6hRUPIiSDiCDY0AQt53xC+9mSYrlj7PDJ3GoDDVFg3VUUqelk
 QOtA3sYrCenEUOaNkrbVnnlLNmLJSPCmMaXtkwK1KU8doRG91MOaxoOebRM7WuudH4uY
 4agVTnqd2i05Oa3fEkeQ4Zs/kT+t8LrnZD2yW55cukHBpM9S+vBNpBqhaZoAsBWkFY6v
 DFa4395vcGuUNxaSIfMHDSI25ZkKxn3Afurymud1JaNhfwMeGu/LeWKRPUcU1ea0tlSR
 XAOg==
X-Gm-Message-State: AOAM533ohp1HHRjTrvd5y6+tm8dnYm28EesESGjClHWOzFb+0Iir2APJ
 91rGDbo+SBSSwIUx4KWGVO7ukw==
X-Google-Smtp-Source: ABdhPJy3lVBNCERAeNgH2dhv8lEGILoM8Wd2ReiG54LDKIxUvl1Yjm1vVuRmJjpNHq8Lw0hE9S41MA==
X-Received: by 2002:a17:902:db0d:b029:127:98e9:c279 with SMTP id
 m13-20020a170902db0db029012798e9c279mr20295192plx.0.1625644526545; 
 Wed, 07 Jul 2021 00:55:26 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:355a:c470:1237:e5f4])
 by smtp.gmail.com with UTF8SMTPSA id t13sm2035196pjq.14.2021.07.07.00.55.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jul 2021 00:55:25 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 0/4] Add dynamic iommu backed bounce buffers
Date: Wed,  7 Jul 2021 16:55:01 +0900
Message-Id: <20210707075505.2896824-1-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
 iommu@lists.linux-foundation.org, David Stevens <stevensd@google.com>,
 Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
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

Add support for per-domain dynamic pools of iommu bounce buffers to the 
dma-iommu API. This allows iommu mappings to be reused while still
maintaining strict iommu protection. Allocating buffers dynamically
instead of using swiotlb carveouts makes per-domain pools more amenable
on systems with large numbers of devices or where devices are unknown.

When enabled, all non-direct streaming mappings below a configurable
size will go through bounce buffers. Note that this means drivers which
don't properly use the DMA API (e.g. i915) cannot use an iommu when this
feature is enabled. However, all drivers which work with swiotlb=force
should work.

Bounce buffers serve as an optimization in situations where interactions
with the iommu are very costly. For example, virtio-iommu operations in
a guest on a linux host require a vmexit, involvement the VMM, and a
VFIO syscall. For relatively small DMA operations, memcpy can be
significantly faster.

As a performance comparison, on a device with an i5-10210U, I ran fio
with a VFIO passthrough NVMe drive with '--direct=1 --rw=read
--ioengine=libaio --iodepth=64' and block sizes 4k, 16k, 64k, and
128k. Test throughput increased by 2.8x, 4.7x, 3.6x, and 3.6x. Time
spent in iommu_dma_unmap_(page|sg) per GB processed decreased by 97%,
94%, 90%, and 87%. Time spent in iommu_dma_map_(page|sg) decreased
by >99%, as bounce buffers don't require syncing here in the read case.
Running with multiple jobs doesn't serve as a useful performance
comparison because virtio-iommu and vfio_iommu_type1 both have big
locks that significantly limit mulithreaded DMA performance.

This patch set is based on v5.13-rc7 plus the patches at [1].

David Stevens (4):
  dma-iommu: add kalloc gfp flag to alloc helper
  dma-iommu: replace device arguments
  dma-iommu: expose a few helper functions to module
  dma-iommu: Add iommu bounce buffers to dma-iommu api

 drivers/iommu/Kconfig          |  10 +
 drivers/iommu/Makefile         |   1 +
 drivers/iommu/dma-iommu.c      | 119 ++++--
 drivers/iommu/io-buffer-pool.c | 656 +++++++++++++++++++++++++++++++++
 drivers/iommu/io-buffer-pool.h |  91 +++++
 include/linux/dma-iommu.h      |  12 +
 6 files changed, 861 insertions(+), 28 deletions(-)
 create mode 100644 drivers/iommu/io-buffer-pool.c
 create mode 100644 drivers/iommu/io-buffer-pool.h

-- 
2.32.0.93.g670b81a890-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
