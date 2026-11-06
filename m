Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988438;
	b=s7hMH1GOndM4I6YUxDDxrNloG3+BwstYGa8LCpuJWGlBkBDBY0ZI8eH7V1yDSkujfnXS
	 S0AcnousYIyzhFBvVLH46pS/Sn+JT0ChzOo5ZGBBbYp7zuM3ptMTXmyULHO2rnSIUH1wx
	 Cjt21OEvQ4vfF3QusbqNj6B7CC3+lDRp5y5Bip6/i7Axp14ZouuBBkLILamIVxEtmGUYe
	 omcDNctX76MiGiYEjOpH40VL5UpFegf072xNoj7F69ddXqbhM5Npde36bgIuCPl1NHp7p
	 hPb59/ZsShRnmnHI1bbZo/7g1YcFP351rK34VWkwE+o3TPbRqWoVynKwlzrJAZa35ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988438;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=xsa9e6MH9/SVm3In7oNjUcANbgdM5Ae2hGRi/O5LwW0=;
	b=flqSYeKSsUo6AEkSWeV0KL81YuhZn/avvjPOk8mOEkOZpIrzsajmr9iIH6E9EtPOp78S
	 TlCdUX/GC8JgXJy+p6gFS4WfZqUpvEYaprSHBXRHBRn6O/T461Ejb7dGw1d+nz3f6l3jn
	 bT1Viwcf3lnyt83GjC1HD6VhS44YLaI8gj/SQs0TUC4R5wLv/Q7upqf0NCRkfQqRh26D2
	 Lqhtx4jlhba6otRvm3Og7Fa4p501GIMMVHbpNCuaUYkak41FbylUbn0yvqONwkqPqTsq4
	 zvUnyAWkA97Fd7q7v7kPg7hb/S4+Yjy9r3zVV2FMPL5OJrMNaLfSq1eYMnezs0DeG9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=lr3KHa3o;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A175A606A32E
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 18:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A175A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=lr3KHa3o
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-537548b811aso6339771cf.3
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 10:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793988436; x=1794593236; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xsa9e6MH9/SVm3In7oNjUcANbgdM5Ae2hGRi/O5LwW0=;
        b=lr3KHa3opeOtbrZAvrtcBXeWbERmh/pJrLKq3d4uBRp9D+CeXa7iI4WTOX1G64hoLP
         pSXsPi1T2aa+d86E3HtRtIsFBucQSnYCEGkKs3CNRc0ELaJoXNQqtLnJtNYC5CM5chzT
         lyw4ht/Iyl42yDpFQVWxLBwSBumJh+eXyNxC3lg/pjNQUvE16F92t9VPie+UMqlwUmWC
         LYitW7XlyjB0+KFEyTwsTGglm52BOrf31FIjY/UQy7WExFYenJzxvyxhXYD7Hi/DWKjO
         KEhQJ73kguBEpztt9WfgFPUYv4Z/AsPEMTlXFtvTWNGf1cHewnn+Vqd0u5tubtSIPvPH
         7yPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988436; x=1794593236;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xsa9e6MH9/SVm3In7oNjUcANbgdM5Ae2hGRi/O5LwW0=;
        b=iPc+avQjbnElKd3eBjTmTLgGLJSlEvS/wpPLPNPJ4rjPfEnPsqFR6WDtiINokir+zA
         TB8O07+zCgrQ3y0XsK3u1Ma3+6VqZOIonxMJWB4a0ivepSaildp3hK0GJFxR9tJ9hTIc
         atw7yxEgQemPMFBIaQkuu3adO61ap2f+lPC3tYqzCMpFic5T0zeMRqsGBWG/GZeAcMfa
         zeHTBR7nnXaJdPRnw92JEUosUuDc9wMdwD0hRogYROpEjf0b/uQYPCS3oZ1RU1a2m3GA
         VoQz/ARvpMDadP9qXoauLoPQPtlxoJCbKcCMKSlf5DOgZRvsDBBRCs/A1ozWyi0nIIQ9
         ZUag==
X-Forwarded-Encrypted: i=1; AKwUvByknmMrZq3QGzPyZmXigpIhxLLKeDlZJOZQi+oo+ot2K1TAx7j3vs2M4gh/Hf7y+i4oB5fqUQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8uCo4wBK1AImRlE7TRu9xV7dYPVpv/gJwzSF5dVWjcf/GhCO55
	qkSWqvSk7Wl+BGujAPOeoAcgkmqBAdCDFithGDz66UtKXWtkgEws2n8Q46GWc/ohBW0=
