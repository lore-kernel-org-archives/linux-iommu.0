Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B38322A
	for <iommu@lists.linux.dev>; Tue, 29 Nov 2022 14:08:21 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5BDAA6732D; Tue, 29 Nov 2022 15:00:35 +0100 (CET)
Date: Tue, 29 Nov 2022 15:00:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hans Verkuil <hverkuil@xs4all.nl>
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
Subject: Re: [PATCH 1/7] media: videobuf-dma-contig: use dma_mmap_coherent
Message-ID: <20221129140034.GA15560@lst.de>
References: <20221113163535.884299-1-hch@lst.de> <20221113163535.884299-2-hch@lst.de> <95cf026d-b37c-0b89-881a-325756645dae@xs4all.nl>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95cf026d-b37c-0b89-881a-325756645dae@xs4all.nl>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 24, 2022 at 03:10:43PM +0100, Hans Verkuil wrote:
> Very, very old code :-) Hopefully in the not-too-distant future we can kill off
> the old videobuf framework.

That would be great for various reasons.

> But for now:
> 
> Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> 
> I assume you take this? If not, then let me know and I will pick it up for the media
> subsystem.

I've actually picked it up a while ago.  So without a reabse I can't
add your formal ACK, but I hope Linus is fine with that.
