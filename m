Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D95B1DFFB
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807910; cv=none; b=rHidkxWods/CC6R2268Xwx9L0cnqQN39Xv8qWHxc1NC0M/7iikIXiPt2UernV2tk1A6TxpHzPYnJ4jNslrMRjKzqH8gpdyrRwtuoJZDM9lwsOVjUKGHg9vx1tL3TZkiSJ5E/zt62pYMaN9CecKJlsZkKKLzoFKyUdj2z1DcwnOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807910; c=relaxed/simple;
	bh=vHJZR07TDsfMQhSOpJNQ7ySVcEwfyhK/k1s8y8Oef78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBGHGgh0GHu4yb0jSzLefK5pPhTe4Rm1TiLido+D6UnBCxZgbm7+7qCQ/UshMTfAOU+qQajil2kHwpNol9f650Eyh1AxPsPuGCvHyU7dgW8qj4V2DCsmxNrFM3NKA0Q043JVhYh0w4Br6Nu1M9W3AbC+YESgQZgKPrxfSPzqDHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Clw+6BfA; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Clw+6BfA"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b2c6291038so7633576d6.0
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 07:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718807908; x=1719412708; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7eSifi9kzw937hBs9m+vGjWLDbN4rIVu8qbt3p8ubO8=;
        b=Clw+6BfAN0n0yqNCmy3sACXL26/pXDUnN9BWyjoH/uVgfubRqoZIW49htQFq2WaVa5
         MoC728o5AqBngMcnH+bhO7MEtdZDWTwup4Lu/RgateXOrbxhKKTlvYGYZS2WaoZ5S3Yt
         0kkHfPmEmvPwdltYrw9TVyJIDh1SRCFVja2rRW8KBDfZ0JWDgUe6BtV1Wi0z82zBs/IU
         KJAx9umMwIJCnIiWLRx3AG0OJFRnLTqEMGoNIMCdpgrT4a8swQO+uRj5ylDMNry2ea4B
         +oMEiHu/r2gzTBJq2P8xdBNIGoeFJP5rUyhyzuseqO2YwBMKPkHvCAWo/MEBJVnOOIq7
         2FxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718807908; x=1719412708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eSifi9kzw937hBs9m+vGjWLDbN4rIVu8qbt3p8ubO8=;
        b=KTXI1Nr8+Wc4qWb2Sv4THZVkGlRnwmb2ETidoTYngNcasuKOIsXSTQoGVM8KbbaJjE
         xfJ8lWYml90/aNVTZDhKpm1kfzmOkARisB9CBt7nI+VwnlRVKvNv929fZz3QVd+dwyj9
         1iM/zyPFEVt1dvzy85Gtpwl7KUIgoF+c8ew/iofPW9AbSmBS/8YCjuZ2iOUkb3NAZGcI
         rtu5UDFgp7fKkkJ1SIdoc7TItVwEaLc4kyo2+VhGWtONeW4FgSW+5iu4njrG2hYgHwer
         wPLjFr753kUfTZ1oQo/O2NQ/wfKFmEpml5VxIUCZaJt08qbqIGetaDY+gLYUxVlOvRXd
         XTtg==
X-Forwarded-Encrypted: i=1; AJvYcCXOb1thkHbOjPrk2HXVA/VOcrf0oVCvOD2ICvD3ZPxTcgfqUGbj/50HdYRpyL0cyL7FWpxsimt4ivhXXrWeEXfhYr0t6Y4=
X-Gm-Message-State: AOJu0Yw3VSIzycvP953hKHTfKoCz1X30Xj8G2GSxOL63EAkNpBZyR4N+
	t6+P2EY8d9SDYujn5a2iS5N3AuOZ1rPXHeNDjraNDfzYiI6ZyCrR2fF6VnK3tW8=
X-Google-Smtp-Source: AGHT+IGZSB/Brli4dklvGSX8RN5hj5Xa3TKJWnONX5AltWqs8DK5Wub0LYx6UoNFdFIIjbi83LBDQw==
X-Received: by 2002:a05:6214:124c:b0:6b0:8991:a2f7 with SMTP id 6a1803df08f44-6b2e230ec57mr96370946d6.12.1718807908248;
        Wed, 19 Jun 2024 07:38:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb4f4asm77884476d6.98.2024.06.19.07.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:38:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJwSB-004dXU-Dy;
	Wed, 19 Jun 2024 11:38:27 -0300
Date: Wed, 19 Jun 2024 11:38:27 -0300
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
Subject: Re: [PATCH v3 12/21] remoteproc: Use iommu_paging_domain_alloc()
Message-ID: <20240619143827.GG1091770@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-13-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-13-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:46PM +0800, Lu Baolu wrote:
> An iommu domain is allocated in rproc_enable_iommu() and is attached to
> rproc->dev.parent in the same function.
> 
> Use iommu_paging_domain_alloc() to make it explicit.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
