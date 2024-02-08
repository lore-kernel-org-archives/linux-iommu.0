Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0619D534
	for <iommu@lists.linux.dev>; Thu,  8 Feb 2024 02:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707359520; cv=none; b=ROA4iut4iyjO4aUGYPJ3psSRGFnnoug2k1jrAzTUy8B0Dnlh1oTeDFiNtb4E29Zird9PAuHRRJWudepLrlF8giQ6zDmtsWuZcwLFfwwO9zy+A+Va6OtoZGfTfkQoE0Z2eDZUjgqDezG2LqoDMpw8lZkjBSmnNyXj6zT1sfsQKiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707359520; c=relaxed/simple;
	bh=yuEhedvxSEPhM/c5pCd3h8DUyGdchu0AOMthWvP9TRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9FvbpyYSgmEEsa1Glxi5skOwNXbCHc2vijvSNqjmwkeRJhww+cT8nvb/qADqnq8kNaZb7UeFeE0QdkxQW4cOWmZVjLV3KahF8T5Ny2sTby4rBwbhTDMKwa5GzczTJl8BiUtLz8S/BTo39YOIg6nZa6xPd1mTtR0pJADRyPBH4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=L4o22vvj; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="L4o22vvj"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59612e4a21eso692317eaf.3
        for <iommu@lists.linux.dev>; Wed, 07 Feb 2024 18:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707359517; x=1707964317; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mqi2UC9d75ipUBmZVL8vxv2HsB7JT096rJI7lC+Kbh8=;
        b=L4o22vvji2yMA/4VCqeZgYMrygYC4rzxw4W/c70I6/vooJdW98DvW0otPVCjhj0Q8o
         6mqy04BRwsG2RxEei2FJwn39YeZ9Akh68STneuRZx9II/s2RWbNvuya4lM0owmBeUAKS
         ptA1jS4/cS1YEKwMcmsj1bJUSXNQ6zM+6HwzjFJCg2CWzMF0l4GZX0gGBhadyXXZk1df
         HOSHOGJYI89B6MpBUSk24zi8pICjhSMRnZpFuGxW8sE0jbl/Z/gApbevGoHTcM4Ty9g1
         XErMIQpg9zWWegcxVd9HqJQLA/oBDaT23W/j5TgJsCu9x3gsqUSYQB47dZxLHnE9TYLb
         J12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707359517; x=1707964317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqi2UC9d75ipUBmZVL8vxv2HsB7JT096rJI7lC+Kbh8=;
        b=xC1B3NdNYnvyAb3DwlZpKrmS9qjFHhxplD3QkcBPL0A9ea/45zcFZz1+P0NHFUoh/0
         P6mrJF/gz7HTdsG6xqzGpUHoDQGwjbEiqlL9brc5C1QpOAb7aenkxuJgvA92TuJ5MBxX
         /FUcj3hMfuVywCbkuBnkql+MeZ54veb1GD1IAjP9km+eqKXVEqQV7I7g47evOm+uh4+i
         dZ+AqM1P9u8BRYuztyxl8d9dRm0VrpUXamB3pwJI8FkET+yt3LS2Z+R6XBxd9tmeyrNJ
         s/AKtqh4NguOTAl53m6n1VbyRNf6mXiEXoxDE27LPZKg/t3wTkddARwMZgBdJozlMOHV
         YkPw==
X-Forwarded-Encrypted: i=1; AJvYcCWNjx0nkpcIzRmr7wAaJYzkgXj6sYwkm4Eym+4RIxM3kYHgIPpo41sPQLpXF3PO9zT+hHwJFWT4YHO1ILKw8GqlBwsP674=
X-Gm-Message-State: AOJu0YzZGWZE5JAPexLJzScquLbkRTUYGUIOc1ACXCw4ZtFmMn/so0FH
	fl2Cvm5xsc5/ukQYoc616Dep0U8iCaLfH4dCYYSIUd5dRWBSc877GmdF2uhzYc8=
X-Google-Smtp-Source: AGHT+IEUWOIitBePYuoLkPihaT0+7zTN/28jdj6JQ4NASEHa4+olFD/etoob3nb/95BBzrkrNxDnrA==
X-Received: by 2002:a4a:9c83:0:b0:59a:15d2:ba0d with SMTP id z3-20020a4a9c83000000b0059a15d2ba0dmr7299809ooj.2.1707359517507;
        Wed, 07 Feb 2024 18:31:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXn6IaFZw+jAAhqmLErMQqYv+LnmTwFRkDvkGVns/+3VI8gGJZOvLxNC3fDN6jfAxVEPe22cSRTXM98NBDXCxGn4EFVg+62XLHwjRcvOMtHLKFipQp7aCeN2wEItyv9+EXanbBVXf6kSG7ocOqVWKh1b9eKhvd7fDGB93JaYpzE20Hei0W0Pmbfhw5hjFQRNwR6jMtG3Jv2Fe0Ilfu1BZhx75dmIiQquJjun02TLffpimR3gTFLHTBkx1lApfjPO4RYmYYWBBfWOomrUCj8XDJcQibgCbOwHm6Q1cuTxr69GCYsssdT0CQQ1VI4zwgrXTmGUaOsLOrVQIxPz+rJaeq4XAdCti78+enafADM5cgEF1Ugi1JiQGy7ElAlKVwNw+wKgvnA
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id h20-20020a4ad754000000b0059cfbbbfd0dsm414256oot.15.2024.02.07.18.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 18:31:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rXuCh-00C6sS-KF;
	Wed, 07 Feb 2024 22:31:55 -0400
