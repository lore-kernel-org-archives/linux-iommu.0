Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C887B
	for <iommu@lists.linux.dev>; Fri,  7 Apr 2023 05:50:20 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 88ECE67373; Fri,  7 Apr 2023 07:50:16 +0200 (CEST)
Date: Fri, 7 Apr 2023 07:50:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Kelley <mikelley@microsoft.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	decui@microsoft.com, tiala@microsoft.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] swiotlb: Track and report io_tlb_used high
 water mark in debugfs
Message-ID: <20230407055016.GA6803@lst.de>
References: <1680324300-124563-1-git-send-email-mikelley@microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1680324300-124563-1-git-send-email-mikelley@microsoft.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Mar 31, 2023 at 09:45:00PM -0700, Michael Kelley wrote:
> Changes in v3:
> * Do high water mark accounting only when CONFIG_DEBUG_FS=y. As
>   as a result, add back the mem_used() function for the "swiotlb
>   buffer is full" error message. [Christoph -- I didn't hear back
>   whether this approach addresses your concern about one additional
>   atomic operation when slots are allocated and again when freed. I've
>   gone ahead with this new version, and we can obviously have further
>   discussion.]

Still not too happy, but at least debugfs is an interfact we could
remove at any time.

But can you please factor the used_hiwater accounting into two
separate helpers that are udner CONFIG_DEBUG_FS and otherwise
stubbed out, instead of adding the logic directly into
swiotlb_do_find_slots and swiotlb_release_slots?
