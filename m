Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633628;
	b=xPyDNmwPTYdKYSEcL4lw2QFaeNtZ9Iqx+CzBJP5N6ZFJDvrMZ98R5Uwk/km9VOvM8XxN
	 bR79xZm/6MN2QnIaWuvf9NYXEUmijfvM99k55sOfCM90Gj0+eyMJ8h09GON9yoLL8pg2y
	 2bUaYpdP62PtPzCcezk26Ld9uUmOgy8hFc1b2anlHxM8TGIPYFGDqT0SfCY4DD8ZkuSc9
	 U9pKMi//kJzFnZOteh7p5XPH7YI64FxJAgSJ9rwmU0be4JlprtSGMrSw6u5wr+wMXMYc2
	 6lU6QDXFH4BOX6FOKh2MEtnk/ryLHyJwKdtwKJE2DjdWLxOAJ0opkaBBRGaSyKdJ5Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633628;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=JisVSgs385NGuntA6erRX4QYHX+VR40SrOV715tgnK0=;
	b=uqnYHQYWwUaKPIdfP5fl0AOB8RuGwp7w7hpMKfUG4523DdgnR4CbwOlGVSMXggWRyQQR
	 oJRlpfceSnnQouMBZRGUquJlUbp+R//jkjl1wtoSAiIH3+6x890ebvi8oB4S/g/AwJjZ5
	 ULp5mhAU50p22Av6DFoh6rnBGVkkWQF1CuSqVJ49bDXoUl3sBZQCuOpOd/MKzfGWR/+z+
	 ESrBuLebwklDgfZMoAXRZu1Up1MN/oVUSTBjqQiVo/yd+6sDqeSCAulw6fXEZVIeUNjOQ
	 2M/95ORJbFjg9PM9a+0ZCsFKD7R2Pw4120iPY/GKU4XjbFTj4z+MmDF95elw+uisdMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=hiNSbW4I;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C2C606A31E
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 19:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41C2C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=hiNSbW4I
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9495c633eb5so343497985a.1
        for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 11:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795633627; x=1796238427; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JisVSgs385NGuntA6erRX4QYHX+VR40SrOV715tgnK0=;
        b=hiNSbW4I/wZ9hLBThfJieREeVkTXchrzJ4MoYlw+j+J8itc8u1+FKqJtdjZZIrkQfX
         xHInGnPDKR6iYe/3lclG28+t77iCvrltI7/OukXojL1tujp1+xpwJUNZPM6AA30hyykI
         acLwR0Eho+HJCX6xEDL3hhYmuEmWbWQAhWIYTy/W3UbghoEKgMpPKmaxaGs9S8bOTFSZ
         Z/1GKKzLdv0h+fV5dLW/P/h9G6vLV9bf+xZE7IlIqJLO7jJcx0hdxf1WzunOyrgF2juv
         C9RXt4Clq2J0i4BGWhe1iq0YaEjkI+qWRMbJiUAHU2+w5mKcA5lrZ3zbalUUPo8x53pO
         cVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795633627; x=1796238427;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JisVSgs385NGuntA6erRX4QYHX+VR40SrOV715tgnK0=;
        b=uv1BuaTNrPkYS60SMWk/8LtRK3GYD+6r9FaFZ1hTP6kAhux+Zm9ZsmcanbuacDVDst
         RTT/LSBBHN2efH7Yh7dbSB8hooN2Wy9UX/h1dn2K5RtlZaJyMBB+UiMf0DKev+GHEI4m
         w8OSrCKWQ0gj5q3KeB8mEX5V3q2/Af2lncpOFw/x8gYWU1bKhGnGfcQXQIIy7FnP3sXg
         2EzIRqIlOXTJ8BgaNwJIVZ5EgjqiPyS3Lp0nGcIkvJOuRsyFL/bBGeXNwxdtxfpjqHMU
         ohQjKMVkb8R/z3ko37a4Kt06w71lKZitH245hhj54skZ03y+1a587u8heMkm6vNCWhH2
         LwkA==
X-Forwarded-Encrypted: i=1; AL+hErG9J9S5kHs5e03nrTd8bC4VeVTnqRh+hJIsBdt+gmgOmf4jh8q/qUpOBkOwEvOVXMjXh9pZdw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9g6jBe8mG+SOPDqC4KIE75bpxRyvavIxEfDmGli5r5+Sp/SicV
	Kd2yT8YLPlYyAs0nDQFGH0T1RBhW2hjliSUMr5KMUaTv4//ImCMfyaofyY4xUZ5kHZM=
