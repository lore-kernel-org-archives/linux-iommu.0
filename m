Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784B81D1E97
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 19:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727896335; cv=none; b=N8IgMRjn6b0PV+3T48wPM6r+aCCaaxOoaHQH9G6r6LxjbH9qZsFnIUcQaKYyi9OLWTDamd+D65MXFtlSIRL2b/R+3Tg5U6vJLLGq1mqWZAwSSkQRkxXS8FkAigJJxxhFb0UYoz8tn6vLSj1XlV3SKCccv2m5n4Ke8CpDqS/1zN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727896335; c=relaxed/simple;
	bh=1yM7GNUrjCyjM5t5697Wn9lX3+r5nxlyk+d35v18CeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4e8YWmeOCH09F0BNGrPJXrJX0z/fED1Q+oloHeM+HUrTUILJMwgcxiGa0c7bpzyIgLcPeaJGdLypw7u+kdDqWCNB6RsC9AGON8j6npx6EQu/X601Asaah28XBBa7JouiXOwwXJ7j8D6B6UDeSOR5GAOrQUIP8nRZh20x0nH1/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AvcxhAvr; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AvcxhAvr"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-45815723c87so1933341cf.0
        for <iommu@lists.linux.dev>; Wed, 02 Oct 2024 12:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727896332; x=1728501132; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Wnr6NGKlaGiUp1fZvjh/uUkuU0Gv+aPE+DpcPqm3qA=;
        b=AvcxhAvrjjDPTAt8aebrpueqipGXV4Web5FTmpE5ekuS+l1KpjWleBWN9aIFsyKXtD
         JCmh1vx5yKXk9ZPZ5AS99//vDOcdWH5D5AAJFfjUJbOZh7OV9eS3ZheuETno42ZSenQN
         Xeh5w93Ai5lnzKlP3rbZLzbcBBtdQuA9RdVgI3R3zoHeZ7ci8bb+pafgIHRt+Qo4DsbE
         BxZi1UeQF8HIXAqvuCALFK16y8EX4Ybbt/Z3Np/qJo13AsnzARBR049NgP95C2UCCO5D
         EKgi2Dc6tAflAqYgY4nbp1BpXh2UjZA0AlUgyBQH0DOJyt8muRnqB2/3R4A3TZPZ6Jd9
         YJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727896332; x=1728501132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Wnr6NGKlaGiUp1fZvjh/uUkuU0Gv+aPE+DpcPqm3qA=;
        b=GdU43tIG2wzFZ1TGmSXLWmeUVFYbKaItR9VBbv/qe21ApTbHd0AtBoTTNIttwG4zkf
         wq9fmy65bStiGy852fKp8MsPW0RmmDQu/myOaPZR14rzyRBpYjELwtmnxRGYipPuO+FE
         yULwPQosawzwltwLtMB3tKmUxFXtt4KWddpj2mC1xg0HsFTelt/vlHylflrpnq3WTA2p
         FYxhtBXaZe1kafIi4p78EXKY0pfng7Arr94h9WZ2XovRYkNfAh709NxnbBdTa7pkvDoA
         uRtZqAidZk7PBOxBEdSyhtOvmKsIc1RxxZBBviafoQyqhaEs8u/QagOQB7Vfw9oUY5Ba
         KFVA==
X-Gm-Message-State: AOJu0YxtrPYD6gKIWo4UpXCbQXIuFtzy4ShsiAM9fJ5VyjjCI/J47EJy
	Mn0POWoRLf1tascJWRkveRtDotlRzrOrb6PJ/ZbnpjHPQsU69AboLZYCR3bJ6Ko=
X-Google-Smtp-Source: AGHT+IEupgLs206NJatZCs36krhM4ozVsEHWLDAT5wUzjjCeVXBlYurkF1PrJJHFPUN5IzOAEk4R+g==
X-Received: by 2002:a05:622a:1a1d:b0:458:3b18:39ce with SMTP id d75a77b69052e-45d8d080e91mr12720101cf.3.1727896332316;
        Wed, 02 Oct 2024 12:12:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f364c70sm59078131cf.97.2024.10.02.12.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 12:12:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sw4lf-00ABgE-0O;
	Wed, 02 Oct 2024 16:12:11 -0300
Date: Wed, 2 Oct 2024 16:12:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 2/8] iommu: Introduce iommu_paging_domain_alloc_flags()
Message-ID: <20241002191211.GO1369530@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911101911.6269-3-vasant.hegde@amd.com>

On Wed, Sep 11, 2024 at 10:19:05AM +0000, Vasant Hegde wrote:
> From: Jason Gunthorpe <jgg@ziepe.ca>
> 
> Currently drivers calls iommu_paging_domain_alloc(dev) to get an
> UNMANAGED domain. This is not sufficient to support PASID with
> UNMANAGED domain as some HW like AMD requires certain page table type
> to support PASIDs.
> 
> Also domain_alloc_paging() passes device as param for domain
> allocation. This is not sufficient for AMD driver to decide the right
> page table.
> 
> Hence add iommu_paging_domain_alloc_flags() API which takes flags as
> parameter. Driver can pass additional parameter to indicate type of
> domain required, etc. iommu_paging_domain_alloc_flags() internally calls
> appropriate callback function to allocate a domain.
> 
> Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
> [Added description - Vasant]
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/iommu.c | 30 ++++++++++++++++++++++++++----
>  include/linux/iommu.h | 16 +++++++++++++---
>  2 files changed, 39 insertions(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
