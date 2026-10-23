Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767026;
	b=JWgKL3EQClK0rgrNHYGI2HJnSop1CtQquLqYjXwtPXWiFUWlmzIZyVtJtKxfeP1phZd4
	 DQFcRiEgVkEN/87aT+IhF2PAf6AI7Q67/okcfIrGXko5MnyS1woQWQvcKIklGgzRhr5P+
	 mrcFwF/QI1g4d5XNHyHe/7nqr5pPhYkIRYNrFipkbFJdN5ni99uSTKIbIwVSdwl/8zNSN
	 4U20nvBd3eYYn/7eRlzoVoXMAxJ9QP22vThq/wsIiyUsRl1JzhGHv1934i8btLiK8eOYX
	 FntADd5CnuxwRs+gWa6Ets7yKe9dFzhRNXDvtZ13YvAhG7xoKS1JpmnibmlIZUeZ/8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=sGl5cqr0Sn8jKPodNx0zyYTo2AHNV4DEHX4rmbHeM6s=;
	b=dpzexAAXXppH4EZTZ2xMSUdOqeB6czepdy9xPI4td76LV5HLaSQCKsXdw/7qg9Func/d
	 OYHflV/RN9H+Pu95gCVF/JjDj+blKIX2veG3DmymjY3JTP7IhjFMUEKPuab4+MjsbNZDa
	 EtrBkoETnYqirylVYkqcphHcvSB0TWA7P0mvW+0MP/6CFFOnsQ1N0E4zcuLcptxLH/b0h
	 uPmTxb9OMl6TVJGsSkU1UOfswFf6ZclnOxzRPF2ZAE43Tk+iRR0IvgcchIer2OV9MNPSu
	 C0qSsHIZdrEQ6VbCO+Ai+CPIecOr0iGdfw56bCYTEAB/bf8q29vMKW+9zecuUOnNGXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=T5be2Fnt;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092CD606A322
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 14:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 092CD606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=T5be2Fnt
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5365b48238dso6867381cf.0
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 07:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792767025; x=1793371825; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sGl5cqr0Sn8jKPodNx0zyYTo2AHNV4DEHX4rmbHeM6s=;
        b=T5be2Fnt/rklVx0TL/h8cjblkdqasMG3lUYtqFXFvtGrnk0pJBVcP/VnK4ECjVQz35
         9XEle/XtrCCv1/TRliZxc5dwRbKQ9wJEqzJk4jI4abjmhV1Ri+dZ62sZXnbpu/CHAu1R
         mh6nTxVGUhg4DuvP0ZIcvxxKJSJ927V3solbOsbyzgamEep1BGjDQZSXiDnQbw7TSbKu
         DsrrA6CGQDrSRsBVkavdrtyQsXSPHWaOfrANtoQfrLsAia5eQVTb7Ef5/sefGBq5Mnwz
         TS2yF1TEOxkWuxp3Le5Jk2bDNoZxTybFeyJ2CBWHm0LsYLAQRJmtf9/n9RtP3YFG8M3m
         aE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792767025; x=1793371825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sGl5cqr0Sn8jKPodNx0zyYTo2AHNV4DEHX4rmbHeM6s=;
        b=pscr335DtWFP41XlnOn31gCuAy+sCKKUop+JhhRrY4YcrPgWuICwJWXXSfoW0xL5uL
         MTBSjk1YdNa04ElhnVkHB9z/pbmzcEX4yBWbrjoy+QpnAQH0g4m+YZxTVSceA4NiFFw5
         gfJc8QHbbuev04I8f4VFStJpzQyn9QSFgwYXb5naKuA1ufqIP4r8gH/aiev3ApuPxjLC
         j5boU9AJtJaSVJMCBkwZkJw1lAaxMF6Q8EvAmRlKYHEjGGuD2otco+Won2sCpzl6wOEC
         /lZbrKeDKtnUQCrNfEjOLKMoCBskN+yd698BHKCkM96dBnIuWiJiZt+DuhIeT0lnFBuv
         VNmA==
X-Forwarded-Encrypted: i=1; AKwUvByLkac+xQP7sK1cU1pRf19Vu/ABoYg3i7W3Vwg5rrceK8LGcuUAlrGTejRsm2hdvyP3o9fQ/A==@lists.linux.dev
X-Gm-Message-State: AFq9FYKqn5U8zN91OYNd19dTk9XJihZDpPVwq9dmNkI7h7EKAv9fto8T
	ttWELVXOO0+BQi/ImLExkk/sOGOltZTHt3apXQCpwlrxm+kz6i48GW0mxvwlAplaMtI=
