Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE21D23A8
	for <iommu@lists.linux.dev>; Fri, 27 Jan 2023 07:07:09 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3621568D09; Fri, 27 Jan 2023 08:07:05 +0100 (CET)
Date: Fri, 27 Jan 2023 08:07:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Christoph Hellwig <hch@lst.de>, Dave Hansen <dave.hansen@intel.com>,
	Georgi Djakov <quic_c_gdjako@quicinc.com>, catalin.marinas@arm.com,
	will@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
	peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, djakov@kernel.org
Subject: Re: [RFC] mm: Allow ZONE_DMA32 to be disabled via kernel command
 line
Message-ID: <20230127070705.GA4180@lst.de>
References: <20230126164352.17562-1-quic_c_gdjako@quicinc.com> <dca84e05-e376-c593-74fa-37c58f30767a@intel.com> <20230127063555.GA3300@lst.de> <C7DCCCB1-AABE-4D3B-80B1-AB755A68D460@zytor.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C7DCCCB1-AABE-4D3B-80B1-AB755A68D460@zytor.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 26, 2023 at 10:52:43PM -0800, H. Peter Anvin wrote:
> >If people want ZONE_DMA32 to go away we need something to replace
> >it first, like a large enough CMA region in the 32-bit addressable
> >range.
> 
> Not to mention all kinds of odd masks like 30, 31, 39, 40, 46, ... bits.

Yes.  Out of those all >= 32 are falling straight into ZONE_DM32,
the lower ones we do a first try in ZONE_DMA32 and then fall back to
ZONE_DMA.  <= 29 mask OTOH are really rate in modern systems for
actual devices.  So with a CMA region for what is currently ZONE_DMA
and one for the first 1G we'd probably cover most of what's actually
needed for x86_64.  Of course on 32-bit architetures things become
a lot more complicated due to highmem.
