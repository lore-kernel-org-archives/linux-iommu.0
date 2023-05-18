Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FC2F9D5
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 18:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AFEC433D2;
	Thu, 18 May 2023 18:50:32 +0000 (UTC)
Date: Thu, 18 May 2023 19:50:30 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
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
Message-ID: <ZGZzdg+U2XY95xIH@arm.com>
References: <20230518173403.1150549-1-catalin.marinas@arm.com>
 <CAHk-=wgm77p42Ow87pZf042+s5aC4S0N4TEPHQnrEyeg-aKtpg@mail.gmail.com>
 <CAMj1kXE+LvjV2fnTg=DHP2ynaqaPtj-YKKC1y1YS4Jf_DOCL3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXE+LvjV2fnTg=DHP2ynaqaPtj-YKKC1y1YS4Jf_DOCL3A@mail.gmail.com>

On Thu, May 18, 2023 at 08:13:08PM +0200, Ard Biesheuvel wrote:
> On Thu, 18 May 2023 at 19:56, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, May 18, 2023 at 10:34 AM Catalin Marinas
> > <catalin.marinas@arm.com> wrote:
> > >
> > > That's the fourth version of the series reducing the kmalloc() minimum
> > > alignment on arm64 to 8 (from 128).
> 
> For the series:
> 
> Tested-by: Ard Biesheuvel <ardb@kernel.org> # tx2
[...]
> The box is fully DMA coherent, of course, so this doesn't really tell
> us whether the swiotlb DMA bouncing stuff works or not.

Thanks.

On TX2, I forced the bouncing with:

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 43bf50c35e14..9006bf680db0 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -296,7 +296,7 @@ static inline bool dma_kmalloc_safe(struct device *dev,
	 * is coherent or the direction is DMA_TO_DEVICE (non-desctructive
	 * cache maintenance and benign cache line evictions).
	 */
-	if (dev_is_dma_coherent(dev) || dir == DMA_TO_DEVICE)
+	if (/*dev_is_dma_coherent(dev) || */dir == DMA_TO_DEVICE)
		return true;
 
	return false;

-- 
Catalin
