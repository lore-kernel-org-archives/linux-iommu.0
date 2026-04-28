Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5608843CED7
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380542; cv=none; b=tfDC7S/x5Dtefg2t3F+TzOs2BPNPmhuStHKD5znm8evJJMlTqXCwA/lWmeFwYow9GTjXARgczztV33yTUTUfJhkAxBfEbClQybRSb59JN+7Wrv9vcJNMKh8Xw607dmUGURf6EVlLDi4bbmufsHwhuv1agHCX83IPBBdc/khzVsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380542; c=relaxed/simple;
	bh=6uQsReytJShRtVwFuY+KaKU4UtffiV2XCyp37o5sVFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZ3J2NUeCh3FWGwJ6FzwutJj4118aa/nXcu16cyzIIrN6fPZffaVqr02JMd9oaaRNzvv3Qys86WC9nwE3GxfBeDY+1sZN2yBJqkYHJnFkb+JkaWa016E61ifW3ziWD5Otv2P+/VQdi8aIzqJRPOMZ8RatzLnoRtiMZsOf5T1IUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pWBIMobc; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pWBIMobc"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8ec37d52c0dso1174436185a.0
        for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 05:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777380538; x=1777985338; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rZDznJLnR5IBM+qy2CmcyjeNtRZUzmIeFEkRhR7jVHY=;
        b=pWBIMobcygQ/OY97AHCqCFJNXr1kr8jYlS/poyw2lb4+7v9k9th0w6V/l4ZtxDjEc6
         bBq5HVEUc55E5zk6C0miBL5Ljkfwr/Mul+VOvElE5/rGyozVpbQa/2JemOJUti94zvXt
         VA4Wgl/Xm1NwFaHUqvsKWvFA60cWPhAGrnJ0vI163PxmegDUKbfJNl/0D9FgFdrKNcYk
         Tr+aQS7DD+w2lhSw/9Mh7ylNJp5RAogg9/+eojg0BnbTaB39P6MPQz4GMM0Ccvxywn3U
         GcWSKCOBNF4F3vQDjxQSRycvADgyWGVa7MwlGo73bZsQb1jOU0EuyDy/7HqwtzXouyaw
         2MLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777380538; x=1777985338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZDznJLnR5IBM+qy2CmcyjeNtRZUzmIeFEkRhR7jVHY=;
        b=ruxkD5YSb1+K48k+vf9f18id+nFapHYcF60RxImgP0HuDF6UOgSXLT2wZkCb97H0jD
         URqHTtIi9te+cfQCuwYpF1moFqfnThyuxG3yb4KJsioF/jRp3D0Gt8CYtDP+xvpnkfrU
         hFBRcvh9/7+XndwjZVSX+YNgQwOxPgdwzq7f4QK3T6A5KSB0xKUN9T7sW9+AAgqa0xH5
         +nvCGnStKUKnClYSdAW9K+lgCQsNX3iIsA2I90SVsvDEoPK3vJEZhF2XhuiKxFQqD7yT
         UV2PPB+5eR3G98UJyEilbICJj9TmUraCo8s88/dNJxmszlKbJPhB1tTc7Y8ftt2MH0LW
         Q6oQ==
X-Gm-Message-State: AOJu0Yxxvv7H9uA+8823sqeUw+Z7dnHtTs3PNZeBj3v7YskilN8JeYa2
	NfI+d0Hn4GmAB4mQXitS52y2Xm6udoBCfbI2DsbR9EQ5PkWP7pC0DjHQiumVnmQiGMk=
X-Gm-Gg: AeBDietReS3tMLXjBn/XYbmDmEX8O1cadQ3ZsgmEsXYck0vtHqr9acZECSYUkQ+inth
	IJpoJQFXVKBy/Zt5srKJ8wqYDzmDnvof5m0sXrPdg8AMTvPu1CIyW3eJdL4I340sWTgY3Y/SfIo
	0G3STI75qDU6fO4xtA5zJ8aEmR2eRFtDrRZSmzSVxHolHhzDgm85kEwJxkFa4x2auSiqE1bZxyX
	6Objc5z8jT9+LCmOPDK/DrzBUjDhn5An5zvxnK+IBsLY1+ACYjNJtAYEobC3bAj84/tPCRaw6R1
	MEU4+Yko9gWjchh54VGzIQtc7X7wRNDdJ2/rNeFwSZMDAkmGy2RqGCBUi2BcdjUguVIR3+WNU3x
	KGWE9OJM9pi9kam0IcDZ62LjTW2xZvv+zyfMvivUUdVXFCprukKWndmLsjtk3ldSh0r0sPlAqJU
	quQsAy+1DgH+FFuEU5LmNlJcVUY5iHqhDiB5m4THHTWcM7of0QwppXMiUWW8MHaF0vVbpq9MObm
	jxebLHPI0HbiIzp
X-Received: by 2002:a05:620a:1a29:b0:8ed:2b66:9ec3 with SMTP id af79cd13be357-8f7d72475c8mr387065185a.16.1777380537766;
        Tue, 28 Apr 2026 05:48:57 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c7cd2c0dsm183064985a.26.2026.04.28.05.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 05:48:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHhry-0000000AVug-1I54;
	Tue, 28 Apr 2026 09:48:54 -0300
Date: Tue, 28 Apr 2026 09:48:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v4 4/4] iommufd/vdevice: add TSM guest request ioctl
Message-ID: <20260428124854.GA849557@ziepe.ca>
References: <20260427061005.901854-1-aneesh.kumar@kernel.org>
 <20260427061005.901854-5-aneesh.kumar@kernel.org>
 <20260427140539.GE740385@ziepe.ca>
 <yq5acxzj1dwu.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5acxzj1dwu.fsf@kernel.org>

On Tue, Apr 28, 2026 at 05:43:05PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Mon, Apr 27, 2026 at 11:40:05AM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> +/**
> >> + * struct iommu_vdevice_tsm_guest_request - ioctl(IOMMU_VDEVICE_TSM_GUEST_REQUEST)
> >> + * @size: sizeof(struct iommu_vdevice_tsm_guest_request)
> >> + * @vdevice_id: vDevice ID the guest request is for
> >> + * @scope: Bus-specific scope classification for the guest request
> >> + * @req_len: Size in bytes of the input payload at @req_uptr
> >> + * @resp_len: Size in bytes of the output buffer at @resp_uptr
> >> + * @__reserved: Must be 0
> >> + * @req_uptr: Userspace pointer to the guest-provided request payload
> >> + * @resp_uptr: Userspace pointer to the guest response buffer
> >> + *
> >> + * Forward a guest request to the TSM bound vDevice. This is intended for
> >> + * guest TSM/TDISP message transport where the host kernel only marshals
> >> + * bytes between userspace and the TSM implementation.
> >> + *
> >> + * The meaning and valid values of @scope are defined by the TSM backend for
> >> + * the device bus type.
> >
> > If you want to do this then you have to also provide a way to discover
> > what the TSM backend is so userspace can form the correct numbers.
> >
> 
> These guest-driven requests end up in the correct VMM backend, which
> should already be aware of the scope value to use. In the case of ARM
> CCA, the RHI calls include a device ID (vdev_id), which the VMM can use
> to determine the appropriate scope value.

That seems kind of indirect, we technically support multiple TSMs in
the kernel, how does it all get reconciled?

Passing overlapping numbers here without any way to tell them apart is
not a good uapi design.

Jason
