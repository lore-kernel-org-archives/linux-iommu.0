Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959CF1B0405
	for <iommu@lists.linux.dev>; Wed, 29 Jan 2025 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738153270; cv=none; b=F/SzQJjjyWFqDcFuAVx7VrQlobUPMdz27gbi8V4u+LgmCTcWbNZlf6BqUS1+V47XeXVw5NBH3L8yfChrkSQrjqOspsCLJDVeFcJlKEjvpM3gw8BCymgOB85dlBLJ5n7XJwvMFZl7qU2yiIdyWZ89CvKmb14z+nq9F1WdVDEAfUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738153270; c=relaxed/simple;
	bh=QKmwrJRx+RfGnpGmuvvZZWIhDtvVs4L9ILhCtYO2GKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=em9xGHD0qYQlN1A2/Ch5dSlmQr1ZKTH2/h13yb+2L7ZmJUNkvGDPiDfYnNWBcCFTOQJSlt/5sW8ndHIQpEbHk/6hxGgwbovUNN6okc4YdjP8BCGZk9GYkPODLPwi5NwH/4aEx/dXIw1gTp2v//IsDd90aDGsQIsTE5aLbKJepDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tAUOMvSE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tAUOMvSE"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4368a290e0dso108915e9.1
        for <iommu@lists.linux.dev>; Wed, 29 Jan 2025 04:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738153267; x=1738758067; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AFFd9yC5/f0kHgmyC8Nq87cOj1SlBpm6jLMMJf6nWJo=;
        b=tAUOMvSEZq1DHYptrxMvAMoSgTKqo0F8eGhRa401M0gTd9P0AGZ7KjEJ3ltqXMML4u
         0ZsWMS8rrkosuZGL+SksTg+yrGYhc7wI09ObWlTM7xWSeLpfpsyfUofIbpauz+a+0bHF
         XduEg/q+52/mQTH3WER5F0Brh7YmEo/b7woJGmqSN99WuW/NILWK79zWnT/cbmReWCdT
         p7dxU0cTk4Dv6/5Aoj+N5a4Whl6xJxQrnaZHTdqiJU7iVXo0eY3d3EorXa2Kl2KhjoP2
         m56fYmhyXqRwYIFiynbWiiYzh/BPOzHnEXnGKzzc0r2q94fO+SjgyI8cqEuolql6qY3D
         2BGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738153267; x=1738758067;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AFFd9yC5/f0kHgmyC8Nq87cOj1SlBpm6jLMMJf6nWJo=;
        b=JotUTpNtQDMvs5oUvZPw4eGp5Lg4DpiTlrYzKs1h4QhlR4IIti6/WKBcps7Jt5oZqk
         opqbVC3VK0xjZs/mVPMsF13eGepXfSaPhAQDDcCoFeQlNshyQ6YJzCMikp/m+x+zoMsl
         EIrErRhh9EOC7nhHAvcBChh/qA2t/0L+yZRjrtGFdc2lwaYfa14j+GSqFIiK0YLR5VeG
         XLKqiVAOsv/Tro12t25Ps8lnDIzKC2D7aX3eKft+e4ID8s0qiIFY3jYY3+WKXxOwjD6m
         wCB3ijmfWhy1PJ8YJ8FopHUanyFIS1LsmRMf3Se4E9ezkPIgkkXtTuvFuiGCZ+x7Fhf3
         jcVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3ZPxcGUjotBixzNrocFegZl9W1gSiXTvfgHqCYDkEFmREqArBsZuegSfFDf2Og/4Jb025tg==@lists.linux.dev
X-Gm-Message-State: AOJu0YychrPs9KojnoMosH1SMh3HEDb7UIucUu9ZWS3bjynMThKWoGlK
	L+mloDD4c/7l/I5OxEIxBtro4IClfsn5BXdnTao1jQ9VZ4/0Vh8sqOIjfZURxA==
X-Gm-Gg: ASbGncvEcs4hS/HUKj6Kxi2fWnUYpxoG35Sm+qYajemVZ/zaeXvpoS+1j3UGGYhRhoW
	Rm+k/E2sl+yx3wnexJhPvUU5Bop9zovMXdJn34aIE1Mw6q8LUrvQQn8nZULUZRVFmyFPWsV7RlZ
	s07CB7QydzmDV5QZ5Aw+UZ9NTFXyPRK0v/mDm3d+iODDTk5Lh2x39edGTD48p0TbXrv3zWyOXoo
	KH5XBVCRX9MX+I7jzO4Hl3bb5M78j07rrwEDoaXEHBFcjOsWTk5zdsYP2V1eUtmLc1y/kumDHik
	tpO/dxVn9aOkmQw03o5/Dr8iiH6bAbjv3kKGQZN6oTECopPGkLs=
X-Google-Smtp-Source: AGHT+IGIQmgNk9mmmgAHeZGEIv+1UNTnqmCcNTg78X7B3IzWsxFEcV4Tw9QmlwIksmRNHaG+4MYD7A==
X-Received: by 2002:a05:600c:1f84:b0:42b:a961:e51 with SMTP id 5b1f17b1804b1-438dc21f186mr995805e9.0.1738153266027;
        Wed, 29 Jan 2025 04:21:06 -0800 (PST)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bb0d4sm17295245f8f.69.2025.01.29.04.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 04:21:05 -0800 (PST)
