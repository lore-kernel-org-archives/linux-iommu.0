Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B6148BD29
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999700; cv=none; b=ii+bhZM+GlJqK4yp2CfCwHC58xsy+yzvckUY6ma8+5wouFyiWBUeNdCOnWaLW1/sdfAdVbMJeAU9eK5dKXnHohYmK+hr9E/5VMZKX9t99+HI391KTrSphuGEW6/6y7DYHQPHEnRQH6pXdPn4+ZMm2W0hpes//8d+xomI6OukXEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999700; c=relaxed/simple;
	bh=HZDV9B9whj7jMOnAALU0NHlqzHm0TKcc03SszyoLCcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoIdBy1bDKVv0+Ip/XHh2cOyMMB2fbFMX8ys8spsIWWX4CMpUAkL1Q1eAl6Vv0/Jz0pSoNAyJdbRwnOweXnY9Itcp5zkFeODrhrG0OdrilWZUPh7H/LsuBaU3Vn9QQlmPzJQY1Z6iqDuT2rY+q6wZqOcRhL+/LulW/gq02gl3Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yx4QlEDO; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yx4QlEDO"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50e61648f10so8261cf.1
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 09:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777999698; x=1778604498; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vp5iopfAmcsOX6ZIRTEf038gXmebvITcztxNgxO/nOk=;
        b=Yx4QlEDOkAmRHBe8cgrTxL1mMtXO7obwwUAFV80aMryELdNcdyXLLgzeZaT6zQhdGR
         Ea3Q81iVRTGqWZSBYyVpcquOI7EANzAlZXhGjDPT/5y/6WqArXTTfc2BeZl36YiNnjfn
         w00Lk4ZDkmq2V9LNA5fYQpnYoU047MNbpp9JQdbDkZx8Aa188184v99iUNiJUF81dYBo
         9jGbVqsflp4Sa3t6PebWhSwnib78A5VEukgct5LhyPvhk8fZ7+AArt2cOROhqgMPF9X1
         Gx7OYrj561mwD3Fbhk83N4RRc6SEBUt6WBJpQSCsmL/8t6twdOFZAZs8PW5QBnsed6iE
         NZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777999698; x=1778604498;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vp5iopfAmcsOX6ZIRTEf038gXmebvITcztxNgxO/nOk=;
        b=dPG2E7+majNNHf4BwbnaBGQsrquhIDzLxBBOfhwgkqXerz6rkGEj89hCuzgj7MGWos
         xMZCSJcu6wt2X07qqb3SDSQ0914+qp2CWvD7PxMxGVSeRwazF1MFPTO2mSTd9PVf07tA
         oqaE1OicJRRMv39HN4qMx8fz7G7Ss95NcJrCM4578iJz7HTbeWaaRWezOfV2C1AQhlqC
         BPwOlpu8LHpZoPUWmbprWvlqlp35lnSymb2Vdbdx/7K4Nx9T/d2NGQbXPiREZWyf1uvR
         J8BybdqrSbhh5eLxSeY8s1tcXArf60Xxu6rOhJ/LdeOcmd7R3c/6WvVApsfu2d7y2p+a
         l2dA==
X-Forwarded-Encrypted: i=1; AFNElJ8Z8kCwHBegYxzIdAEenmhptE6OkSLkC9FDqqFWUeFW//r0jU7nnkdbCkWx4TcZGOduSt0yow==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7FR5u8gzAXn6yljLOIV8MmQt9RPwy9lTxqcjQN7dCQ/NkZUpb
	b9nJbRt1hpVYRt3v37MEVwBquuQMwh7Zvqs9kgf1jg3zR1O5yndcBEwfiImxNYIocg==
