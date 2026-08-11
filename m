Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEBB3ABD98
	for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 07:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786431867; cv=none; b=GBKdRL9hhuR8/XEk68520V+QXf6orV5nhz1KInQFb1j06Q927rOqHCYV/joiuo2LraADfYr4MWKI6I5e+3ON8sP0olKfOB7MYBUw0X5m/AGl1FVzh+OuEfxVDQayi7zDLeOoDRO6QLJ6bhivxz6d2mLee5LZ15W82VScfxC2UHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786431867; c=relaxed/simple;
	bh=2FfAmRSp9yAOuElA1VAzfRLwZR3VfiQfRymJ9tBFfds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0a2+g8FSZzwDutpF3o80ToHqqNLVBw3LoRYKuf94y8bELYPi35yUs9FOGrXcRx1MB56sz3wqkNaE67d80rRPrNVX/IonZKkw5xk4hmCiuThnAWUJ0d8X2neEnESAVsnducTUD3LcDzw6nmh5kxog3fFPfLgIkND5yJHF0hfwVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 25FA12077CC;
	Tue, 11 Aug 2026 09:04:24 +0200 (CEST)
Date: Tue, 11 Aug 2026 09:04:23 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com, 
	suravee.suthikulpanit@amd.com, Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
Subject: Re: [PATCH v2] iommu/amd: Add SNP page mode 0 support
Message-ID: <anrJZElMhC1Z5eD-@8bytes.org>
References: <20260811052257.9247-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811052257.9247-1-vasant.hegde@amd.com>

On Tue, Aug 11, 2026 at 05:22:57AM +0000, Vasant Hegde wrote:
> Joerg,
>   I have rebased this on top of amd/amd-vi branch and it should apply
>   cleanly.
> 
>   Sorry. I missed to include this one along with PRI series. I think
>   think one is ready. Can you please pick this up for 7.3

All good, this now applied as well.
