From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH 01/18] drivers core: Add I/O ASID allocator
Date: Tue, 9 Apr 2019 15:08:45 -0700
Message-ID: <20190409220845.GM14111@linux.ibm.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1554767973-30125-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20190409100049.GC9224@smile.fi.intel.com>
 <20190409100436.GA28683@infradead.org>
 <20190409103030.GK9224@smile.fi.intel.com>
 <20190409145308.GZ14111@linux.ibm.com>
 <20190409152130.GS9224@smile.fi.intel.com>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190409152130.GS9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 09, 2019 at 06:21:30PM +0300, Andriy Shevchenko wrote:
> On Tue, Apr 09, 2019 at 07:53:08AM -0700, Paul E. McKenney wrote:
> > On Tue, Apr 09, 2019 at 01:30:30PM +0300, Andriy Shevchenko wrote:
> > > On Tue, Apr 09, 2019 at 03:04:36AM -0700, Christoph Hellwig wrote:
> > > > On Tue, Apr 09, 2019 at 01:00:49PM +0300, Andriy Shevchenko wrote:
> > > > > I think it makes sense to add a helper macro to rcupdate.h
> > > > > (and we have several cases in kernel that can utilize it)
> > > > > 
> > > > > #define kfree_non_null_rcu(ptr, rcu_head)		\
> > > > > 	do {						\
> > > > > 		if (ptr)				\
> > > > > 			kfree_rcu(ptr, rcu_head);	\
> > > > > 	} while (0)
> > > > > 
> > > > > as a more common pattern for resource deallocators.
> > > > 
> > > > I think that should move straight into kfree_rcu.  
> > > 
> > > Possible. I didn't dare to offer this due to lack of knowledge how it's used in
> > > other places.
> > > 
> > > > In general
> > > > we expect *free* to deal with NULL pointers transparently, so we
> > > > should do so here as well.
> > > 
> > > Exactly my point, thanks.
> > 
> > As shown below?
> 
> Looks pretty much good to me, thanks!
> Reviewed-by: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied, thank you!

							Thanx, Paul

> > And now that you mention it, it is a bit surprising that no one has
> > complained before.  ;-)
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 23ad938244968e9d2a8001a1c52887c113b182f6
> > Author: Paul E. McKenney <paulmck@linux.ibm.com>
> > Date:   Tue Apr 9 07:48:18 2019 -0700
> > 
> >     rcu: Make kfree_rcu() ignore NULL pointers
> >     
> >     This commit makes the kfree_rcu() macro's semantics be consistent
> >     with the likes of kfree() by adding a check for NULL pointers, so
> >     that kfree_rcu(NULL, ...) is a no-op.
> >     
> >     Reported-by: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
> >     Reported-by: Christoph Hellwig <hch@infradead.org>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > 
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 922bb6848813..c68649b9bcec 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -828,9 +828,13 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
> >   * The BUILD_BUG_ON check must not involve any function calls, hence the
> >   * checks are done in macros here.
> >   */
> > -#define kfree_rcu(ptr, rcu_head)					\
> > -	__kfree_rcu(&((ptr)->rcu_head), offsetof(typeof(*(ptr)), rcu_head))
> > -
> > +#define kfree_rcu(ptr, rhf)						\
> > +do {									\
> > +	typeof (ptr) ___p = (ptr);					\
> > +									\
> > +	if (___p)							\
> > +		__kfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
> > +} while (0)
> >  
> >  /*
> >   * Place this after a lock-acquisition primitive to guarantee that
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