X-Gm-Gg: AeBDietmpuObjHtjBRq4eeZI9tCsdBUwdAo89egg0KgsHMQEHUNg+mZOXJJxuxi9GLq
	LXnQ+LtMimR/BYc9HBMuEJqodgHcSfpkZdoeHXH3XSjH5UnSi6gC9gAnQ5mYOkczDjZkVRhqZQx
	eLDMVqhBj2qfRpFWVXenFjbVUGV+0VUDVvjjIC4Ba+5bD0kAiSdcQQYJ6PsSldYKWKLoWnyJNLM
	Vh+IWbCJGaHTgHz4fG88FvuH1eULyk5ipja9IknJ3DC0p0xJ9fQJxLwnMviojCk5Cf9y3LGo20x
	B2KZsFQM5QDmQyrfim5WMPAcgXw1AdCTlRUcwt/6weyL1xi/4rCQYu6GAPjEuEtDbRYUJ4zBz96
	gZBJLf5U+cmoRGQbLKCr4Q67l8Vjp1Hj2/vxUawsVJrCJvL0zD0ZU3JtYm0fuWL26eSZIMMXnH9
	f6qkvs0OqKkkbDXcGZl0rviIGpHLD2AnbkasPykYhPD8KOdbSnOvgp1pdvzzBEFhFUtA8OqCSRq
	q+SNQ==
X-Received: by 2002:a05:622a:8310:b0:509:15b6:f6a0 with SMTP id d75a77b69052e-51305908cf9mr15393051cf.6.1777999697103;
        Tue, 05 May 2026 09:48:17 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc29c6fa7asm1340531885a.20.2026.05.05.09.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 09:48:16 -0700 (PDT)
Date: Tue, 5 May 2026 16:48:08 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 05/25] iommu/arm-smmu-v3: Move IDR parsing to common
 functions
Message-ID: <afofSPQbepd_fpom@google.com>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-6-smostafa@google.com>
 <20260501124716.GD6912@ziepe.ca>
 <afiODW2sVMeOj3Ag@google.com>
 <afoagb/wVBJD1IX+@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afoagb/wVBJD1IX+@ziepe.ca>

On Tue, May 05, 2026 at 01:27:45PM -0300, Jason Gunthorpe wrote:
> On Mon, May 04, 2026 at 12:16:13PM +0000, Mostafa Saleh wrote:
> > On Fri, May 01, 2026 at 09:47:16AM -0300, Jason Gunthorpe wrote:
> > > On Fri, May 01, 2026 at 11:19:07AM +0000, Mostafa Saleh wrote:
> > > > Move parsing of IDRs to functions so that it can be re-used
> > > > +unsigned long smmu_idr5_to_pgsize(u32 reg)
> > > > +{
> > > > +	unsigned long pgsize_bitmap = 0;
> > > > +
> > > > +	if (reg & IDR5_GRAN64K)
> > > > +		pgsize_bitmap |= SZ_64K | SZ_512M;
> > > > +	if (reg & IDR5_GRAN16K)
> > > > +		pgsize_bitmap |= SZ_16K | SZ_32M;
> > > > +	if (reg & IDR5_GRAN4K)
> > > > +		pgsize_bitmap |= SZ_4K | SZ_2M | SZ_1G;
> > > > +	return pgsize_bitmap;
> > > > +}
> > > 
> > > I think this should include:
> > > 
> > > > +	smmu->oas = smmu_idr5_to_oas(reg);
> > > > +	if (smmu->oas == 52)
> > > >  		smmu->pgsize_bitmap |= 1ULL << 42; /* 4TB */
> > > > -		break;
> > > 
> > > ie it should return the supported page sizes by inspecting all the
> > > idrs and don't leave this tricky bit to be open coded..
> > 
> > This way was easier as each function only returns one thing, otherwise
> > we have to pass stuff by address as we can’t pass the smmu struct as it
> > is not shared between the drivers.
> > But no strong opinion, I can change that.
> 
> Could you share the struct? With multi-compilation you do get two
> structs with the same name and different layout, it is OK?
> 
> That would give a cleaner setup too because you can just shove all
> this into a function and have it setup the same struct which is more a
> copy and paste than break up into little functions?

Yes, that’s possible, but I didn't want to contaminate the main struct,
also we can’t compile the main one for KVM because of things such as
“struct device, struct mutex...”
May we can do:
- struct arm_smmu_device_common: Basic stuff (ioaddress, features,
  oas...)
- arm_smmu_device: For the main driver which inherits arm_smmu_device_common
- arm_smmu_nested_device for KVM which also inherits arm_smmu_device_common


What do you think?

Thanks,
Mostafa
> 
> Jason
