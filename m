Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0469C433E0
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 15:10:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5655764DF7
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 15:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5655764DF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 072B78651A;
	Thu, 28 Jan 2021 15:10:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DSAjxQWxuFRQ; Thu, 28 Jan 2021 15:10:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DAFF4860CF;
	Thu, 28 Jan 2021 15:10:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C18BDC0FA7;
	Thu, 28 Jan 2021 15:10:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9006CC013A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 15:10:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 72F1C860F8
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 15:10:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AUITfWpdZ3Oy for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 15:09:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A0CBE860CF
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 15:09:59 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4C75668AFE; Thu, 28 Jan 2021 16:09:55 +0100 (CET)
Date: Thu, 28 Jan 2021 16:09:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Tomasz Figa <tfiga@chromium.org>, Ricardo Ribalda <ribalda@chromium.org>,
 Sergey Senozhatsky <senozhatsky@google.com>,
 iommu@lists.linux-foundation.org
Subject: Re: [PATCH 6/6] media: uvcvideo: Use dma_alloc_noncontiguos API
Message-ID: <20210128150955.GA30563@lst.de>
References: <20210128145837.2250561-1-hch@lst.de>
 <20210128145837.2250561-7-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210128145837.2250561-7-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-doc@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
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

I just included this patch as-is, but here are a few comments:

On Thu, Jan 28, 2021 at 03:58:37PM +0100, Christoph Hellwig wrote:
> +static void uvc_urb_dma_sync(struct uvc_urb *uvc_urb, bool for_device)
> +{
> +	struct device *dma_dev = dma_dev = stream_to_dmadev(uvc_urb->stream);
> +
> +	if (for_device)
> +		dma_sync_sgtable_for_device(dma_dev, uvc_urb->sgt,
> +					    DMA_FROM_DEVICE);
> +	else
> +		dma_sync_sgtable_for_cpu(dma_dev, uvc_urb->sgt,
> +					 DMA_FROM_DEVICE);
> +}

Given that we vmap the addresses this also needs
flush_kernel_vmap_range / invalidate_kernel_vmap_range calls for
VIVT architectures.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
