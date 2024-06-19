Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588B3446AB
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807868; cv=none; b=rEVGb3oz8UdsAToYp6ELV2IUM+k7U1mcMcOz8ZCBoJkcade+n/91xVzViLSBz1n5czmHCfqEEYmK+gwK5w5HnCPeNSTD6L6xsVqJSMwUT8qDetxCgdGw414aPDJTAwaPGPym9nMS/8kXaDHDC6Zw6VQbwhO+twZ3jyFEugLLAm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807868; c=relaxed/simple;
	bh=O2Mc1QzJP89YmB6eoAnF/3NLaj/HJnIjRAyUwSdc+tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rj+FP8BLTOQ1FZWjJsyKPngTG8pSKwekst7EAd/K+NKuoznu/ee4nA/WI74A7HPHIQyRZ5BSt7EqRKylG02ajwrsaMyxzZYc4OUbk5TSS/k9ZLRsk205dXluciLYgKr3MDpdZod+SHGSyfQ4USgSKs9Fo3F1AqJETkubUNvA4pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GQDvmI6B; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GQDvmI6B"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7955e1bf5f8so398372485a.0
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718807866; x=1719412666; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=41x36+E2nhusvTatiAF8IHTdsL8WdLUPppc5CYA4l6M=;
        b=GQDvmI6BYk8wAcXohNfNvmAIfKDnPv5BQ3Ij3kf6auS4eKZeoynBRlrOdruKYFYKx9
         XSXqAgjCLpAloxI4d6C9nkMEaFlJ7MzQS5ZWy5jkyFXYpohgd403GdLo31NA3rhcwqrv
         OLUGunGXM8mYD4F55QjwvIFI+xxzWX+1MIz7Eq7+wRO5S5i0N0FWUcCU/WreG6TNyDlw
         J2ROrDfbTzUxB/tqg9vzi4NWzKBbd2vbwq6nvds9zLmP8lJpvJvrHAAG+AIQ5bFHZthg
         /nob5UK11rEPA/EPUKO7Y3qXOWmW/O1UHtoNewz2fIgQGtmif9NNmMVpk/dW4tT0UWfw
         1iqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718807866; x=1719412666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41x36+E2nhusvTatiAF8IHTdsL8WdLUPppc5CYA4l6M=;
        b=fsLjRoplENuWM0rDgfQBIWvNufUa7v8kpF5KZts8MK/WRIXknA8BRAqrFhv/pkWacq
         3EyFlsgvAsg4qSuw3RGEou3DKCyYdJeRJko+UDsV/4Fpdg1Qrxa2GPnbz/iqu45EN3O0
         LIPyLG+61TuhVVarZUhzH1d03TiORp0Q1x1hmE4EeGlUTltVm8Zs0NAULe05Jgx4Iy20
         uiR45nOIq1dNzE5bereaXIhP8kcK/+FiPB5bdn8Fa1m6zSQ8N07gqubfku7B5KkA4ukP
         IKggNiazP0LWIN8h907nmDz2OOUQggLKqZot7O9RwpQYoGa+MuuKZ3QkJNIDh91CmugN
         RZdA==
X-Forwarded-Encrypted: i=1; AJvYcCXgH65cKqJcVZgTbI+e1d052EW1Vov0lfKMABKbEC8ODEQVtchvmHdT09ZehKvlHc+N8EBlG6SUj9ge1vZrYWVo2WowBFk=
X-Gm-Message-State: AOJu0Ywsy3c/pV3mP2N77dh4oquWTPPWEgIcdhqY9wvcIs/cOclIl5Cr
	4g8oI/XDypmMnR3piAzJZEB9+px7ViBa6znSwY2WG6WRcPG944oSIpX1BpTbyA8=
X-Google-Smtp-Source: AGHT+IEcJxNrliYdvuzlpiDb78QsThSHkvJcrlo7MFvwHxPiUc2KNP4DZqSrOqcyX1HTz8934IoI+w==
X-Received: by 2002:a05:620a:4044:b0:79b:b8ef:160d with SMTP id af79cd13be357-79bb8ef1b2fmr197306985a.32.1718807866220;
        Wed, 19 Jun 2024 07:37:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abc0719fsm611398185a.83.2024.06.19.07.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:37:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJwRV-004dKe-BM;
	Wed, 19 Jun 2024 11:37:45 -0300
Date: Wed, 19 Jun 2024 11:37:45 -0300
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
Subject: Re: [PATCH v3 10/21] wifi: ath10k: Use iommu_paging_domain_alloc()
Message-ID: <20240619143745.GE1091770@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-11-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-11-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:44PM +0800, Lu Baolu wrote:
> An iommu domain is allocated in ath10k_fw_init() and is attached to
> ar_snoc->fw.dev in the same function. Use iommu_paging_domain_alloc() to
> make it explicit.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath10k/snoc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
