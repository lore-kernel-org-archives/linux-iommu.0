Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C7722370C
	for <iommu@lists.linux.dev>; Thu,  6 Feb 2025 05:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738819812; cv=none; b=jifLUYq+s/6/MBVGld6N2oXQdW3UECb4xIABtbD3YtcDBR8AqQaJztvQU0YrEreCxmdnf2U3Ljvw5f2Gxl2w1h3rnoGJL6E/9U3mCcju0zwzSG1P/X4kyL8EkxAXWUIY6+IoJsYxSVaxFLY2Rnj8Rd6zG/I2NOiH9UPPORKJqg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738819812; c=relaxed/simple;
	bh=tNOsQ8XTPAWYz9ImmrEJwRpNQeju67/8X20L+ujIqzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hu+xGiIRaj6mJ51ZKPknPw9EXRrvkOdPH0gKIDHwxmBhTA6P6xDgBNgbB3hW5wXtA7YUfjeSxphzwz+JHblQTfszInLiyVhEc0Zsbr8w3i2XW/dBznYscDxLezWcJ3Ccum7/rmUkszAtRyfGJLqmjxoDFOqKpJybpEvU0QcNPgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=q5MsBWCV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="q5MsBWCV"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f16af1f71so7762895ad.3
        for <iommu@lists.linux.dev>; Wed, 05 Feb 2025 21:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738819809; x=1739424609; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pRoJEJRUPVObRh6bcpNHZcCJSeUoo6qbmkVpHeNteUs=;
        b=q5MsBWCVuNC2F3hHvNX2toyzdzN7weOFg9ToelHKL9D+M46XGiWQ5XNJP8TZygo/2l
         /VMaRugfGhGMjFZ11jr5lpc8xbiffVjrUG9UuDirKIosba0GyRvc35TZOtFyAekc2kpD
         hkwUwp3prQsqP62LeAeeKlBgQkWbM8Hm5/37sUCLmboL2iyjX85QTdX/PlXw7ZBTGijG
         kctxyjz+dWKNVW8lc0dDM3m3U+EuYAPwAp5sjKEetlI33t4h6eIY3wL+zkFiXex8lvjV
         o8W5wVJfEjHcKOrVxVZuENQLV5/YYvGW2V5E7xLy/VDk4ERqnx5OMUORDVuF+t3JSwFn
         6NpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738819809; x=1739424609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRoJEJRUPVObRh6bcpNHZcCJSeUoo6qbmkVpHeNteUs=;
        b=E6ILICiiJS/KBN3EOZ3Owxhh/IqK4HVrKsjsUBlu7HEwhhYKlQVdwaLYNujXMyvLJQ
         FheuTF8izmWNwU+HvV8Jhb5K2JWCsjSnJGVmA9mjjHZvt0pu2wAPGNHh5vjPA77KWa2i
         0chcQ2/ZTWDCSRk8jFBzOU3aZ009HvsIRFsVZrQA9c5n9W3LUlcUS1Pd6+4pfOE85yQJ
         EqJsxCtQ43mjourGqw6x918bQIyw5D72WvGQitAtsrcYiMcWHhvLuaXikLFKoc62xu6D
         9MT+/CDE0yJy2tpi8WRbhgE+4fNn2bJdkfFlh12zwEzUJ4q8a+NXDTK7rR8EHneeUdDA
         AUZA==
X-Forwarded-Encrypted: i=1; AJvYcCWKDiOX8FvWq8TT+CP9Y929/60+9yyUbTb76lftf6gzOlfC45JdzMRBBTSg5TG/GGU5bCFmeg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhCeidU3guX3HGkbYwpx5mzoWcWfdnjjYFTGyhQD3FhM3+U5dX
	cbrAjXgWlQJSOWWb/fc9zCG6kUcPnQNKq9JVy/IpALO2QICKQ+NEFdlhhRpwFd4=
X-Gm-Gg: ASbGnctSqzwMQkvdoUP4Ao2b5e8mw85Am9nrouqli8FWPuqwhXrMhC7chLXK+IEr1er
	GakrBrUGVwqxSDd6iqGxzMQUDH9pu0+OPv+MddaOBeIYgma1SKnNdSLEjoywkho0VzZ1MUjLkzj
	P0KFzCf4nkSzT+KGQogtBHkrb7AZpBXZNAQEVYQJU5C8StqBNQJu6FrH6feg59tUOuBdoRpXOzV
	syxvcPNvgllgu3pVWgV3nPuJ7eWB5AmSDKRGxCyh6LRlTHo45iwp2EUI4qwChlDlg3KsPT8Qb2x
	43+VmQdNRNNPDj+yH/RMawyq+kkNzDkxbg==
