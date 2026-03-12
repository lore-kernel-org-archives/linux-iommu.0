Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35DB3B9D92
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322914; cv=none; b=YsXPxgHMpa+OBYY9MWDdIICO+OkWfP6SlFNH/MkwZ/gfI5EabBDA/ExOWrOc7ZzXa7EaqBR1fR4iOICvMegZqv15eF4hq+7xVlisydxJKj6uMKoJvk7sdmuIvqZNRbQlommIP7spRnsvIHHG7B7g0MiVUZpUUPLzgs+xrtUr5mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322914; c=relaxed/simple;
	bh=dI/azoJAlajelMailovq8TyNO1fCclqei3qlPfzJK9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D06M+DUvEIw6Gg2/sf8tZbtdCkbQGmoUf01PpGKL/a3pl7hyBMqOn2wFCNQEnG+mZPrAW6gUEjF5syozKTjPvvrxpUuK2jzDmmmKZYTrl+SOY8Xr40GUHAiwnaKvua0bOD52KDNrRGGgoVLkyEQjaD82VEog1SeqBpeWbpBD1ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BDe4PG9I; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BDe4PG9I"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-509046c5c7fso13840941cf.1
        for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 06:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773322912; x=1773927712; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o5dFx0wHNh8e3LinTTG/Y3HW59wuwEbRT1tQ1nd6tlk=;
        b=BDe4PG9IrEuyIVC22X0kbnbWla1hutUXreV6PtdCCZ9URqQEAnSFIGc/4z7/AagO1o
         +Vad1dmpP2tpWCVsbDJJw8d08GsCuJ5Oj7znbh8UJGBpO8/REsL8fGJl1pwUy78f3THw
         KFffb+Jg70Mu6T+VsikKzyEOUmpWiWRehQJ4Lo1xSeBIyrhGz++SPUviLEv1SuO0PCxO
         rNB5YXmz5QV6pLcpBsGHjaVP8fesTjkd+jY5pbzN0AMk9w+5Jso7hx3GvzUD+DYJyz0N
         ZLwm6Winl2lXkpbpI6c6vbOVMXVeUYPqhNt8RIfFtYdeClpIhGb8kSFjfckiujmIHZH6
         16+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773322912; x=1773927712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5dFx0wHNh8e3LinTTG/Y3HW59wuwEbRT1tQ1nd6tlk=;
        b=v70wZnQEmUn55jBp97AIkRgb/mN94byeSajH5088xblai04ipCcw3dbm4E/EvgmIjp
         dCDD419OcAYPcSKIcco//AAdyUdusUcsF/4zRRrZAYn3RCzqDTRN6eHIDogyqf2VFL1R
         ZMVprPk3vhUr/gA73J1b0kKuCERjSUEzwUYRIwgK4GaBLMUvhBWje5HXZlc4E62aw//u
         E5bw6EGzpWMkA/LRkRTo6rVWvCR2OBi+e+wSsvLa8ZHwB3JXTr10iF/+pgu+hBgo0uW6
         fTJcY1rfTdwru9maHU08XcMawNUkNgJe/5a+aBzUVEuiN3ZZ21B0QsGSvX/LQmzmDS73
         hqKw==
X-Forwarded-Encrypted: i=1; AJvYcCWtlpfcpZztEmb5Wmpb+DG/Ldz4WM4JPxEpFiEeboX2jSBOJGuzVncRhUSN4cLWA4ZHRBVHMw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjWP82zAVGUO4zyH5GMqoI3jt2XFqc5ejnAaLfyB49bZX6QxHn
	UdNMc+skHXWgz2JrSm4HmQnDCcvYtU0hF81kjLGV5lcZOP34Q0nGGi46xTWgMom6Ezs=
X-Gm-Gg: ATEYQzweHfhPyokvq0cIkojC4k77c6MqeISItyjhDP+LdNNjhgM3p4py7x12o7/ot7T
	SYwsfKIs/qsG+atzlxfAyHh9spm1AeU26OTIxfJ6R4Q+iTt1nITpDw5nQZBw8WZOlKaSC8nEnwi
	VHY85NGV3mqC+XA/7XnYuoIml4TjkGpeHJPug1WPYImmC4IOIqUQwqemEoZXUooPpBbwd821oM6
	6KJojbLa/FKNa6p1X2P3/GNpTNUlVWHYD/C3HcdzeDgYFb94N2AqxK8NEclVnjCsJoGcWxO+oxY
	Kv1+S1P9IB+6K9rhSq4jSFazA28d6VDyuGRdUSpWFuRt4OFAyLSTxqr9DL1aWkf1Q8aUlcMxqdd
	cqXNVYDlPtzNsSQnsKRylUtwjiv6qbLtJysPNc2gGm5VPu+ODxGoJQOcRnhJ3TZ46R/Wm+W+WP4
	EUjNWK/MFvuoa01ETZuUt2MNXHWLZzFgY1dT5T+lc9pTbfdZL53W1AylwUvWHGi+0RW2t2GGkJ+
	i1gr3gk
X-Received: by 2002:a05:622a:d2:b0:509:4d26:25d9 with SMTP id d75a77b69052e-5094d264978mr22289541cf.58.1773322912409;
        Thu, 12 Mar 2026 06:41:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50939ec63d6sm37587711cf.12.2026.03.12.06.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 06:41:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0gIR-00000006fkJ-0b7W;
	Thu, 12 Mar 2026 10:41:51 -0300
Date: Thu, 12 Mar 2026 10:41:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	yi.l.liu@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com,
	vasant.hegde@amd.com
Subject: Re: [PATCH V2] iommu/sva: Fix crash in iommu_sva_unbind_device()
Message-ID: <20260312134151.GK1469476@ziepe.ca>
References: <20260305061842.3953885-1-lizhi.hou@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305061842.3953885-1-lizhi.hou@amd.com>

On Wed, Mar 04, 2026 at 10:18:42PM -0800, Lizhi Hou wrote:
> domain->mm->iommu_mm can be freed by iommu_domain_free():
>   iommu_domain_free()
>     mmdrop()
>       __mmdrop()
>         mm_pasid_drop()
> After iommu_domain_free() returns, accessing domain->mm->iommu_mm may
> dereference a freed mm structure, leading to a crash.
> 
> Fix this by moving the code that accesses domain->mm->iommu_mm to before
> the call to iommu_domain_free().
> 
> Fixes: e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries for kernel address space")

Cc: stable@vger.kernel.org

> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>  drivers/iommu/iommu-sva.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
