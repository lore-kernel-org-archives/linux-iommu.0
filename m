Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE8C1D0DCE
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 19:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727897052; cv=none; b=USIevCploURoad7CSwhH8cY/jliMYckU1Uv2VzGAf/uW91rEgmRoCkKZTKwDC9cttOch+38ssar29ZRE5AjCvStAGdsJSAaWuCWGcFJY/oXvw44emP5WJzjLOy0fG44xWofn5STiiYp5eNwHoJ8/Qm23pFIsH56Y36l5w0zUXIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727897052; c=relaxed/simple;
	bh=Zc5fLbzG4xP4qaAF7MSKaRyDxPy+RyATbbEFlZ1upGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUBMBWOYGGEeu4W+6w4jCvrf8zbNCVZ8iiEaHAzyn1JZWtNIRiwxoA80VsbjJ8ve//eNi9hTFneHheF2TNFtoupr0niQxYIaWrBpb8emgvr+ljdqXH3XU+EUefmpWdA2WkWD0zChL6V5CcwBLtDQ5zBc0E7g7yRSOs6a2xajnBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hYh26oqF; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hYh26oqF"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a9b72749bcso13855685a.0
        for <iommu@lists.linux.dev>; Wed, 02 Oct 2024 12:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727897049; x=1728501849; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nh9hOXqsdtdQ97cZjt5HVZN8vR/dhWVFunB/mCLzDYg=;
        b=hYh26oqFoXqnw9vXRS7TbVGHmfr/Q8vlPlReJDku685tM0aZfescsSJNdj9YMBlJJL
         vgnX9VyVs0uS2Xl8pRo42TVocwcE7b3SsKiyo+/YfacCOmWBZeijAj+uoaL3s2pg2f4k
         sMPmg2TgqN9FsvZH7qJrxgn+7H0M1HMQJ7FCv6rV0E6TcNcBI0gUvgJIMcZO8iqkWKCn
         fNiCnqGiixKiFPx6G3ljMy8ydqI4uB+fEwpgi1NgA8SsJ8z6J/Q4QogkIgDbSrKwORZo
         FWOjCtqctwHedpTMGJkG9KWgqzhqYZlmAOpq5sh4SYLjEPlb0A5ibQ3hUULqDDSWEAxi
         foBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727897049; x=1728501849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nh9hOXqsdtdQ97cZjt5HVZN8vR/dhWVFunB/mCLzDYg=;
        b=a1et+/gjENOu547vgFGC7YvsGj1oa/0TSJZM58bILmq9D1wxK7cK+WujqkYaczw6HY
         VfoTNj/Z8r2sYNr1yEGQ2EHprInIK04CFHazHXXbxycNuXNhBT5nuCgAO1AzhZKIRedu
         o7LRx5iVGgb4VASBQcgDffWOsKA3DwQZ/jEdi7Q17MvxuhUfPar7FrGVpnxluL0zLbdZ
         VtNevAKWfxmv7xQ4JKfnrQ4a3LyrGSdD+telO+d1qLGu7xXVRLParcKTQMMXiFHYHP6X
         qXIO4OhGlXdEzk8oKfCQqJFdJDqJoN773h9OBbZRhBptGTBGxSo2V1ylcuX9U+5bx/8b
         drmQ==
X-Gm-Message-State: AOJu0Yz7tN4S56MOfBCDSa4lT+9uTS+dUs8d+d8uczHu8Pu+ZYPZNJal
	4STTqoxrZvQoKnxw4ltCoSN4PVE8ilKr73s6KGQ0sruPAHicgr0lkhEz6OmGagA=
X-Google-Smtp-Source: AGHT+IHAUw90EGh3Ox/E7PKjf8fBARlle8x6FPR21TyfZtmpa4uFKE/RPXuMKTU9PuDGKnt+1/hh5g==
X-Received: by 2002:a05:620a:1aa6:b0:7a9:baa5:54d with SMTP id af79cd13be357-7ae626bd851mr700882285a.20.1727897049444;
        Wed, 02 Oct 2024 12:24:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae377e88fdsm641299985a.55.2024.10.02.12.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 12:24:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sw4xE-00ACiR-5s;
	Wed, 02 Oct 2024 16:24:08 -0300
Date: Wed, 2 Oct 2024 16:24:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 4/8] iommu/amd: Separate page table setup from domain
 allocation
Message-ID: <20241002192408.GQ1369530@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-5-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911101911.6269-5-vasant.hegde@amd.com>

On Wed, Sep 11, 2024 at 10:19:07AM +0000, Vasant Hegde wrote:
> Currently protection_domain_alloc() allocates domain and also sets up
> page table. Page table setup is required for PAGING domain only. Domain
> type like SVA doesn't need page table. Hence move page table setup code
> to separate function.
> 
> Also SVA domain allocation path does not call pdom_setup_pgtable().
> Hence remove IOMMU_DOMAIN_SVA type check.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 42 ++++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 16 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
