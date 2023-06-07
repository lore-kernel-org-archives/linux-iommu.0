Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EA48839
	for <iommu@lists.linux.dev>; Wed,  7 Jun 2023 13:07:50 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id D4EDB6732D; Wed,  7 Jun 2023 15:07:46 +0200 (CEST)
Date: Wed, 7 Jun 2023 15:07:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: gaoxu <gaoxu2@hihonor.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	yipengxiang <yipengxiang@hihonor.com>,
	"wangbintian(BintianWang)" <bintian.wang@hihonor.com>
Subject: Re: [RESEND  PATCH] dma-remap: Use kvmalloc_array/kvfree for
 larger dma memory remap
Message-ID: <20230607130746.GC19066@lst.de>
References: <4cae21d9a89a4c4da47fb3ef6465b676@hihonor.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cae21d9a89a4c4da47fb3ef6465b676@hihonor.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied to for-next.
