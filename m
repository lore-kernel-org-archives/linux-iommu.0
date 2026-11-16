Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849889;
	b=t+mjoKgjrURC+sR7efktPhMVM/DqcZ75JJuUDQy1uictPhLgLBHnzXRrsvH2CY5Cv6SZ
	 sRdbun5n5zpd5WIPJ6am5LNXYKEQjm0AABKAAECuuj9w2u6wzkm1eEPfUE/OccThyw+sN
	 iRDBEjPNiLU9K5FIKIqaQlcMJPzR9KyYI5ZW1N6oSQPXi8h3xrErIEvT5o5H3q3t0sMKp
	 ojAEtosnZtb5ldVNCdyXbF0oicaTSTcTtEcbNTd+9sd8hBq/ovJlAYqdGQXax4uqeNlMJ
	 0hnact1n/YQgJunRSsKvw6SBHvcCYviqsVK/Tj3VpHEVsdP9PJ02Wuv7ZNq8DPTRxSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849889;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=UkGGtC4MrT++RRjl6LlCaknnygwt1Don0oHcvwreUSY=;
	b=qrmBWSPFVcGi3uaRdUJKzPiIcJ5oz1wu0kILtkkJgcN/TESuW/oDS568HUHAeniZrts2
	 VXcLFz6jfontglPp3bOk60rxE6lQUQN30ixk/n8q7QRog5siONGGnM6p9g4vgO5jxx0tJ
	 8LywF0jPkJAdd7FKX2RjGlz5LWH56iXPHCIDv/MsLEuDoZc64ax1a61DLKsmoV9PT6ZpO
	 erXti2v9cvD3bwn0TUzyd+p2byz/Fu2je3RsDJCMrI9Zq7AtsyEKEbAZljG9MkDWEfobe
	 naTirEcY+hLkT204zds6LtEBHUxsgzyvdDpg5MdNgWMw60se8SUBt+MBpxQ3QY2hwhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="hishp/Px";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2E0606A322
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 17:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A2E0606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=hishp/Px
Received: from [100.64.208.118] (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8F9EE20B7169;
	Mon, 16 Nov 2026 09:24:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8F9EE20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794849882;
	bh=UkGGtC4MrT++RRjl6LlCaknnygwt1Don0oHcvwreUSY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=hishp/PxqZKawN7+bLX36R+bUBwplR/xTWnv4ogc8XDWBEMg25urlixBfdJU2Yn2/
	 7Xp+E9/2U3yEPYzTmE7wbmT08K4N4dPsqk6BKVowGF26G9zlxrAKJtY1/Oj1FntGtc
	 gKBTvdtXb6464pQbrINjkZ4o4RjgT/kFA4ecQGX4=
Message-ID: <c0638e6a-678f-43b8-9cc7-5dc05395b898@linux.microsoft.com>
Date: Mon, 16 Nov 2026 09:24:46 -0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Wei Liu <wei.liu@kernel.org>, easwar.hariharan@linux.microsoft.com,
 Robin Murphy <robin.murphy@arm.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>, Yu Zhang <zhangyu1@linux.microsoft.com>,
 Jacob Pan <jacob.pan@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 iommu@lists.linux.dev, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iommu/hyperv: Keep a new domain's page tables if
 it cannot be deleted
To: Yuho Choi <oss.patchbox@gmail.com>
References: <20261112195710.1417744-4-oss.patchbox@gmail.com>
 <20261112195710.1417744-6-oss.patchbox@gmail.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20261112195710.1417744-6-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/2026 11:57, Yuho Choi wrote:
> When hv_iommu_domain_alloc_paging() fails to configure a new device
> domain, hv_create_configure_device_domain() deletes the domain again,
> and the caller then frees the page tables with pt_iommu_deinit(). If
> the delete fails as well, the hypervisor still has the domain, which
> may already point at the page tables, and they are freed anyway.
> 
> Create and configure the domain in hv_iommu_domain_alloc_paging()
> itself, and leak the page tables and the domain when the delete fails,
> as hv_iommu_paging_domain_free() does.
> 
> Fixes: 2690d4156b51 ("iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest")
> Reported-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> Closes: https://lore.kernel.org/all/20261105141427.00005946@linux.microsoft.com/
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
>  drivers/iommu/hyperv/hv-iommu-guest.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c b/drivers/iommu/hyperv/hv-iommu-guest.c
> index aa1db9db1e97..ef486ffa0be4 100644
> --- a/drivers/iommu/hyperv/hv-iommu-guest.c
> +++ b/drivers/iommu/hyperv/hv-iommu-guest.c
> @@ -540,10 +540,18 @@ static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *dev)
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
> +		/* See hv_iommu_paging_domain_free() */
> +		if (hv_delete_device_domain(hv_domain))
> +			return ERR_PTR(ret);
> +		goto err_pt_deinit;
> +	}
> +
>  	return &hv_domain->domain;
>  
>  err_pt_deinit:

With the commit message and comment fixes as requested by Yu:

Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
