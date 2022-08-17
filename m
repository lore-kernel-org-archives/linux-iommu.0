Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141722561
	for <iommu@lists.linux.dev>; Wed, 17 Aug 2022 06:09:58 +0000 (UTC)
Received: by mail.wantstofly.org (Postfix, from userid 1000)
	id 5483F7F54A; Wed, 17 Aug 2022 09:09:57 +0300 (EEST)
Date: Wed, 17 Aug 2022 09:09:57 +0300
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
Message-ID: <YvyGNeIQTrM4w/fY@wantstofly.org>
References: <Yvo2dfpEh/WC+Wrr@wantstofly.org>
 <ab15191c-d79f-b5de-7568-d15b8f8a8aa8@acm.org>
 <YvpQ5M7//AlrpJGP@wantstofly.org>
 <94921c7a-778c-911d-4d72-d7815d95c46b@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94921c7a-778c-911d-4d72-d7815d95c46b@linux.intel.com>

On Wed, Aug 17, 2022 at 12:04:10PM +0800, Baolu Lu wrote:

> > > > On a build of 7ebfc85e2cd7 ("Merge tag 'net-6.0-rc1' of
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net"), with
> > > > CONFIG_INTEL_IOMMU_DEBUGFS enabled, I am seeing the lockdep splat
> > > > below when an I/O page fault occurs on a machine with an Intel
> > > > IOMMU in it.
> > > > 
> > > > The issue seems to be the klist iterator functions using
> > > > spin_*lock_irq*() but the klist insertion functions using
> > > > spin_*lock(), combined with the Intel DMAR IOMMU driver iterating
> > > > over klists from atomic (hardirq) context as of commit 8ac0b64b9735
> > > > ("iommu/vt-d: Use pci_get_domain_bus_and_slot() in pgtable_walk()")
> > > > when CONFIG_INTEL_IOMMU_DEBUGFS is enabled, where
> > > > pci_get_domain_bus_and_slot() calls into bus_find_device() which
> > > > iterates over klists.
> > > > 
> > > > I found this commit from 2018:
> > > > 
> > > > 	commit 624fa7790f80575a4ec28fbdb2034097dc18d051
> > > > 	Author: Bart Van Assche<bvanassche@acm.org>
> > > > 	Date:   Fri Jun 22 14:54:49 2018 -0700
> > > > 
> > > > 	    scsi: klist: Make it safe to use klists in atomic context
> > > > 
> > > > This commit switched lib/klist.c:klist_{prev,next} from
> > > > spin_{,un}lock() to spin_{lock_irqsave,unlock_irqrestore}(), but left
> > > > the spin_{,un}lock() calls in add_{head,tail}() untouched.
> > > > 
> > > > The simplest fix for this would be to switch lib/klist.c:add_{head,tail}()
> > > > over to use the IRQ-safe spinlock variants as well?
> > > Another possibility would be to evaluate whether it is safe to revert commit
> > > 624fa7790f80 ("scsi: klist: Make it safe to use klists in atomic context").
> > > That commit is no longer needed by the SRP transport driver since the legacy
> > > block layer has been removed from the kernel.
> > And then to fix the 6.0-rc1 iommu/vt-d lockdep splat with
> > CONFIG_INTEL_IOMMU_DEBUGFS enabled, we could convert the Intel DMAR
> > IRQ handler to a threaded IRQ handler.  We (Arista) carry the patch
> > below in our kernel tree, and the last two hunks of the patch do
> > exactly that, for the same reason (having to call
> > pci_get_domain_bus_and_slot() from the IRQ handler) but this is
> > probably too big of a change for 6.0-rc.
> > 
> > 
> > 
> > commit 90a8e7da0facf198692a641fcfe6f89c478608e0
> > Author: Lennert Buytenhek<buytenh@wantstofly.org>
> > Date:   Wed Jul 13 15:34:30 2022 +0300
> > 
> >      iommu/vt-d: Use report_iommu_fault()
> >      This patch makes iommu/vt-d call report_iommu_fault() when an I/O
> >      page fault occurs, which has two effects:
> >      1) It allows device drivers to register a callback to be notified
> >         of I/O page faults, via the iommu_set_fault_handler() API.
> >      2) It triggers the io_page_fault tracepoint in report_iommu_fault()
> >         when an I/O page fault occurs.
> >      The latter point is the main aim of this patch, as it allows
> >      rasdaemon-like daemons to be notified of I/O page faults, and to
> >      possibly initiate corrective action in response.
> 
> The IOMMU subsystem already has a framework to handle I/O page faults:
> 
>     commit fc36479db74e9 "iommu: Add a page fault handler"
> 
> And below series,
> 
> https://lore.kernel.org/linux-iommu/20220817012024.3251276-1-baolu.lu@linux.intel.com/
> 
> is trying to make it more generic. It seems to be more suitable for your
> case.
> 
> The report_iommu_fault() probably will be replaced by
> iommu_register_device_fault_handler() eventually. So I don't encourage
> its usage in the VT-d driver.

We use the iommu/io_page_fault tracepoint from userspace to be notified
of (non-ATS) I/O page faults so that we can detect malfunctioning PCIe
devices, which in our systems are typically switch/router line cards,
and take corrective action, such as restarting the offending line card.

Calling report_iommu_fault() causes the iommu/io_page_fault tracepoint
to be invoked, which is why we made the AMD and Intel IOMMU drivers use
report_iommu_fault() in our kernel tree.

It seems that iommu_queue_iopf() is specific to the SVA use case, while
we are not using SVA, in which case it would not address our use case.
(We don't care about knowing about ATS translation faults, we just want
to know when a non-ATS PCI device is malfunctioning.)


Kind regards,
Lennert
