Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AFB1F171
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807884; cv=none; b=k+Z2lMHRvcx0q9MSGnh7VnlcmiRoKhIls3kA03WJy54n7LlCQR/LPgmAnQ4yiLKBEZCOkLpRtPMJ//eDjyQL2LNwUm+iDWAGziqy3I0HnNdN/bmMzR11u+5XCngwIL980NODXRsjFBalQS+Da/ogehKHUoSKyJhrufR2VT6ZahU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807884; c=relaxed/simple;
	bh=HgRd+PsG2Fckv+DtGDkxGSQtGswJ37qAbmLorPvU8rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CH0ghab2J3KOZ4XCRYWXucGDVRGLNVderawSdepvAraH6x6wm622jG3Li3PYeusQtZKXmMbY2gz7JA+H3+59aSly0K6Ux4WX3iFJDqxhjhBy+dPfrYyKnYvseLm9qy71LeXcmSnjtwbMXHZl3qRSltnQFurZEXnAkJN2QWXA8Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ErmdkNlN; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ErmdkNlN"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4421cbba106so36660661cf.2
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 07:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718807882; x=1719412682; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6pJIKfjLvugpNiyWUPkn81xpwGb7zZV1Mhqp6qTkwpU=;
        b=ErmdkNlNWZ44WCks/Xpf2jFRX9mOKavaguRgpah16tBkqwr3ygJBW/BbymZPhgRgGr
         n/R8JUoocLOB3mOJ5pTbN5YLZDIrXG0SszGIbpijUoAbqPo/TQhifuzH0y+GC/5Sd8C0
         LWh4X4AlPNer3uD1jgLffVEwZN96CVd9FKCkgdaji739BrlZfBJ542GOMge7zYX6xiz6
         8/hAcoXpMOfO/znwEuZl8Z2FeCP3H/y2L/OxFi8CIpq/qjbEevGufx02gii2kiwfoDio
         ECSWr9mBPccvPxLeID8D0LyBY8ssa5emSf9q5OytpANo2ONJDxfUYQPSaMIYy2hWTLtk
         DDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718807882; x=1719412682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pJIKfjLvugpNiyWUPkn81xpwGb7zZV1Mhqp6qTkwpU=;
        b=wPYMxK93u/LSW0iy/uZLjp4ydRA7sB5SxU10fsiMP6m+qmQWfOmGjXu2SNILqO8jnf
         R2VveafjZwGYnXNvecdMRP9JhwPUiyDh6PmpeLG+oZ0FNXYycXRwjWxWW246iN0NU4/k
         wpTQ8jHCOMBX7+ErbVp43Mg/cELQx3vKfOV9L94iHDI0d/CD8+0QxBAke/NnjhtYRvlC
         ds6wdqPPtU8iyareMZFoVQKxRUxDsYLSB+1iCdc08NG3qIVo6vMbWZkJLDI0L+L1ieyD
         hC6OcVNIdm9NLnvC9lWV3ZA0B4mbIPP1dzAZGHRD+hMrnmXuE9/NrpubdfXEN3vMho3y
         O5wA==
X-Forwarded-Encrypted: i=1; AJvYcCX8GHUKMKY+bgmTPKhV1CBFZebxbqCnlB6dFbTZoRnt0Kq2TkvzfHjZqmcf7/4C7YyLb++vdBoLbeXSqt0I2W8xhtaJMlQ=
X-Gm-Message-State: AOJu0YzDq5ldB26hb7wDMoTGhHSVHN/WohHJOPQVvTQZ5RKoZmUIUKsZ
	mTcXfmhreImE9Yc8TeDCbhhk0yhc85EPpBFqJmhQMJbg46Sr0oHKvaFM5vN5+3Q=
X-Google-Smtp-Source: AGHT+IHTB/lZ0M/byP4dE3kOpURatwyTsEaDzd7ugkc+m0b4VPnnl9e+XLcLWm6PxgGLzUpaixUT/Q==
X-Received: by 2002:ac8:5896:0:b0:440:645a:a209 with SMTP id d75a77b69052e-444a7a49c90mr31210081cf.49.1718807881767;
        Wed, 19 Jun 2024 07:38:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441ef3d89c7sm65749961cf.20.2024.06.19.07.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:38:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJwRk-004dPo-Se;
	Wed, 19 Jun 2024 11:38:00 -0300
Date: Wed, 19 Jun 2024 11:38:00 -0300
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
Subject: Re: [PATCH v3 11/21] wifi: ath11k: Use iommu_paging_domain_alloc()
Message-ID: <20240619143800.GF1091770@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-12-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-12-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:45PM +0800, Lu Baolu wrote:
> An iommu domain is allocated in ath11k_ahb_fw_resources_init() and is
> attached to ab_ahb->fw.dev in the same function.
> 
> Use iommu_paging_domain_alloc() to make it explicit.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/ahb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
