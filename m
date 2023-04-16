Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50C310FB;
	Sun, 16 Apr 2023 06:42:00 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8649C67373; Sun, 16 Apr 2023 08:41:56 +0200 (CEST)
Date: Sun, 16 Apr 2023 08:41:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>, iommu@lists.linux.dev,
	baolu.lu@linux.intel.com
Subject: Re: [regression] Bug 217218 - Trying to boot Linux version 6-2.2
 kernel with Marvell SATA controller 88SE9235
Message-ID: <20230416064156.GA6410@lst.de>
References: <a79ea7f5-6a41-a6c9-cfec-ba01aa2a3cfa@leemhuis.info> <20230328012231.GB21977@lst.de> <01c50370-002d-5e18-3edc-81c9527aedc9@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01c50370-002d-5e18-3edc-81c9527aedc9@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 30, 2023 at 01:18:45PM +0100, Robin Murphy wrote:
> FWIW "Marvell SATA" instantly makes me suspect the phantom function quirk. 
> What *should* happen is the IOMMU driver sees the PCI DMA aliases correctly 
> and sets up context entries for both 07.00.0 and 07.00.1, but it looks like 
> that may be what's gone awry.

Looking at the bug report it seems this is device 9235, which doesn't
need the DMA alias quirks.
