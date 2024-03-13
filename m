Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33454087C
	for <iommu@lists.linux.dev>; Wed, 13 Mar 2024 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710333839; cv=none; b=MhCz6ht/ZwwPBsbCnxJwqkIx5idGXvlFdqmmgCc8bbPUK7R5OhgeKtmYjzL5d9AizFfCzOPBXILhsPhgiR0mcFrtnb5ue4uH0PzSctiNDdhPrUKVpf6F7R7odtHwrkWCZ/SmEHwM27hcjGj+8254sks18bToebBt94/Bhn36Eow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710333839; c=relaxed/simple;
	bh=JifDVMoaPXHaAUPJL3A+n8/jjHlsbgg+T4JcEzCN6DM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cW9cjCkffTctygx6PTAyp+QAVxOoG+uOg0Ed6nxEmx8NbpKZQ314THu0hWN6ULeOwraVTaQWDPXtLaVEntDZNT/aiHGbn6DpW1cju7vWe4hhHdcABuL1/QmhwXgDbJoCdJ2ueomhZLQHwqkmTubv9RdBtZZVLSj+VpXSCMjjvLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAE661007;
	Wed, 13 Mar 2024 05:44:33 -0700 (PDT)
Received: from [10.57.52.245] (unknown [10.57.52.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E38D53F762;
	Wed, 13 Mar 2024 05:43:54 -0700 (PDT)
Message-ID: <6b2fa7af-0fef-4c18-a6ff-1bf4ea16810f@arm.com>
Date: Wed, 13 Mar 2024 12:43:52 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] direct-dma: WARN_ON_ONCE when the page is not addressable
 by device's coherent_dma_mask
Content-Language: en-GB
To: John Hsu <john.hsu@mediatek.com>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: surenb@google.com, Chinwen Chang <chinwen.change@mediatek.com>,
 Casper Li <casper.li@mediatek.com>,
 Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240313121933.15839-1-john.hsu@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240313121933.15839-1-john.hsu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-13 12:19 pm, John Hsu wrote:
> From: JohnHsu <john.hsu@mediatek.com>
> 
> The dma_direct_alloc() may return null in some cases. For example, the
> allocated page is not addressable for the device's coherent_dma_mask,
> and the allocated page will be assigned to null.
> 
> This patch can WARN_ON_ONCE() when the returned page is null in
> dma_direct_alloc. It helps the developers position the root cause of
> allocation failure rapidly.

No. Failure to allocate a buffer can happen for any number of reasons, 
it is not specific to dma-direct, and in some cases it is even expected, 
hence why DMA_ATTR_NO_WARN exists. And either way it's still not a 
condition worthy of panicking when panic_on_warn is in use.

Sure, this may well be a handy development hack for debugging a 
particular driver which isn't handling failure correctly, but it is not 
suitable for mainline.

Thanks,
Robin.

> Signed-off-by: JohnHsu <john.hsu@mediatek.com>
> ---
>   kernel/dma/direct.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 9596ae1aa0da..a73b8ad1ef9e 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -156,6 +156,8 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>   		}
>   	}
>   
> +	WARN_ON_ONCE(!page);
> +
>   	return page;
>   }
>   
