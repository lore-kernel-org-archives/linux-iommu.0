Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990629;
	b=sOwZuI0L//R6bij0gnkbDxhOInfPoeCQC/G+RhhLTm1l3lOVmXIuGUIr7/K0oSqWbX9+
	 dW3z7udffwkY1LSNVA4zilLa07Bsgoc0zyJtMiy0TKjLngTDBX6+xotvAIOLnmN11RPhK
	 TqGg/XmlX6pmJXbtZRuilhIW0w86XLCXyGkz9iyFu53UBi+2yerpKEv1eSJLsBVSaJVZF
	 Qum2RZWyi1QbicViGL6W2VsSNzVR9ZheExl/5z+kPeWaHaiKvv3ZtOAvNOR4GWi8Ql+iZ
	 K+yfgrOr3p6ZFOhAqMIDHzgx0s6k3lCg3/5K/lW0QFBpwsu3HtuoAwCj0gPQfJeQo3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=b7Y85ZMNTmnO5vyHoGmhNUdpyQ1xa3t2s3wZRjsJimY=;
	b=Ig8KancJ3uGx4Pn63fTYvKThTLMh5g1Es1xlQ69GFp/GS5Pe0TFy2vBP5tWQ2/SxpDio
	 S43fUnBEPRDLSjed8jw/nZpNKgwZf6eJO54tSaIFs1OeUTlGlWiBNv+riPB2yec+kHMBl
	 SI40sDu3bxk4xgzJJUxa+9McP0Y/dbpwLdK+4Gz5QVwgN1W9y03ofFdT8HtURdtDcLnxd
	 6KR9KgkFMG8DWS8AaruLOIBKUAPAzGEGzkz2DOlx69Sm6rh/+HZZhuWBKHDjEWTMOk4gx
	 22MjvSA201t4WAkHkBU+95h8oaKG4GI3mnr1f/MoszQXoGYxkTFt/88q1eNYZ6b5tmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=STDm0Ns6;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB88E606D827
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 18:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB88E606D827
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=STDm0Ns6
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-53665358476so9171881cf.2
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 10:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793990628; x=1794595428; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b7Y85ZMNTmnO5vyHoGmhNUdpyQ1xa3t2s3wZRjsJimY=;
        b=STDm0Ns6/45sn2GRqprHpdF/TMkQ19axHR3n5cyc181ziPFbHYTRRicsRris+v5cZR
         rUmYTy0rLtZNDUseeeDlvHQpKzXW3Y3AEWt+Z+bytjfs3p9qkggzEAWc+TzdsR7nURl2
         R9ctDLjI8qsRR2Qe6yLo/cMXvjfapPD6InEEebX6QJu8UHz0jHJ/wQLIihRgpkeVcMvv
         LuYUeGZPFkScEPmnPoRyZ2ToUo0i9fo1Irda1Qkj4nLCljVgpNRiOWMhPqi77dsSTtej
         V1sIBLyiax5uQYbfmQ6/pmMCsKi1UVKqptiwW1xEWkaaX8cFzTDzeqLVeyHP+4JVEFPa
         gKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990628; x=1794595428;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b7Y85ZMNTmnO5vyHoGmhNUdpyQ1xa3t2s3wZRjsJimY=;
        b=mgIn16cCLBchaIs/dk8WTSgUviyL0zw4HbbOGxAWZ9k5bjziqS5pLjTbVMpkRo2cJz
         BtYkve4gWePsHPZAjwOcCx+IRMJ2vT3Yvuq1AG7SLAwvIdlIlkErITQLOVH2QrNN8RgA
         Tlc4+DqdScFpmOsSNiRPT5JxTeHBRV5Y5e212OXHCKQn6da0VW2w5nwOabmxdOQARu8T
         z/ir+sfY4SfvCgzbKInz4x6t1/Lc9JcQH9cVCFgJMX7e2HJTcJGD69doA/WkLeONN9y8
         gBOqMxzcNxCxepDMCwJ5nFP8XQmjyZI+JpNndw8jaWLVaO45PfrQ76VR8j9J6MBCUf5M
         Mkdw==
X-Forwarded-Encrypted: i=1; AKwUvBzs0Vi370NsqyV0qxb/CV9BlxWCQRbN1JJvh2Q6uzsQ9BEfl2QiNAGdLUGwB4AbbIjIoZlCzw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+dDU9BgspoosyOpop4ZnZ0D88mimqkK1RqPeybmYpX9CTmCVos
	YlOnRzFDcMuP1PV90voXeSpYm/YF5W929C+RGeqF81qo0ofbAJmEtdVw10XEhuvSGTA=
X-Gm-Gg: AYBFou0BXMhP5Asf6VGfvR2i33Iofe0Q6zRE7NhfZfXGgsKmUjYHSjLYO+S9/4mUvm5
	3CUrbuRcEwCjiOsdiL67/YIg2bXx9Gqhxq5WAz0WyxfaAqPE1FWh2ZmvF3TuWkR73l1TVrXnd4A
	YPBs1MnRJDfvXiEm6smFpQNOQAmQ6sUnuKaKxeHABNnUCGWvPcNMl95ZpMIv5A1c30VJ0Luuhc1
	tkWC4ScukHADiegLLBSjm485iWXPNvVVDp+f7QKaD79So7YHAmTGraGp7MFbl+Ny9Rs0LypqpWw
	QjyOXEbJ8ajEHqV2ZY0SgHuf1MYpWkFAbbewQ/eUR9RmgUvRm9vVxVx65GAVaAHrZBOeJ3TXBne
	yVf19pJ/RXjSyuZ0PlDzG0J23z+rHRxe8YIWD7GoKMG9q7N2GXxLid02QGfnQ8qV/F3hTxfKoXN
	1aHU4oFsvTZXEL65s4ZKeZYbm7zCXGzZ+Wp6Dx22BCeuf6efP5ya1mG6J4gQadLswoLoNjuZdVs
	xLbW1bu4aXnM99SIoZF1wrPUAnV2Y6vuNsH0sRxcV5diSSZSLlCDGjZX20I5t8wId7wFCi4ea3M
	Ay2GMKb/vxvUanq0D24lbclufuIc5HpqMp4SWytMGNNXcH8BGttkj+UWW0BhlElsP+DypMs0Vef
	69k1C82x95Q==
