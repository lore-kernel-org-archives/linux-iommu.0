Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622162;
	b=dwl8XU3QvZp2HByYv8mt7s4ZXW6c+dqEsRBnP3FqoyzukuGJkPwOZ/yeM9QSnwbKHABh
	 jgiA/3E6UKAGfBw0qx5TkA1J5K9QmZeMLU+Evy/AneE4lZrij3INOsI3j7/o1Xdsf0mm9
	 JUg1DDD9k3YESae7YF9xJsEJXZYstZ9xiiD0DCxyRbBLutNGtbLjulzB4VoR7Z14cF2cO
	 Y3zBqcsgYLX1TsfWPJCHCUSLGRvGa4F7wwqo2HfC97NYJdki7Atu6iypWcZOIbZfAFiEk
	 /3Emgi+bTh+FW/u+3tUsnSrWPVkxwPRRjVFx8b+t+om7OAKVhj8rZjbXK6MKdIdJ/0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=EFVYxWaHZcfOFQ3BpTu3S3Fo2WDIpYYjIvIe38jWEXE=;
	b=RI7wIlY9pUSkj+SuhzB4/Bt7lHynotEq8sQESyrKGJXQFd1VblZLRm9cx1WmV/GX/rfy
	 Mky8lTjjYOjSdvS1W/DZeVC+KTExU5fZg6iX1/T2WJWcIMYVWqNoHpTeGp1xNfr9mGoB3
	 Pk0fSsS6U7eVKqC1v3YcaOzb54zCeHX/FT3zpQrspkelGnikmAQAIj7dNYphRZ5Ny3gZS
	 76JSOVUQFK//8P/InkxvEaRHU+k1Qr0wrNeYBmJrj9X9t6pbZWgP6WE2OMJXEGQJeIT82
	 WCICWHsAXdZDQgMR+jM8HYVV7bLwnUFvMZFE5h/lg4kUXXrp88XzNIhq0997z7zy6RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=M39yf3LX;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB72F606A339
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 15:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB72F606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=M39yf3LX
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-537548b811aso49245061cf.3
        for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 07:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795622160; x=1796226960; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EFVYxWaHZcfOFQ3BpTu3S3Fo2WDIpYYjIvIe38jWEXE=;
        b=M39yf3LXB7qlYpAaSNBEZqk1BTQUyqdsY4AE5/vVhmZCySoFF3/YogmN6O2f3RzEn1
         MecSIxgeHgXis4YJ6irRkHHBznVF0W6JjMjikxtkdJr9b0aw/PEWkhGsCsPaeVNVlXie
         TiCI5kjpr1R5DgSOJOgxR/SCxXu5RvyptayVWKMiXPM/lnPXnjKxVpZLPqCMDGnppeLp
         AnvRWP9bgP7lf4Ai7UqIYfiXvbCGYw5Bpf7QiHazxk/+nsDiqgopC3TD/5IjgQ4TfSLZ
         QiknM67DLiCIyuW1b5uxHu9xbji4+3TrQnd0iK8Fgj5uJsRyx1gfttWUMQ2ZIPgTA52s
         nIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795622160; x=1796226960;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EFVYxWaHZcfOFQ3BpTu3S3Fo2WDIpYYjIvIe38jWEXE=;
        b=YEYByNF8DsdmU6/5JyY10tMfFoIThB4s+P63QKw2Z/3kzlT6GJcOwV34ECN3kYHuTU
         X2FZXdqlOubSJZjizXV79x+alaisViykQvJvalEIVwn2/TEklAHTnHm4EtnE4nKoNuqM
         w2EyK4AhBVqiLzbs6b4m/Elvof0rn+mJkEt4N+4MerpUk5kYFtxH6X1HTe+H6f/thXVH
         5F+FmyWiEGhTFFjfAEUu/cMY9nm4HnIaUCHrYbSaqS9LiUfzJ4Z3v4gw1xYZge+zvw5C
         1sLcyZ2+PWiacu/kFh8hCUuR6uT9fPHYn+SuoG5BxGlxPVJBpFYxyz+slMygf0LBsZsj
         iMbQ==
X-Forwarded-Encrypted: i=1; AL+hErHEApEjwi/FfbOKjcD9SJ+qBAbKdQtKkgD+NKD+M52T2moI/jaykyQZL/bQx73oRpF+1twdtQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8MG0uv2OLDj6K6NO6oJm/NSZyb+kPPpmn9fXccmoyx9N+YARNz
	cuvn5EKMRJoCzR8GHlmXOWMSFkbOPBlRouJOXdo8VqRpSQzEoWAxyC0hs682kWtyeQc=
