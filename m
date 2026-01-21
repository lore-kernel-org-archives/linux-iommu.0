Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D006369991
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001537; cv=none; b=IjQv4Xn67lQYsMRKagUR6160HMw5bIlhc6XLwTZFVdIYjRSr5qvG5DpE20QQHEEMYaHhxfQDzPcZVBzJp4DPYxWV3Vx/VLznsWnqpUH+4JWwANh+BEDBvQHEiNJQz4yzHzZaIzTkMtGRTWLxOhgXK67G2xHoAhLqWgdchRDIV64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001537; c=relaxed/simple;
	bh=wNQCHIWEBRMpiFqsZYjt880FRkRpyp1yzlc3O4lUKsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppPIsvIdHi7Hw0yqXuS5jL9BVejDIMrLdczJzluUXMYK8CzOJhDn4vknkGMKq6evkgjK8uQhg52Yl8WAX6AxztDkdscDfvGq6znmO5LCQ+iW31nC+IULk57vLTYntQvEA/tVJ9Mg4MA9O93GicNc1947bDtau7rPnNLBf/5NV1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hnFe/433; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hnFe/433"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c6a822068eso680331085a.3
        for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 05:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769001534; x=1769606334; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wNQCHIWEBRMpiFqsZYjt880FRkRpyp1yzlc3O4lUKsM=;
        b=hnFe/433GxRz2hr5i6+dpScjsWLhGlEObyIfXbGHTbMaEMRySw7IJH4hindawcRdWy
         YHQZIpgwhvz5mBsI+DmRDf434kJQat+Xl3u3xsvQGkwZ1g5GF58DBzs5uKruhqgRCPE4
         1LgXlA8IQbsA7I7EWMqn1FUgnNybnVeqN42C3RN6LgPpVneCpXFNBuKZLC4Z9XLtuDSy
         jxnr3AIotIBuj7uXdPk8XmKLdQ198HnjEPP2JqoZC1yiI/7C/pt7udKYNRqe7n70419d
         5xkdwa4X0umkRN6xg76pPGPYB0fBwOT/e4ncNIoTIUPwPx5c7giABdq0pzZLaVgo/NUY
         1tLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769001534; x=1769606334;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNQCHIWEBRMpiFqsZYjt880FRkRpyp1yzlc3O4lUKsM=;
        b=daK9E7lSo49VjZLteI/xvRE6MggsL/DQ5HJcALHi8dejyRFBWLIKjo8A8d8JosLw/T
         EMppWM66I5sQAjHiR5Fwcb9tBcrPB0gMpP+sIov/PUKWGGkt56OcQYCASua427l7VBru
         /MmJPy4FxufUcfo4Y9yUX45GBiKZBsHtHYXwwW1VewjflJoeoxraNcZKsEfqNkViwi+r
         2veNCJJKbT0ClMrRSbbhEnW5NnC+RH1+f8SBapp2/HIyWKICjTjHYVP5J7WYaLXj0Jp2
         gk+httc8+J3zvkrGwSruKMV712aTV0KPXiYI3iC0j3lD/3ynD/6y1JymZxipxr2dEzTx
         bG3w==
X-Forwarded-Encrypted: i=1; AJvYcCXJDRIRQ4zNXnv20ayO78j2ncb1/2r/I8NM06vNdFrOvrcwLkz74UO6+tXxuv6V6fEEQjyUuw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJpFKZc3zC2QttsN9rVsF2OmCSeeyla6Rt+4PLO6zYdWGC2tWx
	ek/i5VgCyVX9S4LvP4BV3s1K+w1c1YrRnW4sessxC6RM5v8LDb8stkLcqyctiLuf6LY=
X-Gm-Gg: AZuq6aIwbppamPPWivpGrUc9L4hX0BEmG7DMe3bRcT7rhp0QrI1kPRds8N+CsAdzmBk
	H9mE+xNS6n3+Aa1Zm6D7wuUK3lCvWZzV/aCZ2aE48P8+NraDEHGPbh6FyejfnHJS5jfdf8yyi3c
	8sa+/0ezEvfOghLpozZEJc/kw5jUSPma++mv/P9n8omgaxNYQBOVF/E7m/PaRKcuzwerDO91aZt
	B4BhKTAK1x7dW4oFP16KlmiaMBbn675Zwz27mDRhJRLIRQZvMixfrTU6rU1rHICm0B/mRdDNwMR
	bkws+wfQg3w33K5c1fbCHZbtVnnczGg0Z/P12zP2q15nI5rNCI2yNdS1BiI+9VZL3lMuv3MdvEL
	U5gfsmoUvkdeDYn9jtVFkdsNr38FP4Y0KyFMBh/7DVnHG3/9Ia4lHmFgXDMzfF40dEzb5I/qjnP
	nb/mG+Y47Op8tYoHdgjvdWHvSj2I10mwFCN5l5Ktvu6R6zMgE3WytS31GOsmY3qKLiLPo=
X-Received: by 2002:a05:620a:a819:b0:8c6:aaf3:cb44 with SMTP id af79cd13be357-8c6aaf3cd9bmr2247463385a.4.1769001534382;
        Wed, 21 Jan 2026 05:18:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ad820sm1209794385a.10.2026.01.21.05.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 05:18:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viY6m-00000006DUF-3lkE;
	Wed, 21 Jan 2026 09:18:52 -0400
Date: Wed, 21 Jan 2026 09:18:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
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
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v3 3/7] dma-buf: Document RDMA non-ODP
 invalidate_mapping() special case
Message-ID: <20260121131852.GX961572@ziepe.ca>
References: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
 <20260120-dmabuf-revoke-v3-3-b7e0b07b8214@nvidia.com>
 <4fe42e7e-846c-4aae-8274-3e9a5e7f9a6d@amd.com>
 <20260121091423.GY13201@unreal>
 <7cfe0495-f654-4f9d-8194-fa5717eeafff@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7cfe0495-f654-4f9d-8194-fa5717eeafff@amd.com>

On Wed, Jan 21, 2026 at 10:17:16AM +0100, Christian König wrote:
> The whole idea is to make invalidate_mappings truly optional.

But it's not really optional! It's absence means we are ignoring UAF
security issues when the exporters do their move_notify() and nothing
happens.

Given this I don't want to loose the warning log either, the situation
needs to be reported..

Jason
