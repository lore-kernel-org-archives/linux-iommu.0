Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6487E
	for <iommu@lists.linux.dev>; Tue, 20 Dec 2022 04:16:48 +0000 (UTC)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1p7U2o-008kUH-8I; Tue, 20 Dec 2022 12:15:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 20 Dec 2022 12:15:58 +0800
Date: Tue, 20 Dec 2022 12:15:58 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Peter Zijlstra <peterz@infradead.org>,
	torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
	boqun.feng@gmail.com, mark.rutland@arm.com, catalin.marinas@arm.com,
	dennis@kernel.org, tj@kernel.org, cl@linux.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com,
	Arnd Bergmann <arnd@arndb.de>, penberg@kernel.org,
	rientjes@google.com, iamjoonsoo.kim@lge.com,
	Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-s390@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
	linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH 01/12] crypto: Remove u128 usage
Message-ID: <Y6E2/tJ9NwjpKOVM@gondor.apana.org.au>
References: <20221219153525.632521981@infradead.org>
 <20221219154118.889543494@infradead.org>
 <Y6CJsWBhcbKatZNg@zx2c4.com>
 <Y6CYu4skFFMopU+g@hirez.programming.kicks-ass.net>
 <CAHmME9oCBgNCfYFxirA-fdarGip5MvOG-iUxT=2HC=iSXRMH-Q@mail.gmail.com>
 <Y6ExF8mchgYiiRB0@gondor.apana.org.au>
 <7C23FA3C-A967-4BAE-970B-5E6FAF4DE037@zytor.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7C23FA3C-A967-4BAE-970B-5E6FAF4DE037@zytor.com>

On Mon, Dec 19, 2022 at 08:11:37PM -0800, H. Peter Anvin wrote:
>
> Seems like "merging common code snippets" is something we at least used to do with single patches...

I certainly don't have any objections if we go down this route.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
