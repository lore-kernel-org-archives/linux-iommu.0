Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012936118
	for <iommu@lists.linux.dev>; Wed, 16 Nov 2022 15:45:17 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id B04AC68AA6; Wed, 16 Nov 2022 16:45:07 +0100 (CET)
Date: Wed, 16 Nov 2022 16:45:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
	Christoph Hellwig <hch@lst.de>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-media@vger.kernel.org,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH 2/7] RDMA/hfi1: don't pass bogus GFP_ flags to
 dma_alloc_coherent
Message-ID: <20221116154507.GB18491@lst.de>
References: <20221113163535.884299-1-hch@lst.de> <20221113163535.884299-3-hch@lst.de> <c7c6eb30-4b54-01f7-9651-07deac3662bf@cornelisnetworks.com> <be8ca3f9-b7f7-5402-0cfc-47b9985e007b@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be8ca3f9-b7f7-5402-0cfc-47b9985e007b@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 16, 2022 at 03:15:10PM +0000, Robin Murphy wrote:
> Coherent DMA buffers are allocated by a kernel driver or subsystem for the 
> use of a device managed by that driver or subsystem, and thus they 
> fundamentally belong to the kernel as proxy for the device. Any coherent 
> DMA buffer may be mapped to userspace with the dma_mmap_*() interfaces, but 
> they're never a "userspace allocation" in that sense.

Exactly.  I could not find a place to map the buffers to userspace,
so if it does that without using the proper interfaces we need to fix
that as well.  Dean, can you point me to the mmap code?
