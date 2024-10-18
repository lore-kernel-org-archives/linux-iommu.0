Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57791EE028
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261650; cv=none; b=SMs/XzMD6xcjNdle5nCNfBIHz05gymGAZOZX5TG100RconuReQSFoEqtDP+VdsZXNE4R5HZW77/ErLm8jJszOvnHKTPuggdn9AMxmO3d/60lT+qJHxNgjb1NPdqY4h3kMr6m0Lvt68DE/2F4TJxS1L5PuJMFwnN0LUZgBi6sVUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261650; c=relaxed/simple;
	bh=pb8tkMhRHM8Pmh43Puim4I+7u1KCNUYwJ2KUR/lwMl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bf0aemHchVWYNUeH5TajzGV7geUB03L3mgkPMMx6DKpbJd9NXMM97TPCHbCHIEKFvW5JlZIC30wKDahkekfOheKER39/qCXlUb/GSPBHrkMQEI3QI/TsXk9LYbPm3Mtqv3D+1lAqjsHmpdxMyJ70lKl7P4PF3tpcTKLYYnsw8m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QTNrLD7O; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QTNrLD7O"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cd7a2ed34bso5537586d6.2
        for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 07:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729261647; x=1729866447; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=34HIjuRAc8U/hbMOPwI0hKdXqL3JV3Ir2fwLfVSe+sU=;
        b=QTNrLD7OxLBxGvpohrDuJxrufWEuuaQQewx1kANQ1OABfZeaSF9KQ9aF7gB38w3rkf
         oFLWlTqIYTsnoegsIE78KZdm6odknbcVscp/RdTmq8EMXHwpvLmsc3+xn0GmZltJry8A
         TGVMrCG1k9QzcdoHUFEftGqoTLRPcGJ0lIWvaUDxekrGVwdxh1Z848nFeSMssGc9c8wf
         uavoFUxKA6V1LKOnpjmXvb43xc/UtM/x3vADc9E/7h249L5iZHU+48U8ukWL62ouIc0m
         FyuG+43wri2rpzyeLc7nodkdtXNH7hisKrGTobWK7V6T+dY0v1a8SDzHWd0tnDWQY0qi
         St6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729261647; x=1729866447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34HIjuRAc8U/hbMOPwI0hKdXqL3JV3Ir2fwLfVSe+sU=;
        b=T4MXOXa914076tKQHxy/31XIb7Y3AUnwUkLftsRA6mEccEm5ObFfAH0QTvtp9D5zBO
         i2rnn8AVVYN9kcmJ8xLFLfypDpdSSd2vIZqvrSpQyNpEpW/FVPKrHcsS4V7vQPbarCL1
         waOzCEQ4KJ2AXm0WCvMVrLDCxFQR+3BseUJnHCvDd8DhrQJ+qQDqxT8KBPTORvWcs4V1
         C7fFfqoL2j7enmHehxl36xbPemYRMZrWzhWuseChDAP/JqnApAqiVV5stKy/SIHu8B9T
         ApI395IFnmfOaMtixhkDYCiK8+RywSrGAe97ZYnJAX9QN84Zzv+z1jVc1TzngsSFHJeI
         dF9Q==
X-Gm-Message-State: AOJu0YxsohK94Z88Yo5XZCKPoef79Efj780JnkEvps0QH2AhzgUB4q9I
	Eior7NHjF7K28HkZmFb6qZdzrh6kCpbEWcmmfKO38ZKCjfIEY+GoCsHFMihlZ6o=
X-Google-Smtp-Source: AGHT+IEgqPjkU/zv86lpGoMyJoDFT6WRweFwgFzDiZhAGwxl65F78yf6bvSXA1TjrZkFjpUm86yk7A==
X-Received: by 2002:a05:6214:5d0d:b0:6cb:e770:f50b with SMTP id 6a1803df08f44-6cde15ec09dmr29993326d6.33.1729261647528;
        Fri, 18 Oct 2024 07:27:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde1366d96sm7430546d6.126.2024.10.18.07.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 07:27:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1nws-008DaC-L8;
	Fri, 18 Oct 2024 11:27:26 -0300
Date: Fri, 18 Oct 2024 11:27:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v3 09/12] iommu/amd: Enhance amd_iommu_domain_alloc_user()
Message-ID: <20241018142726.GL948948@ziepe.ca>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-10-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017140137.6028-10-vasant.hegde@amd.com>

On Thu, Oct 17, 2024 at 02:01:34PM +0000, Vasant Hegde wrote:
> Previous patch enhanced core layer to check device PASID capability and
> pass right flags to ops->domain_alloc_user().
> 
> Enhance amd_iommu_domain_alloc_user() to allocate domain with
> appropriate page table based on flags parameter.
>   - If flag is empty then allocate domain with default page table type.
>     This will eventually replace ops->domain_alloc().
>     For UNMANAGED domain, core will call this interface with flags=0. So
>     AMD driver will continue to allocate V1 page table.
> 
>   - If IOMMU_HWPT_ALLOC_PASID flag is passed then allocate domain with v2
>     page table.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index cb6a72564c23..87eff85c0c23 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2404,6 +2404,20 @@ amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
>  {
>  	unsigned int type = IOMMU_DOMAIN_UNMANAGED;
>  
> +	/* Allocate domain with default page table */
> +	if (!flags) {
> +		return do_iommu_domain_alloc(IOMMU_DOMAIN_DMA,
> +					     dev, 0, amd_iommu_pgtable);
> +	}

Extra {} ?

> +	/* Allocate domain with v2 page table if IOMMU supports PASID. */
> +	if (flags & IOMMU_HWPT_ALLOC_PASID) {
> +		if (!amd_iommu_pasid_supported())
> +			return ERR_PTR(-EINVAL);

Depending on what we decide this could be
amd_iommu_v2_pgtbl_supported()

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
