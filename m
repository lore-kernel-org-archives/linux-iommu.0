Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13372FDC4F
	for <iommu@lists.linux.dev>; Wed,  5 Nov 2025 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364113; cv=none; b=QQm0tS9+qKe7ZXz0ONWRQ4CcSgQU2U6bA9SKVBtZ95tFvangWlmAZPyyzdeCowJNIEqD0F1UfRUxbHIkQzVrVnaVfiLVXPYD7aXAS7jRFfPjVyvycmbZk7WKSegk3DaQhtkd6JMLNuLtfq5WkJgO6Jh8im/hcBDL9twR1/Hg97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364113; c=relaxed/simple;
	bh=DTXNROkRA31SpKmGKo/09BWRmLOT/RvGrF6DmXSpWgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLwZqpGczI7SJiFMaB1V2z+11la8u0J9KWK/uyXrN5oy7SEB6Xi6lhzHdxE70NWwU0ey1smcsZQjltMsFXZuDoxm4IncW062GUTqf78lTws81vSVYvSFumkwUngEQTvnGlACFVqeZ6oANIGa8KKKZLvDm5QmiydyZSFklq3uxLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25725169C;
	Wed,  5 Nov 2025 09:35:03 -0800 (PST)
Received: from [10.57.86.139] (unknown [10.57.86.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBB8E3F63F;
	Wed,  5 Nov 2025 09:35:06 -0800 (PST)
Message-ID: <44010837-65c6-437e-aede-7b45f69b6758@arm.com>
Date: Wed, 5 Nov 2025 17:35:03 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] of: introduce wrapper function to query the cell
 count
To: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>, will@kernel.org,
 joro@8bytes.org, robh@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
 bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 saravanak@google.com, prakash.gupta@oss.qualcomm.com,
 vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <cover.1762235099.git.charan.kalla@oss.qualcomm.com>
 <47bdcf06aacc1fec791577ffd4a4a94034a4d3ed.1762235099.git.charan.kalla@oss.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <47bdcf06aacc1fec791577ffd4a4a94034a4d3ed.1762235099.git.charan.kalla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-11-04 8:51 am, Charan Teja Kalla wrote:
> Introduce the wrapper function, of_map_id_cell_count(), to query the
> actual cell count that need to be considered by the of_map_id() when
> used for translating the <property>-map entries. Accordingly make sure
> of_map_id_or_funcid() operates on this returned cell count.
> 
> This wrapper function returns cell count as 1 thus no functional
> changes.
> 
> The subsequent patches improve the logic in wrapper function to detect
> the proper cell count.
> 
> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> ---
>   drivers/of/base.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index ac6b726cd5e3..5e76abcc7940 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -2045,6 +2045,12 @@ int of_find_last_cache_level(unsigned int cpu)
>   	return cache_level;
>   }
>   
> +static int of_map_id_cell_count(const __be32 *map, const char *map_name,
> +				int map_len)
> +{
> +	return 1;
> +}
> +
>   /*
>    * Look at the documentation of of_map_id.
>    */
> @@ -2053,6 +2059,7 @@ static int of_map_id_or_funcid(const struct device_node *np, u32 id,
>   		struct device_node **target, u32 *id_out)
>   {
>   	u32 map_mask, masked_id;
> +	u32 cell_count, total_cells;
>   	int map_len;
>   	const __be32 *map = NULL;
>   
> @@ -2068,7 +2075,13 @@ static int of_map_id_or_funcid(const struct device_node *np, u32 id,
>   		return 0;
>   	}
>   
> -	if (!map_len || map_len % (4 * sizeof(*map))) {
> +	cell_count = of_map_id_cell_count(map, map_name, map_len);

This doesn't work. The output cell count for any given entry depends on 
whatever phandle *that* entry maps to - it can't be assumed to be 
constant for the whole map.

Thanks,
Robin.

> +	if (!cell_count)
> +		return -EINVAL;
> +
> +	total_cells = 2 + cell_count + 1;
> +
> +	if (!map_len || map_len % (total_cells * sizeof(*map))) {
>   		pr_err("%pOF: Error: Bad %s length: %d\n", np,
>   			map_name, map_len);
>   		return -EINVAL;
> @@ -2085,12 +2098,12 @@ static int of_map_id_or_funcid(const struct device_node *np, u32 id,
>   		of_property_read_u32(np, map_mask_name, &map_mask);
>   
>   	masked_id = map_mask & id;
> -	for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
> +	for ( ; map_len > 0; map_len -= total_cells * sizeof(*map), map += total_cells) {
>   		struct device_node *phandle_node;
>   		u32 id_base = be32_to_cpup(map + 0);
>   		u32 phandle = be32_to_cpup(map + 1);
>   		u32 out_base = be32_to_cpup(map + 2);
> -		u32 id_len = be32_to_cpup(map + 3);
> +		u32 id_len = be32_to_cpup(map + total_cells - 1);
>   
>   		if (id_base & ~map_mask) {
>   			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores id-base (0x%x)\n",

