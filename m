Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129853AEF4A
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383485; cv=none; b=iXCW5aIgK1km+4P4jpvU5kZ/8AdoQ75NkSonKFTxq2uMMurRWMCUjI16jQBKyOGMp39ph3rT21Amd1BoCW97ZXrcS2d/nWPbLFw67+dT8k0hCptTYwwpL/0yCq/NBxBryL9SQ2kmJLpA+zzHkkSTzmeBiolIU2xZTjXULZpXZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383485; c=relaxed/simple;
	bh=fZyMs6ThguauJIy48ic57lQ7RORMc9Mh6i8joTX9Hr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSJB7I3S5WMkm0dVZOOCNSeBC7feQo91qXGqPtdVh0w6SNyPPhmG5iZnGu1oT1YdM3JCV5pXd714UYACypyWYmEnPzHilIwr6sItmDYmlbmn3Z0J/gXN/X2gTRVZEBF1PWd8DZR/V+xG26HIvbL6Zse5ddGMP5le/wZlAn/W0ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Z824oqYB; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Z824oqYB"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8dbbc6c16b2so1442441385a.0
        for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 06:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777383482; x=1777988282; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WHmUngA0Beg9PMjrunFUFdxSHW2GXtc2kWTAdD0BnF4=;
        b=Z824oqYBkpbVAQrWaTElChuclF4khrbHjgt1sbW8fwwt5MYXrb//aLkHr0PFiRFOjr
         X1Bz+MvWoeNSFgnSGGBp5BJ0M9yuL3YZ/8xWPae7LV/rYojtAxH16Us+WayYZo8MyLVv
         XRRtIHGJTx46V5wdtYNKFwHdSRr6wRGUAb4nV00xj2NL80iY32CtrDGZrp5KOYyfgLXL
         UeOFhpRmKJj+vW23+Mqu3SyNfd4DziLKWcoX7i+XrhLCRaqe8mcuEnI4MhfkGg0STp8Q
         WKn5s37JHuFuXTOHPt8mmmNSI3QDQ9nHBjnZfHyUZL+GvpUbWuFdX0er/iS71Ch/pKdj
         HygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777383482; x=1777988282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHmUngA0Beg9PMjrunFUFdxSHW2GXtc2kWTAdD0BnF4=;
        b=EnL/VqtEjmpcM6kkXQIWyl9vhziugvu5/iHn8aQEvIc6x74qHw58ieXNuQ5LUlzdg9
         bXHRnkBHXga9NeUlkifgUrHb6b6g7pp/Y/wpCigxnXMll1+MeLyCGGNSrC3dQtSY+/t6
         8ixuC0NYEB+u4u8Vr2kY1FYVP8GFWEZOpz+NQfnZJz8EiuxZqzkTn+WML1ijdevh4HXq
         GFdMPoz4tk3xPmuaTmY7O/Y3eWObRLZagolpSveVQVSqF7K7xVWZXsqfBqKvM6MHEOsK
         nfEXSiKH16wvvrv9M4S38yCo7PBfN4X5Pa6Jae9hjM4zYFP3X3GEMICRJDjsc666t6Oi
         j07w==
X-Forwarded-Encrypted: i=1; AFNElJ/sDkT80W3rTQvucdSecYy2priHtilJXTIycoi3mLIKe5Te5IeP3vIiMdo0BipveP3VOT8mTw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx61SR1N0zr3HMWQz4WYnwNhPYT+bAi8IZNaiFnL+iqMHc7V8g/
	t8/OBKwkdQCCjOSB7uCnkeewnHEPMG7WTZGwp8dzq9FB/dZNznuMckLVRgBksYrVV2s=
