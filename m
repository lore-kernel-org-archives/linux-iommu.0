Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E321509B1
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810028; cv=none; b=fEL+MqIAMv+N65tskzgtmog5r3u50h5vKYV5Y5w+0eCwrhiJsdda4cyUgvp4WSRj5PXl0fA7u6KWDix7mMcEf5Pfij/1WqrMy+EuQG+x/645fLNUViCMlH+ly9j0sjIUZC30NJfPBNYdVsvNGF0KL1swCNhzs5aZNDpZ9Cy52Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810028; c=relaxed/simple;
	bh=yCoQElFg1DZuHcJL07Q4G71YiiZQpFnXw230Y845qkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhKIogaR5SiEy7UVVp6dcPe24V4yWDUMXRn5XTtyVbmdGbBS7A5lH0v19XUa1PEKODxnTttg4esvgwkuttP6Q5OARXffc7qv/ndvigzB0q+dN0dTP1Mxst82APDmgQ/jKP8fbIxMohSw6PAPgYzvPdUUsMRCVq88pAfu4pzg/1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fOMFHoKq; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fOMFHoKq"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b50aeb2424so2055846d6.0
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 08:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718810025; x=1719414825; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=moEdRVU3PoPlgPdcVkukT3vEmMSfRXd64UiQM7jDSSo=;
        b=fOMFHoKqKtezBQ7FOzgkqNHPKy7CocoHSon4ZMUp1lSS6vLHxU0+HSDFPKfGSFrjMM
         R9HK1phpItwki0SavNpWTjRqzVsDghzh6A5Ue+yi71ixFEYqdQf5zVz8g7/luSStWC5X
         HHWok1IfzHaGShT43D37RFhQGjM4JewUl8ogGuYbIx/Zmlq4yS8hkVxdUG/8xXutXx0A
         vcLTWHBNCBYbYynDly5GnC7AlxG1LXEjKrw9Js9NmIEEAOskiad43Ivy/PstF7dGOGHJ
         zNdP+Y83K02OEJpMA/wg7WLMyROkyxBtw7T0n6gOvMqziX1bABJtx7l97y8n8VTOB7zO
         qOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718810025; x=1719414825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moEdRVU3PoPlgPdcVkukT3vEmMSfRXd64UiQM7jDSSo=;
        b=iVKY5QlJC+IiXFf8NX8NxmEWiauk73NEScM2/46mivC0jAEQoxFzbOb2oI+rJP6Wwo
         RLsm90/g/NYoEMOZIkd0NgdH9euz0rlCyN8cTrR0XxpTL3uywVDceTJzvp74UHPUVF/C
         0ppgkV/RanRQcDfLl4wmu79PN+xP40EycW0ZB5EsXDnOu3xg1sqfw6oRfvALI0RimPpc
         WE7obTIia2Ef+SXPuCzkUvcUxpL6zTmVg6OLHB4ZyYHeUC2UIQCROX3H+E0IgkM1KB6j
         OLIXCB8DQFMSyS8LeKPfOPyJ3UFK/s8rFLJhZSMugdMBh9iRBldAMzo+scClinqSbVjr
         YJ4g==
X-Forwarded-Encrypted: i=1; AJvYcCXT3MQGw7ukREl62kemLII2D329CEyLUuH82zjQMuYm3qnveaSViG9dZMwei3R/ZdfVp+LtwL/MDbtdQTM+hhyyAB+bzGc=
X-Gm-Message-State: AOJu0YzRAwPe04XZqrIWDAS0t0KP5MprwDz05O4w2aOnlmtCdNpM5S8o
	ee/JI3Ijd4x+7TUcOmqCZjy8i535NubmvjiWfiwWuUEVGIvAol7CsTzHh0mDnOw=
X-Google-Smtp-Source: AGHT+IEJkRZBkgVagiNpl/OtqoGC4d9ZaTPjOU1+2kFAPWdp2oRDjZmssY8YvGAEYa4O75oAH2+OSQ==
X-Received: by 2002:ad4:5849:0:b0:6b2:b3cd:c323 with SMTP id 6a1803df08f44-6b501d22234mr29977206d6.0.1718810025609;
        Wed, 19 Jun 2024 08:13:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2dea97206sm26986726d6.84.2024.06.19.08.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 08:13:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJx0K-004nTt-3N;
	Wed, 19 Jun 2024 12:13:44 -0300
Date: Wed, 19 Jun 2024 12:13:44 -0300
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
Subject: Re: [PATCH v3 17/21] ARM: dma-mapping: Use
 iommu_paging_domain_alloc()
Message-ID: <20240619151344.GJ1091770@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-18-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-18-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:51PM +0800, Lu Baolu wrote:
> Since arm_iommu_create_mapping() now accepts the device, let's replace
> iommu_domain_alloc() with iommu_paging_domain_alloc() to retire the former.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  arch/arm/mm/dma-mapping.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
