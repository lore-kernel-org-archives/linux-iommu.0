Received: from out198-20.us.a.mail.aliyun.com (out198-20.us.a.mail.aliyun.com [47.90.198.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D7E22F74F
	for <iommu@lists.linux.dev>; Thu, 18 Sep 2025 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200940; cv=none; b=HIjBOE2QC8qQ3fNgPsLtNDsG+43im/yqMmRQFMCObEUteTQGmM9BRLY5/jKMpRfeDQ8olLT5S4/v5ttcMpwjlpQg/fHpOJLxU0wWBbDeWQI8es78yRlKzofg2fIBFnqisSl2caYk6b87h1k0uwDbYD3mLuLXPOgy7SLGpDqgHcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200940; c=relaxed/simple;
	bh=oZQ71Yy3FFXzAfFjGRoYoDt9iQTanIC3d59za0gF9uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTTqczwTtKvcxORF0LBx9C/aAlyU7vx65wml8CTnEBmvm/CEOpIZQIko+lsRYRRu+ERSkHwpCNWrQEVVobVwORjc5Mt5vtKhjOmSrc9uHmWHPFyS1Ms9mYjUiqQcq+MUSBlg0+5SAVIK6cXnjC32tpGNc/p+k6zxQVBzYIDtg9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=mUKTHI7j; arc=none smtp.client-ip=47.90.198.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="mUKTHI7j"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1758200918; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=FkGC7xMtyZHkHFCU8at9IRUS9IWm3LClfP+d5+rXRK8=;
	b=mUKTHI7jn8cfsjM9QIR2IvNeoQsUqwaf3AFz2O1thGESFizRO32J/pj8KdmvfMxyytK2uJEACMv473crG1LF4JVDoL4t6zRq17QzsbFHlG6pG57eIdPcED3czcmt2fnuZKIcrU54twWHP0aM9yCQqsQEqKKhNFpyXF9AdfoFkQg=
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.ei7pEXX_1758200600 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 18 Sep 2025 21:03:20 +0800
Date: Thu, 18 Sep 2025 21:03:20 +0800
From: Hou Wenlong <houwenlong.hwl@antgroup.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Ensure GA log notifier callbacks finish
 running before module unload
Message-ID: <20250918130320.GA119526@k08j02272.eu95sqa>
References: <20250315031048.2374109-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315031048.2374109-1-seanjc@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Mar 14, 2025 at 08:10:48PM -0700, Sean Christopherson wrote:
> Synchronize RCU when unregistering KVM's GA log notifier to ensure all
> in-flight interrupt handlers complete before KVM-the module is unloaded.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  drivers/iommu/amd/iommu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index b48a72bd7b23..b314523d9194 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -982,6 +982,14 @@ int amd_iommu_register_ga_log_notifier(int (*notifier)(u32))
>  {
>  	iommu_ga_log_notifier = notifier;
>  
> +	/*
> +	 * Ensure all in-flight IRQ handlers run to completion before returning
> +	 * to the caller, e.g. to ensure module code isn't unloaded while it's
> +	 * being executed in the IRQ handler.
> +	 */
> +	if (!notifier)
> +		synchronize_rcu();
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(amd_iommu_register_ga_log_notifier);
> 
> base-commit: ea9bd29a9c0d757b3384ae3e633e6bbaddf00725
> -- 
> 2.49.0.rc1.451.g8f38331e32-goog
> 
>
Hi Sean,

Sorry to bother you. I'm reworking the hardware_setup() path in our
internal multi-KVM, but I didn't see any usage of
'amd_iommu_register_ga_log_notifier(NULL)' in the KVM code for now. Has
it not been committed?

Thanks!
