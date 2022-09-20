Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E9310F9
	for <iommu@lists.linux.dev>; Tue, 20 Sep 2022 06:49:51 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id AE82868AFE; Tue, 20 Sep 2022 08:43:32 +0200 (CEST)
Date: Tue, 20 Sep 2022 08:43:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: refurbish SWIOTLB SUBSYSTEM sections
 after refactoring
Message-ID: <20220920064332.GA17325@lst.de>
References: <20220919084744.3043-1-lukas.bulwahn@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919084744.3043-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Sorry for coming up with this only now, but what about just dropping
the separate swiotlb entry entirely, and just add include/linux/swiotlb.h
to the dma-mapping entry?
