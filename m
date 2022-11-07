Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF3628E8
	for <iommu@lists.linux.dev>; Mon,  7 Nov 2022 09:13:23 +0000 (UTC)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1oryAz-00AywG-AF; Mon, 07 Nov 2022 17:12:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 07 Nov 2022 17:12:53 +0800
Date: Mon, 7 Nov 2022 17:12:53 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Catalin Marinas <catalin.marinas@arm.com>
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
Message-ID: <Y2jMFeB4h2YwyOpb@gondor.apana.org.au>
References: <20221106220143.2129263-1-catalin.marinas@arm.com>
 <20221106220143.2129263-12-catalin.marinas@arm.com>
 <Y2hr2gbucDzOYI5S@gondor.apana.org.au>
 <Y2jKQOG/oKGXwCaZ@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2jKQOG/oKGXwCaZ@arm.com>

On Mon, Nov 07, 2022 at 09:05:04AM +0000, Catalin Marinas wrote:
>
> Well, it does ensure that the __alignof__ and sizeof structures like
> crypto_alg and aead_request is still 128 after this change. A kmalloc()
> of a size multiple of 128 returns a 128-byte aligned object. So the aim
> is just to keep the current binary layout/alignment to 128 on arm64. In
> theory, no functional change.

Changing CRYPTO_MINALIGN to 128 does not cause structures that are
smaller than 128 bytes to magically become larger than 128 bytes.
All it does is declare to the compiler that it may assume that
these pointers are 128-byte aligned (which is obviously untrue
if kmalloc does not guarantee that).

So I don't see how this changes anything in practice.  Buffers
that required bouncing prior to your change will still require
bouncing.

If you're set on doing it this way then I can proceed with the
original patch-set to change the drivers.  I've just been putting
it off because it seems that you guys weren't quite decided on
which way to go.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
