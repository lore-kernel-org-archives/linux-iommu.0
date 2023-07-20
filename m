Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EE03D99
	for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 06:07:53 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id C188067373; Thu, 20 Jul 2023 08:07:42 +0200 (CEST)
Date: Thu, 20 Jul 2023 08:07:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH] dma: DMA_ATTR_SKIP_CPU_SYNC documentation tweaks
Message-ID: <20230720060742.GA2987@lst.de>
References: <98ef4f76d7a5f90b0878e649a70b101402b8889d.1689761699.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98ef4f76d7a5f90b0878e649a70b101402b8889d.1689761699.git.mst@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 19, 2023 at 06:15:59AM -0400, Michael S. Tsirkin wrote:
> A recent patchset highlighted to me that DMA_ATTR_SKIP_CPU_SYNC
> might be easily misunderstood.

.. just curious: what patchset is that?  DMA_ATTR_SKIP_CPU_SYNC is
often a bad idea and all users probably could use a really good
audit..

>  #define DMA_ATTR_NO_KERNEL_MAPPING	(1UL << 4)
>  /*
> - * DMA_ATTR_SKIP_CPU_SYNC: Allows platform code to skip synchronization of
> - * the CPU cache for the given buffer assuming that it has been already
> - * transferred to 'device' domain.
> + * DMA_ATTR_SKIP_CPU_SYNC: Allows platform code to skip synchronization of the
> + * CPU and device domains for the given buffer.

While we're at it, I think "allows" is the wrong word here, we really
must skip the synchronization or else we're in trouble.
