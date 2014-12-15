From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v4 0/8] Introduce automatic DMA configuration for
	IOMMU masters
Date: Mon, 15 Dec 2014 17:34:16 +0000
Message-ID: <20141215173416.GS20738@arm.com>
References: <1415991397-9618-1-git-send-email-will.deacon@arm.com>
	<546C7D36.7030400@samsung.com> <20141119114150.GD15985@arm.com>
	<1775535.qgYBmCEZS0@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1775535.qgYBmCEZS0@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 15, 2014 at 05:21:16PM +0000, Laurent Pinchart wrote:
> Hi Will,

Hi Laurent,

> On Wednesday 19 November 2014 11:41:50 Will Deacon wrote:
> > +static void __remove_iommu_mapping_entry(struct kref *kref)
> > +{
> > +	struct dma_iommu_mapping_entry *entry;
> > +
> > +	entry = container_of(kref, struct dma_iommu_mapping_entry, kref);
> > +	list_del(&entry->list);
> > +}
> > +
> > +static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64
> > size,
> > +				    struct iommu_ops *iommu)
> > +{
> > +	struct iommu_domain *domain;
> > +	struct dma_iommu_mapping_entry *entry = NULL;
> > +
> > +	if (!iommu->get_default_domain)
> > +		return false;
> > +
> > +	domain = iommu->get_default_domain(dev);
> > +	if (!domain)
> > +		return false;
> > +
> > +	spin_lock(&dma_iommu_mapping_lock);
> > +
> > +	list_for_each_entry(entry, &dma_iommu_mapping_table, list) {
> > +		if (entry->domain == domain)
> > +			break;
> > +	}
> 
> That might be a stupid question (fighting my impostor syndrome again here), 
> but is there a fundamental reason why we can't store the VA allocation data 
> (probably using iova) in the domain instead of having to go through hoops and 
> loops here to associate that data to the domain ?

Well, this was very much a work-in-progress that I ended up abandoning :)

Ultimately, I'd really like to see the default domain management moved into
core code, at which point extending struct iommu_domain seems perfectly
plausible to me (not sure if we'd have a new structure for that).

Then we'd have a fairly clean device -> group -> domain -> allocator
abstraction for each master.

Will
