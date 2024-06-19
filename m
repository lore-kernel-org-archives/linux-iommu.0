Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82401CA92
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806872; cv=none; b=hK+cVdTjRX725ThFIJj51259dkM/Jyt5WWw8MyiY62waIuC/h8vlHdMKD8FWBGFZmERnrnfU0CvePIBy59W9rwfPlEcN2N0HdbDYNPmS7mSDJy/IW62K0fZO/mk48sJzaIPMICtg0qNDqhDdZjcSa0Cur79D/DwdwLdYM7tpgNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806872; c=relaxed/simple;
	bh=xPStD+LJiZiMxPNXI1L+xh95B7THSJin01heSvHDvvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmTryq83xyRcv+vsh6bnPuR8T/teLUv0AJz6Gyy4udEaPkY4kcGbQcxq7hXD8pBQ9T4fAY3gDRVmf6UQ+rNGoY2nnC6K33zT+rA0DkRJUiLuso/1tMVBGO/vIujZnuLalGm0Nx0NwEfMeN8AqCjH92davImVLKKXkglosx+G+LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=J+OlHXGC; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="J+OlHXGC"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4405e343dd8so27376441cf.1
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 07:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718806869; x=1719411669; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dnuarbriLv1gjZdB+/82zOEKoFtQbXR8yQCL4vTr0Qs=;
        b=J+OlHXGCMo+f5hewhcwRBrGdYuc66JYEJoovS15BJ9dHHsy3SGbeAO6JZyOGCghp5P
         sAZpaioPPERf/BIIW8X9r7mcfgonYHzXzS/g/VBLgw1mZNLIgtyimuPv7BuEEl9W3wtd
         e6UGpwPZDdj1KazqKaJ71AJ8frSyJCR+yB3e+jYCKcL46/fAJpnlNABJbTFFNXPBpdze
         NVNMgVifY7mngRVcfVMK/tGxplX/x2/nf7cSmq7FWHBF82NRSgLFRqvunwYjuBxljE9e
         +nL+NddE+U4C9qf69gpfuc2pd0fSGqjM5bY8tWENYyajnfySSka34Bp3QpsPeAvYadPU
         tbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806869; x=1719411669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnuarbriLv1gjZdB+/82zOEKoFtQbXR8yQCL4vTr0Qs=;
        b=vbTSBunwbMDGADswwzNFcrl5DLzfSd7mH8AYiHqUX5yxUuXWzx+1G2C244V665n9MQ
         Q5K3JrK2NokU9Cuk/up55ozVlTBpE+7VlVBwJvLAmSzddjbrzM0k4c4tQjnTOC3k2B3g
         2zqkW9PITktLXnmJWl2E0VDZF5fYHwFokEQGNbm7p3vAGOlnBhxg1U3WVq6KCNMh1Ehq
         MJ0FRZ03aWajuthRKulA5BQoeSDqMyUgmHYocdwBD1+Gl5qubn0Yw2IAUJMjQPkxMiuq
         EhbKtP8MiYYEnTbTylNgKNE4kdwEAczVhqyMyBh+7KBiXCK+lDGOnZMlfYCUaL8UjIXw
         Q+OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrj4l/ybWmr+fMsvRzFu+jNVBVVx4OILnux9X3lV5ejo5xP08tH6FnZbaMe6YIC4WKeOvFqOlXIHU+RmwnqPpWJ/y2AaE=
X-Gm-Message-State: AOJu0YxFtq5R07PG7bymQ/SNqGi+v/qbXmsJzM69U4m7Gs+wmaAp0Pvd
	MMi8khy4A3T0wDRGebfnUHig+tl3LTYgiWPu6qiO0BY9miC1qAI3bFzwj2wz2Js=
X-Google-Smtp-Source: AGHT+IFditz4+ndDJELnqBk6Tg5RVcppmA3k0NZASSXMhXG6oxi/4ZiVAiLFkBd54vQUHLyqIQAFrg==
X-Received: by 2002:a05:622a:11c1:b0:43a:ac99:4bb5 with SMTP id d75a77b69052e-444a7a4a90amr26916401cf.51.1718806869361;
        Wed, 19 Jun 2024 07:21:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444b1e112a7sm2007311cf.97.2024.06.19.07.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:21:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJwBQ-004YYo-D3;
	Wed, 19 Jun 2024 11:21:08 -0300
Date: Wed, 19 Jun 2024 11:21:08 -0300
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
Subject: Re: [PATCH v3 02/21] iommufd: Use iommu_paging_domain_alloc()
Message-ID: <20240619142108.GH791043@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-3-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:36PM +0800, Lu Baolu wrote:
> If the iommu driver doesn't implement its domain_alloc_user callback,
> iommufd_hwpt_paging_alloc() rolls back to allocate an iommu paging domain.
> Replace iommu_domain_alloc() with iommu_user_domain_alloc() to pass the
> device pointer along the path.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/hw_pagetable.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
