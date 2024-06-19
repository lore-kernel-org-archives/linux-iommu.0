Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854AC39FD9
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807478; cv=none; b=Mi07x+Wv1cXWyBNZWgX9KCv7dCJW1lAwciFT1Hc6JABXGj8rdiS0uwVzH5em/hxQ0wMpp/H1yAV4LQaVJdB4bYTF2pP10i11YcBgMuc2vZdEpvR09/9LbhhrtIP17VngNrwRf2wDseh70bkF3XCjNIPHOaWw3Kye0hR7dNN9Kww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807478; c=relaxed/simple;
	bh=770+EPGxwLYW0ig1HvdUIyfXv5v4k+2z74/pTuATEmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N20BVTMiVLl8nCX5zFPLXqecbuaezVQjuXPMTcHy0jbhVF0EYzJI0ZfGTAGqzhN6S4JvTcEwfw4/AyavcuzlD1OQQMhkBYplN6LSs1SBunh/fjWSdRXD3j0i0f07Dz1EE0iUGy3oXTaP2E+vmXCn64FLs8qDH/78xRo6y0qpeE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hyMJFS/H; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hyMJFS/H"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25982aa59efso756719fac.3
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 07:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718807476; x=1719412276; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BsT9hgFyZbBGkde271aluLYZILHDBPNQg1gpCGW3N38=;
        b=hyMJFS/H2xqTw6wihCABGMN7ANtp2oxqqNOSJnLpzWXGW+/PgzAUHVc7YbEb3fPpUH
         RwFrJC+HJWb7Qz5eYxOxZAOQ3nAKe9laFsgqRd9s8vNPPuaEt670eZPoBY5XrySR5Tm2
         eJ8vsGFOI8rihCe+3QDiPBKhn7IXaB+5Gl4jWjKkS6Qnid8jHQ9VNh40/ABnBV23dbRF
         Di6XrZjrZZZ7prm+GVscI4sgyoYPFm5P9YRhznGHX8186+fvZXpq6mAJt5kMSUMkPrJK
         usddhtm8ruUfn4g+Z4af2+foCkNDWCXyIF7rQPP1XVZZbNBlJ0eAb/kmSLL8zcoBv/Rp
         fDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718807476; x=1719412276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsT9hgFyZbBGkde271aluLYZILHDBPNQg1gpCGW3N38=;
        b=fb4i4Jxlu/VpyurCAZKQCPLxLZGxidzMXKusex7bgC3J27uNcMzIzhxU3Y9TLtcbHa
         Z8v5elLFfMf9TxrrE8MYbRTI44JVB1BDXdXAU9QyUZp9or9MAAW4Wlds/Urib8OgMAGx
         VC7huz6OtEnNf8sbzdLvsfNvXH0I4KE1CLAS0Os/lZGUYtwxm3P+mZz6l5BudMnWKMrA
         toBGFTO4lEjW1HHmB4J7apj3dMtdEvmdhS0z0UOSmYTcAkF54WLVZHKEWNrp/JM+F+XU
         pjZwFCpqZkQx5QB64n+F/2PPnKWqCtK4l9grLXBHiKDYMABiCkp+RzZH03hJSiARhX4S
         jRyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8lPM0dTn45okXmgmoxH6xfhsiU1Urp0mJWKcsZDqtT7oqD0SyT+Dis3juiS8N7fXk2BmJMOlYIhxSD/OWQJUYZQNVI+k=
X-Gm-Message-State: AOJu0Yygt9/VC+xaVisDZcpR3LLwKZWm+LNt1Rrrknopku0iyTMBlLEN
	x/47ivbYUXIqaHx1p1rlKpSZnrXhL0XV2A/yUEwFBPSsztC/YgtPKLoAdK7ikrA=
X-Google-Smtp-Source: AGHT+IHZayxzfwc1KZvF4t1SmwGVNV6P/gZQ5Mo6uiPN1/R0ej17zeeigaD/qQOHMYxQZ4opihlAhw==
X-Received: by 2002:a05:6871:592:b0:24f:ef6b:353e with SMTP id 586e51a60fabf-25c94d106f7mr3066372fac.36.1718807476505;
        Wed, 19 Jun 2024 07:31:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5bf23f6sm78142956d6.8.2024.06.19.07.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:31:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJwLD-004bUT-Gm;
	Wed, 19 Jun 2024 11:31:15 -0300
Date: Wed, 19 Jun 2024 11:31:15 -0300
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
Subject: Re: [PATCH v3 08/21] media: nvidia: tegra: Use
 iommu_paging_domain_alloc()
Message-ID: <20240619143115.GC1091770@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-9-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-9-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:42PM +0800, Lu Baolu wrote:
> An iommu domain is allocated in tegra_vde_iommu_init() and is attached to
> vde->dev. Use iommu_paging_domain_alloc() to make it explicit.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/media/platform/nvidia/tegra-vde/iommu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
