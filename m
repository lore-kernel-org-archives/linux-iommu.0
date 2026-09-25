Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE44130D3FE
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 06:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790318060; cv=none; b=Mdg4HzJPUKyTE4cYz4lBRdQgsEjOLiUvtrHCppQeFNmZPZ/113/e9AHAf2MBt+j/UVbRJe3tgwTZU5ECwIknj2lq9t9iokYdwMlQYNjY3uKtuFnycObmpHwf+p03+Dj4C39fkqoAS55Zq+ECsEBWGBTfYDaDqPjNKuNr4LT8KTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790318060; c=relaxed/simple;
	bh=f5K8pebqcjgSOOJ25DGEUezzLNt2kwzZeU57MEeclTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOKbt/aWl4+USQP+XsjKFj7ymTZCWdtIYP/T9mdES6H/OsyIP8+B+JFDIZ+n0txykNokz3NlHwIfaqPO+juJUz7UyiR+wKnMkIeSCNXetlb3JVqT3aGAhqy29l4dHYww7FcVBP5N3KD6U+CipujAzEOa3UrTD2g6BtpLqoTBjrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a000b03c3c046b119f0.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:b03:c3c0:46b1:19f0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 62B4C1C7759;
	Fri, 25 Sep 2026 08:34:17 +0200 (CEST)
Date: Fri, 25 Sep 2026 08:34:16 +0200
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: Daniel Drake <dan@reactivated.net>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, nick.hollinghurst@raspberrypi.com, james.quinlan@broadcom.com, 
	Jason Gunthorpe <jgg@ziepe.ca>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v6 0/6] Add support for Broadcom BCM2712 IOMMU driver
 (Raspberry Pi 5)
Message-ID: <arYVR2QK4WPpTmTg@8bytes.org>
References: <20260924-bcm2712-iommu-submit-v6-0-7b3cace86973@reactivated.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924-bcm2712-iommu-submit-v6-0-7b3cace86973@reactivated.net>

On Thu, Sep 24, 2026 at 10:10:50PM +0100, Daniel Drake wrote:
> Daniel Drake (6):
>       iommu_pt: Fix test_pgsize_boundary() failure on narrow-OA formats
>       dt-bindings: iommu: Add Broadcom BCM2712 IOMMU
>       dt-bindings: display: brcm,bcm2835-hvs: Document iommus property
>       iommu/generic_pt: Add Broadcom BCM2712 page table format
>       iommu: Add Broadcom BCM2712 IOMMU driver
>       arm64: dts: broadcom: bcm2712: Add GPU IOMMU and IOMMU cache nodes

Something got lost along the way, I didn't receive patches 5 and 6. While patch
5 made it to lore at least, patch 6 is missing there as well.

Can you please investigate and resend the full series? As Florian requested I
will then apply only 1-5.

Thanks, 

	Joerg