X-Gm-Gg: AZFdTZcI4b4clBUsh2n79Dc6VjilbJkJhK9RRioXFcSvWQ82MMcD5sZJ6F+bce/SJgl
	ZMhKeBm995p1yFzyvd+kdEIQWF1fRqba81urJo8KHvz9t3syj0jlSfZkjnzo4XBvM5/+gRgG7GU
	1lRNbJILqo1HN7Q0JVMYvTW/zauZD7PVmwkU2gXM8CbEkEETvO32R7xdjx2JbdMKP4GjdpvTeok
	+7Gwu+Gi11GyzqukJjd9A2AenCetBH161Ioyw/JzjST+UD69QbjL1BcBBfl7NFeuJii/yZ/EA2w
	dlaZLn9ivTWvXGX+SiExA303dgEiOAbOsJwQkoBzMDMKMfanT9leGEpSmiOnNOmt1F43nQsMffz
	Kz7mefybK2BS7eCP3n2hbtsnb1uZOoulxh7dqsv5M5vmFxlPMs+j3TEeTFx+27ZSf5WpU3f00mT
	N9luclEmWtnOzKZYkPGlw9W2WqIDgJHVq15X4318ySJkkODDX8FH35COml5pnmmDhhjlHFyHnLd
	Lsbia8mj3Ns1O8H07fPZm/OxxLoLcAZVZQoPd94vK0kTdMdORcrTJqi5RCfsmhjCHL69n7eZFqW
	sk5rveM=
X-Received: by 2002:a05:620a:4543:b0:949:65fe:b727 with SMTP id af79cd13be357-949ba9b99a7mr3433826285a.26.1795633626929;
        Wed, 25 Nov 2026 11:07:06 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94a017cfb46sm339501085a.28.2026.11.25.11.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 11:07:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWIKf-00000002HLZ-3ZQi;
	Wed, 25 Nov 2026 15:07:05 -0400
Date: Wed, 25 Nov 2026 15:07:05 -0400
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
Message-ID: <20261125190705.GN246011@ziepe.ca>
References: <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
 <awT8prWsj11TBdmP@nvdebian.thelocal>
 <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
 <20261124142032.GN9566@ziepe.ca>
 <7a5a2d3a-e42e-4dc0-8d22-8dd1bd249501@amd.com>
 <20261124194618.GC114530@ziepe.ca>
 <awZ_Os1pXelOGaFP@nvdebian.thelocal>
 <fb9a6b12-c134-4e40-86a5-dbcb59c0b91b@amd.com>
 <20261125155559.GL246011@ziepe.ca>
 <5fb8bb60-7d9f-49b1-899c-40a890fdc14b@amd.com>
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
In-Reply-To: <5fb8bb60-7d9f-49b1-899c-40a890fdc14b@amd.com>

On Wed, Nov 25, 2026 at 07:17:51PM +0100, Christian König wrote:
> On 11/25/26 16:55, Jason Gunthorpe wrote:
> > On Wed, Nov 25, 2026 at 12:19:08PM +0100, Christian König wrote:
> >> The low level API which talks for example to the IOMMU driver for
> >> creating the information how to access the buffer is simply not the
> >> task at hand for that framework. The stuff we already handle is more
> >> than complicated enough.
> > 
> > No matter what name you give it we need something in the middle that
> > can see the phys_addr_t and the iommu_domain..
> 
> No, absolutely not. That should be given to the exporter so that the
> exporter can call the DMA API to create the DMA addresses for the
> importer.

I think I've said it many times, and I thought you agreed: NAK to
giving GPU exporter drivers an iommu domain.

> The idea here is that the importer give all the information to the
> exporter so that the exporter can do the mapping on behalves of the
> importer.

No GPU driver must touch these internal details, they must only use
standard abstracted APIs that prevent them from abusing things.

My fear of DRM drivers abusing the DMA process is equal and possibly
greater than your fear of phys_addr_t :P

We are not giving DRM a nightmare API to continue to shoot us in the
foot with.

> > The primary issue here is the exporter *direct* call to the DMA API!
> 
> Why?

Because we need things to be mapped in ways the DMA API will never
support.

DMA API will never support something like dma_buf_iommu_map(). I have
no idea at all how you expect to build this if exporters are directly
calling DMA API. It is not possible.

> > We cannot disconnect this from the DMA API, ie to use an iommu domain
> > or ualink, if exporting drivers are hardwiring calls into it.
> 
> Well the plan is to not disconnect it at all. The exporting drivers
> just says to the underlying API here is my buffer please map that
> for this importer and that result is then given back to the importer
> through the DMA API again.

DMA API will only do basic PCI DMA mappings into dma_addr_t.

It will never handle iommu_domain, it will never handle ualink/etc.

Give us a plan for those if you don't like any of these ideas.

> > Fundamentally the need is for the driver to get the phys_addr list,
> > exactly like today, and then pass it to an op which formats that into
> > the right data structure for the importer. Be it dma_addr[],
> > iommu_domain, or some ualink_addr[] - or whatever.
> 
> No, the phys_addr type should only ever been seen by the DMA API and
> not by DMA-buf.

Again, I don't care how you label things or what "library" they live
in, I can't tell if we are nitpicking names or what.

But there needs to be some kind of abstraction that takes in
phys_addr_t and makes sgt, dma_addr_t, or iommu_domain depending on
what the importer needs.

Exporters must not open code that.

Obviously DMABUF is involved here *somehow* since it is the only thing
that knows an importer even exists.

Would you be happy if we made a 'dma mapping for dmabuf' library that
did all of this and DMABUF just passes its type opaquely and drivers
just call its tightly abstracted functions?

That is the component Alistair is proposing, he just prefixed it with
dmabuf_* as the namespace because, lets be honest, only dmabuf needs
this weird looking thing.

Jason
