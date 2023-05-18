Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E852194
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 18:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543F6C433D2;
	Thu, 18 May 2023 18:46:41 +0000 (UTC)
Date: Thu, 18 May 2023 19:46:38 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>,
	Isaac Manjarres <isaacmanjarres@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 00/15] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN to
 8
Message-ID: <ZGZyjiYl3Iyq52xq@arm.com>
References: <20230518173403.1150549-1-catalin.marinas@arm.com>
 <CAHk-=wgm77p42Ow87pZf042+s5aC4S0N4TEPHQnrEyeg-aKtpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgm77p42Ow87pZf042+s5aC4S0N4TEPHQnrEyeg-aKtpg@mail.gmail.com>

On Thu, May 18, 2023 at 10:56:24AM -0700, Linus Torvalds wrote:
> On Thu, May 18, 2023 at 10:34 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> >
> > That's the fourth version of the series reducing the kmalloc() minimum
> > alignment on arm64 to 8 (from 128).
> 
> Lovely. On my M2 Macbook air, I right now have about 24MB in the
> kmalloc-128 bucket, and most of it is presumably just 16 byte
> allocations (judging by my x86-64 slabinfo).
> 
> I guess it doesn't really matter when I have 16GB in the machine, but
> this has annoyed me for a while.
> 
> It feels like this is ready for 6.5, no?

From an implementation approach perspective, I definitely target 6.5.
But I need help with testing this, especially the iommu bits (can buy
Robin some beers ;)).

-- 
Catalin
