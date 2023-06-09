Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5118F76
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 08:12:05 +0000 (UTC)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id C7DBB16965A;
	Fri,  9 Jun 2023 10:11:56 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1686298317; bh=hZfrcwcxHoyRa5wqyYqCGUTJUrze6YAm/fimj/PnGkc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=11LODvHIZXX438UC905uhWdeYSYnSaBwWC1C3JeTEWrwMES7jzmGLA2yl6TLdyajR
	 1uEkwLsW3k6HHY7h8c4eUk7sJ69NGbp5vNT3Vl6N3ahZ0ms7VgpsaBGi2yci/o5N/8
	 LU3Tdh0TSdTic8Txb4Sdoq9uDFtUZ5d2x5XuQ6wBEaI21pKfONYDaoNZv2o7MlPDnr
	 wHmx26NHQi18vxwwSis5VYN7bY1i20LdObSRRRNfab/BdF/hog0dOow5AgRPf71k/z
	 rghGRLVjvTYvbn7Hh2BiyktIJFqH6DmX/Vvr5Sr9jbsNHc8WDug322OQXVv+m3nYc6
	 A3i4lL2SouHqw==
Date: Fri, 9 Jun 2023 10:11:56 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Isaac Manjarres <isaacmanjarres@google.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Arnd
 Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 Saravana Kannan <saravanak@google.com>, Alasdair Kergon <agk@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>, Mark Brown
 <broonie@kernel.org>, Mike Snitzer <snitzer@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 linux-mm@kvack.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, FUJITA Tomonori
 <fujita.tomonori@lab.ntt.co.jp>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>
Subject: Re: [PATCH v6 00/17] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN
 to 8
Message-ID: <20230609101156.6f17e3c6@meshulam.tesarici.cz>
In-Reply-To: <ZIJISbauzCR/oKby@google.com>
References: <20230531154836.1366225-1-catalin.marinas@arm.com>
	<CABfwK12_wC1t5J9c8qRmUi9H4GtYc6KR9oeJPi8ucK36prhUzQ@mail.gmail.com>
	<CAMj1kXHP_57EOOYQtuL2NO9=7sHPxrX=c0ayYwHaYx9x9hxhJw@mail.gmail.com>
	<ZIJISbauzCR/oKby@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Jun 2023 14:29:45 -0700
Isaac Manjarres <isaacmanjarres@google.com> wrote:

>[...]
> P.S. I noticed that the trace_swiotlb_bounced() tracepoint may not be
> invoked even though bouncing occurs. For example, in the dma-iommu path,
> swiotlb_tbl_map_single() is called when bouncing, instead of
> swiotlb_map(), which is what ends up calling trace_swiotlb_bounced().
> 
> Would it make sense to move the call to trace_swiotlb_bounced() to
> swiotlb_tbl_map_single() since that function is always invoked?

Definitely, if you ask me. I believe the change was merely forgotten in
commit eb605a5754d0 ("swiotlb: add swiotlb_tbl_map_single library
function").

Let me take the author into Cc. Plus Konrad, who built further on that
commit, may also have an opinion.

Petr T
