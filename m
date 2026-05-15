Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2088D3EAC6B
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884548; cv=none; b=qXemxv2H7uzGJGaFVQNieuSWPuVzHuunl9uEnBm3LwPM1P7/HRTOOn1OSaUvUv+XGCmRDpM2lhBpDbukZj7WOfM8Xp7VbDok6mqI8T5qTYilW4+tRLlvtsAd4l4n7sdYX0HDA8GVaVes4XQEC8wTJZT+xj+4oNqlBDQeAkrz2aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884548; c=relaxed/simple;
	bh=43M0QEo0eyyWPrbH4y4RCOZ7Hh/aYFkSTUf2UUibSrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shJEuUtW+WxVIBkefbAd9EWKFhGwV19yJytp0E1uyYWjnceu9lZwnqp9GDAlh5N2VQTJjkA35l9TdAh38zzbqOmyZNZH02RsjZipt30Rqw2jq3auxXt1BnIejNKk3nlcEGGwiIRO8zgrl3udWxSPtq5oXUz/BqbqqxSsYCj7hwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=m7+m0PuU; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="m7+m0PuU"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8c921396e37so4542626d6.2
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 15:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778884546; x=1779489346; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TNcmCN882Y+/mpDinGleLsVSa4beLL8jNPnufICq5xU=;
        b=m7+m0PuU92SjOnUiQPEQcnX4dwOgxucagKvAu0FqE+bSKPFlrtPBFdU655cJNEf0ie
         1DfW5dmkutFJyYe4ETSU9JejeWJ7pXSZAOyk68Bij+1EWEYBsMEhvyw63e12iTUMzeNY
         n3kuazaIo1RJVJRYqAFWn3hyGSlqAZ/jZ+Nf7LK7yhsmML5WmYkpWFGxeSNMepbe5M09
         5x2/YruHSgAd3P7z2AUa9Im3pFl4bhj4IMf/FiS3nrBjXC8+x22ieaBjHHNpKrWvYPFh
         ZBshDW/VT/FN0L2dKFTX6Pj0Ol9zhqccrq7VO0gpR5S7shxz4HIDHPoC5rxOllN0LjZt
         UHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778884546; x=1779489346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNcmCN882Y+/mpDinGleLsVSa4beLL8jNPnufICq5xU=;
        b=IVzmt1JaBvuTvdtLuzT49YyVTOlD8qooNg0TDw+4sC5DZggG3jwPOR2QG+jIZ7I31W
         42IOiQ9ocPIIcS67MCA4OM6cdjlwilB3KgpFiYn4PRahCqdr5Vu5Uox8Edi1bpiemini
         ZJMfZolHML51OP3/UEc8h1vOorRwrWxquAOYk+FxyDNedlWqdNgV2JSD49RJE0P/RqUS
         eqc1MzG/nsjwKgHxMIL0fStN1/j2yhgfrGXtt2WwR5PyorL9lpbJkn8aWcY2jImEt9yL
         H4AeylTJzT1+ETjpQSw1tAcehifc2BpjRGdXK4hC7PHBmOskdvoyj3e/aWk37ggiWCxW
         LVpQ==
X-Forwarded-Encrypted: i=1; AFNElJ+AdIq69/hc7IqXrVJoZVQgotQay5kkcByl+3OOgMiN8u4QJg6XZsXl1GCgNzyL7dNAU19mjw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxp1mGZSwMTzFhjiz0jBTkPP8JDAigZK5nAiAFLUpty6p2S0Lsc
	nI5QOKYLH9OTFwd6Ne0nCAEC595njSGgQS0VI7KoQaKkLHDHqZc0l/no1JnxhAx/oQE=
X-Gm-Gg: Acq92OFTtgpctmbNswhNvpTPaPv8OHq3AfiwzbGY1jcRcC4SshPnoWmmvVkMOfyhhFg
	LDPXNWMAe4DZiFO51yRwYbpjLLNM3WsF1cWhiwD8SKRDk3QSBLq6/cobpvv1tuWEt3nttmtsNhN
	GmM4K9d3F/Wo2iqYpcMzjQsMLA1a0C3bEAf51m62tnyrd55XNLJp4XoY2P6gIuQ+u7t1qSh/Xr+
	kxL6Brq/5NeX0NMMh+LhbnC/ZHx/4nN+yAhuwWYXfjRHok0S3juoTsLNwslF4AtfQj73SspcEfV
	kz3FQYNLh0Agw5jwj4TRHKDizDyzNB6aS+XKHU91vV4mzoTiH2NUYo/dD18CHsQhGYX07aF+Bkx
	l5F2O4fDkuiEDPf47obcDCYhbsR8JCkwX+hwFNa79ampei0L1q/Ll9y5LsWjV9sf8FmsCFYZQK5
	V8IYVxpAtt6xY/XW5N+5vXXUA/7/Tq+PfAHXVGB//EGixy+WkDp/jq3XDX7vRR88UtLk4tE7vQC
	SM4WHhHQFYUXouj
X-Received: by 2002:a05:620a:4406:b0:8ef:ed0b:c235 with SMTP id af79cd13be357-911d087dccamr952694285a.56.1778884546078;
        Fri, 15 May 2026 15:35:46 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910baa3c045sm682967285a.13.2026.05.15.15.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 15:35:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wO18D-00000008EMQ-0W2r;
	Fri, 15 May 2026 19:35:45 -0300
Date: Fri, 15 May 2026 19:35:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, wei.liu@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org,
	mani@kernel.org, robh@kernel.org, arnd@arndb.de,
	mhklinux@outlook.com, jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com
Subject: Re: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Message-ID: <20260515223545.GL7702@ziepe.ca>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>

On Tue, May 12, 2026 at 12:24:08AM +0800, Yu Zhang wrote:
> +static inline u16 hv_iommu_fill_iova_list(union hv_iommu_flush_va *iova_list,
> +					  unsigned long start,
> +					  unsigned long end)
> +{
> +	unsigned long start_pfn = start >> PAGE_SHIFT;
> +	unsigned long end_pfn = PAGE_ALIGN(end) >> PAGE_SHIFT;
> +	unsigned long nr_pages = end_pfn - start_pfn;
> +	u16 count = 0;
> +
> +	while (nr_pages > 0) {
> +		unsigned long flush_pages;
> +		int order;
> +		unsigned long pfn_align;
> +		unsigned long size_align;
> +
> +		if (count >= HV_IOMMU_MAX_FLUSH_VA_COUNT) {
> +			count = HV_IOMMU_FLUSH_VA_OVERFLOW;
> +			break;
> +		}
> +
> +		if (start_pfn)
> +			pfn_align = __ffs(start_pfn);
> +		else
> +			pfn_align = BITS_PER_LONG - 1;
> +
> +		size_align = __fls(nr_pages);
> +		order = min(pfn_align, size_align);
> +		iova_list[count].page_mask_shift = order;
> +		iova_list[count].page_number = start_pfn;
> +
> +		flush_pages = 1UL << order;
> +		start_pfn += flush_pages;
> +		nr_pages -= flush_pages;
> +		count++;
> +	}

This seems like a really silly hypervisor interface. Why doesn't it
just accept a normal range? Splitting it into power of two aligned
ranges is very inefficient.

Jason
