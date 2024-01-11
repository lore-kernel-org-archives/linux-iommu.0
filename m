Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048BD4F20F
	for <iommu@lists.linux.dev>; Thu, 11 Jan 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="B/JRuB8W"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bd4f062aa2so529071b6e.1
        for <iommu@lists.linux.dev>; Thu, 11 Jan 2024 07:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1704988610; x=1705593410; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XzlSQgi5aMFQ6ZZbKcTjiWRQSktCc9jeFnSRbXOKzuI=;
        b=B/JRuB8WPWzHVPEX5+QZ+ETZl8Xea57+hPkWkRMRjbNO7oy0QM4fMNJX2OhljgxQPg
         Ijdpua5PcR417IOaZsK0bdad3LZtdwqcqAGElRSRKJHUApEbKdJN+zvJceYFCVoCpflr
         aBxGPdHvvz/F1+r6mFNrCIExtYVW5sMPWC6xfMftGW0e7EA01Fc9TatjKUIqun6UjZ9N
         KmgzUGAsPwMtGHRaJxMPoJ9AiJpfnUHd0wn3CDIt2BzQkAvjstteaqDhN4sBVwyi2/Ei
         iM0q0Z3fjOYH8Da+6X+Dk5w1cuWKjKnWKAA1yYVy1V3GkLwoDEX9KiYeZHNX1XLUugKX
         UM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704988610; x=1705593410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzlSQgi5aMFQ6ZZbKcTjiWRQSktCc9jeFnSRbXOKzuI=;
        b=mFK9V8XzJ6Qs8EKYf0kl00XK2u4Tmn+Oi9QoyGe7gHYVM2vaTrGcluA9FWZ5HlJjmn
         lJ70jzAFiacXc4rtvitcY59HRdQBLo5D7+ClhkwB/D6Jz9LiPQI+x2RAxyVts+xx3X3l
         Fs9iOgFo7K4Oer2kp/5TmxBzGFnjY6FIXIPo5XUim1bumUilyjhcZv3aoFwtJtS4O3yE
         GFgNnp6YTT8s/YAOupPODZovtx3lfpkVGjs+dv0zkE3WiVo+K0o5h3rl6y0sKBVun8uj
         2XcSjANMExOj9WXDeZ/l3a25PL9og63XH8Xu41iuejRns4vucL47USnBSe7XJPLZfHUg
         twJw==
X-Gm-Message-State: AOJu0YxkQVzOm7YbHQiPcbrQDbLj/rL8zUEdD0GTwVfh9/flye1j3W2A
	XOYjL0k3fw2yCzEyKzNYlyklSr6wJCdt/AzNAn/yYNVqhPNADw==
X-Google-Smtp-Source: AGHT+IHYynUbRhLmuQVEz/Gn2c2nYnwGP0p6jJC5WKr54BT87sr0IvlKfK2tBXuiCnWCfqjPiMAcuQ==
X-Received: by 2002:a05:6808:2e9a:b0:3bd:4b9f:7f5a with SMTP id gt26-20020a0568082e9a00b003bd4b9f7f5amr6897oib.23.1704988609940;
        Thu, 11 Jan 2024 07:56:49 -0800 (PST)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id b14-20020aca220e000000b003bd4453e5d5sm204005oic.22.2024.01.11.07.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 07:56:49 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rNxQG-00326u-0o;
	Thu, 11 Jan 2024 11:56:48 -0400
Date: Thu, 11 Jan 2024 11:56:48 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommufd/selftest: Use right iommu_ops for mock device
Message-ID: <20240111155648.GX50608@ziepe.ca>
References: <20240111073213.180020-1-baolu.lu@linux.intel.com>
 <20240111144840.GW50608@ziepe.ca>
 <016e052e-8a99-4d60-b864-87c9859953f2@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <016e052e-8a99-4d60-b864-87c9859953f2@arm.com>

On Thu, Jan 11, 2024 at 03:50:51PM +0000, Robin Murphy wrote:
> On 11/01/2024 2:48 pm, Jason Gunthorpe wrote:
> > On Thu, Jan 11, 2024 at 03:32:13PM +0800, Lu Baolu wrote:
> > > In the iommu probe device path, __iommu_probe_device() gets the iommu_ops
> > > for the device from dev->iommu->fwspec if this field has been initialized
> > > before probing. Otherwise, it will lookup the global iommu device list
> > > and use the iommu_ops of the first iommu device which has no
> > > dev->iommu->fwspec. This causes the wrong iommu_ops to be used for the mock
> > > device on x86 platforms where dev->iommu->fwspec is not used.
> > > 
> > > Preallocate the fwspec for the mock device so that the right iommu ops can
> > > be used.
> > 
> > I really don't like this.
> > 
> > The lifecycle model for fwspec is already a bit confusing. Introducing
> > a new case where a driver pre-allocates the fwspec is making it worse,
> > not better.
> > 
> > eg iommu_init_device() error unwind will free this allocated fwspec
> > leaving the device broken. We don't have the concept of a fwspec that
> > is owned by the device, it is really owned by the probing code.
> 
> As I've tried to explain before, this is in fact the correct use of fwspec
> as originally designed, i.e. being set up by *bus code* before device_add()
> (remember this is not the "IOMMU driver" part of selftest.c).

I understand it was the intention, but it doesn't relaly match how the
code works today..

> Indeed for perfect symmetry the bus code would free the fwspec after the
> corresponding device_del() returns, but there's no harm in that being
> factored into iommu_release_device() since the notifier call occurs
> sufficiently late in device_del() itself as to make no practical difference.

IIRC there were issues with leaking the dev_iommu :(

> I'm working to get things back to that model (wherein the dev_iommu and
> fwspec lifecycles become trivial), just with the slight tweak that these
> days it's going to make more sense to have the initialisation factored into
> device_add() itself (via iommu_probe_device()), rather than beforehand.

I would prefer to simply remove fwspec as I've already shown patches
for. You should give some comment on them.

My main complaint is there is no full vision to remove the 'global
drivers', we will always have some drivers doing FW parsing in probe
and then this different fwspec thing on the side for other drivers.

Jason
