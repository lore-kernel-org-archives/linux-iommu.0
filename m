Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909259;
	b=eZgldeYS/82eJprsqHD6Vl5KDsiPABsVT3D9j2leeDnBkoKCInj5etwc5ndyO3Yvxrzr
	 viMg4lxtkL9rk28MtF0OaPJhV5iED/0+coUwV2pDmR9bW3AvLO/BY1T9eHYesqBKeDckc
	 kcdeetMWXtd+R1TnmxfyafQrUWDbej/RYzGqxj8JjwUBpeqH2ukECHlBAvZc+BNwaDPVJ
	 Uwh0FisrDkiSnLpUzuFERdyqZKxEHmvBJY20EwlmLVyeS0ss4un9GbRjUZlLxivp3/amu
	 wirh7glix3+IMRQEb0SOH+hI7zsuJGJVJX0PbRft4swRFGsYYWwALxbRedkUftPEEtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909259;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=z52AWMMx/NPlxXG7BPdw5LHgxa12llcgL1Kha+Q5UfY=;
	b=hQu1WJUI7d3UWfan9hauXj/s4IF+j/pB2Cz2XcfhXq0Mya3sDnYoJ8KGkWQgESzDooSb
	 jw1q2Bt5hWddgNVgHz0hbQNYcfOt8HOv8QD/DEkxV5S4iQdrhUqM9zdvdU+a7Bzu4dUgD
	 9RFIPXrCN2L8Mh6LjdsphvIBAjwUUHdrvXwWP+eMewvtflK+Eg+DTlY0gYCUsuQ9koJnj
	 xGY8UfCi1rQ0cH0M+UT2OIULIziPnUPDqw4WRlM/mFuXo4x931V19KGL6dMomHCvMbJ0p
	 tcmIQotqYlC6UAp8lDsklGoBxPimeiEFlO0BWdKpm1kD7uW9n60o7Rm7PccGJ+ovgwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=SAR9OnkU;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77066082BCD
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 20:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B77066082BCD
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=SAR9OnkU
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5e9528732b4so1906793e0c.0
        for <iommu@lists.linux.dev>; Thu, 05 Nov 2026 12:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793909257; x=1794514057; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z52AWMMx/NPlxXG7BPdw5LHgxa12llcgL1Kha+Q5UfY=;
        b=SAR9OnkUfh8Bk57D1h9VhG+n+xp6rS+jFsjk46kHoRXHVLX9haAbLHq+wxnKVLEXEe
         w9ew4dTvVCWZAVaNkBSvF+kc4KemD2YCY7zR3oIavVuYN8HZ1lSFKYLaYYuoaNHWCnwm
         cDm+xoDMw0z5CiBEM2d4yQlvVeVKvnxAYh2AFFNMrM8X0oQDSkhFLd461s/fYfptyNB2
         cIOEZjwSH+nYssA2XUyFiEocrR+0i2JJi2RCdLYWTdYZjWEi+a9PK0TfDnoD5dXhB8IU
         FTpq575un/jRIEe8hDw4Y+yBtZxvaA5EZtmy78v9qP/a2PTPwEObDdnHE4w9CJyiYgE6
         xgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909257; x=1794514057;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z52AWMMx/NPlxXG7BPdw5LHgxa12llcgL1Kha+Q5UfY=;
        b=DyI6nGQdph/dDqznikSX6mSqX6f4bZuMBTShHyuTu1jsqS7ajPHAMeowIEZK+x7P4i
         0af6WJnum4NyEJMn6RYdZ19COsEj8KGZ0+w5WzpAKVLuCjTngpa2OOtmAZDDAhJDdZ9+
         wia2qxyfMaESD6WbP1Yc6Yc43srZzaVl4wTV7BJ3C10rpzVwBISW5gShgotO9YHAEYFA
         m6tM9kT28gxKBYnfeVpvLMYNpnE8yWUUPZA3hgo23UcmVMAyIKpEuNXSP8LzxcSbLbBs
         dLOt3KBZm1RwBmYi7HZL7uyOkXsay50Cr+0qX5oLeat4hq3s/FbPX7oD2HtoKuajkI8C
         3Q/w==
X-Forwarded-Encrypted: i=1; AKwUvBx3NHlAmNWGOCL6SA/Cl/DuvfLCZZKdHL8QhXWDW5hadp3PZdReH7PDfeNMQczN5CUtJWEO4w==@lists.linux.dev
X-Gm-Message-State: APuU4Z+nvnvRQAOAkAJZFx0fBkz7QaxPyFfs+nVk3KY8ViiR/iUvsF93
	bvyCKy9uuf9I/R+AF5v6Lkc7cH4owGW3NcZzc3mk+5VjYSg+J6lplNp8Gow3xSoYYPo=
