From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC PATCH 3/7] iommu: add new iommu_ops callback for adding a
	device with a set of IDs
Date: Mon, 01 Sep 2014 19:18:13 +0200
Message-ID: <3685256.rQ7X7CQ9Fx@wuerfel>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
	<2811939.9L5BJIvoiz@wuerfel> <20140901163400.GK24594@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140901163400.GK24594-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Monday 01 September 2014 17:34:00 Will Deacon wrote:
> On Mon, Sep 01, 2014 at 03:39:16PM +0100, Arnd Bergmann wrote:
> > On Monday 01 September 2014 10:13:22 Thierry Reding wrote:
> > > On Fri, Aug 29, 2014 at 04:54:26PM +0100, Will Deacon wrote:
> > > > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > > > index 20f9a527922a..3dd1b99c4542 100644
> > > > --- a/include/linux/iommu.h
> > > > +++ b/include/linux/iommu.h
> > > > @@ -114,6 +114,8 @@ struct iommu_ops {
> > > >       int (*domain_has_cap)(struct iommu_domain *domain,
> > > >                             unsigned long cap);
> > > >       int (*add_device)(struct device *dev);
> > > > +     int (*add_device_master_ids)(struct device *dev, int count, u32 *ids,
> > > > +                                  void *data);
> > > 
> > > If we want to pass around IOMMU instances I think we should make them
> > > proper objects rather than some loosely specified void *.
> > 
> > Agreed.
> 
> For OF, this data argument is the data field of the device_node for the
> IOMMU. That's private to the corresponding IOMMU driver and I don't see
> what we gain by making that a generic structure. It's likely going to
> represent some internal driver data structures anyway, so that the IDs can
> be recorded in the relevant place and for the relevant group etc.
> 
> In other words, I have no idea what a generic data structure would look
> like for this.

Something like

	struct iommu {
		struct device *dev;
		const struct iommu_ops *ops;
		struct list_head domains;
		void *private;
	};

There are probably a few more fields we will need in the long run.

	Arnd
