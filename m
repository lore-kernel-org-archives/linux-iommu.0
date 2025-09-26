Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D12A2F99A8
	for <iommu@lists.linux.dev>; Fri, 26 Sep 2025 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758893450; cv=none; b=ucvMx2lfdI5IyDS7HH//TRO7J8XVs1cN8bIMK42KWa3kvf9ynjnKrgm5+W6sjXHZ4YI8GEy+PCTaN4G/Tv5kZIBvh9+1KcsbUs0+SsTfrVOBLZl/dp0fx/DobH7yv/okzjERr27xWpEPsw35L2tg8o0mdFOmAdBYAwJeG3mUb0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758893450; c=relaxed/simple;
	bh=WDAPeTdWASamb5Sw8nmHI08GbgLnSRHj5m5dE014LsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfkANLBwmZJIUJLLcT28YUqXLnXRvp+XkAPCqEiWGnoywaXLeZ75gm0i34QfWEBmXdUqaL81g/wK1S35Yw6+BtMEeFpK7uwQGfMQtcB3URcUuT8N9nJfoNafGxmNMPgqhtXrzANLZ1FnQ/h6qE8yBgnmrcEh2vW6P3p1ztsi1fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZdEUOZg/; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZdEUOZg/"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-85b94fe19e2so187187885a.3
        for <iommu@lists.linux.dev>; Fri, 26 Sep 2025 06:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758893446; x=1759498246; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xLRsRSlt7mG37V9XWV9xCd4t2Zo4mCrKKW5pZXioHmY=;
        b=ZdEUOZg/sIH4O8W84ckQLp+IIv2GtC5/eiDLyIsHSOZS0SL/ROHGWCHylta2dWhCUh
         hUzqhTj3BIvivFgu4N0IUcNKtTUWofra8vLSvZs/QYu5S3xugCwcl0yOGfl53lY2v8H1
         R0ScwvjXo5t9oemAP6T3qoB2zLvGnwRwLbR50EAjrkZyF1MzIOxAhPH7AUpDMfmOvRhT
         Us9iSoi+YA83d3fpw+6PsbeHxOWZTXHuvRAYHXlWyfNdEZSF6ft/icZVJb1W3OKcnPnZ
         xSOI9y8qRB+0HQA8c9i6l7SVCqh/fOxTw2dmHTF1dhOS87dgesoeXMRRNYb21g4CpG9g
         jBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758893446; x=1759498246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLRsRSlt7mG37V9XWV9xCd4t2Zo4mCrKKW5pZXioHmY=;
        b=A43TGBr44ulWcIdBJUDanL3V+u9zfhDcAH7mrbDn8tUEcuT0hzJQzIhEBks626SYow
         Kh/l0nK6h1mRdq60mmoVFA+u8AP4SCjv8Mb09IwUOyWy/PrdN1psuzRFvcYIRq/gtT4Z
         8pclHk3n/bAoS3F4MwXGLO6DrhfqvE5OtVyInmUSaWWkFE7gBNTXZFn2fJikbCh7bWx7
         plrE4X+G7NQwBX06uvpxMQssdrytTuKsUVUCAHDGQ6Mn+0irgP4fSu+60gm8Trui56DS
         6Gdm/Ee6tsW4l9qzWM77FgZfQSJo1DaTtGB0lZdHiGWKHl5INR6XloMiYwRVxGXLULBu
         8WJg==
X-Forwarded-Encrypted: i=1; AJvYcCWLRNSfeNlOyoTowhFRfViq/Ie1U4TBizeXOZ3MTUgnOBxR/lOvcnEjrxgzPcuJx3A4rSI68g==@lists.linux.dev
X-Gm-Message-State: AOJu0YywomykQ2rk6iJtes872RlOOEVfRLaz+JQHguNvOAiKXO7gM7UA
	kmua6GzTUPxN+L+WM5QXc2xI/UVPqMQwAIOyBIJwme1JrFF+qCH/oxjlx05a+lDhGGU=
X-Gm-Gg: ASbGncuOlV3EStHxXRcgDXaQ1+v6Mi0aulU0nq2owt9eTa3+uZG9fR8pzWFF5fHMgxa
	cVDkNBa5YkNR5q+nz5nSyWALBS5sdMC9V0dlUmEbKDAdOHCx4t1/SGrQHo2kWe0Q0otZVbCwJsq
	lNxqdQhp7cQj+EryvraA3fuxmjsJsVFsPQCk28nU/+59mSg74NaTqUwavB15+9AKxjIZdYhdxbW
	RblvcdNSrYahADXkvG28DnIj12Tv9I7gPL5nMXV22lRT+E+v5Fwm0BjPYysVmdS2UZZ29LjVwsj
	x6Vg/Rj9LtGgA+SvT6g6j5IvJXhycJx3E8rZl3LkzWsDaTneZVRmd60Ttdabpm7sbUBnO0xwpPQ
	gyppgWSAwsR5RN840MIjTiBnb90IfoJ0xI8BGy7b/G+jQIeCYLUZYoNCPh2Kmml+Zzkn6
X-Google-Smtp-Source: AGHT+IGmUInj2t11OfE9QayJFvZS1tG03tA2jxNsDGnUQinkzVVPc9HyKRtbI7dipMJQ4651qlUeHg==
X-Received: by 2002:a05:620a:394d:b0:85e:91c6:cec7 with SMTP id af79cd13be357-85e91d61b07mr712177585a.34.1758893446163;
        Fri, 26 Sep 2025 06:30:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c307acb86sm282264485a.41.2025.09.26.06.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:30:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v28X6-0000000Bndq-41b8;
	Fri, 26 Sep 2025 10:30:44 -0300
Date: Fri, 26 Sep 2025 10:30:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev
Subject: Re: [PATCH v5] iommu: Fix iommu selftest running test mock domain
 fail
Message-ID: <20250926133044.GB2695987@ziepe.ca>
References: <20250925054730.3877-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925054730.3877-1-kanie@linux.alibaba.com>

On Thu, Sep 25, 2025 at 01:47:30PM +0800, Guixin Liu wrote:
>  drivers/iommu/iommu-priv.h       |  2 ++
>  drivers/iommu/iommu.c            | 26 ++++++++++++++++++++++++++
>  drivers/iommu/iommufd/selftest.c |  2 +-
>  3 files changed, 29 insertions(+), 1 deletion(-)

Applied thanks

Jason
