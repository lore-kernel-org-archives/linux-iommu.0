Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED6FC2E4
	for <iommu@lists.linux.dev>; Mon, 15 May 2023 11:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pWvIuFmnhm9tAkw2SiaTeb6OI+NVYwgnGWSr09ytrtQ=; b=XQzam2wx7hHP7RKcZRsHHTh+jH
	fOcWTjjLz9sOejyH0FqoW80WIs0jMVUG77AOOWswDPnFfUVa3UjFbrAr1Aw5zGeKx35WPKGV5u8Gl
	kIePfBPRxizMWacykL+5vtb5kgaK4nrKj2r72XFapTzCoa35QvEX9yXe/bvTMNW6DGVTJ0DhGpfbY
	GqnAYl994cV1eBFrSQHZTZrWKZdvNWaqtPE+EDq/oRP8hAe9fcdG7tF8ORsU1eBc7yOfS/RYXW8Ju
	M3yarnHLcJCEiXEtMhmrq3L6cuCo34W8D4SFZYSPcAdU2xrGXSZtow+XKlSu6G2j+zh6bCqQBAsht
	SCghbpJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pyWgd-0021nL-1J;
	Mon, 15 May 2023 11:48:19 +0000
Date: Mon, 15 May 2023 04:48:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, iommu@lists.linux.dev,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 2/6] mm/gup: remove unused vmas parameter from
 pin_user_pages_remote()
Message-ID: <ZGIcA67XjL0M6ObY@infradead.org>
References: <cover.1684097001.git.lstoakes@gmail.com>
 <61f0d12058825a14feee6a3292e5a257662e719c.1684097002.git.lstoakes@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61f0d12058825a14feee6a3292e5a257662e719c.1684097002.git.lstoakes@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, May 14, 2023 at 10:26:47PM +0100, Lorenzo Stoakes wrote:
> No invocation of pin_user_pages_remote() uses the vmas parameter, so remove
> it. This forms part of a larger patch set eliminating the use of the vmas
> parameters altogether.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
