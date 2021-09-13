Return-Path: <SRS0=sav6=OD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECC5C433F5
	for <iommu@archiver.kernel.org>; Mon, 13 Sep 2021 08:22:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBFD660FC0
	for <iommu@archiver.kernel.org>; Mon, 13 Sep 2021 08:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DBFD660FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 99693401CA;
	Mon, 13 Sep 2021 08:22:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vvgbbekTvIpk; Mon, 13 Sep 2021 08:22:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 369B3400C8;
	Mon, 13 Sep 2021 08:22:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E5C5C0011;
	Mon, 13 Sep 2021 08:22:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E978C000D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Sep 2021 08:22:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 05A75400E8
 for <iommu@lists.linux-foundation.org>; Mon, 13 Sep 2021 08:22:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AtE1-yMw2Oop for <iommu@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 08:22:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B98B3400C8
 for <iommu@lists.linux-foundation.org>; Mon, 13 Sep 2021 08:22:01 +0000 (UTC)
Received: by mail-yb1-xb31.google.com with SMTP id y13so18843642ybi.6
 for <iommu@lists.linux-foundation.org>; Mon, 13 Sep 2021 01:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hA5SjJKuJahGLX31luP7D8mzJxDC+SO2vk0Mq3zJOdo=;
 b=AoG98t+mNqkfbrBywtW3MJma5qtkX/dgD6g7VOb+c5S1n0FjUnL6yOa9luwzbDC0MB
 NnE4WQDAKNb7Je59De5Z5Z9iZwATFiDUbv4xqPOuTLfNgLnIZEiJWmT2uFI8AESauw1f
 PMZNUSu1450/2jJTr/yR85ZtWx7ev71h29DEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hA5SjJKuJahGLX31luP7D8mzJxDC+SO2vk0Mq3zJOdo=;
 b=ezEyMvTtWTGuPXcCu44bWgKoyAYSUPbHxbGdHg2Wt4ylqiKkK6x7/nK7d9isBw84b4
 xYNXtXVuKj7+gdGCCo+2FyI7N8IyslpVUSpWNP9bwJRFAdkXXFI5DjpzkuDa0e/WM5BM
 xw3OsaCkBEAS9pyibKT0jyucd048CZ9DT6McxMp/qIJ2shLqlYFUqF7yVp/paQhjbTS7
 A8+LAw9XvTWzHTdwEseYAbi1o9nsUPUpQTJpZZuaYBBqm/1EjcgeyJ6U7+Hv/x+URZxP
 uINuTD90TeMxDLbL3od3DBkUgSKC+fK14fik/aTFS4mHbbcgM90zbrbR4TLwSzTrFozI
 GWBQ==
X-Gm-Message-State: AOAM5321/gOxNQ/2LDhqBLHTBxcJpHZ9gObT4SvPFZhjneM51j8EayiS
 ocwp380ecQeNtsO2LvNoofb4zEWXYf7bliw2nKDvgg==
X-Google-Smtp-Source: ABdhPJyoIJv0HVf8WwdAxbVU4oGBg51HU76Y7j3Y3KgW0hMXTKS5AxkYn5ltcrEHX348TDlPO+2cPincRl0pRPxOhOo=
X-Received: by 2002:a25:a522:: with SMTP id h31mr14948997ybi.355.1631521320765; 
 Mon, 13 Sep 2021 01:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210830045925.4163412-1-stevensd@google.com>
In-Reply-To: <20210830045925.4163412-1-stevensd@google.com>
From: David Stevens <stevensd@chromium.org>
Date: Mon, 13 Sep 2021 17:21:49 +0900
Message-ID: <CAD=HUj5xXci8YX90H8zqY-aY5u_EJ8c8ZMoiMT2QXHz52oMy=w@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] Fixes for dma-iommu swiotlb bounce buffers
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc: David Stevens <stevensd@google.com>,
 open list <linux-kernel@vger.kernel.org>, Tom Murphy <murphyt7@tcd.ie>,
 iommu@lists.linux-foundation.org, Rajat Jain <rajatja@google.com>,
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

Is there further feedback on these patches? Only patch 7 is still
pending review.

-David

On Mon, Aug 30, 2021 at 2:00 PM David Stevens <stevensd@chromium.org> wrote:
>
> This patch set includes various fixes for dma-iommu's swiotlb bounce
> buffers for untrusted devices.
>
> The min_align_mask issue was found when running fio on an untrusted nvme
> device with bs=512. The other issues were found via code inspection, so
> I don't have any specific use cases where things were not working, nor
> any concrete performance numbers.
>
> There are two issues related to min_align_mask that this patch series
> does not attempt to fix. First, it does not address the case where
> min_align_mask is larger than the IOVA granule. Doing so requires
> changes to IOVA allocation, and is not specific to when swiotlb bounce
> buffers are used. This is not a problem in practice today, since the
> only driver which uses min_align_mask is nvme, which sets it to 4096.
>
> The second issue this series does not address is the fact that extra
> swiotlb slots adjacent to a bounce buffer can be exposed to untrusted
> devices whose drivers use min_align_mask. Fixing this requires being
> able to allocate padding slots at the beginning of a swiotlb allocation.
> This is a rather significant change that I am not comfortable making.
> Without being able to handle this, there is also little point to
> clearing the padding at the start of such a buffer, since we can only
> clear based on (IO_TLB_SIZE - 1) instead of iova_mask.
>
> v6 -> v7:
>  - Remove unsafe attempt to clear padding at start of swiotlb buffer
>  - Rewrite commit message for min_align_mask commit to better explain
>    the problem it's fixing
>  - Rebase on iommu/core
>  - Acknowledge unsolved issues in cover letter
>
> v5 -> v6:
>  - Remove unnecessary line break
>  - Remove redundant config check
>
> v4 -> v5:
>  - Fix xen build error
>  - Move _swiotlb refactor into its own patch
>
> v3 -> v4:
>  - Fold _swiotlb functions into _page functions
>  - Add patch to align swiotlb buffer to iovad granule
>  - Combine if checks in iommu_dma_sync_sg_* functions
>
> v2 -> v3:
>  - Add new patch to address min_align_mask bug
>  - Set SKIP_CPU_SYNC flag after syncing in map/unmap
>  - Properly call arch_sync_dma_for_cpu in iommu_dma_sync_sg_for_cpu
>
> v1 -> v2:
>  - Split fixes into dedicated patches
>  - Less invasive changes to fix arch_sync when mapping
>  - Leave dev_is_untrusted check for strict iommu
>
> David Stevens (7):
>   dma-iommu: fix sync_sg with swiotlb
>   dma-iommu: fix arch_sync_dma for map
>   dma-iommu: skip extra sync during unmap w/swiotlb
>   dma-iommu: fold _swiotlb helpers into callers
>   dma-iommu: Check CONFIG_SWIOTLB more broadly
>   swiotlb: support aligned swiotlb buffers
>   dma-iommu: account for min_align_mask w/swiotlb
>
>  drivers/iommu/dma-iommu.c | 188 +++++++++++++++++---------------------
>  drivers/xen/swiotlb-xen.c |   2 +-
>  include/linux/swiotlb.h   |   3 +-
>  kernel/dma/swiotlb.c      |  11 ++-
>  4 files changed, 93 insertions(+), 111 deletions(-)
>
> --
> 2.33.0.259.gc128427fd7-goog
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
