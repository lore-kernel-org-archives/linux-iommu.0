Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E271947A0C4;
	Thu, 24 Sep 2026 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249860; cv=none; b=NVcBJdGv58qgIy4BqM5YxuAKQNCaVA0+ImdUBx79+BPif4MCDy9t6J0Wrwc9NWB6/xTMRfv3RuofBxUSoTQVqtvytcn3jKg7t8j3P44BBKkqXShF90IIoOSu9XGvH5xUwLESNdcvN0EIwTBv8idulKWBlBmplY3/HAqtbnOQaPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249860; c=relaxed/simple;
	bh=2EznhBAf4tapLikwBNVBshdXp25sQtmOgYlIBY42W08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8g1GHb4+Kg1LH12IWahSwDeCmw3Udg/BxC2H9ylF9rQQxdXeEF3gPwoSUuu1khoI+4bkgMvcIWbbEjppTKCujiZG9lNQe2I7X9GLj//jiRqtm/UgTvpGiHy9lOtYh7W+oFMQuwUlyE7jtUlvy2RxQA0UwareSPrnQ4Umv+bwdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00e4ccc4fdbbd66590.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:e4cc:c4fd:bbd6:6590])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D53671C7465;
	Thu, 24 Sep 2026 13:37:32 +0200 (CEST)
Date: Thu, 24 Sep 2026 13:37:31 +0200
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v3 0/2] iommu: apple-dart: device specific DMA aperture
 support
Message-ID: <arULHr3O14OerdLR@8bytes.org>
References: <20260902-iommu-apple-dart-aperture-v3-0-252ce55b7001@jannau.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902-iommu-apple-dart-aperture-v3-0-252ce55b7001@jannau.net>

On Wed, Sep 02, 2026 at 09:18:53PM +0200, Janne Grunau wrote:
> Janne Grunau (2):
>       dt-bindings: iommu: dart: Support specifying the DMA aperture
>       iommu: apple-dart: Support specifying the DMA aperture in the DT

Missed that there is a v3, applied this instead.
