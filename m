Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8047630F95C
	for <iommu@lists.linux.dev>; Sun, 12 Jul 2026 22:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783893959; cv=none; b=hRJnFmTRqNV/dSZW3REm0l5QYvO1WmafVP07fensWhzIBFr0dQx6CzD7kzetAqu9I5GD+7BlOODGC0VLFguZhL7m81+84+lKL2XGgevR2JzpxTNcdTIxmbGF/1I41WvBGAV13Vg0hYfWSzIKULwu1DcuLcLAoYlrHvnUurjgBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783893959; c=relaxed/simple;
	bh=MyWENG1m9gbrfCTNQdsyzcqoLVZg6C/T4NBlYiaTdrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xk6sU3pGdrs0o8ElSt5a/ieJ1r8TX2NHyLvb69QH0enHBHQZlOBYk+tp1MS0T0K1rxJODNogud/yWy86JHC971K2ZpiaH0s8fnjjxmu62bgmwal2ZAcje26VUJFCDImK8K1yldmYTZlLKytB27ctVJZOCJmozGmuy14mFGLmSnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SoZu6epn; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SoZu6epn"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8eeb4508f29so22541986d6.0
        for <iommu@lists.linux.dev>; Sun, 12 Jul 2026 15:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783893955; x=1784498755; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kivqKCD/+dlHoNCjZOlMrMIExYZ3y1i62zZem0Ylilc=;
        b=SoZu6epnWwY+gqCPKixprFayyPClK8Q5aJrDnAiJ2duaoe85VFKLZXC94ZE+Y11/gp
         SITtLSGtFwICBhkNWdXGLDgak3HeFx2pdUL/sBFd9vH+9uhhpOMueLxhhYY4WxXlte+t
         r90Vm2m828o7s62Ahz3fKnoGr+xnnbsPB6cl9HFimUgrQnzG+HONEBEnOEIRA0xEtvGE
         cxW/430h3HN62QryRQuysi5km1oAwEoQPSPAYB2LXsSvNOqMXiOH6UEfGo//fv6+UMXS
         AyC9ztukhegfWft29g4z+5wRlLj34tHkexhiYk/zA5TEbh0t9yDbRCJR49dfX6hfC18Q
         F70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783893955; x=1784498755;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kivqKCD/+dlHoNCjZOlMrMIExYZ3y1i62zZem0Ylilc=;
        b=Dd+TM0SFcKa9B9IwLcQP6JXlUQQ21PxKCVXjfbiIRGECcZxF0+8k1/L7sJv1wddttv
         ldvDM8mi6JRospUVSwSS4mROF7MAGGzq41+QoxncesR+9w6wpCHu1LY0nEGGvk07jK1g
         vBLfo4NuAmGoMr+Nc63ijwKRrI8a1EvnBYwYuRpwzZKamrg5edSm01AvDda4X9p6rxTZ
         YiQPPaWUYHjkpdMTSvo5ygv+hAnonjHtSnYQpWY8n3Iqzll77JmTWxOb98TMZbJ2VGN8
         fWgjtimMGs5YZhmTc0EBlTin5YBrILwwl5dbgK6mfbC86ngqH3OmyHuah8YiC/dLffJp
         rNcQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp5WxsSAr/C/tjW17/q//J1KPZJ6QGgPP7zwjP/2fR+/fLRR+yhhVAuMBMF7x3l/PvwJRgLRg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/WqAQzjfHLEsiDM7DdYF0Osodb9gBfSvqqERm8B9wC7EWQy1x
	mBAEm1ZmpWWn5g9AxvXOTatuzAQjtBWxhPEzo3hqX8kSN17trITJKAEgsMCT03ttUjM=
X-Gm-Gg: AfdE7cn2rqr0+F98Ql4vMC3vRgyD40kIzxvJddbWUDMHGliPxT7pyp9QF6ow8qG0xDb
	y+TzSGDOsvPOuJnluyEugMOFz5lZC0+fMMHTfNep0LxbJR8Vh++DH3DeU4caqYOg5Kbco2SGlTQ
	hF50Ne481hincpEzkuNEzDdJIM3AlL6HQUcEHY2EolQ0k8PJqtq+yGLNKoNPGcp3Z69WYd1UIH+
	XANUamLfI6FA7hPTOhXbvOd/DTg91oVVpCVwSTp6Uj3YPPTyoRIJ9u2DJ/eOTU3S+itbCh/1deX
	ONyOW7HozxIuK4Y+zOauavzxPBDmRmHKAuQcNdxhOVfBVcO2d2wqmgeSEXFMKM/2o6HmhkYNBWG
	GfGj0ECJZXPismzP+Hdr/gHHcCG7GBUWpVhKa11Qi7cLbQnwuelEWbk+7iAtR
X-Received: by 2002:a05:620a:43a8:b0:92f:c78:559e with SMTP id af79cd13be357-92f0c785768mr97967985a.35.1783893955496;
        Sun, 12 Jul 2026 15:05:55 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5baaab7sm953864085a.19.2026.07.12.15.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:05:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wj2J8-0000000BnY7-1ro6;
	Sun, 12 Jul 2026 19:05:54 -0300
Date: Sun, 12 Jul 2026 19:05:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Drake <dan@reactivated.net>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	nick.hollinghurst@raspberrypi.com
Subject: Re: [PATCH 4/6] iommu/generic_pt: Add Broadcom BCM2712 page table
 format
Message-ID: <20260712220554.GC1835788@ziepe.ca>
References: <20260712-bcm2712-iommu-submit-v1-0-80e10cdde2ea@reactivated.net>
 <20260712-bcm2712-iommu-submit-v1-4-80e10cdde2ea@reactivated.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712-bcm2712-iommu-submit-v1-4-80e10cdde2ea@reactivated.net>

On Sun, Jul 12, 2026 at 10:18:54PM +0100, Daniel Drake wrote:
> The BCM2712 IOMMU implements a 2-level page table format. It is relatively
> simple, with one unusual aspect: leaf entries can only be installed at
> Level 0.
> 
> Adapted from Raspberry Pi's downstream bcm2712-iommu driver (original
> author Nick Hollinghurst).
> 
> Signed-off-by: Daniel Drake <dan@reactivated.net>
> ---
>  drivers/iommu/generic_pt/.kunitconfig        |   1 +
>  drivers/iommu/generic_pt/Kconfig             |  10 ++
>  drivers/iommu/generic_pt/fmt/Makefile        |   2 +
>  drivers/iommu/generic_pt/fmt/bcm2712.h       | 259 +++++++++++++++++++++++++++
>  drivers/iommu/generic_pt/fmt/defs_bcm2712.h  |  18 ++
>  drivers/iommu/generic_pt/fmt/iommu_bcm2712.c |  10 ++
>  include/linux/generic_pt/common.h            |   7 +
>  include/linux/generic_pt/iommu.h             |  13 ++
>  8 files changed, 320 insertions(+)

Looks straightforward to me!

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
