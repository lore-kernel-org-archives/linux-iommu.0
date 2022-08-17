Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07CD23CB
	for <iommu@lists.linux.dev>; Wed, 17 Aug 2022 05:49:48 +0000 (UTC)
Received: by mail.wantstofly.org (Postfix, from userid 1000)
	id 3A1E97F54A; Wed, 17 Aug 2022 08:49:40 +0300 (EEST)
Date: Wed, 17 Aug 2022 08:49:40 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Sasha Levin <sashal@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Liu Yi L <yi.l.liu@intel.com>,
	Jacob jun Pan <jacob.jun.pan@intel.com>,
	linux-kernel@vger.kernel.org,
	Scarlett Gourley <scarlett@arista.com>,
	James Sewart <jamessewart@arista.com>,
	Jack O'Sullivan <jack@arista.com>
Subject: Re: lockdep splat due to klist iteration from atomic context in
 Intel IOMMU driver
Message-ID: <YvyBdPwrTuHHbn5X@wantstofly.org>
References: <Yvo2dfpEh/WC+Wrr@wantstofly.org>
 <ab15191c-d79f-b5de-7568-d15b8f8a8aa8@acm.org>
 <5f734387-9757-0670-3eef-b565116af541@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f734387-9757-0670-3eef-b565116af541@linux.intel.com>

On Wed, Aug 17, 2022 at 12:45:26PM +0800, Baolu Lu wrote:

> > > On a build of 7ebfc85e2cd7 ("Merge tag 'net-6.0-rc1' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net"), with
> > > CONFIG_INTEL_IOMMU_DEBUGFS enabled, I am seeing the lockdep splat
> > > below when an I/O page fault occurs on a machine with an Intel
> > > IOMMU in it.
> > > 
> > > The issue seems to be the klist iterator functions using
> > > spin_*lock_irq*() but the klist insertion functions using
> > > spin_*lock(), combined with the Intel DMAR IOMMU driver iterating
> > > over klists from atomic (hardirq) context as of commit 8ac0b64b9735
> > > ("iommu/vt-d: Use pci_get_domain_bus_and_slot() in pgtable_walk()")
> > > when CONFIG_INTEL_IOMMU_DEBUGFS is enabled, where
> > > pci_get_domain_bus_and_slot() calls into bus_find_device() which
> > > iterates over klists.
> > > 
> > > I found this commit from 2018:
> > > 
> > >     commit 624fa7790f80575a4ec28fbdb2034097dc18d051
> > >     Author: Bart Van Assche <bvanassche@acm.org>
> > >     Date:   Fri Jun 22 14:54:49 2018 -0700
> > > 
> > >         scsi: klist: Make it safe to use klists in atomic context
> > > 
> > > This commit switched lib/klist.c:klist_{prev,next} from
> > > spin_{,un}lock() to spin_{lock_irqsave,unlock_irqrestore}(), but left
> > > the spin_{,un}lock() calls in add_{head,tail}() untouched.
> > > 
> > > The simplest fix for this would be to switch
> > > lib/klist.c:add_{head,tail}()
> > > over to use the IRQ-safe spinlock variants as well?
> > 
> > Another possibility would be to evaluate whether it is safe to revert
> > commit 624fa7790f80 ("scsi: klist: Make it safe to use klists in atomic
> > context"). That commit is no longer needed by the SRP transport driver
> > since the legacy block layer has been removed from the kernel.
> 
> If so, pci_get_domain_bus_and_slot() can not be used in this interrupt
> context, right?

The 624fa7790f80 commit from 2018 tried to make klist use safe from
atomic context, but since it missed a few of the klist accessors, it
didn't actually manage to make it safe, so it's already not safe to use
pci_get_domain_bus_and_slot() from interrupt context right now, even
without reverting this commit.  Reverting the commit would just be a
declaration that klist use from atomic context isn't safe and never was.

A quick check doesn't turn up any other cases where people have run
into this issue with code in mainline, so it would seem that the
newly-added use of pci_get_domain_bus_and_slot() to the iommu/vt-d
fault reporting interrupt handler is one of very few (if not only)
cases of mainline code wanting to access klists from atomic context.

Kind regards,
Lennert
