Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453039;
	b=w92ok/+LUA5ZCGaZG4KslaAFGA9avHP8qTSrBnutCGZyiW5vPlQ4QCK2dpC1ryScU+PU
	 y//3jrnntQyexp8sHUKuMcAoXgKX74JYhT/tj8QnrVA18nx5+HGQaHhCIXEybPfGNbGCL
	 9NUI2AnlMnjS0jLHcWiL9vH5zeSO00LaZ9yxzqRdzs68vapaQz9r/DwLxz1XSnHobMmlo
	 071sIgM6fo2Z20fs/H5lsxh1YIKvvhB+g+ZGv63XrFei9t1jUe1qO410TyXmXy5BgjI2e
	 /nZEAhWbaUPFzFkclHWIY/N74pIMTpm38bJFjs0yninScNUBUyalB3sG8jOyhWze33Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=j5i4WU3qjrhh//MRl3wcVLLT33h5NdpwdC0V5dWlBjs=;
	b=ism2Hwoh8COZt4Hv8kj3wQNRJ1X44fvbEx4pf2GTC3Yj0TRDV9ICSjZbtxyD8d38iXXH
	 7zDQC/kb2UsOHg8AtZI1om+CvH0uBOSuj/ZyvVph5stm/XFi9wODcHrSRyLYPyWIAIHgK
	 Gx2hAFEy/5LUUVoXQj4a82owiR+YgVo7zmBKSlUCN501rPQG4ibHAYUHubwlNY0ry/HDV
	 OS2L5C/Y2uAY0im7q7X1XaMFT39WZPCNcX/gQR8nqvpVxFmGVuRkZooTbtSMEzPsKpTFc
	 /VnHGbucLREddNiYYKwMtXOPx/YP/yus6G+TfHtRWgib2RLNAjE1ACaGYld462RMOWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=hGnhKLk7;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EE8606A321
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 16:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4EE8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=hGnhKLk7
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-949dcf80821so134620485a.0
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 08:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795453038; x=1796057838; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j5i4WU3qjrhh//MRl3wcVLLT33h5NdpwdC0V5dWlBjs=;
        b=hGnhKLk7LfVg69pgarwVqXSG+O9MpS+O0dt2JGC8b/XEH0xplKLjTp88p2QaSF7KZL
         phuv215ZkKvPm67hbeod3V3C2OgbPRgFXYcr/pi3SYv64LdaJEmmJZIt+yrM9YsSrkCj
         cvMFHxRLwKGEXezeOnc5CgdBupDvm4IoQt4cuY+n6XLv5TtgKo4Qfz9jeh4tI+Ac56+0
         x4N2mGM5nwIHNa9Z8V+QxWGHf8j5vaVBjtMjaHOYyOqG1DUvkgNWoUZ1/z3ASQop+VHo
         VL8Jh5mcJcjAOJrxAgZqhAMNxkxkueMLYmk42EkhYQyz6gigzca/sbLqjiQAHLYF5Gzu
         Vnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795453038; x=1796057838;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=j5i4WU3qjrhh//MRl3wcVLLT33h5NdpwdC0V5dWlBjs=;
        b=BhpNdg38QlFJAmhI+SNBgHYRER96wM8lurf0LdLEjE3MU1yMQp4e4ZPqiJlLTuqDNH
         czXdkqtDQKGgL++XfPeltmkPvxi74vs4Yargar/CSo5QwToTUrTaL0WuJiN93bPedMYk
         UBBNDmNi4cSPpKaS/HQh8qcB92exOx6MO0ywoWWh+5sjk/miUwTz+g09hXEoranjgiOP
         m9+5lscwindxYL+QzG25SPg1NFvIOv1vpqn0uliOUsSci3713jbjTzhzC4WEnvfYEu12
         WZMwXipYAKol0+K3TiBHq3DAViCCfLx86qjEZRTQqs1F3tptxhaiuD388j+b4aDuLy/N
         FHbw==
