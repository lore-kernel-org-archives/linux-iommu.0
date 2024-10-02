Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0460433A9
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727896029; cv=none; b=fWffeTsTq0fO+AwsQfY24a4SLGIPaL2LbclZXtB1K9WEUlCZ7l7LRvSYvrF6pWexwD7mI7MEeF9wwDVroNIoy9gjjR0k3hiezy8Vs6ltCSx/oKPPXqA4D1feMLphd3ljYg/ZP0wQhzb6zDyEaHsiNMbVpviP8oKoHKmPFOmlzhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727896029; c=relaxed/simple;
	bh=I3AhpJHK/kk4lflD7n0MsvxTzXsSdJvtD6TbmBvMiXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OT83HDja2qUnae0PTy9feJGNA+QmJGE3kIhmxbAk3/ADpnaicZ5zXmf/k0WHBVmPIs7NflC6OT6GFyPRzRHqvHo9W0eshTq5yhrSCNcMH1JJDBBfzu/3s9sflYdLmVrgAk0T/rV5qi0S+4oj6hJ+ZPmK5OrJFi+mlevphx1fdLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SNcUJo+4; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SNcUJo+4"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cb2f344dbbso1339016d6.3
        for <iommu@lists.linux.dev>; Wed, 02 Oct 2024 12:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727896026; x=1728500826; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sMxwsD+5PEh72yG1px5YzohT0AsXJxCspJlLFfuU9ak=;
        b=SNcUJo+4wvh1lGV1R2/idcROiqE8UA38NJhmRFQT75xGM69CEm7eUHrXdNJj+qLGEq
         iq4n1HgQvzUE73K6IlU6pCd7nYnJsk1n1iFwZ50fWGINjki6qSg5rvtt7cxLBCdKPEge
         5NHUBCCe+O1BBGvTQZ6xX8/+//Zdhqkdi3bJvySJLTmrDEzl3HWiJBNpPSstNgQhvADx
         62wqCfqZaQGict7WxwTb81FH2v++tBS7ye0MX1eMzXcPZdaHZD4Bp556tOzrRDY+CbV1
         2do3JYz2FhWR1xAXJ5dXVkIyKGZvPLQxnrIcpmRNtMvD6eD2DUydglvK4eb/pxnaa3AI
         DRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727896026; x=1728500826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMxwsD+5PEh72yG1px5YzohT0AsXJxCspJlLFfuU9ak=;
        b=u+XQCt9aw/mDLS48wZjGl93/sJn4KfgJba2WKO9bKF3YE0bCMLaJ4ijN6rStIY9Xfs
         YRoSMn+JTmY1HLV3AzYGIaPq57AMZpUBOi0iKeByv7GA3wq1KvgTxPmfqrW+xcHZSk/2
         4L+yC0fAejIuNOL8ekK0j9A8hk+Np0GmZUNPVqtfmvNl74TqJjsLsq5eDN+vkaSMdMII
         MCK9blHnwvv5+VTn+arVPIVP06OwuNMWEt+m3q95oCoyAwxxNgsfjg7q20UTnfhoTIbr
         QOR4krXIORnCDVKbboYKW1vu/v0MtTeZgQNN3QXVCSy4a5KelnrsnOVMXGhgFmQeMvBG
         nfLA==
X-Forwarded-Encrypted: i=1; AJvYcCWmazI5QJasiiisTwLmPfVguTVZzf12ztuLbuFMYhVFMLcgQca2bT4r5zpp+Iww2PdMlxql3A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyibAbosj9mKeoAdzW85HDiNk5fPsdRda5O6+3rkqgHeHOJ7fdq
	LrwLPeYNasHIEmvpuyk8olQZRX1ZZy1SWmP/hrA3hWvErqyxv+sQOONmpXqOR98=
X-Google-Smtp-Source: AGHT+IEWGXWdKrSlkji6xJPqo9ac2uTXfn4AEwfbLB0PZoFFqUJTKcwA4QVQdP7zjdDl4vYWV825eA==
X-Received: by 2002:a05:6214:3f91:b0:6cb:dcf:4788 with SMTP id 6a1803df08f44-6cb81bae7d2mr44872166d6.52.1727896026546;
        Wed, 02 Oct 2024 12:07:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b60fbf0sm64604796d6.37.2024.10.02.12.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 12:07:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sw4gj-00ABFC-KD;
	Wed, 02 Oct 2024 16:07:05 -0300
Date: Wed, 2 Oct 2024 16:07:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: jacob.pan@linux.microsoft.com,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>,
	Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
	kevin.tian@intel.com
Subject: Re: [PATCH v2 3/8] iommu: Add new flag to explictly request PASID
 capable domain
Message-ID: <20241002190705.GM1369530@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-4-vasant.hegde@amd.com>
 <a3e09a90-0b63-4332-9e25-a5832d5ec8b2@linux.intel.com>
 <dc29a3e4-04ba-4bfe-b06b-67c4d5bdb5a1@amd.com>
 <c6a29fc4-f08d-4601-a0f2-ef1b5d26a87a@amd.com>
 <20241002142331.GG1369530@ziepe.ca>
 <66fd98e3.170a0220.23d7ae.c2a9SMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66fd98e3.170a0220.23d7ae.c2a9SMTPIN_ADDED_BROKEN@mx.google.com>

> Slightly off topic, in [1], you mentioned the following flow for
> iommu_group_alloc_default_domain()
> {
> ...
> 	if (req_type || iommu_def_domain_type == IOMMU_DOMAIN_IDENTITY)
> { dom = iommu_group_alloc_identity_domain();
> 		if (req_type || !IS_ERR(dom))
> 			return dom;
> 		/*
> 		 * if iommu_def_domain_type == IDENTITY fails then fall
> through
> 		 * to PAGING
> 		 */
> 	}
> 
> If we were to have a vIOMMU that only supports "identity" and "sva"
> domains, there would be no need to fall back to PAGING.

That's illegal. If you support SVA the driver can and should support
PAGING. I don't want to see SVA being special.

There must always be a DMA API domain of some kind, if identity
doesn't work then paging must, otherwise the device is unusable.

Jason
