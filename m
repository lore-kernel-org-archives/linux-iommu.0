Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF862405E1
	for <iommu@lists.linux.dev>; Wed,  7 Jan 2026 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767818771; cv=none; b=QKLguxoQEL4sRiTLQYFGwoc2wuqW2YxCgF/aAREO9R3bdofp95AEQtMcKnyAFL1WGaA0rXU1ZE9BEJnNjPxRiwXjtHF14iZD9q2YNaIJQlU+qLvuChDhV+wOCfN+uIhl9PM2WA4jmXfN3gvNA0hm+uPN0vBHFACpniv+f82CyDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767818771; c=relaxed/simple;
	bh=V1GVCS9K1Qf//sa902zfVHBVWTNmYA6vlf7ykEXvGGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WN/zQ02eet0xI4lGAdyqRidFcmJH8cm0Z6XiaLmZCG6BVCDoNZ+w2Woqa9YUx1OQ5EFL57C4Wfz5EjKnc3pPXBwvH+TZKNGvviEd4i6P8PPKIVJsOCBlRgdEEWShJOZx4ZXnV6Ncfq4cLokv1ej3FEB5XSvAJB2EH4XTLSPY4AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dFOiZGX8; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dFOiZGX8"
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-4f1b4bb40aaso13239071cf.3
        for <iommu@lists.linux.dev>; Wed, 07 Jan 2026 12:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767818768; x=1768423568; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DqLGiR8rj/edjA3ZmthNk/CuW8dhDUcDoy+Z3OjEZpY=;
        b=dFOiZGX83n0tNxgAG2V0UuZjLAZf1wXjKhuC1Va2L+lad2EZtX2BMyh3wsnOecLp52
         ztxpDyVDX1tdvjMjl5aA5dctzEeGFr8ZcbWP6wrndTshFbqkN4xLNQc+CUENhdEX25Eh
         nKAlzKXYn3RcNdHgjTwx/fPIvTm0OJpjZO5oNN+TSKKZL7zdlreaanZxZaal3RFUogko
         IcSqjwAZL2r4Yo1IMr15YOj3LGXSpFKubaTjQgOI9y3JlRjHmDh4javStl0gYvXXwF8I
         fby8usIrmL80S90wEpChpGKUX7h5EcaKjG6PTKAtFkBePIcCorIS8/kgXlSDk5f8T0ew
         redQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767818768; x=1768423568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqLGiR8rj/edjA3ZmthNk/CuW8dhDUcDoy+Z3OjEZpY=;
        b=bSBbW/q5LqLJ4E9nPmFt4hrH4hFMPKaBGcHN8eC6WFtb/Fv1KVWOu3LsHvxVQDOBT/
         5vK8z+NLwNUtOkQhMjODKVnW6ch3glnHWc3L5hHlgQXaXQ/1Yebx7iVMDehSPH6HP7Jw
         UEBu2gmhfUNBHsEVkhcpXx+a6EwSLxYcTcXns0vhpoNCoNYHTaygmg7K8k/prxaQ1jTp
         CVivK5N/dgtzAnN2YBWyjnQm4uV+ajWWu/CP4pbf2LQq2T0t4+vyMvcs9Fwc4K+v3VNz
         V3wYVGKgo7TMelEgMFrbe7Io8AUVKqi7ngDhl2IVRmpYrarP49V/T3/4wfRf3d06snNQ
         vvdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5UTtc/tOZewPyTHl4YRz60IZaXjJW0YW0gpkXOfalyYGWL4m/rKAR+57pKZ55N2CqkApUOw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyd2V31busLuJ3vtb2w7AAvA40pH9WfBH5/kTvkH0y2AAdIazQ3
	1D25O3LWtujWJSl4ExHgZjiFBC7+V6d1DdziQxDLUtFrg3MDew5V0rPluvYHeheMyOY=
