Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A1228E8
	for <iommu@lists.linux.dev>; Mon,  6 Feb 2023 11:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6p5UcUVJMB6FcC7LDxPnes2LOQaJUS8z6IEOS3X783s=; b=Ea7S5G84aDpNMvL/Suxi9XIvmP
	C3d8gqapGDHgOfKkaP3NfNlfpuswBdZ+/65aPGo8Ipfi4ygRk8xZ7E1lb+BYSVGzxaS2sN48Bj+uV
	7EcpbhbKtu3+Vy6v0rx38wmRy2zhh9BHTpbWgMb6B1VUojynlRhGLZwyBBeJ97ZTbSyUL+nN/9cdA
	g3KAlOkdL6bK9I8Ru0c8Xd4so95LlWcA9jGTKHdvLf99ddC9qSvsG4IxnKgYDCF/ShOfXC3/ZQNuz
	+ltBvaSkLaaFq/cirv5PAA/Jvc9EmJp6O0MLa9hEeS1tkPMdnYzaGXwcTfJ4KZOOty5sepN3i9T7J
	b/03MOXw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pOzbS-00Gi9E-Dh; Mon, 06 Feb 2023 11:24:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C110E30013F;
	Mon,  6 Feb 2023 12:24:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8C4252CFF4E16; Mon,  6 Feb 2023 12:24:00 +0100 (CET)
Date: Mon, 6 Feb 2023 12:24:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, dennis@kernel.org,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
	Heiko Carstens <hca@linux.ibm.com>, gor@linux.ibm.com,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	borntraeger@linux.ibm.com, Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
	suravee.suthikulpanit@amd.com, Robin Murphy <robin.murphy@arm.com>,
	dwmw2@infradead.org, Baolu Lu <baolu.lu@linux.intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, iommu@lists.linux.dev,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 05/10] percpu: Wire up cmpxchg128
Message-ID: <Y+DjULnIxcPU/rtp@hirez.programming.kicks-ass.net>
References: <20230202145030.223740842@infradead.org>
 <20230202152655.494373332@infradead.org>
 <24007667-1ff3-4c86-9c17-a361c3f9f072@app.fastmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24007667-1ff3-4c86-9c17-a361c3f9f072@app.fastmail.com>

On Fri, Feb 03, 2023 at 06:25:04PM +0100, Arnd Bergmann wrote:
> On Thu, Feb 2, 2023, at 15:50, Peter Zijlstra wrote:
> > In order to replace cmpxchg_double() with the newly minted
> > cmpxchg128() family of functions, wire it up in this_cpu_cmpxchg().
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> I commented on this in the previous version but never got any
> reply from you:
> 
> https://lore.kernel.org/all/1d88ba9f-5541-4b67-9cc8-a361eef36547@app.fastmail.com/

Sorry, seem to have missed that :/

> Unless I have misunderstood what you are doing, my concerns are
> still the same:
> 
> >  #define this_cpu_cmpxchg(pcp, oval, nval) \
> > -	__pcpu_size_call_return2(this_cpu_cmpxchg_, pcp, oval, nval)
> > +	__pcpu_size16_call_return2(this_cpu_cmpxchg_, pcp, oval, nval)
> >  #define this_cpu_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, 
> > nval2) \
> >  	__pcpu_double_call_return_bool(this_cpu_cmpxchg_double_, pcp1, pcp2, 
> > oval1, oval2, nval1, nval2)
> 
> Having a variable-length this_cpu_cmpxchg() that turns into cmpxchg128()
> and cmpxchg64() even on CPUs where this traps (!X86_FEATURE_CX16) seems
> like a bad design to me.
> 
> I would much prefer fixed-length this_cpu_cmpxchg64()/this_cpu_cmpxchg128()
> calls that never trap but fall back to the generic version on CPUs that
> are lacking the atomics.

You're thinking acidental usage etc..? Lemme see what I can do.
