Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4CF7E796
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 06:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726469464; cv=none; b=M0kibtjJa/TY3u5TwwDsXoDGPMocOmnyCtHuUH2XpB42GAKtRMhuajKHdlKq6cQM3+27fTDsygZBShO3QsOjoEYLw02ZVU/FCkyoYfqCoIgVE+J+La+pZOKks7oM16ZIf/Vt6T9hjgCRrfq38SmbiHilRx31lD/Bb+E3a+NWZLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726469464; c=relaxed/simple;
	bh=vqx3byxzt1bdXTwPL8aHobPNsSNVoaxtI2qJmsNesYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mummcw++Ukbcwq/pHvEejuOSLqBL/t5O1yxRR7aAIqhB+ZkwdhkECxw27t8hXcs9xNn+/zvFKuhStk4wv/AMuu6g91+e11oeoBrmRHr6fIiOgCS19TdFugVguaJAFZI2TlAj2MCn+DmtZUaJpNIO9cOHOM6wyXwfOoFanWNuNhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qhxwp0Lb; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qhxwp0Lb"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso28565341fa.2
        for <iommu@lists.linux.dev>; Sun, 15 Sep 2024 23:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726469459; x=1727074259; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JPgpIAwUtRjyGXaz2UWsyQSvP3nVeWuucx2LpeEpAfE=;
        b=Qhxwp0Lb6hHZbkJHt+qO9vXO1YPxLocBwWzc2DsWx/BZOs+37JVPHpXFNhLYL+rIZQ
         7QQsQV5eVGZLsW3bSKLVJ/xEQncC91mbnIsYnGHLrw+iBrWqk8RGugCVyB7TqYxEacUz
         nUxy1HpCCPTVujNRn4yU2QRom/04NrKTwRMljqEeSdJJZfvsVtAt5ONYud2f9r8kxaq5
         0hc08SuGFCjs2mSwFWj+s3meMgq8UaeyOFrQdN2buUCmLlwu97a+bV2J90e60AQ31yuZ
         Lj/ab08sjzFZhT1JPkfWMGhXwbkxkBfM9c+lWDcBRYKvk3qgkX31S1utIZkmbqxRcBeu
         PWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726469459; x=1727074259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPgpIAwUtRjyGXaz2UWsyQSvP3nVeWuucx2LpeEpAfE=;
        b=ttGo8qn6OJUA1pKPam3vVoLrJXSPY/WaEWieeKJ5OYBWsD7vAm7g/WqeQ16+uJ1Ygk
         MfDfDi3aM/7gc3Q+4bZrhbIrzSze+ImZAdGB/5T6eXpUceIlkC0IFrQK1FKkNzCysO81
         utb2u+Z+RXPCA1PMRB5+lrG0baGvjHvblPezjvqwV///QWzcckLh07Wj31xuqI5O2Xr+
         uagAizLWzhd8PrdIxBgqbZQEZETcm3GT6ZRaQPzQE/l38j6Dj2rGW8GP/KoL5uwdflqk
         nkKdF2c78AfLec4ugUW+mFoOjFCRTz0BvIS7Dhac3S8IDdDkz/5nynqqOAxPcLMb3sOH
         wMqw==
X-Forwarded-Encrypted: i=1; AJvYcCUdq2tBj3zoKCExBz0Zl+mPxtuIu3GmUS4PAvuGK3o0HiGHnPMEnovDrYLaG+u3Avyu1QIPQw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhpY1FCebYoGgE5+pdqT5SeQ4VFrrhaJSAqdmahR4PDDG1G6UD
	lXV8dfan7T3SrY5q3zxwMPt/PMMsvZA534sLy3MOmEv0cOeF1FCbVIYJGy3Ahw==
X-Google-Smtp-Source: AGHT+IHdV1TNRmBScApbJF/19sNrIq7EW1xqWRb7LFjySq6rhBb9plTuYbfalnfxPg2RJC3tI6SHDQ==
X-Received: by 2002:a2e:bd12:0:b0:2f1:67de:b536 with SMTP id 38308e7fff4ca-2f791a04b9fmr61395021fa.24.1726469459276;
        Sun, 15 Sep 2024 23:50:59 -0700 (PDT)
Received: from [172.31.47.100] ([193.118.249.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f3883sm271634266b.50.2024.09.15.23.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 23:50:59 -0700 (PDT)
Message-ID: <d23c9af4-4a79-4300-891a-fba3ea9cbb1c@suse.com>
Date: Mon, 16 Sep 2024 08:50:58 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] xen/swiotlb: add alignment check for dma buffers
To: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20240916064748.18071-1-jgross@suse.com>
 <20240916064748.18071-2-jgross@suse.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20240916064748.18071-2-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16.09.2024 08:47, Juergen Gross wrote:
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -78,9 +78,15 @@ static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
>  {
>  	unsigned long next_bfn, xen_pfn = XEN_PFN_DOWN(p);
>  	unsigned int i, nr_pages = XEN_PFN_UP(xen_offset_in_page(p) + size);
> +	phys_addr_t algn = 1ULL << (get_order(size) + PAGE_SHIFT);
>  
>  	next_bfn = pfn_to_bfn(xen_pfn);
>  
> +	/* If buffer is physically aligned, ensure DMA alignment. */
> +	if (IS_ALIGNED(p, algn) &&
> +	    !IS_ALIGNED(next_bfn << XEN_PAGE_SHIFT, algn))

And this shift is not at risk of losing bits on Arm LPAE?

Jan
