Received: from mail-m19731105.qiye.163.com (mail-m19731105.qiye.163.com [220.197.31.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8003942DFFD
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773135215; cv=none; b=NOzdMINVbgeYqZnDOeoUFCrLWXQ6mY5etioScQzA93HRIexwf6TJQhE+PflF7k/G1eXKsIF7tditV61nUWFawpRMa4ffHlXNFJ1t3heXiB73cLiRWUiSxrXO5K4TiYN68NlFrrn9B/OgIzUkRoLIY1ukDP93tJqW2rQJAdwQxHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773135215; c=relaxed/simple;
	bh=HSVzwIdfC/FJZEROZTHHCdDNg4P077yMQ90rKvarKUo=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pR33Hc7lQ3IQtl2sQ+/3LpoKOFnXWRd6YehSmpm1zt9DdlbBRA3lkhvNgB2VnwVEcBvNPN9k4CccwMLcxT/6iJ9KXWuKXGuNd4y9kLxZgFYyDJNmdvVEpjRWgpkYOzlJwzqM0SADg27S68pVQSS5EJ3UhiLvqg5U96rFqBc8aQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=LfN4T1hy; arc=none smtp.client-ip=220.197.31.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="LfN4T1hy"
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3665d3ef2;
	Tue, 10 Mar 2026 17:33:22 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/rockchip: Drop global rk_ops in favor of per-device
 ops
To: Simon Xue <xxm@rock-chips.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Heiko Stuebner <heiko@sntech.de>
References: <20260310084812.126082-1-xxm@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <a2719902-e5cb-bd4d-4eb4-a01371a57aed@rock-chips.com>
Date: Tue, 10 Mar 2026 17:33:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260310084812.126082-1-xxm@rock-chips.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9cd718098809cckunm7907381ceb4dc
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkxKSFZCTUIdSkpCHkpCTxhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=LfN4T1hyZ7F/Fgc3GdQa6KkyTJsBBYXeMneDyaHtkZD66iT4bIqkSGQ+21SreSvQnHOsDGsZPoyJML87v5z5OGZ3hpaF3rLUmaeCanZdLysYoiEe1/WhuqnTqYue/i9OmmJWrM4Uo+vjt3wmtvTkMaY0A1mI5Ls2sqt30XxO3BY=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=mBTi+Diqk25yIasnhVjZ42wpi09vWfP+RtyQmstJvHA=;
	h=date:mime-version:subject:message-id:from;

Hi Simon,

在 2026/03/10 星期二 16:48, Simon Xue 写道:
> The driver currently uses a global rk_ops pointer, forcing all IOMMU
> instances to share the same operations. This restricts the driver from
> supporting SoCs that might integrate different versions of IOMMU hardware.
> 
> Since the IOMMU framework passes the master device information to
> iommu_paging_domain_alloc(), the global variable is no longer needed.
> 
> Fix this by moving rk_ops into struct rk_iommu and struct rk_iommu_domain.
> Initialize it per-device during probe via of_device_get_match_data(),
> and replace all global references with the instance-specific pointers.
> 
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> ---

...

>   					 SPAGE_SIZE, DMA_TO_DEVICE);
> @@ -1212,15 +1215,7 @@ static int rk_iommu_probe(struct platform_device *pdev)
>   	iommu->num_mmu = 0;
>   
>   	ops = of_device_get_match_data(dev);

Could you remove this one-time-used ops variable and use iommu->rk_ops
directly. The other parts make sense to me.

> -	if (!rk_ops)
> -		rk_ops = ops;
> -
> -	/*
> -	 * That should not happen unless different versions of the
> -	 * hardware block are embedded the same SoC
> -	 */
> -	if (WARN_ON(rk_ops != ops))
> -		return -EINVAL;
> +	iommu->rk_ops = ops;
>   
>   	iommu->bases = devm_kcalloc(dev, num_res, sizeof(*iommu->bases),
>   				    GFP_KERNEL);
> @@ -1286,7 +1281,7 @@ static int rk_iommu_probe(struct platform_device *pdev)
>   			goto err_pm_disable;
>   	}
>   
> -	dma_set_mask_and_coherent(dev, rk_ops->dma_bit_mask);
> +	dma_set_mask_and_coherent(dev, iommu->rk_ops->dma_bit_mask);
>   
>   	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
>   	if (err)
> 
