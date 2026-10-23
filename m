Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792765863;
	b=J6YHo+zpx/ceLYGSma/Q1z5tHaZQKFZxzoiIdFg9CjRto+LoXQYCmFY9CryA3F9EXcDA
	 do1tTQljLVYEg5tFD/rv38bdt8OPmjXLh6XV8sy7LAr20DmKiYulicF6H5CiXfTDgUl2S
	 rHzbxZ/5yBtdF+c1LI3MfEdEvPzmTuzphUFWkW0lLW+XFxEpmLIpltjLI9EFg618FgEzJ
	 rrG+cFOOge2zk+jLmYHQP3Eqq1t3Wk/Rr0Ul1bHRqKM5tJe3KCksixfsSGoxuo+e4ZPJC
	 FRf752jEsPBfjWwPqQYerrLXleu+sU7aQtJ4Rr8VjikeX91Hr3srJeZR40tx6JR+qaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792765863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=s3FkMl8OhjMqOhi3zpzbiZNiNsx48LLQzOlCjP1CveY=;
	b=WkVaaboyd6zsxE9xllBSyJip6pcN3cRWh8jRTr0QrLAeFpUiem5oIdaIF0AQtJE2PSVC
	 YsrMruHS9U2LtDOEJaLl1rG6D9r4Um65P1cNDbDK4QNp0IaxAPkOmTinTfSXMT8b4uZtj
	 01+RU1Q/vcOjuZYyxD38MxOWsc0Szf+eWG1jeRlcJKW/Pd77T4SpvHnsFyyIJ/SE0B9nb
	 IzFK03EHay7qk/50AMJDmHOkfrUv3N/Tf1mxjG8NHSaS5TcMXNsvyDXd5te8PD+v741tS
	 CNhpsWcBQMOJvKuBhCUFP32axqTbChQ7r7FpLP2n6CZLWlzRF64HRYnNeC6iD/5HiqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=pUhHw0SY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6F6606A328
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 14:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F6F6606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=pUhHw0SY
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2db33db4de9so71155ad.0
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 07:31:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792765863; cv=none;
        d=google.com; s=arc-20260327;
        b=cx7INBuxjfR9PAZ2mjRNZOPKFUvs+YUUWHWccutVOcHzGkHaa0r0rX5KK4gG/ghsaJ
         dPlX/3oTCjnz510uLrLBhj+1rJKg4HxttsLXLQltYOgM3u0WelOaCIRELQChyTaKLdMR
         +ytB8eAeqDn5i87g1+/UC0fHwCQVmmB58gO9M/DoVBgI4U2EgzlllaryNX26+AcB9tD/
         7zHEPv5xwqFreoFFhG1HBSZUijyANImRONljyILZWfFddaRyollx0IlLbYFPfw0thnT9
         JMBdFerRndW8fV6s1KXWCRw35Z27q3uzP7oQpm86WgAvFT5HGts1Y6yeU5S2a4CLZjBm
         S4TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s3FkMl8OhjMqOhi3zpzbiZNiNsx48LLQzOlCjP1CveY=;
        fh=uAVGc+6a9K8/Nwn6xRT+Gv0iA+ovFLUTTAZGhZzwXXk=;
        b=fl7b3s8eBA51e2OItXBDJHAdoXWxnle2eJ5iqO1w7gTzKab8RGp94TuO9cugdfUCZ3
         XEOlFcfF04PF/LO+lFx9otlTJAh6J8+vfqsAHJ9mxmNVZARUsgvMAQZ8vNf8dcH/Afpb
         uZFioBaKWiZNt4/oA97Ev/FJ5FM2MmvJra+x7GgadLtNn1VbrM8BdDhKkpcp/KUYJ7Ng
         6zVS/MsFr3aN7osypEmUxWQJMGH3P8AjL7fYWTmp+Jer7DpVGbJ1vvA6l7bQu4DCXUvF
         wn8DQ+RKLJAkjvzpTg7F3gl32ix/izJQoVx1ybbIJAVeHj6gsCQnv9FZt1zFoJQbomyY
         PrkQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792765863; x=1793370663; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s3FkMl8OhjMqOhi3zpzbiZNiNsx48LLQzOlCjP1CveY=;
        b=pUhHw0SY0+Byms+8Dlum6dLyL93HdB3zS3TTtUrVW/GIeiKli28x2K1qx9TABzFHhS
         7gSjYbQvGCYFX6g+7CY2F74rLKZCAnd2APFZTfdW0v4wH00LXh0ov5IYd6P7A0q5jmVj
         YILe6tB/LxJT8z9foItVL4QFi6gW2qz+WT+AaNH1SPQ+BDQDcQyMjKrXvoC6bBUleVLR
         JFi901tbevrzZ/jfkWUBkNfMuCl8s10C61WLh3yxtHX5nndzyj6umvnyG5yPoaj530in
         2T5LoFKdvhuMs3nXmcE9a1cXIT0iDOXjBvGm3vtNM2P7P73s4hC9otOLFRh8//SdwnFp
         QiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792765863; x=1793370663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s3FkMl8OhjMqOhi3zpzbiZNiNsx48LLQzOlCjP1CveY=;
        b=fCO3s3N3CwtxEIPNyoOzhq5PZ7wBN0D1UKXMCC56R8dsFaUdaEnmUopm4Xbc4ByEej
         mtEqPYPL7lQ30IOO2t/j/OTrGlhYlzKpcvHpRFsCw7f0C8lax8lIDoWc4Xg1h4kgpGUZ
         R59pgkJEb5riSPhj6DPAu7GFh5cys9/4MWHSLduS4k5oJ8hArz781XHiMwAO4bdz6fhD
         fiZ2x53KxfAQdiMepvnUKern7AW4BGkGyrG+mBZhJSRl2bQqP3Agoph3w/KaguCE9NeI
         pUyQV7qJe8CSiEJQt3IUppvBesJsZ0HhDjKT26l2FkQuoR1DQ0KA1hynLtYTZixt6voN
         IcsQ==
