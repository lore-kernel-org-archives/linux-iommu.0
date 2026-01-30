Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EFC31A051
	for <iommu@lists.linux.dev>; Fri, 30 Jan 2026 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769784258; cv=none; b=dXLUY1zWxmjBGKwYfk44x4Y9lZC9SXWM3OzqQ6iLjBQpW3Zq78sKUDAt6wxxeX0eH6SfIn3tNnxSWs4H9qViBoYPUoQMEptkz8x0fUjopQya5yhUxl/ExvOFlDIerAHUvsje/mU8cA2PwNzGXP3CG3LPZQs76fE0yyGNsE69c0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769784258; c=relaxed/simple;
	bh=VsbMM5xoKqA8UQ3isRtzAP4PmVkOh9whfmV8sar8q8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/2jnyer26LvKT/sWgwT1nw08Qyz/VgJvdZ1nh9ir8qPs+j7HGeAoFmF1ywM5xyPMLcdfSbWMykkwubaOkvQfKSd3Ujo2Khnrwgwl6C9saX2BLmCgDdJpZ1tF5t11KQaN+QGMgLm2hG5BvrJsAW+npGfyShSN6gG1qu6uUB98jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LJmGvR8I; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LJmGvR8I"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c70ce93afaso242625385a.0
        for <iommu@lists.linux.dev>; Fri, 30 Jan 2026 06:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769784256; x=1770389056; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UlIFC23S9unnjQhVGEC3vUha1a+Kfy5xxpLqRiUCtvQ=;
        b=LJmGvR8IqrpJDPc8jT0PD+X9VvToKaanktMZQnxVNibAi0U9NqfLUaJE1S/W8EqxNP
         u1+c2st9Mn1muRaw1YRBJmXeIg6esrtQxLks8Ji3kUx0uPFzUSdzKE1aVh6B6uk+Qw4E
         iKtk+BjfbJlRhdV+LINIizvqGiGz6RxLzmKZTiOb0vUSMlQdkQWOFAw4L4LbM/crIyt4
         gnOGtiqgMRxeLkRkoynolW/BogxpPer1ihRjlVTL971TbShh7ehmPoKp/erzBnba+Aa6
         KYdWFk8asWeZzB81BK1SMEF22aa3QIftg0xJCHCx6FpGpiw0j79IUb7iBup/ZwIay4mh
         u6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769784256; x=1770389056;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UlIFC23S9unnjQhVGEC3vUha1a+Kfy5xxpLqRiUCtvQ=;
        b=d+p2DLzZZ9Li5+lXUIBVotgY2m4kX0M3SgLbzQgOHtTEKjSOxQVflDMNwTPKqteS7p
         2ZKCjg/9qjft92RZtzZgct9m3BpKNuK1yCpBjMifqVJXfDcXQiTeSqeZHSrKjJ3P2Exq
         wmIa/VXc5UfoVs1sr53Pim0YpzH7h6dz/TQ3lnBgsHuz491eIrt+wVzGUB4y1H1X1sRj
         hfZZ1a6ZU2qCF3dxxu7UIlj5R57cS92oWugcp0P8GpCrEGiwM+2dR2y3nTmbm5KFPVLG
         UoZzQHt+mSJSQ3ACJGcEHzN+f/wWRgU99wmit8ctqWxIN4873FgyDdv10Clknfflfp3Z
         qn+w==
X-Forwarded-Encrypted: i=1; AJvYcCX8U6/Rx4s/yp5dfn+yzdd1UYxXTwoQ/nqhc2X/ALHI/ZgIBKO8VD3en7CakmlaMNwzzRE/ew==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNoH0bwhGD1tUfXahe5N2ucuwBxhBO58Lr5EvssytGgwmBmhh9
	mHKhFGvbLWGKj5IBU36V8ET8PYyL0uGK7CRZrGheCx9dLfl+YJe7F38OHo+i6N7CepE=
X-Gm-Gg: AZuq6aKNNVSZGwcGSeX72FcF4iRYFiKgPBGXK+qywucd8AGJ0wWKfknazcTQIkx+nt3
	LSOz/+sNRMvdJnu3M/YT+ZEDwsZzcR1T8eZVUN/0HYU2j9qMCr86zhh9CgoO8aPSUdJVwlrSC5a
	sgG3qBftAN4VIZdr2sJy9f3sJwwdn29H39L/P6Sihr7WG7P9ZHVHsm4rPmpcNiUihOgHkVzpZQ0
	pI/llz6+8o0eMaDVvemdc7aaBiqoyD4E4mMIgROBhJMLy4zfHK6QTTsjGOXzNoHVyIY2xgAnx3b
	1/qx8OgoSy+U2Kj1f8Y1WY+yW/K13UNqDIZ9MNOK0Q6LAdYcH8IgfLNHptxi/2Yiyd4QTSpbneO
	Vx5sjk4gfcK1XR5fevSqEEo3Q91TrEllaXI3ltybxhZrrAPhGeca0ZDQlscf9MZD8fz7XblGVER
	fQZ0Y6HB5Q8MxEzI556lEhFMCooPSnRtR7ujYpVCkX2LBFiZ57DgAelcoJdajKY7xV1MY=
X-Received: by 2002:ac8:7f0f:0:b0:501:51b6:cd3e with SMTP id d75a77b69052e-505d21a4775mr39321141cf.29.1769784256186;
        Fri, 30 Jan 2026 06:44:16 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c426sm56137391cf.7.2026.01.30.06.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 06:44:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vlpjL-0000000B0t1-0Fhg;
	Fri, 30 Jan 2026 10:44:15 -0400
Date: Fri, 30 Jan 2026 10:44:15 -0400
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
Subject: Re: [PATCH v5 4/8] vfio: Wait for dma-buf invalidation to complete
Message-ID: <20260130144415.GE2328995@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-4-f98fca917e96@nvidia.com>
 <31872c87-5cba-4081-8196-72cc839c6122@amd.com>
 <20260130130131.GO10992@unreal>
 <d25bead8-8372-4791-a741-3371342f4698@amd.com>
 <20260130135618.GC2328995@ziepe.ca>
 <d1dce6c1-9a89-4ae4-90eb-7b6d8cdcdd91@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1dce6c1-9a89-4ae4-90eb-7b6d8cdcdd91@amd.com>

On Fri, Jan 30, 2026 at 03:11:48PM +0100, Christian König wrote:
> On 1/30/26 14:56, Jason Gunthorpe wrote:
> > On Fri, Jan 30, 2026 at 02:21:08PM +0100, Christian König wrote:
> > 
> >> That would work for me.
> >>
> >> Question is if you really want to do it this way? See usually
> >> exporters try to avoid blocking such functions.
> > 
> > Yes, it has to be this way, revoke is a synchronous user space
> > triggered operation around things like FLR or device close. We can't
> > defer it into some background operation like pm.
> 
> Yeah, but you only need that in a couple of use cases and not all.

Not all, that is why the dma_buf_attach_revocable() is there to
distinguish this case from others.

Jason
