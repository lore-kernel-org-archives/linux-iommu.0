Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00127945A;
	Thu, 21 Dec 2023 04:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hKekoeAY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9fu9ycNjYnh+jMIffCCFUrHb5XSgNNhRHsHudZOD1U4=; b=hKekoeAYg/rDawz5RlczPsQxTw
	FbJT6TQ/p5XH1uX/o1xNv0G7RwUKs979dkcSf9bdh8J2O5Ndx6YwfkTRl0DgPUhrKo9+pDTHkbn/O
	BomJKJeDHCTiFPP5arVtnHQTwF55V060pPAjYwVtcT4Wo62YpeSK1DKMb9BSaiNpfwUn/uQnw/PY/
	d71QvyIk992VEnb1fbjUdMhlwUQFrEv/6o+ooZRLpFtS16cvZERfzA2k6zay9yrT+GJteQT4COUjO
	0tSA7ljvQDKMUK7eQhLODDSWWxnYyvr5nRpz5THDzpQ9TMs0ELWTP6UbEPs3/euDXKsl2ai0lk/68
	/GjocBuw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rGAU6-004eJy-UH; Thu, 21 Dec 2023 04:16:35 +0000
Date: Thu, 21 Dec 2023 04:16:34 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rientjes@google.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev
Subject: Re: [RFC 0/3] iommu/intel: Free empty page tables on unmaps
Message-ID: <ZYO8IqiHeqs8LktJ@casper.infradead.org>
References: <20231221031915.619337-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221031915.619337-1-pasha.tatashin@soleen.com>

On Thu, Dec 21, 2023 at 03:19:12AM +0000, Pasha Tatashin wrote:
> This series frees empty page tables on unmaps. It intends to be a
> low overhead feature.
> 
> The read-writer lock is used to synchronize page table, but most of
> time the lock is held is reader. It is held as a writer for short
> period of time when unmapping a page that is bigger than the current
> iova request. For all other cases this lock is read-only.
> 
> page->refcount is used in order to track number of entries at each page
> table.

Have I not put enough DANGER signs up around the page refcount?

 * If you want to use the refcount field, it must be used in such a way
 * that other CPUs temporarily incrementing and then decrementing the
 * refcount does not cause problems.  On receiving the page from
 * alloc_pages(), the refcount will be positive.

You can't use refcount for your purpose, and honestly I'm shocked you
haven't seen any of your WARNings trigger.
