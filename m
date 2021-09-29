Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74F6C433F5
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 02:33:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698736124A
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 02:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 698736124A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A7CB827A9;
	Wed, 29 Sep 2021 02:33:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i8pAInXhgNhn; Wed, 29 Sep 2021 02:33:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D4D89826DF;
	Wed, 29 Sep 2021 02:33:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 860BCC0011;
	Wed, 29 Sep 2021 02:33:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5C1BC000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 02:33:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 868E160BBE
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 02:33:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k8gCIl2nn3ac for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 02:33:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B975560BBD
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 02:33:10 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id t11so466770plq.11
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=s4D2m3+ZWSpbOoxTyd7Cgfd8aoV6x9f5QnXTQ4XHoJU=;
 b=mjb1HkkFEo/4kXpzKswwKo7ybpmTiqaMC1SZPvRXfskBLUGEYTTfVY8P/C3LAuJHi+
 ffXrSo/WgWYrdjlAf7i8QaoHE3qh6iNB2SfXImYtOOJDvRp+6XoErY67hPQWnn8erK+K
 QBUWG0efPgEgJhtXYBUzHZwwNfjKky5oP4Lis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=s4D2m3+ZWSpbOoxTyd7Cgfd8aoV6x9f5QnXTQ4XHoJU=;
 b=aIrZhU4lL0gswp2wKsq43T/O+tamEHgFTu5KePwjUO187m7F4wKLHzzuygqoWiGjS6
 UN5lyyEi0GgyX4dsdwoWkUbf79bp0T+ogP0YNSvAYiFF9gUfPn0NL1QbZrNcCbUy02ul
 ufMf+IbhXFAgAEoioyA98BpJkN8EleOtEk/lkv8FL26LJ8MFpnSGnof9OCxjior2gN6V
 NOwOVAGW4IHHaojllP8QTs2Jy6cbsLt2A2izzCZejDXhblWAi4Oi470NbpvIMBbXGC4q
 tr7+f+W9jMMvfXqONeAIor8DkXjFwQk9mH/TVcTYcKA3LzoRBSqQv0lQlKpZnhPB9sxU
 JJWw==
X-Gm-Message-State: AOAM533t798pSWlGTNs3Q42w7BRj4x3Sq+dDBiPLEeQibBI52bTBBEgT
 2pBfobEVXorm6gsgBqQIA5gUNQ==
X-Google-Smtp-Source: ABdhPJy/Xl7WpMkqbfI/8pobwf4sSQzGXJOOhZ9x/QA095lKKz/1QLB7sdtXt7FXoTcHkHNu+Vqwjg==
X-Received: by 2002:a17:90a:1b67:: with SMTP id
 q94mr3664963pjq.246.1632882790135; 
 Tue, 28 Sep 2021 19:33:10 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:f818:368:93ef:fa36])
 by smtp.gmail.com with UTF8SMTPSA id w142sm407779pfc.47.2021.09.28.19.33.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Sep 2021 19:33:09 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v8 0/7] Fixes for dma-iommu swiotlb bounce buffers
Date: Wed, 29 Sep 2021 11:32:53 +0900
Message-Id: <20210929023300.335969-1-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
 iommu@lists.linux-foundation.org, David Stevens <stevensd@chromium.org>,
 Rajat Jain <rajatja@google.com>, Will Deacon <will@kernel.org>
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
buffers for untrusted devices.

The min_align_mask issue was found when running fio on an untrusted nvme
device with bs=512. The other issues were found via code inspection, so
I don't have any specific use cases where things were not working, nor
any concrete performance numbers.

There are two issues related to min_align_mask that this patch series
does not attempt to fix. First, it does not address the case where
min_align_mask is larger than the IOVA granule. Doing so requires
changes to IOVA allocation, and is not specific to when swiotlb bounce
buffers are used. This is not a problem in practice today, since the
only driver which uses min_align_mask is nvme, which sets it to 4096.

The second issue this series does not address is the fact that extra
swiotlb slots adjacent to a bounce buffer can be exposed to untrusted
devices whose drivers use min_align_mask. Fixing this requires being
able to allocate padding slots at the beginning of a swiotlb allocation.
This is a rather significant change that I am not comfortable making.
Without being able to handle this, there is also little point to
clearing the padding at the start of such a buffer, since we can only
clear based on (IO_TLB_SIZE - 1) instead of iova_mask.

v7 -> v8:
 - Rebase on v5.15-rc3 and resolve conflicts with restricted dma

v6 -> v7:
 - Remove unsafe attempt to clear padding at start of swiotlb buffer
 - Rewrite commit message for min_align_mask commit to better explain
   the problem it's fixing
 - Rebase on iommu/core
 - Acknowledge unsolved issues in cover letter

v5 -> v6:
 - Remove unnecessary line break
 - Remove redundant config check

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
  dma-iommu: account for min_align_mask w/swiotlb

 drivers/iommu/dma-iommu.c | 188 +++++++++++++++++---------------------
 drivers/xen/swiotlb-xen.c |   2 +-
 include/linux/swiotlb.h   |   3 +-
 kernel/dma/swiotlb.c      |  13 ++-
 4 files changed, 94 insertions(+), 112 deletions(-)

-- 
2.33.0.685.g46640cef36-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
