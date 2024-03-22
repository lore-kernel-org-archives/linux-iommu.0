Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5BC5D75F
	for <iommu@lists.linux.dev>; Fri, 22 Mar 2024 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127054; cv=none; b=sb5scDrgJj4FhtxHeIukmtUK7Ar0Gso02+KA7tT2iP3cECk7f/nJacdPvhZ4t+vnbsphcHd/5gxu5cZcUvXd4TZCH0unx2i0TCRMDIDtnl8+q7jCLW75cdZxalzX+Epib6T4ucro6nkVgzGLmuqB6nGHbqFKARu5KSk7pCwGLoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127054; c=relaxed/simple;
	bh=F2cON8G466CEiB2xctEBotK4ZUZCOX8kUGGaoxBRHl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjICyPaKqMfskdYH8mi3DirNH12fM8UAsr4zqW1XmV1B6AP2mAWkapjRmTqXdMT/Lr91/nsOmAM/D2AyX57y4GDm6jvZM/hHB3kEj/RCVneam9I0DONqm8qClmSHCW60GCQUNVTRYYNqDK7ANXQyMmn75NWowjAoXFJO/+nApmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DmIVttYi; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DmIVttYi"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-69670267e87so4291846d6.3
        for <iommu@lists.linux.dev>; Fri, 22 Mar 2024 10:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711127052; x=1711731852; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6bmTLjYhpzrW7g0IUEWDDdCG7VehUoT56RlgrSoKr94=;
        b=DmIVttYiA7lenqVteTzbJAO0wFDJOHUBgbrupTEuszmOB4ReKc6eEJgKdrBYRIiTrX
         Rr8QCevuOAJawCSehn3AOsdxEnyXTVSd0Gy8GDVcJyqhTvgpwZKfdWDUkO9tkKOyHjEz
         GLrs5gtPhN9i083OGXBc2Xt/CQaknoeBvIY+PiF9PnIv68ErGtV7pg2tfgT5oP3DzBQE
         JegCXZU2AuthDaxTUr6JTB2u7YfNqZUmDUW2c6+WGuVpHzOgCgW9OYKcCxQ0CatsPQ0R
         N6OKRAezFWiWMlQhgyX8MUmzI0xvokoipeB8cTfgDksBm5t5HJOjSLvEuhBIfzYaJrJc
         9uuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711127052; x=1711731852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bmTLjYhpzrW7g0IUEWDDdCG7VehUoT56RlgrSoKr94=;
        b=UgE93UN70bXIoJ8BOVyydb/xQoNyXXUdLRsDTl9lit+2yxrP/CLiEXgLVPNV2axQbn
         iwv7M4ULCCLMpSfZwJzGRNi/wlJx0QYxao9HPTm10PENFBK9qCc9Iu8sJ1vOQ2DRtt2S
         7KI6ObI0aj2RdvEvkxuSdx29Wc8WUrV+c6usoApBE4OQmcQHN446soFBQfurjEpSi4RW
         EpE5J5+ag0eJg8VJUHvyUALy//mh2dzNqE7mCgYBQyXIzr8j8bj3AmutLK2Kfb5wRX4M
         MOh71E/TJicSXIxbOtBYlPN3TkgUEVFKxQ6UDUhPjj/srrJyz+/mLFQ8FyBxyzQbeb3d
         Mazw==
X-Forwarded-Encrypted: i=1; AJvYcCXUvELxycFmb1kpGDwR7ppSL3Byasy3DrX+8r89DIRv3+0zUVA3YHtk8QsEbAnTRBeeGbA5ZTtRLBH/Cu8gDGf39u1uUEQ=
X-Gm-Message-State: AOJu0YwdJg5qpGz0CXsMGY+5G6NmeweRFwR4qvv8aYVHJL2yGMRvhy9C
	6El262EUG2VGaiDzYZZSuIVp197JyoWs4Yhx2txRRX3nFl6AT0SkWvtwpebYfWo=
X-Google-Smtp-Source: AGHT+IGCuCLf0r0lAOyGbCQQgecN3nqXlLc/lQ8IcmAc2LgzDweXJnwWqJ+Euwk9ABhKAExpPSSADA==
X-Received: by 2002:a05:6214:1250:b0:696:47ea:df2e with SMTP id r16-20020a056214125000b0069647eadf2emr2633333qvv.23.1711127051828;
        Fri, 22 Mar 2024 10:04:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id q15-20020ad45caf000000b0069124066c2fsm1223742qvh.140.2024.03.22.10.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 10:04:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rniJO-00CS0w-OK;
	Fri, 22 Mar 2024 14:04:10 -0300
