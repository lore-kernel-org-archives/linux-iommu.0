From: "Cornwall, Jay" <Jay.Cornwall@amd.com>
Subject: RE: [PATCH] iommu/amd: Fix for L2 race with VM invalidation
Date: Tue, 20 May 2014 13:53:57 +0000
Message-ID: <99CB3FADB756624A867BE9481439561C334C9EB5@satlexdag03.amd.com>
References: <1400049252-4213-1-git-send-email-suravee.suthikulpanit@amd.com>
 <20140514092920.GB6026@8bytes.org>
 <99CB3FADB756624A867BE9481439561C334C9045@satlexdag03.amd.com>
 <20140520133245.GE17056@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140520133245.GE17056@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Hurwitz, Sherry" <sherry.hurwitz@amd.com>, "Naru, Kim" <Kim.Naru@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

> From: Joerg Roedel [mailto:joro@8bytes.org]
> Sent: Tuesday, May 20, 2014 08:33
> 
> On Wed, May 14, 2014 at 11:38:25AM +0000, Cornwall, Jay wrote:
> > Hi,
> >
> > I'm not sure why you're submitting this, Suravee?
> >
> > We already agreed that we need the extra mmu_notifier point, proposed
> > by Joerg back in 2011, to eliminate the race. I had thought we were
> > waiting on that to be implemented.
> 
> Speaking of this, would it also be possible to hold back all faults (so not
> sending back ppr-comletions) between invalidate_range_start/end()?
> Or will the hardware run into a timeout when it takes too long to process a
> fault or when it issued the maximum number of parallel faults?

I haven't located a comment on this in the HW documentation. The ATC will set a MMIO register flag if a response takes more than 2^32 cycles (I'm not certain of the frequency). I don't know if this is fatal. I have experimented with adding significant delays into the PPR handler in the past without affecting test cases.

My larger concern with this design is that the only situations in which there is a conflict between the MM and IOTLB activity is where the IOTLB client is racing with munmap() or physical page relocation. Both of these are low proability scenarios. However, blocking PPR completions for all MM invalidations would impact all IOTLB client activity.

This is particularly true for heterogeneous applications.
