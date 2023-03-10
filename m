Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8343E8838
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 16:18:19 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3C8FAD7;
	Fri, 10 Mar 2023 08:19:02 -0800 (PST)
Received: from [10.57.90.67] (unknown [10.57.90.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C99A3F5A1;
	Fri, 10 Mar 2023 08:18:18 -0800 (PST)
Message-ID: <dcc64433-f0ba-4cdb-b090-4bb81058ab3d@arm.com>
Date: Fri, 10 Mar 2023 16:18:13 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] iommu: omap: Use of_property_read_bool() for boolean
 properties
Content-Language: en-GB
To: Rob Herring <robh@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: devicetree@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20230310144709.1542980-1-robh@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230310144709.1542980-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-03-10 14:47, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   drivers/iommu/omap-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 3ab078112a7c..baafd6211ac4 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1191,7 +1191,7 @@ static int omap_iommu_probe(struct platform_device *pdev)
>   		return err;
>   	if (obj->nr_tlb_entries != 32 && obj->nr_tlb_entries != 8)
>   		return -EINVAL;
> -	if (of_find_property(of, "ti,iommu-bus-err-back", NULL))
> +	if (of_property_read_bool(of, "ti,iommu-bus-err-back"))
>   		obj->has_bus_err_back = MMU_GP_REG_BUS_ERR_BACK_EN;
>   
>   	obj->dev = &pdev->dev;
