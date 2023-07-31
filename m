Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BFE18C31
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 16:02:45 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4A06A67373; Mon, 31 Jul 2023 18:02:37 +0200 (CEST)
Date: Mon, 31 Jul 2023 18:02:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, hch@lst.de,
	m.szyprowski@samsung.com, robin.murphy@arm.com, paulmck@kernel.org,
	bp@suse.de, akpm@linux-foundation.org, peterz@infradead.org,
	rdunlap@infradead.org, kim.phillips@amd.com, rostedt@goodmis.org,
	thunder.leizhen@huawei.com, ardb@kernel.org, bhe@redhat.com,
	anshuman.khandual@arm.com, song.bao.hua@hisilicon.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH] dma-contiguous: support per-numa CMA for all
 architectures
Message-ID: <20230731160237.GA8904@lst.de>
References: <20230512094210.141540-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512094210.141540-1-yajun.deng@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied to the dma-mapping tree for 6.6.