X-Gm-Gg: AZFdTZf2f2GD89d+amQ7kFlinNL3GHNBX0EU/6vvSe87huTBF8xYJ/m22IZRYg+m9xc
	lap5EhNFnMcfoiHr+nyfeYzqZg2ATSiXaXclbplwXIclNKaSZ700d5lC7pFoCRph09BVoR7v9gH
	SNKObtDhpRW/TLQ6e0dgPMLcET+6Vq+KM1usUmt6rkYQApx+8BP5hVcIfcSt461f3JEkeXQlROI
	pDme3HY83oAsiqYfQDo/+rZzDBA8IrQYRkzudYpCScYADB5U1ZaRkQoKRwXDUW1C6x2JyMc60l7
	biGhXAPmM29fvKsJGxSvUIII88sORlbcvKKLA+7c6kciY0cpjhtRQgbg6mtjyn820zJh+NwRiHo
	5Kzi9bhkJfqamQsNqZP6kUGuWwYuB1UweeXHgGKs7MoMH1UjUD2fWf8AqFkGSN50MSweVs5bBbI
	+BkAeGN9lMoegWzhrplblWdTioGMhWcVZvkoQu//jC2xcqkO45wKCcCt9DxA7ckiI8KZxwJBDDz
	znSICu/rSMBUT3pcH0EXaK160GnToMLbJcIW9ppwEdcnd9TFQSO1DAhG2TJHlyT5/biIZiaFBIF
	W+3Zu8pumC9Aneo5Bz5NUea+CYs=
X-Received: by 2002:ac8:5d89:0:b0:536:5696:e8c8 with SMTP id d75a77b69052e-55d769e4561mr347501161cf.28.1795622160509;
        Wed, 25 Nov 2026 07:56:00 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7882bf70sm160274901cf.11.2026.11.25.07.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:55:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWFLj-00000001uyg-0aUM;
	Wed, 25 Nov 2026 11:55:59 -0400
Date: Wed, 25 Nov 2026 11:55:59 -0400
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
Message-ID: <20261125155559.GL246011@ziepe.ca>
References: <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
 <20261123165716.GM179082@ziepe.ca>
 <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
 <awT8prWsj11TBdmP@nvdebian.thelocal>
 <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
 <20261124142032.GN9566@ziepe.ca>
 <7a5a2d3a-e42e-4dc0-8d22-8dd1bd249501@amd.com>
 <20261124194618.GC114530@ziepe.ca>
 <awZ_Os1pXelOGaFP@nvdebian.thelocal>
 <fb9a6b12-c134-4e40-86a5-dbcb59c0b91b@amd.com>
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
In-Reply-To: <fb9a6b12-c134-4e40-86a5-dbcb59c0b91b@amd.com>

On Wed, Nov 25, 2026 at 12:19:08PM +0100, Christian König wrote:
> The low level API which talks for example to the IOMMU driver for
> creating the information how to access the buffer is simply not the
> task at hand for that framework. The stuff we already handle is more
> than complicated enough.

No matter what name you give it we need something in the middle that
can see the phys_addr_t and the iommu_domain..

If you don't want DMABUF to be that thing, then I'm not sure what you
have in mind.

> > If I drop the type/placement negotiation for now and focus on SGT removal I can
> > simplify things a lot. Plan would be something like:
> > 
> > 1) Introduce a new C data type (dma_phys_list?) for exporters to pass physical
> >    location info and context for mapping.
> 
> Something like this maybe?
> 
> struct {
> 	u32	mapping_type;
> 	u32	num_entries;
> 	union {
> 		dma_addr_t	*dma_addr;
> 		u64		*generic_64bit_addr;
> 		...
> 	};
> }
> ....

"phsyical location info" means phys_addr_t and related, not
dma_addr_t. Step #3 has it as the *input* to dma_phys_list_to_sgt().

The flow today has the exporter get a phys_addr_t (ie a struct page),
build a scatterlist and directly invoke the DMA API.

The primary issue here is the exporter *direct* call to the DMA API!

We cannot disconnect this from the DMA API, ie to use an iommu domain
or ualink, if exporting drivers are hardwiring calls into it.

Fundamentally the need is for the driver to get the phys_addr list,
exactly like today, and then pass it to an op which formats that into
the right data structure for the importer. Be it dma_addr[],
iommu_domain, or some ualink_addr[] - or whatever.

This is the main issue here, disconnecting the exporters from being
hardwired to the DMA API.

That's what Alistair is explaining. This sequence:

> > 2) Introduce two new dma_buf_ops - map_dma_phys_list() and unmap_dma_phys_list()
> >    - which are replacements for {un}map_dma_buf that converted exporters use to
> >    return a dma_phys_list instead of returning a sg_table.
> >
> > 3) Move dma_buf_phys_vec_to_sgt() somewhere other than drivers/dma-buf and
> >    rename it dma_phys_list_to_sgt().

> > 4) Update dma_buf_{un}map_sgt() to call the new map_dma_phys_list() ops and
> >    dma_phys_list_to_sgt() to create an sg_table for unconverted importers
> >    importing from a converted exporter.

Effectively converts all the exporters to produce a phys_addr_t, and
then moves the DMA mapping action into one single place in common
code.

With one single place we can figure out how to replace it with a call
that does an iommu_domain:

> > 5) Add dma_buf_iommu_map() taking a IOMMU domain/iova/offset/size to be called
> >    from iommufd for mapping an attachment into an IOMMU domain.

But that relies on iommu_map having access to the dma_phys_list *which
is true physical*

> I think a whole bunch of other drivers would be really happy to use
> that interface as well, yes.

Right, that is clear now, that it is not just iommufd that wants a
dma_buf_iommu_map()

But I don't understand at all how you imagine to implement
dma_buf_iommu_map() if you don't want this in the DMABUF core code.

> That totally sounds like a plan to me.

I'm confused if you agreed to what Alistair said :(

Jason
