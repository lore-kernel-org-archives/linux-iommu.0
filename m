Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED75F148318
	for <iommu@lists.linux.dev>; Wed, 17 Apr 2024 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369999; cv=none; b=VhCikxho8yNXAf0GeB26PTUCrIon4gdRsLp/3fIjFjTVxR6v+6aD8UZLEuWu5z+OdYJMVZ3+MGXbgNfZgbP/HhR6krMSi5Xb6TulOivO5f2ZZ7PNSCrYf87tXEVt+3sg3Il2FugZvGkSIQnhhiH0HjKrMrdjHDSSsiGy/f5z4lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369999; c=relaxed/simple;
	bh=TrPp24tMMwGHm8mD4NKNAejLdtRWmMSKpThXrCtR3P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRG2sd7MZCgnTkZ0A5Oos4P/GCFtbTf+KFcmlV1jFPn30ZRcgF4Mne9AnxKqL27Ub5uMBen+QwQriW7IVKZKxN8ojz+7lpkLWzZWtNsXpneYEwQUrtQoZxaszFJKCb2eqAqFdoFleMaz41jJEf+r6+3XLWLm8EdTJcvyF0Oa7+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IMBPXB0v; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IMBPXB0v"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-23319017c4cso3836879fac.2
        for <iommu@lists.linux.dev>; Wed, 17 Apr 2024 09:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713369997; x=1713974797; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=prTQPRIiK+BBCw1mzVVl+h9I6lIr/WlyDI5bHERVORk=;
        b=IMBPXB0vvS7wrUyMX31/1QAFzY+0kdWQWUXSgM1d2+fK/choTXQ2zFLyaCFHqCbwZM
         Bc99vBJoTnKY+1sgjVScsl2s1+eEX1bzrs6PgOzqjSxZ63e3XThsVN2/ib1zjqWsCJfl
         uIAPDMn320D5DNFiUC59WuLE7AD7EsrcKaPbkRF+ebYVlA2oJBrvg7cZwXs7X6/puHNd
         muwbuLERA7NRY00GPlSKn3UNxUYH8HH3rvfCExM804nqgEEwV7SVenitAPUStv5pV/Da
         PVKVQFhm+pmIAIUIbVSaIyJ+/cFd5bz/yD9kalfRdmMycwudb1R+mFltcFb3dhNq//1f
         GY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713369997; x=1713974797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prTQPRIiK+BBCw1mzVVl+h9I6lIr/WlyDI5bHERVORk=;
        b=To7YG2H0IrAXKVnIwqMewSOhbFBo8Eqp5YRRPZNKPKCNK4USTJhxsJLSvK4Ebk8MxX
         UTPMG2D92PjTdcXdKGXOqyMx5AQ22ElP+IylycmqON9ELPSJHFlR8QRBP5ZfrlC1NM3f
         ylKFqeVf4uKwgSOFLEBCYGBJbaJaEQuI2iefjs+Tb0nA49hjdYfAPlEuGnLONzoms4/t
         B/2p0RWLi22B3c5P8gdRzvMWQs1lO4Z2smX2BSIvOghGV+/3lqHyJzUthHJdl4+Pkw7z
         Wo/W6TWREpn0f8oqY5IenZCkPZycZ93Dl2zcIKTxGbmyLu5Uot8d0+EZPY69RsyuMz+T
         h7mg==
X-Forwarded-Encrypted: i=1; AJvYcCXGKTZEL3e60jLDFISTwXlYVjD27PhZD/4NGAwfhj3aWdV4ddh30J7ABj1EZK/8zGRMhxs7jCFpMohqNUSbPrQLclr0GeA=
X-Gm-Message-State: AOJu0YzLkDWEjplhHOmF6BhLK3LKYgqVeRMnXpGIHMoZW8C8fUukxqcE
	8NQ9q9xj4H+nR9wQ0B/cXBCQNqjpwPwK7ckk7mniOGiEEXhzhSVetke68jHOoEU=
