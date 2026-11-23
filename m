Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426403;
	b=WIcVbUSmVcqwKRwkjojcjJ9ZhtoaBdPKr1bpzRLH2j5OEuDHBujNanCfaYOjM9QxiM+E
	 zIKKfj2oflTHAcYQOXAYYawRCLiBeiYZMTByzjPATF+JhA8TgNPIFDZYo1Sf66bdUjKzE
	 xyPvRIMu5iwGbNPUg0wxuCihSYCQBIZ+SH1kyKqYPtwpXgKJZ49BaHF8FPxQdsaBFuUKO
	 2EisJPchRKwIZIR1Fl4AcYZZpRuIH2XaTQR5SsogtY6rSN90K3SaIDQaFSuXby0MtVQCm
	 HQIsmsl8N18Sx3MhqV7SR90JgrynCdpW+wVaK1zw3rwBZSkEGdMki7CVhOqHjTBCxcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426403;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=jKhKtTQjIJE6EfezE1d2i+cGBwefJa4Rpfrdc7KyzQg=;
	b=IKv1rZ/WJ3kj+qVzGfI/a2VYpL87nPUWkGrJYkilXh0usDKzQuC08NC3qHNTuEKllIst
	 hFMiv4lPYoSsWDWCTOXWH/CFpiPsud1cWdvNmPmxvQqIsQPCrjKhlIeNaWaQS3S/8Jr2v
	 GIt94eM1+8C0ZP8CUqVm/ZmXwWOeTxy412GZcWFvN2LoZLfv7NxEQkPNaqlgdAj+W0RBx
	 D2Cnho2GC5OwmNwFcDEWmGPmiy2kTYMW50EiPUM3y3PGGydmE6Tc2bZcPigVC4pgqzh6g
	 k7/yexyZwLDTEB9drUAtnDYg5Bipsv5oF+Gmj67Y1VxaBrPD65Lt9tbyZg1dihbAgpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=MBHCxdZZ;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF8C606A330
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 09:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BF8C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=MBHCxdZZ
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7D05E20B7167;
	Mon, 23 Nov 2026 01:33:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7D05E20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795426392;
	bh=jKhKtTQjIJE6EfezE1d2i+cGBwefJa4Rpfrdc7KyzQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MBHCxdZZeHLGsZAYcZ5DvIphhCAlf1qfltfp4ConW7vvy4yWxm+cNC17BJmr7jZf0
	 xBfznlulWTDhnmupSW8O/8COGnre75kK6seImc56vpMhqPifFHWg6baTnw4IDhrBb/
	 SvGDfDUNQUcHbFt/c419OhfGpiL2hbtvtF8uiOkI=
Date: Mon, 23 Nov 2026 17:33:13 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Wei Liu <wei.liu@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, 
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Michael Kelley <mhklinux@outlook.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 2/2] iommu/hyperv: Keep a new domain's page tables if
 it cannot be deleted
Message-ID: <hfqiba643klm6y2onbgipn3hc3obyywhn25wl7daqdf4uu3tlq@52oylmrpaujg>
References: <20261123060419.119078-4-oss.patchbox@gmail.com>
 <20261123060419.119078-6-oss.patchbox@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123060419.119078-6-oss.patchbox@gmail.com>

On Mon, Nov 23, 2026 at 06:01:56AM +0000, Yuho Choi wrote:
> When hv_iommu_domain_alloc_paging() fails to configure a new device
> domain, hv_create_configure_device_domain() deletes the domain again,
> and the caller then frees the page tables with pt_iommu_deinit(). The
> page tables are freed even if the delete fails and the hypervisor
> still has the domain.
> 
> The current Hyper-V implementation does not adopt the page table root
> when HVCALL_CONFIGURE_DEVICE_DOMAIN fails, so the page tables are not
> referenced in this case today. This change is defensive: it avoids
> relying on that while the hypervisor still has the domain.
> 
> Create and configure the domain in hv_iommu_domain_alloc_paging()
> itself, and leak the page tables and the domain when the delete fails,
> as hv_iommu_paging_domain_free() does.
> 
> Reported-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> Closes: https://lore.kernel.org/all/20261105141427.00005946@linux.microsoft.com/
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
>  drivers/iommu/hyperv/hv-iommu-guest.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c b/drivers/iommu/hyperv/hv-iommu-guest.c
> index aa1db9db1e97..0110a1529a23 100644
> --- a/drivers/iommu/hyperv/hv-iommu-guest.c
> +++ b/drivers/iommu/hyperv/hv-iommu-guest.c
> @@ -540,10 +540,23 @@ static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *dev)
>  	settings.page_table_root = pt_info.gcr3_pt;
>  	settings.flags.first_stage_paging_mode = pt_info.levels == 5;
>  
> -	ret = hv_create_configure_device_domain(hv_domain, &settings);
> +	ret = hv_create_device_domain(hv_domain);
>  	if (ret)
>  		goto err_pt_deinit;
>  
> +	ret = hv_configure_device_domain(hv_domain, &settings);
> +	if (ret) {
> +		/*
> +		 * The current hypervisor does not adopt the page table root
> +		 * when the configure call fails. Still, keep the page tables
> +		 * while it has the domain, as hv_iommu_paging_domain_free()
> +		 * does.
> +		 */
> +		if (hv_delete_device_domain(hv_domain))
> +			return ERR_PTR(ret);
> +		goto err_pt_deinit;
> +	}
> +
>  	return &hv_domain->domain;
>  
>  err_pt_deinit:
> -- 
> 2.56.1
> 

Reviewed-by: Yu Zhang <zhangyu1@linux.microsoft.com>

B.R.
Yu