X-Forwarded-Encrypted: i=1; AKwUvBxmP0800ALmiZ8n9q8+p+uA1kbLikxRlG5E5hLPXhEEmKxA5T78m18BojSgrL6kwiFJg2aXbA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLDyrINGXvEyWiYeZKQqxlgLMQofq4004aBpW+XjawAEzuK08dH
	HV+lW68B1a8hD+XcZhzomDfBcgeBPJbdsWBIZq/QWsXheie7SSZFGqhY+HsqFPEjp7Nama2s3jo
	/pcgtMJxYNaOXtpvyRyqbHhWCU/vC9+dhGisfeSAH
X-Gm-Gg: AYBFou1EUPEYr1BKQ/r2SwOzRLMcR7OopnT7/jzY+0mikUpFOk8dFYwZvlrtRZVFs3H
	3goJNEKlsthXelH9U0OOKS7GqlCDnBqV771edPO7Jw4egwhDb8t1lPiyvneCk2wmJuzojGZrqkI
	LruIB4Q0NQHs8QN31f7PxPvv5GwEN9IM4Weak0iR/hoU86T+HpzOKc0iggCE2SSN2KuELbtErpN
	AyMPDYOZh9f06fp9WQ9yFDWqSaS5CQxZ1NRxEI9yGz/9TMrlq6gx71WsRmJJJD/ha/osFociFMY
	fXCGn4UocrM2UiYjxpm2fMkuU+feD1qFxnhCktJBhmyWmVFFu6M1OyWbdaOwFqpgLW1TuCjWMAi
	MfjeeAJO1QwxoYIDDyyjUpgx7LPVKMfAB6fKOcJRRyqAe06JjZk8lKal4hOU=
