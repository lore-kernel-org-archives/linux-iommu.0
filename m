Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8277E
	for <iommu@lists.linux.dev>; Tue, 20 Dec 2022 03:52:10 +0000 (UTC)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1p7TeR-008kBl-SS; Tue, 20 Dec 2022 11:50:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 20 Dec 2022 11:50:47 +0800
Date: Tue, 20 Dec 2022 11:50:47 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Peter Zijlstra <peterz@infradead.org>, torvalds@linux-foundation.org,
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
	linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
	linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH 01/12] crypto: Remove u128 usage
Message-ID: <Y6ExF8mchgYiiRB0@gondor.apana.org.au>
References: <20221219153525.632521981@infradead.org>
 <20221219154118.889543494@infradead.org>
 <Y6CJsWBhcbKatZNg@zx2c4.com>
 <Y6CYu4skFFMopU+g@hirez.programming.kicks-ass.net>
 <CAHmME9oCBgNCfYFxirA-fdarGip5MvOG-iUxT=2HC=iSXRMH-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9oCBgNCfYFxirA-fdarGip5MvOG-iUxT=2HC=iSXRMH-Q@mail.gmail.com>

On Mon, Dec 19, 2022 at 06:03:04PM +0100, Jason A. Donenfeld wrote:
>
> Is there a patch at the end of the series that adds it back in to use u128?

Could we do some ifdef trickery to reduce the amount of code churn
please? Changing everything away from u128 and then back to it seems
silly.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
