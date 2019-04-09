From: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 01/18] drivers core: Add I/O ASID allocator
Date: Tue, 9 Apr 2019 13:30:30 +0300
Message-ID: <20190409103030.GK9224@smile.fi.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1554767973-30125-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20190409100049.GC9224@smile.fi.intel.com>
 <20190409100436.GA28683@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190409100436.GA28683@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 09, 2019 at 03:04:36AM -0700, Christoph Hellwig wrote:
> On Tue, Apr 09, 2019 at 01:00:49PM +0300, Andriy Shevchenko wrote:
> > I think it makes sense to add a helper macro to rcupdate.h
> > (and we have several cases in kernel that can utilize it)
> > 
> > #define kfree_non_null_rcu(ptr, rcu_head)		\
> > 	do {						\
> > 		if (ptr)				\
> > 			kfree_rcu(ptr, rcu_head);	\
> > 	} while (0)
> > 
> > as a more common pattern for resource deallocators.
> 
> I think that should move straight into kfree_rcu.  

Possible. I didn't dare to offer this due to lack of knowledge how it's used in
other places.

> In general
> we expect *free* to deal with NULL pointers transparently, so we
> should do so here as well.

Exactly my point, thanks.

-- 
With Best Regards,
Andy Shevchenko
