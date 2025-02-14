Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A451C8615
	for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562228; cv=none; b=OAonTfa+KOmpBOH0ba2z39D2U4qNBWIS6G2HBhhVfZ+3NK+TBaJDgrtUsG6I4wgfQz3h7GpQHbSvz/dPSde8e3n5qNytIOHuzWVOTzAt1s25snWBELdEphTX2yjpUOUjDyVaEEYaCXzO6/Qr5SUbvP0b09Px1WW7R/Iy94ngpyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562228; c=relaxed/simple;
	bh=mhtKeLm5igpgwc6h4fPK4Ajh2FAgScw0xgMCQuun79I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1K52MWWWt5Drf1b2kSrF8s7oatV81sWER0QC6FsFpKxlv5pmkRW4CDaoLv8SCSpWEcIUI10MUXFQSLcae46MqvRqKQOqXhtGu1Q95d2ltXkjQ16RJTUc4nqAOI/UoSIn7RzhxSboGJ1hYV0/dKQ8Cmv7/kKhoCIb617SOPNbQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=c+PGgIDO; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="c+PGgIDO"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e65baef2edso19181426d6.2
        for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 11:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1739562225; x=1740167025; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=buGqXK8/ktUg8RW6l4BfFP62BuolnXWk213EnIe2HCM=;
        b=c+PGgIDOCXs8OAn2261X4CHqL8mypvvSSv0n14DGjyIeStwmjbdykj4I/JY7MpQ0c3
         cp+wMnTHEvYwT4NJw5Usd5s9zVLlRmM3LqqFsBX0+CBcpn8TGq4wAHTp+T64P+xgQRWS
         zq2JhDQiT+rAyHg+Yf49LreyDAuwYjAZtGsjOop6MiTwIW00lyyGOvE36PQjc7SesHJ/
         gMSF2fF/3OUxeJv43StpmmiPyJ7+9BgjNhpXZJUi3WMry/veIiN2MymvUJ9+Znag90LO
         /Q62HQkVdhECySF7He+rlKFpNBN3L7CGAeqgafY+u4o+/BdC98PR0nKXNJw2xGpvCPIw
         Ad+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739562225; x=1740167025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buGqXK8/ktUg8RW6l4BfFP62BuolnXWk213EnIe2HCM=;
        b=lVTM9sklbp5U1uMVu+DZYUcTXSQU5/Oeet0/81PqyMLQHidLUmSvEFMLtYMvSjI0gU
         PlNaY3fy1Fp8RbQsLt14/rSEwM7KSIBm+Ag7HvdObJYw/pBox4FGrQ9p1/Xwa5CUIIrT
         O7NiiVGO2slnTjVvCb+G1tAzljnibqIRmmV4BKC2DyqberbI12GG1GIqRhlVRr8zYWWE
         7iBEAsnwIXAzOL17b7MWLtlNW0usZc6poWLgZASzwkmtSUprqXMg8Gn9GcSgnRGRKqUB
         Khd8iqDwEGAeJDEbcBCKToel0RxyQSYCriB3JdnGpJ09opUJrrgrax1LfcUaaQQx8EYc
         yDtg==
X-Forwarded-Encrypted: i=1; AJvYcCVX9VzVUXur7GwJF1hfK4bsw4DvPvFV5eSSYnRQiIftBfkpa/zdwj66tInC8XNr+1eHx6xvhg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4qRzYWcUQjNlsUShkA8lPjp6XjyzXsYzx3+2IHEobs38WnFWi
	1dJ8eA9OaE2sjqhPQ9bmvJ2oe34OsOSjoCgUzuq6l4fc9n5mSoYF56mWCclvJew=
X-Gm-Gg: ASbGncs+CtOQCUe5GzPBjO9SFibGK9jzRPRNSRZRZVYM4bGS9xqmuQxCe96m+QmD4+D
	eRWv3qWz17brz8oiAWHnpLgbcjG0XxbDPu5CWchO16nLAD2/WKUmJEqP1DhEocRv2JzEmZljUY/
	uOAZT2e4NK1e1eHFyUbTXeqbutAlYUzv34/h3pGptsSKYj1VBi0TE69gFN7CVnrn7eplN2yISjh
	TbjcAFdaRuke+xJf2MLMG9fqgOu3eWJKt6TOdO1Fhc+Ep3MeCUgloBeImvmQM2pbYJrMXFOkkH8
	E6qp+PspARAf/xfNUARuaMkDpMOB51I+C1aqiuvjLEvU4oHLC88N5gxSxNQk2WzE
X-Google-Smtp-Source: AGHT+IFaSyYcyF+Ryh1E4s3MGomseXTapLkA1HeMxX8nrM5eJsPF5uZrRKBhBqh/ftWJjIpaJugHyQ==
X-Received: by 2002:ad4:5d6f:0:b0:6e4:4331:aae6 with SMTP id 6a1803df08f44-6e66cf38b4bmr7577546d6.39.1739562224840;
        Fri, 14 Feb 2025 11:43:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a439esm24231236d6.67.2025.02.14.11.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 11:43:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tj1bD-0000000GmVK-3Ena;
	Fri, 14 Feb 2025 15:43:43 -0400
Date: Fri, 14 Feb 2025 15:43:43 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH 1/2] iommu: Handle race with default domain setup
Message-ID: <20250214194343.GE3696814@ziepe.ca>
References: <cover.1739486121.git.robin.murphy@arm.com>
 <87bd187fa98a025c9665747fbfe757a8bf249c18.1739486121.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bd187fa98a025c9665747fbfe757a8bf249c18.1739486121.git.robin.murphy@arm.com>

On Thu, Feb 13, 2025 at 11:48:59PM +0000, Robin Murphy wrote:
> It turns out that deferred default domain creation leaves a subtle
> race window during iommu_device_register() wherein a client driver may
> asynchronously probe in parallel and get as far as performing DMA API
> operations with dma-direct, only to be switched to iommu-dma underfoot
> once the default domain attachment finally happens, with obviously
> disastrous consequences. Even the wonky of_iommu_configure() path is at
> risk, since iommu_fwspec_init() will no longer defer client probe as the
> instance ops are (necessarily) already registered, and the "replay"
> iommu_probe_device() call can see dev->iommu_group already set and so
> think there's nothing to do either.
> 
> Fortunately we already have the right tool in the right place in the
> form of iommu_device_use_default_domain(), which just needs to ensure
> that said default domain is actually ready to *be* used. Deferring the
> client probe shouldn't have too much impact, given that this only
> happens while the IOMMU driver is probing, and thus due to kick the
> deferred probe list again once it finishes.
> 
> Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
> Fixes: 98ac73f99bc4 ("iommu: Require a default_domain for all iommu drivers")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iommu.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
