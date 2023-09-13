Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62D51DDD4
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 12:14:06 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8C3E868AA6; Wed, 13 Sep 2023 14:14:03 +0200 (CEST)
Date: Wed, 13 Sep 2023 14:14:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Petr Tesarik <petr@tesarici.cz>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] swiotlb: fix the check whether a device has used
 software IO TLB
Message-ID: <20230913121403.GB4544@lst.de>
References: <20230913114016.17752-1-petr@tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913114016.17752-1-petr@tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks, I've applied this to get it into linux-next ASAP.  I'd love
to have reviews before sending it on to Linus, though.
