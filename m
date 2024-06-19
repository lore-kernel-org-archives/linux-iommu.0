Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC85928DA0
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806890; cv=none; b=o/dD+FM3F2/KYR0ZoiAKvfr/RK+EG+Ekm7LBxzyCnvhvNu0BcyfsYfdIFfVNW+iQJUszUBFVrkQH/KFodT+ovzGyd5z9fxVpm64ttb+u7ZSAYLANbUofwq7tIyHS4CF6QnV6+GBkSIrHD9Jiw1iNdCeLU3uRZ7stEO63E4YQpNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806890; c=relaxed/simple;
	bh=jDmb7VW45DnqwAzmE0G7Yx8+dpvdynBkwVU5igS3sOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B97PzNQ+nwfFchmP8TY7jaoQZQ7sJsIlNCedGQMe8t10Q7D2hqnmQMy53/Fe3vNWhacKbxi1VDWlxtmc1AeWP8e6F3SUzYRnIiNL+5a02TayHWiUr/TZCa88HiGAmiYfeCxnRT6auucRGrUKRA8RiFDVFYIU3vvH0i9vzIwQ8ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SZhX5vhi; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SZhX5vhi"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c9d70d93dbso4248564b6e.3
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 07:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718806888; x=1719411688; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oXd93FB8mW37LRaoaeih1f4UeSXMaaR0S6po9oPAKCU=;
        b=SZhX5vhi8GcZpGSOFq4apkp/2XVFXbNgLqfu39be1MiG2ENJLSjM8ZW05ChhIuQGUW
         aG4hcB8bJO7Sa1FroDSyD2YvLUCPod9aMKb4j+MSWdk4xjxJzoqh7vjJOkURr59vpwrl
         ISeWc6naHT7mhcU0ZJECkghgYFUPki+J0LKFkmYeDFpguSCBjgDh0B6vQd06rkLkBujb
         ziwgtGuPfh8vMQuA6Ym0GUGJRtqUm4xyd+9T5blnweuyeN0PWi5KhbNIqsvtjTgnpwqu
         zir738HprNyPPJwoe2ShnWcnM4Rvt1PC9Gf1WwRtrReFDTiUKeDEDoB2Gxtbewyt7Lph
         1ALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806888; x=1719411688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXd93FB8mW37LRaoaeih1f4UeSXMaaR0S6po9oPAKCU=;
        b=q4iKTNk7hKBdinHdbhi9m0ktoo4sadAu7aSul920GMdhB9QSQmesi9hcfVxHqQTZIT
         1ynJpQicWXAqJkUd3URtWo6s1odQ1hjo/nNjYDEgQpbnkj8jnaI352PZ4mEnhhrcu+u8
         iZ7CZAWurNuarjfwcGhgZx9G/fddrcIjTerL/HcxFe8DPPo6fCMouF80EAPDc6OUn82k
         R+RI9ygo7YFM/q9PYA52Xiwc5VyihI4YX9cSRUguhoiwTs4Lf9tjJIqPTn5SMOWgvCs6
         RLv35LjFC38l16yhRQ9UskbQX6e4Zx37tbxsS4y5xKm2EqezAxspj4vWJCC/3dKK0GYf
         A2qg==
X-Forwarded-Encrypted: i=1; AJvYcCWSkBhLR5lz7uJY9UI9toS508QUy6Htg/wzfVL2AGbr1LiWTLfOIrHcXPDU3kN5X9726Dx6uDAjwKpUTA6RlL6lTQSxxPY=
X-Gm-Message-State: AOJu0Yyzn4T+G8IpKrVVBAUH/xOLXV4XwB8sqxQp7x5aZYFgumwOawva
	BZSAyPWoCN9gMw0FG71iGowi8OHKhkmfPHAs8hZcFFNysxoKcEkggWjmkdvdGpo=
X-Google-Smtp-Source: AGHT+IGeUQCBPT+VgM+BpkPpQTiytNsNv7t22Ffuk+cASd5EIDo/hVSa+fwqc195JPldb8qsFYSfsg==
X-Received: by 2002:a05:6808:188f:b0:3d2:29d6:fe8e with SMTP id 5614622812f47-3d51b962118mr3218240b6e.8.1718806887789;
        Wed, 19 Jun 2024 07:21:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444b3aec088sm454201cf.62.2024.06.19.07.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:21:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJwBh-004YeT-Jx;
	Wed, 19 Jun 2024 11:21:25 -0300
Date: Wed, 19 Jun 2024 11:21:25 -0300
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
Subject: Re: [PATCH v3 03/21] vfio/type1: Use iommu_paging_domain_alloc()
Message-ID: <20240619142125.GI791043@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-4-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-4-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:37PM +0800, Lu Baolu wrote:
> Replace iommu_domain_alloc() with iommu_paging_domain_alloc().
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
