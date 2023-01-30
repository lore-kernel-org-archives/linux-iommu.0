Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB4920E3
	for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 11:58:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B027816F3;
	Mon, 30 Jan 2023 03:59:26 -0800 (PST)
Received: from [10.57.89.162] (unknown [10.57.89.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF7853F71E;
	Mon, 30 Jan 2023 03:58:42 -0800 (PST)
Message-ID: <52254849-96fa-2882-d81d-d22fe3948405@arm.com>
Date: Mon, 30 Jan 2023 11:58:38 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] dt-bindings: memory: mediatek: Add support of
 unmanaged iommu domain
Content-Language: en-GB
To: Alexandre Bailon <abailon@baylibre.com>, yong.wu@mediatek.com,
 joro@8bytes.org, will@kernel.org
Cc: matthias.bgg@gmail.com, krzysztof.kozlowski@linaro.org,
 robh+dt@kernel.org, iommu@lists.linux.dev,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230130102722.133271-1-abailon@baylibre.com>
 <20230130102722.133271-2-abailon@baylibre.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230130102722.133271-2-abailon@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-01-30 10:27, Alexandre Bailon wrote:
> Currently, the only way to have an unmanaged domain for a device
> is having a dedicated iova region or bank.
> This adds a new bit to MTK_M4U_ID that allows defining devices
> that needs unmanaged iommu domain.

These are details of Linux-specific usage policy, so don't belong in DT 
bindings. I believe the driver already has some internal data to make 
its own assignment of particular devices into particular groups, so 
please just add to that.

Thanks,
Robin.

> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>   include/dt-bindings/memory/mtk-memory-port.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/dt-bindings/memory/mtk-memory-port.h b/include/dt-bindings/memory/mtk-memory-port.h
> index 2f68a0511a257..86896c776691a 100644
> --- a/include/dt-bindings/memory/mtk-memory-port.h
> +++ b/include/dt-bindings/memory/mtk-memory-port.h
> @@ -7,11 +7,14 @@
>   #define __DT_BINDINGS_MEMORY_MTK_MEMORY_PORT_H_
>   
>   #define MTK_LARB_NR_MAX			32
> +#define MTK_UNMANAGED_DEVICE            (1 << 31)
>   
>   #define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
>   #define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0x1f)
>   #define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
> +#define MTK_M4U_UNMANAGED(id)		((id) & MTK_UNMANAGED_DEVICE)
>   
>   #define MTK_IFAIOMMU_PERI_ID(port)	MTK_M4U_ID(0, port)
> +#define MTK_M4U_UNMANAGED_ID(larb, port) (MTK_M4U_ID(larb, port) | MTK_UNMANAGED_DEVICE)
>   
>   #endif
