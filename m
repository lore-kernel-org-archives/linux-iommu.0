Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3794218872A
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 01:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448920; cv=none; b=hUVIFb7L0C0LoGnb4TqprlezCyS/ptSu9WoLDxmybRYRlIpAziPbplT0RPqGfxBx548OaPLGzu5dQW5MIB1BBERJRwrMz+7qKDNfcXyqBdKRHsIdaBql2lxjuS9UPc73Yf6SNaGzdy27qvcqiGh0+LDdjJsqtkO0z7wP22HAxTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448920; c=relaxed/simple;
	bh=Ci2pr2kYm3LPu9lpXp+7i4ynWp7NmN4d4je3ZnENWUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icp2lpoQBEYDFFl58yfldmWrCVuBA5A8ciJwFUymW0U+bDWUdieI77AAFEyqPzisVWQk0YAfB8yOprCeJn0nH3CuSVf0bH86V3cIuZt1w4V6wkoaLlG7YXHwYh4gLsoOuT8EAZKTxmVFPfNHLbiwvuqOEvP5CSCVy2WOWO70cyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NkU+7r9R; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NkU+7r9R"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-91587626a3eso92430285a.2
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 18:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780448918; x=1781053718; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5b1waI30m43a9rgbDHZrFDb+c/4Zyp2tRTfYwiyzcxw=;
        b=NkU+7r9R2zfzdcvV97Q+YbEGGlklHyxpzKpUg12+l+THETnj4kvtpbP03imitStjVz
         v9jkEQSKkiy3/4wrXMNezsog7FAi8MDNSDyYp2KrDrLL8KNTGZUTxyY0lGGRutidCqf7
         N1TxM3cPfIFG7/27uc4Xl0StRqrjeOV7BuWfjb/lKwtS1vyMzT8Ad0yZ6CobgEG/xRaA
         i1AgPk0MBdvWP6hYtCRY32PQd2dbqYkeSiV2Zcx/k2uTr97c1MfBE03TBhcQqFfydFRo
         t8lDChszJFgdkL/pV2715ZEE6leD8N/K88P47KR2cUA9Eb+x/iBCxcqhNIE0NwFTOTHx
         DWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780448918; x=1781053718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5b1waI30m43a9rgbDHZrFDb+c/4Zyp2tRTfYwiyzcxw=;
        b=mdjz4rAd2k6ws0+ZelLR22hlLWJT9TZxHIZvlpci5TnIfBn1e1JIDxzdNfN9FMEXr/
         TocDbi/gWhnXcEqcIta3PhM45FLQv8RtYPiIi0Lh1rKRpR/GPoUcZsCwNotC5OBZRIFd
         O7YL47V6mnJKrASeu8wN0EQ4dc+XSdjGQP4z+AJNROeB9ELf+sPa3TjHSWM87d0RXASz
         d2E51Qw/qedJmRaFg8J22Blh7W5UrdeumfaGk8fBLv+mVDxsU/xqt1Zd+xEQw0dOle4u
         EJgErsvWx9sha0uo76cOhBS+CKy3SiPXPqjWYVW85sV9+VcDFxxqh3IHuCTMLqHg1dzf
         HGnw==
X-Forwarded-Encrypted: i=1; AFNElJ9MLdWut7otQa5t1f3mRbdOiYdB482qc5yOqt+2W6qkCVH4AhdsQjHQkdeK4QsIfLDh4UH8Ag==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+RmdwY0ARc5dqBbCDbl9IFh4QqpPxXsx6W8A8xR0v70mq8Gaw
	a+oKeU0FYF03Qn5pSf4Isq1u0POplSCI6RKy0y2pC6d/cjI07mI/WIS0dCtJp0Ch16Q=
