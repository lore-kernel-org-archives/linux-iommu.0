Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E8419BB0
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 16:02:57 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id CF8A568AA6; Mon, 31 Jul 2023 18:02:53 +0200 (CEST)
Date: Mon, 31 Jul 2023 18:02:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: corbet@lwn.net, hch@lst.de, m.szyprowski@samsung.com,
	robin.murphy@arm.com, akpm@linux-foundation.org, paulmck@kernel.org,
	catalin.marinas@arm.com, rdunlap@infradead.org,
	peterz@infradead.org, rostedt@goodmis.org, kim.phillips@amd.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v3] dma-contiguous: support numa CMA for specified node
Message-ID: <20230731160253.GA8931@lst.de>
References: <20230712074758.1133272-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712074758.1133272-1-yajun.deng@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied to the dma-mapping tree for 6.6.
