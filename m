Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390753F54CA;
	Fri, 28 Aug 2026 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787912218; cv=none; b=mqTeZZ2HXTuUzyMtTD9sJUNHo4upv6/KEFEqTXNOqx0+r7vfjxMdoWQReaL1wuqkGExJUPrdO6xMtly+RVS2HkTtxHM2wCz8z0KiVBuWkPaBXztqMHqTTlLZkyrg8x2mqVaYu40CwDqgP3W0TmGw7a7rFLduXXUMS12wbKDsyWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787912218; c=relaxed/simple;
	bh=9Us9IMizOoqaj6TquqOu5TOVM0zErZxehu5FgJJ/Rw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmdoHERP7dVp6h4GwxN2P0c5PtLFnBaoaJli2KlhS9kAMr+4hIlYRTy6dA6mjsQXt7bmFPWtYXIiFpoA5SpuDQfOb+GNpl2xNwOypvc9ru7nWkf2U+ClYi/8JnWkdKpPDW34IYLQkxyoQEeT0LPBJ1nKt1cnLqBz0sPUtvknmsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csgXZBNZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csgXZBNZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43DB1F000E9;
	Fri, 28 Aug 2026 10:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787912216;
	bh=P4tQ+sDRU7aZ6CAzmMOUXv0qgEZIvH2G6eCwbcj+hO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=csgXZBNZ+X4iEmHYpxbvT57tC+RvwyPFkPfuJaSyhyLp3N/53N0xLZ2XxXt/TQSoI
	 0wz6dWz6x3UKBQ/bI0j67gIC8bBlKqc/r1D2BzDAtHkO9M6V9bbyydCjyIX3JpIwfh
	 VG9/dFYHq/6STUfGEVgVxd5I0Pg4tzdzOd71evI5qlHdUH1sWTbrm7TC69Gt38+TsA
	 47L6i501WJsik/NuRZtEL7tTCLCCWLvNlhQ43R4bj9L9laqghmYPM4FFhlZEJQW6rj
	 eRWhuKHgErjobB523V9pp/7ntzaEZT7eKdt2oS3BybVGX3ybaNJ4eKguvdeSehrZeL
	 946iCDzbVPOFQ==
Date: Fri, 28 Aug 2026 12:16:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Drake <dan@reactivated.net>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, nick.hollinghurst@raspberrypi.com, james.quinlan@broadcom.com, 
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v3 2/5] dt-bindings: iommu: Add Broadcom BCM2712 IOMMU
Message-ID: <20260828-hypnotic-jerboa-of-grandeur-cace05@quoll>
References: <20260825-bcm2712-iommu-submit-v3-0-7f143e7289b6@reactivated.net>
 <20260825-bcm2712-iommu-submit-v3-2-7f143e7289b6@reactivated.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260825-bcm2712-iommu-submit-v3-2-7f143e7289b6@reactivated.net>

On Tue, Aug 25, 2026 at 09:56:05PM +0100, Daniel Drake wrote:
> Add bindings for the Broadcom BCM2712 IOMMUs and their shared TLB cache.
> 
> Signed-off-by: Daniel Drake <dan@reactivated.net>
> ---
>  .../bindings/iommu/brcm,bcm2712-iommu.yaml         | 52 ++++++++++++++++++++++
>  .../bindings/iommu/brcm,bcm2712-iommuc.yaml        | 38 ++++++++++++++++
>  2 files changed, 90 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

