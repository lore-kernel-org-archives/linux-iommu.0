Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CB05D900
	for <iommu@lists.linux.dev>; Fri,  8 Mar 2024 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709930260; cv=none; b=m9h0wnapf86AP9SGOxyirw0fLKJODEkdNAC68Iw1m6inN9y0zFOUupka5nI5s4VOA3PTOibJ2H9yVukcvB2BxcgeEeG7fXlYCz8FNmoTkH1zt7OPEK+Moy8CZehPmt31xDLjhZjg3cmrIKj2tWjWTY7NWcdENgCREIH3YknsBBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709930260; c=relaxed/simple;
	bh=QVuJYBg7eAXpV6Ijtmm49xelHY48E81cS9xdFZ2y8ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLuRbDJwT58YmY+/NcT0DiOOmV16Noo6cvMY/+YD8uB7EWqKimRuqAcrl7JEGTBMbIF6laLqq9QSjxOcoS1Ur+cp2QoDhkpeCN5ajinI2vG51Iemx9Xtoy06QlrlCNfWVpvsrl4kaC5f2pkWORhdrL9VTNvYThE34VWtHqY2U30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BhTViLWG; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BhTViLWG"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bd72353d9fso1381311b6e.3
        for <iommu@lists.linux.dev>; Fri, 08 Mar 2024 12:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709930258; x=1710535058; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8AtBhhUJsX7iCjuz60QlnI9oeTh8ox4hiuWAL+2qFxI=;
        b=BhTViLWGWF2y/YO4KbrDOksJvCCtaU6dYbLzvBq4bPwaytoHBlXpwGwQ9inDNZk9rT
         j08CyMIdWGoFN96lHTLRKfGe5yna8LTHTTrql2pQJEVY5CwvdZmK/dU7znSn5Lgiftq7
         IcVLQO70Zz0b/oc1wmAoacbPj892RtuRlifdXsTkYX9Y9kZXTZje5kv/oh6dH0dtSvwV
         dMsL6nMnU5O5vMmtyrVnUwlN+zHATztoy1TceNBYk23vyykv00W2cU7Px+mdiePUcH56
         H40w2QqDgQFLSel1eMi7xSLCbOSHmoaomXV29f3zcQcjvIdT/e2r5Ea3GxZpiB7uPVes
         XerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709930258; x=1710535058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AtBhhUJsX7iCjuz60QlnI9oeTh8ox4hiuWAL+2qFxI=;
        b=C7Q5nc9s+GjthOBJ/sKPOgbcfynRM63zP9NYZlm0DQ2LQUJTqw4EnxTMZSKZU2Mw9k
         2d00HOjhzy+Wxk0qk32k8KSXm2o0TqmciPgVVguUZ+HpyEBjfC41r/568wA7qWxn8yJf
         ca9j/3iibfnoi+skhcoQkccdzIi6qeEUdo7aHr8LwlBHEknumsUb0eEtbkjL0rmqkBUk
         SWrBOkfLEBjTf+toTHEdsaguSLR0qC5q6Pu4bUReXZrb+t9ljjnDqF7EPgLEJew7zr70
         2UhSCILEtjJEXm05fjB7Xx182n/Hk1+ZdSPmuJMrRooQArSJfrRqCELuOQH2erIJN3XI
         3jIA==
X-Forwarded-Encrypted: i=1; AJvYcCXcKSof1EFZ2cW+rGW0v0ZogC5g+ETl8xDVx0b4OhMfngZf6xBkQ2+KArwJyFr+kc8HGpTrmGaefAF7e0ior0+1uQ61SVI=
X-Gm-Message-State: AOJu0YydqXQdsJrepCmUpKKSVfyIQrCOJeya4QDkA5niy00w285YsIkH
	p6QnBcF3r4pivPvPjvYTidVmmo+I41RNUzGHjUja2CX9VtWjw+U3f6PpK8EyQ+A=
X-Google-Smtp-Source: AGHT+IFbgpl0pB6g2XaoyrWZZStUAXJBL7gQEaHjPXP/ruZgANeVKSb/3hxLcl0YhzvyQSM42+vm+A==
X-Received: by 2002:a05:6870:7a0d:b0:21f:ab17:44c3 with SMTP id hf13-20020a0568707a0d00b0021fab1744c3mr272908oab.24.1709930258434;
        Fri, 08 Mar 2024 12:37:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id gu19-20020a056870ab1300b0022154dd4eb0sm47251oab.4.2024.03.08.12.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 12:37:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rigyH-007y3a-Aw;
	Fri, 08 Mar 2024 16:37:37 -0400
Date: Fri, 8 Mar 2024 16:37:37 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 7/7] dma-mapping: Simplify arch_setup_dma_ops()
Message-ID: <20240308203737.GB9225@ziepe.ca>
References: <cover.1707493264.git.robin.murphy@arm.com>
 <f0ea76846c89a65dfe42933d78d770004bb3de01.1707493264.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0ea76846c89a65dfe42933d78d770004bb3de01.1707493264.git.robin.murphy@arm.com>

On Fri, Feb 09, 2024 at 04:50:04PM +0000, Robin Murphy wrote:
> The dma_base, size and iommu arguments are only used by ARM, and can
> now easily be deduced from the device itself, so there's no need to pass
> them through the callchain as well.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> v2: Make sure the ARM changes actually build (oops...)
> ---
>  arch/arc/mm/dma.c               |  3 +--
>  arch/arm/mm/dma-mapping-nommu.c |  3 +--
>  arch/arm/mm/dma-mapping.c       | 16 +++++++++-------
>  arch/arm64/mm/dma-mapping.c     |  3 +--
>  arch/mips/mm/dma-noncoherent.c  |  3 +--
>  arch/riscv/mm/dma-noncoherent.c |  3 +--
>  drivers/acpi/scan.c             |  7 +------
>  drivers/hv/hv_common.c          |  6 +-----
>  drivers/of/device.c             |  4 +---
>  include/linux/dma-map-ops.h     |  6 ++----
>  10 files changed, 19 insertions(+), 35 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
