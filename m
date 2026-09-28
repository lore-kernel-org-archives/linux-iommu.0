Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847A246E01D
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583593; cv=none; b=nNk0/Gq21wzoYOcDsVA62VvtKqRb+0K7tx9IH4VnZCvgPjCzKb0rrShbUF5Bq4z2MzsDv1KobFve4ws99yNPDqy0evX9tNYdRln7npO2kJy4WLxmEGxQ4Jf59/RCfc+F0TbQN9u3QyLSGaWA4tr5lxTmPDwPqHCjYQg47mO9G4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583593; c=relaxed/simple;
	bh=9UVSxdTe8b7TgneoWLQ4KBffWP7R9fRbAe/jkoXP4eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScbkxnzUUX9GCBFG85vL9JZF5igEkFIwD7K5DiEQCj7IucAXR1/KJlYYYz4UZ8cl6L33xNSkEbUg9Hu0q2VA1F3qadwmA+Q55sJsVAvCY8wqVmaCgJmEJsiboep4i414+DG2icRSGGCAMSKQU1ULL8vGIlfRL2YEDpuCdS41Zpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00db6de583eafb82e4.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:db6d:e583:eafb:82e4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 663791C778C;
	Mon, 28 Sep 2026 10:19:50 +0200 (CEST)
Date: Mon, 28 Sep 2026 10:19:48 +0200
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: dan@reactivated.net
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, nick.hollinghurst@raspberrypi.com, james.quinlan@broadcom.com, 
	Jason Gunthorpe <jgg@ziepe.ca>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v7 0/6] Add support for Broadcom BCM2712 IOMMU driver
 (Raspberry Pi 5)
Message-ID: <arojDdPH1o2ckB5x@8bytes.org>
References: <20260927-bcm2712-iommu-submit-v7-0-dfa2b975cbc9@reactivated.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927-bcm2712-iommu-submit-v7-0-dfa2b975cbc9@reactivated.net>

On Sun, Sep 27, 2026 at 02:08:59PM +0100, Daniel Drake via B4 Relay wrote:
> Daniel Drake (6):
>       iommu_pt: Fix test_pgsize_boundary() failure on narrow-OA formats
>       dt-bindings: iommu: Add Broadcom BCM2712 IOMMU
>       dt-bindings: display: brcm,bcm2835-hvs: Document iommus property
>       iommu/generic_pt: Add Broadcom BCM2712 page table format
>       iommu: Add Broadcom BCM2712 IOMMU driver
>       arm64: dts: broadcom: bcm2712: Add GPU IOMMU and IOMMU cache nodes

Applied patches 1-5, thanks.
