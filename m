Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFA04749D8
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249463; cv=none; b=m8/MeyizdQn00uUER8W/4uxRHS4j5Cd+gRFmjqpHjpY2N6whNPR9a/Tvo2iyfUEKeN3l4QOFIwplO9lBGGXy0uYsfWWNNKLdNIXH4Xwlxo/1ElKpOLCbMo74g/atwR4wu5fRY8ioY8rh9PRIs/8361974qjKYqV+evEPLErlNJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249463; c=relaxed/simple;
	bh=y7gO6VrsNdoGYZk5SUzW4j4AMEsUFVWDu8Dp4AtVumU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6o77hqa+mFPQgYuQcyYwpujNnhBJl7S25Be03XCECh/sqGIg299Agxn8TTx71IuJyu15osuVGrU5Ylj6HgiXFOZqT1HIQt0XWkwE+SmBxNi7kMm3mU6SgeZwphFmfjej4n5BGHANacWA8vJBOD1ACZwjxs86y/JmzNtGoNqxaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00e4ccc4fdbbd66590.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:e4cc:c4fd:bbd6:6590])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1421E1C7465;
	Thu, 24 Sep 2026 13:30:57 +0200 (CEST)
Date: Thu, 24 Sep 2026 13:30:55 +0200
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: Daniel Drake <dan@reactivated.net>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, nick.hollinghurst@raspberrypi.com, james.quinlan@broadcom.com, 
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v3 0/5] Add support for Broadcom BCM2712 IOMMU driver
 (Raspberry Pi 5)
Message-ID: <arUJxhEDFYSIUp4e@8bytes.org>
References: <20260825-bcm2712-iommu-submit-v3-0-7f143e7289b6@reactivated.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825-bcm2712-iommu-submit-v3-0-7f143e7289b6@reactivated.net>

On Tue, Aug 25, 2026 at 09:56:03PM +0100, Daniel Drake wrote:
> Daniel Drake (5):
>       iommu_pt: Fix test_pgsize_boundary() failure on narrow-OA formats
>       dt-bindings: iommu: Add Broadcom BCM2712 IOMMU
>       iommu/generic_pt: Add Broadcom BCM2712 page table format
>       iommu: Add Broadcom BCM2712 IOMMU driver
>       arm64: dts: broadcom: bcm2712: Add GPU IOMMU and IOMMU cache nodes

Applied, thanks.

Please submit a follow-on patch adding a MAINTAINERS entry for the new IOMMU
driver.
