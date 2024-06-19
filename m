Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B05182B5
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807975; cv=none; b=gSmTrnUrgSudjjMXIN1AaRC/W0i28GVGSwgxhjQnGDnv0tIrUetm6+qYDiMP4giajulV1bJlSRBfwxw5g2VbvezcomtwHHJsqL3tcAGtxa2JEh7ZEBjqaQf728WzG1Rvbnjvw2GGDXDgePpaA4LXeMipn3KzCNc2scmyvNCaBHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807975; c=relaxed/simple;
	bh=R3guH+r22vxWZS45Xhn/5mcUPnpAYFt1nE1jSbf7vGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJlEjWPoZ1G0hZyqrd9qrIjRFRpPAF5DIvsofpw9W/4Iwn4dpWaT9a8GZWzVdsRQOBVpvlwDJ1FFWXWbdNe8AhRD7ADUJG/mUHcLt8ierLZftU2yRJNPZPO1mAEbfZrqSlai8lYpjJMePhkHIwvF3AMophM1Pj67h4MKrqM+yVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gXC7SQtA; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gXC7SQtA"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44056295c8cso31680111cf.3
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 07:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718807973; x=1719412773; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cokph3+KYsFeNsm+0akdDgXIRf+sbN6W33vmdBN3BV8=;
        b=gXC7SQtArBROX4rjowNwE9aYq34DvlURVSu9CAcI0Q48Pv2wRMSH3/ol/XsBAAJoiO
         Ptiw3VfB9/SdO1PcsvrxZ4Vw0st3O9od2WRS1Ij/cUw1JwwgRtGGhPsHL7dkmeqoypxK
         6wHC7Cha+dzXLMdB+NYnjjEcQ0K/IExjcEdmob2PnwfuhS55ql5Ta3WV+nXjnTdUJivN
         8gr/myu+zK1J+/Oq9O0v1N126tp6o1OOGCIOcSQor49YYTEZT/Nv6hN9u7RmK+gEKiiH
         AzPeR6subF5683uy2rt+PeWn0Vz7OUhpoUqocuK62YvNVLZmmf7tdlA/KMvgfI8OwcTO
         6dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718807973; x=1719412773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cokph3+KYsFeNsm+0akdDgXIRf+sbN6W33vmdBN3BV8=;
        b=pO4kuYmyPIxlEqOD6lWK8nkz5SHiCh3Uw7vYhFUxUa1yZO21WIQ6XptnGBxiGTttQU
         p+szkcG7AmJshoA45ST7MmfLPoy8hIOJn0H9L0sr57dn4G6l8iHiNMnTLRehB5G5rpEO
         7c24NeKrOaAFwQZCApWPUlfKshsoXuxN2FfCIDndOhnP6VTByF68MCZ3ySxm8xcSFS2M
         9ka3K2tjQiSrSXa66A3iaPMRm4pEziO9tlD/so/Djd8v7WcRJHFShsIuT8Vhtg39IH2u
         E2B0Dr48B/aEMlCjLUoG0YaPx4X4FhDnNWwbrFuBqAGF8zTAuf4X15epzwuVZgI+cqxS
         KHJw==
X-Forwarded-Encrypted: i=1; AJvYcCV9UxItyVWEykbDM00h+QYyhQuBLrUNsPWsoeG4Q07c5deqW8fQzyqBt9lvtTXIJmQO/J7ferYfs5kdBQVCGBwb8xe4fE0=
X-Gm-Message-State: AOJu0Yx/4fbV2kYfOfFOyhGq34AAzpKhoSiTEIWtHJ/DJGiDLIh+JK48
	RwQa8RtGYqtEEakwzuRtPIVHtdzgbD6XWtw86JfH2Uj3BFPyUEGo3dkZuzAphk0=
X-Google-Smtp-Source: AGHT+IG1XaOP45+fSUMkTGWH4nocXjjMBFeSWjsksr0Y1tefBQYZu2xLsBBhuOT4sOfHsJbLjtz4+A==
X-Received: by 2002:ac8:5ac4:0:b0:440:5b49:2d63 with SMTP id d75a77b69052e-444a7a76f5amr34714511cf.66.1718807973466;
        Wed, 19 Jun 2024 07:39:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f2ffb37bsm65405151cf.90.2024.06.19.07.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:39:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJwTE-004dqv-Em;
	Wed, 19 Jun 2024 11:39:32 -0300
Date: Wed, 19 Jun 2024 11:39:32 -0300
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
Subject: Re: [PATCH v3 13/21] soc/fsl/qbman: Use iommu_paging_domain_alloc()
Message-ID: <20240619143932.GH1091770@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-14-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-14-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:47PM +0800, Lu Baolu wrote:
> An iommu domain is allocated in portal_set_cpu() and is attached to
> pcfg->dev in the same function.
> 
> Use iommu_paging_domain_alloc() to make it explicit.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/soc/fsl/qbman/qman_portal.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
