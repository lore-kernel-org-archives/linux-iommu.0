Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17411AF4C1
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 10:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730716179; cv=none; b=UmAEbMKwrXpdk9948kQMzzPnHrcjTYq+eKUC3MsQTBWbngkMneB7eTmN/LrO7yNtIkmAr9v7j5ojQhlERAWfcSeD7HNBroE1XviAM9QoE4W/OeRwq/gufW8luYsWVN/QWtR1sn/W1mwNa8u6smBpGzZY1XHt4KT3tbbTtjaGR18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730716179; c=relaxed/simple;
	bh=LtIwrcWSstP0WmM8VkgYPMRFr/2et7hXkOEQDULPM8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kOa+p8uGZfiNtpojZUUcitPlho91dXVAm+DYpSFM5Ucpys5zMxdMMGYCdSYbH6RA8yT1EI0l73O+8VNwBgicakD/G3jSGJ3pTfHvWk84vBqaBKhXB1aHw2WVt3I4dPmuUvZObVy23OQwhVukZPen915OdQRkAQ4IzQFZshEau/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8808FEC;
	Mon,  4 Nov 2024 02:30:04 -0800 (PST)
Received: from [10.57.88.110] (unknown [10.57.88.110])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 155133F66E;
	Mon,  4 Nov 2024 02:29:31 -0800 (PST)
Message-ID: <069c9838-b781-4012-934a-d2626fa78212@arm.com>
Date: Mon, 4 Nov 2024 10:29:28 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [net-next] net: hns3: add IOMMU_SUPPORT dependency
To: Arnd Bergmann <arnd@kernel.org>, Jian Shen <shenjian15@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
 Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jijie Shao <shaojijie@huawei.com>, Peiyang Wang <wangpeiyang1@huawei.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241104082129.3142694-1-arnd@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241104082129.3142694-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-11-04 8:21 am, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The hns3 driver started filling iommu_iotlb_gather structures itself,
> which requires CONFIG_IOMMU_SUPPORT is enabled:
> 
> drivers/net/ethernet/hisilicon/hns3/hns3_enet.c: In function 'hns3_dma_map_sync':
> drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:395:14: error: 'struct iommu_iotlb_gather' has no member named 'start'
>    395 |  iotlb_gather.start = iova;
>        |              ^
> drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:396:14: error: 'struct iommu_iotlb_gather' has no member named 'end'
>    396 |  iotlb_gather.end = iova + granule - 1;
>        |              ^
> drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:397:14: error: 'struct iommu_iotlb_gather' has no member named 'pgsize'
>    397 |  iotlb_gather.pgsize = granule;
>        |              ^
> 
> Add a Kconfig dependency to make it build in random configurations.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: iommu@lists.linux.dev
> Fixes: f2c14899caba ("net: hns3: add sync command to sync io-pgtable")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I noticed that no other driver does this, so it would be good to
> have a confirmation from the iommu maintainers that this is how
> the interface and the dependency is intended to be used.

WTF is that patch doing!? No, random device drivers should absolutely 
not be poking into IOMMU driver internals, this is egregiously wrong and 
the correct action is to drop it entirely.

Thanks,
Robin.

> ---
>   drivers/net/ethernet/hisilicon/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/hisilicon/Kconfig b/drivers/net/ethernet/hisilicon/Kconfig
> index 65302c41bfb1..790efc8d2de6 100644
> --- a/drivers/net/ethernet/hisilicon/Kconfig
> +++ b/drivers/net/ethernet/hisilicon/Kconfig
> @@ -91,6 +91,7 @@ config HNS_ENET
>   config HNS3
>   	tristate "Hisilicon Network Subsystem Support HNS3 (Framework)"
>   	depends on PCI
> +	depends on IOMMU_SUPPORT
>   	select NET_DEVLINK
>   	select PAGE_POOL
>   	help

