Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49021487FE
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519504; cv=none; b=quqM73RYKBTox13Y8NGZDwni89lCX1xF6Ky/t0ShbE6AgkAQyzCvkAICV1foTTF31n7TOJGlFQ6p99HpMAryIKvWhfZH2Y4/CZT9LKD9PehyyQIXBrLsNgluH0kjDq03RgnoVd1sbFJECHCRHiVUR8p3kfU887MjXxVu6Upe/Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519504; c=relaxed/simple;
	bh=Jl68LcgBN1pRhZi6PtJEE4lVnKKYIRWjPxs0FDaFCcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCNMkWEIFkmgaL/wievj87I30MaFJSwXH4tBpA3NXqVVIGq41preE1+RMjtrxB41ow4AexAI9ZNI3YvvvZIbO/iEgckr6YBLnd0HWOkXOIOfClfPbLU7u4UJ9tiPM6s4He2QCTRh772hlei4BVGEMlYnoT1RMNTIJPFyZj8rb+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jsj7ZQXm; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jsj7ZQXm"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b96a95c5e8so3236387eaf.3
        for <iommu@lists.linux.dev>; Tue, 04 Jun 2024 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1717519502; x=1718124302; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=13DrUW0wsjFsOLQQnsi9knf7av4PrVRrLk1t14myUlc=;
        b=jsj7ZQXm6YlL+g5md8WHlVmo2F9ItLlQg1CDARVcjRi9c5LZa4Yk9lyvU5iSu06eXq
         FPdurjvTt1aVBvmq7vSM2xgamiL0vFWk/fqBjCxBqPO7UpI+iozq45fyjo9D7fw146+B
         GW0DPdl++UWYmwhyxj25NE8Uri8yDOv0FTcdmP3LyiERDrnpjzDK3udKKZCE+ADqBXyp
         X9QHdf/tezy9s3xVDcn6DX1AduDsuQkexXmzwYetNtyyzKZ5GDG7o/ogUZBiRYtZxepf
         Hf4BTeFEVx3BA5db+gkKvVBIxiCgYdUH1cIE/xtzwMuYdd7rv7in6k8Mt3top0cZndQK
         KS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717519502; x=1718124302;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13DrUW0wsjFsOLQQnsi9knf7av4PrVRrLk1t14myUlc=;
        b=gwSn24X5SGVsXwLNKUg84f7S9USfueEuTWCMhVPSpMtC82o11fK46h283ODIJCJdQn
         ik1LI5v+bb9Fuuje6l5J68iHYRfGTYHaf5ZjwFpGXDn5vZjBJ8hY9YyzVTGQWqHvpdyP
         D1GO+L8xSZ3QyvQHYsrK7nMMUODqwbxDJQtLmbfoNC7UaVbJ+IwLPHhZ5Lqof9Il4Fbx
         76PJwUeeq+6FFHH63a+SEBeS0jVcp0nQlTUWE2xo+l7UqxYjKwdHHW+r0ppFbum25XvZ
         js6JjzjtpKktto/CtdC9dm0+vlEAfimZMIPS6otRbyWojPIMfcenXwEOXwBoim8FK/zl
         fCOw==
X-Forwarded-Encrypted: i=1; AJvYcCXCaHijL+Mtbo80Nda2kEw1XQaz+k8G8nJw6AtmHf8ZoREzWQEi1Yb7JYwM6ln3Ik6XDpGnmqhUmwmJris3jxPeIPjBjQs=
X-Gm-Message-State: AOJu0YxFLMYhoSYssp2EaTCbSSqVIFOMwKp/Rbg71JxQyB2MzmDFfNsr
	kv0iMoyyxdNPipN2G3oU3hwdB8p9jv4tFqk6RAySRNhl49YNusXMGuB5wOXneAI=
X-Google-Smtp-Source: AGHT+IEfas1lnZdFNBRgqZxmKWv2oXN51AWEQ8aiqFcaC4Ca/kraXgYuVuAGXMg9aTheAhe7N7CZog==
X-Received: by 2002:a05:6870:4708:b0:24f:f297:3ff7 with SMTP id 586e51a60fabf-25122a6d964mr33165fac.38.1717519501608;
        Tue, 04 Jun 2024 09:45:01 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44009a2902csm30190921cf.38.2024.06.04.09.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:45:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sEXHP-002tE6-4C;
	Tue, 04 Jun 2024 13:44:59 -0300
Date: Tue, 4 Jun 2024 13:44:59 -0300
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
	Mikko Perttunen <mperttunen@nvidia.com>, iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/22] RDMA/usnic: Use iommu_paging_domain_alloc()
Message-ID: <20240604164459.GC21513@ziepe.ca>
References: <20240604015134.164206-1-baolu.lu@linux.intel.com>
 <20240604015134.164206-16-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240604015134.164206-16-baolu.lu@linux.intel.com>

On Tue, Jun 04, 2024 at 09:51:27AM +0800, Lu Baolu wrote:
> usnic_uiom_alloc_pd() allocates a paging domain for a given device.
> In this case, iommu_domain_alloc(dev->bus) is equivalent to 
> iommu_paging_domain_alloc(dev). Replace it as iommu_domain_alloc()
> has been deprecated.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/infiniband/hw/usnic/usnic_uiom.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
