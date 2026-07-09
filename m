Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5403D3326
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585217; cv=none; b=dIEfHKaQqbLkJVp0nHT16xoUbqhNLlkCNd3lEjey6D9wRKxPSX2hUsOLgLMXo/8gN6eiYhs8T8LicWavWl5npMUWxdtdcf5+VGe0KBvvMoG7M0oXwLDQEqpv6jO1F9Z2Z/YFnbkj94FK85tJOPFVkGPtE1msx/jGD0/Srhd0llE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585217; c=relaxed/simple;
	bh=VK5FHqQoqXsXssQzYiXc/2gv+OjHxjLV6l1qwpll0mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgabqxtJ3CEJS758o7XJrZlajRGJev/q/DzGATw1hAX5kaN3xL5EXHvBOVYi24Z7Tn5B274F547xYKblVNI3dldm8zfVPpoqv6dYq1oTOy5gW7pn2zmQw5ByUMDpfwVrZwJ43K4NR1eREVOudHSXI4ulsSK150sS7aTJZgPHtRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc500c39e96c98da8598f.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:c39e:96c9:8da8:598f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 978CE203855;
	Thu,  9 Jul 2026 10:20:14 +0200 (CEST)
Date: Thu, 9 Jul 2026 10:20:13 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: vasant.hegde@amd.com, suravee.suthikulpanit@amd.com, will@kernel.org, 
	robin.murphy@arm.com, thomas.lendacky@amd.com, aik@amd.com, jgg@nvidia.com, 
	kevin.tian@intel.com, xuyongwei@open-hieco.net, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iommu/amd: Fix and improve SB IOAPIC IVRS
 validation
Message-ID: <ak9ZqrAEP72aT8mR@8bytes.org>
References: <SI2PR01MB4393F989AF7FBFC94C304E61DCF52@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SI2PR01MB4393F989AF7FBFC94C304E61DCF52@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>

On Thu, Jul 02, 2026 at 10:40:17PM +0800, Wei Wang wrote:
> Wei Wang (3):
>   iommu/amd: Prevent SB IOAPIC from overriding IVRS validation errors
>   iommu/amd: Fix false positive in SB IOAPIC IVRS validation
>   iommu/amd: Dynamically verify Southbridge IOAPIC via PCI config space
> 
>  drivers/iommu/amd/init.c | 57 ++++++++++++++++++++++++++++++----------
>  1 file changed, 43 insertions(+), 14 deletions(-)

Applied, thanks.
