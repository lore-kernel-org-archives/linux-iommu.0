Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE371FA5
	for <iommu@lists.linux.dev>; Mon, 12 Jun 2023 07:48:01 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id BE4E368BFE; Mon, 12 Jun 2023 09:47:55 +0200 (CEST)
Date: Mon, 12 Jun 2023 09:47:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tomonori Fujita <tomonori.fujita@ntt.com>
Cc: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Isaac Manjarres <isaacmanjarres@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v6 00/17] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN
 to 8
Message-ID: <20230612074755.GA24234@lst.de>
References: <20230531154836.1366225-1-catalin.marinas@arm.com> <CABfwK12_wC1t5J9c8qRmUi9H4GtYc6KR9oeJPi8ucK36prhUzQ@mail.gmail.com> <CAMj1kXHP_57EOOYQtuL2NO9=7sHPxrX=c0ayYwHaYx9x9hxhJw@mail.gmail.com> <ZIJISbauzCR/oKby@google.com> <20230609101156.6f17e3c6@meshulam.tesarici.cz> <TYWPR01MB101127656AB0A0D5DB1FF4CB3F354A@TYWPR01MB10112.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYWPR01MB101127656AB0A0D5DB1FF4CB3F354A@TYWPR01MB10112.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 12, 2023 at 07:44:46AM +0000, Tomonori Fujita wrote:
> I cannot recall the patch but from quick look, moving trace_swiotlb_bounced() to
> swiotlb_tbl_map_single() makes sense.

Agreed.
