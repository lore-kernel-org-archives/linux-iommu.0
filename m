Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398307E
	for <iommu@lists.linux.dev>; Fri, 30 Dec 2022 09:38:20 +0000 (UTC)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1pBBUj-00CILa-7B; Fri, 30 Dec 2022 17:16:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 Dec 2022 17:16:05 +0800
Date: Fri, 30 Dec 2022 17:16:05 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
	corbet@lwn.net, will@kernel.org, boqun.feng@gmail.com,
	mark.rutland@arm.com, catalin.marinas@arm.com, dennis@kernel.org,
	tj@kernel.org, cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, davem@davemloft.net, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com,
	Arnd Bergmann <arnd@arndb.de>, penberg@kernel.org,
	rientjes@google.com, iamjoonsoo.kim@lge.com,
	Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-s390@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/3] crypto: x86/ghash - add comment and fix broken link
Message-ID: <Y66sVbBVtYu8Jll5@gondor.apana.org.au>
References: <20221220054042.188537-1-ebiggers@kernel.org>
 <20221220054042.188537-4-ebiggers@kernel.org>
 <Y6GJzD9PLKj+Ocr2@hirez.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6GJzD9PLKj+Ocr2@hirez.programming.kicks-ass.net>

On Tue, Dec 20, 2022 at 11:09:16AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 19, 2022 at 09:40:42PM -0800, Eric Biggers wrote:
>
> > - * http://software.intel.com/en-us/articles/carry-less-multiplication-and-its-usage-for-computing-the-gcm-mode/
> > + * https://www.intel.com/content/dam/develop/external/us/en/documents/clmul-wp-rev-2-02-2014-04-20.pdf
> 
> Since these things have a habbit if changing, we tend to prefer to host
> a copy on kernel.org somewhere (used to be bugzilla, but perhaps there's
> a better places these days).

Alternatively just save a copy at web.archive.org when you submit
the patch and use that link.  In fact it seems that the original
link is still available via web.archive.org (sans pictures).

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
