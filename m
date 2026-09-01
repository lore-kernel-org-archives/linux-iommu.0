Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092424A4401;
	Tue,  1 Sep 2026 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788295559; cv=none; b=OkxdVkAmw1eoYcWKKtwb3LAD9smHEMxQrWLqmZL/gZ3JMAxN5CYg+tRDhtnSCmazXp20HoQt87mHoo+hvJ/uMS1q9NDJKkeJD+xwlhks/IxGcMharD3uDTpbAdW3b8Z05+ptqnBBFHF7v9bic7agAzKwcjQP7floD/YBN3mUtZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788295559; c=relaxed/simple;
	bh=zRMEa5c5ui2nn0EcJvJsdjakYRKPPxlzAFWBj5ZyHAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HePgH5Lic5UiekhD8qoBJkhg2gtKuDB19vCRx7U/0OHUoKcsTJ9PAGM7PMOvESCqVw6B3a+ZV+CN3o1WY6e5rSp9MGlWAnvVbpZ6jsmUQescsjwdn0QBfTsk1ok6OkHkMnASXDnAPnKUP8KEtDRNQUjiRPslFxkhvFKnoTYY4wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7BEi9MF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7BEi9MF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FFE1F000E9;
	Tue,  1 Sep 2026 20:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788295557;
	bh=zRMEa5c5ui2nn0EcJvJsdjakYRKPPxlzAFWBj5ZyHAM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=l7BEi9MFmuTupEv7HxYHW0JJUAGv2eP4grXl8QE/a1dhT/y6E2jk44LxtzEFdf89b
	 XZhPCV1uzTE3KgMlUY9GsTHYkqavoQlXuy5YW3mjL3O8UmVV4EB1tgIUyhOZc3GLgE
	 R+JDBdW5sDkZ8Xx2BXlTc7F1EwEE9vCva+mRwJMx4bg6DciEXnWQ1l81a7doZ40czx
	 PpIw7GkdBCNtU2vlAEa1kQBRfBDiVPxNRPEefF3ea/V2G4Fg2R5Us1XZwMJENcJT6U
	 z1TogSnBYLl8SJbL1lZxPQdSNGWnvBj1CPS7veVxM13tvOG4WPMbiNJzSAvTyDk/o+
	 ORBqadjH1u+oQ==
Message-ID: <2b95fa20-22a5-4ef2-9ea6-c6fb7d1f16ac@kernel.org>
Date: Tue, 1 Sep 2026 22:45:52 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iommu: apple-dart: Support specifying the DMA
 aperture in the DT
To: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
References: <20260831-iommu-apple-dart-aperture-v2-0-d16ce3770299@jannau.net>
 <20260831-iommu-apple-dart-aperture-v2-2-d16ce3770299@jannau.net>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20260831-iommu-apple-dart-aperture-v2-2-d16ce3770299@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 8/31/26 15:46, Janne Grunau wrote:
> Apple DARTs are often connected directly to devices that expect only a
> portion of their address space to be used for DMA (for example, because
> other ranges are mapped directly to something else). Devices can specify
> the start and end of the aperture via "iommus" args if the DART device
> node specifies "#iommu-cells = <5>. Aperture start and length are 64-bit
> values as apertures above and larger than 4GB are used.
> Limit compile testing to 64-bit architectures to avoid warnings in the
> calculation of 64-bit dma_addr_t values.

I don't see any Kconfig hunk below, did you drop it by accident?
Otherwise:

Reviewed-by: Sven Peter <sven@kernel.org>


Sven


