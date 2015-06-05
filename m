From: "jroedel@suse.de" <jroedel@suse.de>
Subject: Re: [PATCH 00/22 v2] Introduce default domains for iommu groups
Date: Fri, 5 Jun 2015 16:35:28 +0200
Message-ID: <20150605143528.GK16345@suse.de>
References: <1432831305-11126-1-git-send-email-joro@8bytes.org>
 <20150605142206.GB7420@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150605142206.GB7420@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Kukjin Kim <kgene@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Heiko Stuebner <heiko@sntech.de>, Hiroshi Doyu <hdoyu@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Robin Murphy <Robin.Murphy@arm.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Oded Gabbay <oded.gabbay@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

Thanks for having a look!

On Fri, Jun 05, 2015 at 03:22:06PM +0100, Will Deacon wrote:
> 
> Most of this looks fine to me, modulo by comments about the dm regions
> (which I'm not sure how to implement for ARM).

When there are no direct mapping requirements from the firmware on ARM,
you can just return an empty list in these call-backs.

> > A major change is that now the default domain has to be
> > allocated by the code that allocates the iommu group. For
> > PCI devices this happens in the IOMMU core, but drivers
> > allocating the group on their own can now implement a policy
> > that fits their needs (e.g. not allocate one domain per
> > group but let multiple groups share one domain).
> 
> Makes sense. I really think we should be moving group allocation out of
> the IOMMU drivers and into the bus code, like we already have for PCI.
> Once we've got a way to describe groups of platform devices (e.g. in the
> device-tree), then we can have the group creation happen automatically
> as part of Laurent's of_iommu work.

Yes, that makes sense. And PCI is pretty hardcoded into the iommu-groups
implementation right now. This needs probably be more generic too.


	Joerg
