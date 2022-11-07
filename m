Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70CA15A9
	for <iommu@lists.linux.dev>; Mon,  7 Nov 2022 02:51:43 +0000 (UTC)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1orrld-00AtFK-MB; Mon, 07 Nov 2022 10:22:19 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 07 Nov 2022 10:22:18 +0800
Date: Mon, 7 Nov 2022 10:22:18 +0800
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
Message-ID: <Y2hr2gbucDzOYI5S@gondor.apana.org.au>
References: <20221106220143.2129263-1-catalin.marinas@arm.com>
 <20221106220143.2129263-12-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221106220143.2129263-12-catalin.marinas@arm.com>

On Sun, Nov 06, 2022 at 10:01:41PM +0000, Catalin Marinas wrote:
> ARCH_DMA_MINALIGN represents the minimum (static) alignment for safe DMA
> operations while ARCH_KMALLOC_MINALIGN is the minimum kmalloc()
> alignment. This will ensure that the static alignment of various
> structures or members of those structures( e.g. __ctx[] in struct
> aead_request) is safe for DMA. Note that sizeof such structures becomes
> aligned to ARCH_DMA_MINALIGN and kmalloc() will honour such alignment,
> so there is no confusion for the compiler.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> ---
> 
> I know Herbert NAK'ed this patch but I'm still keeping it here
> temporarily, until we agree on some refactoring at the crypto code. FTR,
> I don't think there's anything wrong with this patch since kmalloc()
> will return ARCH_DMA_MINALIGN-aligned objects if the sizeof such objects
> is a multiple of ARCH_DMA_MINALIGN (side-effect of
> CRYPTO_MINALIGN_ATTR).

As I said before changing CRYPTO_MINALIGN doesn't do anything and
that's why this patch is broken.

To get what you want the drivers have to be modified.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