X-Google-Smtp-Source: AGHT+IHgcNp6Ar03nDC8wHH+TgVKXTVJyw64Wiji0FyeRStubLgJ2fQw8iiEdkwOb/DsRK4PEj9nWQ==
X-Received: by 2002:a05:6870:14d3:b0:22e:e0ef:3d29 with SMTP id l19-20020a05687014d300b0022ee0ef3d29mr18759481oab.13.1713369996806;
        Wed, 17 Apr 2024 09:06:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id gv6-20020a056870aa0600b0023362a0daf6sm3345950oab.4.2024.04.17.09.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 09:06:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rx7nv-00CQ2l-35;
	Wed, 17 Apr 2024 13:06:35 -0300
Date: Wed, 17 Apr 2024 13:06:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vashegde@amd.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
	ewagner12@gmail.com, suravee.suthikulpanit@amd.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH] iommu: Fix def_domain_type interaction with untrusted
 devices
Message-ID: <20240417160635.GW223006@ziepe.ca>
References: <fa14583e94cbf540b60a6be94b41bb24d0037e75.1713272443.git.robin.murphy@arm.com>
 <20240416152943.GU223006@ziepe.ca>
 <b0db9b48-e9c6-4e40-9d07-c353ab14e4ce@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0db9b48-e9c6-4e40-9d07-c353ab14e4ce@amd.com>

On Wed, Apr 17, 2024 at 10:53:00AM +0530, Vasant Hegde wrote:
> >  - DART
> >    * system page size is too small, can't map IOPTEs, force identity
> >    * iommu does not support IDENTITY at all, force paging
> >  - tegra: Device quirks mean paging and DMA API doesn't work
> >  - amd: The driver can't support PAGING when in SNP mode
> 
> Actually When SNP (Secure Nested Paging) is enabled in host, AMD driver forces
> DMA translation mode with AMD V1 page table.

Why does it return IDENTITY?

	if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT) && !amd_iommu_snp_en)
		return IOMMU_DOMAIN_IDENTITY;

If the HW can't support IDENTITY then it needs to return
IOMMU_DOMAIN_DMA..

> > Since actual PASID AMD attach isn't implemented yet we could just
> > remove that check from def_domain_type as an RC fix. Vasant can sort
> > it out properly by disabling pasid support on untrusted devices until
> > the DTE logic is fully completed.
> 
> Keeping PASID support aside, largely the question is who should handle/decide
> domain type for untrusted device? Is it core IOMMU layer -OR- HW
> driver?

def_domain_type() should return a HW limitation. It has got muddled up
with the default domain type stuff, but in essence it's usage right
now is to tell the core code that a specific device cannot support
IDENTITY or PAGING. It should be combined with a matching test in
attach_dev to block the unsupported domain combination.

The core code should use that information to decice on policy. If the
device reports it cannot support PAGING and the device is untrusted
then, IMHO the core code should leave the device blocked and
inoperable for security.

The key thing is this API should not be used for the driver to inject
some kind policy/optimization choice.

>   - If its individual driver, then I can try to add fix in AMD driver. But then
> what is the expectation? Driver is expected to return IOMMU_DOMAIN_DMA -OR- core
> IOMMU layer is expected to adhere to whatever driver returned?

If driver and HW supports PAGING and IDENTITY attaches to the devices
RID then it should return 0.

If only PAGING is supported it should return
IOMMU_DOMAIN_DMA. alloc_domain_paging(dev) should select the correct
page table format - including a format to enable features like PASID.

If only IDENTITY is supported it should return IOMMU_DOMAIN_IDENTITY.

If AMD SW cannot support PASID & RID PAGING right now then it should
return 0 and fail that attachment combination during set_dev_pasid().

In the interm you should instruct users to use the command line option
to force IDENTITY until the driver work is completed.

If there are embedded GPUs or something that have an implementation
that bypasses the IOMMU for DMA then you need an ID list to check
against like some of the ARM drivers do.

Jason