Date: Fri, 22 Mar 2024 14:04:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/8] iommufd: Add fault and response message
 definitions
Message-ID: <20240322170410.GH66976@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-4-baolu.lu@linux.intel.com>
 <20240308175007.GW9225@ziepe.ca>
 <43ef5e3f-8a8e-4765-8025-b8207fd05f91@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ef5e3f-8a8e-4765-8025-b8207fd05f91@linux.intel.com>

On Thu, Mar 14, 2024 at 09:41:45PM +0800, Baolu Lu wrote:
> On 2024/3/9 1:50, Jason Gunthorpe wrote:
> > On Mon, Jan 22, 2024 at 03:38:58PM +0800, Lu Baolu wrote:
> > 
> > > +/**
> > > + * enum iommu_hwpt_pgfault_flags - flags for struct iommu_hwpt_pgfault
> > > + * @IOMMU_PGFAULT_FLAGS_PASID_VALID: The pasid field of the fault data is
> > > + *                                   valid.
> > > + * @IOMMU_PGFAULT_FLAGS_LAST_PAGE: It's the last fault of a fault group.
> > > + */
> > > +enum iommu_hwpt_pgfault_flags {
> > > +	IOMMU_PGFAULT_FLAGS_PASID_VALID		= (1 << 0),
> > > +	IOMMU_PGFAULT_FLAGS_LAST_PAGE		= (1 << 1),
> > > +};
> > > +
> > > +/**
> > > + * enum iommu_hwpt_pgfault_perm - perm bits for struct iommu_hwpt_pgfault
> > > + * @IOMMU_PGFAULT_PERM_READ: request for read permission
> > > + * @IOMMU_PGFAULT_PERM_WRITE: request for write permission
> > > + * @IOMMU_PGFAULT_PERM_EXEC: request for execute permission
> > > + * @IOMMU_PGFAULT_PERM_PRIV: request for privileged permission
> > 
> > You are going to have to elaborate what PRIV is for.. We don't have
> > any concept of this in the UAPI for iommufd so what is a userspace
> > supposed to do if it hits this? EXEC is similar, we can't actually
> > enable exec permissions from userspace IIRC..
> 
> The PCIe spec, section "10.4.1 Page Request Message" and "6.20.2 PASID
> Information Layout":
> 
> The PCI PASID TLP Prefix defines "Execute Requested" and "Privileged
> Mode Requested" bits.
> 
> PERM_EXEC indicates a page request with a PASID that has the "Execute
> Requested" bit set. Similarly, PERM_PRIV indicates a page request with a
>  PASID that has "Privileged Mode Requested" bit set.

Oh, I see! OK Maybe just add a note that it follows PCIE 10.4.1

> > > +struct iommu_hwpt_pgfault {
> > > +	__u32 size;
> > > +	__u32 flags;
> > > +	__u32 dev_id;
> > > +	__u32 pasid;
> > > +	__u32 grpid;
> > > +	__u32 perm;
> > > +	__u64 addr;
> > > +};
> > 
> > Do we need an addr + size here? I've seen a few things where I wonder
> > if that might become an enhancment someday.
> 
> I am not sure. The page size is not part of ATS/PRI. Can you please
> elaborate a bit about how the size could be used? Perhaps I
> misunderstood here?

size would be an advice how much data the requestor is expecting to
fetch. Eg of the PRI initiator knows it is going to do a 10MB transfer
it could fill in 10MB and the OS could pre-fault in 10MB of IOVA.

It is not in the spec, it may never be in the spec, but it seems like
it would be good to consider it, at least make sure we have
compatability to add it later.

> > > + * @addr: The fault address. Must match the addr field of the
> > > + *        last iommu_hwpt_pgfault of a reported iopf group.
> > > + */
> > > +struct iommu_hwpt_page_response {
> > > +	__u32 size;
> > > +	__u32 flags;
> > > +	__u32 dev_id;
> > > +	__u32 pasid;
> > > +	__u32 grpid;
> > > +	__u32 code;
> > > +	__u64 addr;
> > > +};
> > 
> > Do we want some kind of opaque ID value from the kernel here to match
> > request with response exactly? Or is the plan to search on the addr?
> 
> I am using the "addr" as the opaque data to search request in this
> series. Is it enough?

I'm not sure, the other discussion about grpid seems to be the main
question so lets see there.

Jason
