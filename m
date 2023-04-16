Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D2210FB;
	Sun, 16 Apr 2023 06:55:08 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 80B4167373; Sun, 16 Apr 2023 08:55:04 +0200 (CEST)
Date: Sun, 16 Apr 2023 08:55:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jason Adriaanse <jason_a69@yahoo.co.uk>
Cc: robin.murphy@arm.com, baolu.lu@linux.intel.com, hch@lst.de,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [regression] Bug 217218 - Trying to boot Linux version 6-2.2
 kernel with Marvell SATA controller 88SE9235
Message-ID: <20230416065503.GB6410@lst.de>
References: <01c50370-002d-5e18-3edc-81c9527aedc9@arm.com> <04a94830-f626-2cd7-d220-7ba3025a409c@yahoo.co.uk>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04a94830-f626-2cd7-d220-7ba3025a409c@yahoo.co.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi Jason,

sorry for the late reply.  I had some email issues and am still
recovering from the backlog.

On Fri, Mar 31, 2023 at 10:20:37AM +0800, Jason Adriaanse wrote:
> Hi Christoph and Robin,
>
> Christoph - I would like to send you more dmesg information but as my boot 
> device cannot be detected that information is not being written to disk. Is 
> there any way to specifically write boot debug information to say a USB 
> device with some kernel parameters?

I don't know of any good way.  pstore has some ways to save kernel
messages, but it doesn't work to well with normal block devices in
case of crashes.

I'm a bit lost at the moment.

Two ideas I have, would be to

 1) boot with the intel_iommu=off kernel command line
 3) build a kernel with CONFIG_INTEL_IOMMU

and see if that works and report the dmesg.
