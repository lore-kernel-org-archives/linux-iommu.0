Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069DEC448
	for <iommu@lists.linux.dev>; Wed, 16 Nov 2022 06:11:11 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id CFEBC68AA6; Wed, 16 Nov 2022 07:11:06 +0100 (CET)
Date: Wed, 16 Nov 2022 07:11:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Russell King <linux@armlinux.org.uk>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-media@vger.kernel.org,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH 7/7] dma-mapping: reject __GFP_COMP in dma_alloc_attrs
Message-ID: <20221116061106.GA19118@lst.de>
References: <20221113163535.884299-1-hch@lst.de> <20221113163535.884299-8-hch@lst.de> <Y3H4RobK/pmDd3xG@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3H4RobK/pmDd3xG@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 14, 2022 at 10:11:50AM +0200, Leon Romanovsky wrote:
> In RDMA patches, you wrote that GFP_USER is not legal flag either. So it
> is better to WARN here for everything that is not allowed.

So __GFP_COMP is actually problematic and changes behavior, and I plan
to lift an optimization from the arm code to the generic one that
only rounds up allocations to the next page size instead of the next
power of two, so I need this check now.  Other flags including
GFP_USER are pretty bogus to, but I actually need to do a full audit
before rejecting them, which I've only done for GFP_COMP so far.
