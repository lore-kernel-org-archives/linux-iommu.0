Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11320440C
	for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797602; cv=none; b=cRlUhI8dhiZ6nDIG8kdyqVpjs9nkfovA3zURABKMGn+w8yUklG5B1zlYD+xH4Kja2dcSaBtYX0Z4O9g+wiMGM6aVQIOBro30N1ftS9uYtpCkVeOI+rWyQ++zRckV9qkYs5dLNl0LjK1cIs7MYop0aK7IeZQUj2SnXOhaQv7KUNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797602; c=relaxed/simple;
	bh=TNvJcoklh4WnAHN3grm55Zl/KM16QRzHr3vB1Z6UZB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYUu0EfBw/M9TmIq6OomtgVo0nwfLB3Sek4xXq9CZ+i35nnKmCgkhEEvPXk5+jWREm321N5KROHvdGg5TFD6ysSjfkLjS3A8ly+Bqyt1U2Yz4pSi+fjUNSJ0kCGgGI6zIOTsEOWRe/v5gKoX+3lFV6hnkI2xSAq947nWjdEcbyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jB1cC3q5; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jB1cC3q5"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d9306100b5so1358358b6e.1
        for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 08:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720797600; x=1721402400; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=43HoLu0+3/bbyXS55KnD1P/pBVc8WMouWNFCz57Gz5U=;
        b=jB1cC3q5wcRAD9SSK9L7DoGHkXfALjJBEgyvecklrnBgm+CaivpWfed1Hru61rNqQ8
         2uRvFMs/xuZJwYNwqfKhqP3KEmaONHInFEgZ2OztuabIOArFnDW7XwvpxLSoDeP2Pp0R
         Rj+p7dm/jvuZ+nERsYozCAQuduj54A6xBuBcqz+YM761MleL/g3COm5/ltGLbbOpk5Tv
         vJRShQeMEbNpVbd/GilXycaybeg9Rl1F0vN0INNC/OtLradVLvgLnyxGwmR43Q2YCbrC
         tCjoWWVuqVut516B47vqNDZly78ZA4jZ/XZi7rThTK2+WOD/DN87gqit5lutP0aXYUq/
         JnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720797600; x=1721402400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43HoLu0+3/bbyXS55KnD1P/pBVc8WMouWNFCz57Gz5U=;
        b=RT8Z3VGALqs0sMaE+2pOxi+NZPXhJ4cH0y0no5Am+RWnnkeLpJIGOKRM1f4JYoEUq/
         GsQpQIboOGa6/on2SqlRTt5n0A0+YLHpNHcAcKCZH1r+z3qQwtz7F9GM+AcPgbsqacXM
         j9W4o6LnsjZA/U9tlRVaLeEsTuFH62uavRQXFL/E7Gublg0LeyEGfviSxc7h/AjViec+
         5ngw3V42J036QGD6qH1eCdT1PgIuS7BilTC3UXK1/xi26WLWEgb0iK1QrOsscjKVxR5m
         GduXj6D0RMj2RfbVqQZKzyjYUI9wfcSsz5XfmLe6yCO4rTAfP9CR7XCxZT3m5LMXstD+
         J92A==
X-Forwarded-Encrypted: i=1; AJvYcCXv9HhAizpSWhbkmB7KTg+EAsd+5qftg+RfLAbdK+zGUp1MWSm6QBjUtktIKMG4kheJg416Fo4CzFtutZlcnwg1xCGlC9g=
X-Gm-Message-State: AOJu0YzkGNP2VkrSDmJasGAHxnfClbmdrBGrK+qpBR65RG8Wztu5dtLD
	saOuiTp9C9JhNG4ICLfI2+huFXjqyxJiLq3nDg0+uLD8vKhqKxN0b71PQPa9H/E=
X-Google-Smtp-Source: AGHT+IFoQMEIClq/J4S2KmMkxKKGbVFFHFC76GCUor1bVVj9EjuXJY00vRFxFZG1ZbCcYZwFjejzRg==
X-Received: by 2002:a05:6808:19a8:b0:3d6:317b:a95c with SMTP id 5614622812f47-3d93c07512amr12878873b6e.38.1720797599214;
        Fri, 12 Jul 2024 08:19:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f1900e954sm412288085a.28.2024.07.12.08.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 08:19:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sSI3x-000zGk-RC;
	Fri, 12 Jul 2024 12:19:57 -0300
Date: Fri, 12 Jul 2024 12:19:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Yi Liu <yi.l.liu@intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Joerg Roedel <joro@8bytes.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support
 AMD IOMMU driver
Message-ID: <20240712151957.GE14050@ziepe.ca>
References: <1f8f04e5-3b70-45de-bd93-e3c96fb0a555@amd.com>
 <ZoLmyOzOVYGLKjmn@ziepe.ca>
 <68d300af-4d3d-497e-9338-d99dbf88dd21@amd.com>
 <8bfc6cb7-d2d7-4d4c-9970-f4f207fb54b4@intel.com>
 <20240709182303.GK14050@ziepe.ca>
 <3eff5c86-8b5d-491a-955e-794198350ec3@intel.com>
 <20240711234917.GW14050@ziepe.ca>
 <35ff9f32-ae60-4124-9ced-42f82c2b4f93@arm.com>
 <20240712135326.GD14050@ziepe.ca>
 <7f930d79-2309-4b94-a187-0707c6d5b9e8@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f930d79-2309-4b94-a187-0707c6d5b9e8@arm.com>

On Fri, Jul 12, 2024 at 04:12:43PM +0100, Robin Murphy wrote:
> On 12/07/2024 2:53 pm, Jason Gunthorpe wrote:
> > On Fri, Jul 12, 2024 at 02:40:37PM +0100, Robin Murphy wrote:
> > > > > BTW. SVA domain shall not be attached to RID I suppose. This should
> > > > > be a common restriction across vendors. Do you think it is valuable
> > > > > to let iommu core block such an attempt?
> > > > 
> > > > Yeah, maybe.
> > > 
> > > There's no functional reason to disallow it for Arm SMMUs, at least, so it's
> > > something that could potentially want relaxing back to per-driver in
> > > future.
> > 
> > I think everyone can technically do SVA as everyone should be able to
> > do PRI on the RID. We want PRI on RID anyhow for unpinned guest KVM
> > support someday.
> > 
> > My specific "maybe" was because SVA is troublesome for MSI, on ARM we
> > won't have an ITS page mapped for instance.
> 
> Yeah, I think the trick for that is going to be to require the device to be
> happy with shoving any kernel-owned mappings (MSIs, firmware, etc.) into the
> TTB1 range.

Oh that's a really clever trick!

Jason
