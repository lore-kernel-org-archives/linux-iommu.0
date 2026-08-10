Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103DF37C0F6
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348256; cv=none; b=GNIFU6fWoOA5hIF2ddDvBMepC71OezyhbUxAG1ubEdk++W/c0CQJ7PSu/kYH/r1hI97ysj5pY44/+cQHvd45pgnZAvxx4WjewA7tuCQlt41IBIrIPlGXdOgNGd8Q4z2vPrt61c9h6HmGtrNrad9q8ToSDfcP5VatvXEP86VBSH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348256; c=relaxed/simple;
	bh=Kj2FuAJ/hTODDGs7mC3/AsDcJuQ1lZdlBEs6xQ0j6Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bj79yEfrMpr/lu41e9ZipD/Df2YwpkEgPJB/cWo2a8Fnz1HwACzpcRNBodmfBJrpVvzxuwO159Ge9PABOpa6HoMEM3CKLAdhS1lea8iY9scNDpIvLDkJCk+ab3R6DGonwBLbY0xe7Y2Srf3V7Zr1zymzZyzr6xcwUWZScGwInNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 91A0F206A2E;
	Mon, 10 Aug 2026 09:50:47 +0200 (CEST)
Date: Mon, 10 Aug 2026 09:50:46 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com, 
	suravee.suthikulpanit@amd.com, Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
Subject: Re: [PATCH] iommu/amd: Add SNP page mode 0 support
Message-ID: <anmCl1aePQO3xZhz@8bytes.org>
References: <20260723084332.11008-1-vasant.hegde@amd.com>
 <d7ba7ef4-cea1-4a2e-84ba-a0fb85af2824@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7ba7ef4-cea1-4a2e-84ba-a0fb85af2824@amd.com>

Hi Vasant,

On Thu, Jul 23, 2026 at 02:16:37PM +0530, Vasant Hegde wrote:
> Missed to mention. This patch applies on top of
> 
> https://lore.kernel.org/linux-iommu/20260723061548.10187-1-vasant.hegde@amd.com/T/#t

Please include this into the repost of the above patch-set and base the series
on the amd/amd-vi branch.

Thanks,

	Joerg
