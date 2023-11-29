Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000AE219EF
	for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 20:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gdmmMH17"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3b8952b8066so561748b6e.1
        for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 12:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701290598; x=1701895398; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VQkQZtrQbpqMHU38TIDcUDo5JEq87aQQf1MaJK/f8fE=;
        b=gdmmMH17F3AZhCI7aQ66kUPO2lpWyHL15owIIdOG6vINjzQnNk/jN+wXQPGQzGYsAG
         MH+RoDfhTKwJ8+6oy3ejZ74V2+JCvq1DGbRHMnekgt35npRh1RvrOJoTTgXHkW/G1L8l
         erm3EsuuVpf54AcyXlPRQnSV8i8uhQS/6TyeZoof7gtH7sBwAZTfyx37eSbjtAWs7fss
         qjXX9k9SjA/+PDQ/LOxOSjz4MFVCU4POus5ybS4W4iVg830P97yK2X4nXXBve4hUIYWQ
         WyOlSyk1bgoeoZgzNaYG9cSnMsnOEdtFrYtJzSGizEFudIm3Nr5Cp2bzEzkkohx/8bUf
         C4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701290598; x=1701895398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQkQZtrQbpqMHU38TIDcUDo5JEq87aQQf1MaJK/f8fE=;
        b=Nz8cDzgK61zf9JtjDwmMMDTCGEEeLk/P7PLB1/70Xt8rfnqW8Oyn4aj1gT2NIxj4L8
         +p5+99zr8AALnCnMneWsHSkHhA/tHZEg9WU5mzpJrC5oDfDMtKK4EsPriLNcLnLV0Izl
         7lQRYgOP2jhAXDj5883Xbxgoe6pucIAYWXZ624MV26TodmxvJ7C8TW2vHBtJlZJuAhoS
         I00r18spXYvAl9bXO4Q6j7y87d1nM8M0Fy4mTMQnnZv2bgadteMedKrHRdoBi5PkIh7o
         9STkj7PDndU6ufCaxfEXhKSA1qesGjAosWP58yCKqVXWUNMdCHRbsuX0+7JOXk+dc4Uj
         rviw==
X-Gm-Message-State: AOJu0YzEGB4RMK545KWj+OKcGtOHwbZLfYAKxEHF/uHhveRzgkxgi5Nw
	E/2IbjtNsiB6vdSuePa0t062KQ==
X-Google-Smtp-Source: AGHT+IGLoniM+wElYPIWxSKpX9Eo477s4X8dPUqDwUM2qIN0+StQVm9ol890wMZQ9Fmvg1ybJUuFzw==
X-Received: by 2002:a05:6808:152b:b0:3b8:3399:84bf with SMTP id u43-20020a056808152b00b003b8339984bfmr11564700oiw.15.1701290598186;
        Wed, 29 Nov 2023 12:43:18 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id bd33-20020a056808222100b003af644e6e81sm1782211oib.45.2023.11.29.12.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:43:17 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r8ROv-005pgb-4k;
	Wed, 29 Nov 2023 16:43:17 -0400
Date: Wed, 29 Nov 2023 16:43:17 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 5/7] iommu/dma: Make limit checks self-contained
Message-ID: <20231129204317.GQ1312390@ziepe.ca>
References: <cover.1701268753.git.robin.murphy@arm.com>
 <951f52b59b401418a7ccc00beed15632d1aabd7a.1701268753.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <951f52b59b401418a7ccc00beed15632d1aabd7a.1701268753.git.robin.murphy@arm.com>

On Wed, Nov 29, 2023 at 05:43:02PM +0000, Robin Murphy wrote:
> It's now easy to retrieve the device's DMA limits if we want to check
> them against the domain aperture, so do that ourselves instead of
> relying on them being passed through the callchain.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)

When I spent some time noodling on this a few weeks ago I was looking
at putting the dma_range_map_min() effectively as a new reserved
region in the common reserved region code so it naturally flows out to
all the right places.

But this is no worse in that regard than what we have right now:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

>  	/* Check the domain allows at least some access to the device... */
> -	if (domain->geometry.force_aperture) {
> +	if (map) {

Oh, I've been sitting on a patch to delete force_aperture now too..

Jason
