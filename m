Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6520817E3
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 03:41:47 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 47E8868BEB; Tue, 11 Apr 2023 05:41:37 +0200 (CEST)
Date: Tue, 11 Apr 2023 05:41:37 +0200
From: "hch@lst.de" <hch@lst.de>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	"hch@lst.de" <hch@lst.de>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	Dexuan Cui <decui@microsoft.com>,
	Tianyu Lan <Tianyu.Lan@microsoft.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] swiotlb: Track and report io_tlb_used high
 water mark in debugfs
Message-ID: <20230411034137.GB15679@lst.de>
References: <1680324300-124563-1-git-send-email-mikelley@microsoft.com> <20230407125535.476350d4@meshulam.tesarici.cz> <BYAPR21MB168877F6B7BF005B91F9E8CED7969@BYAPR21MB1688.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB168877F6B7BF005B91F9E8CED7969@BYAPR21MB1688.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 07, 2023 at 10:05:26PM +0000, Michael Kelley (LINUX) wrote:
> > Yes, this works fine now, but why are total_used and used_hiwater
> > global variables? If you make them fields in struct io_tlb_mem
> > (possibly guarded with #ifdef CONFIG_DEBUG_FS), you can get rid of the
> > check. Of course, in instances other than io_tlb_default_mem these
> > fields would not be exported to userspace through debugfs, but if really
> > needed, I can at least find them in a crash dump (or read them through
> > /proc/kcore).
> > 
> 
> Got it.
> 
> Your previously comments mentioned making them fields in struct io_tlb_mem,
> and I missed your point.  :-(   I got focused on fixing the accounting for
> DEBUG_FS so it didn't include the non-default pools, and didn't pick up on the
> idea of doing the accounting for the non-default pools even though the values
> aren't exposed in /sys.   I'll fix this in the next version.

FYI, I agree that per-instance accounting is probably the better way,
too.
