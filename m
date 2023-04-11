Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDE517E3
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 03:42:57 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id E37E368BFE; Tue, 11 Apr 2023 05:42:53 +0200 (CEST)
Date: Tue, 11 Apr 2023 05:42:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	Dexuan Cui <decui@microsoft.com>,
	Tianyu Lan <Tianyu.Lan@microsoft.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] swiotlb: Track and report io_tlb_used high
 water mark in debugfs
Message-ID: <20230411034253.GC15679@lst.de>
References: <1680324300-124563-1-git-send-email-mikelley@microsoft.com> <20230407055016.GA6803@lst.de> <BYAPR21MB1688CCCC4CFC597A3C12E370D7969@BYAPR21MB1688.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688CCCC4CFC597A3C12E370D7969@BYAPR21MB1688.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 07, 2023 at 10:01:13PM +0000, Michael Kelley (LINUX) wrote:
> I coded the way I did to follow the kernel coding style guidance
> that prefers converting a Kconfig symbol into a C boolean
> expression, and using it in a normal C conditional instead of
> using #ifdef.  If CONFIG_DEBUG_FS=n, the compiler will constant
> fold the conditional away so there's no runtime overhead.  I
> like the way that approached worked out in this case, but if you prefer
> separate functions with #ifdef and stubs, I don't feel strongly either way.

I don't think there is a a hard and clear rule.  Actual ifdefs have the
benefit of allowing to actually remove struct fields as well.  But
the important bit is that I do want the accounting in helpers instead
of in the main swiotlb logic.  And once you do that, having #ifdefed
stubs for the functions make sense to me.
