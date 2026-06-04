Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5990413D96
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583229; cv=none; b=JVhzwZsI57x/f7ZfqMKm3WipMTC+NC7k72P9rJQq5g3p+avG+yuwuVJayju74M+W/9iW5LdA+gwiemwEsYRf4qqZcEWIFUc8oDrjBmyZd1SDhPnRattzaLA3+ijMxeRWlNez/36g01rHJ/6+va6Xn5fLpIi0oiey7VcsPfn099k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583229; c=relaxed/simple;
	bh=R5hMbnNS12FEIZNlNB/bpEoNfDKSllPhXOnCYKccGQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvH1/u1TluhP6dZ9AKc8Jji61AUPJBskNAbXqVbsL3xommmNIncgbFR7OuPHUrYpwl9pvRUQEb3T87iK6XTspY179X41DQGY/MHscpxinOEQUb7fdxuL8dZmvN3/UW8snKoBCaexykeU9z7Zve6c2zB+0N9PlcRSmSDfTJ7X42A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=A1ighxUc; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="A1ighxUc"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-91574384cc2so89778985a.2
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 07:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780583228; x=1781188028; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rHKibgV+RCLusPgB3KbLwXXB/tqYgf/ZSAW8CwOeGIc=;
        b=A1ighxUcXjfV7X+h6CR21LWl6Ynyc6ZcDyprMPUSCsmgJIeMHI88TkpbP7/1mG1mz1
         P+5qXs6lQ4wmo8I85yS36O8F8QRZMTc490v3fxoKA9potnWNtILjZZjkaeYAVYXbFnfj
         oTc3gY2ybrJx86ihVy3V3Ct/9I+u++S3K6pW7lLMcRENs4jmVVQ1T+QGcTVJu6ULxFUR
         mfa14LrEgM6sIw5r661vYNpDHd2NVJPmTqzU+iNK5yiYRu96Wsv+wRPq+E0Ndm3p5h4m
         KxE9srtNXzkD8HmfqW+znzTNwX71A0b8JlIbJR4cYSCGdFmGYawcPbls9Z5SZmLsF+2e
         yTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780583228; x=1781188028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHKibgV+RCLusPgB3KbLwXXB/tqYgf/ZSAW8CwOeGIc=;
        b=Mt53fBL8pJjl443Df720juVsRCq0pPIkQqtEHHLpRJAEuv9iIwoi2PGpQfROIo0hYG
         mqHpAqVaK7+XcoBiNLHLVVmCw6hQSOdGEmi8ahKg6E03b+C3wBpAjarxajY/vTeimdyp
         E7KNhywa0aOJJYDrgOzMOgea668cX40O7k62zVHy0Wev3HUPlWUbw3jbxiD0FFiQZaGd
         +tRFdd/81EnNHg8/uR5+IMiAULF9eM902uWHGFf0jYo8r0XYeYdqY075qber3g/nDv9D
         I6vrJI0/VpzZGSjTGp6SljrKjH5Gyq8L/KBbs0M1XeLT5qHh2g+icODr5z1+GgwzNI8w
         ALcw==
X-Forwarded-Encrypted: i=1; AFNElJ+IfgUqt7SbMtWBVpwIh1gE3aUL7WTtffiwQjgUScceoMfiTmsLQeNi831xZuSQMVWpP+xzYA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUb0/19K7NCPNFfzriCGa6M+1TMDzCtdOrM0h8dHZ3Emvg7qFw
	jObK1Ydr1AOx+xTukwXUIftIAo5GL2Q2s3KSi1TJqB/E4SpC1oEJxsCwpcJPG3SsrI4=
X-Gm-Gg: Acq92OHEIrTn6c4/4sTcENw/F8GkYVcUNOz2Cb80EVr0hP8L0vA7eV6BTCBIJsnJBlj
	kEiNxfi3RLE/fXHR0og+Qn6zXJZ6GMUBZx0W2HesnBhwuGRWcciTlGRWjIrgHLlN3K9YmKXYlo7
	LwK1vdt+W552HNnAxGY86dxJGjp7bMtTXSzyGPtAGpHOpYuFHSZGHo86kIQw01aKvEg4mqKV93Z
	wN+zd0ZatuK6Hw0pUlMJimGxLEVuYzoSYpZxbmi+sn0KM6gSkt/5lOPDtp2xm5Ndx+QjBUcpCSW
	aJOwjXPvXwOqI3/FyTWfilN9q9R/CXVtkqlfVDB9wYipOptvdVluiVp8FvXhwwUU8xURHmoEjdN
	N20/B/WFJIuCpzxtnKyda3UuQF/Rdu2WgTzHuVB5qNBlzcupH3bz4vmq8nPYxpF1ECQ6r+bq617
	5UjnNWA6ueoluEQSiuQcyqZxs2jrnQD2u8YQYwY3E0DQw93pJARTspDxg771SoLATsUYmLTfjIO
	ayUYHnbTJF1xkwt3FeZM6KXZoU=
