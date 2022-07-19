Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CC07B
	for <iommu@lists.linux.dev>; Tue, 19 Jul 2022 07:10:35 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id D975368AA6; Tue, 19 Jul 2022 09:10:28 +0200 (CEST)
Date: Tue, 19 Jul 2022 09:10:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.garry@huawei.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>, joro@8bytes.org,
	will@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
	hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, iommu@lists.linux.dev,
	linux-scsi@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v6 4/6] scsi: sd: Allow max_sectors be capped at DMA
 optimal size limit
Message-ID: <20220719071028.GA28633@lst.de>
References: <1657797329-98541-1-git-send-email-john.garry@huawei.com> <1657797329-98541-5-git-send-email-john.garry@huawei.com> <6725df4f-4e27-3320-8b7b-22ba15a07866@opensource.wdc.com> <e3dbd78e-95fe-ea61-8bcf-45ea02de1647@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3dbd78e-95fe-ea61-8bcf-45ea02de1647@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 19, 2022 at 08:05:30AM +0100, John Garry wrote:
> Christoph has now applied this (thanks, BTW), so would you like me to 
> follow up with a patch on top with a comment?

Please do.