X-Received: by 2002:a17:902:f683:b0:2ea:7180:3abf with SMTP id
 d9443c01a7336-2ea7f512f16mr4025665ad.15.1792765862249; Fri, 23 Oct 2026
 07:31:02 -0700 (PDT)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com> <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
 <CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com>
 <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org> <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>
 <20261022201229.GH3381610@ziepe.ca> <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>
 <20261023140107.GC3977851@ziepe.ca>
In-Reply-To: <20261023140107.GC3977851@ziepe.ca>
From: Luigi Rizzo <lrizzo@google.com>
Date: Fri, 23 Oct 2026 16:30:25 +0200
X-Gm-Features: AclHuK9d7tFq_s1fhJmYPVN1-JncgZCOvwLUHaeunw-YOxbh9iZtFoxmVAkcY88
Message-ID: <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, driver-core@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 4:01=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Thu, Oct 22, 2026 at 11:51:40PM +0200, Luigi Rizzo wrote:
> > On Thu, Oct 22, 2026 at 10:12=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca>=
 wrote:
...
> > > Can someone explain what outside netdev would use this? And why you
> > > couldn't do this in the netdev page pool?
> >
> > I can try.
> >
> > Regarding users, the next target is disks (not included in this series)
>
> Disks don't use a memory pool, they do IO to folios allocated by the
> page cache.

I know. As I said I have a separate patch to cover those IO buffers

 block/bio.c                  |  21 +++++
 block/blk-mq-dma.c           |   4 +-
 drivers/iommu/dma-pmd-node.c |   3 +-
 drivers/iommu/dma-pmd-pool.c |  14 ++-
 drivers/iommu/dma-pmd-priv.h |   7 +-
 drivers/iommu/dma-pmd-user.c | 390
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----=
---
 include/linux/dma-pmd.h      |  53 +++++++++++
 mm/filemap.c                 |  27 +++++-
 mm/page-writeback.c          |  13 +++
 mm/readahead.c               |   9 +-


Disk I/O is still potentially affected by the same problems
(cost if io mapping/unmapping, iotlb thrashing, bounce buffers
in confidential computing...)

>
> The only other candiates I know of besides page pool would be the
> existing dma pool users. I don't think they are so performance
> sensitive as netdev.
>
> IOW I think this entire series is only useful to netdev.

Well, the series provide mechanisms to address disk I/O as well.


>
> > > It is not a common workload to have the DMA allocator be the one that
> > > allocates the memory. Usually we are DMA'ing from memory that was
> > > allocated someplace else.
> >
> > Aside from the fact that dma_alloc_attr()/dma_alloc_coherent()
> > does memory allocation + iova allocation/mapping,
> > this is not what happens here.
> > Maybe the confusion comes from one function name
> > (dma_map_alloc_pages()), but it doesn't map any thing.
>
> > My code (in this version, and more in the upcoming release)
> > mainly implements a specialized memory allocator with an
> > API equivalent to alloc_pages() and variants, but ensures that
> > the order-N blocks come from contiguous 2MB blocks reserved on the fly.
> >
> > The physical addresses of these blocks are recognized by the
> > "dma allocator" (I suppose you meant the entity that allocates the IOVA=
 range)
> > so that it can apply specialized IOMMU mappings backed by 2MB IOMMU lea=
ves.
>
> Why? This seems completely divergent from how anything else works in
> DMA mapping, and I don't see a reason for it to be anything like
> this. Other than it makes page pool work a bit easier
>
> Frankly this looks like you had AI to transpose a bunch netdev page
> pool into iommu.

(yes, AI assisted, heavily human-guided).
Frankly, it's very orthogonal to pagepool, given that it uses pagepool
for what it does well, and it provides functionality that pagepool
does not have.

Anyways, reading your next comments, are you suggesting that all
these functionalities should be implemented as pagepool extensions?
(2MB mappings and iommu backing, proper allocator of fragments out of large=
r
pages, device-less pagepools, multi-domain mappings, pagepool
as memory provider for skb heads, pagepool as memory provider for descripto=
r
rings ?)

cheers
luigi
