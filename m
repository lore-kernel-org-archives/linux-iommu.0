Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B65C433E6
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 20:24:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7956208CA
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 20:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7956208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9F6A6868B5;
	Tue,  1 Sep 2020 20:24:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3ti+ZJzNAnVM; Tue,  1 Sep 2020 20:24:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 98E73868B4;
	Tue,  1 Sep 2020 20:24:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90B73C0052;
	Tue,  1 Sep 2020 20:24:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A3C0C0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 20:24:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 35E2A86479
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 20:24:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vtb_lm-TOlVj for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 20:24:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 034F8861F2
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 20:24:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BAF91063;
 Tue,  1 Sep 2020 13:24:49 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C94E3F66F;
 Tue,  1 Sep 2020 13:24:47 -0700 (PDT)
Subject: Re: [PATCH v9 31/32] media: pci: fix common ALSA DMA-mapping related
 codes
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063629eucas1p1a3c9c93e281b4c432a6d9940e734e3c4@eucas1p1.samsung.com>
 <20200826063316.23486-32-m.szyprowski@samsung.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <925232f3-7371-c7eb-ad31-4b041cbbca4f@arm.com>
Date: Tue, 1 Sep 2020 21:24:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200826063316.23486-32-m.szyprowski@samsung.com>
Content-Language: en-GB
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-08-26 07:33, Marek Szyprowski wrote:
> The Documentation/DMA-API-HOWTO.txt states that dma_map_sg returns the
> numer of the created entries in the DMA address space. However the
> subsequent calls to dma_sync_sg_for_{device,cpu} and dma_unmap_sg must be
> called with the original number of entries passed to dma_map_sg. The
> sg_table->nents in turn holds the result of the dma_map_sg call as stated
> in include/linux/scatterlist.h. Adapt the code to obey those rules.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/media/pci/cx23885/cx23885-alsa.c | 2 +-
>   drivers/media/pci/cx25821/cx25821-alsa.c | 2 +-
>   drivers/media/pci/cx88/cx88-alsa.c       | 2 +-
>   drivers/media/pci/saa7134/saa7134-alsa.c | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/pci/cx23885/cx23885-alsa.c b/drivers/media/pci/cx23885/cx23885-alsa.c
> index df44ed7393a0..3f366e4e4685 100644
> --- a/drivers/media/pci/cx23885/cx23885-alsa.c
> +++ b/drivers/media/pci/cx23885/cx23885-alsa.c
> @@ -129,7 +129,7 @@ static int cx23885_alsa_dma_unmap(struct cx23885_audio_dev *dev)
>   	if (!buf->sglen)
>   		return 0;
>   
> -	dma_unmap_sg(&dev->pci->dev, buf->sglist, buf->sglen, PCI_DMA_FROMDEVICE);
> +	dma_unmap_sg(&dev->pci->dev, buf->sglist, buf->nr_pages, PCI_DMA_FROMDEVICE);

If we're touching these lines anyway, we should update them to use the 
modern DMA_FROM_DEVICE definitions too.

Robin.

>   	buf->sglen = 0;
>   	return 0;
>   }
> diff --git a/drivers/media/pci/cx25821/cx25821-alsa.c b/drivers/media/pci/cx25821/cx25821-alsa.c
> index 301616426d8a..c40304d33776 100644
> --- a/drivers/media/pci/cx25821/cx25821-alsa.c
> +++ b/drivers/media/pci/cx25821/cx25821-alsa.c
> @@ -193,7 +193,7 @@ static int cx25821_alsa_dma_unmap(struct cx25821_audio_dev *dev)
>   	if (!buf->sglen)
>   		return 0;
>   
> -	dma_unmap_sg(&dev->pci->dev, buf->sglist, buf->sglen, PCI_DMA_FROMDEVICE);
> +	dma_unmap_sg(&dev->pci->dev, buf->sglist, buf->nr_pages, PCI_DMA_FROMDEVICE);
>   	buf->sglen = 0;
>   	return 0;
>   }
> diff --git a/drivers/media/pci/cx88/cx88-alsa.c b/drivers/media/pci/cx88/cx88-alsa.c
> index 7d7aceecc985..3c6fe6ceb0b7 100644
> --- a/drivers/media/pci/cx88/cx88-alsa.c
> +++ b/drivers/media/pci/cx88/cx88-alsa.c
> @@ -332,7 +332,7 @@ static int cx88_alsa_dma_unmap(struct cx88_audio_dev *dev)
>   	if (!buf->sglen)
>   		return 0;
>   
> -	dma_unmap_sg(&dev->pci->dev, buf->sglist, buf->sglen,
> +	dma_unmap_sg(&dev->pci->dev, buf->sglist, buf->nr_pages,
>   		     PCI_DMA_FROMDEVICE);
>   	buf->sglen = 0;
>   	return 0;
> diff --git a/drivers/media/pci/saa7134/saa7134-alsa.c b/drivers/media/pci/saa7134/saa7134-alsa.c
> index 544ca57eee75..398c47ff473d 100644
> --- a/drivers/media/pci/saa7134/saa7134-alsa.c
> +++ b/drivers/media/pci/saa7134/saa7134-alsa.c
> @@ -313,7 +313,7 @@ static int saa7134_alsa_dma_unmap(struct saa7134_dev *dev)
>   	if (!dma->sglen)
>   		return 0;
>   
> -	dma_unmap_sg(&dev->pci->dev, dma->sglist, dma->sglen, PCI_DMA_FROMDEVICE);
> +	dma_unmap_sg(&dev->pci->dev, dma->sglist, dma->nr_pages, PCI_DMA_FROMDEVICE);
>   	dma->sglen = 0;
>   	return 0;
>   }
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
