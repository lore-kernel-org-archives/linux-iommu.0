Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986258;
	b=NtLfP04B5ki0GDFTslVZx9laJ+QQewhBGNffWqYD+wNVnNNySxyNgOaqn8nrkdnFALtP
	 LTl6IhPKYCMVjdUSA9tuTrrg0SpKEv2JOgXMpel+Q1RczDSI2oB9L7z326DLYjphBE2rK
	 BvOYjsaH9HP3iULG2dm+UT9C/gSHkIOCaP7D8zCIhy0ta1FnJXDvdTfSlExyZb1AjYz70
	 YzdmZC7KbAF92/X7IUIJ4zxYNwx5ZXSkZ1Cc2HwMgtaDtAR+TDBGXs52qY9cn0xRgVUTf
	 1KkGoXbxGiH0e4dbmmWL3DzdkUPz/lMjPIXNy2MZnYcnfYDsiHLYmm4Kk1bfkaPpJzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986258;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=XofOEQXNLqFn+X/AdUrRbjVcp2Tpjks1Mv/4b0yulcU=;
	b=hoFmy0xGm6XfJ4e0mP04vbwcJs5UOzMaXiW63w0t3W984WT5hax3L7NkqWIRk9M67tdM
	 gLI+vK5bEEp6+UAdCwuQNQtyY/TxHzeDsU9/QIuMl7n0pxMGuO1PmzbIF3pneeyMpCqKQ
	 SnFQBss77hR/zoPBWVb2RanJY2k7DnqEQZi9FvEckKKshyVkE5zWjp5eBbIy2/t9k5NC2
	 /tkWzzwtjKD8lgFDArYvlwTj5HBJX7xCpPYDnhecz/HCHtCY2wbwuPxP34pzwRb04aoSb
	 uNuxUQTBjPRWb/k0ydnWfW1nPKmZCqmYlJy0o2L9eGNAhrDbtVDeVuEOnbhlIFRci0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=in35xxpq;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD66606A326
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 17:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACD66606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=in35xxpq
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91eb5559b34so3365856d6.0
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 09:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793986256; x=1794591056; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XofOEQXNLqFn+X/AdUrRbjVcp2Tpjks1Mv/4b0yulcU=;
        b=in35xxpqBM6rdfsbShYcHSyUj63tCA6rN95tCGGTqlNYv4JPxXYTU1Hayoshqbnd/h
         Q7lHxOUVsJWk5p3+5COh5cbyCxLqJ6aBOzgAT2HHZkDuaIEcozxALUj+/MSL+VHimkJV
         E0lWBrBUO2Fshm20ZVqcIMFB1gorN1vxw/HqyWyF8T36ydIkxnTZx4x/vTnTOnr+1BtC
         3EJS1usyUbV/I1cLI743swb7hmv8bwFuUed3iz5hsC6MKNLn1nRXT2eCMQi+NvmV7Vyp
         8Y8eAk5mkUgBCfWiXmAZhoYLH7y+KKD6XCCgKyatcqrNZ0ZbyrWCybES4+yJZxcwVbiz
         vJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793986256; x=1794591056;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XofOEQXNLqFn+X/AdUrRbjVcp2Tpjks1Mv/4b0yulcU=;
        b=FxAjel0YQSsyDeFpW8IgQLS6N+whVXot90I+1yyYN0vC8mrlIEq9URgbwkU9EiGbYA
         L+xSNFjBZ9oagX9IYNPbbe7AAWvyLtk607qw8R2lZ8x0uXwh7VpLez4qEYEAoYIEZkWt
         3RWvGeJBV01hQqeAh/PYbmk2YEFI2lNqXa8URrxQGXvQrdA9qVdRCbzs+BOHFdupalX9
         Aag8ALiM+DnGt6crqtjJDKv28g0jf8xFkBQuU9EaMrK1VAk4c2s9KEHn9vQvQG/CbKp6
         LH66A1AvaqOhOdfWWrnao1qDxpEmjbEOLVU+/KanoZK03Ljp5MCsGE0E/+1F6fIq5JDT
         q0vg==
X-Forwarded-Encrypted: i=1; AL+hErFUGM4+MSWDpKl26QNdLxAWB5sVf0fKB2H4vXC6VevsE3NqhKLclCGmLuNj0c676+hKp6T5Uw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/C7XZYyVDN2kBdjiO0rm9b+ECS7w8ZZGAu7kIsj/Sv1+OgOwO+
	0I/TNUOzs5dnL2c3PEPHraiYUgZAqp2hMND5CzsDtcQeAblVHEdOrzFdBNKbpLEmyp8=
