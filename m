Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1AC63D4
	for <iommu@lists.linux.dev>; Mon, 19 Dec 2022 17:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AoHsdXMGtwYoivDhVzS8Gq7Q9pcIfze83OdOHhDQbg8=; b=eUjaapgCBm8IxeFah4OJ2c3/Gl
	HBpuz5Hc/VGKJoE4PzptLz+cPQR9Xt79XOnii253NhACRZCZyFsdYBtw/dUP0vNtUyQrrLnz8eK0H
	pDahAmGnkSiSzlfmiR+YfDMQuDK9uqwJ5svoOU0m50n0azB/jkZmVxAPOENcE0hxmwwHiQ697SFtL
	GMS8KKr/SzrKgE2+lD9tHsYu7O6r5oRKLBoEWTZJ7luxQeSC7JoIukZksM+c11hwKokzR8DMCWrzY
	64LKnvuoRISfjz3PCJNJlBnRf3VPpqu+IdfGzNxa5a9rJkb28NicDPnkjPvSN9aPTgWpLoEG9Bl0T
	ajTbWNPA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1p7JVP-00CfUx-2C;
	Mon, 19 Dec 2022 17:00:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 586D230006D;
	Mon, 19 Dec 2022 18:00:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0695F20B13018; Mon, 19 Dec 2022 18:00:44 +0100 (CET)
Date: Mon, 19 Dec 2022 18:00:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
	boqun.feng@gmail.com, mark.rutland@arm.com, catalin.marinas@arm.com,
	dennis@kernel.org, tj@kernel.org, cl@linux.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com,
	Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	Arnd Bergmann <arnd@arndb.de>, penberg@kernel.org,
	rientjes@google.com, iamjoonsoo.kim@lge.com,
	Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-s390@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
	linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH 01/12] crypto: Remove u128 usage
Message-ID: <Y6CYu4skFFMopU+g@hirez.programming.kicks-ass.net>
References: <20221219153525.632521981@infradead.org>
 <20221219154118.889543494@infradead.org>
 <Y6CJsWBhcbKatZNg@zx2c4.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6CJsWBhcbKatZNg@zx2c4.com>

On Mon, Dec 19, 2022 at 04:56:33PM +0100, Jason A. Donenfeld wrote:

> Why not just use `u128` from types.h in this file?

Ordering, I can't very well introduce it in types.h while other
definitions exist in the tree. So I first have to clean up the u128
namespace.
