Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6292630FF30
	for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568222; cv=none; b=sBUrln/SJhUVSN5qnQIkUHKOAfYd+GZ6je4yq67ou0lIBTyY5ztRgykqnuc6htWYXV18Aszsvw15DjZzsAJyIiGUc1JkeRgol7de633TvtasoyS1mKgXVx9EQB0+49jz3+Ibhhy+sWM6HgUin+yEYR5Fd5vWm0hNEMH0Vgkj0XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568222; c=relaxed/simple;
	bh=eLQyIPcXagOHVeJ7T1QmYxtkY/1LoZO7/OV1+Imxg8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8vtMCrtwVBQJpn3HsrWCFpk9zt90X9nI29PbQpHxgKJrJy6+UE+HYTP4xy4LdaGMKEnDaC52SGjXRI9BQ1tW2+aquZaMSk8L2j3zfIDSklJKFN4s23HigTCzkHWCCJ6Du3/Z3/2B8pmdP6/mmhTOA45MRPt2hXdvAzBT5gumrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=1ttVBZ8w; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="1ttVBZ8w"
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1C44D59903;
	Mon, 27 Oct 2025 13:30:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1761568219;
	bh=eLQyIPcXagOHVeJ7T1QmYxtkY/1LoZO7/OV1+Imxg8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1ttVBZ8wgoNk7NvrIGfQdHOZsqEKmSTndxKtmT77RzDVNjRxqaplshCssnkK18Flj
	 4smnQLV/5ZGJIMnuxxeTzhp3SsrvMyriOF93Po6HtmGqw3wMncobqQoL4Au3v1Hsrn
	 w8LkIimq7DSUO+BskpRwvhbkXwLmak20NrRMsQ+dKjomr5F3/tySafzxT5yHKYXEsz
	 62j49uZkWG4lqHn2jsF2jy6p1ecjGfQqwmH3Q1UZvLsRDt9ziDogOKoIEPIhBXyYF4
	 DKf6BjMFeio5S6RSNmRDUd5zF9GBUkEP30yCqNzEO/ucNpDXnH0MxQemz/YqIMPf5a
	 1AWESwoGwE1Zw==
Date: Mon, 27 Oct 2025 13:30:17 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: suravee.suthikulpanit@amd.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/amd: Enable PCIe ACS only if AMD IOMMU is on
Message-ID: <3agjkv6s4zk6y4ir7ix7bnqeoxl6i63hcwwksh6dews3wg7v3h@wm2nopcqv6yo>
References: <20251011031448.2699-1-guojinhui.liam@bytedance.com>
 <20251011031448.2699-2-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011031448.2699-2-guojinhui.liam@bytedance.com>

On Sat, Oct 11, 2025 at 11:14:48AM +0800, Jinhui Guo wrote:
> To preserve PCIe performance, ACS is enabled only when
> AMD IOMMU is not disabled.
> 
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/init.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index f2991c11867c..38e8c38c5f10 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3314,8 +3314,10 @@ static bool __init detect_ivrs(void)
>  	}
>  
>  out:
> -	/* Make sure ACS will be enabled during PCI probe */
> -	pci_request_acs();
> +	if (!amd_iommu_disabled) {
> +		/* Make sure ACS will be enabled during PCI probe */
> +		pci_request_acs();
> +	}

Instead of checking amd_iommu_disabled here it is better to move the
pci_request_acs() call to early_amd_iommu_init(). This function is only called
when amd_iommu_disabled is false and runs still before PCI probing.

Regards,

	Joerg
