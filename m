Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBCF146A8A
	for <iommu@lists.linux.dev>; Fri,  5 Jul 2024 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720184719; cv=none; b=EavImADWWPIZPo+1s4YrgxDtdBomk1A5Dyc+l8M79qJga2NwSwzXmFRLIkip2MemXrYRH/OArjTPxyUqt3KkFww2kWKZCCuzwUsB+P0J6yTRVJ9LwD0dqtzT83RNI7nY97gd34UgNjQL3BzGjtVePyLur7Jjl3WVBXVhXNZpNgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720184719; c=relaxed/simple;
	bh=wBzyCGvZlXrGtucgZe5QgnlabcM77Tfn3Q0JRN4Rovo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4H35wFeJSeSdJ0zvl02lsqi+IEITInji7RP6Ts/DUFByxyNYI21mS2V9BhE7BSUgfdGGK/yNOudxJ+uGG9hzKwlLb5o1du95RlUXBwynWHbkRHPGOQ8U0mOkzCncNJlXIPwpMMByl3kiU7DA5l7r2sTtQO8ytJF41nb6YMW7so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hb/+SADe; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hb/+SADe"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ebe785b234so17545231fa.1
        for <iommu@lists.linux.dev>; Fri, 05 Jul 2024 06:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720184715; x=1720789515; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Kq2UKMfyZSG8CmSMNXs7gnYEo7SViN3yYFQkgYUzKI=;
        b=hb/+SADenWOItpp0wsc+OdlSncTuxqPfZ1ljquYZtp1Knwlpej/g5TrbrTolARggop
         /K+gysMKOUzs4tqzCp0ehIhjEGR3n4b3mtFiYUA3vref714ERvW8ElWjs4Cf42L2Wvhu
         FW6A54mDCbHr9JXjdgaEg93HIujh/J4hsv0Tklo9kDjPV6nAs1riFI+9PLYChmMRShnm
         FG8DmXqG0rwnZcHokSlVzqI3786/hSeSX4J6wHQoG1nTGiCLPRYU1RdjL91qSlZYzNu/
         u/Hcof+7VkBkZm14de8IwtAxxwywhf6zNie90Td3z2//bY93lCXm6lAfXnrE0nXjdQ6k
         8Ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720184715; x=1720789515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Kq2UKMfyZSG8CmSMNXs7gnYEo7SViN3yYFQkgYUzKI=;
        b=BNim0gnQFGYAzBHRxioNBwZkrw5MGgR5JvMj4gAY6YAXUcnbxuh6jS1ilMACoR8q0s
         IDZBmVgmJetbVTErKeCZLbYwgZaq/OlqEM03oIFC4LfQj+GQef86dhZpDzg2f+iQkm55
         8X6u366DLMFHWgk1VSwQ54I/ljT44+Cupqayw5VgxOh1gZamHhUI3es0S1I7e4fTT9Cz
         rvqTWEv7lzlB2KiIFpUssMFbZbQFsT4BqT0tNr92B/eYm7BPZbGjlYWmJvVWoGibSC8/
         pWUGjOlo8AMAuZ13/aHROD9Tz0/ATGWrzjrZHuCorgpx4fhZnaR4ffKFGdR18KMGonc6
         WyiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhGTKPhT6iGQG7ME5fregaK62Z1rYgq2dFEhal1VJP939eBPWFFu0d6vhwVwMOMH6Vrv8/SNX7Ps6t6mCTQ3DLcvSOHTU=
X-Gm-Message-State: AOJu0Yw0RXwM47sVw5rZPFH8O0hClEXVEzbJ4j1C8dJaGvdCJn7rz5M/
	RQXmeVqct5Vf8uV75uInBDLrM+x030F5ERKCW1pHrcAneKwUZ5yd
X-Google-Smtp-Source: AGHT+IFa5r5ZKGcjLyiUMDN8L/oSRNvhombRkJzjuV9r/itwTc5sVm9f2Y2DKblhSa3bPwC2+LYr9w==
X-Received: by 2002:a2e:8017:0:b0:2ee:46ec:60bc with SMTP id 38308e7fff4ca-2ee8ed62914mr28303561fa.27.1720184714805;
        Fri, 05 Jul 2024 06:05:14 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1202:4fb5:f16a:579c:6dcb? (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee96a836b8sm1497511fa.102.2024.07.05.06.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 06:05:14 -0700 (PDT)
Message-ID: <986361f4-f000-4129-8214-39f2fb4a90da@gmail.com>
Date: Fri, 5 Jul 2024 15:05:12 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] of: reserved_mem: Use unflatten_devicetree APIs to
 scan reserved memory nodes
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, robh@kernel.org,
 saravanak@google.com, hch@lst.de, m.szyprowski@samsung.com,
 robin.murphy@arm.com, will@kernel.org, catalin.marinas@arm.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, kernel@quicinc.com
