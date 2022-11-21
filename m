Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370D6A2C
	for <iommu@lists.linux.dev>; Mon, 21 Nov 2022 08:37:19 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id CDDBA68AA6; Mon, 21 Nov 2022 09:37:07 +0100 (CET)
Date: Mon, 21 Nov 2022 09:37:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Takashi Iwai <tiwai@suse.de>
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
Subject: Re: [PATCH 6/7] ALSA: memalloc: don't pass bogus GFP_ flags to
 dma_alloc_*
Message-ID: <20221121083707.GA27649@lst.de>
References: <20221113163535.884299-1-hch@lst.de> <20221113163535.884299-7-hch@lst.de> <87leod52l6.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87leod52l6.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 14, 2022 at 10:04:37AM +0100, Takashi Iwai wrote:
> It mentions something about sparc32/64.  I hope this isn't relevant
> any longer (honestly I have no idea about that).

It shouldn't.  sparc is using fairly generic code now.