Date: Wed, 29 Jan 2025 12:21:01 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"maz@kernel.org" <maz@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"robdclark@gmail.com" <robdclark@gmail.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"vdonnefort@google.com" <vdonnefort@google.com>,
	"qperret@google.com" <qperret@google.com>,
	"tabba@google.com" <tabba@google.com>,
	"danielmentz@google.com" <danielmentz@google.com>,
	"tzukui@google.com" <tzukui@google.com>
Subject: Re: [RFC PATCH v2 00/58] KVM: Arm SMMUv3 driver for pKVM
Message-ID: <Z5odLXPZPAwu4oqe@google.com>
References: <20241212180423.1578358-1-smostafa@google.com>
 <20241212194119.GA4679@ziepe.ca>
 <Z1yNWI9lBNIZg6Le@google.com>
 <20250102201614.GA26854@ziepe.ca>
 <Z35rEeSVwfZVA9IF@google.com>
 <BN9PR11MB52760686ABB3145E44BAD95A8C1A2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Z5DWag7ZKCPl1Eje@google.com>
 <BN9PR11MB5276B783D518DB354BF58A3C8CE02@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB5276B783D518DB354BF58A3C8CE02@BN9PR11MB5276.namprd11.prod.outlook.com>

On Thu, Jan 23, 2025 at 08:25:13AM +0000, Tian, Kevin wrote:
> > From: Mostafa Saleh <smostafa@google.com>
> > Sent: Wednesday, January 22, 2025 7:29 PM
> > 
> > Hi Kevin,
> > 
> > On Thu, Jan 16, 2025 at 08:51:11AM +0000, Tian, Kevin wrote:
> > > > From: Mostafa Saleh <smostafa@google.com>
> > > > Sent: Wednesday, January 8, 2025 8:10 PM
> > > >
> > > > My plan was basically:
> > > > 1) Finish and send nested SMMUv3 as RFC, with more insights about
> > > >    performance and complexity trade-offs of both approaches.
> > > >
> > > > 2) Discuss next steps for the upstream solution in an upcoming
> > conference
> > > >    (like LPC or earlier if possible) and work on upstreaming it.
> > > >
> > > > 3) Work on guest device passthrough and IOMMU support.
> > > >
> > > > I am open to gradually upstream this as you mentioned where as a first
> > > > step pKVM would establish DMA isolation without translation for host,
> > > > that should be enough to have functional pKVM and run protected
> > > > workloads.
> > >
> > > Does that approach assume starting from a full-fledged SMMU driver
> > > inside pKVM or do we still expect the host to enumerate/initialize
> > > the hw (but skip any translation) so the pKVM part can focus only
> > > on managing translation?
> > 
> > I have been thinking about this, and I think most of the initialization
> > won’t be changed, and we would do any possible initialization in the
> > kernel avoiding complexity in the hypervisor (parsing
> > device-tree/acpi...) also that makes code re-use easier if both drivers
> > do that in the kernel space.
> 
> yeah that'd make sense for now. 
> 
> > 
> > >
> > > I'm curious about the burden of maintaining another IOMMU
> > > subsystem under the KVM directory. It's not built into the host kernel
> > > image, but hosted in the same kernel repo. This series tried to
> > > reduce the duplication via io-pgtable-arm but still considerable
> > > duplication exists (~2000LOC in pKVM). The would be very confusing
> > > moving forward and hard to maintain e.g. ensure bugs fixed in
> > > both sides.
> > 
> > KVM IOMMU subsystem is very different from the one kernel, it’s about
> > paravirtualtion and abstraction, I tried my best to make sure all
> > possible code can be re-used by splitting arm-smmu-v3-common.c and
> > io-pgtable-arm-common.c and even re-using iommu_iotlb_gather from the
> > iommu code.
> > So my guess, there won't be much of that effort as there is no
> > duplication in logic.
> 
> I'm not sure how different it is. In concept it still manages iommu
> mappings, just with additional restrictions. Bear me that I haven't
> looked into the detail of the 2000LOC driver in pKVM smmu driver. 
> but the size does scare me, especially considering the case when
> other vendors are supported later.
> 
> Let's keep it in mind and re-check after you have v3. It's simpler hence
> suppose the actual difference between a pKVM iommu driver and
> a normal kernel IOMMU driver can be judged more easily than now.

I see, I believe we can reduce the size by re-using more data-structure
types + more refactoring on the kernel side.

Also, we can make many parts of the code standard outside the driver as
calling hypercalls, dealing with memory allocation...., so. other IOMMUs
will only add minimal code.

> 
> The learning here would be beneficial to the design in other pKVM
> components, e.g. when porting pKVM to x86. Currently KVM x86 is 
> monothetic. Maintaining pKVM under KVM/x86 would be a much
> bigger challenge than doing it under KVM/arm. There will also be
> question about what can be shared and how to better maintain
> the pKVM specific logic in KVM/x86.
> 
> Overall my gut-feeling is that the pKVM specific code must be small
> enough otherwise maintaining a run-time irrelevant project in the
> kernel repo would be questionable. 😊
> 

I am not sure I understand, but I don’t see how pKVM is irrelevant,
it’s a mode in KVM (just like, nvhe/hvhe where they run in 2 exception
levels) and can’t be separated from the kernel as that defeats the
point of KVM, that means that all hypercalls have to be stable ABI,
same for the shared data, shared structs, types...

Thanks,
Mostafa