References: <20240528223650.619532-1-quic_obabatun@quicinc.com>
 <20240528223650.619532-4-quic_obabatun@quicinc.com>
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <20240528223650.619532-4-quic_obabatun@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024-05-29 00:36, Oreoluwa Babatunde wrote:
> The unflatten_devicetree APIs have been setup and are available to be
> used by the time the fdt_init_reserved_mem() function is called.
> Since the unflatten_devicetree APIs are a more efficient way of scanning
> through the DT nodes, switch to using these APIs to facilitate the rest
> of the reserved memory processing.

With this patch series, I've observed significantly less memory 
available to userspace on my Raspberry Pi 1 and 3.

I see this message on the kernel console:
Jul  4 23:13:49 bonnet kernel: OF: reserved mem: 0x1b000000..0x1effffff 
(65536 KiB) map non-reusable linux

where it was previously marked as reusable:
Jul  4 22:23:22 bonnet kernel: OF: reserved mem: 0x1b000000..0x1effffff 
(65536 KiB) map reusable linux,cma

If I look at bcm283x.dtsi, it definitely has the reusable property.

I've below pointed out the snippet I think could be suspicous.

> 
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> ---
>   drivers/of/of_reserved_mem.c    | 93 ++++++++++++++++++++-------------
>   include/linux/of_reserved_mem.h |  2 +-
>   kernel/dma/coherent.c           | 10 ++--
>   kernel/dma/contiguous.c         |  8 +--
>   kernel/dma/swiotlb.c            | 10 ++--
>   5 files changed, 72 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 113d593ea031..05283cd24c3b 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -14,6 +14,7 @@
>   #include <linux/err.h>
>   #include <linux/libfdt.h>
>   #include <linux/of.h>
> +#include <linux/of_address.h>
>   #include <linux/of_fdt.h>
>   #include <linux/of_platform.h>
>   #include <linux/mm.h>
> @@ -99,7 +100,7 @@ static void __init alloc_reserved_mem_array(void)
>   /*
>    * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
>    */
> -static void __init fdt_reserved_mem_save_node(unsigned long node, const char *uname,
> +static void __init fdt_reserved_mem_save_node(struct device_node *node, const char *uname,
>   					      phys_addr_t base, phys_addr_t size)
>   {
>   	struct reserved_mem *rmem = &reserved_mem[reserved_mem_count];
> @@ -109,7 +110,7 @@ static void __init fdt_reserved_mem_save_node(unsigned long node, const char *un
>   		return;
>   	}
>   
> -	rmem->fdt_node = node;
> +	rmem->dev_node = node;
>   	rmem->name = uname;
>   	rmem->base = base;
>   	rmem->size = size;
> @@ -178,11 +179,11 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
>   }
>   
>   /*
> - * __reserved_mem_check_root() - check if #size-cells, #address-cells provided
> + * __fdt_reserved_mem_check_root() - check if #size-cells, #address-cells provided
>    * in /reserved-memory matches the values supported by the current implementation,
>    * also check if ranges property has been provided
>    */
> -static int __init __reserved_mem_check_root(unsigned long node)
> +static int __init __fdt_reserved_mem_check_root(unsigned long node)
>   {
>   	const __be32 *prop;
>   
> @@ -200,6 +201,35 @@ static int __init __reserved_mem_check_root(unsigned long node)
>   	return 0;
>   }
>   
> +/*
> + * of_reserved_mem_check_root() - check if #size-cells, #address-cells provided
> + * in /reserved-memory matches the values supported by the current implementation,
> + * also check if ranges property has been provided
> + */
> +static int __init of_reserved_mem_check_root(struct device_node *node)
> +{
> +	u32 prop;
> +	int ret;
> +
> +	ret = of_property_read_u32(node, "#size-cells", &prop);
> +	if (ret)
> +		return ret;
> +
> +	if (prop != dt_root_size_cells)
> +		return -EINVAL;
> +
> +	ret = of_property_read_u32(node, "#address-cells", &prop);
> +	if (ret)
> +		return ret;
> +
> +	if (prop != dt_root_addr_cells)
> +		return -EINVAL;
> +
> +	if (!of_property_present(node, "ranges"))
> +		return -EINVAL;
> +	return 0;
> +}
> +
>   /**
>    * fdt_scan_reserved_mem_reg_nodes() - Store info for the "reg" defined
>    * reserved memory regions.
> @@ -212,41 +242,40 @@ static int __init __reserved_mem_check_root(unsigned long node)
>    */
>   static void __init fdt_scan_reserved_mem_reg_nodes(void)
>   {
> -	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
> -	const void *fdt = initial_boot_params;
> +	struct device_node *node, *child;
>   	phys_addr_t base, size;
> -	const __be32 *prop;
> -	int node, child;
> -	int len;
>   
> -	node = fdt_path_offset(fdt, "/reserved-memory");
> -	if (node < 0) {
> +	node = of_find_node_by_path("/reserved-memory");
> +	if (!node) {
>   		pr_info("Reserved memory: No reserved-memory node in the DT\n");
>   		return;
>   	}
>   
> -	if (__reserved_mem_check_root(node)) {
> +	if (of_reserved_mem_check_root(node)) {
>   		pr_err("Reserved memory: unsupported node format, ignoring\n");
>   		return;
>   	}
>   
> -	fdt_for_each_subnode(child, fdt, node) {
> +	for_each_child_of_node(node, child) {
> +		int ret = 0;
>   		const char *uname;
> +		struct resource res;
> +		struct reserved_mem *rmem;
>   
> -		prop = of_get_flat_dt_prop(child, "reg", &len);
> -		if (!prop)
> -			continue;
> -		if (!of_fdt_device_is_available(fdt, child))
> +		if (!of_device_is_available(child))
>   			continue;
>   
> -		uname = fdt_get_name(fdt, child, NULL);
> -		if (len && len % t_len != 0) {
> -			pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
> -			       uname);
> +		ret = of_address_to_resource(child, 0, &res);
> +		if (ret) {
> +			rmem = of_reserved_mem_lookup(child);
> +			if (rmem)
> +				rmem->dev_node = child;
>   			continue;
>   		}
> -		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
> -		size = dt_mem_next_cell(dt_root_size_cells, &prop);
> +		uname = of_node_full_name(child);
> +
> +		base = res.start;
> +		size = res.end - res.start + 1;
>   
>   		if (size)
>   			fdt_reserved_mem_save_node(child, uname, base, size);
> @@ -269,7 +298,7 @@ int __init fdt_scan_reserved_mem(void)
>   	if (node < 0)
>   		return -ENODEV;
>   
> -	if (__reserved_mem_check_root(node) != 0) {
> +	if (__fdt_reserved_mem_check_root(node) != 0) {
>   		pr_err("Reserved memory: unsupported node format, ignoring\n");
>   		return -EINVAL;
>   	}
> @@ -447,7 +476,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
>   		       uname, (unsigned long)(size / SZ_1M));
>   		return -ENOMEM;
>   	}


> -	fdt_reserved_mem_save_node(node, uname, base, size);
> +	fdt_reserved_mem_save_node(NULL, uname, base, size);

This could perhaps be suspicious?

The above message seems to come from of_init_reserved_mem_node when
called from of_reserved_mem_save_node when called from here. This would 
mean that the node is not actually saved to rmem and thus not marked 
reusable?


>   	return 0;
>   }
>   
> @@ -467,7 +496,7 @@ static int __init __reserved_mem_init_node(struct reserved_mem *rmem)
>   		reservedmem_of_init_fn initfn = i->data;
>   		const char *compat = i->compatible;
>   
> -		if (!of_flat_dt_is_compatible(rmem->fdt_node, compat))
> +		if (!of_device_is_compatible(rmem->dev_node, compat))
>   			continue;
>   
>   		ret = initfn(rmem);
> @@ -500,11 +529,6 @@ static int __init __rmem_cmp(const void *a, const void *b)
>   	if (ra->size > rb->size)
>   		return 1;
>   
> -	if (ra->fdt_node < rb->fdt_node)
> -		return -1;
> -	if (ra->fdt_node > rb->fdt_node)
> -		return 1;
> -
>   	return 0;
>   }
>   
> @@ -551,11 +575,11 @@ void __init fdt_init_reserved_mem(void)
>   
>   	for (i = 0; i < reserved_mem_count; i++) {
>   		struct reserved_mem *rmem = &reserved_mem[i];
> -		unsigned long node = rmem->fdt_node;
> +		struct device_node *node = rmem->dev_node;
>   		int err = 0;
>   		bool nomap;
>   
> -		nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
> +		nomap = of_property_present(node, "no-map");
>   
>   		err = __reserved_mem_init_node(rmem);
>   		if (err != 0 && err != -ENOENT) {
> @@ -566,8 +590,7 @@ void __init fdt_init_reserved_mem(void)
>   				memblock_phys_free(rmem->base, rmem->size);
>   		} else {
>   			phys_addr_t end = rmem->base + rmem->size - 1;
> -			bool reusable =
> -				(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
> +			bool reusable = of_property_present(node, "reusable");
>   
>   			pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
>   				&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
> diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
> index e338282da652..769b8f67c8d3 100644
> --- a/include/linux/of_reserved_mem.h
> +++ b/include/linux/of_reserved_mem.h
> @@ -10,7 +10,7 @@ struct reserved_mem_ops;
>   
>   struct reserved_mem {
>   	const char			*name;
> -	unsigned long			fdt_node;
> +	struct device_node              *dev_node;
>   	const struct reserved_mem_ops	*ops;
>   	phys_addr_t			base;
>   	phys_addr_t			size;
> diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
> index ff5683a57f77..8f99586204fb 100644
> --- a/kernel/dma/coherent.c
> +++ b/kernel/dma/coherent.c
> @@ -362,20 +362,18 @@ static const struct reserved_mem_ops rmem_dma_ops = {
>   
>   static int __init rmem_dma_setup(struct reserved_mem *rmem)
>   {
> -	unsigned long node = rmem->fdt_node;
> +	struct device_node *node = rmem->dev_node;
>   
> -	if (of_get_flat_dt_prop(node, "reusable", NULL))
> +	if (of_property_present(node, "reusable"))
>   		return -EINVAL;
>   
> -#ifdef CONFIG_ARM
> -	if (!of_get_flat_dt_prop(node, "no-map", NULL)) {
> +	if (IS_ENABLED(CONFIG_ARM) && !of_property_present(node, "no-map")) {
>   		pr_err("Reserved memory: regions without no-map are not yet supported\n");
>   		return -EINVAL;
>   	}
> -#endif
>   
>   #ifdef CONFIG_DMA_GLOBAL_POOL
> -	if (of_get_flat_dt_prop(node, "linux,dma-default", NULL)) {
> +	if (of_property_present(node, "linux,dma-default")) {
>   		WARN(dma_reserved_default_memory,
>   		     "Reserved memory: region for default DMA coherent area is redefined\n");
>   		dma_reserved_default_memory = rmem;
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 055da410ac71..450e9e4be79c 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -456,8 +456,8 @@ static const struct reserved_mem_ops rmem_cma_ops = {
>   
>   static int __init rmem_cma_setup(struct reserved_mem *rmem)
>   {
> -	unsigned long node = rmem->fdt_node;
> -	bool default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
> +	struct device_node *node = rmem->dev_node;
> +	bool default_cma = of_property_read_bool(node, "linux,cma-default");
>   	struct cma *cma;
>   	int err;
>   
> @@ -467,8 +467,8 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
>   		return -EBUSY;
>   	}
>   
> -	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
> -	    of_get_flat_dt_prop(node, "no-map", NULL))
> +	if (!of_property_present(node, "reusable") ||
> +	    of_property_present(node, "no-map"))
>   		return -EINVAL;
>   
>   	if (!IS_ALIGNED(rmem->base | rmem->size, CMA_MIN_ALIGNMENT_BYTES)) {
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index fe1ccb53596f..9949ddc14272 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1859,12 +1859,12 @@ static const struct reserved_mem_ops rmem_swiotlb_ops = {
>   
>   static int __init rmem_swiotlb_setup(struct reserved_mem *rmem)
>   {
> -	unsigned long node = rmem->fdt_node;
> +	struct device_node *node = rmem->dev_node;
>   
> -	if (of_get_flat_dt_prop(node, "reusable", NULL) ||
> -	    of_get_flat_dt_prop(node, "linux,cma-default", NULL) ||
> -	    of_get_flat_dt_prop(node, "linux,dma-default", NULL) ||
> -	    of_get_flat_dt_prop(node, "no-map", NULL))
> +	if (of_property_present(node, "reusable") ||
> +	    of_property_present(node, "linux,cma-default") ||
> +	    of_property_present(node, "linux,dma-default") ||
> +	    of_property_present(node, "no-map"))
>   		return -EINVAL;
>   
>   	rmem->ops = &rmem_swiotlb_ops;

Regards,
Klara Modin