X-Received: by 2002:a05:620a:6cc2:b0:90f:b39e:ec8 with SMTP id af79cd13be357-9158a6998c8mr1313811585a.17.1780583227568;
        Thu, 04 Jun 2026 07:27:07 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3e0d55sm600410185a.43.2026.06.04.07.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 07:27:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wV92I-00000008IGV-29F2;
	Thu, 04 Jun 2026 11:27:06 -0300
Date: Thu, 4 Jun 2026 11:27:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
	alikernel-developer@linux.alibaba.com, baolu.lu@linux.intel.com,
	boris.brezillon@collabora.com, dri-devel@lists.freedesktop.org,
	dwmw2@infradead.org, iommu@lists.linux.dev, joro@8bytes.org,
	kevin.tian@intel.com, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, oliver.yang@linux.alibaba.com, robh@kernel.org,
	robin.murphy@arm.com, shiyu.zsq@linux.alibaba.com,
	steven.price@arm.com, suravee.suthikulpanit@amd.com,
	tzimmermann@suse.de, wei.guo.simon@linux.alibaba.com,
	will@kernel.org, xlpang@linux.alibaba.com
Subject: Re: [PATCH v3 23/32] vfio: use iova_to_phys_length for efficient
 unmap
Message-ID: <20260604142706.GZ2487554@ziepe.ca>
References: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-24-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603151804.1963871-24-guanghuifeng@linux.alibaba.com>

On Wed, Jun 03, 2026 at 11:17:55PM +0800, Guanghui Feng wrote:
> Use iommu_iova_to_phys_length() to get PTE page size, allowing
> traversal by actual mapping granularity instead of PAGE_SIZE steps.
> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> Acked-by: Shiqiang Zhang <shiyu.zsq@linux.alibaba.com>
> Acked-by: Simon Guo <wei.guo.simon@linux.alibaba.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index c8151ba54de3..115d88d7003e 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1177,25 +1177,42 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>  
>  	iommu_iotlb_gather_init(&iotlb_gather);
>  	while (pos < dma->size) {
> -		size_t unmapped, len;
> +		size_t unmapped, len, pgsize;
>  		phys_addr_t phys, next;
>  		dma_addr_t iova = dma->iova + pos;
>  
> -		phys = iommu_iova_to_phys(domain->domain, iova);
> -		if (WARN_ON(!phys)) {
> +		/* Single page table walk returns both phys and PTE size */
> +		phys = iommu_iova_to_phys_length(domain->domain, iova,
> +						  &pgsize);
> +		if (WARN_ON(phys == PHYS_ADDR_MAX)) {
>  			pos += PAGE_SIZE;
>  			continue;
>  		}
> +		if (WARN_ON(!pgsize || pgsize < PAGE_SIZE))
> +			pgsize = PAGE_SIZE;
>  
>  		/*
>  		 * To optimize for fewer iommu_unmap() calls, each of which
>  		 * may require hardware cache flushing, try to find the
>  		 * largest contiguous physical memory chunk to unmap.
> +		 *
> +		 * mapped_length already accounts for contiguous entries
> +		 * from iova, then try to join following physically
> +		 * contiguous PTEs.
>  		 */
> -		for (len = PAGE_SIZE; pos + len < dma->size; len += PAGE_SIZE) {
> -			next = iommu_iova_to_phys(domain->domain, iova + len);
> +		len = min_t(size_t, pgsize, dma->size - pos);
> +		for (; pos + len < dma->size; ) {
> +			size_t next_pgsize;
> +
> +			next = iommu_iova_to_phys_length(domain->domain,
> +							  iova + len,
> +							  &next_pgsize);

vfio should not be calling it twice, the core code needs to give the
best length as efficiently as it can. not open coding this in callers.

I think I've said this three times now

Jason
