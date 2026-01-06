Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A6C230270
	for <iommu@lists.linux.dev>; Tue,  6 Jan 2026 01:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767662200; cv=none; b=HEvlHDrIXw/H0NbJ5OVXRpvKC19WtlGHSk/ATtydl8M6AIhACcUjdO/Rp5vMqrieN6iDnkb9wfvK3jrbKZz1oPPvoGnm68m9ITG7/b0+eKOxqrq2E8+4Okj8KMkVVEayKZCBxs5iiBWPnZn92tb/fvpWYqp8dmar/PIUlerEwrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767662200; c=relaxed/simple;
	bh=7atvEQB/W0MrWZ5oi5VEvWdIg99MP03MI5kWg9yZPQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psvw/3Pf8TblRjOrUWu09qKOfdH9zcy/vdOLnNlkdoV0/o+//xUPAP0bkR/9+rxbEvrkzR84IqrvtZ7ExK0at4DVK1PFJr0XGZitvEvkGcADJ25yBfWbRWKgKPo/WVjAwcY54ffiOIE561BCVSHX9a1WPSKMf1KTGSdv1/H1J5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=B6ZpUxMB; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="B6ZpUxMB"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88a367a1db0so6346676d6.3
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 17:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767662198; x=1768266998; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zwYvEJe49Eyq1mhCz3eanRMP0U05DubkNVlbpgrK6QM=;
        b=B6ZpUxMBEzYGcz3IkupYqEmNIAsPHTkLsdGdBQKvW7g1H+gA7QdBTV0r3RfjL+ggER
         1v2DN6OPr+tcix2SrI9AEePt7kWlTO/jiq57pSVlTDN6QfyJlNMe1uyfzlKlprD+kCAt
         ILTuM7IOYqlGRA2tzuUPrDfvg0Q2Q7yOHJrLE5tT87ABuPwQ8cym5ZK9RP6lXjaNvGa+
         Bh5WPfhGJ2JTtXAs+wpX7cfMrqALXP70IN29onu9/DxxIx9qUpMZSe/g7tx0JghTbLBN
         ie+vUpIKEH97LnOByiynjq0KQaix8esmTUGBgISSGqowh+cZctTVQgOrLqoO9eAQd+Ra
         XXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767662198; x=1768266998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwYvEJe49Eyq1mhCz3eanRMP0U05DubkNVlbpgrK6QM=;
        b=hEuAWRvdo+LhPeToZVWapKUM0wdAO3aZ9cJRQrQJeV+hNRxIMDQVkZblrZ0B14g0N9
         5lr7mMT3SHmF+9UhlQI9QNij7dP13oc/A45rXoExytlTrd+eoN/TsUrfIw722HaxIwHN
         UHVhz4fknVQsyjYfAs1gUFXK963ZnPISnhQt85RuQs3mc5YvpZZ92VGhV0ow9BW0QYW4
         1P5ZNXocEmVkUnWt3k/COgAajSoOHy2OA+/Mm1OLLJAeGZ1tu6sOJF9r47RuRDR4pfIV
         rbPfVzFNpcB+UJcNh+GrXfbJV5TfUnn2yPob7ddflTXstGK7jiFmxQ+PD6qvX73Tyqz2
         FUkA==
X-Forwarded-Encrypted: i=1; AJvYcCXVNPwUteWjiw+eKfIXMlqpf6pypTvAw6JrUT5flEFTPkmHDRIFjCHWhEZrIN9b9Ybh/tE1zA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyK/5s9WS/wHLm931wzFx9fuHoK/s0eHUBaPThCTCxcGnfmqVJf
	SZqT2ZGUJj6QB+FhYnAQyQYVLSR4dl9wioBnPtT9ENlvjAwZ6ixrVBLMsV6tEFWd18uQR9dlfLg
	vUC4r
