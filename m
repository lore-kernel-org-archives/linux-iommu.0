Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B3E368275
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984313; cv=none; b=goEBQN/nKSW6RTxYBRxWH6gVy+ZICnRIElxZFPMU6A4Lffwo1hjFvIWpJ52ESurwesOH3Amgk4q2egZNxAsoBhfVbeTq/IhXxiA8CeJRI5sde8gOCwh3X/oGLxj60ab46LtSsHTniforpe31SYs6TRJUGSRwgR/01hGJ8HbF11o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984313; c=relaxed/simple;
	bh=Yh35ooV5k2ic+R5vE8oeNjphhYaG5GuCEktYzyHuivU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQFogOYR7Q3U/QevOuHk6hsul5pDnu6Tt4esdgc/Ij3IYjmgbkN97T6cQxXyeBly498WzFj76SvDi4R+W8W/F/E29HefqJiifokFn+0uef06CHCWx27MbGRD6JMdGBGrYk9QrJOpt+57lv9rivmCA6SLpVDhloRIy7/64OJIDgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ABHFGqmi; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ABHFGqmi"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8d4f78fc9f6so775550185a.3
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 15:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776984310; x=1777589110; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VHs1SB6C6q+VxGSLs4PEu15EKKlh8msoZuhCPbHV/WQ=;
        b=ABHFGqmiqeTjZPx+N5frAjYe4txgVL6E+22cya7nBoCndQ2413aX9efDk1vRuOrdbn
         9MQCigFClWrBsjr9RCTUGqyqS2R46vDbiAT5o6G+HTiyKPOvArdCyEceKADJJFOWAZLC
         MWSwVo9iRZ//RCNHV6hx16t0SdvjdIFX1cm2WpvIzsWj6mOPxGj8nC+1RQM5K/8hh5wK
         XyR3ngSCUpBMIVoWon447ClaP6KjrU2aDybBF5hv55gUgE2QEnIeuKBQDiGUHgIfDS7p
         FvlVLltrv+Wy1LfQmONXdC9nUDDnFGTlYrvRuNsGYSdY2xQTEUZEkhN4PiAxuOQQZQRS
         SNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776984310; x=1777589110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHs1SB6C6q+VxGSLs4PEu15EKKlh8msoZuhCPbHV/WQ=;
        b=rwZHmmxcqJzKsnj8wAaQ71KaqaQUwRooFPNzpsj8GPuNgE4hGDMvGGUBPuyWrfheAw
         wyW6e5/d4Ocn0xY+E/YElF/8o5u5KSfhsqYcccL7TarqwICl9PIGIyKD6l+3t8bOdmwG
         vKsig8khzZm86JSX/Kk+Pn3CdHxOF3IrGlGpH3h9N6ciE+YrYqWIyBrM0vE595wSeasf
         5Q+qWdJBx1wYq3MfkLN65Wz4/iWtnNn8/URVwEeBwzxD6msV8W/VgWBmIkIG5h0PpcPM
         sGCQ1bc+jRNM/xV1aWf98G8HlY3rRmiVJaXhPVUbo7ZQPvaX1uvFXJPVbJ+zvFbOymbV
         Wrzg==
X-Forwarded-Encrypted: i=1; AFNElJ8NhKBYc8pROFvu2bfuJyaF/3Mtp3fIau2cAlCnCMTafKH7RP7d9UWGGuvnpHqO+27AH9fMNw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCGoq/WpnFbroL+1XgMmds5rzZ9CHzD13ieU/9cyxrGP3nPMxW
	782C/oK/S0YGwHXRWx8Kg/NKGIZrf/xuR68e9xX6H1SU9EDO5AZicPETO3DoRM71GBs=
