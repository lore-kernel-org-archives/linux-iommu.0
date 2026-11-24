Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530037;
	b=XwRW6/QxW92sMLqUamlcnnDiOArDlYQowNdnR7PS7C7ZWvMPQDGXs5F0NP0PA8hy8APh
	 CaVPGQeNbOQjqg+IsLjVUehistVWGwMFqMt7M+AGho+EiReimHuc2j9c6t05Nx3SpmLTB
	 97Z3XUKNtdDS5fThl1qJyOleLETSN59NBh8uVWeMnb7t5ftOltqMqbG9W/tyIuK1r4vF/
	 vQ1B9jH4znj7gWr2gYbbDI3DjJgheq6d3nrT5VV7mN0DOaXWvtXLaUL9j3zp+E7EAHocz
	 NcRwMkzFMcFmfMvUQzK8Bi9rdb2X9syeEwl17FQ9PTPMSD+XvJPF5qaLZVJZRa699LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=Hoa2uDGRiz+jXLxbcD4HBQF2SzMfWsHt0csEQeOTfAo=;
	b=RfAG7akuS2SFAgl2IR5qWVdMa9hvClnpqyoI//3XOIoL8L8Xp0h4Pfz1saHcBwXCla9d
	 Kn4CzXUvXIFOfgCcD3LjuhtSnMHLzVsJwEew1wRux9xaV5rIkVgNuzknECFmfI/5UkwpC
	 vKaJjGZw4iHTRUqF1br4FaJ93AVBnk/8LuTNzvAY9i98AvAWH0cqbFv4DovAJBtV+HnEO
	 /6WEW4fECEugPS2d8nf9NkIT3AsVlENLgYHtk425WLjxm5U0/i7veMH9exaX9scNDyBez
	 gJ9dJIyKIepysWbqaYBaq4f/ROP8fSAHzCGcqbZFte8ref+id+NP/wyVGiUxQ1NheBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=S6SRJ8gs;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89960606A31E
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 14:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89960606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=S6SRJ8gs
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c5127c7abd5so718494066b.3
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 06:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795530035; x=1796134835; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hoa2uDGRiz+jXLxbcD4HBQF2SzMfWsHt0csEQeOTfAo=;
        b=S6SRJ8gsP3P/VN619z2am4YZ5bgvKbAoQ71CzYHVWXFhWYEqpxRc44yOC3vsxFJRF0
         sdOZVqOPWlV0U2GtHU4ouqDUtZAlEdq4H5AekAuS5PrlDEs52Zhk+hFL6U6w5DH7qoIW
         1TuL7BmFDjFwAKUtxLyM8MRsQfzaKfo8FvS2kg/9T5OAPbku9dxtYAMSsf0MCPOZodSb
         HUm0zqEjzP21hpTFaBQpptWBwEoi6ReZFsEt/RmD8M6V8C5x7yqVDW8pZGL9Kmmcz74V
         vxSstAKWVmYqeGyT9VzQ9oLBaHdqCa+SKXpKbyAPTBAilYQlAwHjpJWSu19wlUe0y0ve
         dIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795530035; x=1796134835;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Hoa2uDGRiz+jXLxbcD4HBQF2SzMfWsHt0csEQeOTfAo=;
        b=XW6c9Co/7ws5TY5+vMi8z2blVkfa4Vui8V83H5M/D4qTYIhpSOWjOPpu0hmvzwv4Gj
         mPnvia5aaNp2V43iQTTWL7QKu6/ssOkIIr+aMCSifQfM/ZTV4Cg/MLbswuZJpFI/nEh0
         yKd5gzhSWIbUs3syueejdTUgHSlcaBwJXE2NTJuDXZyEfaRKs9J97J+iP+qGG9hGTijE
         eqjBu5wJY/DsrpoLaq0357MtpCy7z2aXfUFqtWCuWmwmvuxlfVr+RNGl+BtrLISAPMxG
         I/7lpUgzb3h472+tOQ0tmMDpMEo8eykZNiHlnVu2M297beN9w1TpQG52kJXknakvWqzK
         Umwg==
X-Forwarded-Encrypted: i=1; AL+hErHAHmsrl37gIhFnIunmNHFV35fMPe/Sm2lz2HLG5s0nyDe8kIHtSW53VRjQF76YlNhKRLNWjQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8DsNspu9IoOawufkWJBi9oaPwsOHSQms8kIbAvAJLdEsHjGe9Y
	98MIRdKCBcgmsE9slbp67cioyXLYZc22TYMbm3yGO/2kpQRi0YlQgC9FgklKoJCbdsk=
