Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F5020E327
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261555; cv=none; b=XLczNfEuVc4REUInk11NaArT1qykhauy5lv+60CaA1XT7u1fR1xQD82rv98tXxNYJkvlJ52ghE4D6XCEEVXmuOpr+5KWSOv0SgMoEwEG2J/Fxi4UCP8srwmfK1qKtkz5t0w57MR4JMKLc1lsk7crxBfBpSUXNqHf1GXPWCNZTYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261555; c=relaxed/simple;
	bh=ooyQWreopn1rUDCjmodZTJxozlns7OcDb8lQhqxb7zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nReUtPbq0cCeoa37AAHKoNvmd0Ra9MHQXrWrbZ4vGwnUiTE51JXY3izXqy3NS9DqRCPXULK5652mc05fG/UwxVwjOy/LCV0f+9TlBEBj0hJPIXt/fRZPIB1DoBERLo3+qYeE3IH1KB61hUWpNK+5dQ7o48sCVMRFQAYKlvRtIfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SBfh38FG; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SBfh38FG"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5e7aec9e168so1189337eaf.3
        for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 07:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729261552; x=1729866352; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8N0qX+tkHNWSb9091rkzpNULlkCy6tifoy2ta/rdZxg=;
        b=SBfh38FGx7lTD0+EY389XUCR2whk4X2CQyWxV2+r0/axqcUqfdK7I2l0wUa/Ykck4o
         UenQhoJeWhLN/uXdlcPbEvvqnQQGmf/V4WMhCxSUdlIxP+9qQuuYugO4EP2PKjD2ZNAR
         wy7QIyNH7SqcsH6QDswk+tXqGi4NToIGIIl+mbqL/YhakvxelHbxCjhUIcIXmsPnYI+E
         dtyW7P+IqPizblVZ9snkPjQ6NND5QMY0ZxyPS+g0D8bAAj5K7euVAtoSvlO8b2l49lu3
         3i1i2A0dzU9Kr5prbqLOV2B3Tl0R5ePvggjvSt91+wwZRfSmXLLwgSqKkOMgRtXEtC4O
         fULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729261552; x=1729866352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8N0qX+tkHNWSb9091rkzpNULlkCy6tifoy2ta/rdZxg=;
        b=GP0UCTvb+LKWFD9D7CIGpOY1uUqNmBtV1ogZ0ZBaoKRKM/LoRb3PseZYj0p3xRnxzV
         PT74RwBNKqDigXGCRMWLl5PcrHJ0widPulHcE2ObHSnAQRyJ+rpwQbalPgR4GIjdHZ5o
         xSmqxOB7TwWLcOUERgZR7bep7xZmxonhNlDpuhpNQ7TUbc2cdmeLrN8Lgs+sDPNXBXFV
         ALpmKZgXVB5P2c3Wf1xi1mFWLVHBOEzGGnZ4SPUF4hVDZq9Y0uKqI94JhU7tjYaRAHhy
         uQ2zlb+o9SrJjUHSXSZkRbn6azR1xE9wL/40aNMSDzsfFfR30FXobkgkkafLoFqkLBMF
         JrbQ==
X-Gm-Message-State: AOJu0YzDH7ZKI4DpgrmQQnmPJ2/n/JdvXtI+lR+q/FhTb00iEdRNg83Z
	+OxlREuodZ0o+t39OPcPSQ6FbFP5InQ4zVC/OnU7Tk4/FM7o/lqpw39OlEJQ8dk=
X-Google-Smtp-Source: AGHT+IHytFOaw9KmYi7BbeY+3cVyAFAM3ibm47m7bXg9YvQlzm2EHI19KeOk0DQSopbRi3EsJVZQyg==
X-Received: by 2002:a05:6358:724:b0:1c3:8001:b9eb with SMTP id e5c5f4694b2df-1c39de24cf7mr89616755d.1.1729261552634;
        Fri, 18 Oct 2024 07:25:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b15700b3f3sm72188885a.136.2024.10.18.07.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 07:25:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1nvL-008DAy-Mm;
	Fri, 18 Oct 2024 11:25:51 -0300
Date: Fri, 18 Oct 2024 11:25:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v3 08/12] iommu/amd: Pass page table type as param to
 pdom_setup_pgtable()
Message-ID: <20241018142551.GK948948@ziepe.ca>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-9-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017140137.6028-9-vasant.hegde@amd.com>

On Thu, Oct 17, 2024 at 02:01:33PM +0000, Vasant Hegde wrote:
> Current code forces v1 page table for UNMANAGED domain and global page
> table type (amd_iommu_pgtable) for rest of paging domain.
> 
> Following patch series adds support for domain_alloc_paging() ops. Also
> enhances domain_alloc_user() to allocate page table based on 'flags.
> 
> Hence pass page table type as parameter to pdomain_setup_pgtable(). So
> that caller can decide right page table type. Also update
> dma_max_address() to take pgtable as parameter.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>  drivers/iommu/amd/iommu.c | 43 +++++++++++++++++----------------------
>  1 file changed, 19 insertions(+), 24 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