X-Google-Smtp-Source: AGHT+IE1tNZkBLKVThcpOUcjJPjEE6LeUB5SuPAtY9c/ZHJbnXa2ZNVKpzCci8Lb0vwwFKWpOtSe+Q==
X-Received: by 2002:a17:902:d28b:b0:216:410d:4c53 with SMTP id d9443c01a7336-21f17ebba71mr74788475ad.41.1738819809035;
        Wed, 05 Feb 2025 21:30:09 -0800 (PST)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653c997sm3459215ad.78.2025.02.05.21.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 21:30:08 -0800 (PST)
Date: Wed, 5 Feb 2025 21:30:05 -0800
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
Subject: Re: [PATCH 17/19] iommu/riscv: Update to use
 iommu_alloc_pages_node_lg2()
Message-ID: <Z6RI3ftJTrm3UxoO@tjeznach.ba.rivosinc.com>
References: <0-v1-416f64558c7c+2a5-iommu_pages_jgg@nvidia.com>
 <17-v1-416f64558c7c+2a5-iommu_pages_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17-v1-416f64558c7c+2a5-iommu_pages_jgg@nvidia.com>

On Tue, Feb 04, 2025 at 02:34:58PM -0400, Jason Gunthorpe wrote:
> One part of RISCV already has a computed size, the other part seems to use
> PAGE_SIZE (which is probably SZ_4K?). Convert the call.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/riscv/iommu.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 549bd8d0615d75..b7cee3d651b179 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -65,13 +65,15 @@ static int riscv_iommu_devres_pages_match(struct device *dev, void *res, void *p
>  	return devres->addr == target->addr;
>  }
>  
> -static void *riscv_iommu_get_pages(struct riscv_iommu_device *iommu, int order)
> +static void *riscv_iommu_get_pages(struct riscv_iommu_device *iommu,
> +				   unsigned int size)
>  {
>  	struct riscv_iommu_devres *devres;
>  	void *addr;
>  
> -	addr = iommu_alloc_pages_node(dev_to_node(iommu->dev),
> -				      GFP_KERNEL_ACCOUNT, order);
> +	addr = iommu_alloc_pages_node_lg2(dev_to_node(iommu->dev),
> +					  GFP_KERNEL_ACCOUNT,
> +					  order_base_2(size));
>  	if (unlikely(!addr))
>  		return NULL;
>  
> @@ -161,9 +163,8 @@ static int riscv_iommu_queue_alloc(struct riscv_iommu_device *iommu,
>  	} else {
>  		do {
>  			const size_t queue_size = entry_size << (logsz + 1);
> -			const int order = get_order(queue_size);
>  
> -			queue->base = riscv_iommu_get_pages(iommu, order);
> +			queue->base = riscv_iommu_get_pages(iommu, queue_size);
>  			queue->phys = __pa(queue->base);

All allocations must be 4k aligned, including sub-page allocs.

Note from IOMMU/RISC-V spec:

"If the command-queue has 256 or fewer entries then the base address of the
queue is always aligned to 4-KiB."

I can't find this to be guaranteed with new allocation API.

>  		} while (!queue->base && logsz-- > 0);
>  	}
> @@ -618,7 +619,7 @@ static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iomm
>  				break;
>  			}
>  
> -			ptr = riscv_iommu_get_pages(iommu, 0);
> +			ptr = riscv_iommu_get_pages(iommu, PAGE_SIZE);
>  			if (!ptr)
>  				return NULL;
>  
> @@ -698,7 +699,7 @@ static int riscv_iommu_iodir_alloc(struct riscv_iommu_device *iommu)
>  	}
>  
>  	if (!iommu->ddt_root) {
> -		iommu->ddt_root = riscv_iommu_get_pages(iommu, 0);
> +		iommu->ddt_root = riscv_iommu_get_pages(iommu, PAGE_SIZE);
>  		iommu->ddt_phys = __pa(iommu->ddt_root);
>  	}
>  
> -- 
> 2.43.0
> 

best,
- Tomasz
