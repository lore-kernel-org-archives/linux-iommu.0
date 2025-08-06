Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C54E27470
	for <iommu@lists.linux.dev>; Wed,  6 Aug 2025 23:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754524733; cv=none; b=MZEJcH3+ADJKvOtSDv99xUsiDkJaNjf1qmGEqggtqcmSpiFhy+zB1B4HvjnhNeSBcFxA3GA5vKSG0eDq/SDz9ZrKU2YKTefZ62NA/tnF6CxvBs09BCXNNNN9k4aWHeVZK+fzwnJgeRi047NhBvpHd8KxUbT2dijdtOJkmfG8b3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754524733; c=relaxed/simple;
	bh=Ch3Lu3JNorrE3DqTb4s0lvqvQJV5+k082o5zzm77yE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmlNlbKM4XylxuavXKqK9+Q4+U55qs7HPSQ1LQk//5BJJB8nlVMqraBDEhXAUPzbhl2XoK4wdcfJYFlgsxx5/7i52Is/MCQalVG7O1bUBrF+d03ia0wKeA/erFpJFbOqz9iMalyVXG6f260ilgEelm8b7TSt1C0tINpdr4Cc1IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MH27oci2; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MH27oci2"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e809baeef7so54125285a.0
        for <iommu@lists.linux.dev>; Wed, 06 Aug 2025 16:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754524730; x=1755129530; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I4DgF6Vw8xGQncqmkZy1+xUkx+suIzKaCcwcVTdjpkA=;
        b=MH27oci2nJjyrPxMZoBx++UIIjvZjcXN591pFI4mCv0vumJ8zo9CY4GZZvnt8++Bt0
         brldMJZ8vFFmEpnD35dbhq7FUD1SsRA9CPy0Z/o4x38G+c+swFzuu/H30lsNaw2XqHzb
         XjqAKhjOulsOytsl+GIH1u1ucneKHUt2oN0M/fJZHwlf5aplJ0J2Wpb1BawBVUrCgCqM
         0zjeR4mJvxbUDii1p+ec4W7sUOs12HTiySstdxmjAS+ysmLLZXAwkt8td2q281PXtDaW
         mM0h+kH+newNYQ8i38K1g4oyiOt0KKwuAUDj9HldbQv7K6Za5qNIEcfVfX0uQlV5x5MM
         ktig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754524730; x=1755129530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4DgF6Vw8xGQncqmkZy1+xUkx+suIzKaCcwcVTdjpkA=;
        b=AfBzbGu/y8mwSf7LVBKsyiWV1KgGrEoQhFdb24OnwQ4PoCAlc23soiHiDBCTKSu0vo
         hB9tQZMndq7eoAELnX7Dem9/OMuGmZ3r1N4JZ1AQFmlnkaJL/1ffTpZN8xhyAsxo+be5
         +2OGtEEUWtlG1A+z4iidWyhou4ELTYOGVwCAJLo+lrbU3m00gGNq2Z6FGGLLlfSMun3+
         Pd9zjTes84Rpn7xHH5l0a3LELsckUEc9HRgiLpbV1QhSrlF6kKRqcBnfnDsl6fD0jAF6
         3nQCHN/unEQwML+szjlqdTu39P1IQ1moioZ1babHewVo9UdY20Glqc0+Cu3fzek0xF1k
         nbUg==
X-Gm-Message-State: AOJu0YyzcvJk/2RepLwbml0UFjq1t0BUwxquJ/BUsSC8xRZMFehCaaZN
	W976P8j8gn6QrDK5NYWhXn2gIt127hMcDD0+Fuklqqc8NUFlBf7JlWiQBtBtgjWLWMg=
