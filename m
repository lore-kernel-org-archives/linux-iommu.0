Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998413522F0
	for <iommu@lists.linux.dev>; Fri,  5 Dec 2025 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764964217; cv=none; b=hn8jkdHcNX7zlgW0iuN01i371E2lwdQKl+9Z0Rrv2MhUzro6gyx5fEqwlsXDVBog3kANZ94PCoz3QWYjZhhGV7axoxM45j1cL724eogL6Cib6d3yTZ0XEm50Dl94I9ABdOlDmRlIp2+oxed217L/sbXmtnV1h60gxSU9bFsg82Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764964217; c=relaxed/simple;
	bh=2qehvIyxcQgdG2r4Lq1PdhJk+p1KTlod1C1KRZ0s8Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hooPDo9WydycezswJfbPdvapH+NY5Ayz+CXjJXzPl3V5NwhDAinbD5O5W6MXDcciHiMSG9mSJiYgssVrUDoT+o//p+lCxHWq2hEiKt+3FSonEW8E+6I2/F0St2nZob1jGbc2fxSD+1PE+Rx0+hyMzWVcmz2dgu3iOpFq0Hz1ATY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ximyys9z; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ximyys9z"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-882379c0b14so19696846d6.1
        for <iommu@lists.linux.dev>; Fri, 05 Dec 2025 11:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1764964211; x=1765569011; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3RQExzcfqwYlyekZ+KLVqUTRdy0TqxFDRhSxkhvJOBs=;
        b=Ximyys9zHb+kVmzSeQ9zOVHHA1t/iWcuupXu0QfTspuljoJ0IHoD7SKwWta45KYl72
         gFxHl5wArlFd1v8rNp6Vq/I9mcKeVy7OXB/hJQOcgvsU/WkiFc+We6Yq5gk/2dxFW/U0
         hkl+l/Iv9RTXpVyA4UAfJqfovfBAQD9ZEIdY3qBx3V5CXo+02YF4uP/gJpy8w1b5K6iJ
         Lci6hdoq3OhncD1Fi24XuuZVpJlJ8YJ3ePCIdiPeYKIsKyMwe/x13G9lT2uQMixRDgb2
         PhRcfailT6d84c2kUpC1rc0vTYAq4OZZMgb2mwqOu+jnBk1IGwr87hkRMQJxVFGJqBq0
         4ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764964211; x=1765569011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RQExzcfqwYlyekZ+KLVqUTRdy0TqxFDRhSxkhvJOBs=;
        b=DyR1mzW5z4H3FTIEq9+cyfHqIn+1EGYAq8fjBB9mwPqTzOoIbv5g1rJi+VIowvfRkf
         AgMqDtCLc2EavQnK6YtGPWlnyWwDdz/ChIkChRhfXnC/wmT4hBriKSqTv/bxNTxeq6Vm
         K+NX7b3rJGPMz/oNbQ/r3a1vffx3BXtmzshBcmoXjtEZxU2POBMOkXr/MtRAsY0916la
         uShdynAuF6JcFHz7KL2LSx8KDffuN6V0MgNXyfo+T9K9AHS98A0R2k9MA7Jm270N9H6W
         U1Ea/0n6k6RZT/Lct24RSxZ+EyJIz3ylkqhc5vvq10yXZPVm4R4hLlKZQuOxVZvn7jx2
         lpuw==
X-Forwarded-Encrypted: i=1; AJvYcCUrSB9CFsnvdwTHDr+zwl6E2PJ8wRbj8ZP4Ib0CECNSBGaXZp7y4bceGNJyi0qdrAT5blbl8A==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywwb8THCrooscU6h+OajrZ4t82h2mdFRe9L3QGrV5EPOxXsbax8
	tGEVdjvPeUXa0JvoxZoaoABN+c01ekPWqotUbddDV1fl+fIpml2QpOLUNAp7A/CKNy4=
X-Gm-Gg: ASbGncuCXPaX/mcpwU+jpTEM/HvSduuuq28UaF0JXBtmLoawzg3iNOTFQW3L/CBUEZv
	atO1IIaw8ZpDV6J+MsXWbN7JH8wJSbsenVEA1IK2iS3c15MGJcPKUJ3WQO41qwDsVHiZ9c4rw4r
	Fhqs5UBZ04d4v3MDf6lx9e+Glq4HxqLgZZB8TCumkhlNVpBGwmqTRa8BxrWwhdewYITc+iPAwwd
	z+lsnFP2nBjKPn8aC6Fq4v9jFNAt8VGfRBUpurT1t1Hft4hJM0CbwHGYK1Um+TxOkg+u/68Fy7f
	mPIekrP/ilQ4IYH8Ng9Coa1OCZTs9yHRmeSpqaInnRlQbZ9S4SQ3Ij6qITYJXUjRfNPzYErig1+
	7pnFnn2p8OkQCDkRvrAbPKnSVh1KM0yV16uc/Lrq7RRZH2u6ISRESod2/9nKiXO46MnPd+JZIHF
	duqzrjZdh5tzRKRAI4oPXfQLe7WDVLancgC9uEYwh0bbaQbEcjs+b8Zfsc
X-Google-Smtp-Source: AGHT+IEhNQzl6hnLnvBGiNFZqavEi9gf+2ka/7WFT3C4ElHJ2NM/0b+SbU12SVUuzIi8xfaOQ1uqlA==
X-Received: by 2002:a05:6214:5090:b0:880:4ef7:ce77 with SMTP id 6a1803df08f44-8883dbef91bmr3494316d6.49.1764964210765;
        Fri, 05 Dec 2025 11:50:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-888286aed31sm40901866d6.37.2025.12.05.11.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 11:50:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vRbof-00000005vY6-1Pjz;
	Fri, 05 Dec 2025 15:50:09 -0400
Date: Fri, 5 Dec 2025 15:50:09 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Arnd Bergmann <arnd@arndb.de>, Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Alex Mastro <amastro@fb.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd: fix building without dmabuf
Message-ID: <20251205195009.GN812105@ziepe.ca>
References: <20251204100333.1034767-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204100333.1034767-1-arnd@kernel.org>

On Thu, Dec 04, 2025 at 11:03:29AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When DMABUF is disabled, trying to use it causes a link failure:
> 
> x86_64-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_map_file_pages':
> io_pagetable.c:(.text+0x1735): undefined reference to `dma_buf_get'
> x86_64-linux-ld: io_pagetable.c:(.text+0x1775): undefined reference to `dma_buf_put'
> 
> Fixes: 44ebaa1744fd ("iommufd: Accept a DMABUF through IOMMU_IOAS_MAP_FILE")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/iommu/iommufd/io_pagetable.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

I picked this up anyhow since it looked like adding #ifdef stubs to
dma_buf.h was going to be a bigger thing

> +	if (IS_ENABLED(CONFIG_DMABUF_HEAPS))
> +		dmabuf = dma_buf_get(fd);

But this needs to be:

	if (IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
		dmabuf = dma_buf_get(fd);

I fixed it

Thanks,
Jason
