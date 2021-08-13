Return-Path: <SRS0=SLGw=NE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108BFC4338F
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 07:42:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A107D6104F
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 07:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A107D6104F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F92D40580;
	Fri, 13 Aug 2021 07:42:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BoYoxmPLxNjr; Fri, 13 Aug 2021 07:42:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0688A4053B;
	Fri, 13 Aug 2021 07:42:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D266BC001A;
	Fri, 13 Aug 2021 07:42:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56F6AC000E
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 07:42:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3355B4053E
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 07:42:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bVfvO3k35BQO for <iommu@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 07:42:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3AB6C4053B
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 07:42:34 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 qe12-20020a17090b4f8c00b00179321cbae7so4208475pjb.2
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 00:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lPsloz8dMJKQVghkZv9dWfHyOqdGc988vzlcGdOMiqs=;
 b=KLm6BU9Ld81zJP8v5wM43vhpaGeoR18x2sjWQKj6pS59bD+DnZpkv0NiHsY+D9t07C
 dRtIHNZpfka/ocJnIU9bqQwJ2/E+YoeQOgCavCt2eAZEu0MAmw6iKrCRqNxUU9v/iuem
 lWeRNYnqJz7xxC9TnA0OuTtDB+csJZF3sLQkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lPsloz8dMJKQVghkZv9dWfHyOqdGc988vzlcGdOMiqs=;
 b=cLQndrmSy63ddnskczOFqCtrbxvW/q8b1NKbZEFvyxTh5aXzOugPo7XBjU/x124LJN
 8wjtx8GnCcP32ihYlKrE3vzQKL1Fkq0rLdlPDAN2cOie3r18VsMT+Fp1Ks9Iigs5ZqBd
 Z4HtYYFI/oHev7KCZnCakps6cXGCNKTHl7kBKjnA2PQvM19cC5gY+HwhynDBhU61sVKU
 bfb0xKn1jOMTYwBIIQ/DwKq+tbi+aM0NC4uHh3TRh3NRRclGradc1V6T324nIW6f1CEl
 rqHywjeQlOdE2SzpHBCRxVCfz4qwqh+clLsqEIfZ7zr+4aK/EmqFrQXC93CO9l5BZxTS
 wypw==
X-Gm-Message-State: AOAM531OFkkP9U+SIT1jB2bY0dq845oXUwZPwjiPyW8af9/zDErhrJQy
 Y1qfXJTLJa2XT+2FyQxtf+D4CQ==
X-Google-Smtp-Source: ABdhPJzvmeADMrhG+LrPTQFy9EJDVmpdV2ijzdrQsWjP6jQVJIYcsouAqv40voGkNSNsJcOpsg9WZA==
X-Received: by 2002:aa7:973a:0:b029:3e0:9744:6460 with SMTP id
 k26-20020aa7973a0000b02903e097446460mr1168689pfg.63.1628840553663; 
 Fri, 13 Aug 2021 00:42:33 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:cbc8:5998:527e:5f43])
 by smtp.gmail.com with UTF8SMTPSA id q29sm1183232pfl.142.2021.08.13.00.42.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Aug 2021 00:42:33 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 0/6] Fixes for dma-iommu swiotlb bounce buffers
Date: Fri, 13 Aug 2021 16:38:33 +0900
Message-Id: <20210813073839.1562438-1-stevensd@google.com>
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

David Stevens (6):
  dma-iommu: fix sync_sg with swiotlb
  dma-iommu: fix arch_sync_dma for map
  dma-iommu: skip extra sync during unmap w/swiotlb
  dma-iommu: Check CONFIG_SWIOTLB more broadly
  swiotlb: support aligned swiotlb buffers
  dma-iommu: account for min_align_mask

 drivers/iommu/dma-iommu.c | 193 +++++++++++++++++---------------------
 include/linux/swiotlb.h   |   3 +-
 kernel/dma/swiotlb.c      |  11 ++-
 3 files changed, 97 insertions(+), 110 deletions(-)

-- 
2.33.0.rc1.237.g0d66db33f3-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