X-Gm-Gg: AYBFou1LgZjBCnALoO8aBXSd1kj4jjH4UOAgL96UWH0edo05PxTNyS2Xop8iBS5FVES
	4k5zXwhi+86Vy9qpfoD82LNRfJBmCzq4vhaqxZPYQNeKlB3YZJ02pvLL16Jdfi0/DXQERon2xlX
	CKlRR7ORqsYSKdA7CJIDnAYDS/nYLKYbkCJtD3EfLAPHHkGzMEz8A9JSAqvuBNDH813JAMICf3z
	F+90L7qnB3OKlrF5TeBjVgRTynmGNokwlXKrkBoPBpncOoLXdsq3TlZJ1SdKDiYSxt8fe9mb1vw
	FC183SMfCl7FltDjK5dR4vG3a/RiB1EuOioMjVcr3JVIUOTo1nQc2HEKHVIyhbUyr9INLQFqLc8
	ufCY1GffZXwA4sHEDZZC1eGwbMM71uG3B6DxKKSyK35NEDd/lhbkKFQsbmcZQ1wn1wNYX7j4ze+
	Me5bKybuKmQ+Z6IqFjhHGawjiJInoucPAFE324AE05J5Il39Vv/qA2zOvhNcH6NYPgZtLG8rTDD
	kXAw4wkvKh+Vdp3FsDvGC7C1dIwXNgyUQRT6gqWnx7/XggEaBDPevvQBsJ+PN8rgPcuxcREMf9W
	y1ZAB99Mbvi4ztRYfxiouGKFiMCVsYwZrN2kflXYcWMJ6HxR2sc6z9XWteCd5A9SPJsmMCjytX5
	ydVBuGB25TQ==
X-Received: by 2002:a05:622a:480c:b0:535:a5fa:edff with SMTP id d75a77b69052e-54e15b63c63mr47814391cf.63.1793988436090;
        Fri, 06 Nov 2026 10:07:16 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e231d0710sm26555871cf.2.2026.11.06.10.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:07:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xPOLK-00000007CW0-3s9S;
	Fri, 06 Nov 2026 14:07:14 -0400
Date: Fri, 6 Nov 2026 14:07:14 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Naman Gulati <namangulati@google.com>
Cc: Christoph Hellwig <hch@lst.de>, Luigi Rizzo <lrizzo@google.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev,
	netdev@vger.kernel.org, linux-mm@kvack.org,
	driver-core@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
Message-ID: <20261106180714.GI663069@ziepe.ca>
References: <20261022201229.GH3381610@ziepe.ca>
 <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>
 <20261023140107.GC3977851@ziepe.ca>
 <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
 <20261023145023.GH3977851@ziepe.ca>
 <20261103080933.GA4213@lst.de>
 <20261103151021.GK3889730@ziepe.ca>
 <CAMP57yWvHO0pWCR3-9q1gtwVe8WV4Y6i69trmw+BJRVYf3JB1g@mail.gmail.com>
 <20261106173054.GH663069@ziepe.ca>
 <CAMP57yU-VhZWXijvwAXcN9=zZ+eWXZ6J1bkHuCJw3ocRaFaV=Q@mail.gmail.com>
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
In-Reply-To: <CAMP57yU-VhZWXijvwAXcN9=zZ+eWXZ6J1bkHuCJw3ocRaFaV=Q@mail.gmail.com>

On Fri, Nov 06, 2026 at 10:00:35AM -0800, Naman Gulati wrote:
> On Fri, Nov 6, 2026 at 9:31 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Fri, Nov 06, 2026 at 09:21:08AM -0800, Naman Gulati wrote:
> > > I drafted an implementation [1] for premapped TX and RX buffers on top
> > > of the existing networking page_pool. It is implemented entirely in
> > > the networking layer and extends page_pool as the default RX
> > > allocator, to the TX path. There are no hooks in the IOMMU, DMA or
> > > page allocator code. I wanted to understand if this implementation
> > > correctly captured the feedback on this thread. Key components of this
> > > design:
> > >
> > > - Chunks: as in Luigi's series, memory comes in 2 MiB chunks, but each
> > > chunk is mapped once per opted-in device through the DMA API and
> > > records its IOVA for each device, rather than using a shared IOVA
> > > window.
> > >
> > > - TX: page_pool accepts a memory provider for pools that are not bound
> > > to an RX queue. Per-CPU page_pools take 32 KiB pages from the chunks
> > > of their NUMA node; TCP copies sendmsg() data into them through the
> > > task page_frag and allocates its skb heads from them.
> > >
> > > - RX: an instance of the same memory provider, sharing the chunk code,
> > > backs RX queue page_pools. RX chunks of order-0 pages belong to one
> > > device and NUMA node, and are shared by that device's queues on the
> > > node.
> > >
> > > [1] https://github.com/torvalds/linux/compare/master...NamanGulati:linux:netdev_dma_pool
> >
> > IMHO the netstack should never read from shared/decrypted memory. If
> > you put it in a SKB you have to be sure the only touch after that
> > point will be a DMA read from an untrusted device on the TX side
> > (sending it to a trusted device would be a fail) and the final copy to
> > userspace on the RX side.
> 
> That's likely a fair callout. TBH I'm not very familiar with CoCo and
> will spend some time understanding the constraints. I kept CoCo out of
> my implementation as I approached this solution from the overcommitted
> VM problem where we are trying to overcommit memory in VMs and use
> these pre-mapped pages to avoid using bounce buffers.

Why does overcomitted VM use bounce buffers? Do you mean this is
about getting better memory clustering in page pool since the VM
paging granule is 2M?

Jason
