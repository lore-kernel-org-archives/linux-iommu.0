Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E132701C3
	for <iommu@lists.linux.dev>; Wed,  5 Nov 2025 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762366852; cv=none; b=tV/02NUmWptgX4wIFNV0q4wTiIN9cNvv1PMStmD7GDCHl8C+VSTUpGP5GdOaoEZ/FLuRTg5EFsRu3HfBPmLwxG+qs1PY/GKIyXg9tin/1oHhYY8ueifbZmNdhTnWOsbTY5uYmAmSdHjKS5czc9lvV3j67eLv3SmajLXoaii3f0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762366852; c=relaxed/simple;
	bh=V7ma7PxupnuLC7grOYhYd+m0IgHSWyMcIkrUXP6R5Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sEP3ohoOaDP+a8uVqI4fwpP08pouzzrdMCnLW7bIqJeu1AIQps1mtxTTrCsqRG0rn07IifPFqrnIWAAtZlFDigORMeH54iqSbMq473JrL+dAwhDnQj5fUlVhkxSovGyRkcLbGFwUvCGgNT3VJQODQUlgHIaUS/fsKvBWOK9RMH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 134F1169C;
	Wed,  5 Nov 2025 10:20:41 -0800 (PST)
Received: from [10.57.86.139] (unknown [10.57.86.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD4633F694;
	Wed,  5 Nov 2025 10:20:42 -0800 (PST)
Message-ID: <3fb55030-52d5-4e61-896f-c15a4f45ae8b@arm.com>
Date: Wed, 5 Nov 2025 18:20:38 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] of: use correct iommu-map parsing logic from of_iommu
 layer
To: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>, will@kernel.org,
 joro@8bytes.org, robh@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
 bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 saravanak@google.com, prakash.gupta@oss.qualcomm.com,
 vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <cover.1762235099.git.charan.kalla@oss.qualcomm.com>
 <b1ad7bee26fc87c1b73ac18d2284ad2e10b4b4d5.1762235099.git.charan.kalla@oss.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <b1ad7bee26fc87c1b73ac18d2284ad2e10b4b4d5.1762235099.git.charan.kalla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-11-04 8:51 am, Charan Teja Kalla wrote:
> Use of_map_id_or_funcid() that takes #iommu-cells into account, while
> keeping the compatibility with the existing DTs, which assume single
> argument. A callback function is used to get the of_phandle arguments,
> that contains iommu controller and its cells, and is called into the
> vendor specific driver through of_iommu_xlate().
> 
> When 'args_count' passed in of_phandle_args is '1', it is expected that
> of_map_id_or_funcid() fills the translated id into the of_phandle
> arguments which then called into of_iommu_xlate().
> 
> When 'args_count' > 1, as it is complex to establish a defined relation
> between the input id and output, of_iommu layer handles through the
> below relation:
> For platform devices, 'rid' defined in the iommu-map tuple indicates a
> function, through a bit position, which is compared against passed input
> 'id' that represents a bitmap of functions represented by the device.
> 
> For others, 'rid' is compared against the input 'id' as an integer value.

Sorry, I struggle to comprehend what this is trying to achieve... 
of_iommu doesn't have a clue what phandle arguments represent, only the 
relevant IOMMU driver does. How are we asking the IOMMU driver to map an 
input ID represented by an offset into a range, to an appropriate output 
specifier, without passing all that information to a suitable driver 
operation? Why would that have any dependency on bus types? And where 
has this notion of Linux platform devices having some sort of inherently 
standard bitmap suddenly sprung from?

Thanks,
Robin.

> When matched, of_iommu_xlate() is used to call into vendor specific
> iommu driver.
> 
> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> ---
>   drivers/iommu/of_iommu.c | 59 +++++++++++++++++++++++++++++++++-------
>   drivers/of/base.c        |  4 +--
>   include/linux/of.h       | 15 ++++++++++
>   3 files changed, 66 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 6b989a62def2..9575e37ad844 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -16,6 +16,7 @@
>   #include <linux/pci.h>
>   #include <linux/slab.h>
>   #include <linux/fsl/mc.h>
> +#include <linux/platform_device.h>
>   
>   #include "iommu-priv.h"
>   
> @@ -41,22 +42,60 @@ static int of_iommu_xlate(struct device *dev,
>   	return ret;
>   }
>   
> +/**
> + * of_iommu_map_xlate - Translate IOMMU mapping and release node reference.
> + *
> + * @id: bitmap for function id parsing(platform devices) or base id.
> + * @id_base: checked against @id
> + * @arg: Device to configure.
> + * @iommu_spec: IOMMU specifier from device tree.
> + *
> + * Wrapper function that calls of_iommu_xlate() to configure the IOMMU
> + * mapping for a device, then releases the device tree node reference.
> + * This is used as a callback function for of_map_id_or_funcid().
> + *
> + * When the cell_count > 1, the relation between input id(@id) and the
> + * output specifier is complex to define, like linear case when cell_count = 1,
> + * Handle such cases where linear relation can't be established between
> + * the @id and the output with the below relation:
> + * a) For platform devices, @id_base represents the function id, which is
> + * compared against the input @id, all maintained in bitmap relation.
> + * b) For other devices, it performs exact ID matching.
> + *
> + * Return: 0 on success, -EAGAIN if ID doesn't match
> + * and standard negative error code on failure.
> + */
> +static int of_iommu_map_xlate(u32 id, u32 id_base,
> +			void *arg, struct of_phandle_args *iommu_spec)
> +{
> +	struct device *dev = arg;
> +	int ret;
> +
> +	if (iommu_spec->args_count > 1) {
> +		if (dev_is_platform(dev)) {     /* case a. */
> +			if (!(BIT(id_base - 1) & id))
> +				return -EAGAIN;
> +		} else if (id_base != id) {     /* case b. */
> +			return -EAGAIN;
> +		}
> +
> +	}
> +
> +	ret = of_iommu_xlate(dev, iommu_spec);
> +	of_node_put(iommu_spec->np);
> +	return ret;
> +}
> +
>   static int of_iommu_configure_dev_id(struct device_node *master_np,
>   				     struct device *dev,
>   				     const u32 *id)
>   {
>   	struct of_phandle_args iommu_spec = { .args_count = 1 };
> -	int err;
>   
> -	err = of_map_id(master_np, *id, "iommu-map",
> -			 "iommu-map-mask", &iommu_spec.np,
> -			 iommu_spec.args);
> -	if (err)
> -		return err;
> -
> -	err = of_iommu_xlate(dev, &iommu_spec);
> -	of_node_put(iommu_spec.np);
> -	return err;
> +	return of_map_id_or_funcid(master_np, *id, "iommu-map",
> +			"iommu-map-mask", &iommu_spec.np,
> +			 iommu_spec.args, dev, &iommu_spec,
> +			 of_iommu_map_xlate);
>   }
>   
>   static int of_iommu_configure_dev(struct device_node *master_np,
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index cd221c003dd5..b5554c0b0bc5 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -2181,7 +2181,7 @@ static int of_map_id_cell_count(const __be32 *map, const char *map_name,
>    * @id: input id that is given for translation.
>    * @arg: argument passed to the @fn.
>    * @pargs: filled by the contents of @map and pass to the @fn.
> - * @fn: Callback function that operated on @dev and @fn.
> + * @fn: Callback function that operates on @arg.
>    *
>    * The function populates the phandle args structure with the node and
>    * specifier cells, then invokes the callback function. The callback is
> @@ -2233,7 +2233,7 @@ static int of_map_id_untranslated(const __be32 *map, u32 cell_count, u32 id,
>    *
>    * Return: 0 on success or a standard error code on failure.
>    */
> -static int of_map_id_or_funcid(const struct device_node *np, u32 id,
> +int of_map_id_or_funcid(const struct device_node *np, u32 id,
>   		const char *map_name, const char *map_mask_name,
>   		struct device_node **target, u32 *id_out,
>   		void *arg, struct of_phandle_args *pargs,
> diff --git a/include/linux/of.h b/include/linux/of.h
> index f8d976205ff4..7935ff5ac09e 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -410,6 +410,12 @@ extern int of_phandle_iterator_args(struct of_phandle_iterator *it,
>   extern int of_alias_get_id(const struct device_node *np, const char *stem);
>   extern int of_alias_get_highest_id(const char *stem);
>   
> +extern int of_map_id_or_funcid(const struct device_node *np, u32 id,
> +	       const char *map_name, const char *map_mask_name,
> +	       struct device_node **target, u32 *id_out,
> +	       void *arg, struct of_phandle_args *pargs,
> +	       of_map_id_cb fn);
> +
>   bool of_machine_compatible_match(const char *const *compats);
>   
>   /**
> @@ -909,6 +915,15 @@ static inline int of_map_id(const struct device_node *np, u32 id,
>   	return -EINVAL;
>   }
>   
> +static inline int of_map_id_or_funcid(const struct device_node *np, u32 id,
> +	       const char *map_name, const char *map_mask_name,
> +	       struct device_node **target, u32 *id_out,
> +	       void *arg, struct of_phandle_args *pargs,
> +	       of_map_id_cb fn)
> +{
> +	return -EINVAL;
> +}
> +
>   static inline phys_addr_t of_dma_get_max_cpu_address(struct device_node *np)
>   {
>   	return PHYS_ADDR_MAX;
