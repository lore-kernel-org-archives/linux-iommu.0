Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E4029422
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046570; cv=none; b=pnrbTtCTdbLRzJBqF9Yih5ldxcM7trA+A7WWpIcLop2P/ndQ32M9k1v7EwGbLe8vKGfl5FpBVl8sf7t2ecbPxXODIoA53+nNxBce8PcRG3D9bGgGI2nsFVjBpazOLpfWJOyvlwGzZnR9MSkbgH8ZzjlvRofWcByTxmvXAedW3gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046570; c=relaxed/simple;
	bh=jP/w37KYhLW1ZnJJcPsv5ibiTjlGIk4BwBThLcU706I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYjUBqP5vQHL/A0kVSi4Uubmh2YAkgQy2kWwBAY/kuoLPxJEjWaJSdY3MTd6MEqDDXS+qBuyhdCrPwpb3+OreXMvci0ONdR0CEgRKxqeb0byYhMcw1NspuEULcYrI4kfv28mY+4higSPSfQ6xh1nJWUBPftCPUbnvucOaRzcXOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TkD2MPEw; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TkD2MPEw"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a99de9beb2so113578385a.3
        for <iommu@lists.linux.dev>; Fri, 04 Oct 2024 05:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728046567; x=1728651367; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PIn/ayOPhdntoadEcTqIonvvHd5dS6ypUUweoj8CCTA=;
        b=TkD2MPEwvr42nTMA4VXt0fdx88GQZdhW1cP1hiHJyzK/lxXml1vOzg2HfR9m3Dr1EN
         9AbkurHitJZ4BMuViC1Nw7eGPXEJmbAA4tfa8h3ySI2hy8TMAs2YLfKGLxnFPWng9XUb
         LQ8YBEDNyNyVMmG48pMqkqMTf9juOrXikqo2NrP7tUJIXAF0xbNMXqX4mwLfihiECGkE
         exXUWuaogydl6R13kjIaoLwPw7sMFDe9QXCSzO3W1RIz6TDtmrDR7dWpFMfkF63INO1U
         lERKyHwxGcPBn4b04oo2J/4jBC0/hFKnXz2lgrF1CobNk9T/3BKXk6VvnR2xwMxssaq6
         WteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728046567; x=1728651367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIn/ayOPhdntoadEcTqIonvvHd5dS6ypUUweoj8CCTA=;
        b=Tssofu+4NLdno6ZAAZ1p9a2XtGpxkKJcm9Rv3QwU1uK/yzWNKZRzBO57vPlazRBWR/
         /CNGgJ0BrbosUv1ZXIf4FhmpFt7qcQ/JkjJGhk0pLQjmPj6LGDP7wZkAp36oKn8EW3B5
         yGrFLPyxFyR9/rYUnR+ogLURFdQcwRPRcy+38r2sHK13edAXcNpdwGDJ6sstsahVM/cK
         EUBKN5QhjMLa6aNo1r0sqCM+2pYSkd7JbjbognVWkwpp1BTN0ZtF9M2uW9+gDnLsZZLC
         lxWT5nEkZeonq61qlikAkcAF4A0ruQpFKkHMjN1iVFz6e156MlyDjfaZp0EnheNSlA9C
         083A==
X-Gm-Message-State: AOJu0Yz8orFmay2NnvH/wJUCuJLbceCG8NNZfeK32An4lTiFH7Kd3FJR
	rlwaX3jaGJJXtrHCEbZHD/qJ89nP6U5CzguaDZ0vSOVfcXvOYTVgkd68rkLnwDc=
X-Google-Smtp-Source: AGHT+IFWj/Si2NSk7k7qnbjh60oGy2BaV3asukLzbLlJQTun4hQ4KWmEiSQmApbC3C9lFDnVxXEysQ==
X-Received: by 2002:a05:620a:28c9:b0:7ae:6ba2:faba with SMTP id af79cd13be357-7ae6f44b54fmr427783485a.28.1728046567107;
        Fri, 04 Oct 2024 05:56:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b3e9028sm133301685a.136.2024.10.04.05.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 05:56:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1swhqo-00CfZm-6l;
	Fri, 04 Oct 2024 09:56:06 -0300
Date: Fri, 4 Oct 2024 09:56:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 7/8] iommu/amd: Add iommu_ops->domain_alloc_paging
 support
Message-ID: <20241004125606.GH2456194@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-8-vasant.hegde@amd.com>
 <20241002193345.GR1369530@ziepe.ca>
 <1f6110a2-a21d-45e9-bfcb-7d3650ff889d@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f6110a2-a21d-45e9-bfcb-7d3650ff889d@amd.com>

On Fri, Oct 04, 2024 at 05:25:20PM +0530, Vasant Hegde wrote:

> >> +/*
> >> + * Allocate domain with default (amd_iommu_pgtable) page table type. Core will
> >> + * call domain_alloc_user() interface to allocate PASID capable domain.
> >> + */
> >> +static struct iommu_domain *amd_iommu_domain_alloc_paging(struct device *dev)
> >> +{
> >> +	return do_iommu_domain_alloc(IOMMU_DOMAIN_DMA,
> >> +				     dev, 0, amd_iommu_pgtable);
> >> +}
> > 
> > I think you should avoid this. The _user one (aka extended) should
> > handle everthing. It doesn't really make sense anyhow, as the legacy
> > VFIO path is going to take this branch as it will have 0 flags.
> 
> I should have been bit more clear in cover letter.
> 
> I thought eventually we want to remove ops->domain_alloc() interface. Hence I
> introduced domain_alloc_paging(). I didn't remove amd_iommu_domain_alloc() in
> this series. I was planning to do it in later.

We do want to remove domain_alloc

> If we are fine to keep ops->domain_alloc() then I can just drop this patch.

But why not just remove it and not add amd_iommu_domain_alloc_paging ?

Your prior patch does this:

+	if (ops->domain_alloc_paging && !flags)
+		domain = ops->domain_alloc_paging(dev);
+	else if (ops->domain_alloc_user)
+		domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
+	else if (ops->domain_alloc && !flags)
+		domain = ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
+	else
+		return ERR_PTR(-EOPNOTSUPP);

So if !ops->domain_alloc_paging && ops->domain_alloc_user it calls
ops->domain_alloc_user()

You just need ops->domain_alloc_user(flags == 0) to allocate the
fasted/best page table with no-PASID support (ie v1 in most cases) and
everything is fine.

Don't add amd_iommu_domain_alloc_paging(), just add the above
paragraph of logic to ops->domain_alloc_user()

The point of all this fixing was to stop using IOMMU_DOMAIN_DMA to
select a page table format and instead rely on IOMMU_HWPT_ALLOC_PASID
to make the selection. The core code and VFIO will set
IOMMU_HWPT_ALLOC_PASID properly for what it wants to do. I expect the
driver to rely on IOMMU_HWPT_ALLOC_PASID exclusively.

Jason
