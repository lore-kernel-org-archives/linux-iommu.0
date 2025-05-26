Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9832B1D88AC
	for <iommu@lists.linux.dev>; Mon, 26 May 2025 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748284785; cv=none; b=DhQxEwzt+IMWNA+AR6+USd3KtLHUa4Ad/v9ypSePcbWpibGKkE8g2EKXqIeSDmu6H4Q1l1nJCGDuEsl7qYwvCECHybDS6rtXnPWjneS98JHB3+y+tfkEWNWJKZWMrKY3pbH6L6VmeM3kSApm52KmbiyGknpfK5a3k9PSSW6x5ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748284785; c=relaxed/simple;
	bh=vQM+dbOsVNtnD6l723Z1cplax/h0AmSZd+7H89VyNRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeD2NLrJNO1HnPic2ZF/YuAxX4JG8jwz5YpU0hUlIDxsVcYwZg5k75di+I5vrXG4nQtXOfCO9ms8ZCnGj6hd4vPsGDkUEzu6QA5xNlzSKFPSqE3Zjp9CoX05WYMODZyq7j7wzkYtWXqQWc8lpi3epCAnxwxhin7yY0ED8dgoRSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UByMrgC2; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UByMrgC2"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7cadd46eb07so242639085a.3
        for <iommu@lists.linux.dev>; Mon, 26 May 2025 11:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748284782; x=1748889582; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c86jKa309c3+QcTsQwLNlEeQh4J3Qa5o3Yi92C1rAmE=;
        b=UByMrgC2+3rGexVLygHngzA0BcCvyicV8raBp6toDkuPiml0lWgd3QICR5n8BV0I16
         VT3x5DEKWkuMnjmxAN4JRh+Fms3DfQKoKaS/4Ve/iTZ6tHfxAEAtKV0uraq74sV18I28
         1AI4E30PoFdUhAIkBRJdBljgPrC1o6P0fWrCZaT0GGL8Rgm62NjY3imRSrCvDPibHq06
         V4D8C8ACVmA5DltLEwN51lpoB06MZ/cKxO6UBbmUbF9WfNzEbU8e0+ggv9JXgt0jqv27
         Vdsd8GtETSI90OdjBwkJwtLuJfW4NO5HqAc35hEGsm8vRqeZKWgKcoXbpIfC4AnWWUrs
         gH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748284782; x=1748889582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c86jKa309c3+QcTsQwLNlEeQh4J3Qa5o3Yi92C1rAmE=;
        b=fQWL4QUEq58jbu30XAdZPnAsjGt1NJ8vtFYWpHHFcIV/02247zRcuyQne3AzwOfN0r
         Ltj61kj9UvzISzybAoEa7GJybqF/rnwL6RCPD9hZT7V7DjAPahPC0zzgeb0oT1Z6Gh6K
         7k+COPmbiPxQA9lvRvwoZC9OMrKBExDFYhfn6akWvZrACyCdQxMIQ65LQpqN9vu+FIay
         98w377Qcl4WcYvqH6gb7WWAcQnPZAu8hEyY1diAfzDZWql6DoD/bgNnG1Es0keEdMDES
         MGQNRAv3Srb1XYWQTs0eOEgiPUo2D/HwCP8QHE8N3uzMzoR7q2mQF09s3UzVKL3O0MOr
         NmYw==
X-Forwarded-Encrypted: i=1; AJvYcCUmf+HEU3pzOjXyP1YW0G+x7KXkomXBv1eN5FeZIqdLkCBXSPRVqBrKcfsmhNxrmrYMyrmwHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpnIY6MQFleybtZ9lSkTjYt/VuTcGx24Fj9H7pSfjHZ5ckIXK7
	OuRDN+zQU9C3zyJmkXQPUdh7xfL3lO14zeriXMeWyyyl1AxWGLhAFSHSfD061YjHub8=
X-Gm-Gg: ASbGnctUVG+7MAXcZJRnCC1d1OYwtJN9paakxOI/NHZ6GtymA13Alto2BYB9HkYP0Hx
	wcK/TRPuyMAF+3wnbutLdpe1mOtqxxiUU+bo3PlBC0lJY4mkzXVTqzmvyXtOFZoaDBDWk3LBsX3
	1SEvvT2666gT3RIfqbz2GHi65unepbUSORexK5NeYBYXuM36dci7CptCY4/6EQPaDGI3zinmbie
	+qt97URru/pGXODSqTaBImqbonQPoC4y6yBQlg9+ODFmvSBciDTLbunaMTUJOk1DdxgP+6nl6TY
	cQfHyBnK6P+iierhQZ+CryFw6tUxdveVc/tjKs+fRGFY/QINmrbb1QnGCIpNq/bPIvUOKbueEwz
	28jcUzk3Pzj4wHVeEj029Jde8R2I=
X-Google-Smtp-Source: AGHT+IGL7te5fpMbZe9HXdt3D5MGVGH/Bdpvl2UHGaBVcVqu8HICiF43E0e5svsb0e6OdO9BbM2sDg==
X-Received: by 2002:a05:620a:269b:b0:7cd:4b5b:a202 with SMTP id af79cd13be357-7ceecbad0cbmr1427354485a.20.1748284782328;
        Mon, 26 May 2025 11:39:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b844bsm1592181385a.87.2025.05.26.11.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 11:39:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uJcjd-00000000Ts1-0aL8;
	Mon, 26 May 2025 15:39:41 -0300
Date: Mon, 26 May 2025 15:39:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Rolf Eike Beer <eb@emlix.com>,
	Arnd Bergmann <arnd@arndb.de>, Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Nate Watterson <nwatterson@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: arm: fix building smmuv3 as loadable module
Message-ID: <20250526183941.GE12328@ziepe.ca>
References: <20250523121257.2340274-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523121257.2340274-1-arnd@kernel.org>

On Fri, May 23, 2025 at 02:12:53PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The smmu-v3 kunit test fail to link when the SMMU driver is configured
> as a loadable mdoule:
> 
> ERROR: modpost: "arm_smmu_make_cdtable_ste" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
> ERROR: modpost: "arm_smmu_make_s2_domain_ste" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
> ERROR: modpost: "arm_smmu_make_s1_cd" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
> ERROR: modpost: "arm_smmu_make_bypass_ste" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
> ERROR: modpost: "arm_smmu_make_abort_ste" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
> ERROR: modpost: "arm_smmu_make_sva_cd" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
> ERROR: modpost: "arm_smmu_get_ste_used" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
> ERROR: modpost: "arm_smmu_write_entry" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
> ERROR: modpost: "arm_smmu_get_cd_used" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
> 
> The problem is that the drivers/iommu/arm/arm-smmu-v3/Makefile only gets
> parsed while building modules, but the driver itself is accidentally marked
> as built-in unconditionally, so not only does the kunit test fail, but the
> entire driver is missing.
> 
> Change the driver configuration back to $(CONFIG_ARM_SMMU_V3) so it
> actually gets build here.
> 
> Fixes: e436576b0231 ("iommu: make inclusion of arm/arm-smmu-v3 directory conditional")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/iommu/arm/arm-smmu-v3/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
