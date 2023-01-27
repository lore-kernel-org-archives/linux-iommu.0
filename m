Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED38C15A8
	for <iommu@lists.linux.dev>; Fri, 27 Jan 2023 06:36:05 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7A69F68D09; Fri, 27 Jan 2023 07:35:55 +0100 (CET)
Date: Fri, 27 Jan 2023 07:35:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Georgi Djakov <quic_c_gdjako@quicinc.com>, catalin.marinas@arm.com,
	will@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
	peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, hch@lst.de, m.szyprowski@samsung.com,
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: Re: [RFC] mm: Allow ZONE_DMA32 to be disabled via kernel command
 line
Message-ID: <20230127063555.GA3300@lst.de>
References: <20230126164352.17562-1-quic_c_gdjako@quicinc.com> <dca84e05-e376-c593-74fa-37c58f30767a@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dca84e05-e376-c593-74fa-37c58f30767a@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 26, 2023 at 10:51:17AM -0800, Dave Hansen wrote:
> 
> Also, what are the practical implications here?  There are obviously an
> ever decreasing number of 32-bit DMA devices out there.  Somebody that
> has one and uses this option might be sad because now they're stuck
> using ZONE_DMA which is quite tiny.
> 
> What other ZONE_DMA32 users are left?  Will anyone else care?  There is
> some DMA32 slab and vmalloc() functionality remaining.  Is it impacted?

DMA32 never supported lab.  But < 64-bit DMA device are unfortunately
still not uncommon, and configuring out ZONE_DMA32 breaks them pretty
badly as we guarantee that a DMA mask of 32-bit always works.

So I'm not only very much against this patch, but also the currently
existing way to configure out ZONE_DMA32 on arm64, which needs to
go away.

If people want ZONE_DMA32 to go away we need something to replace
it first, like a large enough CMA region in the 32-bit addressable
range.
