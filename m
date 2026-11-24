Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795549581;
	b=emTdVrrKgAIFGcwXh0cjDHHip1ltzTZFniCyDFfN69lHJL+3iovyDzP6UvtK9rwRD7db
	 jMOq5vcRUcoAApVFqcJ7VrieBaS5nrW5PYjqYjOQorRyCo98T4GcWpaUas1zvr4V3d5az
	 00jktoHs4br7N3k4YRoint4/i5h6YzF38cSbL5BWFFN8c1oXdsn18X2GeAdzU2VrCdcrA
	 /exKj8GbJLYxFDL3Hr5JofvhU9n7ZANhBImBbv1ar9xTgDMOUhls96Wp7kBICvmY9JZEs
	 sw0BdUcA5J3vf4RqELRKvgdktZzc9a4XiQJnze/xk8kUJCvzku8awzBQsZrWou3zdkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795549581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=cCMOaZdag+2OcXEDMl2EbRqTcxfKhXeKWu4Qydoaad0=;
	b=KudYUoQ26Mculq8U9EEPX9sWPJCq4I1bOd4+x/12Hng0GpzzLMN8ooP49nRUXOisWoJI
	 oQwyaWc3mlcFqqgazQb+FhHFYkGpHoVY3ZJCf5OjcpbSqHAwwyg4s9PXD6V8GNDTmQntC
	 BdbrbLcKUwvM58JxnDi8QXw+REFgaMNrqmzu6aQ04pT1pmv01hldZ/rs2trMw6aeaSWaQ
	 OGLtvygjS/286jj6WmiZU4MVgx4BflT7hdf9mYIkjMPdm9qq8DygnGU62teseAQIeMA7X
	 fD1vMv4RhpFDKCQDTRlMEbMRtk5ArveCDThFHILwIzK3I6Hso75A2MWXkpKilD8tBCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=JYLEn4Aj;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03453606A323
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 19:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03453606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=JYLEn4Aj
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-55b8cd4e2abso52806991cf.1
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 11:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795549580; x=1796154380; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cCMOaZdag+2OcXEDMl2EbRqTcxfKhXeKWu4Qydoaad0=;
        b=JYLEn4Aj5Obz2CRvRa0/Yh1BYHHi6f299sEPrLpFsYsSwguLZC66AUxBcNm26Onwoy
         RGxurpCfq5w6ilPaPKkfYaHC+qFzfM2684VO1a4x701P7o4j0V2dLUljLnCoKEQXyXTZ
         xNIdOw5lG14JUtLVaCFch1UJOTw6kVzrty+vbgBCg0QlG/sGUCXxCCdyKUpXH7T23PTw
         jrniD+dcRL7f79lKVE1dwlkt4Qx0De+0W0KVc8Hs+oC2dYn6+0ENf4g/WTAfA/o2fAFI
         JxyxMPPJ/CuD17pUWuK2MmpQIReLNJHDao7wHkt+PU5EZDLI86SyZh7HYwVIOozvDpJl
         5Mgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795549580; x=1796154380;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cCMOaZdag+2OcXEDMl2EbRqTcxfKhXeKWu4Qydoaad0=;
        b=odlzmc/7KtZtNoOjBZZe9ShsQluSeW5LXLiy1aQZGfIrmJF13cbF+iRnVjq+AJ4duM
         HyzF+q6TMgYBbcC7//9/65uFjJ299MV+PvFiD+nF+Q+nRCAcCw7f4MXiq7YjbM1Qlf0u
         mofRLJoI4+cyXhW2HN9ftGbsk3ZDNsJo2dl2xB7pVUsUeIhCAp0m6f5z9yJz1imcbTfI
         Bxe3oJsvPQOt4CV+68ScmSYGlsAnaK4NiDl0KR0F6wtWILHt/A5c664d1e2MI4+8JO7M
         du8UvcOHgPkvVXNQE4o7Y8L/hqtMjli+Su9jailiOoYHU9EbrzJ5J71HJn5zihWMY4bx
         pgPA==
