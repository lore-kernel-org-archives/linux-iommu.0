Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A835A33C4
	for <iommu@lists.linux.dev>; Fri, 22 Jul 2022 15:21:20 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1BDBF68AFE; Fri, 22 Jul 2022 17:15:25 +0200 (CEST)
Date: Fri, 22 Jul 2022 17:15:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.garry@huawei.com>
Cc: jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
	damien.lemoal@opensource.wdc.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH] scsi: sd: Add a comment about limiting max_sectors to
 shost optimal limit
Message-ID: <20220722151524.GA8096@lst.de>
References: <1658224264-49972-1-git-send-email-john.garry@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658224264-49972-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks, applied.
