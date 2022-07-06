Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884284A3E
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 13:44:52 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 81CAF68AA6; Wed,  6 Jul 2022 15:44:47 +0200 (CEST)
Date: Wed, 6 Jul 2022 15:44:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.garry@huawei.com>
Cc: damien.lemoal@opensource.wdc.com, joro@8bytes.org, will@kernel.org,
	jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
	m.szyprowski@samsung.com, robin.murphy@arm.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev, linux-scsi@vger.kernel.org,
	linuxarm@huawei.com
Subject: Re: [PATCH v5 0/5] DMA mapping changes for SCSI core
Message-ID: <20220706134447.GA23753@lst.de>
References: <1656590892-42307-1-git-send-email-john.garry@huawei.com> <b5f80062-e8ef-9597-1b0c-393140950dfb@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5f80062-e8ef-9597-1b0c-393140950dfb@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID: <20220706134447.aNMi6kv5cb-QPwOrGdFESmRF3OXW3xF8vbRoyup4yAw@z>

On Wed, Jul 06, 2022 at 02:40:44PM +0100, John Garry wrote:
> On 30/06/2022 13:08, John Garry wrote:
>
> Hi Christoph,
>
> Can you please consider picking up this series? A few things to note 
> beforehand:
>
> - I changed to only apply the mapping limit to SAS hosts in this version. I 
> would need a fresh ack from Martin for those SCSI parts, but wanted to make 
> sure you were ok with it.

Yes, I've mostly been waiting for an ACK from Martin.

> - Damien had some doubt on updating the shost max_sectors as opposed to the 
> per-request queue default, but I think he's ok with it - see patch 4/5

I'm fine either way.
