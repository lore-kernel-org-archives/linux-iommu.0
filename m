Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855CB2E650
	for <iommu@lists.linux.dev>; Thu, 12 Oct 2023 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9AB8E67373; Thu, 12 Oct 2023 16:00:39 +0200 (CEST)
Date: Thu, 12 Oct 2023 16:00:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>, Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org,
	netdev@vger.kernel.org, Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH 5/6] net: fec: use dma_alloc_noncoherent for m532x
Message-ID: <20231012140038.GA8513@lst.de>
References: <20231009074121.219686-1-hch@lst.de> <20231009074121.219686-6-hch@lst.de> <ea608718-8a50-4f87-aecf-fc100d283fe8@arm.com> <0299895c-24a5-4bd4-b7a4-dc50cc21e3d8@linux-m68k.org> <20231011055213.GA1131@lst.de> <cff2d9f0-4719-4b88-8ed5-68c8093bcebf@linux-m68k.org> <12c7b0db-938c-9ca4-7861-dd703a83389a@gmail.com> <e16ac0a4-3e4a-4e8c-98ba-7b600a8c6768@linux-m68k.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e16ac0a4-3e4a-4e8c-98ba-7b600a8c6768@linux-m68k.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 12, 2023 at 11:25:00PM +1000, Greg Ungerer wrote:
> Not sure I follow. This is the opposite of the case above. The noncoherent alloc
> and cache flush should be performed if ColdFire and any of CONFIG_HAVE_CACHE_CB,
> CONFIG_CACHE_D or CONFIG_CACHE_BOTH are set - since that means there is data
> caching involved.

FYI, this is what I ended up with this morning:

http://git.infradead.org/users/hch/misc.git/commitdiff/ea7c8c5ca3f158f88594f4f1c9a52735115f9aca

Whole branch:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-coherent-deps