Date: Wed, 7 Feb 2024 22:31:55 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, thierry.reding@gmail.com,
	vdumpa@nvidia.com, joro@8bytes.org, will@kernel.org,
	jonathanh@nvidia.com, baolu.lu@linux.intel.com, jsnitsel@redhat.com,
	jroedel@suse.de, linux-tegra@vger.kernel.org, iommu@lists.linux.dev,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] Failed buffer allocation in Tegra fbdev
Message-ID: <20240208023155.GN31743@ziepe.ca>
References: <bbmhcoghrprmbdibnjum6lefix2eoquxrde7wyqeulm4xabmlm@b6jy32saugqh>
 <20240123151508.GR50608@ziepe.ca>
 <pgund4coabp5pdlmwze5o2d7ogrdncktqz267yzukjcvmikudc@7svrwdci7ujl>
 <55cab5e0-0abf-47d0-becc-05cdf1d22fac@arm.com>
 <20240124170300.GU50608@ziepe.ca>
 <d5074c11-b03a-4a24-9e3a-dfa5743d80bb@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5074c11-b03a-4a24-9e3a-dfa5743d80bb@arm.com>

On Thu, Feb 08, 2024 at 01:22:47AM +0000, Robin Murphy wrote:
> > So, if everything still works and something else is calling
> > of_dma_configure() prior to using the struct device for any DMA
> > operations (eg because a driver is always probed?) then we should just
> > delete this call.
> 
> I've considered that before - arguably it could have been removed when Mikko
> implemented the full bus model, but now I kind of don't want to since it's
> one of the remaining few that *is* still in the right place where it's
> always meant to be. The correct fix to meet the original expectations
> *should* be simply:

It is a bit jarring to hear you call a rare place, where it doesn't
even actually work right, "meet the original expectations". :\

It is pretty clear the function doesn't do what it was originally
expected too anymore, and there are now so many call sites doing
different things I don't think that past is so relevant.

> ----->8-----
> diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
> index 84d042796d2e..6cab950690a0 100644
> --- a/drivers/gpu/host1x/bus.c
> +++ b/drivers/gpu/host1x/bus.c
> @@ -455,11 +455,11 @@ static int host1x_device_add(struct host1x *host1x,
>  	device->dev.dma_mask = &device->dev.coherent_dma_mask;
>  	dev_set_name(&device->dev, "%s", driver->driver.name);
>  	device->dev.release = host1x_device_release;
> -	device->dev.bus = &host1x_bus_type;
>  	device->dev.parent = host1x->dev;
> 
>  	of_dma_configure(&device->dev, host1x->dev->of_node, true);
> 
> +	device->dev.bus = &host1x_bus_type;
>  	device->dev.dma_parms = &device->dma_parms;
>  	dma_set_max_seg_size(&device->dev, UINT_MAX);
> 
> -----8<-----
> 
> ...except you've now also broken that at the same time by removing the
> dev->bus check from of_iommu_configure() :(

Umm. Is there examples in the tree of this ordering? I looked for a
while and I only found a bunch of counter examples..

Trying to order it before the bus is set feels like a big hack,
something so subtle should not be part of a driver facing API.

At this point, if it is to stay here, the functionality it needs
probably wants a new function name and no entanglement with the iommu
layer.

> Frankly, for all you protest whenever I call you out for demonstrating a
> lack of understanding of this tangled mess, I sure do seem to spend a lot of
> time explaining it to you... :/

You never do actually explain it though. You throw some insults and
make a few statements and often don't answer any followup
questions.

The code itself is not enlightening, there are no comments explaining
these entanglements, these patterns you point to as "right" are not
really followed. The designs you explain as "right" don't fully
work. There are lots of little accumulated hacks to trip on.

It is a huge red flag that something so important as probing the iommu
is so completely baroque.

> I've never claimed it's *not* a horrible mess, but at the risk of repeating
> myself, it *is* fragile, and the consequences of mucking about with it are
> tricky to reason about even when one does understand all the history of how
> it's intended to work vs. what actually happens. To coin a phrase I find
> enjoyable, this is definitely "F around and find out" code; as this and
> other threads show, now you're well into the finding out part.

Well sure, fragile is how this kind of kernel work usually goes. How
many times has Thomas broke Xen refactoring x86 stuff? This is normal.

It is impossible to know what every crazy driver has done, and stuff
is getting broken. The point is to slowly make progress toward a
robust and understandable design in the core layer and facing the
drivers, especially one that releases the drivers of any complex
understanding.

We've made good progress on this front. The iommu drivers especially
are slowly getting more uniform.

Here we got a log message that points to something really WTF going
on. John's case is different and seems to have identified a real
race. I think we are doing pretty good on this.

It would be nice to come to conclusion on what should be done here
that improves and makes the driver facing API more robust. But it is
just a log message so maybe it is fine to leave it.

> > Was the above issue fixed in commit 07397df29e57 ("dma-mapping: move
> > dma configuration to bus infrastructure") ?
> 
> Um, no. That commit was no more than code movement essentially separating
> PCI from non-PCI configuration; merely host1x didn't need to share the full
> path which ended up as platform_dma_configure() since host1x doesn't support
> ACPI. Once again the fact that I've had to explain that drives me to utter
> despair...

Okay, I didn't go through the whole patch, I was only looking at the
hunks in drivers/gpu/host1x/bus.c that added a new of_dma_configure()
call.

Regards,
Jason
