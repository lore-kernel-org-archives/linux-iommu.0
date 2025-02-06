Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8441F60A
	for <iommu@lists.linux.dev>; Thu,  6 Feb 2025 05:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738821188; cv=none; b=m1OTayIOmEIMfquLHqv5lQ56KPBQxnR8FWUrL5mJlEO62G+qMNPiGtNNDcNXaJcIALLlJrxcPISlXVC91PcAWVA6DosPJ+hR0e/1JUs7LWvuHTV7XA9YfcU1Qc1M0Ah2S6KUmKWuqFl5CsvvOzpd6UEWqKtHRzJUP43Vp02PNr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738821188; c=relaxed/simple;
	bh=AqBJlKICIlVN/KVB1S54nyOy92xf+Ecum9ESyS7lCGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxGhT7hzQQMqO3ie3zd4hkg7WE3G+IkzM8RFngq9a0Y+CHASeXPsaIAVmkpOpTP+knR/aVnGgexn2EN51ev0VJK4DTxUQwnOaZGsJvTpI3ow7ecZL5y3Sqg0oYWNPs47WeTeGjy0k54efBxGq3s2liSNfYXHn/QEiNYrqSsTqzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ecyr2ZrF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ecyr2ZrF"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f08b44937so8127745ad.1
        for <iommu@lists.linux.dev>; Wed, 05 Feb 2025 21:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738821186; x=1739425986; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U5ldcxqakXbm8AP3lHPyZs0Noc32OWjVSFhOYUYpAno=;
        b=ecyr2ZrFrCG7N/W07JtZmj0+Zq1DI4kNy5vVkEKZp01oUTBsi8b1WG6yMPRz8RSfBy
         i8C+t0jq7x80l9BG9Jq2zKKB5tGGWwXN6EvILfxeOyqpK3rJmxmEaOUcPfCTJ9ZlDoZ4
         8JW1aq6z1fRuLWhx8iz/+UXFlsfX1Itruvxd6AqdVThFZxMdscIRq3Z/R3WSmopOOa5K
         265Rq3ZfNQ2V1uaDOCEa5P2Jk+0G+0aoOWom+MAXmVLDDswfSjByljykJYBatC6mQzid
         nTjTYLsYp46qHFeC15UAL8mea5syhpO0YTS4g2GDSe6EP2DEw2eRzTg+D2f4BGacZWwV
         wo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738821186; x=1739425986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5ldcxqakXbm8AP3lHPyZs0Noc32OWjVSFhOYUYpAno=;
        b=BzMFtQD0KumYc+K4DpD84qK2Ol/Xddlj0k2MJR5XVBnbRpQrE1U0VjxrQedKgEFqTx
         bDtm7aYLjywn7eP5jnJWXpG9ZSEW0Hy+uHo4v8w14uklC8TW8Q3Cr0lhfaZVNp9sWskX
         3amQ03H0oYxNtGDle4AxV4/1d9/OIzrRSksIw41XBSmxMkSLbYMw+vYUGhj+aEF0v+ll
         R3lQZJkrmkjcxvlb9A4BKiT9sPc8PPkchchXwpGSvB03m79diDKItw39dN2WO/EGQgt0
         dtqMFJhh9lde9rhU/vu0xi8Ge+ArRUHDsrv52KC4fr474wu/tDj7so677PzW9Gh6i3K2
         lXWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY+5BXeDrx7bQ0gFmSwE8W7wgV1ypbakqPUnCU1UMx6LVNAD9y/ts2fHqmGQVWUCDi4Jyt3A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJiI24gdJYY8eZ64IWwjzkWOavS86I/uWemjIY2j9VQwqB7QiU
	pLa7sB2D8barxq+oXoUhfhRXWZxMLGSWiXAKPD4SeBD/i0WaufUYP70VM90eB2k=
