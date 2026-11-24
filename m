Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528842;
	b=uZrXFPyJkWGi2s1tOLOiL9Rxqf9grI4r1Gd6H6pHOcNLNXKNHwW3n8pjHSLUI9FIFxOM
	 gVL1qSxxZP60FGUlq35dTSNYNx2N6TN0CF+RpULMWIi61l/8hgfColFjC7y4y8GXnhunK
	 0n9Z3gQIRWtSZUyBAkYuSHtheN6u5GRRv7cq9hHm1GJUvS24hTMZFmGDLS0MJ3caQFbwl
	 6HEnL9nIY7QfdEFYg1TBoYzEJ/qC4/+PAmtw9UlPNAITUmos7nMbAqOUIj6Val7uNhPjA
	 KQ2QoENck5zsWruRi11LApTI/m7M4OJkjyD2mGgynz5tXuye0qlUHXCL78MDpy0ZJhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=o+7iSwGfMjtzT2Y6Ygii4nLjUX3g93NcfuA7HOwwEkw=;
	b=CZW0rU49ux530zb8uLcjULcjLF61GvWdEMR0qAqpeW0KXnsNeOoX7L+WVlt+nBwmLL+J
	 kbOxzJPkathiBA5mpiQQcUKfmUcHXiAC9WFKyjSZRSWjvqvbs4NvrR8g5Sj4hmwXwAeOs
	 4Kv0F7cW7MeUrxzjOycAmv7J50OjGeEoCAP8wdcEdsVLZyklK7levmJp8l45bCB6QF+2t
	 KHMg8Q5pwBNiFcwv1oHUkn28KbfNuvS14DL/orqFLj2EXMVD+rNkpew+BvEZ0gG6nfOD/
	 OaI1nrEsKnyVWLEhngp0L0+b6GUOFfcXOhMLWW8v9mbpYBLOzCimHTq6Jm+6AZmrnHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="WNW4fu/s";
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEB1606A327
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 14:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBEB1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=WNW4fu/s
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c50933bdf4bso902231766b.1
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 06:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795528840; x=1796133640; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o+7iSwGfMjtzT2Y6Ygii4nLjUX3g93NcfuA7HOwwEkw=;
        b=WNW4fu/sDDpC7TvCyO1JTr5/WRBoT1SyHA8XdBsssc5eTEBq6mje6bA/dpwl8QYCg+
         HXLBaFSsUSSlfZbYv6iSbHUj330uRveSzOwPcxMvHnxGrbQp9XcR3liTZWK1UP1N2uSv
         4hiHHjc5oQsenQedKx+iG7+S/XMUsz8C4krA01JmhDElRaogXTq9wd+f9dcGg9wAns3A
         1OPhRl1z+YHBR1NR5rg2AoIszn/3Uy4eQeMD2LD6UeQZzhY6SDpGuoUqgpt8fl2R3TKU
         nrbeV4BAxZ81VJtvPYl+aGSkGqHY3oJLlcZFJofp3EA+dGgt4MFBmO9kSnVz8sSNlYkx
         2L2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795528840; x=1796133640;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o+7iSwGfMjtzT2Y6Ygii4nLjUX3g93NcfuA7HOwwEkw=;
        b=sShOwnMm8aidOLLNGEDHtb37QqyAri3YGd0hqengSyT7sJV56mywkACRi7zMCXLONz
         Y4puVw1Qlc6oqa0TkqQiI1SGxe/hZCRICl54bxayDlPyWJWeSIl3vt65g7HbmGvis1gB
         LdiHisVBEVwThgjpFGhOd/Bc2m6O39VfD26A1iLXXd3MIFK6PrudNKFWHZ9WdwkmaAyp
         qODBqwFlnZklkHYKkvZQ3ROQp+ij/wB8+vz+W0Ts6PjHkSYjZ136ZFmhdEcWyd/h3FNz
         X7in2AjTmYPsA9aoKhz4LSYc1gYw3/CrxaohDwBE6VmGKg7iY5KSsgjyqulLnUHWaqhW
         jUMQ==