X-Gm-Gg: AeBDieue6ZpVcW7qFkAN5LkLZcUtzTaLKITGEstEgoA6KXuGo2bKG1wpeHG29efon8Y
	q302xGJy++2IwqIzaNiAWeG82MtYM+BNgNQ/BdVWuKOITg6b7yOlXGfqry7j8TJP/cSzI8V/BLU
	X2iXY+xjU7biZ5COg7oSxwXY6bVvwzKjdRCHkrgSIokj1l8k5NB9YvL9k7OoR27tW6IEE2XtkFz
	BPhd+ANY7ZvJPcSB1lzYl/TZmaXtZP6gIKW3k7a4u7KfemuafmsvOdMg4qpwVQGiRtw7HEYSXWj
	ZyiO+TUd7z6ycJE/e659aKykq757ASmg1FpK1e8GGEIpx829chKJG6LEY5mvCe7vGNWqbLni8iS
	jer8w5K6ad5KhT4foJt/g7V0AhNpTD6h0V2puZLlAMWF4mGYk4FtOJ5Xsq0OCZSP1GZ6SdHlHhj
	Lzc7vJhwvmJVn1vV33yVJ+OJxSIBAlC97pFp71Mkm60pooWfKTDPIat5I/dlrqHeUhdDrS2SsBV
	m2EvD8VeuCvAEr1
X-Received: by 2002:a05:620a:4554:b0:8ee:2c17:2ff3 with SMTP id af79cd13be357-8ee2c1733c4mr2169354085a.0.1776984309768;
        Thu, 23 Apr 2026 15:45:09 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8eb9becc72dsm1271207885a.34.2026.04.23.15.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 15:45:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wG2nE-0000000GLqe-155A;
	Thu, 23 Apr 2026 19:45:08 -0300
Date: Thu, 23 Apr 2026 19:45:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: rafael@kernel.org, lenb@kernel.org, saket.dumbre@intel.com,
	lpieralisi@kernel.org, guohanjun@huawei.com,
	sudeep.holla@kernel.org, will@kernel.org, catalin.marinas@arm.com,
	joro@8bytes.org, robin.murphy@arm.com, nicolinc@nvidia.com,
	praan@google.com, vsethi@nvidia.com, sdonthineni@nvidia.com,
	kthota@nvidia.com, sagar.tv@gmail.com, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, acpica-devel@lists.linux.dev,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 3/3] iommu/arm-smmu-v3: Honor IORT Root Complex PASID
 descriptors
Message-ID: <20260423224508.GU3611611@ziepe.ca>
References: <20260423191417.2031652-1-vidyas@nvidia.com>
 <20260423191417.2031652-4-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423191417.2031652-4-vidyas@nvidia.com>

On Fri, Apr 24, 2026 at 12:44:17AM +0530, Vidya Sagar wrote:
> The SMMUv3 driver currently calls pci_enable_pasid() for any PCI
> master that exposes a PASID capability, regardless of whether the
> upstream Root Complex actually supports PASID and regardless of the
> RC's declared Max PASID Width. With IORT spec E.c (RC node revision
> >= 4) firmware reports both, so we can do better:
> 
>   - If the IORT Root Complex node says PASID is not supported
>     (Flags bit 0 == 0 at byte offset 36), enabling PASID on the
>     endpoint is futile - the RC will not forward the PASID prefix to
>     the SMMU - so skip pci_enable_pasid() silently.
> 
>   - If the IORT Root Complex node reports a Max PASID Width (bits[4:0]
>     of PASID Capabilities at offset 33), clamp the endpoint's
>     pci_max_pasids() result by 1 << width before computing the SMMU
>     SSID width. This prevents master->ssid_bits from exceeding what
>     the RC can actually carry.
> 
> Both behaviours are gated on iort_pci_rc_pasid_max_width_known(), i.e.
> RC node revision >= 4, so platforms with older IORT firmware see no
> behavioural change and continue to enable PASID purely on the basis
> of the endpoint capability.
> 
> Use the new IOMMU_FWSPEC_PCI_RC_PASID fwspec flag (set by IORT) for
> the support check, and call iort_pci_rc_pasid_max_width_for_dev() for
> the width clamp; both pieces are wired up in
> iort_iommu_configure_id() by the previous patch.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 26 ++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index e8d7dbe495f0..2b269307fd33 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3071,16 +3071,28 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
>  
>  static int arm_smmu_enable_pasid(struct arm_smmu_master *master)
>  {
> -	int ret;
> -	int features;
> -	int num_pasids;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
>  	struct pci_dev *pdev;
> +	int features, num_pasids, ret, rc_width;

Don't reformat the code like this.

Otherwise the series broadly makes sense to me

Jason