X-Gm-Gg: AeBDieuO7HSbCmVdOw03IJCLP3esxZWQzZWNMDUHyyaptL+BuxbtHPlLYqaOJWkJ8ig
	J8hBfLpPWR/HLo9jBJtJUNEqKuoljHpQ6iCmSinUE82D8vprhgzB4i467rG3oRS+kRU9qtxBffN
	59RKznHJgfEhbmP4OMOQ7RZWuEnbjBwk+TaIio8hiMarVgPsNA45DePYRXSXWYuSMCe+lD3XQja
	N+FBOcclpBbIhkJ6k5054rPeLtnPjOlcabhgc9Rf9PP1WraQ8iiiQ8783/4s7XoTW0VWPns4mtA
	vqqL9IZJKThOIhD4+KBFNgXnutMxJrDbGKSEFe9O4xDf1P3OIfREtN0uRrNoVT8/tFf7VWUNbKA
	ql1A4z574O8fqPHH8BboEIoLDoG1jvPWEvYI3ZeS5Df4AzjxgHmnAJM1U9H2Ip463r/Z34NBjkN
	aPLwfsPvemXM8Juc8HEWthhJ5mippExV/04TrZI8A3ZOF3jB1DW/CbhgBp62/jCu6NPvIADJap/
	z7CBGe+OFowgCpc
X-Received: by 2002:a05:620a:178c:b0:8cd:aa61:ad8f with SMTP id af79cd13be357-8f7d5d6dc38mr357079385a.14.1777383481817;
        Tue, 28 Apr 2026 06:38:01 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c4dbcfbdsm203538685a.12.2026.04.28.06.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:38:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHidU-0000000Aj1L-1JSZ;
	Tue, 28 Apr 2026 10:38:00 -0300
Date: Tue, 28 Apr 2026 10:38:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	tjeznach@rivosinc.com, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, vasant.hegde@amd.com, anup@brainfault.org,
	atish.patra@linux.dev, skhawaja@google.com, guoren@kernel.org,
	kvm@vger.kernel.org, iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 08/11] iommu/riscv: Add dirty tracking support for
 second-stage domains
Message-ID: <20260428133800.GG849557@ziepe.ca>
References: <20260428131359.34872-1-fangyu.yu@linux.alibaba.com>
 <20260428131359.34872-9-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428131359.34872-9-fangyu.yu@linux.alibaba.com>

On Tue, Apr 28, 2026 at 09:13:56PM +0800, fangyu.yu@linux.alibaba.com wrote:

> @@ -1247,6 +1247,84 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>  	return 0;
>  }
>  
> +/*
> + * Enable or disable hardware A/D bit updates (GADE) in the device context for
> + * all devices attached to a second-stage domain. When dirty tracking is
> + * enabled the IOMMU hardware will set the dirty bit in PTEs on write access,
> + * making them visible to read_and_clear_dirty().
> + */
> +static int riscv_iommu_set_dirty_tracking(struct iommu_domain *iommu_domain,
> +					  bool enable)
> +{
> +	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
> +	struct riscv_iommu_bond *bond;
> +	struct riscv_iommu_device *iommu, *prev;
> +	struct riscv_iommu_dc *dc;
> +	struct iommu_fwspec *fwspec;
> +	struct riscv_iommu_command cmd;
> +	u64 tc;
> +	int i;
> +
> +	rcu_read_lock();
> +
> +	list_for_each_entry_rcu(bond, &domain->bonds, list) {
> +		iommu = dev_to_iommu(bond->dev);
> +		fwspec = dev_iommu_fwspec_get(bond->dev);
> +
> +		for (i = 0; i < fwspec->num_ids; i++) {
> +			dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
> +			tc = READ_ONCE(dc->tc);
> +			if (!(tc & RISCV_IOMMU_DC_TC_V))
> +				continue;
> +
> +			if (enable)
> +				tc |= RISCV_IOMMU_DC_TC_GADE;
> +			else
> +				tc &= ~RISCV_IOMMU_DC_TC_GADE;
> +			WRITE_ONCE(dc->tc, tc);

I'm pretty sure you don't need to do this. Just preset GADE when ever
a S2 domain is attached, rely on the pre-set D to avoid any HW cost
and you are fine. No need to change it dynamically unless something is
reall weird about riscv.

Jason
