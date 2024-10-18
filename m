Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2479B15C3
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 11:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729252463; cv=none; b=Azyo5769mDw66n5Bd5u/d0gA499J/Ck7vC7RIVWmJdPl7HnOJaP6Ml1Vjv2c6VbiyjGi4/KNaIYNCikKLVaCXn09+xNPRRiuTEFsGrwVr4Ruwru0b6LckbA23mXa8xe/iskYHoYGK62VbjIySl6MAZ3TblN5OpnU7AtRbXmwNUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729252463; c=relaxed/simple;
	bh=hliJxPK1bqzsMF0FxwT83Yiq0voVwAmN62B4FELq0UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZK3HuenCNDXa2HYgwoQI959va1ai4IlD4uUZ0fZwmmtN7g01WPW8AXHKIhj6puW7ooJwYm1sKrJEjyiE6BwkpCZYEEKxpantpHuhR7o6Bw6hFcDWJE9Su0CuYVk5TnOG1AbHvRVzoZhNYsUbUfOR4KyBN2+ox5uthfG2Q+s6hVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WDv7L+Hv; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WDv7L+Hv"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-50d525be53eso610246e0c.0
        for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 04:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729252460; x=1729857260; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pTlXHawciHLTuS+UEPeWZlKrthH2IIqaAQj96Lzo6UI=;
        b=WDv7L+HvEUiH3YR8CsOUgR0pNmxEi9S9EvCKdaqI0JTN3mnM9fHXWdshnz0aM6v/70
         5ZWSSt7fMysxmKtcNmaHdge74xPtiEssMvGWpn/6IFFXmwWyL0n5ojT+g0o7xSx9zIBA
         fXWOG6GVfuit9tZiQwL4sdYjmP44HSRiEgwKFZZDi4CTyW/GIFTBxsKPmApND82NgirO
         Z9q4fnnZslrWKRMiiRw9YcNtz4ZTKn306veXNV1/kmerwV/jTsJdYvNXW4GzdOMpYHNJ
         AoX01GqW8ANjX6oRCssQV22Oa5efl5z1m5yjSASl01QDHNo4iTiv+4OZTJWbX/awlfpa
         0OBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729252460; x=1729857260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTlXHawciHLTuS+UEPeWZlKrthH2IIqaAQj96Lzo6UI=;
        b=QdSU9o3UVAKMK/vmkGBmlJ3kFUcLrHBXBY+55a4I4tpJOhUlv2nDUaBfqV9ewaNBxH
         XMbsmaBAz6sv4f/wwvRtDIXyrDQSMMeeoGHjE9YK1i9QbReN6AvjXlzfYx4daLUs4AGR
         DguDH6kmBSSegct1ftFuxMUJodiVeO3hjmXQydws2OHj6sxqkYXFKrHlGqBGmSABP8KJ
         E55XHTkFGVUt/P2vA6nOAueqUcmHWCRvMedr6ol9omPIQdt0ylsAUOzLA+NzK+viifW/
         yxseULmdDojOa1nGPXbwo1/5iqFkYTcXcO2tKMmkMEpfoAYx93aA79ijwI2uWZU35Naq
         mjnA==
X-Forwarded-Encrypted: i=1; AJvYcCXdnlyWT0z/SCKy7HvpX5tZC00WMN8A5tts3sYKQyB9gptYkrLdWhwaVypuo0N/flyaeB7xKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCk2Akt4w8cnO2rHR8W0pwqrlcQ/fG3Q9VYbTqiEbLmOsZdzx2
	7Y9AkHHXgOABvFU8glmN3p60RC2LGZRjiE5O+z7pcqmn6m31xdwmSncENokB+CE=
X-Google-Smtp-Source: AGHT+IGt+GMt4fRRcFO/EpbReoVAvWBaxycuXcm2o43soIRnUPEY37vOeSgQmFwCVDKCfasAUfAcpw==
X-Received: by 2002:a05:6122:4681:b0:50d:99e4:dea6 with SMTP id 71dfb90a1353d-50dda1ba083mr1974345e0c.7.1729252459836;
        Fri, 18 Oct 2024 04:54:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b156f8b2c0sm62486085a.10.2024.10.18.04.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 04:54:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1lYf-007XXi-J9;
	Fri, 18 Oct 2024 08:54:17 -0300
Date: Fri, 18 Oct 2024 08:54:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v3 06/10] iommu/amd: Reduce domain lock scope in attach
 device path
Message-ID: <20241018115417.GD948948@ziepe.ca>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
 <20241016053501.97497-7-vasant.hegde@amd.com>
 <20241017133244.GP4020792@ziepe.ca>
 <4b0f1d5d-778d-4161-92e4-8e2ad1c211e9@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b0f1d5d-778d-4161-92e4-8e2ad1c211e9@linux.intel.com>

On Fri, Oct 18, 2024 at 10:38:05AM +0800, Baolu Lu wrote:
> On 2024/10/17 21:32, Jason Gunthorpe wrote:
> > On Wed, Oct 16, 2024 at 05:34:57AM +0000, Vasant Hegde wrote:
> > > Currently attach device path takes protection domain lock followed by
> > > dev_data lock. Most of the operations in this function is specific to
> > > device data except pdom_attach_iommu() where it updates protection
> > > domain structure. Hence reduce the scope of protection domain lock.
> > > 
> > > Note that this changes the locking order. Now it takes device lock
> > > before taking domain lock (group->mutex -> dev_data->lock ->
> > > pdom->lock). dev_data->lock is used only in device attachment path.
> > > So changing order is fine. It will not create any issue.
> > > 
> > > Finally move numa node assignment to pdom_attach_iommu().
> > numa node assignment should only be done during domain
> > allocation. This is important because the domain can be mapped prior
> > to being attached and without the right nid table levels will be mis
> > allocated.
> 
> Sorry for off the topic, just a question about the domain numa ID.
> 
> When a domain is about to be attached to a device on a different numa
> node, what should the iommu driver do? Should it:
> 
> - Ignore the difference (probably log an informational message);

I would say silently ignore it..

The only case that probably does this is VFIO, and VFIO is probably
doing it deliberately to save memory.

> - Return -EINVAL to force the upper layer to allocate a different domain
>   for the device?

This seems extreme..

I think if qemu or something wants to optimize this we need to return
numa information in the get_infos to let it make the right decisions
about domain allocation without being forced into anything.

Jason
