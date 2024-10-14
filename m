Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CE71CB33E
	for <iommu@lists.linux.dev>; Mon, 14 Oct 2024 19:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728933813; cv=none; b=ekYfzaomOppAmHCh7RFVAq7CHOFR1ho//nQEo/VuVYueSPthxIFWlOz5Vn/nVaqfJROZeJrjZxlO3B26pofekrmHKCWf3F/P2flNXojb2rBUlV5vn8gVusO3x2QOi2bp4aj8dWnzIuqW4C9taXp6wajCGUSDzdPENzOJ4fi4p70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728933813; c=relaxed/simple;
	bh=emeXBtwMn6DtEefBt6yswSxVk1ipftom5++LZf6LU6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pro3/ztgGeqYcaB0jXkSwWk1nRX0LOUqDcvNac9rtH5+6hlU92dbb3Lk7v0c44wdNVBKfr7MQOuIA2Fz5pKMjBrCnKtdPiJX0Tz/QASlNEdeQE34FJ2gmgoD5Ex+tu03xXG+E5UItzYeFL1LdvRCr2b2wo/BW3caApTJvCIwlR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TTLbyDMj; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TTLbyDMj"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-460634ac984so15806651cf.3
        for <iommu@lists.linux.dev>; Mon, 14 Oct 2024 12:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728933810; x=1729538610; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lBhUds+HaOC7zQKJNy3XXJqe6YYOt7fx52YpM7tyG20=;
        b=TTLbyDMjWJ0H8wspq+wXmZEbV5Cxi7VEHS5v2o1ZlUV1wOp77c0uMHzNAZYiobcmUk
         7E40jrjorXsR08axFwi2C/fr1cIgTfe5Mr2UKBNnX7/V9kqJJTesHPvRRSvAE9nY0SnB
         9TMhoU7MpOetxIE+4kmtDLCSEl8Lj2cI2LpXmY8vAYiStpYdPwXiBCL4PCUjV86qR2oF
         ZyVxXn5drSr+vpv4mioEMqr9uGT5fc0K/cFO44C+Mz5JaTLtoPFLx5+j/aqQe2SJUlkg
         7N1Z3xkCRyRsrqGi60IATrBKRSRxFQsyTa8sq2JHoICMTptgf7K0PVqMsxnGb1mYDGJE
         I5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728933810; x=1729538610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBhUds+HaOC7zQKJNy3XXJqe6YYOt7fx52YpM7tyG20=;
        b=LuhJpnJnr6IvLPWrD6GXHrCbj+QXV0bNriO0fcRTQ6Ecj0pb45h8eZc3M6botwKghf
         kgd1x5wT1zJuz+LhnXefzuj/uqEFb0h7cs+NXQ8eBQKQ1IA5vKz0+SJ2nlz4UX/li6hg
         oWRVirFdhmx1bF40A91TNz3beLePqaMFHt2QhhzuyIGEku0uOPQNg+khBTB11TNkAAug
         ZPB/LUva/iYDfrY7YT1lsEb5aZjJoPqSiBZ46JSJ0tj+/BvqUz/jktv+XqJ9a6VpqJhe
         R1MmSzvvhFYvQRYp2O5zL7Qo1wyWLsRoaGTzxrQKDxTrOvDjrKxeAPkbK97jz3f4p4lg
         j++w==
X-Gm-Message-State: AOJu0YyS4mEYGfyYwjDSh3IRw3MNiR/E8BVwNrlFS548jrIkjoWZtYWh
	MMczOH1KqEYjQs13/d6ZvM3zMij5ttBNXKqXNSD09PEDI69DLaji2Hs9imcFcbk=
X-Google-Smtp-Source: AGHT+IHKKfmRJFjO/sDfGl6CDPUc9QgdAJYQY99MHUxI4Xfg2C4EirPx+cp9a8iRn8S8ajuff68K5g==
X-Received: by 2002:a05:622a:11c8:b0:45f:a04:3d84 with SMTP id d75a77b69052e-4604bbcf77amr191886021cf.29.1728933810210;
        Mon, 14 Oct 2024 12:23:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1148c767esm451679185a.20.2024.10.14.12.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 12:23:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t0QfA-008iSk-Of;
	Mon, 14 Oct 2024 16:23:28 -0300
Date: Mon, 14 Oct 2024 16:23:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] iommu/vt-d: Add domain_alloc_paging support
Message-ID: <20241014192328.GC1825128@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-2-baolu.lu@linux.intel.com>
 <20241011132252.GJ762027@ziepe.ca>
 <b2926672-216c-49cf-abea-9848aa52f109@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2926672-216c-49cf-abea-9848aa52f109@linux.intel.com>

On Mon, Oct 14, 2024 at 08:53:36AM +0800, Baolu Lu wrote:
> On 2024/10/11 21:22, Jason Gunthorpe wrote:
> > On Fri, Oct 11, 2024 at 12:27:16PM +0800, Lu Baolu wrote:
> > 
> > > +static struct iommu_domain *intel_iommu_domain_alloc_paging(struct device *dev)
> > > +{
> > > +	struct dmar_domain *dmar_domain;
> > > +	bool first_stage;
> > > +
> > > +	first_stage = first_level_by_default(0);
> > > +	dmar_domain = paging_domain_alloc(dev, first_stage);
> > > +	if (IS_ERR(dmar_domain))
> > > +		return ERR_CAST(dmar_domain);
> > > +
> > > +	return &dmar_domain->domain;
> > > +}
> > With the direction that Vasant's series is going in, I think this
> > should be skipped and instead your other patch to make
> > domain_alloc_user (which we will rename) a full functional replacement
> > is the right thing.
> 
> I think it's too early to remove domain_alloc_paging from the iommu
> driver. Vasant's series makes most of the paging domain allocation go
> through domain_alloc_user ops, but for those that are non-PASID related,
> it still goes through domain_alloc_paging. So perhaps we can clean up
> after both series are merged.

I gave him a few more patches to finish the job, but yes let's not
make them interdependent. Just make sure this series sets things up so
we can delete this and the _user version can do everything

Jason
