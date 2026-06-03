Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA052D7DD4
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 01:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780449099; cv=none; b=Qjh/9UqpjDU2Cow0VCzpLFN+ZLhxqA+rpf/qHJA/W7O9Apq7554o9uHIzPd4l+l4QC706XLR0UQxcdVIB3nCoNApU95Cz9COfy8sebFMrz1eWyyXohqEW6h69mQn7lX+Z2gOvfi8FesfBND9kh5Ta6v6w30ocwH8h9yTSYjptHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780449099; c=relaxed/simple;
	bh=Mo+6uIwlljg7HEKWxoRbh7QUYcSwJ8ALJpeg6fpri34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKMAcTid7+759dYnO8ClFPcHH2TjGByiEoWgfPzHbPvbpVBGoAHggqxkFikJIvh2HXIaOnRWO5CifKbk9EeNOanCTy+ifz9K4O0Wxv5zMO9N6aiU7dJlrmteqncnvjb1iW+zoFyl7tPxfS9s45XzmpU8f4dro/mNx6Hnp0xqDyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kpIpbqcb; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kpIpbqcb"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-914bfa75911so19462085a.1
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 18:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780449097; x=1781053897; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OkcXxIwae3ZkBqRFobExjF5BmBij71a6Agx7B+x/coo=;
        b=kpIpbqcb6jYDHsX6hIpaKv6zgcWP77ZizV++emflmArHatVJsqDqhbzbE48By8REjG
         BSHi3d/dKOd4BQv2bbSuXxwvacI3NDIaUxLW0B9n3kJygd8DQnMbepC0chvJuGmCAKLI
         ZcGyvkZE+fcM1Y4fvxAMkk1n5XKLMUWaaRD7/xJZnVV1GSASCloG30Xwfhs2sV+3b6ZX
         xKsIiZT5d7IjmYTFUaTmym0rmUSrKRZvlnh9OzLvn07twgx5H9TKxno/AH+Np98EBiuw
         dPb+x6Rh6x9pbrhLAJPVFMMgJCUnKDFAUWCIFPDo/LvaC/eBLSD8sBw60qOqb5wYALsU
         eDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780449097; x=1781053897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkcXxIwae3ZkBqRFobExjF5BmBij71a6Agx7B+x/coo=;
        b=i/lehQzavdRZiwR6jIywTmT/OH3FnKY3gKMQu1VikRyuGAT+BxVhyQcUuqJcBArvFp
         aWQxbx/L4pFpCuEW8OvCnFaYLkNYrS+A9h2d4RZVI8IOxeVmR6H32+wcPPtsyMBcdF2r
         wZy9tbez9Jfj/QQfO9ibi41tTJoM3Y1Pk6S6l/GPNGFUqLaAEMnop4WYLycVwn3yImu/
         d+C4Bx9Csb+7cqmFKNCE4o46/D3aMxFDx+ZOc9IqJKg9892v+URHIexz9mrVYNsZ6jmR
         C340f9q6N7RSj3b39Rt1D8yAMV+tMEZYZlS3exF/nLEPpFrr1xosxNX6YBx4es1tuRWJ
         oEYA==
X-Forwarded-Encrypted: i=1; AFNElJ+89UPhnNDr2hb5nIV1J8sfYQ1EaeOwylFVd5E0Evi1xxSZLCrYO+dJk39KwNAe/YFcxE6BUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCq1c3KOyEQklkglt30Mlkt/pOoGzfe+us7IvhjKfljbOVe3zh
	Bk6kSxZUWySN84jr2AHCEZban/54gPj+tf8GT/ZoWaDB+t2hQPYcoUwwfuEC/gudUd0=
X-Gm-Gg: Acq92OHlOLBOEj08BuqIJKmAQ7dY9/rIPbqPL0I2ZKC4VvrNXOCGx4wPJt2+RYzktpW
	FLcOE+N/fmUSCDCbrkKs61DwlHjWl8UpcsITk2TfxWcDhMhyYqAiZB0gvhJgpcK5VTHi25kxQoJ
	S7L6rkmODaNmvF+F29XsSNXDJD5Wxp4S05uv5tAd0gCErtzcWDoihX+LnxzJqraN5n4TBW1DbIV
	XWBAaGeWnJrOWbcDheVZYTWZSsACf3krU5/1xwyGyxEn0Gt9zjvACx3PBKSWvlr62SIU9/VBP5Q
	DeJJ8jJgE6sXZDjg7WfNGsGQAAo/XROIsBO7AihFjvU1BRs4RsBBu4p1H6l4e7sVhuEKCPb4ggG
	TO/S2upeD75xfP6nn/fqKWn4nrOzcCVACw1BhjuxEdz4THxfh35KtO73PCvlW83BaqeEycAMldl
	fCkG9siA+JNZnlcwTDYMODXa2xBoxi+81K7bQYsd4Ec2A4FUH+f/JcBRfUjRO1ndlovnbQjh6Be
	8YyooraN0EDYaJBqnWQeDNjoqk=
X-Received: by 2002:a05:620a:31a9:b0:911:c5c0:d5f2 with SMTP id af79cd13be357-9158b5cbe4dmr170236985a.1.1780449097421;
        Tue, 02 Jun 2026 18:11:37 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a009fb2sm107640685a.5.2026.06.02.18.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 18:11:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUa8u-00000004yOx-1sfF;
	Tue, 02 Jun 2026 22:11:36 -0300
Date: Tue, 2 Jun 2026 22:11:36 -0300
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
Subject: Re: [PATCH v2 05/30] iommu/generic_pt: implement iova_to_phys_length
Message-ID: <20260603011136.GR2487554@ziepe.ca>
References: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-6-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602104637.1219810-6-guanghuifeng@linux.alibaba.com>

On Tue, Jun 02, 2026 at 06:46:12PM +0800, Guanghui Feng wrote:
> +static __always_inline int __do_iova_to_phys_length(struct pt_range *range,
> +					       void *arg, unsigned int level,
> +					       struct pt_table_p *table,
> +					       pt_level_fn_t descend_fn)
>  {
>  	struct pt_state pts = pt_init(range, level, table);
> -	pt_oaddr_t *res = arg;
> +	struct iova_to_phys_length_data *data = arg;
>  
>  	switch (pt_load_single_entry(&pts)) {
>  	case PT_ENTRY_EMPTY:
> @@ -159,45 +164,53 @@ static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
>  	case PT_ENTRY_TABLE:
>  		return pt_descend(&pts, arg, descend_fn);
>  	case PT_ENTRY_OA:
> -		*res = pt_entry_oa_exact(&pts);
> -		return 0;
> +		break;
>  	}
> -	return -ENOENT;
> +
> +	data->phys = pt_entry_oa_exact(&pts);
> +	data->length = log2_to_int(pt_entry_oa_lg2sz(&pts));

I really do want this to accumulate the contiguous length if we are
changing things like this.

As I said before only iommufd needs to do this, the other drivers
don't have to, but the wrapper should take care to give a consistent
result so we don't have callers open coding another inefficient loop
on top.

vfio and iommufd should call it exactly once and then move on.

Jason
