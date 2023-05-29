Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DD22102
	for <iommu@lists.linux.dev>; Mon, 29 May 2023 07:55:53 +0000 (UTC)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 0E8386605961;
	Mon, 29 May 2023 08:55:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1685346945;
	bh=oTdocyJ/fdDvVOM9bvypLnMcp07pgkCobWwO3/e/PV4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kAYZU6QnU8eMMuQkF3n6TdkQrOGmMBu2uqnpRWntRDxezgkByhD/fLa7ahKyLEOGK
	 GKy8qGnV4BeNJ+mMcSvN8TdjueJNMaOKKkIwpEfCMKHYyEohHQEQDZq95k5EjAigye
	 kWCctLWRaq6Gd0o7LmjBzDPQ/gCeJ5EonmisQZ16WXKwcuKnkRp1JpKiN2VBCyp/ds
	 /LGzACi6NDMsoEdhlIkInp4NGNd39vXdyFMzYozA1K0FmlI0n8GGKmlzwJOCfSQFEF
	 iQCowGSzSsXzDINBB2eN+8/NvBUzty91CEEuM6e/hIUremjnzoIcoi0xo0CbSKWENN
	 BkeVcrYoOxICg==
Message-ID: <cc053ab0-1ed3-0d2c-204d-a5ae85b759a5@collabora.com>
Date: Mon, 29 May 2023 09:55:42 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH RFC] iommu/mediatek: Flush IOTLB completely only if domain
 has been attached
To: Chen-Yu Tsai <wenst@chromium.org>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230526085402.394239-1-wenst@chromium.org>
Content-Language: en-US
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230526085402.394239-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/05/23 10:53, Chen-Yu Tsai ha scritto:
> If an IOMMU domain was never attached, it lacks any linkage to the
> actual IOMMU hardware. Attempting to do flush_iotlb_all() on it will
> result in a NULL pointer dereference. This seems to happen after the
> recent IOMMU core rework in v6.4-rc1.
> 
>      Unable to handle kernel read from unreadable memory at virtual address 0000000000000018
>      Call trace:
>       mtk_iommu_flush_iotlb_all+0x20/0x80
>       iommu_create_device_direct_mappings.part.0+0x13c/0x230
>       iommu_setup_default_domain+0x29c/0x4d0
>       iommu_probe_device+0x12c/0x190
>       of_iommu_configure+0x140/0x208
>       of_dma_configure_id+0x19c/0x3c0
>       platform_dma_configure+0x38/0x88
>       really_probe+0x78/0x2c0
> 
> Check if the "bank" field has been filled in before actually attempting
> the IOTLB flush to avoid it. The IOTLB is also flushed when the device
> comes out of runtime suspend, so it should have a clean initial state.
> 
> Fixes: 08500c43d4f7 ("iommu/mediatek: Adjust the structure")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Not only ARM SMMU does this, others are doing the same, some in a different
form (walking a list)... So I agree with this being a valid fix.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> 
> I think this is a valid fix, but I'm not very familiar with the hardware
> or the design of the driver. The ARM SMMU drivers seem to do this as well.
> 
>   drivers/iommu/mtk_iommu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index aecc7d154f28..e93906d6e112 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -781,7 +781,8 @@ static void mtk_iommu_flush_iotlb_all(struct iommu_domain *domain)
>   {
>   	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
>   
> -	mtk_iommu_tlb_flush_all(dom->bank->parent_data);
> +	if (dom->bank)
> +		mtk_iommu_tlb_flush_all(dom->bank->parent_data);
>   }
>   
>   static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,


