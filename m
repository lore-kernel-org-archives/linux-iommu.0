Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF063DDDDA
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577859; cv=none; b=O6LW5rzZcfnxip7tV7w1hpfxhHJdBFENz5gkXZ8HzD35+mjGxVEYGgYR+QiUHFIX9vw8gvUtrA9h6ro9K/6EnqywsK/RfobOTCEgeu5chlMqi97EmjP83ETgMffZLTh6RL+WktPL1YW7QLKa2ExJlPqIID43Dxw4S2xRGpGX9Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577859; c=relaxed/simple;
	bh=1U6NyzXgzghwmgznfZeRYyFAcgGDs0fm45Rk9Z3dM4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFicuHFaldQJ81Xf2fXuA95XUZM8zae34ZEYo/dkl/02wFd1/BLWKL8AWSjWRKhRIluoFhqBp4Wbh+7hB/qlWO04X1USZ+71Br4phgMT+NlEjC+oh1DIuDNeEjnb44fiAmn3IaII77pwjodNdaBbdhNmYRHK08qgaqVPF10jc8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DX/fuluK; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DX/fuluK"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e85499ffbso266909485a.0
        for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 06:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1787577853; x=1788182653; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Av++B0/o7UC1jj49c6nzmrH1j+NIAZ2vTywjWODYChQ=;
        b=DX/fuluKTyU5WMViAEX8ZFVS8urxLLLfKSDrRAF4TVViCwDo0UvNtbLNMNdUrIr2v5
         5qK0P4VyxlwKqbxgpqjXrg6GbobPSuPl6ArVtf98EchDzy+TUyrlTnwyJjgxrh/wepJS
         oiVk7XyEbESnRHjhSTUwtrT7kibeYRUQZwaDwWlwfcfpJP4zoknjVKb3OlzB9PpUq7i5
         xZo9QLNlqW1/WVJBQoZ9DpKYrSj1ChkE2856XHI8NHI2pkrmAOHmb0SRplFp8pQUSDFi
         HB+lqU5Fq/FuWJGEmP51acdWywpzkQ4q3ThsoUXT5p8FwjLWXrG46sFcjkvE+3FHoxI/
         N2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787577853; x=1788182653;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Av++B0/o7UC1jj49c6nzmrH1j+NIAZ2vTywjWODYChQ=;
        b=skJ++8U+UI/SpMbsF4fY5lRRXRfXo5FNJeh0w1BNc0N9SPyrIae9nr3pP/cScX5BK9
         RbwhIFK6V7FY/rRxbqaLC45h+tgG4mfwdjxtEMJwI/wyi49kS9r4LwdHeetvPPR1gIib
         daggv2TxU3qzP4qPDGaCgR0D86NtQXCHmvAOC5SsJp7WilpWwZ+lEuI06v8uLMMxE5lI
         AaDHkQ+bTqfvBEnNmdTQ37SRBoCcedwDF+ei6+E9rhF83f1Y0L7pk89UKhXqvVcAskYa
         9el+zvamXWxG5NjtRF0Nm9rfRzSBr4AGBa7H4DRYFcFHKtfkxbZpzipa/fDI/jOYrRDa
         WMUA==
X-Gm-Message-State: AFuF++nXSWKVTgxEgibk9g9y+cLQNoMHIB9ddvBVo0hDO9W9ijbpngsN
	z1/mH5BADf4dws0vvjPPcWxQ+fmZ30syWddRWvU7wbW/NiAYVMDz4ICOHFZWVqWvXLA=
X-Gm-Gg: AR+sD13/JJ/KaXiLRJMRBQbyG5Rp0GLLERNSBZMzZZ4gl3eJgifQLo4FXRqR90CNou0
	I8fXiOOUAUnqnQ+6AnI0Zqd3/0w7NlAgwfVXNLbpximNxUEn+Q5KA9zNyBUh2M1xWBEn9a+MWW7
	N9q6+3dbz2mrJBZuAli1p7Mw3FnNXiYRLczicwH5XTK+jy8wFn0yq944OSErqvtZ0iXFyOypKbs
	FH093TUMiO+1HlbcJ+7vrI2XJDP4sPXIwH1TgsYynXj8ID46TqGmCGS2mv/dZTS2L62EzbXDNF7
	+ugOLxhigeRM0a2wWmy9qbuS2rA1Od2TeiiCpaiqOfOVSNcIdOiSKSgyoe58cARmuUVWYslrCnT
	2GSAYRgJUYzMigDWXyc9x+8JI+WPxap3HAoKqvJ6G7/Zm/WuHNJaypY0vLHCaC81XFswq1KWZ7Q
	CUn/Tz34Hd5YiJHMD2orJOT+gX/NdbStkiHq/MsVGQNN9hPLgWucyrxFSPDSvVS6M4BZiFAtoCu
	0VumD9NYVbUMXVIBRdVWRBuXjlEDaLSk9Z4Z27Uz64Vaw==
