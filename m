Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836335661
	for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 11:51:33 +0000 (UTC)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 6454415DE30;
	Thu, 20 Apr 2023 13:51:25 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1681991485; bh=g2Y0JUrOOrjs89t94MuNQTvVybtijGZMJ0i55bADfpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QjgJpIvhA5OvUg+LBiSm+buLfpgqbqDLvPEbn+iWZH53NDG4alePmDkpKoqDgsZjc
	 7VcoU6SBCdvY3UJTzYjGnvCcTLvE16JQ4L81toBZSWenxzuaRWHWfYTREtDjWVCQC0
	 kZAnxudb59X/0NiOz4o7CZLHMFfFY025kmMtDvsOhm6bSqDfR0U9V34RWajnQvdIir
	 r7SRIfoysRlocdJ6IAelLMIOQRFvbt444nfABSY9cD86HMj0MVtg+KVHUj4usw+bVQ
	 2FAhzCR7ABxYIRz6LNf/OLIjDLC0RNFjT24B09YDOiHEIayUPoHcq69eTOPyq3anlP
	 S+Htq3rPP/m3Q==
Date: Thu, 20 Apr 2023 13:51:24 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Alexander Graf <agraf@csgraf.de>
Cc: Isaac Manjarres <isaacmanjarres@google.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon
 <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, Ard
 Biesheuvel <ardb@kernel.org>, Saravana Kannan <saravanak@google.com>,
 Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, Joerg
 Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>, Mike Snitzer
 <snitzer@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-mm@kvack.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 13/13] dma: arm64: Add
 CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC and enable it for arm64
Message-ID: <20230420135124.62c452db@meshulam.tesarici.cz>
In-Reply-To: <629d62ce-b993-35fe-05ff-ee0befc0c73d@csgraf.de>
References: <20221106220143.2129263-1-catalin.marinas@arm.com>
	<20221106220143.2129263-14-catalin.marinas@arm.com>
	<6e846f75-b330-9523-4356-41d5f9e48f12@arm.com>
	<Y2omz6pibSUNPtHu@arm.com>
	<20221108100331.GA31944@lst.de>
	<Y4eldGXZjpi2L2SQ@google.com>
	<629d62ce-b993-35fe-05ff-ee0befc0c73d@csgraf.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Alex!

Nice to meet you again...

On Thu, 1 Dec 2022 00:32:07 +0100
Alexander Graf <agraf@csgraf.de> wrote:

> Hi Isaac,
> 
> On 30.11.22 19:48, Isaac Manjarres wrote:
> > On Tue, Nov 08, 2022 at 11:03:31AM +0100, Christoph Hellwig wrote:  
> >> On Tue, Nov 08, 2022 at 09:52:15AM +0000, Catalin Marinas wrote:  
> >>> Since it's hard to guess the optimal swiotlb buffer for such platforms,
> >>> I think a follow-up step would be to use the DMA coherent pool for
> >>> bouncing if no swiotlb buffer is available. At least the pool can grow
> >>> dynamically. Yet another option would be to increase the swiotlb buffer
> >>> at run-time but it has an overhead for is_swiotlb_buffer().  
> >> Alex said he wanted to look into growing the swiotlb buffer on demand
> >> for other reason, so adding him to Cc to check if there has been any
> >> progress on that.  
> > Hi Alex,
> >
> > Did you get a chance to look into this? If so, have you been able to
> > make progress on being able to grow the SWIOTLB buffer on demand?  
> 
> 
> I've been slightly under water and haven't been able to look at this yet 
> :). It's on my list, but will probably be a while until I get to it. 
> Would you be interested in having a first try?

All right, I have just found this thread now after having sent my own
patch series to make SWIOTLB dynamic. I hope you don't mind. I didn't
want to "steal" the project from you.

Petr T
