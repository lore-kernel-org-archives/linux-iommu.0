Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF2C1791F2
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199684; cv=none; b=JlFCXt0ESDibcgGugyWaQm22M+PJBSas9gge75ZHVqT8YhM705nsmJ30UGJHdaTonX4s+brYlouxZe85Dr0SXWZ+LGJsmcmh/L0tuUbcEXooAaCvhWCN5Y8tpOpRyCrC7OfVce408FMZ5qG+Lawtqxumv7cFXvXf0NWRklebIL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199684; c=relaxed/simple;
	bh=uBT7vUYzRxnNkNdZfK9+gVAa0bI6bEGIF3WRyxtN3+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvludsgjAt073C5SdEa9XY9Gx4d3Hp7CUzipGFuRRBy94bxKRELHMCYXXPwxXATUbkD0E/MDXfA3DFpUOCT2sX0okRKFdYrS/l9FIMNT/Bi4HM5liwO1SYkTCQxxccqOGu4jS5xDqUKXtey3rS7gpw7OFutx6WQBAKLvz9pD0Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q++eLzTr; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q++eLzTr"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b065d12e81so12599116d6.0
        for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 06:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718199682; x=1718804482; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r+ZhQSvNAOb5p0/jqmLJRKx9ZqGMPzys9Xujkbr5NR0=;
        b=Q++eLzTrEmgOwinC22IS8R3lRWrOWGuc648T41D/SMp2HQbox15LWeyUTve13wclUr
         WToQY95vSvvZO7nzxV/jb26j5F85ZDfKKIsHSUqV5PU4/yjDgxseajDLAX7FpUDCOauO
         RigywyulukmCJsJg1+0n0KVvI82bRYTviY4CCmTCoum8iuAiq/gBb7xiaGzfcJv6fJGc
         rYrmpYqRl0E3t7Z8Rr80ojDiwZrHa425pvnXIOThVqvt7FsJLqj5FCFjXsy/XLYP5qyt
         bKwiF1yqlrst79QxTF1nTSttU1riDtBm/X3toFrXpxRVQ6u0NmR/jQixuKlB0y+0beZx
         lDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718199682; x=1718804482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+ZhQSvNAOb5p0/jqmLJRKx9ZqGMPzys9Xujkbr5NR0=;
        b=IoOjTul+M302HfIsa2bQPT8dgo0Qj/eOT5Zlqer4ESpNuCbViljMdsFwSrWEM+60x1
         jQuRt07vtQviGCJY1Zm6kyPiPletZ5jwGAjZmVVXAx+EFinhlrfpMT9+Kfyr3eeXziMy
         uwT/3n4ajNZJsWAoUkVN+kZVSnR4+g2SvGuhidb/7/LoxeplBdKv1Mf+TAGMy8w9k4U7
         sYI2eHlOLCliH9e6GLuT2srKvLOQyT22z2pjl+cXOT0tWQ5YG4XThA1xa7yLR+PUVaLg
         vW5aN9YsPzSSW+lOe61TEu0M/nYcvVaAR/bW/JO3hWQtdunRrO0OczkPSv2rBAnnjNWe
         oBxA==
X-Forwarded-Encrypted: i=1; AJvYcCWsPgc3MQydYjTnCfYLfQmDcyXnYcLFI3gXNU2c9KfHxX+dhVefFDJvE/A2C9RrwSEdjpoq7cfBAUGRH6i8R0ZU31V0TuA=
X-Gm-Message-State: AOJu0Yz2KPGbkvIz9+Mwec+DdoQAEukG3lYD712YfY8ab3Y0nKwOOVZO
	VlfPpGApy3EiK8Ks8nXxxywXAwAP9BeiQtKcUPkC/oUCBHYKNn+1qPEihUmRBmo=
X-Google-Smtp-Source: AGHT+IGj3bA+oXPOoBvMCn6FAi2vMePmynyM2+Wxv1k8TreF0ZOFdKJAdWV4ii1y8EtkVeqRq9O4sQ==
X-Received: by 2002:a05:6214:5d11:b0:6b0:7270:104d with SMTP id 6a1803df08f44-6b19fb9fc09mr13439486d6.29.1718199682399;
        Wed, 12 Jun 2024 06:41:22 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b091d55c30sm11975046d6.87.2024.06.12.06.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:41:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHOE4-008y6B-6Z;
	Wed, 12 Jun 2024 10:41:20 -0300
Date: Wed, 12 Jun 2024 10:41:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 04/10] iommu: Extend domain attach group with handle
 support
Message-ID: <20240612134120.GX791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-5-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527040517.38561-5-baolu.lu@linux.intel.com>

On Mon, May 27, 2024 at 12:05:11PM +0800, Lu Baolu wrote:
> Unlike the SVA case where each PASID of a device has an SVA domain
> attached to it, the I/O page faults are handled by the fault handler
> of the SVA domain. The I/O page faults for a user page table might
> be handled by the domain attached to RID or the domain attached to
> the PASID, depending on whether the PASID table is managed by user
> space or kernel. As a result, there is a need for the domain attach
> group interfaces to have attach handle support. The attach handle
> will be forwarded to the fault handler of the user domain.
> 
> Add some variants of the domain attaching group interfaces so that they
> could support the attach handle and export them for use in IOMMUFD.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu-priv.h |  8 +++
>  drivers/iommu/iommu.c      | 99 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 107 insertions(+)

I don't have an objection to it like this, but I wonder if we could be
smaller to teach iommu_attach_device_pasid to use IOMMU_NO_PASID to
attach the handle to the rid?

It would have an if there to call the  __iommu_attach_group() instead
of the pasid attach ?

Jason
