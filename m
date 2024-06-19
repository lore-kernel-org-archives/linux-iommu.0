Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589B817C8B
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806855; cv=none; b=HLQ+I5N6sA9PWYqQEex06+1LfUu1yO9Eg5naNYuuu9QEfvaVeROU8j30Bo/UtetkVYkx0nTVug4nCyYjeqZSWXT+/aJb1fumDmmEm8ZItphet3A/UkobH5pMFXrbDqXP9ibtjHH/iZ4ke0U4KNRHjVWlK+50S9r2uqiJ5xlZd4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806855; c=relaxed/simple;
	bh=1IT57w3XTjZ596JZPrdRq3lBMOojlNcmKzYqXjsyH+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dT60qnwhAFX5Crk3aKUwzJXGtwkO3EQPdb1rBewDk3LShX2L6j29jFNPhAcpPX9oqZonOgnUjSrzjYMOf0OT4KciPNhoFyhYsjr4qXu5No3k1MXs2i8GYhjKpND2qz33+O0e1CZ8Mp3j+j4v+6FvlYW/oECgFP9nWcV7lovY1Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aKwopA3L; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aKwopA3L"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b4fec3a1a7so6121786d6.2
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 07:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718806852; x=1719411652; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7yoE1PBMeOt8AWWOCfirQIQiAXfywLWQ1wTXnwAB5no=;
        b=aKwopA3LkB8m/nHnnnRQkdgymOool7mC5Dogi7pINSle84L5KnpDaSY7o1t+loSyra
         OPf0M5yFpr1nDWeNYF/gU5atORIuaE9XUplA0YvfHOOxC37K34Hgmm5Gdlslqw/CtD9d
         j/JM5hjf9ss22AksOXU0ydEXwwxcbVaetHjI7Y0x8S7h1uhvMiLanXgu+H5pVG4gLY+9
         mXHZh+nmHFuLLe1Bdl96kb1vSSJ9LF3SbLj0GG7MUS9ToGRMiK7JEmoHSvnDZVbHDTCz
         VwBM2cRa0X/VnxD+/lX9YN/ATptgBh0lkRCOktcQ5eEVWNtzgy6hSHYmU3Mw39q58i30
         E+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806852; x=1719411652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yoE1PBMeOt8AWWOCfirQIQiAXfywLWQ1wTXnwAB5no=;
        b=UjcLwpaqwmv6jvEZKTliqWYXzbE1P2HCdo371zE7zpg9W92obCI/zJrXR3ry8Wk0S2
         R5Au/0T/fEY821j+hgP7ZeG/Vgtv9KwrbDg1pFDVpYJWLgDiPacF421U/Fhb/eYof+8G
         ynL1KA6cEtLBNPTbpIwhyhmW+970yFT9r/DPFvJtA95AQNYbHrdqr4lj76vPC6CDNsmO
         zTkuU0t4IFDvaKkS/Rg6poYSl5xMoEhMrfKuoVzkFPcCSB28ZR00NfxD/4oEImON+rmJ
         cL0BflA4/Yirm8y5yZaWCV+zHezey/6RYDg+ItrysmIkTOtWzIPJ9xpzrN+lQu+uMFdr
         YusQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBXyDAsDjGk/HReQlGlEo/EaqpYbRx9UBoJ093PBSzguIazv9cXYImZ5X2UCERBiyuVimw5QGhO9H2FtYWwXlXt2uU62k=
X-Gm-Message-State: AOJu0YyHq8hlly1NNs0ABbT2VALSORQN4jgjCzX8KRLjd/9K8PtELtnG
	jBWlqDPpYtt+5S8OF9cRRdJafh1vakwlBxNwFdcKft9NFf7YIfVyBWSNduSQ4DQ=
X-Google-Smtp-Source: AGHT+IHRnNfM3kpcWftEa4vzfduj3t2OxKbu1f062TE8ncSp4oMlwh+It4VOxlc2xlXVn+nW/690wQ==
X-Received: by 2002:a0c:f093:0:b0:6b5:a5:f5f2 with SMTP id 6a1803df08f44-6b501eabd0emr29525536d6.55.1718806852061;
        Wed, 19 Jun 2024 07:20:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b503445091sm9427136d6.101.2024.06.19.07.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:20:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJwB8-004YTZ-Pt;
	Wed, 19 Jun 2024 11:20:50 -0300
Date: Wed, 19 Jun 2024 11:20:50 -0300
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
Subject: Re: [PATCH v3 01/21] iommu: Add iommu_paging_domain_alloc() interface
Message-ID: <20240619142050.GG791043@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-2-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:35PM +0800, Lu Baolu wrote:
> Commit <17de3f5fdd35> ("iommu: Retire bus ops") removes iommu ops from
> bus. The iommu subsystem no longer relies on bus for operations. So the
> bus parameter in iommu_domain_alloc() is no longer relevant.
> 
> Add a new interface named iommu_paging_domain_alloc(), which explicitly
> indicates the allocation of a paging domain for DMA managed by a kernel
> driver. The new interface takes a device pointer as its parameter, that
> better aligns with the current iommu subsystem.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h |  6 ++++++
>  drivers/iommu/iommu.c | 20 ++++++++++++++++++++
>  2 files changed, 26 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
