Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D44156C0
	for <iommu@lists.linux.dev>; Mon,  9 Oct 2023 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6FF0568CFE; Mon,  9 Oct 2023 11:15:15 +0200 (CEST)
Date: Mon, 9 Oct 2023 11:15:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org,
	netdev@vger.kernel.org, Jim Quinlan <james.quinlan@broadcom.com>,
	Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: fix the non-coherent coldfire dma_alloc_coherent
Message-ID: <20231009091514.GA22463@lst.de>
References: <20231009074121.219686-1-hch@lst.de> <CAMuHMdU281a+=9SApaCRy5os3k73HGZhQ=Fsv58OD4C430iDDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU281a+=9SApaCRy5os3k73HGZhQ=Fsv58OD4C430iDDg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 09, 2023 at 10:39:18AM +0200, Geert Uytterhoeven wrote:
> CC Greg

Ooops.  I was pretty sure I added him as he is one of the most
relevant persons for this.  Sorry.

