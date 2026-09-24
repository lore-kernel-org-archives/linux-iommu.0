Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F0F3A9DB2;
	Thu, 24 Sep 2026 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249691; cv=none; b=bTAL8SijlTDTgnu8JIQXVdxiksb2//pA5WHEygtSUMgidCt0KCfOBvRo1axQCsCExLOtOOYbQTyW7pTLkNFDAAgbCdqxe4t3kFDEnSjDOopqa1bd580GxZynner2hLMRNR4W1LVPLw1M6Orvu5VcxwHkBEv4YNqAkIb+2psgCT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249691; c=relaxed/simple;
	bh=M8sNdMh/EqenIIhXjyG9d0brtDAAkF8CJ0vp9zjfgMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maJZ24hEplPHhl8NpvrnaXgCEp/EY7FhW16VmJw0/+20DYRPVZ7hWDWrYo/WOSJNvW4P0YnQn/h4vGa5CVfIUokI5ZQyhkzSCxRR+fcelJYlE0p8y7hRXDJgVldinj6z2WjujSo/NaB4sDO2W9PSCEUvWN+qSDRxtrCJ03dGB30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00e4ccc4fdbbd66590.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:e4cc:c4fd:bbd6:6590])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 18CCD1C7465;
	Thu, 24 Sep 2026 13:34:42 +0200 (CEST)
Date: Thu, 24 Sep 2026 13:34:40 +0200
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 0/2] iommu: apple-dart: device specific DMA aperture
 support
Message-ID: <arUKwubaodZVrf29@8bytes.org>
References: <20260831-iommu-apple-dart-aperture-v2-0-d16ce3770299@jannau.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831-iommu-apple-dart-aperture-v2-0-d16ce3770299@jannau.net>

On Mon, Aug 31, 2026 at 03:46:07PM +0200, Janne Grunau wrote:
> Janne Grunau (2):
>       dt-bindings: iommu: dart: Support specifying the DMA aperture
>       iommu: apple-dart: Support specifying the DMA aperture in the DT

Applied, thanks.

