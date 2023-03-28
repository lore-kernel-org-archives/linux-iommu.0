Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1EA7E6
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 01:37:14 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1B85368BEB; Tue, 28 Mar 2023 03:37:11 +0200 (CEST)
Date: Tue, 28 Mar 2023 03:37:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Desnes Nunes <desnesn@redhat.com>
Cc: iommu@lists.linux.dev, linux-scsi@vger.kernel.org,
	storagedev@microchip.com, linux-kernel@vger.kernel.org, hch@lst.de,
	martin.petersen@oracle.com, don.brace@microchip.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com, jejb@linux.ibm.com,
	jsnitsel@redhat.com
Subject: Re: [PATCH v2 0/3] scsi: smartpqi: fix DMA overlapping mappings
 asymmetry
Message-ID: <20230328013710.GA22672@lst.de>
References: <20230316140912.1038404-1-desnesn@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316140912.1038404-1-desnesn@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)


Thanks,

I've applied patches 1 and 2 to the dma mapping tree.  You might want
to resent patch 1 to the scsi maintainers and list to better get it
onto their radar.
