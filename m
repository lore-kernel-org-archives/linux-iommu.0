Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA377FA
	for <iommu@lists.linux.dev>; Mon, 22 Aug 2022 11:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YNVjeYI2nPEVx61J8iSfNtxwDJBnDqCx6z5D+BwBZZw=; b=Jxf1IV4W3/EzX0MGWvdwzKDwng
	zPOG5m4IJYNsD2JWFxqyawSMhMglPzWldAw8JvaWuMCTOIZx94xvPb3myseWMOu3j8R3cit3OzagE
	vatWXcsl+50NPOi8T9KpySW1c51HGPDIc1Z56HCE3OJ1Ss5FPzoE9GVZVpio+DJu95/CzS7Vwt9k2
	e7lsG9nJrcxAIxTrF7GOJVXlNrWq9yT7Bgg0ZO4Hn6grEnJwG85/yma7sYSN/nJP3d/5wZK6Hh0Gn
	tKiPrpfOkmdaU4hLU6l92zv4L8xF5tLZMAX+3/nCbjLM9xZ0UZ4WXv/rH3P7C2eplPa8v37jlP0nD
	+Z4iNrDQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQ5QT-0083BY-TY; Mon, 22 Aug 2022 11:17:02 +0000
Date: Mon, 22 Aug 2022 04:17:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chao Gao <chao.gao@intel.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, hch@infradead.org, m.szyprowski@samsung.com,
	robin.murphy@arm.com, jxgao@google.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v2] swiotlb: avoid potential left shift overflow
Message-ID: <YwNlrVUYAC/pDmYX@infradead.org>
References: <20220819084537.52374-1-chao.gao@intel.com>
 <38c58aa0-11c7-f553-95fd-292fd4944a75@oracle.com>
 <YwA8DttmM7wgYuHv@gao-cwp>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwA8DttmM7wgYuHv@gao-cwp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Aug 20, 2022 at 09:42:38AM +0800, Chao Gao wrote:
> In an internal effort to measure the impact of swiotlb size to IO
> performance of confidential VM (e.g., TDX VM), we simply added
> SWIOTLB_ANY to the default io_tlb_mem to lift the restriction on swiotlb
> size. Then we hit this issue and worked out this fix. I posted this
> fix because I think the fix by itself is helpful because it removes the
> implicit dependency of the left-shift in slot_addr() on swiotlb size and
> then someone trying to lift the size limitation won't hit the same issue.

SWIOTLB_ANY is used for real, so I think this is a legitimate fix.
I'll apply it.
