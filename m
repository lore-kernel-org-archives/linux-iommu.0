Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94FE2F34
	for <iommu@lists.linux.dev>; Fri, 13 Sep 2024 04:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726200132; cv=none; b=X4FQMcwodjYxDGIRlznoJlZq2EdSN+awP5g6kN44c8qJUtD1+WYmOxmQx1iLIXAIUN986m7xJqDcjBaEOiDNOb6V+XNduZs/t9NZAwNQQQqOlE6WWpo7EN1fH7Jja1v6JMeSBePp3/4Qg4oWGJ7KOfOCMykXf5qdE5a+T37IxaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726200132; c=relaxed/simple;
	bh=QRilgyJufoEFrkA/x6t+A1oMgJ7I3O3rDLsQ9bU7Nik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UX9/23OhuY78vfPr5RvosEyADb6oJilDaxx3uiq2w3z7aMBMvL5CKlTVItB3tyQ4nDKATp+RVVehXAxt8iB4Enhj0uQJKQkLR3i8RZvbtRu+6fzdJvDwxUoNlwFzlAw0JSrvtnSdjd+w7G0GqyCeqbsnAGVwStTKpZ8+bTE08wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=S2p0rEco; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="S2p0rEco"
Received: from DESKTOP-0403QTC. (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id DD4B120BE556;
	Thu, 12 Sep 2024 21:02:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DD4B120BE556
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726200130;
	bh=gPQTVSysG+zCOwKw/4DjvygFwXlOFPnequTPwrt6exc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=S2p0rEcoxbSnTevuEemSfQhIy58U3na7Gy+6+HD4iT//QX+uYCFtgeii4L+r4t/FT
	 gF3Xete00GtBD6TlLxtm1vHqFGOA1pcvhUW60zgLjKA8VgAD82EI6Tmddvg5G1VsHe
	 jYhnbQfTxQ/dmL6hbMs2ly/RCaeC96AaD7D0H8vU=
Date: Thu, 12 Sep 2024 21:02:07 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: <iommu@lists.linux.dev>, <joro@8bytes.org>, <will@kernel.org>,
 <robin.murphy@arm.com>, <suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>,
 <yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 1/8] iommu: Refactor __iommu_domain_alloc()
Message-ID: <20240912210207.4ba164c2@DESKTOP-0403QTC.>
In-Reply-To: <20240911101911.6269-2-vasant.hegde@amd.com>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
	<20240911101911.6269-2-vasant.hegde@amd.com>
Reply-To: jacob.pan@linux.microsoft.com
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Vasant,

On Wed, 11 Sep 2024 10:19:04 +0000
Vasant Hegde <vasant.hegde@amd.com> wrote:

> @@ -1962,27 +1978,7 @@ static struct iommu_domain
> *__iommu_domain_alloc(const struct iommu_ops *ops, if (!domain)
>  		return ERR_PTR(-ENOMEM);
>  
> -	domain->type = type;
> -	domain->owner = ops;
> -	/*
> -	 * If not already set, assume all sizes by default; the
> driver
> -	 * may override this later
> -	 */
> -	if (!domain->pgsize_bitmap)
> -		domain->pgsize_bitmap = ops->pgsize_bitmap;
> -
> -	if (!domain->ops)
> -		domain->ops = ops->default_domain_ops;
> -
> -	if (iommu_is_dma_domain(domain)) {
> -		int rc;
> -
> -		rc = iommu_get_dma_cookie(domain);
> -		if (rc) {
> -			iommu_domain_free(domain);
> -			return ERR_PTR(rc);
> -		}
> -	}
> +	iommu_domain_init(domain, type, ops);
>  	return domain;
>  }
>  
> @@ -2965,6 +2961,14 @@ static int iommu_setup_default_domain(struct
> iommu_group *group, if (group->default_domain == dom)
>  		return 0;
>  
> +	if (iommu_is_dma_domain(dom)) {
> +		ret = iommu_get_dma_cookie(dom);
> +		if (ret) {
> +			iommu_domain_free(dom);
> +			return ret;
> +		}
> +	}
> +
nit, if a user changes default domain types via sysfs and the current
domain is already DMA API type, i.e. DMA to DMA-FQ, I think it causes an
extra round of iommu_get/put_dma_cookie() compared with doing this in
allocation time.
