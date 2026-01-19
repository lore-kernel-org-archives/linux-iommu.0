Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB3D2DC333
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841995; cv=none; b=JjRfTVjhGaLaSlRyfNO0OR8meyrC8ji1SEjxryZxXVYXsy+dNXC+mJRC9nMzSDlE63/47W6cA6nX+Vzz1ZVnFZvCe3ZStD9KjkCPU92UiQQEPgga5gGGWp0jd13kFGR4ROeL56WwuSopzQNNNHMFWdHcwNVQZxrJ/cf031RZ8c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841995; c=relaxed/simple;
	bh=bhDzKe3hBaMep6hb4Ruwhdat9qUjuZInlAgPSftgqs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2Apnz6aSIdRfBMqrpRcQ49nlDYbTfJ0+b+Fby3A268CcgM9jZFblpZvES7wCTH6QJ886VrlVNd03aREKaR5oaLh6YYr87twMkLLKKRSPyspmxYV30oKkVQOGa5sUQtszGBywyIjd/qNdbV3pWlPwcY0LWLtfQPqa6/c6xqGJaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ud4leYJB; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ud4leYJB"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c52f15c5b3so520668785a.3
        for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 08:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768841992; x=1769446792; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TPsA7s1a/5IQbuetD0KLnhoW9jbCMPzN3lJpfuVRncw=;
        b=Ud4leYJB89gXsZ4uDZ/4u7oLHV5PkFCtSnjixqJMSxzGe5RUTXD7+cNX7nTc48ftFR
         xgvEr9/K60f1NOn8W69HaHHkWzf15SCHL2XnfoY6ZMuUurwdGiv9TmGhH5MW1eHxUEni
         luZ6bC3/JhhKvpyGvGJJ63PP+7N5UO7x26gFrVK8RH3jdeq3WtaXSP8PynQjwOEa6sYp
         mIB5UjV4oXSt1KTbL08xrTX359q4JBnQvefy25yqlR2ITOSjrVjABY3FAKUduzL/9o9B
         8mt0Cr1EkOkQNLG1TudUvPB+nEyMZAUYPuTonPl4Yy+Jm+jqjKOprDSRxeoOeI1wf2GS
         QhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768841992; x=1769446792;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPsA7s1a/5IQbuetD0KLnhoW9jbCMPzN3lJpfuVRncw=;
        b=R6st0UYXToAQyPjRBKWTamRnnPjVm1QiEyU+ie8vIXPXYlRiSOXAgv0vDAedMXcnRf
         /BQfYcG+R6e3FN3dJiax9PXmFkV4ZJPINeSugQKQgou4rSqd0+kZke7veXi+Iq+jid8V
         21jjX3eOX7TzRnIDfNmSU5TiuCx5V0Kn3xpKt2nquCxpoUq6Agd0BlJ+CXw5tOt9cB2n
         dRObcfBPOWa9NxDN4kryzRVaSlxhw1V+d7MmZ1aU7VTXx4IVRrplZZSwhZnoycXnnolg
         M/TVMBhS09OFLkZkhZEvm6B/DblKNcNaWil1YaridhRfIHj5uuYdC5Sum5mZPghrW8bP
         esxA==
X-Forwarded-Encrypted: i=1; AJvYcCViTHohHLaN6Kiq25BB5KAA1KthO7+BCOfPw0fAtZu26oFukcl4jWIR6tXBFauTx1OFVfHocQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlCmi7nSO9LnEPAAliRoB5pqDrYdsd5Shn1QmqXJk1YNFx18Q8
	UWVs9bYBQw/tCNhuKkOLj8XnXRPFHC9jko7xpUTRG3ic/6qPJaCvl0BdsoCKcJhQJIE=
X-Gm-Gg: AY/fxX5eC9PtHB1Zn5aiKxsBiy3N1+spjhtYyFCUiLwrbOYXJ/lCBlz4YPn81jRcS3D
	J9Rdl1L3y0akGahXyuyOEHqlZ3x+G49wzKS2I5bg3qIuZXKn87f2CriogC4RLV7T2e9GVXFw29Y
	gMBnS0EgakC7HZTNULrCxvczCxDmFTvgqFjbx2HwWHT+Ar2MppUAtEwvCLgXPdMGdOTliWQHiXB
	RqHM5amOsVgoB3wqf5oAH5bRYMVLG6KaVqavQ9+htyOL5+mgcuGhrZVqFn5OqUcr6kO/s4wkU1U
	423UXUaeKYriXJWRSkVQByI5GzlpCmGqIj8mb+W+a6k4i6uiZLef6D5MqISn0tB3M6Ks2u+BdRU
	0Icud5sM4X9cuP9lYBCXPeitBZkeMNw0WWEDCjp4SRKjjrFBiK2HVlxk72oFN0kn5GuDjAx2fhi
	5dUnC2iJH0dgBGjr3pl49IHGdYzCSpV0cq0K5uzFRN9PPbMSPv40Sfw6u9cFBZz8yd7uo=
X-Received: by 2002:ac8:7f56:0:b0:501:50cd:cd3a with SMTP id d75a77b69052e-502a16b363amr184663241cf.43.1768841992288;
        Mon, 19 Jan 2026 08:59:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e5e4d79sm93947786d6.2.2026.01.19.08.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 08:59:51 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vhsbX-00000005IQz-1QSu;
	Mon, 19 Jan 2026 12:59:51 -0400
Date: Mon, 19 Jan 2026 12:59:51 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iommufd: Require DMABUF revoke semantics
Message-ID: <20260119165951.GI961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
 <20260118-dmabuf-revoke-v2-3-a03bb27c0875@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260118-dmabuf-revoke-v2-3-a03bb27c0875@nvidia.com>

On Sun, Jan 18, 2026 at 02:08:47PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> IOMMUFD does not support page fault handling, and after a call to
> .invalidate_mappings() all mappings become invalid. Ensure that
> the IOMMUFD DMABUF importer is bound to a revoke‑aware DMABUF exporter
> (for example, VFIO).
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/iommu/iommufd/pages.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> index 76f900fa1687..a5eb2bc4ef48 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c
> @@ -1501,16 +1501,22 @@ static int iopt_map_dmabuf(struct iommufd_ctx *ictx, struct iopt_pages *pages,
>  		mutex_unlock(&pages->mutex);
>  	}
>  
> -	rc = sym_vfio_pci_dma_buf_iommufd_map(attach, &pages->dmabuf.phys);
> +	rc = dma_buf_pin(attach);
>  	if (rc)
>  		goto err_detach;
>  
> +	rc = sym_vfio_pci_dma_buf_iommufd_map(attach, &pages->dmabuf.phys);
> +	if (rc)
> +		goto err_unpin;
> +
>  	dma_resv_unlock(dmabuf->resv);
>  
>  	/* On success iopt_release_pages() will detach and put the dmabuf. */
>  	pages->dmabuf.attach = attach;
>  	return 0;

Don't we need an explicit unpin after unmapping?

Jason
