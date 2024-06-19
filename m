Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4731136664
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810061; cv=none; b=UechtdLlrM3d6LlK7kwL0IwyN8XM83V8WK118TKCvSpDi0fjpMJITNyAhp8HwSR0bvJETsfU1CyOPzBYCTK348AgfODkcPdYPvSn/F4o4rpvzEd7/83O+2tU1Rr0wwqho0FcBEfTGgIcKgnqtHNWIjaHWbDloaedBHRSdVoaz+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810061; c=relaxed/simple;
	bh=muFmkQLJvQ15Yt/BaKNlq7hz+YLGZlMYkp08ZhiNpUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usuLSaPEwiEif5CbLq7aQ/UsMNee9Qx1R2xAbOQxoixGz3p76qyXkpZx7/CkbDm9VWyvqC3W96c3U7maGpnQ7VY+gNHX8pJ0CUm8Uv3khUmhu9dwZsvLMkdvgIWT2aZaHWNjdUaFZVWlynpjCCSIfFzvNma8CEbE2rGrgd1LAIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Jm9xjA/k; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Jm9xjA/k"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b4fced5999so8651806d6.2
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 08:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718810059; x=1719414859; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qq78ltb5crvWyLzXIfnPlOkoWYmn1e4oCmMdRELkiuo=;
        b=Jm9xjA/kBPFaec8QqieU4Z/vHWe6s+Y5ASe4nBTcLi0mMLH3MQYvukoyvZaDNXFjzd
         O7Fgee3RlbO57bWhfM3yHKqtsm+3ZsfITRYhwPYLUrtpz6cC+w2H5XvXEBZu9x1ulh0L
         MP29IijUy1hHMSZs7bgw39m6dKBjujy9G89mhaoqjcRzAbILtiYDxnTWJiLQ9CRWggP/
         c5H4vV46q3AkRHS/w8JLvCdekw8pS3YMlghr8CluIOiC1gZ4jJZcePQYAA0dDdmgXWkY
         nsZ7VDE0VRUYcnTLamosmBNCGtIKtIpXK0YfT5TIzaDtUv3SAT3Gvw40AFPvU7ccKf+V
         5eIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718810059; x=1719414859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qq78ltb5crvWyLzXIfnPlOkoWYmn1e4oCmMdRELkiuo=;
        b=VB8w6a6uZGGy5MhxB2jdMZCKSw0Tc3epYHDAnvsuCrV13SeMVLonQf4xWszs+aNupE
         ul/it01AM8ls1AMqILJO6xt+sHLempMLi54x6jbuWDcXuqgchlHHsQRkDujj803sPcCW
         mgSyHmIKj/7v7n3YCfDZ6/xdbLIsTopzW2iUhAiHGkHR9e65F/zU4LLKK5jhC+0r+fz6
         mOD6vxG0tOBg/Rvimcr6V94BfRpNIHR1Jn5bQiDcGCcr0c65kKZ6Y/47MIjgk5CzDBf3
         4U1OXYqZRXv97cfFeQMHgFrzeGthn8+gUNpONfrEkLpsmPt/D+Ebe5Ufj6Ob8G0+mQN9
         0OIw==
X-Forwarded-Encrypted: i=1; AJvYcCUPoScIUL1qaYv27nJJP9MhNR/PfliLiFh0kUhmio0lpnCuADTc3IRv+Nvc4iSrVIoAEYRwIDVOAjAW0FELBxs0isH/1Zg=
X-Gm-Message-State: AOJu0YwaMRz2noEXaz7vzdhzs6iF/dyIhiksHUuxUmVdZA906nZBFGKH
	eHyf23YXgKP/2Vc0v+Noos5VQSu0w91Scs2Jl5nV9/yLIYibQQ7RZg+YnGnH1lw=
X-Google-Smtp-Source: AGHT+IEOeuPwNQG30sVHkXguHikBPl0Zz6A9LkZtMX2PCT+BlXopyE8xiWNkdljzVxC2GPEBoe42EQ==
X-Received: by 2002:ad4:4bb0:0:b0:6b4:ee84:905e with SMTP id 6a1803df08f44-6b501ea4245mr25964686d6.43.1718810058700;
        Wed, 19 Jun 2024 08:14:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c113b3sm78372256d6.34.2024.06.19.08.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 08:14:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJx0r-004ne0-3e;
	Wed, 19 Jun 2024 12:14:17 -0300
Date: Wed, 19 Jun 2024 12:14:17 -0300
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
Subject: Re: [PATCH v3 18/21] drm/rockchip: Use iommu_paging_domain_alloc()
Message-ID: <20240619151417.GK1091770@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-19-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-19-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:52PM +0800, Lu Baolu wrote:
> Commit <421be3ee36a4> ("drm/rockchip: Refactor IOMMU initialisation") has
> refactored rockchip_drm_init_iommu() to pass a device that the domain is
> allocated for. Replace iommu_domain_alloc() with
> iommu_paging_domain_alloc() to retire the former.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
