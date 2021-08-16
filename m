Return-Path: <SRS0=tZpB=NH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE12C4338F
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 02:59:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 631936140B
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 02:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 631936140B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22A7980C02;
	Mon, 16 Aug 2021 02:59:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9JxLhew8ctjS; Mon, 16 Aug 2021 02:59:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A8CB880BBF;
	Mon, 16 Aug 2021 02:59:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A8E8C001A;
	Mon, 16 Aug 2021 02:59:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18763C000E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 02:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E8EE560602
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 02:59:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1s5SdTXmsGxv for <iommu@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 02:59:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EE5FB605B0
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 02:59:22 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id u15so3766566plg.13
 for <iommu@lists.linux-foundation.org>; Sun, 15 Aug 2021 19:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JJmx8LsBVfoygzSD05ZwIHQxzCJmHnV38QWqOATHelQ=;
 b=UVjsELPlAK1AHNHzU1tOH9RD3UEOCFs/XiDEkQu85qGgQhihCL+7Kps3O0thUqfL/e
 GfiZ/sOyOJ+LVL7/YjWVL5z0LA90PO98DPklo9HOXVhQmM+KYLqWBUgsdC0DIGPg+7Gp
 mMnYwGbGRGTS9BR5Dhey8TkCOg3NmlAaGliRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JJmx8LsBVfoygzSD05ZwIHQxzCJmHnV38QWqOATHelQ=;
 b=ABlSt9Wwt6xkdMmjydJ5dN2RuscWpg6wTQb3Go4zz2kUfrvMhH4RRj/HLg3Qv0pPQb
 rqgRooGdP0X87jsak/Wzgs3kTfRslpJRNgX429xcxpMDN4GOqFbyLVrdzqqA2kyB5T4A
 qlHn8tBBNYepCq/5kNBn7laAygYs1SVUSVl7MJrMjsaOLba7M0soywX3Qg8lInkWZEv+
 WmCB0bVirw8Pr7hrfMb4UCKinP1I+a+iJryKD8cX+fsJtig0NEsr/DtGPd6WxTsRtBDe
 0DramvdXwwBeeEn29DQqktczV3oO/mTdkSNqq5P/iZqoA88egZTs2tFn4blgyG5IiPnO
 EiWw==
X-Gm-Message-State: AOAM5312Lf/F/cX6MqkA9Mgaa51hoFKOWLjYSJtN9B0lJu8MWVdN1grJ
 +OkPCpMaIEdFbhNBASYM47k7Lw==
X-Google-Smtp-Source: ABdhPJwUVs9a4JAM6gHL66U95qsAW2lmlophZEsPwfhMxRcipFC7Q/ovkUqDwjuu70xU9CEV2z6zzg==
X-Received: by 2002:a62:5c6:0:b029:341:e0b1:a72c with SMTP id
 189-20020a6205c60000b0290341e0b1a72cmr13967618pff.71.1629082762342; 
 Sun, 15 Aug 2021 19:59:22 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:17b8:f07a:2a52:317a])
 by smtp.gmail.com with UTF8SMTPSA id 21sm9195739pfh.103.2021.08.15.19.59.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Aug 2021 19:59:21 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 0/7] Fixes for dma-iommu swiotlb bounce buffers
Date: Mon, 16 Aug 2021 11:57:48 +0900
Message-Id: <20210816025755.2906695-1-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
 iommu@lists.linux-foundation.org, David Stevens <stevensd@chromium.org>,
 Will Deacon <will@kernel.org>
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

From: David Stevens <stevensd@chromium.org>

This patch set includes various fixes for dma-iommu's swiotlb bounce
buffers for untrusted devices. There are four fixes for correctness
issues, one for a performance issue, and one for general cleanup.

The min_align_mask issue was found when running fio on an untrusted nvme
device with bs=512. The other issues were found via code inspection, so
I don't have any specific use cases where things were not working, nor
any concrete performance numbers.

v4 -> v5:
 - Fix xen build error
 - Move _swiotlb refactor into its own patch

v3 -> v4:
 - Fold _swiotlb functions into _page functions
 - Add patch to align swiotlb buffer to iovad granule
 - Combine if checks in iommu_dma_sync_sg_* functions

v2 -> v3:
 - Add new patch to address min_align_mask bug
 - Set SKIP_CPU_SYNC flag after syncing in map/unmap
 - Properly call arch_sync_dma_for_cpu in iommu_dma_sync_sg_for_cpu

v1 -> v2:
 - Split fixes into dedicated patches
 - Less invasive changes to fix arch_sync when mapping
 - Leave dev_is_untrusted check for strict iommu

David Stevens (7):
  dma-iommu: fix sync_sg with swiotlb
  dma-iommu: fix arch_sync_dma for map
  dma-iommu: skip extra sync during unmap w/swiotlb
  dma-iommu: fold _swiotlb helpers into callers
  dma-iommu: Check CONFIG_SWIOTLB more broadly
  swiotlb: support aligned swiotlb buffers
  dma-iommu: account for min_align_mask

 drivers/iommu/dma-iommu.c | 193 +++++++++++++++++---------------------
 drivers/xen/swiotlb-xen.c |   2 +-
 include/linux/swiotlb.h   |   3 +-
 kernel/dma/swiotlb.c      |  11 ++-
 4 files changed, 98 insertions(+), 111 deletions(-)

-- 
2.33.0.rc1.237.g0d66db33f3-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
