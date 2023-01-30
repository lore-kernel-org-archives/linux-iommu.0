Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAB6644
	for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 06:46:06 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9D63C68C4E; Mon, 30 Jan 2023 07:45:57 +0100 (CET)
Date: Mon, 30 Jan 2023 07:45:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, hch@lst.de, jgg@nvidia.com,
	baolu.lu@linux.intel.com, rafael.j.wysocki@intel.com,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 0/8] iommu: The early demise of bus ops
Message-ID: <20230130064557.GA31834@lst.de>
References: <cover.1674753627.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674753627.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

The whole series looks good to me:

Acked-by: Christoph Hellwig <hch@lst.de>