X-Forwarded-Encrypted: i=1; AL+hErFKYXMOi/Cg5DuZMRk+L0G0CL0ZrPtaIXnBBKPRPMoLiqLbKSLRx8UGiNzRWCshWHntfXbIrw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/ifk6kdkX6QjxClRYDFymUvBdzcsIkBhQ7w3EDNccDDmxI2apM
	pYb6us4cyMCviuZ7TyHND1bt25BSAOLlkTrKosxLemrn8xki6qCgOZQ2HLd7dDGXiz4p2b41x2x
	4xUNX
X-Gm-Gg: AZFdTZe+eLnVhpEs9bqPCSfYlqtiM3SA901lyA8SHQuXQfuF/7jYIccmOqJFfCcpbrw
	UJKJebECxMoRMNqzrvoZSfEoa3xdwoenq+j/5mhfhFrPBRTsc/Y/Z+p+i2A4GziLXHyAwfZBZ9P
	FlXzx5Oa4u2O6wEK0t9ngAMa7vZ+jjSHqtjP2yadPMOEEZgqT+m0DtX5sarDpeMLLcCUjoZ2Ag/
	XEo9kntDc143qRCiTRfQdd+3aePIM+wJ3As3pVan7qXiGWHmgZMto9u5AsljXn9NezOWh6l7Ha8
	6Q2GqsMtzETja0JqtKjFjYwf196bcYqjnB4F+0s3GBinYSGZrE6R+Oaf7tDN3CXS0knsJFgHVXJ
	lz4VbOiHpFS/ZHeRxXEFzWSyfQhofRpf4LRZue/zXG0Eo7an/uprlkMBwz9NqlFDgQvzTh3GEz1
	MFCNWOHSLhGGSfSNTqf25t+onHeOKuqtbRk/sXZeQBCACwzhy31Ubb9nRi4IHGZuh5j/XjvsIl6
	RrPszbAMyLlKljJ0R/sviU4op+YruY2y1f+n8SrjC8xoGmreSRwq34c9F+9dGGepnWHq0sU1KpH
	Ia1FjQ==
X-Received: by 2002:ac8:5c8a:0:b0:55c:66f0:5bfe with SMTP id d75a77b69052e-55d76a6f55fmr288174681cf.22.1795549579924;
        Tue, 24 Nov 2026 11:46:19 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7882ea2dsm135596661cf.15.2026.11.24.11.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 11:46:19 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVwT4-0000000113s-3B2s;
	Tue, 24 Nov 2026 15:46:18 -0400
Date: Tue, 24 Nov 2026 15:46:18 -0400
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
Message-ID: <20261124194618.GC114530@ziepe.ca>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-3-c0183a409bdf@nvidia.com>
 <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
 <20261123165716.GM179082@ziepe.ca>
 <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
 <awT8prWsj11TBdmP@nvdebian.thelocal>
 <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
 <20261124142032.GN9566@ziepe.ca>
 <7a5a2d3a-e42e-4dc0-8d22-8dd1bd249501@amd.com>
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
In-Reply-To: <7a5a2d3a-e42e-4dc0-8d22-8dd1bd249501@amd.com>

On Tue, Nov 24, 2026 at 05:02:31PM +0100, Christian König wrote:
> The whole conversion from phys_vec to DMA addresses is something
> some API should provide based on the data the exporter/importer have
> negotiated (e.g. p2pdma_provider for example).

Yeah, probably, and this is exactly why I think it will take some
time. Building a new something in lib/ like this is not a
straightforward task.

But also, this:

> > You need to negotiate the actual C data types too, especially if you
> > want to do that nasty idea where dmabuf populates an iommu domain.
> 
> Yeah agree as well, but to be honest that task is negligible. We
> first need to figure out where to put the code.

Means you need to get the phys_addr_t into the dma-buf code so it can
do this conversion.

I'm still absolutely NAKity against allowing any DRM driver visibility
to an importer's iommu_domain if we do this hack.

I don't see how to meet all these concerns without making dma-buf into
a "converter" framework...

Regards,
Jason
