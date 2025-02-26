Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B8B258CD1
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574711; cv=none; b=FzGyQ/soB6aQ8QruRIBkHEUlcTpqSDP8TlkANitI7IFRmDVmMcg3szpGe90axnkiXfU6H3BDTKZogS7QSmxajxbf2OCaTqzCIgS8IQDPBslbrktpmC+ciQygvC5Kv3hoXxCh3k6H/aLZvG0tbcU9hgImatNqau2pp5ql7hyxDLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574711; c=relaxed/simple;
	bh=GHkOOUwBgKvlRX8cnP/xmtvgNBEsxAGHQdUOMxEvwfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsnZ745pqie4ORxnFaOiSy7/a2DHxAOyjosZ966lZA+Fm8Ifuto6UfRIeXHhXk12gts0cfbKXhZfDD+RwnXlk/jZoAvgh08YwqQWcGBmdmVnExHyvSDlZKkH2P6JF9ZhUj2WQ5Z6Cbnt4J7uBD6sv2hev13FoGKEQvPo94rrt24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JBrvYSbt; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JBrvYSbt"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c0a1677aebso612204585a.0
        for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 04:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740574708; x=1741179508; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ebgSjMdNuO5SJT8PtvFYTNz88NoQMc8Rf0MgoywjYjY=;
        b=JBrvYSbtOcnWM96Y7inTeBaWaSpTCssQhfsaXeu5hw1JluQ1BZ368iUgnXL1qvbofo
         i9ah+NMOW3ZO0JDcD9WifFXy98ler0tpmsT8ti5+qCBBJxN/lt05KysnoIc+OrEH91hZ
         g8ADeiVFHEflOyjNCIYJ8uRWmyqaOI+mc/AFXVDuNqKWQtt+9m0cj9KKb6e/VwYDQRvE
         rzgHVW3ynIqP8INsV2VBEmL98KzLunK5AdCEDMPscZ9mFpuIZS1arKbtIR7s6y9nAN/B
         9Lpux3R9E97CuA/PWyVWWzfvnLQc9L9ZRfo3js3EagUskJA7eNqbdEi226R1+SJQCTAv
         Swng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740574708; x=1741179508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebgSjMdNuO5SJT8PtvFYTNz88NoQMc8Rf0MgoywjYjY=;
        b=iqQf22WUHHTHx5scVO9gszb/mTnvL4VGhHYNrwJFzN5G3CP8rm6QcWIjHof0Drc35D
         gN9IbYQ4/LmhzUay3vumUWEceRN2s3UCe2mMTzx6qXIZaivDEP6eyR9JlePl+oCeEda8
         CyGoVAjFMpaI9fAlL8gAZz64cjxwgn7vntmKlbv6cHM9ux+Oh18y/0Csa+Gc/vbY+fuc
         Rm0QB4GKKe0j530psvnrDVf9KEOORJfhVyBFnV2DHsTRCrPE4kbiUZc949aQe4ok2QO1
         v4v5zWXyb8/Vi+S2Z3P2r0M9QvPOXnE2GaJ0K+hiP7dF2Dqw2z1InbKDiK7m2tEXn3Zl
         FtIA==
X-Forwarded-Encrypted: i=1; AJvYcCWq/7qu1Bsjhi7deLzEIpdS2iMsXwlRNfncxTt+nV/xrEjM7DX9AIIGD4Pn9T4VZsvS3Lo2Lw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6QrvoZ3mJ9lCzNccNjw29SYqP88+4muFhcM670SkQEoYwP8kM
	iMVD5wJYnaRfaUEkz27+GjMZAWK4s/9kC7zKhY+LEgKAD+xNMq112e7TthFOmUs=
X-Gm-Gg: ASbGncsgdm8Hit0m/LmRIezsCmXspMRlHUhR0Pt607MaGj/+4CABfqCsWeSnRvxavkN
	hCZmlaD8Qe37tCGu/d9iDHBr0j+AJz62iNh38kuA9UdL1Ho+kEW7RpqxnPZt9udSV6iiT/Z40d1
	R/MFtECB/bPT2HT94oXzWBEE0M8tsaE1SqL9TgZC+D4frd27x6Bg9Mvw7jaOVeBLETAqBqWWuvP
	gCAn3PcdciXW4ZUaVht1fA5J7jbiRhPIpf0vRLjI6ZTFVGuslG7mCFb/+1xicl9Uxj/DguJddnX
	XoEZuaTiLRcIEMKxXVybu/AMvWsZFSqDRzZ8OPmrh3jXzsARcjWhr+VU0wWDfksdu3DgWq9EblM
	=
X-Google-Smtp-Source: AGHT+IGrg8acDr41m7WytDFwUFYiiPcoTPoOr7QAtzOcdoaXCpi5CYhpf/4+E6m1CwiS4lcjtHCXgA==
X-Received: by 2002:a05:620a:270b:b0:7c0:bb63:5377 with SMTP id af79cd13be357-7c0cf953f06mr2705312285a.39.1740574708319;
        Wed, 26 Feb 2025 04:58:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c2a6b59sm237415585a.45.2025.02.26.04.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 04:58:27 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tnGzb-000000007FB-1V5z;
	Wed, 26 Feb 2025 08:58:27 -0400
Date: Wed, 26 Feb 2025 08:58:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
Message-ID: <20250226125827.GD5011@ziepe.ca>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250226011750.GB5011@ziepe.ca>
 <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>

On Wed, Feb 26, 2025 at 07:05:06AM +0000, Tian, Kevin wrote:
> > Not exactly. They are functionally different but serving the same purpose
> > to the user. From user p.o.v. it's sufficient to have a general flag for sats
> > when allocating a domain. The underlying driver decides whether such
> > flag is supported based on the domain type and the associated device,
> > just like checks on other existing flags.
> 
> Chatted with Yi offline. Having untrusted user control a security 
> feature doesn't make much sense. Probably what we really require
> is:

So you don't want iommufd users to be able to opt out of it? That
makes sense to me

Jason
