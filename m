Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1C43B4EBB;
	Thu, 30 Jul 2026 07:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785394851; cv=none; b=dyuJJ4q/+7TGEH27HTd24xD91dFkRFGU9vFzOd68U43UxG5Fp0qaHTc7DowH4iY85m7L09TThGCDj8mwRr+UBFE1ZHanN638FCardIiyASvmMwcfwyCG4xlRb4cW0/rReAhpH4GY4oMSSdnz3v8gcXDuImcGt0dIZXNyz2Hbe9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785394851; c=relaxed/simple;
	bh=JLAqM/StU2KBesrDDjzQX6W7skAKikrIt9FNScwIgOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFusfS6V9AYk5sZ9bSh1L6vmY3sVTi1H2RI2XKVIITIdWiddaXSTbNFOAq94S24FnFLY8ppUxyy+EDwGW9OvUpmTdSMl0k7T7WijCMFgx1ADtVzlI+rMFfrOZT3O8MrHHpgFp4fl1e1rVlmvO+A+uzIHoUI0eANzB/y5b1VqFW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKOZbfri; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKOZbfri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618131F000E9;
	Thu, 30 Jul 2026 07:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785394845;
	bh=2JijS86Jw1VKItMsxEtHHn8Jv2/Telj2s55VY9QKuIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lKOZbfri9z5YOMp6hAdPIvqp4XAFYFEB9wvMDaz6nuMB+Cir+KxLlA0QIC7SHvyCn
	 mNjxjVDsq+zgleMpHQAXI1pmmW45eg8z/NWZu4BmvXxkQkSmQkSm7Q4HZBvrAH/x84
	 ysDI5UKoDMTylhOmsF/Kpdylo2kwA7cNEfHra0sp8Ypd1Lv2jORKJsVuuUDDG6kuzc
	 4K1/3szDXdmbSDvknNjsTqDIOIWLsrdefgugfK5rljV8aof2A+yk3sg6UXfFaePb+M
	 B2LNd19p2SVYg7hBh5B9bomb2AS0ikh8x3dftcs4lxQFg/ryRxxxxFWv7d23bD7Weu
	 rP3N476pdYWNg==
Date: Thu, 30 Jul 2026 09:00:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Drake <dan@reactivated.net>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, nick.hollinghurst@raspberrypi.com, 
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 4/5] iommu: Add Broadcom BCM2712 IOMMU driver
Message-ID: <20260730-small-solid-spoonbill-8a8bbd@quoll>
References: <20260727-bcm2712-iommu-submit-v2-0-0247b5c03de8@reactivated.net>
 <20260727-bcm2712-iommu-submit-v2-4-0247b5c03de8@reactivated.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727-bcm2712-iommu-submit-v2-4-0247b5c03de8@reactivated.net>

On Mon, Jul 27, 2026 at 09:43:59PM +0100, Daniel Drake wrote:
> +static int bcm2712_iommu_init_cache(struct bcm2712_iommu *mmu,
> +				    struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct platform_device *cache_pdev;
> +	struct device_node *cache_np;
> +
> +	cache_np = of_parse_phandle(dev->of_node, "brcm,iommu-cache", 0);
> +
> +	/* Fall back on 'cache' property used in old/downstream firmware */
> +	if (!cache_np)
> +		cache_np = of_parse_phandle(dev->of_node, "cache", 0);

NAK.

You cannot have undocumented ABI. I asked you to drop this at v1.

Best regards,
Krzysztof

