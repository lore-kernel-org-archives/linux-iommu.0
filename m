Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795191444;
	b=IVIWGc3V+WzIg96xP2UmkfJwVOn/zR4ClQNdhMtugASa6eDQNgfJzh90v1MxJ5HPXpwN
	 pqMzHaZO0GL0f7eKhW0/1YlwTTjb4CB0KlxY//md+upbazVmfZ4Jbnf82CJOgwvwaWmGl
	 +zbgmBKnk+wyIYvJ/3meGHkjq++2vbtSHc1O08W9anV5l/RZqNNh2FOKCyEOoN9PaHocV
	 cgbpcZGvwBY9auqX/iVuiQZAwT0jLMWO/yzfmVXyP4d3zY8KzXmV18itPmWgBg/9SHKST
	 j25NtVQzAW3YOSgGqy7VKBc2NX3Aau2C3nRgY3hb5BT0K6AdhqNEDHfDwTKdkS7LwVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191444;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=7oWxZkJSIrIvDRuijxJDq8O8Wh3VfFr0MJdwdp0vWdE=;
	b=kWJ6C5dfllzPAVQLqNYyVHvOtOubZkdpNenxtw5yZn0TDHVKhSFNLMBGfLOeL+v4CFi0
	 CWyCSWlzqN7xHC7BMFSTW45bb35MXINEahuCX9gOQLtdWEMnnZzr6+mM+OynY4P3t2Usf
	 yrrzPQYyhqtCjWilqzNp2UssX1oBsVY35fB75FimkbV6420VFTBLXUA51l5+gG3uZy/X5
	 Dx9+w+PQ7/M7O+NVrYNRzMIU8k5UnhWy1NjS9nt/g1Px+gr0GsBeaW11t7KpKKl3umjNn
	 O2LOWqN1aclJsg2KKZdT3dDKFfE1q+j8ZIorZbzhnWHve7BC13dhJpPocz+1JoHaTXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54990606A320;
	Fri, 20 Nov 2026 16:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54990606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 095346732A; Fri, 20 Nov 2026 17:17:16 +0100 (CET)
Date: Fri, 20 Nov 2026 17:17:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Luigi Rizzo <lrizzo@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Vlastimil Babka <vbabka@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Luigi Rizzo <rizzo.unipi@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>, Harry Yoo <harry@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Naman Gulati <namangulati@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
	iommu@lists.linux.dev, netdev@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 12/25] block, mm: Support PISA for disk I/O and
 scrub migration
Message-ID: <20261120161715.GA31401@lst.de>
References: <20261109182533.3594984-1-lrizzo@google.com> <20261120010655.467825-1-lrizzo@google.com> <20261120010655.467825-13-lrizzo@google.com>
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
In-Reply-To: <20261120010655.467825-13-lrizzo@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 20, 2026 at 01:06:42AM +0000, Luigi Rizzo wrote:
> Extend PISA user/page-cache allocators to support O_DIRECT and buffered
> disk I/O, gated per block/controller device through pisa_rx_bufs (read)
> and pisa_tx_bufs (write):
> 
> - Split per-node user_pa into DMA_BIDIRECTIONAL, DMA_TO_DEVICE, and
>   DMA_FROM_DEVICE allocators, promoting pages to DMA_BIDIRECTIONAL if
>   later accessed in the opposite direction.
> - Upgrade pinned O_DIRECT user pages in bio_iov_iter_get_pages(), and
>   allocate/promote order-0 page-cache folios for buffered I/O when PISA
>   is enabled on the target block device.
> - Add pisa.scrub_migrate to compact or demote lingering folios off old,
>   sparse user_pa 2MB pages.

No, doing MM migrations in an (any) I/O path makes no sense at all.

Can we all please go back to actually thinking about problems instead
of generating giants amounts of shit code without the slightest
reflection.

Than you very much for your attention.
