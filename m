Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABA728E8
	for <iommu@lists.linux.dev>; Mon,  7 Nov 2022 09:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30A8C433D6;
	Mon,  7 Nov 2022 09:38:15 +0000 (UTC)
Date: Mon, 7 Nov 2022 09:38:12 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Isaac Manjarres <isaacmanjarres@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 11/13] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <Y2jSBGvoJcVvuoAU@arm.com>
References: <20221106220143.2129263-1-catalin.marinas@arm.com>
 <20221106220143.2129263-12-catalin.marinas@arm.com>
 <Y2hr2gbucDzOYI5S@gondor.apana.org.au>
 <Y2jKQOG/oKGXwCaZ@arm.com>
 <Y2jMFeB4h2YwyOpb@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2jMFeB4h2YwyOpb@gondor.apana.org.au>

On Mon, Nov 07, 2022 at 05:12:53PM +0800, Herbert Xu wrote:
> On Mon, Nov 07, 2022 at 09:05:04AM +0000, Catalin Marinas wrote:
> > Well, it does ensure that the __alignof__ and sizeof structures like
> > crypto_alg and aead_request is still 128 after this change. A kmalloc()
> > of a size multiple of 128 returns a 128-byte aligned object. So the aim
> > is just to keep the current binary layout/alignment to 128 on arm64. In
> > theory, no functional change.
> 
> Changing CRYPTO_MINALIGN to 128 does not cause structures that are
> smaller than 128 bytes to magically become larger than 128 bytes.

For structures, it does (not arrays though):

#define __aligned(x)	__attribute__((__aligned__(x)))

struct align_test1 {
	char c;
	char __aligned(128) data[];
};

struct align_test2 {
	char c;
} __aligned(128);

char aligned_array[4] __aligned(128);

With the above, we have:

sizeof(align_test1) == 128; __alignof__(align_test1) == 128;
sizeof(align_test2) == 128; __alignof__(align_test2) == 128;
sizeof(align_array) == 4;   __alignof__(align_array) == 128;

> If you're set on doing it this way then I can proceed with the
> original patch-set to change the drivers.  I've just been putting
> it off because it seems that you guys weren't quite decided on
> which way to go.

Yes, reviving your patchset would help and that can be done
independently of this series as long as the crypto code starts using
dma_get_cache_alignment() and drops CRYPTO_MINALIGN_ATTR entirely. If at
the point of creating the mask the code knows whether the device is
coherent, it can even avoid any additional alignment (though still
honouring the cra_alignmask that a device requires). So such reworking
would be beneficial irrespective of this series.

It seems that swiotlb bouncing is the preferred route and least
intrusive but let's see the feedback on the other parts of the series.

Thanks.

-- 
Catalin
