Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76510182A1
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 11:29:00 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0EB0367373; Mon, 31 Jul 2023 13:21:56 +0200 (CEST)
Date: Mon, 31 Jul 2023 13:21:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pintu Kumar <quic_pintu@quicinc.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, hch@lst.de, m.szyprowski@samsung.com,
	robin.murphy@arm.com, iommu@lists.linux.dev, pintu.ping@gmail.com,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Liam Mark <lmark@codeaurora.org>, Laura Abbott <labbott@redhat.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2] dma-contiguous: define proper name for global cma
 region
Message-ID: <20230731112155.GA3662@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690598115-26287-1-git-send-email-quic_pintu@quicinc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi Pintu,

On Sat, Jul 29, 2023 at 08:05:15AM +0530, Pintu Kumar wrote:
> The current global cma region name defined as "reserved"
> which is misleading, creates confusion and too generic.
> 
> Also, the default cma allocation happens from global cma region,
> so, if one has to figure out all allocations happening from
> global cma region, this seems easier.
> 
> Thus, change the name from "reserved" to "global-cma-region".

I agree that reserved is not a very useful name.  Unfortuately the
name of the region leaks to userspace through cma_heap.

So I think we need prep patches to hardcode "reserved" in
add_default_cma_heap first, and then remove the cma_get_name
first.