X-Gm-Gg: AY/fxX7avTs8k1DCWNrQVCnRX+HbsfRR97Y6pVVPnrVlAtjoN8zzW7oV+Uzw2nabWVw
	byBHjvjGhQso0PsZarZHC22WuPYOaXNDcHqg0kTOm6iqxZb57t/awM+ijVnWclZ8XRMbDWFdSTI
	uUkKowzxYN8QeVwvkc3vaoWBQtPoh/lqw/pntI0B0hZzgwTxSoRN9ibFKj4ObNsqQeex1Uik2Km
	JqUKZiNnilnpo3Gxl71OPOdRuMjKPybdkCtKI9JX4F7xy8oiFL8Olgdd8ULDv5u6PvUfNep7l/9
	ZriJYJ5Ck+CzA2/cetA60kBS+xK66H10caJ2rwaxU8BZ6FL9/bzbLBbWefMFeoaZ9hRQg0a7lep
	j/nX7PqSnyTcHDrrtYzTtVWCLhCtwNFGTzmOz9dJ0XYT0VUHhzbNhLwRj9dLA0fZEi2oE1r01fP
	lHz8xURb4S0qRJSS1q4Jqmb3Y30ikkws30TyVPBqsbibOYq9o+Gx4/roxFxs7wpwElQbc=
X-Google-Smtp-Source: AGHT+IGDmyd7kjxIp/jIm0kXF9tq0fAn0CQ3sKUlFYdgvJub9VEiYkmE5sOV0MLJ1rA3hSKtj1n7+A==
X-Received: by 2002:a05:622a:155:b0:4f1:ba0b:90 with SMTP id d75a77b69052e-4ffb48bc30fmr42029251cf.8.1767818768314;
        Wed, 07 Jan 2026 12:46:08 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077234c96sm39240416d6.27.2026.01.07.12.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 12:46:07 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vdaPv-00000002FiH-0jqm;
	Wed, 07 Jan 2026 16:46:07 -0400
Date: Wed, 7 Jan 2026 16:46:07 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>
Subject: Re: [PATCH 0/3] iommu/vt-d: Add support to hitless replace IOMMU
 domain
Message-ID: <20260107204607.GE340082@ziepe.ca>
References: <20260107201800.2486137-1-skhawaja@google.com>
 <20260107202812.GD340082@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107202812.GD340082@ziepe.ca>

On Wed, Jan 07, 2026 at 04:28:12PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 07, 2026 at 08:17:57PM +0000, Samiullah Khawaja wrote:
> > Intel IOMMU Driver already supports replacing IOMMU domain hitlessly in
> > scalable mode.
> 
> It does? We were just talking about how it doesn't work because it
> makes the PASID entry non-present while loading the new domain.

If you tried your tests in scalable mode they are probably only
working because the HW is holding the entry in cache while the CPU is
completely mangling it:

int intel_pasid_replace_first_level(struct intel_iommu *iommu,
				    struct device *dev, phys_addr_t fsptptr,
				    u32 pasid, u16 did, u16 old_did,
				    int flags)
{
[..]
	*pte = new_pte;

That just doesn't work for "replace", it isn't hitless unless the
entry stays in the cache. Since your test effectively will hold the
context entry in the cache while testing for "hitless" it doesn't
really test if it is really working without races..

All of this needs to be reworked to always use the stack to build the
entry, like the replace path does, and have a ARM-like algorithm to
update the live memory in just the right order to guarentee the HW
does not see a corrupted entry.

It is a little bit tricky, but it should start with reworking
everything to consistently use the stack to create the new entry and
calling a centralized function to set the new entry to the live
memory. This replace/not replace split should be purged completely.

Some discussion is here

https://lore.kernel.org/all/20260106142301.GS125261@ziepe.ca/

It also needs to be very careful that the invalidation is doing both
the old and new context entry concurrently while it is being replaced.

For instance the placement of cache_tag_assign_domain() looks wrong to
me, it can't be *after* the HW has been programmed to use the new tags
:\

I also didn't note where the currently active cache_tag is removed
from the linked list during attach, is that another bug?

In short, this needs alot of work to actually properly implement
hitless replace the way ARM can. Fortunately I think it is mostly
mechanical and should be fairly straightfoward. Refer to the ARM
driver and try to structure vtd to have the same essential flow..

Jason
