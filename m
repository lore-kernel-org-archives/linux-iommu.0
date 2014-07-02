From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 1/3] iommu: introduce IOMMU_DOMAIN_HYP domain type
	for hypervisor allocation
Date: Wed, 2 Jul 2014 14:57:42 +0100
Message-ID: <20140702135742.GC24879@arm.com>
References: <1404231017-10856-1-git-send-email-will.deacon@arm.com>
	<1404236553.3225.93.camel@ul30vt.home>
	<20140701180426.GX28164@arm.com>
	<1404242891.3225.144.camel@ul30vt.home>
	<20140702104902.GH18731@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140702104902.GH18731-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 02, 2014 at 11:49:02AM +0100, Will Deacon wrote:
> On Tue, Jul 01, 2014 at 08:28:11PM +0100, Alex Williamson wrote:
> > If we go the route of defining it at allocation time, I'd probably think
> > about adding a new interface, like:
> > 
> > iommu_domain_alloc_with_features(struct bus_type *bus, u32 features)
> > 
> > Where features is a bitmap
> > 
> > #define IOMMU_DOMAIN_FEATURE_NESTING (1U << 0)
> > 
> > iommu_domain_alloc(struct bus_type *bus) would then just be a wrapper
> > with features = 0.  If an IOMMU driver doesn't support a requested
> > feature, it should fail so we don't have cases like KVM requesting a
> > "HYP" domain when it doesn't need it and the IOMMU drivers don't support
> > it.
> > 
> > It would be a lot less intrusive if we could use iommu_domain_set_attr()
> > to enable nesting after allocation though.  This could return error if
> > called after the point at which it can be easily enabled.
> 
> I'll take another look at set_attr, since I agree that it would be cleaner.

Ok, we quickly end up with a bootstrap problem here:

  - We need to know whether the domain is stage-1 or stage-2 before we've
    attached any devices to it (since we can have DMA traffic once a
    device is attached).

  - Until a device is attached, we don't know the specific SMMU instance
    backing the domain.

  - Until we know the SMMU, we don't know whether or not we can do
    nesting, and therefore can't handle set_attr calls.

So the two places we can provide this information are either at domain_alloc
time or at device_attach time. I think the former makes more sense, so I'll
look at adding a new alloc function as you suggest above.

Will
