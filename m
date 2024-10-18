Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D4418FC79
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261423; cv=none; b=lnlfzxSMb6nBbw/rCD0HzgaMDF13P5zQH9tNCZEfs+iFiE+L+Mwt7YT0Qd+5fvScQbUCBqSrkMLC9M7dcc40NHm3HU9vn0VSLnNZbDRnC9UVxPmMtN0f39yLVJZKzuZSDZC6z2IvblYiEsJPWpMa8BqSpglF53yhL/AZuyF6XT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261423; c=relaxed/simple;
	bh=tQcELO+OmlUo//8UdHjHB2/a3YwsCpFmD+QgnEJZ9vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuP1RxAPidREaTIR76ACg9OjcQB2NOgGMWfTfN+CCYdNqtUeKTrgwmJeGnCkj1VSFky6V567/GBZPwoMT4JSAE44o/GxT8RFacK28W5gCgls/L9GNj2EpvSK9pgaLeNXkWQnsVH93shUpNE98xpW5OlplU2LPF31upF3bXsxRa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XjIPYtfe; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XjIPYtfe"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cb82317809so14306426d6.0
        for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 07:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729261421; x=1729866221; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+4gEdB+5JYvJCAfWZebjhnmH+RSwlxwFHuuYfx9k9+0=;
        b=XjIPYtfezDzXKC0ovfMpgiWNl5HsqfqJrD92C/qwn0NAzWzICbrMqwyg9WpAyrAkVU
         iVYU9I+qs+V3HrLzu0aYEAIrF3MS98D4YPF5t6yMFv0qX8DKyhvN6H9ExarvGqwK6koF
         ype6OgZdPEM6xkSDHwsnhGFu5OxtkG1zSzMPLOapvM3omaNMdTTskYVdMFkfWhjh4x5m
         MkuT+Z4+oxA6Kx+ynM2eUjwARwz8YhWhJrmW6NEwqE+z3lp22W994AiuLjD2RMpIfP9Y
         2W2r8O4z6RJ+VkjVzlgiPsbTAVTMFYh58MzkfD7SofXfWDgcqe/lCrvhmeFp2CoLx503
         bd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729261421; x=1729866221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4gEdB+5JYvJCAfWZebjhnmH+RSwlxwFHuuYfx9k9+0=;
        b=a5skA15uOUhe5obpFBYxpGAF9YfusQDcClTS3TqyjA5INjgt29vNaevQeimydZP8gJ
         EHOrs2GBB35XYLcR8e4ToNqyxyt13SbH6QSEi5WpOpY1G26kpQifaFdsT3BQGNDE7Rc4
         ihllirM3zcf6Z5amJA3KNJ2IbiDdBoDmeMej7v0R/fLWN6ocZX7zekGQX+Oy+aD7o/MA
         TcNxPFsIMwBMDeg07U53FigclfvhQ90Xptmx/XQWqdbrkAAPjkFylual+HGR7zTMfzIv
         LJWCVgioMqscw4sUQfPmW0aNBxOnXZWx/ZKUSsc/2cIJFDC9UqL+biwx4mGvl+xnFIJ9
         xfDA==
X-Gm-Message-State: AOJu0YzDdLAhmrcADOCwtdhIWzQTQPAEKA6rdp0QU1aPyHA3rSmdnVBx
	J3z0oPzqRaMxCJywmu2axJOyfW1NsvdQkcYhGOlNAzcYnpc2lVg5Z/s6Mw/r2OU=
X-Google-Smtp-Source: AGHT+IG7ISejfDrG2J2RABirjmWItTW5FcdRK3p24LBSrAqWZn3JV6nJlaR/hD6RR9T2j8WZFK5oPQ==
X-Received: by 2002:a05:6214:3a8a:b0:6cb:d538:cc48 with SMTP id 6a1803df08f44-6cde154bad8mr38515786d6.22.1729261420740;
        Fri, 18 Oct 2024 07:23:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde122b017sm7378376d6.78.2024.10.18.07.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 07:23:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1ntD-008Cb7-PH;
	Fri, 18 Oct 2024 11:23:39 -0300
Date: Fri, 18 Oct 2024 11:23:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v3 05/12] iommu/amd: Add helper function to check
 GIOSUP/GTSUP
Message-ID: <20241018142339.GI948948@ziepe.ca>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-6-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017140137.6028-6-vasant.hegde@amd.com>

On Thu, Oct 17, 2024 at 02:01:30PM +0000, Vasant Hegde wrote:
> amd_iommu_gt_ppr_supported() only checks for GTSUP. To support PASID
> with V2 page table we need GIOSUP as well. Hence add new helper function
> to check GIOSUP/GTSUP.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h | 7 ++++++-
>  drivers/iommu/amd/init.c      | 3 +--
>  2 files changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
