Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0126715A8
	for <iommu@lists.linux.dev>; Mon,  9 Jan 2023 16:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o2/WdWh0APeupuPh7RKLqwpzddI4XMgnRH0Srb3bBA8=; b=JVVg5ZiQ5EwX/bJmzcBrm5hQRZ
	/FzNMH+VKS9Uj+oKG55AthoXByc4rsJne2KzG8AGcjMmoP5h0WqErzYgDSN+WUQKzncqgpwuFs1+7
	1M6D1dFOaXVUOKeggVpP3UtCWrl5p5Ztj2Lj80rGwv2HxiXqq7hDuP/8BUHSrJZWBfuL6Q1X4nx1p
	RS1CDqZNoCvrBjNAChCc1uvqKPHUBlUFMKbqG3LtFI8xHtSyffujWEPx/nzLx/hEe5qaX301iKJnv
	lPtarK9OheMMBqEx+eJIz+xyn512CYwoPVvUtrlL1KlwNB/M9NxcRuX/KVZUMniyhSoP3acYxTdvd
	rpTqYc0Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEv2H-002QqF-Eb; Mon, 09 Jan 2023 16:30:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 13FAA3001E5;
	Mon,  9 Jan 2023 17:29:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 02FBF20086EAB; Mon,  9 Jan 2023 17:29:56 +0100 (CET)
Date: Mon, 9 Jan 2023 17:29:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
	boqun.feng@gmail.com, mark.rutland@arm.com, catalin.marinas@arm.com,
	dennis@kernel.org, tj@kernel.org, cl@linux.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>,
	davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	Arnd Bergmann <arnd@arndb.de>, penberg@kernel.org,
	rientjes@google.com, iamjoonsoo.kim@lge.com,
	Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-s390@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
	linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH 07/12] percpu: Wire up cmpxchg128
Message-ID: <Y7xBA35m6DboB2C7@hirez.programming.kicks-ass.net>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.286760562@infradead.org>
 <Y7VsbM4ada2KkAdx@osiris>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7VsbM4ada2KkAdx@osiris>

On Wed, Jan 04, 2023 at 01:09:16PM +0100, Heiko Carstens wrote:
> On Mon, Dec 19, 2022 at 04:35:32PM +0100, Peter Zijlstra wrote:
> > In order to replace cmpxchg_double() with the newly minted
> > cmpxchg128() family of functions, wire it up in this_cpu_cmpxchg().
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ...
> > --- a/arch/s390/include/asm/percpu.h
> > +++ b/arch/s390/include/asm/percpu.h
> > +#define this_cpu_cmpxchg_16(pcp, oval, nval)				\
> > +({									\
> > +	u128 old__ = __pcpu_cast_128((nval), (nval));			\
> > +	u128 new__ = __pcpu_cast_128((oval), (oval));			\
> 
> spot the bug... please merge the below into this patch.

D'oh, luckily I got a fresh pile of brown paper bags for xmas.
