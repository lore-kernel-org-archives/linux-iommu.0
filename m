Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9098528A1E8
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429284; cv=none; b=ahXfxSGr0Q/054/uhsJKXgyl3bR2vWoJnGypW58UuophQ0GUbEaCaqJZB1JOP7QVWgd/4gSEl/DePUNK1Mw5BzRsd8lgmScsLlsdoxqQff6D9KhA7l1Pacsc2mgDXDqtQP80WBt5XYBv2veKTDKrCfMeKkD2ji2cXQAiPWPr3To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429284; c=relaxed/simple;
	bh=To5+mXKVqJ4D8W9A86Idf9GAwp67sMMUFZetXoeXhNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukXWrriPvZSqPSEGVszpujnTIBjsg1ean5FY5lV4StauFvyVquhwwIJsp7qUZIgEViLkMM1bnZKNTiNii07Fs7SNdIUG0t9ANY8Pxno699VtnDPrvolXDlLwxueE5vIPPGoqP0800C7XWa0CfLB/Gf2f0DCo2Jr8dkgc9/ZAe3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gx2sO52d; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gx2sO52d"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22c33e5013aso1333285ad.0
        for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 10:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745429282; x=1746034082; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpN3s3qmY26UBKN47K4OXTIlbbWZaDEQfwBQfiV1DYQ=;
        b=Gx2sO52dWUZOsFVDaF+CYjuupw/9cZFfg4JzALJQxq8/92CHTc0VOrDbnokApVQiH1
         k95GZPMxErSYrv2rZsbQedbhOHQQ3CthV69AUPibC7TpOYNx0VDTkjdOXUbGED9AAv7A
         shfiCo56a6xy+sIJ5UwFUAbeFG1tsbV/c/9qRSpyerB0IWETRqKVSYviGVzwW7iY2J7o
         tDWdmkZzp7RhEVyZSHjVyTSdexdwk8SDW/+AdCMNg6tRFv/kT5tM2hCcruglujU0nHTs
         cSHzvzhAK21djOUyOWQ8mro21SYaoxJTsw+pm4ldhZ1THVs3QbRMjgdLAZLTFgKDa3fv
         YK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745429282; x=1746034082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpN3s3qmY26UBKN47K4OXTIlbbWZaDEQfwBQfiV1DYQ=;
        b=BPyN7aWzz+uADUP9FHhpUMe9/5nxxCDmPMyR4ksrHzz4kLADAH1TU7D4OxSA+edBUd
         I1Ms4Y1scwam2xJ0gEE5FysRhVjI9Sf9UWBO18ojPRVjbm9B4C/KtTwLXV6o+Q+BYzGk
         QTQcwv+7nIlp5M8vNMv+99WoJupmjNLIwHdVezFXa4F+7ZWmIk4Po5pie0kI05ERHBGU
         Qk0MBlYBHbu4ds2EAPm/bpDBcao+42VWYa+yxfrRpxk2CIshoJOSSwwDjnjQXB8xBzdo
         nE5HwV31MLXuhTwE1AOPOXNlqUVQKOs6tRuDPhzNJzRkN+Pp9anH9IsKa00q+JXuJfZV
         dN5g==
X-Forwarded-Encrypted: i=1; AJvYcCV8bt6S/wewWsePDAGHTqK3OGrocfFEdBSO4Czb7woUYpNlYqUYu9G1PQMWMRxBVocYA3sOZg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFw2fPyUQnja/u/KnGFzeLU9k6cc1UAev2t+N4R+RLYVlXmb+a
	EPQt57xSHXIKx/gMnDvoT2BSRiux8CpTrS+i6E3HR0udSdvT95Nlvt+33wJlWA==
X-Gm-Gg: ASbGncv8A/Ooi6O6oW1SmRheRrshqTBq+pOwXQMo3PiIuJkq4Ss4aijD+iJCkQnB+EX
	jUDqFMs7cAajmZgsA0G0abl81fBscHkJ+/UCVVP+KXKZRg82wJJBjt1ciQysLgPhLGLccZ8XwkP
	vFRYqS2PRJpsPwNtwwMpJBjaDiuaLKRmSZpeXPEzQd/p1inTzF9xHxs35v7KpDHfJJABPg5lUx3
	8W/N1saZeTe3FX5q5lMonEOPLfPnOqBAeioSnlEXDSaCjJJDWHlwewxSgvtpz2u6jGW1pYQgs0Q
	I3C7gnh5WsE6Eyb9TZyGip/uQQS6QvVgYsYZEi2T5IqUf6T762JSAFGCrNebZhjDhTHGs2Qg+ql
	rP7e8DQ==
X-Google-Smtp-Source: AGHT+IHa77CexBJ8kZ0MMVz4lBWN5XuYsJm19QW6W7Xn3LZrvzkSypYq7z6BTcnhDO0elSznGaYPdA==
X-Received: by 2002:a17:902:e5c5:b0:224:c7c:7146 with SMTP id d9443c01a7336-22c53573e54mr225103025ad.6.1745429281505;
        Wed, 23 Apr 2025 10:28:01 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eced45sm107077345ad.175.2025.04.23.10.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:28:00 -0700 (PDT)
