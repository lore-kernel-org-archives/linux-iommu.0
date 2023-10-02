Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C6520F5
	for <iommu@lists.linux.dev>; Mon,  2 Oct 2023 06:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XKqktRgZJ9kzBiEPkUUVphTY5hbUfnFM86CuOM3EvbY=; b=bGmIi2RbBBQ68IW4awuPgghjA0
	bg8A7VVnJrSg+QryNVBhMjSFHVLEDLilkMlWK/XOxYwpItZgilPWVvlc8/A5gwXDcGGLRuGZaZW8v
	vNqCWakUQfMlVR6v0vtK/VZ1Lt7drz38jnH3hRShMwLP3Eaz9P8HL53bvtZGz5MOvpbdmo2nfvapB
	HQrxlpJ7N+Nqxj3JdDVoFKPLPQXghoy4nPUXAxwW9FtGK63+NcsdxgxJvrLGV73NoQCG4JtrgAsp5
	1/xAqbbDF7wmI/iUVdzrEmNZSwYSqAH7AsrWtw0Pt0lNRZimVP3E4mJokzPrqtcvXgZelfiESPQsw
	JY7D3eQw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qnCRY-00C1mG-0L;
	Mon, 02 Oct 2023 06:30:12 +0000
Date: Sun, 1 Oct 2023 23:30:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kelly Devilliv <kelly.devilliv@outlook.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dma_map_resource() has a bad performance in pcie peer to peer
 transactions when iommu enabled in Linux
Message-ID: <ZRpjdPC4eSCA/jOk@infradead.org>
References: <TY2PR0101MB3136A7480B842E009BCBDA8384C3A@TY2PR0101MB3136.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2PR0101MB3136A7480B842E009BCBDA8384C3A@TY2PR0101MB3136.apcprd01.prod.exchangelabs.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

FYI, dma_map_resources must never be used for PCIe P2P mappings, you
absolutely must use dma_map_sg as only that handles all the corner cases
correctly.

And we need to figure out a way to put a check into dma_map_resources
so that people stop abusing it.