X-Received: by 2002:a05:622a:47cd:b0:536:764e:1527 with SMTP id d75a77b69052e-54e14a6c486mr53004081cf.44.1793990627606;
        Fri, 06 Nov 2026 10:43:47 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e25785f14sm26823821cf.5.2026.11.06.10.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:43:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xPOug-00000007JdL-0xGY;
	Fri, 06 Nov 2026 14:43:46 -0400
Date: Fri, 6 Nov 2026 14:43:46 -0400
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
Message-ID: <20261106184346.GJ663069@ziepe.ca>
References: <20261023140107.GC3977851@ziepe.ca>
 <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
 <20261023145023.GH3977851@ziepe.ca>
 <20261103080933.GA4213@lst.de>
 <20261103151021.GK3889730@ziepe.ca>
 <CAMP57yWvHO0pWCR3-9q1gtwVe8WV4Y6i69trmw+BJRVYf3JB1g@mail.gmail.com>
 <20261106173054.GH663069@ziepe.ca>
 <CAMP57yU-VhZWXijvwAXcN9=zZ+eWXZ6J1bkHuCJw3ocRaFaV=Q@mail.gmail.com>
 <20261106180714.GI663069@ziepe.ca>
 <CAMP57yW6Y4g-xM9YTB+MpgxPN7RFeEWhAPWvqrfOoMDEuL8HZA@mail.gmail.com>
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
In-Reply-To: <CAMP57yW6Y4g-xM9YTB+MpgxPN7RFeEWhAPWvqrfOoMDEuL8HZA@mail.gmail.com>

On Fri, Nov 06, 2026 at 10:17:38AM -0800, Naman Gulati wrote:
> On Fri, Nov 6, 2026 at 10:07 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Fri, Nov 06, 2026 at 10:00:35AM -0800, Naman Gulati wrote:
> > > On Fri, Nov 6, 2026 at 9:31 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Fri, Nov 06, 2026 at 09:21:08AM -0800, Naman Gulati wrote:
> > > > > I drafted an implementation [1] for premapped TX and RX buffers on top
> > > > > of the existing networking page_pool. It is implemented entirely in
> > > > > the networking layer and extends page_pool as the default RX
> > > > > allocator, to the TX path. There are no hooks in the IOMMU, DMA or
> > > > > page allocator code. I wanted to understand if this implementation
> > > > > correctly captured the feedback on this thread. Key components of this
> > > > > design:
> > > > >
> > > > > - Chunks: as in Luigi's series, memory comes in 2 MiB chunks, but each
> > > > > chunk is mapped once per opted-in device through the DMA API and
> > > > > records its IOVA for each device, rather than using a shared IOVA
> > > > > window.
> > > > >
> > > > > - TX: page_pool accepts a memory provider for pools that are not bound
> > > > > to an RX queue. Per-CPU page_pools take 32 KiB pages from the chunks
> > > > > of their NUMA node; TCP copies sendmsg() data into them through the
> > > > > task page_frag and allocates its skb heads from them.
> > > > >
> > > > > - RX: an instance of the same memory provider, sharing the chunk code,
> > > > > backs RX queue page_pools. RX chunks of order-0 pages belong to one
> > > > > device and NUMA node, and are shared by that device's queues on the
> > > > > node.
> > > > >
> > > > > [1] https://github.com/torvalds/linux/compare/master...NamanGulati:linux:netdev_dma_pool
> > > >
> > > > IMHO the netstack should never read from shared/decrypted memory. If
> > > > you put it in a SKB you have to be sure the only touch after that
> > > > point will be a DMA read from an untrusted device on the TX side
> > > > (sending it to a trusted device would be a fail) and the final copy to
> > > > userspace on the RX side.
> > >
> > > That's likely a fair callout. TBH I'm not very familiar with CoCo and
> > > will spend some time understanding the constraints. I kept CoCo out of
> > > my implementation as I approached this solution from the overcommitted
> > > VM problem where we are trying to overcommit memory in VMs and use
> > > these pre-mapped pages to avoid using bounce buffers.
> >
> > Why does overcomitted VM use bounce buffers? Do you mean this is
> > about getting better memory clustering in page pool since the VM
> > paging granule is 2M?
> 
> Not exactly, we are trying to use VFIO passthrough NICs in
> overcommitted VMs. Since the guest memory is overcommitted we can't
> dma-map the entire guest address space (as non-overcommitted VMs do).

?? I understood you could and this was implemented under the
virtio-iommu by pinning the memory under active DMA?

Where in upstream does the DMA API force bounce buffering for this
case?

> So overcommitted VMs can use bounce buffers to have a set of
> pre-mapped buffers to bounce traffic in and out. We're trying to use
> this solution to map pages dynamically with virtio-iommu and recycle
> them via page-pool to avoid traps on each TX/RX and avoid the copy
> cost of bounce buffers.
> 
> This problem extends to generally reducing IOMMU overhead in
> networking - taking the dma map/unmap cost out of the hot-path and
> avoiding IOTLB thrashing.

Sure, that makes sense, but just having a pool of entirely normal
pre-dma-mapped memory is quite a different problem from what launched
this thread...

Jason
