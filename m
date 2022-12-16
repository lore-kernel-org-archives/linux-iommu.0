Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CD120E3
	for <iommu@lists.linux.dev>; Fri, 16 Dec 2022 12:15:26 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8637667373; Fri, 16 Dec 2022 13:15:20 +0100 (CET)
Date: Fri, 16 Dec 2022 13:15:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
	m.szyprowski@samsung.com,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev
Subject: Re: [6.2][regression] after commit
 ffcb754584603adf7039d7972564fbf6febdc542 all sound devices
 disappeared (due BUG at mm/page_alloc.c:3592!)
Message-ID: <20221216121519.GA5710@lst.de>
References: <CABXGCsPnpu0TGHnvXM1we7q1t3tJAOYW2rA=AMvf7ZahcYvpRQ@mail.gmail.com> <20221216064645.GA24446@lst.de> <a76cb262-a24f-e113-5680-2025aa143ee6@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a76cb262-a24f-e113-5680-2025aa143ee6@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 16, 2022 at 11:40:57AM +0000, Robin Murphy wrote:
> On 2022-12-16 06:46, Christoph Hellwig wrote:
>> Ok, it seems like the sound noncontig alloc code that I already
>> commented on as potentially bogus GFP_GOMP mapping trips this.  I think
>> for now the right thing would be to revert the hunk in dma-iommu.c
>> (see patch below).  The other thing to try would be to remove both
>> uses GFP_COMP in sound/core/memalloc.c, which should have the same
>> effect.
>
> Or we explicitly strip the flag in dma_alloc_noncontiguous() (and maybe 
> dma_alloc_pages() as well) for consistency with dma_alloc_attrs(). That 
> seems like it might be the most robust option.

In the long run warning there and returning an error seems like the
right thing to do, yes. I'm just a little worried doing this right now
after the merge window.