X-Forwarded-Encrypted: i=1; AL+hErFl8OCvkYM4JVeAyyHYH/66SDJnnEgYZmGNkJ04wiN3NL/kL+FtRm4WiI72yFxUo601dZURVQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+AwBgGbIbcyKOzzK4ahvVVMBlFjh29+O6FZBAYSry7J95CsL1X
	Dfdy+/S54nmDsa2O4ydLSrp/mrF47hlPkaomMwFcHvokWV4FEuzKxz+YIiogh0Syni0=
X-Gm-Gg: AZFdTZesZSUPI1HDgA7lX/uPuyh36eBfuMV+TmO1e9Xmi1wZK1Cp5xL7CtyPSYYN6mh
	gueTJ6K8RR0SucbETuBo/Ib+xKx58JWveC3wHC0RrgDWys/dTBE1yuxoDKQ5nDmesqK9QlfvK8E
	+svKA/0pLA/05yKsxYilbR+aYJmbkezG08XcNYz9Dhko7XOx8WSlzJxZ1nqfQsLYzy20e3HZJvi
	mB5eUBXM/DMGgz92+T4fTYtsxvUkE2gKaGTlntKu5V47R27s/mUP3ke2C018SvC2pigyWPVtJkm
	rbDxEXuwTTFRf0Zqr8Nr26IR9PuGFmBtWQwsJIw4g9CVlJuKPAiRpbgqY+i37ngAjDLjwryGgjx
	zMRK3smdrqzrNQxdqJCACuOgvix9Q98wxLphdeKoHWy+gY+1BQo3rLU7bGC2M4t/0SFRiIop2HQ
	yLMpgnID2F0AJXCbUZgELJr/ELatMMz5cgYO+HtN27kbkl1uqmaX8cmw6DVWVt3CR3xBQPwL3WS
	xqYqtp8BrYE9QfPSOoR5xx3CPE5Pvr+dQXCCkmX7RacAyN1HhTZuDhNceWHH5/VxrshxRveAlo8
	SqM9iQ==
X-Received: by 2002:a17:907:3e86:b0:c36:777f:824c with SMTP id a640c23a62f3a-c51315851d7mr1405271066b.4.1795528839874;
        Tue, 24 Nov 2026 06:00:39 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370cc257sm6492195a12.13.2026.11.24.06.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:00:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVr4W-00000000QnE-3MAi;
	Tue, 24 Nov 2026 10:00:36 -0400
Date: Tue, 24 Nov 2026 10:00:36 -0400
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
Message-ID: <20261124140036.GM9566@ziepe.ca>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-3-c0183a409bdf@nvidia.com>
 <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
 <20261123165716.GM179082@ziepe.ca>
 <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
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
In-Reply-To: <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>

On Mon, Nov 23, 2026 at 07:37:41PM +0100, Christian König wrote:
> > Part of the design of this series was to allow the conversion away
> > from SGT to be done incrementally without breaking compatibility.
> 
> Do you know the joke from the hitchhikers guide to the galaxy where
> the dolphins are happy for exactly the same reasons?
> 
> I'm pushing against this plan for exactly the same reason because I
> think it will make the conversation away from SGT even more
> problematic than it already is.

I think it is well proven that trying to do big bang conversions in
software doesn't work well. :(
 
> > So it is effectively this:
> > 
> >> The framework should then either connect the SGT directly if both
> >> importer and export are using the "classic" interface 
> 
> Yeah but that should not be a separate mapping type, it's rather
> that we just convert back and forth from DMA addresses to SGT for
> compatibility reasons.

The mapping type is to support ualink/etc that don't do "DMA".

Only DMA API can create dma_addr_t's, you can't reuse those types for
something else.

And you still need a scheme to negotiate exactly what kind of
connection you need. Focusing on the SGT is missing the big picture of
why this was organized like this.

> > As this is actually quite complicated and needs discussion exactly
> > what it will look like.
> 
> Actually that is the easy step I think because quite a lot of
> drivers already convert the SGT to a DMA addr array outside of the
> DMA-buf framework anyway.

Given the importer an array is not so bad. Getting the sgt out of the
importer will be a debate.

Jason
