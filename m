Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508178838
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 16:17:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E7AB4B3;
	Fri, 10 Mar 2023 08:18:20 -0800 (PST)
Received: from [10.57.90.67] (unknown [10.57.90.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BCD43F5A1;
	Fri, 10 Mar 2023 08:17:35 -0800 (PST)
Message-ID: <a258094d-91c8-de56-7faa-28862a6f927f@arm.com>
Date: Fri, 10 Mar 2023 16:17:30 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] iommu: Use of_property_present() for testing DT property
 presence
Content-Language: en-GB
To: Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230310144709.1542910-1-robh@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230310144709.1542910-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-03-10 14:47, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.

Oh, neat!

> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 2 +-
>   drivers/iommu/ipmmu-vmsa.c            | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 2ff7a72cf377..d0843caf8760 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -139,7 +139,7 @@ static int arm_smmu_register_legacy_master(struct device *dev,
>   	int err;
>   
>   	np = dev_get_dev_node(dev);
> -	if (!np || !of_find_property(np, "#stream-id-cells", NULL)) {
> +	if (!np || !of_property_present(np, "#stream-id-cells")) {
>   		of_node_put(np);
>   		return -ENODEV;
>   	}
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index bdf1a4e5eae0..f4470303d906 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -1014,7 +1014,7 @@ static int ipmmu_probe(struct platform_device *pdev)
>   	 * the lack of has_cache_leaf_nodes flag or renesas,ipmmu-main property.
>   	 */
>   	if (!mmu->features->has_cache_leaf_nodes ||
> -	    !of_find_property(pdev->dev.of_node, "renesas,ipmmu-main", NULL))
> +	    !of_property_present(pdev->dev.of_node, "renesas,ipmmu-main"))

On reflection, weird that this works the way it does instead of actually 
following the phandle, but oh well. Definitely beyond the scope of this 
cleanup :)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   		mmu->root = mmu;
>   	else
>   		mmu->root = ipmmu_find_root();
