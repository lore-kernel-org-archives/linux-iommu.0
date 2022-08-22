Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0517FA
	for <iommu@lists.linux.dev>; Mon, 22 Aug 2022 11:20:00 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id AEFF668AA6; Mon, 22 Aug 2022 13:19:56 +0200 (CEST)
Date: Mon, 22 Aug 2022 13:19:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Yunfei Wang <yf.wang@mediatek.com>
Subject: Re: [PATCH] dma-debug: Improve search for partial syncs
Message-ID: <20220822111956.GA9920@lst.de>
References: <35bf2add5ae803b0355d556f965090d4014e574e.1660590752.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35bf2add5ae803b0355d556f965090d4014e574e.1660590752.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 15, 2022 at 08:28:40PM +0100, Robin Murphy wrote:
> Having come back and looked at this for long enough to realise that
> max_range itself was both wrong and not actually useful, I figured it
> was easiest just to write the whole thing up as an alternative patch.

Yes, this looks much better than the original code.  Yunfei, can you
test this for your specific case as well?
