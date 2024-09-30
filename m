Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B995C18C31
	for <iommu@lists.linux.dev>; Mon, 30 Sep 2024 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727718927; cv=none; b=oY2JZlJgRincH/jEw+zKAFC+8CS2+y0H3Z4ZLqzNiicxwTc2ncsY9yzv5bXm+r0V4RkBTwrPTPJBEZ5NRauAyxc/CrsYKBGbf5gAgoEkc/C4U2/XqeEX/MZWWKj+6px2KGXIJ1cS0GwNjWRXanoYc/ZqkUK1mwR9Ep24H3JpTIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727718927; c=relaxed/simple;
	bh=ztESj6vh04AUuXkZ29RVKGGjakaxb+jNjbyI+9tRH84=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEMfsZI3DDQTBWcvJwLbPAARozo3yjhDKDpZq8N/AtnHdej6uQlHJ9iAP92q7CeIubnXQDENR6njLavvfP5rAroa4X1J6fWNJXgB0qxY/NzwPEbq1bFo65oHon4K1aBu2oXOtIBc58jlblGICKItI2iF6P8ZzFngyDx3tKAXtlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QW+Yv1xc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QW+Yv1xc"
Received: from DESKTOP-0403QTC. (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id B83E020C8C7F;
	Mon, 30 Sep 2024 10:55:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B83E020C8C7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727718925;
	bh=VGTse01yAuu5s22JlH/aQU7SEJMLWQhPrGcWns/o+/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=QW+Yv1xcsHYa54fctRUI8x9p5S95X6NhFIrUmIAWj96JJgOoGPmo6gk/yEtYEPcoy
	 UR4i1PeRO6XILaRPRb9O0OhHbaNpo+sTADOHd2FJ26kF2/PbjZPKHFYPi9Ef0ONeUR
	 ZX3jsnBqTi2zUNntvTplqjh8iC52HAdGwCHt6g08=
Date: Mon, 30 Sep 2024 10:55:23 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, jgg@ziepe.ca,
 yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 1/8] iommu: Refactor __iommu_domain_alloc()
Message-ID: <20240930105523.51fee7c1@DESKTOP-0403QTC.>
In-Reply-To: <d092766e-bae2-4dd0-b274-69fbf5c27971@amd.com>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
	<20240911101911.6269-2-vasant.hegde@amd.com>
	<20240912210207.4ba164c2@DESKTOP-0403QTC.>
	<d092766e-bae2-4dd0-b274-69fbf5c27971@amd.com>
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

On Thu, 26 Sep 2024 15:47:48 +0530
Vasant Hegde <vasant.hegde@amd.com> wrote:

> Hi Jacob,
> 
> 
> On 9/13/2024 9:32 AM, Jacob Pan wrote:
> > Hi Vasant,
> > 
> > On Wed, 11 Sep 2024 10:19:04 +0000
> > Vasant Hegde <vasant.hegde@amd.com> wrote:
> >   
> >> @@ -1962,27 +1978,7 @@ static struct iommu_domain
> >> *__iommu_domain_alloc(const struct iommu_ops *ops, if (!domain)
> >>  		return ERR_PTR(-ENOMEM);
> >>  
> >> -	domain->type = type;
> >> -	domain->owner = ops;
> >> -	/*
> >> -	 * If not already set, assume all sizes by default; the
> >> driver
> >> -	 * may override this later
> >> -	 */
> >> -	if (!domain->pgsize_bitmap)
> >> -		domain->pgsize_bitmap = ops->pgsize_bitmap;
> >> -
> >> -	if (!domain->ops)
> >> -		domain->ops = ops->default_domain_ops;
> >> -
> >> -	if (iommu_is_dma_domain(domain)) {
> >> -		int rc;
> >> -
> >> -		rc = iommu_get_dma_cookie(domain);
> >> -		if (rc) {
> >> -			iommu_domain_free(domain);
> >> -			return ERR_PTR(rc);
> >> -		}
> >> -	}
> >> +	iommu_domain_init(domain, type, ops);
> >>  	return domain;
> >>  }
> >>  
> >> @@ -2965,6 +2961,14 @@ static int iommu_setup_default_domain(struct
> >> iommu_group *group, if (group->default_domain == dom)
> >>  		return 0;
> >>  
> >> +	if (iommu_is_dma_domain(dom)) {
> >> +		ret = iommu_get_dma_cookie(dom);
> >> +		if (ret) {
> >> +			iommu_domain_free(dom);
> >> +			return ret;
> >> +		}
> >> +	}
> >> +  
> > nit, if a user changes default domain types via sysfs and the
> > current domain is already DMA API type, i.e. DMA to DMA-FQ, I think
> > it causes an extra round of iommu_get/put_dma_cookie() compared
> > with doing this in allocation time.  
> 
> DMA -> DMA_FQ will just initialize flush queue and exit. It will not
> enter iommu_setup_default_domain(). In case of DMA_FQ -> DMA it will
> do new domain allocation. Am I missing something here?
You are right. No extra get/put_dma_cookie there.
My other concern is that this change made domain alloc/free asymmetrical
in terms of get/put_dma_cookie.

Currently, we have ftrace like this when I do:
echo DMA > /sys/bus/pci/devices/0000\:38\:00.0/iommu_group/type

    iommu_setup_default_domain() {
      __iommu_domain_alloc() {
        intel_iommu_domain_alloc();
        iommu_get_dma_cookie();
      }
      iommu_domain_free() {
         iommu_put_dma_cookie();
        intel_iommu_domain_free();
       }

With this change, it will be:
    iommu_setup_default_domain() {
        iommu_get_dma_cookie();
	__iommu_domain_alloc() {
        intel_iommu_domain_alloc();
      }
      iommu_domain_free() {
         iommu_put_dma_cookie();
        intel_iommu_domain_free();
       }