X-Gm-Gg: AYBFou0R64X0JwtNYG7FqRg/FLILqjqmUGmIh50akpvf2CL3/CDv7EzIodKw5ry1neF
	azM5ndQm4lXxSsWOSiso9LNg0/+LwElXVw1RIJOw8X5EeEGvtLnT5f+ri2mWL6yFoLDuI1CG+Vu
	raChRIvM8hRTwg+C20eKS+E3OI/6elakZkBL6wxv1oPyE0mim6cEEEUgKmXtnAwvoXv9/uv9OQo
	VbQNNqXc8s0kY1K1F1XbX1dME2RRndHEOmyelENwUOXAdKpIGzG9RkfBatrpKeRCfvLYsf+KsVr
	JC3WWw2bd6xaJNrFEPPeb253Y+l98wQ8Ovz0OTzHl0o4LiBBv9yCDHMV8zMJF+0G/7uztLxswa5
	Lq2aeSW9g8+mzFQhPCrPQZ6faCHYME3o9iv8FryYEaF5++gPhTH/rvEK8sTLLvPmo7pPEFriRPX
	qjXHq9Cib8UnbPtrW+z+8QN5q6Ol/khlVVsGWeEbOjJz+fciF/PQFuuwPduultfG+U6u0yn71tO
	hQlLRuPp+FdstT3rsrxusx12O/ozz6CEHMsjedtsSsQiTWJZuCIPPEX8Q5cbgWix/Sd8TFXp+2K
	yrBekGf63AAkIiCMzvCpCvnm1ERg5khJ50P/NIx3wfAK6AilLvOWWScS8zGs3e5S705JVVUyaYB
	+83j4IfTx7A==
X-Received: by 2002:a05:6102:390f:b0:7c3:99a3:314a with SMTP id ada2fe7eead31-7d2a1509e88mr658597137.9.1793909257584;
        Thu, 05 Nov 2026 12:07:37 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecb6d79d9fsm2610604e0c.7.2026.11.05.12.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:07:36 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xP3kF-00000003dYX-3Q5c;
	Thu, 05 Nov 2026 16:07:35 -0400
Date: Thu, 5 Nov 2026 16:07:35 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v8 13/15] iommufd/viommu: Allow vIOMMUs without a parent
 HWPT
Message-ID: <20261105200735.GF663069@ziepe.ca>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-14-aneesh.kumar@kernel.org>
 <auuBjRjQwXl7UvvO@nvidia.com>
 <20261104193139.GB3889730@ziepe.ca>
 <yq5afqxf97a1.fsf@kernel.org>
 <auzAivzpzSUHjEQj@nvidia.com>
 <20261105182106.GD663069@ziepe.ca>
 <auzNkAGFLH6da8fq@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auzNkAGFLH6da8fq@nvidia.com>

On Thu, Nov 05, 2026 at 10:40:16AM -0800, Nicolin Chen wrote:
> On Thu, Nov 05, 2026 at 02:21:06PM -0400, Jason Gunthorpe wrote:
> > On Thu, Nov 05, 2026 at 09:44:42AM -0800, Nicolin Chen wrote:
> > > On Thu, Nov 05, 2026 at 10:58:06AM +0530, Aneesh Kumar K.V wrote:
> > > > Jason Gunthorpe <jgg@ziepe.ca> writes:
> > > > > On Wed, Nov 04, 2026 at 11:03:41AM -0800, Nicolin Chen wrote:
> > > > >> By dropping the nesting parent from VIOMMU, it just simplifies the
> > > > >> attachment to an S1 paging hwpt, right?
> > > > >
> > > > > Yes.
> > > > >
> > > > > The VMM must always maintain a S1 paging attachment that is the
> > > > > identity map of the VM on all devices, same action as when there is no
> > > > > viommu.
> > > > >
> > > > 
> > > > I am currently creating an S2 paging attachment. This results in a
> > > > configuration with S1 disabled and S2 enabled, which is used by all
> > > > untrusted devices.
> > > 
> > > For validation, that would work. Yet "no viommu" should would be S1
> > > paging, i.e. hwpt allocated without IOMMU_HWPT_ALLOC_NEST_PARENT.
> > 
> > It doesn't matter, consistently using a single S2 for everything is
> > probably better..
> 
> Hmm, I am confused: if we use a nesting parent, why do we need to
> allow a viommu without a parent HWPT here?

It is because it doesn't *use* it. It is a confusing to pass in a hwpt
that is never used for anything.

Jason
