Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F184014373A
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810090; cv=none; b=iDEsWgCaWvT3VNfn+rd1g4q+9fAhIBIpb+KtrcBd3l9iyUHYndbIhBZnZ/HAmamFq3O0BmEG+ih/acVzjM0vyZ70ZHxhTuXsx7c5j4IXmIf+3Bzve/CiIPdYQBUl4rJGEcjFaM1/3fqIcivM8zdiSzwKGq/j8rbGm83ilRIc1eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810090; c=relaxed/simple;
	bh=6nQ24Ttf46Vn0Bnc0Pn3bfSXY+6J/UIhB3AFIysMkuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1ah698G1acNEyerkhqTJb8B4lMkpCUzE/lTGi8KLASTGSc5UdExDQioMWV2CGwwCY644epc0qGDB8j5J3IKVhcWzwKRWm35wM9gSlmYJ1JRhoTrdcpBVuBcoeKRUppSqemmx1XwhUUU7Rde+dIwGEB79KATd/o4pMmBOsz6ZpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Qm6KO/az; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Qm6KO/az"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5b9a35a0901so2229078eaf.0
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 08:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718810087; x=1719414887; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mOCumefnCWAh/IoBUZ2rq796M41BHPnroxPN1L782is=;
        b=Qm6KO/azDyuwW3RdCjGyBSp3Neh+TiAkvelB4K5gaiLHjxKh7Omq7of6W/tuYtq5bb
         DAPr7H3cbPCS5fsnIF86CUCiSZjdriM0mE/BW/J6c3/lqbW2EHRG2oY/jUO+I4iKE6kP
         cjsmJr/Zb3MVKsQNdgLoBrPNOOLRfv+lncUAGd8x8K+GJ+nI3/UwWX79lxM8diNGoNSs
         qa4S0f/fINDsXWfV/Z4piuxTqA5rL0UyIVQrmwn0+f0BZyuYUgekKTtSLlIENpT4NT/5
         SopvlVW6S7VcVsIPJQIUhcLIZVBKjPaHJ/NJ0K7MyNWgQAZa1tLytEx/jQ91pE4ykqH/
         TEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718810087; x=1719414887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOCumefnCWAh/IoBUZ2rq796M41BHPnroxPN1L782is=;
        b=PihEIcjSnARi/YcyVNWZCmDijNVNyZBQGWyNNcvJicGFdbj+iLypyvgjgO+phqtJyA
         T6So3vubITGCX0FoUO7Qly0U5LWsrDHtTsVN1EgbOE0EYn67/oFQZB/Wpv9Ewoow+V+R
         CTPVeJQaIhL2pj/iFYA27qsYP2OrtaXPCnfeiRymKqa9IlWnyuDbFMhGO84tuFPkVFLm
         IGewyyddg/P90gmRB9B0Wg5YRxtUVCMQyeX4mAOPCRiRWWaeqe2PojKax3yfjbrQBC+P
         XGFV45RUWq65akgKO5UImSJy2ztSSqTrKgAaTydPzWQsQCl3KNcVcgAs5Gvp6M18N+yG
         Zf6A==
X-Forwarded-Encrypted: i=1; AJvYcCXoZkrtD9DG0BXm+v9I7zNRmYlg6xHKOdG7ILk9Yw0aYeDNe2I2CaVUtxZCLRb9vIcdQ/12KHs8hDNP9uhMEq2l28Lg8Jo=
X-Gm-Message-State: AOJu0YyydkaBCusoxhXKfJ/9R4b4fvtlKm1V3smCMF1sLxgIBPfIRzsH
	idz+Wzl9eaudcwPWTHGmgCYqcFEeGcouNEdY+xyMsoDYf7VJbb+GeJirG9gAqLc=
X-Google-Smtp-Source: AGHT+IFVFHsVlQMiH0Fbhd4tc40tCEx10K+gMkRqXAjqGDO2L2x5wkknywHxXN6ff9bLZXfNrK0Jmg==
X-Received: by 2002:a05:6358:9886:b0:19f:1644:d45e with SMTP id e5c5f4694b2df-1a1fd470d73mr300419055d.8.1718810086999;
        Wed, 19 Jun 2024 08:14:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abe47ce5sm614900285a.103.2024.06.19.08.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 08:14:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJx1I-004nmY-NX;
	Wed, 19 Jun 2024 12:14:44 -0300
Date: Wed, 19 Jun 2024 12:14:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org, ath11k@lists.infradead.org,
	iommu@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 21/21] iommu: Remove iommu_domain_alloc()
Message-ID: <20240619151444.GM1091770@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-22-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-22-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:55PM +0800, Lu Baolu wrote:
> The iommu_domain_alloc() interface is no longer used in the tree anymore.
> Remove it to avoid dead code.
> 
> There is increasing demand for supporting multiple IOMMU drivers, and this
> is the last bus-based thing standing in the way of that.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h |  6 ------
>  drivers/iommu/iommu.c | 36 ------------------------------------
>  2 files changed, 42 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
