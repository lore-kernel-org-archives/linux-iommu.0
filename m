Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B5A34F26F
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782727921; cv=none; b=Zl51Y54ewuOh+LHmsTcTtODjpw2866nuX2QRiB/ED70h18myNx/sfkFTYvqFXHsGrPvD/AY1zIDAyBNzWtMaSwEbo+NT1bxfaiO322hpSSCQ7NUwPtRw0pyBzSbjYcob5/nwmzOROtt7+29/DX9yaey4QHDv0q9FlFfVg9gK6FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782727921; c=relaxed/simple;
	bh=Au9s+ToVcqhsg1eeBDi2qQsnLGkQDNkDcGytyy/7fmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jaoyqgiThwvgKXOID7W86cznhWxM3YwHJ0rWOUqSwNZC+yRQfaB/PwcjS4ib7okEWWNOC+6GoMJhrU0Oi2DpSLHxr6Y3pWT+pTYwgLnF7p9lWYhDcCRGfbHBAz3MxB8p350wevrhjRpzEd65qzfgmSTAj/MCn4CthKAClSmpzc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=D54cPJDS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="D54cPJDS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 778851595;
	Mon, 29 Jun 2026 03:11:52 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 999553F836;
	Mon, 29 Jun 2026 03:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782727916; bh=Au9s+ToVcqhsg1eeBDi2qQsnLGkQDNkDcGytyy/7fmk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D54cPJDS3Xeh3vPYugL+dVyyzABp8jPfk6Mnbr75X6fbZq1S92zt7sSpVlK8oKy+f
	 JyJOJykSpOWWwmDIGjiq+xYDUwIYJK2+snzfcMFSHvdy4oX+/WPbDwE0xqkxu4FRTL
	 qEDr7lcMF33l6winKpmZXg6NaXBFc5SUXsKcj+6c=
Message-ID: <53d07679-b1bb-469c-acc2-981e75c071c9@arm.com>
Date: Mon, 29 Jun 2026 11:11:53 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dma-mapping: make dma_max_mapping_size() return 0 for
 no DMA capability
To: John Garry <john.g.garry@oracle.com>,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 m.szyprowski@samsung.com, hch@lst.de
Cc: linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
 ionut.nechita@windriver.com
References: <20260629085310.2298552-1-john.g.garry@oracle.com>
 <20260629085310.2298552-2-john.g.garry@oracle.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260629085310.2298552-2-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/06/2026 9:53 am, John Garry wrote:
> For when a device is not DMA capable, the max mapping size would be 0, so
> make dma_max_mapping_size() reflect that.

Seems logical.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   kernel/dma/mapping.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 4fe04669e5e66..7e576e5c6b8be 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -979,6 +979,9 @@ size_t dma_max_mapping_size(struct device *dev)
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
>   	size_t size = SIZE_MAX;
>   
> +	if (!dev->dma_mask)
> +		return 0;
> +
>   	if (dma_map_direct(dev, ops))
>   		size = dma_direct_max_mapping_size(dev);
>   	else if (use_dma_iommu(dev))

