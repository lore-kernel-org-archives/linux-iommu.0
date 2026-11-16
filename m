Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844704;
	b=PXk82xA2pn52OhYAVYd/Gg8eHS5R35Zc6k6yVl9b8ZOZAZV7m8I+HAMjx1QcJ/YK7XOS
	 ainLsE0O3R9paVnX38TIpGFWrTsCMsvf5RSQI6kFJqGx6LPAYvtSwoa54wT9x/pkl4OD5
	 QxNXGTwa0pnYLGyolwaacpm9SKdUFSbL79efTSA46GVRoH19zDZEsY7iZzVsQTwvNYwmY
	 vlwtoxrLI1FhdYYQem1arJv7Znk9o6gVY2PWuyMP39yN+q4WCIK6VV0Q0PAlu3zaP6PLL
	 KgHfSYcerZxL70on8v+8jll7OuCs4D+UlKhlo2vgWL1k0bObE0XXE6O7CqSWlqkE6+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844704;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=u4SFVD7jxf9RuHxTJCNcwPNhfgv8lj7Sm/PppY2wowY=;
	b=L4AqvEDBUN4aTxJaqiXvHHoubrxI7fwmsZsaSFEWxcH2fCZSwURGzxi0EOJH7Ih7AMgO
	 TQQB9E8bby9XbqVmwrG3dTItGeFC3E0WLlZYugsr/66qb13HoSjOvmUvuluUqpYrFmrEv
	 5FBmTtemexwL2uE+XhfQaud4FQHtcj2hD0AFL73tHH//UDRd+4ylU1YYeUQJTB/61xD/a
	 SDiYBubmuJEQ0rtAoH564k9WONFs3H8hyhP1w39vihIHS5utrXpcojcgwyo8kVkf2RCHB
	 0eZr9U6t3jz+wmnlnPEaGb6KWCBJNdSA1Dk9Ya0M2FQyymrAltGlDAALEGqKxdtpWmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=loQEIcb2;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B463606A322
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 15:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B463606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=loQEIcb2
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 301BC20B7168;
	Mon, 16 Nov 2026 07:58:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 301BC20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794844697;
	bh=u4SFVD7jxf9RuHxTJCNcwPNhfgv8lj7Sm/PppY2wowY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=loQEIcb2c0PH3xTtaO4N/BcjSBsGzV+Qn6Ka1RCJcvrh7+BEXzpo2pMvSn3dmAkuy
	 qgBv1BzG2UuVC5gmT0+vIeqk6ktzLeNYnq3t+I8LB3Rcka/nc1e4Z2F37YYy93qlC0
	 JXQbiR6a3R++PzfiSIbtihHj/U9Il5T2Ujwm/zX8=
Date: Mon, 16 Nov 2026 23:58:21 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Wei Liu <wei.liu@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, 
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Michael Kelley <mhklinux@outlook.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 1/2] iommu/hyperv: Don't free a paging domain the
 hypervisor did not delete
Message-ID: <wvvoqqavra5lvqi3hnvcgl4y3jzbk3b2f6h7vlkwpksjuqgoqm@rhzwlj2ieozi>
References: <20261112195710.1417744-4-oss.patchbox@gmail.com>
 <20261112195710.1417744-5-oss.patchbox@gmail.com>
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
In-Reply-To: <20261112195710.1417744-5-oss.patchbox@gmail.com>

On Thu, Nov 12, 2026 at 02:56:59PM -0500, Yuho Choi wrote:
> hv_iommu_paging_domain_free() frees all page-table pages with
> pt_iommu_deinit() and only then asks the hypervisor to delete the
> device domain that points at them. If HVCALL_DELETE_DEVICE_DOMAIN
> fails, hv_delete_device_domain() only logs the error, returns the
> domain ID to the IDA, and the domain is freed anyway.
> 
> The hypervisor then keeps a device domain whose page tables have been
> freed and can be reused for anything. The ID is also handed out again
> by the next paging domain allocation, while the hypervisor still has a
> domain with that ID.
> 
> Delete the domain before freeing its page tables, and keep the ID, the
> page tables and the domain if the hypervisor fails to delete it. WARN
> when the delete fails, as the domain is then leaked.
> 
> Fixes: 2690d4156b51 ("iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest")
> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
>  drivers/iommu/hyperv/hv-iommu-guest.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c b/drivers/iommu/hyperv/hv-iommu-guest.c
> index 9f4fa4315091..aa1db9db1e97 100644
> --- a/drivers/iommu/hyperv/hv-iommu-guest.c
> +++ b/drivers/iommu/hyperv/hv-iommu-guest.c
> @@ -107,7 +107,7 @@ static int hv_create_device_domain(struct hv_iommu_domain *hv_domain)
>  	return hv_result_to_errno(status);
>  }
>  
> -static void hv_delete_device_domain(struct hv_iommu_domain *hv_domain)
> +static int hv_delete_device_domain(struct hv_iommu_domain *hv_domain)
>  {
>  	u64 status;
>  	unsigned long flags;
> @@ -122,11 +122,15 @@ static void hv_delete_device_domain(struct hv_iommu_domain *hv_domain)
>  
>  	local_irq_restore(flags);
>  
> -	if (!hv_result_success(status))
> -		hv_status_err(status, "HVCALL_DELETE_DEVICE_DOMAIN failed\n");
> +	/* If the domain still exists, its ID cannot be reused */
> +	if (WARN(!hv_result_success(status),
> +		 "HVCALL_DELETE_DEVICE_DOMAIN failed: %#llx (%s)\n",
> +		 status, hv_result_to_string(status)))
> +		return hv_result_to_errno(status);
>  
>  	ida_free(&hv_domain->hv_iommu->domain_ids,
>  		 hv_domain->device_domain.domain_id.id);
> +	return 0;
>  }
>  
>  static int
> @@ -466,11 +470,16 @@ static void hv_iommu_paging_domain_free(struct iommu_domain *domain)
>  {
>  	struct hv_iommu_domain *hv_domain = to_hv_iommu_domain(domain);
>  
> +	/*
> +	 * If the hypervisor still has the domain, it may still use its page
> +	 * tables, so leak them.
> +	 */
> +	if (hv_delete_device_domain(hv_domain))
> +		return;
> +
>  	/* Free all remaining mappings */
>  	pt_iommu_deinit(&hv_domain->pt_iommu);
>  
> -	hv_delete_device_domain(hv_domain);
> -
>  	kfree(hv_domain);
>  }
>  
> -- 
> 2.43.0
> 

Reviewed-by: Yu Zhang <zhangyu1@linux.microsoft.com>

B.R.
Yu

