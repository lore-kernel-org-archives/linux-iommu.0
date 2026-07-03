Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39A8305047
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783098623; cv=none; b=A4AyNLaZjEBKEMmVRLClEpswAsIJo2Uj/vUGdqml5WV1XT2RT1layN5K66huk9T3MpN30XtkhrK3OA6qDNK7g9VZaAdga/l5iUKBK+548ZVSgGou5TafqejDnIbgichDTLtR8xrfl5KuS1wnVAHoh1RjbIUIYr5v5CQB/1oQxz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783098623; c=relaxed/simple;
	bh=JqbyUGSlLgU7xpTZ+Kst/HuDrhY2T70S9MikqXlpd+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sT9cO1mKiQ9TjQlPTxCiC6570RLCjiKU49B5N5y7ibOT7wjbfPyC916wqaOTWh0gRgX4DvrX8ZpHEKV9t6aqJYiYObse5LrRxUQOC71DqF9/f7TSWN8HPt3jUGhNAdfOelQilxClypjRjOhM0Ull0o3Hm8rNlmPA9nRvx1LiHtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Tj6hB6Gp; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Tj6hB6Gp"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e50979c71so70642185a.3
        for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 10:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783098621; x=1783703421; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n3oZ+zgqAAjsMiarR8e3Jw/svVLzceSmIMfYpYh96XE=;
        b=Tj6hB6GppG3dfVsemRpf93AmOp8fn/6nLFnkzMw8+cuGatgVK+5pWSJbWdsgR8qo/K
         Vvd7tyajtk9HB9aimQKyYH40VJg+gzSPnfVaoQa1fcIhobGnHVeRe2aHZ7dbCITyYzxL
         WGAdOCeOg/MZZfruz5/ZZE6v1f5sOVaPwdSaXXoULe/ZF+IZniV2HbRC4DfCA9pAWcTx
         KepuBmzjzMjsQ84yxYFy2/rLrQo5QgNxjthTzvRaC5k8vWNzJQ1yrCSIUuXv52yCqUcj
         0tFylbwCX7Hpr57lRSAYCaNoFenpipM+JKjieeRCYOVUOyzYkb0dneerNU67h7L1sXCs
         tkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783098621; x=1783703421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3oZ+zgqAAjsMiarR8e3Jw/svVLzceSmIMfYpYh96XE=;
        b=If6BPBY0RzSmWgHQs3HxNyqU1n09vfufixAG+P5SkGnaoCdz/eWz3Jb8j3MDrOkddm
         +BV5sXr963ZmLJPFcARQzNG5vrY9/ujvST7wxAic4ZMAHad2Xy9ISqaaOeg6/T1Jc7fG
         B63t3l0G1PxHeeRWqwbll6GtWagbGzTbSLha+S07Lxj625qnvSwwdOeN+S4Rhq3OBee/
         /d4lI6Pzefnf5PbKaT6xPW5oZZi+rWDl2qj0xzz0O1a+J3EkyaacK/oW2/VV3A5XZjJw
         gQ0u1VcBayjQDxss9dsYk2CbAtE3PaLEuAwNORI2Tv7Ng3ptv+PqMMjNPCEnMSj1ybLx
         nl2g==
X-Forwarded-Encrypted: i=1; AFNElJ9bbmPBxSzcUdeRw81xZRNI5mmBbpTc1HuICdYwM9A0t/lk6j9/j56DJ6sZa2nZUjeSCTvIkw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzeSbQxudBil3y/5n5UnCJrWrZUgERR/3v7I1ikJD1f7FbMzqhF
	AYS6QV3MxjQ0I9Ai61YlhiMKhbTgEL/FmTSOO9+ne5+W0X1dO8PvVz3qp2raYicfqOo=
X-Gm-Gg: AfdE7clrRIdqgo5e3x7y0L8vvx4he3SHxxobwxaMXZT4B0wnIULXZDEU/pJZ48T/606
	QcCioSTTDVX6VN7SC3oteCYrD6CHDjI9R6QWYW4R/fC1LW7aNs4+chX0djyhdPlG3LdQoon5i4e
	2j0kI5XMyBp5/O7M2ArtTIeK35ILVCY0/yxjkT2bVeH5cNyA0By26HKr5VjESUs2ivc++VQ1u/l
	zsnoEBPBghoxOmhd5MgdYjazB32v082zVv6wzbpYRRGRg4D2LhdOcq/kQLzs7zkFBe8UrSWHEEj
	niKMHoKOZTMC9DY50l6gH3/jzNPD+4lkXund+RX6t4kmLSVl6rE4VWaQv69jEJU2+fY9pdAOhmF
	HMQMBK5aLOqKN3VaXk/ynAUZ9vULlFAyqeiDkGruFjnRqh8kFxloPmGRbgx76mcnKl//jYtZxI8
	NlApQWAgQy2GbqoZazMUD/6RIAcqoKfoWxn2HRjuyk7KGJTBV9UcqIXhyTC5dC10h+sfQ=
X-Received: by 2002:a05:620a:46a5:b0:915:5379:b511 with SMTP id af79cd13be357-92e9a48e177mr44923985a.43.1783098620659;
        Fri, 03 Jul 2026 10:10:20 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90cbe3e2sm200315285a.35.2026.07.03.10.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 10:10:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfhP8-00000008GuS-3eyQ;
	Fri, 03 Jul 2026 14:10:18 -0300
Date: Fri, 3 Jul 2026 14:10:18 -0300
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
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	mrathor@linux.microsoft.com
Subject: Re: [PATCH v2 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Message-ID: <20260703171018.GA1968184@ziepe.ca>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-5-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702160518.311234-5-zhangyu1@linux.microsoft.com>

On Fri, Jul 03, 2026 at 12:05:18AM +0800, Yu Zhang wrote:

> @@ -401,10 +402,74 @@ static void hv_iommu_flush_iotlb_all(struct iommu_domain *domain)
>  	hv_flush_device_domain(to_hv_iommu_domain(domain));
>  }
>  
> +/*
> + * Calculate the minimal power-of-two aligned range that covers [start, end]
> + * (end is inclusive). Returns a single (page_number, page_mask_shift)
> + * descriptor that may over-flush when the range is not naturally aligned.
> + */
> +static void hv_iommu_calc_flush_range(unsigned long start, unsigned long end,
> +				       union hv_iommu_flush_va *va)
> +{
> +	unsigned long start_pfn = HVPFN_DOWN(start);
> +	unsigned long last_pfn = HVPFN_UP(end + 1) - 1;

Pedantically end can be ULONG_MAX, you shouldn't be adding to it since
it will overflow.

> +	unsigned long mask_shift, aligned_pfn;
> +
> +	if (start_pfn == last_pfn) {
> +		mask_shift = 0;
> +	} else {
> +		/*
> +		 * Find the highest bit position where start_pfn and last_pfn
> +		 * differ.  A range aligned to one above that bit is the
> +		 * smallest power-of-two region that covers both endpoints.
> +		 */
> +		mask_shift = __fls(start_pfn ^ last_pfn) + 1;
> +	}
> +
> +	aligned_pfn = ALIGN_DOWN(start_pfn, 1UL << mask_shift);

I think the whole thing is simpler if it stays using bytes until the end:

	sz_lg2 = __fls(gather->start ^ gather->end);
	if (sz_lg2 < HV_PAGE_SHIFT)
		cmd.sz_lg2 = HV_PAGE_SHIFT;

	page_number = (gather->start & ~(1UL << sz_lg2)) >> HV_PAGE_SHIFT;
	page_mask_shift = sz_lg2 - HV_PAGE_SIFT;

No overflows that way either

Jason
