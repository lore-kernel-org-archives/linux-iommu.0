Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BFAD531
	for <iommu@lists.linux.dev>; Thu,  6 Nov 2025 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434730; cv=none; b=ViUYSQzQ8tXT80p3Hdg46bh9uYyUZxrw8R3olj3+w0Xjlge2c8aM85HkF0lVjmtEC2FY+KOJniOWnfmQxvtMU9Tapm1HvOsnYGlDE1ADxpxvQIC1xjF5IRZH1ETDGaBut4igSkgWndHAXWrHdKKk3PaOcIxFmRhEvYlB2yXKiTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434730; c=relaxed/simple;
	bh=5fTu+d04zbTJZlqMZWEMH+c1jZ5YJrgOff05i/wlilU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAkSkbhH3tyHtQlzQRDq6MRuKQI5bgzLFf0D24MgnwAxjdsaGh05pXkIHrP6lZQ20NMg3t9FJtdSN89LcrykzcZ2/6/JZDle+fEX4DMQ7UIP5Gw10JIVt/yuktRaPKu8+qGY8t4ba5EN7Op0SjzaKGUZ+F2Ycrq8ukpfsw5JfnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lrkt4NfS; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lrkt4NfS"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ecef02647eso8180951cf.1
        for <iommu@lists.linux.dev>; Thu, 06 Nov 2025 05:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762434727; x=1763039527; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E29aoir2P/D00xWPCdBMTWQeHrb8OPeQgwrWgeqWvFc=;
        b=lrkt4NfSn9fdDbcjQnX5aEZ6WUOfFa3fA4BFuWA3KSLsF3dNFF0ywfjuqyrrwa5kHC
         dR3omyR+H35XwOivw9xYGgfJuiG5rEOPU93YZ7R+05jZcuKHdtW4GMmGNr6221wl2eke
         u7R0SGP0IyCp1zcfE0rIptaX696eQAL/iUE3QpK/WTpJzFMv0LDACUEDlsHtpuWl5Rpe
         5GHRUJdLmDUcmeDAhgyaTpeuJ+QXOeK1UtgPGMn+TNzvqf/Os07OS+Yljos8NDXDK/1G
         09WMVZkmHvVlAZWN+Dgh45dWofPjZZX4h+QE+tzMClEHO2tz0w06tnhPaobkcS79oFyP
         1KbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762434727; x=1763039527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E29aoir2P/D00xWPCdBMTWQeHrb8OPeQgwrWgeqWvFc=;
        b=o5/i6+gYazCzHzTG1259Wd5G/hPCUHpPfX5oFSNw3jWn5kwF14pXjOsHo78Pkmhtrr
         6bz/JVw1UtLM8uNCokbtE5e0vG/vvGbUPNf4vSYP7mRBgjgP5lhFvDfQyVe+hZ3wwqIA
         KhP2fAf+W7T8oFU/eqyGwB8zzANj1ttz6zP3hGdRsdpOoIc+OsCFOJHtZNzpjfhMTfwz
         pyv0QSNTy6hsEuPcPDZnzE0PrXoJacssknSyKc/g1g/fTX99VG57b7cTFvUhamjqV6Yh
         WhSyvrGcC3HTlgAHzGPKLgsbPG98AeASvNBG1VvVtEPlbgAEtkx6/fngHbpZ71jQ+Lym
         gtcw==
X-Forwarded-Encrypted: i=1; AJvYcCXa4iqdDjL2YTTQ13t8rjLwkOy6PyItS/7hCYuCQ9qYUh6nZojw2S2YaeZt6T/eYBBbe+6JWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhFcgE89q6tz7+KJpm2vGQOezCIXhZ3bWgnDM57Y29J2WfZ/yl
	UHJdVmzg2U9i1gk+/FxX5bCYvkMMYOIEvzKDZQBP7GjkmYbMzAQwIHV0EXSY2sKxK3s=
X-Gm-Gg: ASbGncvABpf3Xz/+QTiN4UeQIrEEBBrUP5PCsCKY9TOSKfZSLsLXeQlPj6GjTt+WFju
	bQWWrwknehaumPbMXoOuNIM50H49RBCwbumBzPp7j47QKnZpjyrj27YCQy2+AUrc1hdmfkrZhR4
	Ni3nLPT6XrSH4Oy9ciLhi2eCapNtJWkRRulLByiWMY4xltkkzN7/K+DXKmHBO9Q74VV8yRyELdE
	WlGdhYnnkVwZkg0ueI4hUxjAHlEmMHtfO0BSnIVSLM+D7ZveMRQsq+Y+bSP3DTJEh2iEuBFf37O
	qZQmOkYx9Wtg6lVC3OzFe5mas6CnkxlRv4i77ETMQvI60cxN3pmAg3TR43eQDtk0eWxuVe7LuaX
	Tetb/HYcj5TiquVHLApClRvnZzRyoG9bxL4DNVGJYyu5KJvjqwbmQhreZIvy38RwNS5hQPsAnQd
	RXG1e6GvozGgu4Ric+E5VnyMyi1baiw5wmFZ3g4tJbdDFecQ==
X-Google-Smtp-Source: AGHT+IHO2kfw1vydAWg7lJYdgVN60+8RpDLa3bu5iIb6/gokLYdATyBmAutBTljfCiGVr0ImJH3xUg==
X-Received: by 2002:ac8:5903:0:b0:4e8:a269:ceab with SMTP id d75a77b69052e-4ed72354895mr97954141cf.5.1762434727357;
        Thu, 06 Nov 2025 05:12:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880829f7a3asm18683196d6.40.2025.11.06.05.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:12:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vGzmY-00000007LUY-0oBI;
	Thu, 06 Nov 2025 09:12:06 -0400
Date: Thu, 6 Nov 2025 09:12:06 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>,
	Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH 0/2] genpt documentation fixes
Message-ID: <20251106131206.GT1204670@ziepe.ca>
References: <20251106073845.36445-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106073845.36445-1-bagasdotme@gmail.com>

On Thu, Nov 06, 2025 at 02:38:43PM +0700, Bagas Sanjaya wrote:
> Hi,
> 
> Here are fixes for two htmldocs warnings in generic radix page table
> documentation. The first one is reported in linux-next [1], and the
> second one is also found when making htmldocs locally to reproduce the
> former.
> 
> Enjoy!
> 
> [1]: https://lore.kernel.org/linux-next/20251106143925.578e411b@canb.auug.org.au/
> 
> Bagas Sanjaya (2):
>   Documentation: genpt: Don't use code block marker before iommu_amdv1.c
>     include listing
>   iommupt: Describe @bitnr parameter
> 
>  Documentation/driver-api/generic_pt.rst | 2 +-
>  drivers/iommu/generic_pt/pt_common.h    | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks,
Jason
