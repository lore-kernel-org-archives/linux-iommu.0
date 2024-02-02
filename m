Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131E2145B38
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887860; cv=none; b=lPN/2W7sKRjmEaGhbbitej/3dulDCY2vOp+swfJqpy8gCR/SKxLx9aNeBj11NEfoXKLzJ3RqjyxJFEuRHuPbUfFKy2TL+rp4yGiTmaRmL4mJL12gQdy2qd1toKh5kUiBcnLuHAu4GFK5w14qBw0x7DqHGLrG1PJBfU+hkZ9I+Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887860; c=relaxed/simple;
	bh=g+rq2ewO9SlANZTCNZuYnUw3ArChFXEF+OYucMox9YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbJuCbVVfPpuN11DjqJspsR4KC971jiP/XvckyVNz2NkaxDTy9VdSqqaNhDaSQ90TTXl/PnPPgMy4aipI3crUVhEEo/wOEQIAFzTIqm/szlnXri72oR1NF5BOomX/8t9eXoTsJX7ISC0Jo1tA5v2ZmfjmCYvhRK/tIvj2iBr2Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WheW2hhJ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WheW2hhJ"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42a8a399a9fso14541921cf.1
        for <iommu@lists.linux.dev>; Fri, 02 Feb 2024 07:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706887858; x=1707492658; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2GTCLu+HhWJpPXRCw5sz0N7u//JDwZeQij0bc9xg++A=;
        b=WheW2hhJtrgw1GHfzHq+verJ4AuL03WF1TCqktKvYPrPNH53BAourCi/2rJ2uNxXpR
         fXRNz8w9TdW3FeQIsoEmGAkx3pqFLzHhXGxo6Pq8K3E4n73NsBBtc17H4SEj2paZ+ZfG
         aT95lvtBnlXcaoGPcVpg0Du5hgQn0bYYHpVw0KiX8PcxtQ9bzVYeIhMUZSz0X06L9k79
         +Q3qa0+PWFm+AV/Bz7LbFoACprpiMQVxIXu4qQ6RcZPPDSXq94QprlgPWTtl/pWKh6ob
         VeWTh2bAyUR9aed9e7k5/AZN78dp5s/R0UxrVTCBGRaZcIpMYAl1SBI6YnWHIlXultBg
         09dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706887858; x=1707492658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GTCLu+HhWJpPXRCw5sz0N7u//JDwZeQij0bc9xg++A=;
        b=C+F7AevJ5JnjBeLeWG/ClBgn+gGGWrcvHq3mObkoiQsJCl/HwztT4Se4z5h7c0vfdV
         hnTPsbNv2uNFnIPErtYg7jqNBJspAelEA2meYrDLwvbmyBpNvzWOeMjoJDl4E6V2cDmh
         E/Xv8Wb4yp6RKx1TPeS/Jp8QKx9wOGwAmaxF8sQ/GDZQObxIzQQFCxjwBiHKMKtqygix
         uGqKuvHQbroOvMMZnc5WOfKmJV+z1lXwUYQk769vDvjamghjrZe9uNEWvfF1li+jrZF8
         8On88DWuX0duVzgJcocOlWVZQga+YGATe6hgoVtdAXLoED63UTiwm58/uYC3rMCXAIEX
         XFNg==
X-Gm-Message-State: AOJu0YyalpQPs87BlgncmW4OOBEw61HpYYHt38ezOW7cqBfxQ6h+B0cf
	TYav3gX7DiAER7COHiEGpdfkiXJ6bSJoNeiivTdjoL32VYB3qAcxlvP5LdM3b4Y=
X-Google-Smtp-Source: AGHT+IGHAQK0VVxYUF3dGDBP6087/6UJ0G+80twM6GhRPuELoqzQZO2qHch0woUVXs8ewArk4tYGRQ==
X-Received: by 2002:a05:622a:494:b0:42b:ec73:4320 with SMTP id p20-20020a05622a049400b0042bec734320mr6537798qtx.11.1706887857860;
        Fri, 02 Feb 2024 07:30:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXLr1bDM6DjTo/q48Bi0BREjw0VxWP9HD3yqZuj/ZOiBdoEuz2KzmC5SyjjfR5hsN98CjGKiJY7oLK5zCt2mqlVrGE8fGTCdUsauVzfkXr5t5DC9Kxog3ZCVMFccewsBiumS+Bryu/4+QmFxZWCzwb/CKFx3WvKgwEIoYPwOvVMJ7FXW6YL9KM=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id kq23-20020ac86197000000b0042a3358bf59sm906586qtb.79.2024.02.02.07.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:30:57 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rVvVI-00AwF5-RU;
	Fri, 02 Feb 2024 11:30:56 -0400
Date: Fri, 2 Feb 2024 11:30:56 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 06/14] iommu/amd: Define per-IOMMU iopf_queue
Message-ID: <20240202153056.GZ50608@ziepe.ca>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-7-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118073339.6978-7-vasant.hegde@amd.com>

On Thu, Jan 18, 2024 at 07:33:31AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> AMD IOMMU hardware supports PCI Peripheral Paging Request (PPR) using
> a PPR log, which is a circular buffer containing requests from downstream
> end-point devices.
> 
> There is one PPR log per IOMMU instance. Therefore, allocate an iopf_queue
> per IOMMU instance during driver initialization, and free the queue during
> driver deinitialization.
> 
> Also rename enable_iommus_v2() -> enable_iommus_ppr() to reflect its
> usage.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |  5 ++++
>  drivers/iommu/amd/amd_iommu_types.h |  4 +++
>  drivers/iommu/amd/init.c            | 12 ++++++---
>  drivers/iommu/amd/ppr.c             | 42 +++++++++++++++++++++++++++++
>  4 files changed, 60 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