X-Gm-Gg: AZFdTZfagCgql+k4v4VC/z9ZRgVM/8WNipwfVdWfZEbdqW0oZc/iqoQajw9Yn4wkthq
	hC2MMPxuw4d/W5HQNybpQW0O7yDl0p8d86k1UQGxiGU4qIyC2GcjRoEqVkAGFO7QHkg10VoFr9+
	CTE6qdZBvpHxoFdUJ50qMvjGpS9b724Scz8T5JEAckqy8Jnv9MwydTLPdlRBEKVX+g1Ttn7pHYe
	sKnVFeyMcJZarACfdsMXiKJRdOYeeO//0EURSLjhIgyJl2fSQsSpQJi7NK07T+lfw496Lz5FgaX
	DXAtccP99iVw7rXc4qb2sTji/fwn0AWBPBTQvk0z2ZBk4pMUJ6SDLsKcoqDFqso9C9NnfgjVacC
	JBwSKmlXn+1AViynxYpNlxrWzUfSJOeCVKOQD9ElV6shNDuMa68BmNAzYHOaxnNSvLRrttrOdNT
	GTDEHQkJ7r9ZveHpv33/+UFLDpdtweclKCwI6htkAmhItyi7aBC3ebJumAPUqSfeZP3FytgCvBM
	ivlNQsZj8r4Jsz3PSROFfn+JGsEPc/NsmBLLNt2kFk04/QMUe7DuDkt1MXBLF9ZMS/h2rxUsP9x
	uc5IYwDHG+hTJ0VZ/Az91NNE3sg=
X-Received: by 2002:a17:906:eec9:b0:c51:5589:35a1 with SMTP id a640c23a62f3a-c515589d211mr891019366b.5.1795530034479;
        Tue, 24 Nov 2026 06:20:34 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae8dc60sm518286266b.34.2026.11.24.06.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:20:33 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVrNo-00000000RS3-1UVp;
	Tue, 24 Nov 2026 10:20:32 -0400
Date: Tue, 24 Nov 2026 10:20:32 -0400
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
Message-ID: <20261124142032.GN9566@ziepe.ca>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-3-c0183a409bdf@nvidia.com>
 <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
 <20261123165716.GM179082@ziepe.ca>
 <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
 <awT8prWsj11TBdmP@nvdebian.thelocal>
 <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
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
In-Reply-To: <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>

On Tue, Nov 24, 2026 at 01:36:21PM +0100, Christian König wrote:
> > The core then negotiates compatible types and adds converters between them,
> 
> I have strong objections to that plan and would potentially NAK it.
> 
> DMA-buf should *NEVER* accept CPU physical addresses nor provide
> conversion between different address types.
> 
> Keep in mind that DMA-buf is solely a container for DMA addresses,
> nothing else and it should not provide any mapping functionality
> whatsoever.

dmabuf needs to provide support for drivers to help them use the
interface, and going from physical to dma_addr_t is absolutely a
common task every driver must do. I don't care how you call it, but it
is a service that must be provided by *something* and matched to the
needs of dmabuf.

I will definitely NAK any direction to open code dma mapping in every
driver again. If we are going away from SGT then we are fixing all the
DRM mistakes, including the wrong open coded DMA mapping, sketchy use
of SGT, and abuse of P2P that seems to be endemic in drm.

Meaing the exporter constructs a phys_addr list, gets a P2P provider,
and some common code constructs what is passed to the importer. I
don't care if this is in "dmabuf" or some "dmabuf library" or
*whatever* but it must exist as common shared code.

dma_buf_phys_vec_to_sgt() is the template how to implement this
transformation.

> > and having SGT as a type is what allows that. It only exists for unconverted
> > exporters and importers and eventually goes away once everything is converted.
> > The idea being we don't have to convert everything all at once, whilst also being
> > able to add support for different interconnect types. Are you ok with the SGT
> > type if it is just transitional?
> 
> Not really, it just complicate things.
> 
> What we should do with the mapping interface is to add the
> information in which domain the DMA addresses are to be used.

You need to negotiate the actual C data types too, especially if you
want to do that nasty idea where dmabuf populates an iommu domain.

Jason
