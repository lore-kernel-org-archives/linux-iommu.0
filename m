Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E09335B5
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 05:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719898981; cv=none; b=PNNxU3W7DaXgEVY418z40/V83a0D+6x6FjI3YS53BQS/4Y8uYvGYgZQJaVDw94e23ChlTobR8P0n21bG0KYybZEZjYKb+yCoYj5NC9ayYz8bBDG3WetzsAZcNFzG+D47CPWAVF7az6h9hXwwePjiTXg14MOSX1ioBGURbbtl02M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719898981; c=relaxed/simple;
	bh=esiAP32KVMqSCDoDEUg5OeBa3oPnhXiS2SjgngyYTCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4roPWn/RrNYdXVgi1NkT1V4uKvIQxNa6HCF1xEQFEIhxyxmLgtsI9yklsDI7s2HUx/D9GwWgCjHj8HXiEOcY8t/jntuxnAG7rjw5P/PZN30iPpZlrWDFsgqFRgQrLmHl6ZA1F/cUAERlVpW3CHoCNAJtMlq1iA/MXIItEDrcuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FvBqmHI5; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FvBqmHI5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719898977;
	bh=esiAP32KVMqSCDoDEUg5OeBa3oPnhXiS2SjgngyYTCM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FvBqmHI5QSG6PLNjYhl4coC4sujtELF3mLHrLfRgGGeJEtpTsPAa/jd8k5KQwWIRw
	 o29viYrHJIh5+LgStVF7iO4tumF1lo7g0txDjyW89J/Xy/c87h8PiuL8bdXTuROCob
	 hSDUTJCck7mJPCleSkLAXM9sh3C8EraTdeGl+ene1nozidnY6lZYIUnpFwkP/92+eL
	 yiEqozHOHjDVzBoQRS796JHzGbronmKkcGV0Lxp5Z4GvSuU4zfp2GoIGZWpJ/sPULJ
	 dOefj+o1pLp/chHC8gqiFuL3CZETX0Mb0JTPfLt3vPT9L6UmT7Sv3RQetgRcMNf1Yg
	 MjjTBUpTujpMw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 866DC37811EB;
	Tue,  2 Jul 2024 05:42:56 +0000 (UTC)
Message-ID: <f648b751-482e-46ba-8ef2-8d04c0633c2c@collabora.com>
Date: Tue, 2 Jul 2024 07:42:55 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Remove iommu_sva_unbind_gpasid
To: Mark-PK Tsai <mark-pk.tsai@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: yj.chiang@mediatek.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240628113011.3535-1-mark-pk.tsai@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240628113011.3535-1-mark-pk.tsai@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 28/06/24 13:30, Mark-PK Tsai ha scritto:
> This is a left over of commit 0c9f17877891
> ("iommu: Remove guest pasid related interfaces and definitions")
> 
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>

Please also fix the documentation, after which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   include/linux/iommu.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 17b3f36ad843..225403cfe614 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -785,8 +785,6 @@ extern int iommu_attach_device(struct iommu_domain *domain,
>   			       struct device *dev);
>   extern void iommu_detach_device(struct iommu_domain *domain,
>   				struct device *dev);
> -extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> -				   struct device *dev, ioasid_t pasid);
>   extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
>   extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
>   extern int iommu_map(struct iommu_domain *domain, unsigned long iova,