X-Gm-Gg: ASbGncv5yL9BT4Texio7Rihlu1MGtaWymy0IpF8Vd7aJqjVJ7YrjnZ4R+E1U6uGBN+2
	7l9Sqw2LXYwNT4a/OR3kg64u+gQ0EQuDALLQhgXBHtaFKdX2jIUCXZ736io7ek1+S7oSscO1WDX
	M2y78KYlfbHBhZrxWIbsFC6UmuHYL3ObHkpgBtpHiavp2ay3Ir7VbeMiNTEpXeA7thj8nZoNtTM
	pQiwiOOwU2jUn+gKyCJdgy3T3xsqaKzh6TdJr16Et+2x9S5T3l0Sn/fKvpmoQg1bDhj3iOWbUYZ
	zLpn6+HzFPAXbPhgGvzJHtLWKhTUAlxbDrPmLdAhiOVgSb5Cq/er/dWqjtdwIlj0VXoKOR+zpeL
	q8KAY1nLJBIrgGDDf4tZNER1+0GZ2VwwL4dsDMgugsL4W2560/759uh7Kui0tyY4bGK4+
X-Google-Smtp-Source: AGHT+IGnS032BQYfbSfwSqYTvKso8Ea62PyX+fE1vpQVHfXPFL26cVNK4i9ZyLJUzr/PgtuVEArJEg==
X-Received: by 2002:a05:620a:4045:b0:7e6:97a2:ea7d with SMTP id af79cd13be357-7e81677da93mr625181985a.62.1754524729857;
        Wed, 06 Aug 2025 16:58:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e80b869d4bsm310283985a.24.2025.08.06.16.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 16:58:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ujo1w-00000001sk1-2RDU;
	Wed, 06 Aug 2025 20:58:48 -0300
Date: Wed, 6 Aug 2025 20:58:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, virtualization@lists.linux.dev,
	will@kernel.org, jacob.pan@linux.microsoft.com,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com,
	bboscaccy@linux.microsoft.com
Subject: Re: [PATCH v3 3/3] arm-smmu: select suitable MSI IOVA
Message-ID: <20250806235848.GD377696@ziepe.ca>
References: <20250806215539.1240561-1-shyamsaini@linux.microsoft.com>
 <20250806215539.1240561-4-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806215539.1240561-4-shyamsaini@linux.microsoft.com>

On Wed, Aug 06, 2025 at 02:55:39PM -0700, Shyam Saini wrote:
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3642,17 +3642,30 @@ static int arm_smmu_of_xlate(struct device *dev,
>  static void arm_smmu_get_resv_regions(struct device *dev,
>  				      struct list_head *head)
>  {
> -	struct iommu_resv_region *region;
>  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>  
> -	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> -					 prot, IOMMU_RESV_SW_MSI, GFP_KERNEL);
> -	if (!region)
> -		return;
> -
> -	list_add_tail(&region->list, head);
> +	static const u64 msi_bases[] = { MSI_IOVA_BASE, MSI_IOVA_BASE2 };
>  
>  	iommu_dma_get_resv_regions(dev, head);
> +
> +	/*
> +	 * Use the first msi_base that does not intersect with a platform
> +	 * reserved region. The SW MSI base selection is entirely arbitrary.
> +	 */
> +	for (int i = 0; i != ARRAY_SIZE(msi_bases); i++) {
> +		struct iommu_resv_region *region;
> +
> +		if (resv_region_intersects(msi_bases[i], MSI_IOVA_LENGTH, head))
> +			continue;
> +
> +		region = iommu_alloc_resv_region(msi_bases[i], MSI_IOVA_LENGTH, prot,
> +						 IOMMU_RESV_SW_MSI, GFP_KERNEL);
> +		if (!region)
> +			return;
> +
> +		list_add_tail(&region->list, head);
> +		return;
> +	}
>  }

I think this whole series looks pretty good, but I would suggest to
put this in a helper..

'iommu_set_sw_msi()' perhaps, must be called after iommu_dma_get_resv_regions()

Then maybe the constants can just be placed in the .c file inside the
helper function.

Jsaon
