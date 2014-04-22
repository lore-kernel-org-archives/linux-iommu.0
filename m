From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/9] Renesas ipmmu-vmsa: Miscellaneous cleanups and fixes
Date: Tue, 22 Apr 2014 13:44:50 +0200
Message-ID: <7322154.6fhsyAGbuH@avalon>
References: <1398089589-9181-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20140422113423.GB8389@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20140422113423.GB8389@arm.com>
Sender: linux-sh-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Tuesday 22 April 2014 12:34:23 Will Deacon wrote:
> On Mon, Apr 21, 2014 at 03:13:00PM +0100, Laurent Pinchart wrote:
> > Hello,
> 
> Hi Laurent,
> 
> > This patch set cleans up and fixes small issues in the ipmmu-vmsa driver.
> > The patches are based on top of "[PATCH v3] iommu: Add driver for Renesas
> > VMSA-compatible IPMMU" that adds the ipmmu-vmsa driver.
> > 
> > The most interesting part of this series is the rewrite of the page table
> > management code. The IOMMU core guarantees that the map and unmap
> > operations will always be called only with page sizes advertised by the
> > driver. We can use that assumption to remove loops of PGD and PMD
> > entries, simplifying the code.
> 
> Hmm, interesting. We still have to handle the case where a mapping created
> with one page-size could be unmapped with another though (in particular,
> unmapping part of the range).

Correct. I've implemented that in patch 9/9. Note that the patch also frees 
pages use for page directory entries when they're not needed anymore, instead 
of just marking them as invalid. That's something you probably should do in 
the arm-smmu driver as well.

> > Will, would it make sense to perform the same cleanup for the arm-smmu
> > driver, or is there a reason to keep loops over PGD and PMD entries ?
> > Removing them makes the implementation of 68kB and 2MB pages easier.
> 
> Is this an assumption that's relied on by other IOMMU drivers? It certainly
> makes mapping of large ranges less efficient than it could be, so I'm more
> inclined to set all the bits > PAGE_SIZE in pgsize_bitmap if it's only used
> to determine the granularity at which map/unmap are called (which is
> unrelated to what the hardware can actually do).

I haven't checked all the other IOMMU drivers, but at least the OMAP IOMMU 
driver relies on the same assumption. Splitting map/unmap operations in page 
size chunks inside the IOMMU core might indeed have a negative performance 
impact due to locking, but I'm not sure it would be noticeable.

-- 
Regards,

Laurent Pinchart

