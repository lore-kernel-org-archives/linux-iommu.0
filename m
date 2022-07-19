Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE4410E9
	for <iommu@lists.linux.dev>; Tue, 19 Jul 2022 09:17:31 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id CDE1E68AA6; Tue, 19 Jul 2022 11:17:26 +0200 (CEST)
Date: Tue, 19 Jul 2022 11:17:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.garry@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>, joro@8bytes.org,
	will@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, iommu@lists.linux.dev,
	linux-scsi@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v6 4/6] scsi: sd: Allow max_sectors be capped at DMA
 optimal size limit
Message-ID: <20220719091726.GA30468@lst.de>
References: <1657797329-98541-1-git-send-email-john.garry@huawei.com> <1657797329-98541-5-git-send-email-john.garry@huawei.com> <6725df4f-4e27-3320-8b7b-22ba15a07866@opensource.wdc.com> <e3dbd78e-95fe-ea61-8bcf-45ea02de1647@huawei.com> <20220719071028.GA28633@lst.de> <1f523333-1de5-2a09-0476-298edcbba413@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f523333-1de5-2a09-0476-298edcbba413@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 19, 2022 at 10:10:22AM +0100, John Garry wrote:
> Just saying in case it's an issue - I was looking at 
> http://git.infradead.org/users/hch/dma-mapping.git/log/refs/heads/for-next 
> and the order is not the same as this series and would cause an 
> intermediate build breakage at 9f5ec52ae501 ("scsi: scsi_transport_sas: cap 
> shost opt_sectors according to DMA optimal limit")

No idea what git-am did there, I've fixed it up now.