Date: Wed, 23 Apr 2025 10:27:56 -0700
From: William McVicker <willmcvicker@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Joerg Roedel <jroedel@suse.de>, Bjorn Helgaas <bhelgaas@google.com>,
	iommu@lists.linux.dev, Saravana Kannan <saravanak@google.com>,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] platform: Fix race condition during DMA configure at
 IOMMU probe time
Message-ID: <aAkjHMCQ82v5Ea0n@google.com>
References: <20250423150823.GA422889@bhelgaas>
 <4129dca9-07fa-4b9d-a7d8-de7561d509e7@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4129dca9-07fa-4b9d-a7d8-de7561d509e7@arm.com>

On 04/23/2025, Robin Murphy wrote:
> On 2025-04-23 4:08 pm, Bjorn Helgaas wrote:
> > On Tue, Apr 22, 2025 at 04:26:49PM -0700, Will McVicker wrote:
> > > If devices are probed asynchronously, then there is a chance that during
> > > the IOMMU probe the driver is bound to the device in parallel. If this
> > > happens after getting the platform_driver pointer while in the function
> > > `platform_dma_configure()`, then the invalid `drv` pointer
> > > (drv==0xf...ffd8) will be de-referenced since `dev->driver != NULL`.
> > 
> > I need a little more hand-holding to make sense out of this.

Sorry for not making it super clear :/ I was trying to find the right balance
between being too verbose and not clear enough. I guess a threaded call flow
might help visually demonstrate the race condition.

> > 
> > After digging out
> > https://lore.kernel.org/all/aAa2Zx86yUfayPSG@google.com/, I see that
> > drv==0xf...ffd8 must be a result of applying to_platform_driver() to a
> > NULL pointer.  This patch still applies to_platform_driver(NULL), but
> > avoids using the result by testing drv for NULL later, which seems
> > prone to error.
> > 
> > I think this would all be clearer if we tested for the NULL pointer
> > explicitly before applying to_platform_driver().  I don't like setting
> > a pointer to an invalid value.  I think it's better if the pointer is
> > either valid or uninitialized because the compiler can help find uses
> > of uninitialized pointers.
> 
> Yeah, I was also in the middle of looking at this after managing to hit it
> playing with driver_async_probe at the end of last week. I guess when I
> originally wrote this pattern I was maybe thinking the compiler would defer
> the to_x_driver() computation to the point it's eventually dereferenced, but
> I suppose it can't since dev is passed to an external function in program
> order in between.

Glad to hear I'm not the only one hitting this. I agree we should test for the
NULL pointer first before trying to get the platform driver. I'll send a v2 for
this.

> 
> Indeed in my half-written version of this patch I was leaning towards
> removing the drv variable altogether (just doing
> to_x_driver(dev->driver)->driver_managed_dma inline), or at least doing the
> same as Will's previous diff. I figure the one-liner replacing
> "!dev->driver" with "!&drv->driver" would be too disgustingly non-obvious
> for anyone else's tastes...
> 
> For consistency we should really fix all the buses the same way - sorry for
> the bother (I can write up the other patches if you'd like). FWIW this part

Yes please. Thanks!

> really was the most temporary stopgap, as my planned next step is to propose
> moving driver_managed_dma and the use_default_domain() call up into the
> driver core and so removing all this bus-level code anyway, hence trying to
> minimise the effort spent churning it. Oh well.
> 
> > > To avoid a kernel panic and eliminate the race condition, we should
> > > guard the usage of `dev->driver` by only reading it once at the
> > > beginning of the function.
> > > 
> > > Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
> > > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > > ---
> > >   drivers/base/platform.c | 7 ++++---
> > >   1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > > index 1813cfd0c4bd..b948c6e8e939 100644
> > > --- a/drivers/base/platform.c
> > > +++ b/drivers/base/platform.c
> > > @@ -1440,7 +1440,8 @@ static void platform_shutdown(struct device *_dev)
> > >   static int platform_dma_configure(struct device *dev)
> > >   {
> > > -	struct platform_driver *drv = to_platform_driver(dev->driver);
> > > +	struct device_driver *drv = READ_ONCE(dev->driver);
> 
> Beware this might annoy a different set of people as it's not paired with a
> WRITE_ONCE(), but for now I guess using it is still arguably better than
> not. Really we should be under device_lock at this point and so have no race
> at all, but we can't do that without keeping track of which devices are
> IOMMUs themselves to avoid deadlock, and that's not something I fancy
> throwing out as an -rc fix in a hurry...
> 
> Thanks,
> Robin.

Thanks again!
--Will

> 
> > > +	struct platform_driver *pdrv = to_platform_driver(drv);
> > >   	struct fwnode_handle *fwnode = dev_fwnode(dev);
> > >   	enum dev_dma_attr attr;
> > >   	int ret = 0;
> > > @@ -1451,8 +1452,8 @@ static int platform_dma_configure(struct device *dev)
> > >   		attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
> > >   		ret = acpi_dma_configure(dev, attr);
> > >   	}
> > > -	/* @drv may not be valid when we're called from the IOMMU layer */
> > > -	if (ret || !dev->driver || drv->driver_managed_dma)
> > > +	/* @dev->driver may not be valid when we're called from the IOMMU layer */
> > > +	if (ret || !drv || pdrv->driver_managed_dma)
> > >   		return ret;
> > >   	ret = iommu_device_use_default_domain(dev);
> > > -- 
> > > 2.49.0.805.g082f7c87e0-goog
> > > 
> 