X-Gm-Gg: AYBFou1kWKY/VKU+hHZPYBtQgeaPx45e9lhrVilJlR2CQwuea+xC4rBjXtwao1f/Ids
	MXOeTWRDdlRUzIZC5QLIpDVFpj8iSS9U3/wb64mSUBmN1dXqhXIghK5o62VtcahB9suhrVFhgEK
	ldAOmldwxnT5DQImLgKQXpYMtinxEMbKzuCxjwmIQ1BUp53R0H8D+cqWte2pI3gu70pkFy65aak
	zfk0w8fO0+yw5tX+IxsxgSEDZtXcQ5ipJx0UOitwPjgPqFaAja7lloj4A4OPv5HA0ueV+o3Uznr
	Db+9YLA540QxDz5dMjr3SzxRSImw+k7kqwR5XmaajpCsMMtsknmCt8ncZ/6MMsvLKC5QMYi9szE
	MEYwK7wbH17G7IThpjZOHdITX6AZcMHjB1mtpaway3sSnEpgmUG+DBTY8eKYZZtMCTbqt8z4uz+
	ajD3tCvYyfMUm7TXYVMr+pWs9fOsJsp+gb+CFxjX8dWLkzWDIB3DoKX7opVzRQvwsNQqmiR/gIr
	jz6Q2CvkeAs5cd1rX1vzSPmxWfU4i2fctZQrRj71XlsdP2JSW1ErbnG7KkDk8F6Tg00ISfE7C98
	968o4vgp3GUL8n1A272PucUToTcWG+uI65yXr3kvCFI0SALCWdTZxfThNhynatLy2nGpZ5KAJE7
	mTci+A+nbBiedZIjXQtArAln8gkr5tF4=
X-Received: by 2002:a05:6214:c69:b0:91c:73fc:a5a8 with SMTP id 6a1803df08f44-91ea9742db4mr40471196d6.9.1793986256339;
        Fri, 06 Nov 2026 09:30:56 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6acceacsm25406486d6.43.2026.11.06.09.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:30:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xPNmA-000000076Mk-3tnC;
	Fri, 06 Nov 2026 13:30:54 -0400
Date: Fri, 6 Nov 2026 13:30:54 -0400
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
Message-ID: <20261106173054.GH663069@ziepe.ca>
References: <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org>
 <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>
 <20261022201229.GH3381610@ziepe.ca>
 <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>
 <20261023140107.GC3977851@ziepe.ca>
 <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
 <20261023145023.GH3977851@ziepe.ca>
 <20261103080933.GA4213@lst.de>
 <20261103151021.GK3889730@ziepe.ca>
 <CAMP57yWvHO0pWCR3-9q1gtwVe8WV4Y6i69trmw+BJRVYf3JB1g@mail.gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMP57yWvHO0pWCR3-9q1gtwVe8WV4Y6i69trmw+BJRVYf3JB1g@mail.gmail.com>

On Fri, Nov 06, 2026 at 09:21:08AM -0800, Naman Gulati wrote:
> I drafted an implementation [1] for premapped TX and RX buffers on top
> of the existing networking page_pool. It is implemented entirely in
> the networking layer and extends page_pool as the default RX
> allocator, to the TX path. There are no hooks in the IOMMU, DMA or
> page allocator code. I wanted to understand if this implementation
> correctly captured the feedback on this thread. Key components of this
> design:
> 
> - Chunks: as in Luigi's series, memory comes in 2 MiB chunks, but each
> chunk is mapped once per opted-in device through the DMA API and
> records its IOVA for each device, rather than using a shared IOVA
> window.
> 
> - TX: page_pool accepts a memory provider for pools that are not bound
> to an RX queue. Per-CPU page_pools take 32 KiB pages from the chunks
> of their NUMA node; TCP copies sendmsg() data into them through the
> task page_frag and allocates its skb heads from them.
> 
> - RX: an instance of the same memory provider, sharing the chunk code,
> backs RX queue page_pools. RX chunks of order-0 pages belong to one
> device and NUMA node, and are shared by that device's queues on the
> node.
> 
> [1] https://github.com/torvalds/linux/compare/master...NamanGulati:linux:netdev_dma_pool

IMHO the netstack should never read from shared/decrypted memory. If
you put it in a SKB you have to be sure the only touch after that
point will be a DMA read from an untrusted device on the TX side
(sending it to a trusted device would be a fail) and the final copy to
userspace on the RX side.

Everything else is very security questionable.

It is unclear to me how any of these page pool proposals meet that
requirement since page pool typically provides memory that ends up
widely used in the netstack.

Jason
