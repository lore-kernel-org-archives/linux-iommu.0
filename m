Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42471A08C6
	for <iommu@lists.linux.dev>; Tue, 27 Aug 2024 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761159; cv=none; b=V+AL4nSUShEXIgp2QY97rAo7HqHe+Al6BEzf8HJLhKTNjP6nghDsBeqx4s+r907my1oRiYLx/VC+dqEUBC8HbuL8Bq1GQjHDunqqr/CVA4oxAFpZfdBr8LZVsZSJsIvW25LgBci9PBXGfXxMVv6xwhzsRFnCYL8TEEw5+Cx1h/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761159; c=relaxed/simple;
	bh=PY/odrZ7HFMDFloiTo+2Oa6vUtHjnrzFME+/EnQwvEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0pu32vbCNypFLEpFpLvdZVBsvFIWfe0XQEvActNXOhQc3ZH48HQDusaFzDKEnqmkA5uwTm4gxSMmtyIfnGsfcTjgEkutJpe0TMQ8jcUg6FyHJR9GjOk9QUwHIBqXblzcBISITzLXlhmIChqFfcFRxJShvY6lW5pOf1KNeTWQqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D0DCDA7;
	Tue, 27 Aug 2024 05:19:43 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 185FF3F762;
	Tue, 27 Aug 2024 05:19:14 -0700 (PDT)
Message-ID: <92ebdc16-7938-462a-bb0e-4d5d368c5eb1@arm.com>
Date: Tue, 27 Aug 2024 13:19:13 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] scsi: check that busses support the DMA API before
 setting dma parameters
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240824034925.1163244-1-hch@lst.de>
 <20240824034925.1163244-2-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240824034925.1163244-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/08/2024 4:49 am, Christoph Hellwig wrote:
> We'll start throwing warnings soon when dma_set_seg_boundary and
> dma_set_max_seg_size are called on devices for buses that don't fully
> support the DMA API.  Prepare for that by making the calls in the SCSI
> midlayer conditional.

Just thinking ahead, might it be worth a logical "are SG segment limits 
relevant?" wrapper around the dev->dma_parms reference? Not a big deal 
for now if we think this site is the only user, so either way,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/scsi_lib.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 3958a6d14bf457..7f0394c4492033 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1988,8 +1988,15 @@ void scsi_init_limits(struct Scsi_Host *shost, struct queue_limits *lim)
>   	if (shost->no_highmem)
>   		lim->features |= BLK_FEAT_BOUNCE_HIGH;
>   
> -	dma_set_seg_boundary(dev, shost->dma_boundary);
> -	dma_set_max_seg_size(dev, shost->max_segment_size);
> +	/*
> +	 * Propagate the DMA formation properties to the dma-mapping layer as
> +	 * a courtesy service to the LLDDs.  This needs to check that the buses
> +	 * actually support the DMA API first, though.
> +	 */
> +	if (dev->dma_parms) {
> +		dma_set_seg_boundary(dev, shost->dma_boundary);
> +		dma_set_max_seg_size(dev, shost->max_segment_size);
> +	}
>   }
>   EXPORT_SYMBOL_GPL(scsi_init_limits);
>   
