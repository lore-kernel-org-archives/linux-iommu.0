Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775D07A
	for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 05:12:55 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8B49567373; Thu, 14 Jul 2022 07:12:48 +0200 (CEST)
Date: Thu, 14 Jul 2022 07:12:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev, Stephen Bates <sbates@raithlin.com>,
	Christoph Hellwig <hch@lst.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Minturn Dave B <dave.b.minturn@intel.com>,
	Jason Ekstrand <jason@jlekstrand.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Xiong Jianxin <jianxin.xiong@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH v8 01/13] lib/scatterlist: add flag for indicating
 P2PDMA segments in an SGL
Message-ID: <20220714051248.GA23381@lst.de>
References: <20220708165104.5005-1-logang@deltatee.com> <20220708165104.5005-2-logang@deltatee.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708165104.5005-2-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Do we need the dma_ prefix for the flags field?  That's just what it
is used for now.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