X-Gm-Gg: AYBFou10UWrF4G854Y5UBbBfbq1bw9SYjhlzbsZW1umGDlw6DAyIyN/sJyeqjmPkZKM
	eGrmLB19ITq71DkNaYxeRwAnklFQNIsxhKTtCHzglVPPPsoqyUKUTCWHSODldtY/mgM0FZuEyvP
	2exFQo8EPM2qNtBdguJB9UuZie2JAAN4yaPj2SE4v58KunQQ/T/ENkkG+/lG1TQecmIZKlc/dbT
	CFvP0bJSvWk7Ku5eXd4EWU5wUnZyzZXxD25KFZij64f2r+QFElKYqoq1wyRzgwAmbm8svCTZsh5
	apZacCg++k7G2PlNjgKUA/hQoblDR2rD7UO1hpc2d74ChEZ/JVYtuQdnRu7p670d3vezooPBrMT
	+ZyKmf3lsDjoezdTNFtQ+ee4fXiq6a5zKzFRPaKSLmV63QXt3dVr5iiEPCpNm1MMKlsivX+Rm5g
	qc53fwRCY7RpI0Ucf8JR5F9yZpQN8/XoFbq/NZuY3ha9kU8m12uHDw/ygXg1CqjpsdML0x6GqVG
	9l1K9F+H1+BXgGn7JmRA95XBL9BUb4G76qlHmq2FndPi+0thygAKARa7ixQ+oUjbChvvIRcfjpp
	92XnpZ36mUvDKY0aBvtZqDrRAeuWDIcmad97fA==
X-Received: by 2002:a05:622a:3cc:b0:536:7669:7eed with SMTP id d75a77b69052e-536c2837232mr34025651cf.21.1792767024875;
        Fri, 23 Oct 2026 07:50:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536c1846ff0sm18130901cf.19.2026.10.23.07.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:50:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xKGb9-0000000GkTD-2sYP;
	Fri, 23 Oct 2026 11:50:23 -0300
Date: Fri, 23 Oct 2026 11:50:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Luigi Rizzo <lrizzo@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20261023145023.GH3977851@ziepe.ca>
References: <20261003212241.3432303-1-lrizzo@google.com>
 <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
 <CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com>
 <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org>
 <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>
 <20261022201229.GH3381610@ziepe.ca>
 <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>
 <20261023140107.GC3977851@ziepe.ca>
 <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
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
In-Reply-To: <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>

On Fri, Oct 23, 2026 at 04:30:25PM +0200, Luigi Rizzo wrote:
> On Fri, Oct 23, 2026 at 4:01 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Oct 22, 2026 at 11:51:40PM +0200, Luigi Rizzo wrote:
> > > On Thu, Oct 22, 2026 at 10:12 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> ...
> > > > Can someone explain what outside netdev would use this? And why you
> > > > couldn't do this in the netdev page pool?
> > >
> > > I can try.
> > >
> > > Regarding users, the next target is disks (not included in this series)
> >
> > Disks don't use a memory pool, they do IO to folios allocated by the
> > page cache.
> 
> I know. As I said I have a separate patch to cover those IO buffers
> 
>  block/bio.c                  |  21 +++++
>  block/blk-mq-dma.c           |   4 +-
>  drivers/iommu/dma-pmd-node.c |   3 +-
>  drivers/iommu/dma-pmd-pool.c |  14 ++-
>  drivers/iommu/dma-pmd-priv.h |   7 +-
>  drivers/iommu/dma-pmd-user.c | 390
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
>  include/linux/dma-pmd.h      |  53 +++++++++++
>  mm/filemap.c                 |  27 +++++-
>  mm/page-writeback.c          |  13 +++
>  mm/readahead.c               |   9 +-
> 
> 
> Disk I/O is still potentially affected by the same problems
> (cost if io mapping/unmapping, iotlb thrashing, bounce buffers
> in confidential computing...)

The disk folks already have a proposal to address all of this using
io_uring and preallocated buffers. I really doubt yet another version
is going to be interesting there.

> Anyways, reading your next comments, are you suggesting that all
> these functionalities should be implemented as pagepool extensions?
> (2MB mappings and iommu backing, proper allocator of fragments out of larger
> pages, device-less pagepools, multi-domain mappings, pagepool
> as memory provider for skb heads, pagepool as memory provider for descriptor
> rings ?)

netdev shouldn't be touching iommu, it can get a 2M page and map it
using the normal DMA API. AFAIK there is not such a big reason to need
any of these layering violations. They just make it easier on page
pool..

"multi-domain mappings" is that just for page pool because it can't
easially keep track of IOVAs for all the devices mapping the same PMD?
I admit hacking in a special IOVA range so every netdev has the same
IOVA is certainly a creative way to ignore all layering and solve
it. :\

But you could just figure out a way to keep track of the per-device
per-PMD iova mapping..

That said, if you came with some much narrower series to request some
kind of 'globally shared iova' during dma allocation that might be
something dma-api folks could agree with.. It seems like the only
actual DMA API request here anyhow?

That's a bit tricky since it is impossible as a general concept, but
maybe you can come up with some way to narrow it..

I'm still not convinced this is even right for netdev, especially
compared to what Dragos has been working on. The CC stuff seems
actively dangerous. Unconditionally always using CC shared memory for
skbs is completely security wrong. What I have traffic flowing inside
my VM between containers or something? Does this end up putting those
skbs in shared memory even if they never hit a physical NIC?  Same
with a TDISP capable NIC, does this unconditionally degrade its
security?

Jason