X-Received: by 2002:a05:620a:1195:b0:92e:4799:a808 with SMTP id af79cd13be357-937395be432mr1945679685a.40.1787577852646;
        Mon, 24 Aug 2026 06:24:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749abe858sm495557985a.6.2026.08.24.06.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:24:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wyUen-0000000Cnw4-2s5a;
	Mon, 24 Aug 2026 10:24:09 -0300
Date: Mon, 24 Aug 2026 10:24:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, linux-pci@vger.kernel.org,
	will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, bhelgaas@google.com,
	alexander.deucher@amd.com, mario.limonciello@amd.com,
	felix.kuehling@amd.com
Subject: Re: [PATCH v2] iommu/amd: Force identity mode for selected GPUs only
Message-ID: <20260824132409.GC1449020@ziepe.ca>
References: <20260824085821.5422-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824085821.5422-1-vasant.hegde@amd.com>

On Mon, Aug 24, 2026 at 08:58:21AM +0000, Vasant Hegde wrote:
> Certain AMD GPUs must always operate in IOMMU identity mode. This was
> previously enforced using a PASID check, which happened to work because
> these specific GPUs are PASID-capable. However, this approach incorrectly
> applies identity mode enforcement to all PASID-capable devices, not just
> the GPUs that require it.
> 
> This made sense in the past because the domain allocation API
> (iommu_ops->domain_alloc()) only received the domain type, so the
> driver had no way to inspect device capabilities and pick the most
> suitable page table format (v1 or v2). With the recent driver
> enhancement to use domain_alloc_paging_flags() for all paging
> domain allocations, the driver can now inspect the device and flags
> directly and choose the appropriate page table type per device.
> 
> Update amd_iommu_def_domain_type() to force identity mapping only for
> the specific GPUs that require it, via a new quirks_force_identity_mapping().
> 
> With this change, a system booting in DMA translation mode will now
> select:
>  * Guest (v2) page table for PASID-capable devices
>  * Host (v1) page table for non-PASID-capable devices
> 
> Also drop the amd_iommu_snp_en check, as SNP enforces paging domain,
> which doesn't work with the identity requirement of these GPUs.
> 
> Link: https://lore.kernel.org/all/20200824105415.21000-1-joro@8bytes.org/
> Link: https://lore.kernel.org/linux-iommu/20260723061548.10187-1-vasant.hegde@amd.com/
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
> Changes in v2:
>   - Dropped disabling ATS for "Radeon Pro WX 4100"
>   - Addressed review comments
> 
> @Jason,
>   Once this patch settles, I will send separate patch to drop
>   'untrusted' check inside amd_iommu_def_domain_type().
> 
>   Regarding SME check, I have retained SME chek inside
>   quirks_force_identity_mapping(). If everyone is fine to drop then I
>   will do follow up patch later.

Sure

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +	/* Apply device specific quirks */
> +	if (quirks_force_identity_mapping(to_pci_dev(dev))) {
> +		/*
> +		 * When memory encryption is active, some of these devices
> +		 * don't have the encryption bit in their DMA-mask and
> +		 * require remapping.
> +		 */
> +		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> +			return 0;

I still haven't seen an explanation why this make sense. This
patch says two conflicting things:

1) We need identity for the APU cases because they can't handle
   translation
2) We can't have identity for the SME case because it can't handle the
   high address bit, so use paging.

Surely #2 is also a per-GPU version thing and this address width issue
was fixed in newer chips?

But even so, if paging doesn't work why is it OK to use it for SME? If
paging does work then why do we quirk it away?

Jason

