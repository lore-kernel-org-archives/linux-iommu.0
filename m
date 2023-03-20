Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9719D1876
	for <iommu@lists.linux.dev>; Mon, 20 Mar 2023 13:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HwTdN3GBL4Kthfdvn83f/oC/vgkDbOjy8uf52YF/ONA=; b=z4+8PvzWgNfF3prAWk3ZA8V+61
	BjItwaE128uM4ETKSFEQ5GdJE2ACm6U2AC2N2pbzrL7BOndLExMSFaEX3IJiYAH01GVuHuwRwGgn2
	eTqyqDiV3lvnMS0c7yEZEeI1w2TcCveOcYpOyaKH9gdtV0GbItHaEl761WRUigJmguULxadcHyajr
	Y0A6BLGlNJttiGwP78SJjJemrKQEqYGtDbitbEsY4b8L2fFN+FFKHxsQ7berkFBBGp43Baqv4bSY0
	OHgOsSKuuLtSNUL7pJ24EJoCzsFEN0OFxt25qYxGFcuFt11Nn2bQoNZTxDTgJdA1sEkl3daG/D7/d
	5Cn35iSg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1peFfM-009CWS-2i;
	Mon, 20 Mar 2023 13:35:12 +0000
Date: Mon, 20 Mar 2023 06:35:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Fenghua Yu <fenghua.yu@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Vinod Koul <vkoul@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Alistair Popple <apopple@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>, iommu@lists.linux.dev
Subject: Re: [PATCH v2 08/16] iommu: define and export
 iommu_access_remote_vm()
Message-ID: <ZBhhEK1V+u2oV2Ll@infradead.org>
References: <20230306163138.587484-1-fenghua.yu@intel.com>
 <20230306163138.587484-9-fenghua.yu@intel.com>
 <f7b0cbef-3d7d-e5aa-1971-fe230d0c80e1@linux.intel.com>
 <932aebd3-c655-3266-1acb-e41e8cbfb771@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <932aebd3-c655-3266-1acb-e41e8cbfb771@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 07, 2023 at 09:55:28AM -0800, Fenghua Yu wrote:
> > 
> > I don't quite follow here. Isn't I/O page fault already supported?
> 
> The following patch 9 in this series explains in details why IDXD device
> cannot use page fault to write to user memory: https://lore.kernel.org/dmaengine/20230306163138.587484-10-fenghua.yu@intel.com/
> 
> "DSA supports page fault handling through PRS. However, the DMA engine
> that's processing the descriptor is blocked until the PRS response is
> received. Other workqueues sharing the engine are also blocked.
> Page fault handing by the driver with PRS disabled can be used to
> mitigate the stalling.
> 
> With PRS disabled while ATS remain enabled, DSA handles page faults on
> a completion record by reporting an event in the event log. In this
> instance, the descriptor is completed and the event log contains the
> completion record address and the contents of the completion record."

This seems like a completely broken I/O model, and I don't think Linux
should support this model when it requires operations like
access_remote_vm.
