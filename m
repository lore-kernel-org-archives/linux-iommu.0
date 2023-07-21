Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252ED2102
	for <iommu@lists.linux.dev>; Fri, 21 Jul 2023 07:42:12 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id B2F0F67373; Fri, 21 Jul 2023 09:42:09 +0200 (CEST)
Date: Fri, 21 Jul 2023 09:42:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Yajun Deng <yajun.deng@linux.dev>,
	corbet@lwn.net, m.szyprowski@samsung.com, robin.murphy@arm.com,
	paulmck@kernel.org, catalin.marinas@arm.com, rdunlap@infradead.org,
	peterz@infradead.org, rostedt@goodmis.org, kim.phillips@amd.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v3] dma-contiguous: support numa CMA for specified node
Message-ID: <20230721074209.GA22859@lst.de>
References: <20230720082517.GA7057@lst.de> <20230712074758.1133272-1-yajun.deng@linux.dev> <25942dafbc7f52488a30c807b6322109539442cf@linux.dev> <20230720115408.GA13114@lst.de> <20230720095941.76803bbda5ad0c5103713d0c@linux-foundation.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720095941.76803bbda5ad0c5103713d0c@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jul 20, 2023 at 09:59:41AM -0700, Andrew Morton wrote:
> > Where did this land?  dma patches really should be going through
> > the DMA tree..
> 
> It's in mm-unstable with a note "hch" :)
> 
> I'll drop it.

Ah.  And looking at the patch is isn't even pure dma but also has
a significant mm side.  If you're fine with it I'll pick it up in
the dma-mapping tree in addition to the follow up.
