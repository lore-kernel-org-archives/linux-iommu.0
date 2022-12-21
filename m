Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF791FB3
	for <iommu@lists.linux.dev>; Wed, 21 Dec 2022 07:46:25 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id A5D1867373; Wed, 21 Dec 2022 08:46:15 +0100 (CET)
Date: Wed, 21 Dec 2022 08:46:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: Re: [PATCH 2/2] dma-mapping: reject GFP_COMP for noncohernt
 allocaions
Message-ID: <20221221074615.GA22974@lst.de>
References: <20221220082009.569785-1-hch@lst.de> <20221220082009.569785-3-hch@lst.de> <alpine.DEB.2.22.394.2212201653520.3532114@eliteleevi.tm.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2212201653520.3532114@eliteleevi.tm.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 20, 2022 at 04:57:25PM +0200, Kai Vehmanen wrote:
> Minor nit, typo "noncohernt allocaions" in subject of this second patch.

Thanks,

I've fixed this and queued up the series.