X-Gm-Gg: Acq92OEmoHB3ACWzgtn3lrPS8bPBtIzMTJbgbmxeF5RTvABbgSPbG3yjEgIdD9yj2FI
	mZmM67uvXGtw1XVhXUTmUBOTCtC5/iQJMZ4TwqCG6pFmEerCITkPhdO+Xtcy1I0ippPPa6y+dCb
	vvW+Kxk+Cjyvrru+9s/mcrNxxm31qLqmh/7qIVmQi7iYDMBoqydaoAyujQ6EFmXqJUpgeC1E43Y
	BFeX1sMUFdPBOSgA7Kx+IMy1NXfkuCSabIcQFjOTPcUI2QCEDWUk4jxC7D9x++r25YbOCm38o34
	tf9ZOQp9OKD3febYniUahpDs7AeyfRzjhUaxYCgoE1CBo9SWCb7yPL35iQI1QXvAJKbwn7fEwGS
	qbn/VFnmOB63hy/XOQKBv0AF7vh99wFqqaMnYVutTT3M5L9yh2a6yIKZiIU+cfTXWyEJbX7+ivN
	8eYoGWhN/pSchpO6QhkINHRivA/mb0gfQDtc61shpBVKoWvRhpxJCJun4gxZKalt8ZyUUDBYARc
	t2iNqAQ2rJzgO42
X-Received: by 2002:a05:620a:1722:b0:911:de69:ee21 with SMTP id af79cd13be357-9158a656dbdmr268795585a.11.1780448917995;
        Tue, 02 Jun 2026 18:08:37 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a37c50bsm99840585a.24.2026.06.02.18.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 18:08:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUa60-00000004yEH-2fsG;
	Tue, 02 Jun 2026 22:08:36 -0300
Date: Tue, 2 Jun 2026 22:08:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
	baolu.lu@linux.intel.com, boris.brezillon@collabora.com,
	dri-devel@lists.freedesktop.org, dwmw2@infradead.org,
	iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	oliver.yang@linux.alibaba.com, robh@kernel.org,
	robin.murphy@arm.com, shiyu.zsq@linux.alibaba.com,
	steven.price@arm.com, suravee.suthikulpanit@amd.com,
	tzimmermann@suse.de, wei.guo.simon@linux.alibaba.com,
	will@kernel.org, xlpang@linux.alibaba.com,
	alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v2 01/30] iommu: introduce iova_to_phys_length in
 iommu_domain_ops
Message-ID: <20260603010836.GQ2487554@ziepe.ca>
References: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-2-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602104637.1219810-2-guanghuifeng@linux.alibaba.com>

On Tue, Jun 02, 2026 at 06:46:08PM +0800, Guanghui Feng wrote:
> +/**
> + * iommu_iova_to_phys_length - Translate IOVA and return mapping page size
> + * @domain: IOMMU domain to query
> + * @iova: IO virtual address to translate
> + * @mapped_length: Output parameter for the PTE page size (e.g. 4KB/2MB/1GB)
> + *
> + * Like iommu_iova_to_phys() but additionally returns the page size of the
> + * PTE mapping at @iova through @mapped_length.
> + *
> + * Return: The physical address for the given IOVA, or PHYS_ADDR_MAX if no translation.
> + */
> +phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
> +				       dma_addr_t iova,
> +				       size_t *mapped_length)
>  {
> +	if (mapped_length)
> +		*mapped_length = 0;
> +
>  	if (domain->type == IOMMU_DOMAIN_IDENTITY)
>  		return iova;

This doesn't seem right. It needs to return a mapped_length of
something that is not zero..

> -	if (domain->type == IOMMU_DOMAIN_BLOCKED)
> -		return 0;
> +	if (!domain->ops->iova_to_phys_length) {
> +		/* Fallback to legacy iova_to_phys without length info */
> +		if (domain->ops->iova_to_phys) {
> +			phys_addr_t phys = domain->ops->iova_to_phys(domain, iova);
> +			if (phys && mapped_length)
> +				*mapped_length = PAGE_SIZE;
> +			return phys ? phys : PHYS_ADDR_MAX;
> +		}

Follow success oriented flow..

Jason