X-Gm-Gg: ASbGnculVDbTbBE94AtuyOTRKRthIhb5rIplNkFWUeEQ3xHVLhYYu5aV6Uf382Z5GE4
	eqaqDzxguwXQ+UGHRmolTE3J22SAmpD5cN4FF9KBbn8UjlAXdjvIq2nJ8nRW0dJlsRRBxjjdQDh
	SlTuTjBHEuHPki8MGWTK480wrbw5GTk+wSYskib6C2eymu8zEAbUCewSDZcVwScmBlbxOBWfQ+5
	GIzWDVTrNfjFs9CALtSNaB0WOZB92lQNJh+rkA6grUR99nlDKXfBqs9v9ckMnDqIC4lZNkhAfTT
	y7NmiFBHjO2Ttfrn/SjP3BuzJfpUVTI5IA==
X-Google-Smtp-Source: AGHT+IGCr9xd2Dhw5KUTmjMsz2hIPxrdWNp4ze88e5FpvAsB5Znxk1UOOvf/vmpixanfPva87r8KEw==
X-Received: by 2002:a17:902:c403:b0:21f:35fd:1b6a with SMTP id d9443c01a7336-21f35fd2116mr20176495ad.51.1738821185899;
        Wed, 05 Feb 2025 21:53:05 -0800 (PST)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c746sm3841885ad.180.2025.02.05.21.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 21:53:05 -0800 (PST)
Date: Wed, 5 Feb 2025 21:53:02 -0800
From: Tomasz Jeznach <tjeznach@rivosinc.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev,
	Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Hector Martin <marcan@marcan.st>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Sven Peter <sven@svenpeter.dev>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
	Joerg Roedel <jroedel@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	David Rientjes <rientjes@google.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 09/19] iommu/riscv: Convert to use struct iommu_pages_list
Message-ID: <Z6ROPsbXHYlQ0TgF@tjeznach.ba.rivosinc.com>
References: <0-v1-416f64558c7c+2a5-iommu_pages_jgg@nvidia.com>
 <9-v1-416f64558c7c+2a5-iommu_pages_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9-v1-416f64558c7c+2a5-iommu_pages_jgg@nvidia.com>

On Tue, Feb 04, 2025 at 02:34:50PM -0400, Jason Gunthorpe wrote:
> Change the internal freelist to use struct iommu_pages_list.
> 
> riscv uses this page list to free page table levels that are replaced
> with leaf ptes.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/riscv/iommu.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 6e7df7273426da..549bd8d0615d75 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1085,7 +1085,8 @@ static void riscv_iommu_iotlb_sync(struct iommu_domain *iommu_domain,
>  #define _io_pte_entry(pn, prot)	((_PAGE_PFN_MASK & ((pn) << _PAGE_PFN_SHIFT)) | (prot))
>  
>  static void riscv_iommu_pte_free(struct riscv_iommu_domain *domain,
> -				 unsigned long pte, struct list_head *freelist)
> +				 unsigned long pte,
> +				 struct iommu_pages_list *freelist)
>  {
>  	unsigned long *ptr;
>  	int i;
> @@ -1103,7 +1104,7 @@ static void riscv_iommu_pte_free(struct riscv_iommu_domain *domain,
>  	}
>  
>  	if (freelist)
> -		list_add_tail(&virt_to_page(ptr)->lru, freelist);
> +		iommu_pages_list_add(freelist, ptr);
>  	else
>  		iommu_free_page(ptr);
>  }
> @@ -1192,7 +1193,7 @@ static int riscv_iommu_map_pages(struct iommu_domain *iommu_domain,
>  	unsigned long *ptr;
>  	unsigned long pte, old, pte_prot;
>  	int rc = 0;
> -	LIST_HEAD(freelist);
> +	struct iommu_pages_list freelist = IOMMU_PAGES_LIST_INIT(freelist);
>  
>  	if (!(prot & IOMMU_WRITE))
>  		pte_prot = _PAGE_BASE | _PAGE_READ;
> @@ -1223,7 +1224,7 @@ static int riscv_iommu_map_pages(struct iommu_domain *iommu_domain,
>  
>  	*mapped = size;
>  
> -	if (!list_empty(&freelist)) {
> +	if (!iommu_pages_list_empty(&freelist)) {
>  		/*
>  		 * In 1.0 spec version, the smallest scope we can use to
>  		 * invalidate all levels of page table (i.e. leaf and non-leaf)
> -- 
> 2.43.0
> 

Reviewed-by: Tomasz Jeznach <tjeznach@rivosinc.com>

Thanks,
- Tomasz
