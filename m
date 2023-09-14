Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DE5FBE7
	for <iommu@lists.linux.dev>; Thu, 14 Sep 2023 18:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E7CC433C7;
	Thu, 14 Sep 2023 18:28:04 +0000 (UTC)
Date: Thu, 14 Sep 2023 19:28:01 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] swiotlb: fix the check whether a device has used
 software IO TLB
Message-ID: <ZQNQscYr0rQWdw66@arm.com>
References: <20230913114016.17752-1-petr@tesarici.cz>
 <20230913121403.GB4544@lst.de>
 <20230913142656.29e135d6@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230913142656.29e135d6@meshulam.tesarici.cz>

On Wed, Sep 13, 2023 at 02:26:56PM +0200, Petr Tesařík wrote:
> On Wed, 13 Sep 2023 14:14:03 +0200
> Christoph Hellwig <hch@lst.de> wrote:
> > Thanks, I've applied this to get it into linux-next ASAP.  I'd love
> > to have reviews before sending it on to Linus, though.
> 
> Fully understood, given my past record. ;-)
> 
> @Catalin Marinas: I have added you to the list of recipient, because you
> spotted some issues with memory barriers in one of my previous attempts.

I seem to have forgotten everything about that thread (trying to
remember what I meant in
https://lore.kernel.org/all/ZGJdtmP13pv06xDH@arm.com/ ;)).

What do the smp_wmb() barriers in swiotlb_find_slots() and
swiotlb_dyn_alloc() order? The latter is even more unclear as it's at
the end of the function and the "pairing" comment doesn't help.

I found the "pairing" description in memory-barriers.txt not helping
much and lots of code comments end up stating that some barrier is
paired with another as if it is some magic synchronisation event. In
general a wmb() barrier ends up paired with an rmb() one (or some other
form of dependency, acquire semantics etc.) but they should be described
in isolation first - what memory accesses on a CPU before and after the
*mb() need ordering - and then how this pairing solves the accesses
observability across multiple CPUs. The comments should also describe
things like "ensure payload is visible before flag update" rather than
"the wmb here pairs with the rmb over there".

Presumably in swiotlb_find_slots(), the smp_wmb() needs to ensure the
write to dev->dma_uses_io_tlb is visible before the *retpool write? For
swiotlb_dyn_alloc(), I'm completely lost on what the smp_wmb() orders.
You really need at least two memory accesses on a CPU for the barrier to
make sense.

-- 
Catalin
