Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C26725A642
	for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185896; cv=none; b=teA7TDAR92LGE1fVC1VePGeUqhHI0Ilwr/hjhPlbrTj6sLnNCYudm4UNNJwCA9uN/W5uYvmmZ2tlH4h5X1PWeiKN/fHPfB5ohIHy+a236prCNmwVOxxWCKG1OcoYgBSQCW90c/p2o+6Vi5bfu8eHB4BWlVTyM1ONdAh+WPTOm/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185896; c=relaxed/simple;
	bh=/94C/UlPmwUDToYy/+qtR2DFocibuSIwzpBkOhnUW50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2ANTekuajwSgHyNraQYGmVAVflad8/e5qR2NHC0Q5RoiMUwsY5rqZHVilILz5xJbCznHL4SeNNDNwGul1ONoS3wIe6dzgk3TNYzuFakN3rhBZTiQ8X9MNuE7arbJMilQaO3laEJRrnFl+5X1Dgg3VLYhM2sFow2Od9Ky776rUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=S1Exg5gx; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="S1Exg5gx"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c5389c3d4cso275261285a.3
        for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 08:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769185893; x=1769790693; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=871+kMuUuN8eKawcT4NNcOEOt4uiGeIzveYuD9+CVek=;
        b=S1Exg5gxnaZ7jUx0IoaNVZDmzsxuyZUcojxAOR7c3+KCcqTQyo05NW1jjMGd58o4UZ
         IwFrHpMMPQQfZiQeYuNz5z9PD4ljqLE7nS3gX1wMsnLJIirqmjv7Q4pBXMkthDs4F3Ge
         TcRCZVSqTRLUAFx/dlbMXk9hBYshBoltWEqdZKTB+WBSR/y9TYuL6L6kkDo9zzJzLgHZ
         /TlOSSMxMQrLBl32/gil+XpgBCcLwkhSwi3lFJ/6dZ1kCd250MFQSGrDwNy5GJg5DvFe
         Ot8Admvsz+k71BffKiYo6mClLhvhD4EnZq4acB0ccibhbJAUZWTxCVlB3Bx8/pP8zEgI
         p/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769185893; x=1769790693;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=871+kMuUuN8eKawcT4NNcOEOt4uiGeIzveYuD9+CVek=;
        b=UZuIUgy1xPAvRw8WUoRKAquvY47K28PxfPvK7Q9NfP63qzD2qy795V/OYn5yDX1bFj
         JPxyvlxoTxPD+luSkHDgV7t3OfYAcNLlLU0gON+BEgNyeOM6DD54CnMwIALVOd+ZrOiP
         +qvbDaQbcQmzNbfcmyboYaEETf+SuUyS5ltoBFUfBXooMOKGhhaDcYM4t9NpikaIJG4e
         IvAgMMnbi1HP754cTRjJwBzGiqQ2cpWTcHbuipFxnpyIsa4MMM+nb0PswcJQxOBF9JDN
         RbuySLt0LVyX9k9dnOmGsy+U47FGtd8WO6Ot8OUXs5rCWzcp4OJxMo6QRNm18BXoUMah
         e0mg==
X-Forwarded-Encrypted: i=1; AJvYcCUGYDlfmAjpC6Is+QbnCHhO1Qtrrj6jV/NcgG/7wlSPwQIorAwmHLnW7FTQBDbNRKbQR0BJ1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7ScfBzs8jcPllld0EDCkTpm0OhQ8Yj4FrfJiuHzI8oEVXWVRZ
	Mka0tLToIKfaMFlCmalZeOOZdNL6nubD54Ip4EXaP4J9Qj4HK5R8ocXjjnnBpcKtvEE=
X-Gm-Gg: AZuq6aKht2K16rZHs9YnW1TzgsMq9Mil9Ytag4TwSfkEI/gl/zdtqncVKnwGOimBH92
	xGGur4go7aTqIFVI0G4yuOu5sAh1bgNEJccouS19qubmBJNa42WInzWlFoGplvw2prspmtNszCk
	HD5mwc3zbgnV3bi2Sg1bO6bV0gCmqjlNBqCoBNH6hEs+MA4AfqI10UR1+bmdcUw1R2F+piXg5Lt
	vDu8joWcxslmS0pyZUv+QitIVUpEUz1XoT6bZoHP2ZC9kTU/wvf3CvQqHySP5kC6UeTkHAseyUj
	e4nHbArDio4FW0sZsqvPpwLpnTpjmGpp9dr4tuWVnO+HEjx83PyEnk3USOr0iT2fMoW5gjCgBnm
	aRoMs+QR5x9zp5s500iksaVhQX8cc2m2Z+2ANDMX7iXqxA0mNp4/QySVbLvIO3xInpJvUEZo6al
	DUsxIsrOky+d21TIM8mc6Bk0VBKHLazWZ0rR+TctWuQ2zjshCHdZE9mZrVPTCBonJuEFg=
X-Received: by 2002:a05:620a:1901:b0:8c6:c9a2:504d with SMTP id af79cd13be357-8c6e2e48438mr431308085a.59.1769185893221;
        Fri, 23 Jan 2026 08:31:33 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8949193cdc1sm19709316d6.47.2026.01.23.08.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 08:31:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vjK4K-00000007Grc-04II;
	Fri, 23 Jan 2026 12:31:32 -0400
Date: Fri, 23 Jan 2026 12:31:32 -0400
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
Subject: Re: [PATCH v3 6/7] vfio: Wait for dma-buf invalidation to complete
Message-ID: <20260123163132.GA1641016@ziepe.ca>
References: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
 <20260120-dmabuf-revoke-v3-6-b7e0b07b8214@nvidia.com>
 <b129f0c1-b61e-4efb-9e25-d8cdadaca1b3@amd.com>
 <20260121133146.GY961572@ziepe.ca>
 <b88b500c-bacc-483d-9d1a-725d4158302a@amd.com>
 <20260121160140.GF961572@ziepe.ca>
 <a1c55bd8-9891-4064-83fe-ac56141e586f@amd.com>
 <20260122234404.GB1589888@ziepe.ca>
 <20260123141140.GC1589888@ziepe.ca>
 <98b74c7a-44c1-49ba-997b-bbbab60429ba@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98b74c7a-44c1-49ba-997b-bbbab60429ba@amd.com>

On Fri, Jan 23, 2026 at 05:23:34PM +0100, Christian König wrote:
> > It is illegal to call the DMA API after your driver is unprobed. The
> > kernel can oops. So if a driver is allowing remove() to complete
> > before all the dma_buf_unmaps have been called it is buggy and risks
> > an oops.
> > 
> > https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/#m0c7dda0fb5981240879c5ca489176987d688844c
> > 
> > As calling a dma_buf_unmap() -> dma_unma_sg() after remove() returns
> > is not allowed..
> 
> That is not even in the hands of the driver. The DMA-buf framework
> itself does a module_get() on the exporter.

module_get() prevents the module from being unloaded. It does not
prevent the user from using /sys/../unbind or various other ways to
remove the driver from the device.

rmmod is a popular way to trigger remove() on a driver but not the
only way, and you can't point to a module_get() to dismiss issues with
driver remove() correctness.

> Revoking the DMA mappings won't change anything on that, the
> importer needs to stop using the DMA-buf and drop all their
> references.

And to be correct an exporting driver needs to wait in its remove
function until all the unmaps are done.

Jason
