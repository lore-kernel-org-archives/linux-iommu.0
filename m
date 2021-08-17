Return-Path: <SRS0=VUzA=NI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93DDC4338F
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 01:39:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4847660EAF
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 01:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4847660EAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 186AD607DC;
	Tue, 17 Aug 2021 01:39:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zri_w8tbp7JP; Tue, 17 Aug 2021 01:39:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9AD2E607C5;
	Tue, 17 Aug 2021 01:39:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7660FC001A;
	Tue, 17 Aug 2021 01:39:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CB08C000E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 01:39:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0AFD1402D2
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 01:39:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id izyuJDiQwUUu for <iommu@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 01:39:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F3E7A402D5
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 01:39:14 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 hv22-20020a17090ae416b0290178c579e424so3452259pjb.3
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 18:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HaeVCqVLYGePRZHRPgpZyDyc+9DsWOQG8K5wim8K06M=;
 b=az8HGc8lPGq1zGtlBUJkUyNQT27hlrF90LkVRdo0UIiQJgLiJ6Ny1/2Y8nVoP/1QaN
 LEWf8yGDarQC0dgQJbiekX805OjNYM8A32yK535SnlBVNuRgDXBPo0k9mW9e1q2evHtM
 dFLG/Mxh0ee/DFG3rVBkLdMHTKykJwgvtXaL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HaeVCqVLYGePRZHRPgpZyDyc+9DsWOQG8K5wim8K06M=;
 b=O/ZnsfBAjlm/gsFaSfre4tB2qhLCikpItiJsaTf+YGSYyrMI+/vsT1AzPrIS5hU4LF
 S9UCKA/NJYc7Yt3IVMnN3QYNc75W/IyvDJu+jU//V/ngiLJ9VvHXsPwLAVjZyFWiJdaz
 1kJL2LdTUaHoXODtrtIQBHDQmYY+lQfzMl7h4xsXXCkLkEtWfBzDh62kmtuCuuF4w/Rn
 b/WDQPFLD607DLTu+eMT9SoWkO2Nej3au+6UHGoIYdRkX0HXPrgi+N4G+TLPR8AEgMxu
 A/mnLlfgple9PDifqxbjdFDRjsfc7iXN4vRDcv4ljzynw0Ctr04EccNooe7btDhXUQce
 7qkA==
X-Gm-Message-State: AOAM530fPwgN/xDNLcg947n4kUaW7RLQFXF3gErnpfHU9C+k26KT7lrs
 PJCh3LUYGIInKkrX2enwLQZsKg==
X-Google-Smtp-Source: ABdhPJx3pzb8ovk9BInxryDeR1SaMMI6lCp8NNmr4FVx6wgLcXHHX7VG/9xlN4KDklvXGSusqc+EOQ==
X-Received: by 2002:a17:90a:c57:: with SMTP id
 u23mr908312pje.186.1629164354448; 
 Mon, 16 Aug 2021 18:39:14 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:6864:767c:2ff8:749d])
 by smtp.gmail.com with UTF8SMTPSA id k9sm393131pfu.109.2021.08.16.18.39.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Aug 2021 18:39:13 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 0/7] Fixes for dma-iommu swiotlb bounce buffers
Date: Tue, 17 Aug 2021 10:38:45 +0900
Message-Id: <20210817013852.3222824-1-stevensd@google.com>
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
  dma-iommu: account for min_align_mask

 drivers/iommu/dma-iommu.c | 191 +++++++++++++++++---------------------
 drivers/xen/swiotlb-xen.c |   2 +-
 include/linux/swiotlb.h   |   3 +-
 kernel/dma/swiotlb.c      |  11 ++-
 4 files changed, 96 insertions(+), 111 deletions(-)

-- 
2.33.0.rc1.237.g0d66db33f3-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
