Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3367A7E6;
	Tue, 28 Mar 2023 01:22:41 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2F39C68AA6; Tue, 28 Mar 2023 03:22:32 +0200 (CEST)
Date: Tue, 28 Mar 2023 03:22:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>, iommu@lists.linux.dev,
	baolu.lu@linux.intel.com
Subject: Re: [regression] Bug 217218 - Trying to boot Linux version 6-2.2
 kernel with Marvell SATA controller 88SE9235
Message-ID: <20230328012231.GB21977@lst.de>
References: <a79ea7f5-6a41-a6c9-cfec-ba01aa2a3cfa@leemhuis.info>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a79ea7f5-6a41-a6c9-cfec-ba01aa2a3cfa@leemhuis.info>
User-Agent: Mutt/1.5.17 (2007-11-01)


I finally found some real time to look into this:

On Tue, Mar 21, 2023 at 02:52:00PM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> > The man errors I am getting are
> > 
> > dmar_fault 8 callbacks suppressed
> > DMAR : DRHD: handling fault status req 2
> > DMAR : [DMA Write NO_PASID] Request device [07.00.1] fault addr
> > 0xfffe0000 [fault reason 0x82] Present bit in contect entry is clear

This clearly indicates that my original idea about the AMD gart was
completely bonkers, as we're obviously on an Intel platform.

And this indicates that the device is trying to do a DMA write to
something that isn't IOMMU mapped.  Getting this from an initialization
change (commit 78013eaadf6 (x86: remove the IOMMU table infrastructure")
feels very strange to me.

Can you maybe post the full dmesg?  I wonder if there is interesting
initialization error in here.