X-Gm-Gg: AY/fxX5gIyQavFuBASKmce6+Vm0ZH0s/3DwqMYzw7eyHNJ/pZuMIp+iXyZEjUDSPA9r
	r/Pafio90/X15l7/WpmmI9gf3ORDX76/wAl6JUokUqiRaB9KYYHFQKS5fzAv7Q6gHRLaCj7Y5AG
	SOUdQJCFXiVLg5md47vKjLbHUwnpGI5pudTIl5E9tR8ZQUupxm2TpwCFjp12vGGGyFUCR8cYbDP
	uSyKDquun4AmJWM4h4jkthe3iT/FOSFy1UPWDVVMWeh5i++99RM7vB4C/B7rxfnGJ2Aqbp5Efvp
	ZCTYea+CDIzBO0cSlrHHngq60AIIJt/j6Du3u9+rPQOP6gQl6EC23qRO31MietnUdvxqnMRk74d
	OtjoxAeSDd8P6s0buqVl0XCLmCh3i9R+dvex89E3jisjmDAvUDEDxmkctz8y0rTxHGPK1QBPgLo
	Ykx23fCrZ9ktRwz0bqXF3OnbZixVVz9mcfSg0wyctdXPXhB/GGKkAkfcz2bmp/aNC+sEU=
X-Google-Smtp-Source: AGHT+IGU4EwnENoVLZcc3PNj6UtCmKbLL+4ENJNdat+CgzEfd6wR8SIRx+LQD5e3GkbAHGRB7KzypQ==
X-Received: by 2002:ad4:5767:0:b0:882:4130:d108 with SMTP id 6a1803df08f44-89075ea5df8mr23575886d6.43.1767662197793;
        Mon, 05 Jan 2026 17:16:37 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8e6ce5asm3810611cf.33.2026.01.05.17.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:16:37 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vcvga-00000001EfI-37dn;
	Mon, 05 Jan 2026 21:16:36 -0400
Date: Mon, 5 Jan 2026 21:16:36 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
	maz@kernel.org, tglx@linutronix.de, robin.murphy@arm.com,
	suzuki.poulose@arm.com, akpm@linux-foundation.org,
	steven.price@arm.com
Subject: Re: [PATCH v2 1/4] swiotlb: dma: its: Enforce host page-size
 alignment for shared buffers
Message-ID: <20260106011636.GQ125261@ziepe.ca>
References: <20251221160920.297689-1-aneesh.kumar@kernel.org>
 <20251221160920.297689-2-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221160920.297689-2-aneesh.kumar@kernel.org>

On Sun, Dec 21, 2025 at 09:39:17PM +0530, Aneesh Kumar K.V (Arm) wrote:
> +#define mem_encrypt_align mem_encrypt_align
> +static inline size_t mem_encrypt_align(size_t size)
> +{
> +	return size;
> +}
> +

IMHO this is the wrong API.

The issue here is not about alignment, it is about the permitted
granule size for shared/private.

On X86 this will be PAGE_SIZE on ARM64 it is
  max(hypervisor_page_size, PAGE_SIZE)

So think the arch helper should simply be

  __pure size_T mem_encrypt_granule_size(void);

> +	if (WARN_ON(!IS_ALIGNED(addr, mem_encrypt_align(PAGE_SIZE))))
> +		return 0;
> +
> +	if (WARN_ON(!IS_ALIGNED(numpages << PAGE_SHIFT, mem_encrypt_align(PAGE_SIZE))))
> +		return 0;

And then we don't end up with weiro reading stuff like this..

if (WARN_ON(!IS_ALIGNED(addr, mem_encrypt_granule_size())) ||
    WARN_ON(!IS_ALIGNED(numpages, mem_encrypt_granule_size() / PAGE_SIZE)))

Is much more readable..
> @@ -319,8 +319,8 @@ static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
>  		unsigned int flags,
>  		int (*remap)(void *tlb, unsigned long nslabs))
>  {
> -	size_t bytes = PAGE_ALIGN(nslabs << IO_TLB_SHIFT);
>  	void *tlb;
> +	size_t bytes = mem_encrypt_align(nslabs << IO_TLB_SHIFT);

The stuff like this is just ALING(nslabs << IO_TLB_SHIFT, mem_encrypt_granule_size())

etc

Jason
