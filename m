Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F41017C3
	for <iommu@lists.linux.dev>; Wed, 13 Jul 2022 06:02:57 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6D6BB68AFE; Wed, 13 Jul 2022 08:02:46 +0200 (CEST)
Date: Wed, 13 Jul 2022 08:02:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tianyu Lan <ltykernel@gmail.com>
Cc: kernel test robot <oliver.sang@intel.com>,
	Tianyu Lan <Tianyu.Lan@microsoft.com>,
	Christoph Hellwig <hch@lst.de>, linux-doc@vger.kernel.org,
	iommu@lists.linux.dev, lkp@lists.01.org, lkp@intel.com
Subject: Re: [EXTERNAL] [swiotlb] 44d89f2248:
 Kernel_panic-not_syncing:swiotlb_init_remap:nslabs=#too_small
Message-ID: <20220713060246.GA13497@lst.de>
References: <Ys43FtIumAsHPn+y@xsang-OptiPlex-9020> <c8edfbd4-afad-c018-daf6-aa2ac1f7b2fe@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8edfbd4-afad-c018-daf6-aa2ac1f7b2fe@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 13, 2022 at 01:58:38PM +0800, Tianyu Lan wrote:
> Thanks for report. The issue is caused by auto merging between
> commit44d89f("swiotlb: split up the global swiotlb lock") and commit 
> 0bf28fc40(swiotlb: panic if nslabs is too small). nslab is checked before 
> initialization.
>
> Christoph, do you prefer to update patch "swiotlb: split up the global 
> swiotlb lock" or append a fix patch on current brand?

Please just send a patch againt the current tree.  I'll see if squashing
it in makes any sense.
