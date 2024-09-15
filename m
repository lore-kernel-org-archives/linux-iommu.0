Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F24F1C68A7
	for <iommu@lists.linux.dev>; Sun, 15 Sep 2024 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726409290; cv=none; b=rI6rux0DCyJwKTV6EYr8d5j0uSxU6038rXN/P/MzZmpHT+P7OZTMVH2zEC/S7Y3+cZMCiJxy/LCc+BKj6AOI7bIh7tD4942WSLksqJAtsocVhC2kEmDec/hsJd/M2FxNDPb4gz9Qc/iDV1XzlwI+w//5fYCuYdMCWD/W1BVd6VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726409290; c=relaxed/simple;
	bh=GfT6dD8sFY2oQhCO9PtqTkl3lPIfLc+IuYIxo1EtG9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Huq/8HHhV9+NOH4+FDLpEbqRUFFu5+eNVzmIktxIqSaawHRF2+9ZcTz+H1fMkw8y+y/WoT3/xPxl+0+FfVAoBLqGT7GSDgiITEvO3gPgggSP0hLz+soTxah1q7LIucbvcS3P2lY/+zey741rtQ15Dofv7XE+a7Q49Mj0PNmHaHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Tq4vQM2v; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Tq4vQM2v"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6c582ca168fso14482816d6.2
        for <iommu@lists.linux.dev>; Sun, 15 Sep 2024 07:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1726409287; x=1727014087; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qETOmqLs3VcWBE6fq/NLpP/VdMfGfLvWYa4naTceEbU=;
        b=Tq4vQM2v7/KbcVIkpC9kPi2zGFHSiTKryYu+5mQDzzm0/JoZLXjPpYOoNPZnMnXFox
         5JkPmix5p29DZFzUNK+lN9PwQRrE7uW4LTohHJjD2F0v9Xz0c6BmvWFn6InBcBeFN3+U
         ydAZRX6Aed+Ghy5zhU57FJukt7UYXTqZZkFdPxBi9VAS5iAecFwg5c2xnPvr09XF6Co4
         B4J/aWN+Wo874ZKMnjYzqzCwTWg0KszNUadb0CJBi5v9kdF+TwHqUvxK/ox+McmkIRkD
         7Lm94VnFwiFRsblzzuUl7BpXszBQRhzeZngr5TEHDaBq4vOB98pWgFr8PYLae8JcrRSO
         KVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726409287; x=1727014087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qETOmqLs3VcWBE6fq/NLpP/VdMfGfLvWYa4naTceEbU=;
        b=BFHJPGaljDYuUCFA65M+CWqp4akPTFfs2tk+tL9u5TxfeBG3jMy+NEW/s96xmmtrrd
         DF8Jd6uzlLAUra+v83EmkKr/pS/aY1ag1fjCWoRnA0cj8oVKC91owLY6hInmoWV2wmpm
         BfCLOYZnUvy/m45ivZy7iRhMWFxV/6nOD+dr6Ve/tzqpQzpqDk5kF5VUKtyqZsvk16BF
         kOl/EgnuV29q//Qi45KgGLKUylZMAFncnBKFuq8/SWW4WMPJyqG5C/pLmnxwfNSXSX+/
         tZUC68CMfw67b9bfcPpovL9tl2HDuIrn+bjCMLLOO4C3LFvJgnCkmBzT5R5l2DEmq6Np
         df4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAhJ/QK3j0hNmWYcq/KikU0l7yDH2eOdMQSuofG1H31Zbk4LP07WAWUNdsTOwsl2qK2MZ22g==@lists.linux.dev
X-Gm-Message-State: AOJu0YycFyABmNS88Jx/CpssAhsql635HI0uQ5ln4lgGk8CADxcjZYC1
	TU/RWJnys9Ovwukj9e0wzu7CbGmojeIY37QamiqdW321ZtPupOSNrDX3QRousok=
X-Google-Smtp-Source: AGHT+IEGScRXWkjCa1MsukJtaEHzEo9sxiP6ZOXcwDMa/t01rqjqte/GHdDfO4BuPAC0Ip8flPeYYw==
X-Received: by 2002:a05:6214:5a07:b0:6c5:5326:18a5 with SMTP id 6a1803df08f44-6c57dfb94a0mr155649476d6.28.1726409287152;
        Sun, 15 Sep 2024 07:08:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c632f7bsm16033696d6.37.2024.09.15.07.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 07:08:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sppv4-007h2G-0a;
	Sun, 15 Sep 2024 11:08:06 -0300
Date: Sun, 15 Sep 2024 11:08:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lyude Paul <lyude@redhat.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Karol Herbst <kherbst@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sandy Huang <hjc@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] drm/nouveau/tegra: Use iommu_paging_domain_alloc()
Message-ID: <20240915140806.GE869260@ziepe.ca>
References: <20240902014700.66095-1-baolu.lu@linux.intel.com>
 <20240902014700.66095-2-baolu.lu@linux.intel.com>
 <a43c31da6a6989874eb0998dc937d7a611ec542c.camel@redhat.com>
 <20240905132459.GG1909087@ziepe.ca>
 <243808ad949823a0d64cd785ed05a375ccdba096.camel@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <243808ad949823a0d64cd785ed05a375ccdba096.camel@redhat.com>

On Thu, Sep 05, 2024 at 12:26:31PM -0400, Lyude Paul wrote:
> I did take the one patch - but I'm happy to push the others to drm-misc
> (provided they all get reviewed. 2/3 seems to be reviewed already but not 3/3)

Did it get lost?

$ git reset --hard next-20240913
$ git grep 'iommu_domain_alloc(' drivers/gpu/
drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c:		tdev->iommu.domain = iommu_domain_alloc(&platform_bus_type);

??

 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c |  4 ++--
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        | 10 +++++++---
 drivers/gpu/drm/tegra/drm.c                        |  5 +++--

Now we have the other two but not nouveau?

Jason
