Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706703;
	b=dW+kCEMj+HL6uNpQ+rtikStYV+fjqNdu4qG+Dtq95zvzb2Mq/gt4v+b+mWI3wo3uO5W0
	 iayUhUibxykqVNpwXH1B+um6TDqZEbdiARZ3uLdnEvVYFUcInpGWgSVMsjS5pdv6ZR/5k
	 m5M5rat3pJ/+uQR5Ua8wj/6oGDkIy8cq2xOv9AXCoNYP8j1BG3xnlNLwWPmMh7nnB53mW
	 8Siqwt0zYAuY0vDJN2kyTvfBe0too8mpzV61HgTP1x/twkqYC2J8Mlvzl2FzkH2W4qbNB
	 i2disK7qQ6OrQPrJYI70JYTPzHhfvXU4StisiCwW7Pt1FBzqPB8n6GwRKHBMD9R2DJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706703;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WaGhGP18N1e5WQjSL7Kf13XBuOe/Lyl+VKElqyiI+RE=;
	b=0enFW7IKqs0LYHmyI+V9Mx/hvsKqiMijRN7DCuPvluppPFodCe7Xdo4D/48xaptK4Kyr
	 B8aEj0qq7SsWDuypYv708pCdSR32TFJH+T/HFkWSK+73BgBudTxqSYG37TA/YP5MHj/t4
	 rIOF2yZy50aQeXpUrK8OpxOLqXKn8ec1pqF7Lo9r1Mf0ZPEYMmAl1Z9Etp+a1h1VDCsfz
	 5Y1ljFCajZo4sY0gIOEVgZ57EZTO1grZOZ2sfB2Z3UtigDqR3je4CvTGaat71R/awLT4F
	 haJJoMpygu1LMzJD5r1eijZcwGiGXQIo+oQ9J+sovdyM9wWIsQv56JCotVO8qM+dRVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dVVGBgUe;
	arc=none smtp.remote-ip=91.218.175.232
Received: from mta0.migadu.com (out-232.mta0.migadu.com [91.218.175.232])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE95606A333
	for <iommu@lists.linux.dev>; Thu, 26 Nov 2026 15:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDE95606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dVVGBgUe
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=e8n4p5I4AJEqksbOANyj0Uvx8iI2baqGaT4jyvFlF3s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795706700; v=1; x=1796311500;
 b=dVVGBgUe9owodYdGtln7dPUN0WIk3zQGtK7GCZTw6lfdipbYqFHMw0LFhVZI8JKiHj+WsVSd
 rbidA0agbBLiw9bFTKrdjACzbkA/wZ3FPqDUSunPEUSfUSar+tGgjt4oTqTDIZE0KadgDSWuLpd
 BbL4GL+aNZDp2IMQHMncHFDg=
X-Envelope-To: iommu@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id e28c61dcd929e842;
	Thu, 26 Nov 2026 15:24:58 +0000
X-Mizu-Trace-ID: e28c61dcd929e842
X-Migadu-Flow: FLOW_OUT
Date: Thu, 26 Nov 2026 07:24:42 -0800
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Harry Yoo (Meta)" <harry@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Muchun Song <muchun.song@linux.dev>, Hao Ge <hao.ge@linux.dev>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, "Liam R. Howlett" <liam@infradead.org>, 
	Alice Ryhl <aliceryhl@google.com>, Andrew Ballance <andrewjballance@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Amir Goldstein <amir73il@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Eric Dumazet <edumazet@kernel.org>, maple-tree@lists.infradead.org, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Mina Almasry <almasrymina@google.com>, 
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, linux-arm-kernel@lists.infradead.org, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, iommu@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-sunxi@lists.linux.dev, linux-um@lists.infradead.org, 
	cgroups@vger.kernel.org
Subject: Re: [PATCH slab/for-next v2 00/14] mm/slab: mandate SLAB_MAY_ACCOUNT
 for __GFP_ACCOUNT allocations to avoid wasting memory for slab metadata
Message-ID: <20261126152250.GB738059@shakeel.butt@linux.dev>
References: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>

On Wed, Nov 25, 2026 at 09:37:01PM +0000, Harry Yoo (Meta) wrote:
> TL;DR
> -----
> 
> The purpose of this series is to convert existing slab users that
> specify __GFP_ACCOUNT on allocations to specify SLAB_MAY_ACCOUNT on
> cache creation, to reduce memory waste for slab metadata with
> CONFIG_MEMCG=y && CONFIG_MEM_ALLOC_PROFILING=y.
> 
[...]
> 
> Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>

For the series:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

