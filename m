Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AA42FFFBF
	for <iommu@lists.linux.dev>; Thu,  4 Dec 2025 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764853929; cv=none; b=KvKtfZ53V/DTaXDIJAYsdgO5yVYzezMQW985jpFlQAe7KHsV3pFhLaXY/8L1VmCSLuUWnH7cq8rH6FwqdNU/cgPI+6YrhGEVzXah6WNPClbUTtJ6vs7GzlCO4vkWf2aFY4S9NZFaPJeNEaxY5bKVnQ3aodBDwhSeznwrCwZ6zqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764853929; c=relaxed/simple;
	bh=4XeIo1j6UgtNocdjhGhmFLM+uOk06qOz3ttN8u8DDFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucYNsjthRLr1j8BznBA4MPEhgYCFH73o5pVy1PnnbuSFblh4f8MWltpulX+vHykOUEK83zPqJTtUcyNpF+Oz3joVbxZPguh88Zd9chVY6iYLa6jULtT6Kpfhsu88QvHb+4OKYN0fHpu9I6iv33EUQieetajSi2PUoGPBTkiSiZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hp9yX85S; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hp9yX85S"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ede6b5cad7so3434941cf.2
        for <iommu@lists.linux.dev>; Thu, 04 Dec 2025 05:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1764853927; x=1765458727; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5AgEOOnvz05cFH+HJjEiBkLkjMN/F+6OlzBuG6akvn0=;
        b=hp9yX85Sjq12Cw6PSwmklNW8ebTlzxGLXx4O1pnidses54Ngh5uDwi32GGYl36tkMM
         P1traUnvE2W9tf1hu44A7Aqmc2kqIxbqINJEK14TsM6UbIr+2uHhTZxC9fWUHC3rig6O
         QQsSZr2TurxmRhXTJog7i0K6mUOBLIR7R/OgCXLyk4kK/AmIGK6psnQNcIyHB3R/89Y5
         NLQc6QyqeiiKKNCoC45XVrpyPAJZ67EsNXvVg5LSiRzHkZNqB+nbwx7gD38A4yt47fMS
         oha2iHFQ31qCOhkRyRJ37PXBBRrlCkOsTCjZig/pM1iAHf3JljWxxm+eDn0wcA4xoj4I
         Lnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764853927; x=1765458727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5AgEOOnvz05cFH+HJjEiBkLkjMN/F+6OlzBuG6akvn0=;
        b=OnfsfPvnd7cdB588wVSnmj+cHEovz1skrA5nPvAh5QMO0jR5BTIae44ksFbWkCHdxv
         UMQ/UeDgcXZSpnUCRc9X7oGKmdWJM5+Pe8Fyf8Z07lK8uJ9Yg5M2dRgKwgRKUTxU+ppB
         k24+zP+9JRKLtR8yxXEYdBopB1lLbjLzFl9+zGQVf2lBkjC73+QGFsffZOI9eCZKrad0
         5hn+Zoq1PEQCvwKbEZHN2Gz5AKDRbgOB+8s39rYJ84Kvj9eVt6hJpqY+sWpm/yK9EGnc
         mdL54363lCtqo1zWldNRhFZHv3np63psWi9kbY7F601DkOf5pt8B9dCWN2JlMZjczvFY
         aZyA==
X-Forwarded-Encrypted: i=1; AJvYcCUHXeYjTcnEXEQNbdQ0Mu8pRpLDRXOyfe1PgHbxzDToFFOrm0AP39ZiiiozBzvrwdlOU3/DHg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2pgaFnTa5UuwkkUiyyUQWlFKRiRdVoMrNEcbnLy3PsqC/zMbl
	WcqvmLgrjtWlJYC8UclD/uSdxKWLUMXMU3B6ldqKjU+S3tFixBwH6sFrUG95nQbackc=
X-Gm-Gg: ASbGncs8L8k7FXPWbNsYoJhmCzcuCrtdD7khRUDm+AwaNEtfYFEBIvtJcWC9ij0i/6/
	gxCgVAR8POh8Ly6UgACJFU6u8+cKI7hvdxsSyKSOIdFYP1fLlyf2fv3HPaoDOsbgMgBMbonLvdp
	YttSZjR6N17EIkXa5xsIQCc5WVuk8myp7Fa+u5ERZpMScMqs/21lQiVKdoNnwgmRbY5x6xEpt9R
	R52863c0nHgCW6KowzzgJIaJrNf/Vw4qDz1PAmc5vc0UOYs3ReocuVgMr6PiOIhdHdSXVZet/Ns
	d5T9aZq5BvlRw6rLAYvT5TXkUMhmyHhIE3ujRFOouI5cHglPcOxTfcja8tsSpvytGo9EnbK0n7t
	zAv8GTc4d6AZntHeiem5AuYA2eQBBj3aI2jwLVeUtiBMG0NEZTCEi0EZVeMTO74MsiSB218Sk1V
	/UUDWPApeglK+vY6PAHJoRvKBHy9xwcXSfAcirNMru7NXjPqr0ERxrogKb
X-Google-Smtp-Source: AGHT+IGbf2POGGp83vOpbLTZgUpb+1qNJF1IH2HsPf0pbehut04M+P62HA1t/m2xT+835/Xz6BBdWg==
X-Received: by 2002:a05:622a:64c:b0:4d8:531e:f896 with SMTP id d75a77b69052e-4f023a12e7amr40334061cf.27.1764853926790;
        Thu, 04 Dec 2025 05:12:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88827f34168sm10719626d6.1.2025.12.04.05.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 05:12:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vR97t-00000005FjT-2I8y;
	Thu, 04 Dec 2025 09:12:05 -0400
Date: Thu, 4 Dec 2025 09:12:05 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Arnd Bergmann <arnd@arndb.de>, Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Alex Mastro <amastro@fb.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd: fix building without dmabuf
Message-ID: <20251204131205.GM812105@ziepe.ca>
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
> 
> diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
> index 54cf4d856179..d22e86de03e9 100644
> --- a/drivers/iommu/iommufd/io_pagetable.c
> +++ b/drivers/iommu/iommufd/io_pagetable.c
> @@ -495,7 +495,11 @@ int iopt_map_file_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
>  		return -EOVERFLOW;
>  
>  	start_byte = start - ALIGN_DOWN(start, PAGE_SIZE);
> -	dmabuf = dma_buf_get(fd);
> +	if (IS_ENABLED(CONFIG_DMABUF_HEAPS))
> +		dmabuf = dma_buf_get(fd);
> +	else
> +		dmabuf = ERR_PTR(-ENXIO);

Shouldn't this be fixed in include/linux/dma-buf.h with a stub always
fail inline?

Jason
