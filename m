Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792776479;
	b=zzmxwcaC/PkK0OEgPnnaqZUpxU72yDwW/Czw3JeaXDnOn7UTl4Cl1xjP1kMdPN8qJoZx
	 KmZtSFVdXikTWD46xI6isA7q6tAutOgdqBj92a95o+6F43WVviryIqdJM/cVodrqbZJJf
	 jWM+cIQiC9q2uGYrph4BT74keXdIF2Xsb1SHQhnEbJmICm9t9nYGWbRpnchf5aXrZndUv
	 0SRx0dmuhq/qGLIGe4e61anQQqPltUqZwBWI0etPd13PONtkc53dJOvpgscBh8Zy9bdy5
	 QmenvPDmmqAN1f4faeXVRQAWenzBPM4YGPVKOG35yff3dPTZgdFMYNpgFSLI/8yQYXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792776479;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jJXUDdGOUlnprTLNQ3mpD2znb8kn6x0W43UYG81DLJE=;
	b=u51EQVR1R+dEPPggXOJoET1mZWVzkp731M/2d9tbLggsea+3yPklRnK8QQPS6tK0nkjK
	 5tAYR+wKvASCVPTyz8Cp365QWCVe0OprRbxv6r4KbJH+JrrOqJnhnmxrOuaxy0FytRshf
	 cNdZa9UtXPxFS+5vU2IB078evadl2gmUHTVsI/Ab2SBX8Zkw0FtM+P7OXzdSprUF2Nyni
	 5TodNc2Xh8qsbrifsEyFZkP4PI5KkKUwsc9Lz+qnUwhLV0mlCy5m+zKz7Cj11vW7SQTd4
	 s0dVHBAUXzHgIpbLiIsdS7Yi5MUEoXGiRGaqWJjfZGgvxy4OHDJCO/B1WB2/L/+QfJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VRNOxv+1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3920606A31A;
	Fri, 23 Oct 2026 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VRNOxv+1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DAF1F01825;
	Fri, 23 Oct 2026 17:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792776478;
	bh=jJXUDdGOUlnprTLNQ3mpD2znb8kn6x0W43UYG81DLJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VRNOxv+1Pksyrz5HnFhBkcnpuxCnSmnXdeyB52HziAZ0BKiZZtXPxAuj93PuJc5xI
	 1pTqs+75q+CJrl3PdpXqmb75U0b0ztZJPlKfMeA3oNQiv6FTGN0ztfopW9p+8p+T7P
	 ui7Qx8f3vVvVIwafvbWaB9RjhsPkzk6toCmg6ljNO/fs5AQqJlScIW/CdQo43D6NRP
	 tJo7uzYkrsViniHWvZsVkJCO1YIV9hAIclTxvK4nIj4FUgUlALsK4u9HNWRALjqoHb
	 Ctem5QTw0r4Gw3aGxKfIafMxkmpl9sspL0EJ5FfAFmnB/0QSTga0iibcftCdkkp4By
	 uoxDdS6wkAlbA==
Date: Fri, 23 Oct 2026 10:27:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Luigi Rizzo <lrizzo@google.com>, "David Hildenbrand (Arm)"
 <david@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Willem
 de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy
 <hramamurthy@google.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev,
 netdev@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
Message-ID: <20261023102756.201315d7@kernel.org>
In-Reply-To: <20261023145023.GH3977851@ziepe.ca>
References: <20261003212241.3432303-1-lrizzo@google.com>
	<0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
	<CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com>
	<b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org>
	<CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>
	<20261022201229.GH3381610@ziepe.ca>
	<CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>
	<20261023140107.GC3977851@ziepe.ca>
	<CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
	<20261023145023.GH3977851@ziepe.ca>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Oct 2026 11:50:23 -0300 Jason Gunthorpe wrote:
> > Anyways, reading your next comments, are you suggesting that all
> > these functionalities should be implemented as pagepool extensions?
> > (2MB mappings and iommu backing, proper allocator of fragments out of larger
> > pages, device-less pagepools, multi-domain mappings, pagepool
> > as memory provider for skb heads, pagepool as memory provider for descriptor
> > rings ?)  
> 
> netdev shouldn't be touching iommu, it can get a 2M page and map it
> using the normal DMA API. AFAIK there is not such a big reason to need
> any of these layering violations. They just make it easier on page
> pool..

FWIW we're entirely happy on the netdev side to add this to page pool.
In fact the initial RFC I posted for "page pool memory providers"
was addressing this exact use case. I didn't push it forward due
to low time and suspicion that IOMMU folks would prefer a more generic
solution. Since then memory providers were pushed forward and merged
for dmabuf, and we have netlink APIs to configure things. So adding
large mappings should be SMOC.