X-Forwarded-Encrypted: i=1; AL+hErEFr5UYWKmGw1kRUbQ3rpuPEZlqSFE2h1xir1aBHw4znXXoyij/lYRSYlzQnfl7+LvoMFRguA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/IBI3gz8esO60NzFnU7H4X5dVGIC7bmyrZal+4Glmx5K+Muc4e
	P5AcK3fxdLHVA1vT9YcAtsLBFdHgsfedtbM/CWarAhHEcYQcJndltmOwqx6kvqc4yrU=
X-Gm-Gg: AZFdTZfWETdNdzVRibaSVvRui/SHk0/lUT+yLutvu1wWYxY4J4pXH7WVfD+KQTRIqTT
	JIP103nw91cgYwb8Vpu36c4wq7rf/kVJkjoq2O0YUTDRTgdP1qnoPgYw2qO59miOz23O00cxTvm
	TPkRQfxIvFElYtXr1ir5FvLXrwlgUvH/f2fnZFl+20/Mv1c62lrK2ZyRvjiSqi+nXSd1mH2J+eS
	nOz/ehaIha2RGFxwIyt8QOofT8PmCUPDbBeE++Y3ClN5kn7wvz5vLGVXTYa9vg0qdHaf6F8dxOg
	xrk/NG8Q5UZP5R3tyAaObKu9DLHLnkHjgpMVBBeqMTDcqat8alOgsoOQwyfPAVqONIQHmOwPB+j
	fwz8yWZDXvHqg3NgBOpY1DV1npFNN+/fQqvn7PbWb3LfxyuVDHVfUjZR74wIH6lSoOoIJ09lxZv
	8b/TJzhC5A8C7/DuLhOb49esEzmD0QmKyPfDAhxywUV6I/I3H2TSKhUsOH30jANTdwm04D0M28o
	i5D38hbIO4/l6xTwo06VwKAIqpOoZbJIDsfU4gfRb2HobhVFT7paS4r+PjgYxZvOXBOZKRR90Tb
	PFk8BVD4tR1451z+j0I7oWvMMBlx+n/sLi2R4oRdYepfTm7bWa1xsJTpXgBLDEF7wYEYrGvuMR1
	lok4YQ1PXwykAAMp78qMuf85w
X-Received: by 2002:a05:620a:270d:b0:949:8109:8bcd with SMTP id af79cd13be357-949bab6d24dmr1950593985a.77.1795453037117;
        Mon, 23 Nov 2026 08:57:17 -0800 (PST)
Received: from ziepe.ca (stjhnbsu6iw-159-2-142-59.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.142.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb031601sm844162485a.6.2026.11.23.08.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:57:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVXLw-00000000woc-0Jy7;
	Mon, 23 Nov 2026 12:57:16 -0400
Date: Mon, 23 Nov 2026 12:57:16 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Matthew Brost <matthew.brost@intel.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Dongwon Kim <dongwon.kim@intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	Alexey Kardashevskiy <aik@amd.com>, zhipingz@meta.com,
	treding@nvidia.com, jhubbard@nvidia.com, chaitanyak@nvidia.com,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v3 03/24] dma-buf: Add the SGT DMA mapping type
Message-ID: <20261123165716.GM179082@ziepe.ca>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-3-c0183a409bdf@nvidia.com>
 <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>

On Mon, Nov 23, 2026 at 02:36:46PM +0100, Christian König wrote:
> On 11/20/26 06:55, Alistair Popple wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > The SGT (Scatter Gather Table) DMA mapping type represents the existing
> > sg_table/scatterlist based DMA mapping. For now it continues to use a
> > sg_table for map/unmap, but this will allow a future patch series to
> > convert to using a different data structure for importers without having
> > to convert all at once.
> 
> I strongly think we shouldn't have an SGT mapping type in the new DMA-buf mapping API.
> 
> Instead we should have something like either an array or an xarray
> of DMA addresses.

My plan was always to get there, but I don't think it is reasonable to
start there? There are too many places all over the place that are
just hardwired to do SGT right now.

Part of the design of this series was to allow the conversion away
from SGT to be done incrementally without breaking compatibility.

So it is effectively this:

> The framework should then either connect the SGT directly if both
> importer and export are using the "classic" interface 

And this:

> or convert
> from DMA-addr array to SGT and back if either of them are using this
> new interface.

Is something I imagined as a followup series.

As this is actually quite complicated and needs discussion exactly
what it will look like.

Jason
