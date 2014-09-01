From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC PATCH 3/7] iommu: add new iommu_ops callback for adding a
	device with a set of IDs
Date: Mon, 01 Sep 2014 16:39:16 +0200
Message-ID: <2811939.9L5BJIvoiz@wuerfel>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
	<1409327670-3495-4-git-send-email-will.deacon@arm.com>
	<20140901081320.GB24430@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140901081320.GB24430@ulmo>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Monday 01 September 2014 10:13:22 Thierry Reding wrote:
> On Fri, Aug 29, 2014 at 04:54:26PM +0100, Will Deacon wrote:
> > This patch adds a new function to the iommu_ops structure to allow a
> > device to be added to a specific IOMMU instance along with a set of
> > opaque IDs that are used internally by the IOMMU for identifying and
> > configuring translations.
> > 
> > Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> > ---
> >  include/linux/iommu.h | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> I don't really see the point of this new callback. As I understand it,
> the strength of the current .add_device() callback is that it uses only
> the struct device and figures out which exact IOMMU to associate it with
> in case there are multiple IOMMUs.
> 
> Although that doesn't seem to be the general case either. That's really
> been one of the difficulties in dealing with IOMMU. Every driver seems
> to do things very differently and the IOMMU subsystem itself is fairly
> different from other subsystems too.

The problem with add_device is that it assumes that each bus_type only
has one IOMMU instance, and that we know which one that is. Current
implementations do more or less nasty hacks to work around this where
necessary, and we should try to remove those hacks rather than adding
more of them into future drivers.

A smaller issue with the add_device callback is the point at which it
gets called: the caller is in the bus_notifier when the device gets
added, but at a time when we don't have access to the bus-specific
information.

> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 20f9a527922a..3dd1b99c4542 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -114,6 +114,8 @@ struct iommu_ops {
> >       int (*domain_has_cap)(struct iommu_domain *domain,
> >                             unsigned long cap);
> >       int (*add_device)(struct device *dev);
> > +     int (*add_device_master_ids)(struct device *dev, int count, u32 *ids,
> > +                                  void *data);
> 
> If we want to pass around IOMMU instances I think we should make them
> proper objects rather than some loosely specified void *.

Agreed.

> Also the generic IOMMU binding doesn't require the IOMMU specifier to
> contain master IDs. So this seems to be a callback that would only be
> used by a restricted set of IOMMUs.

No, it should be used by all of them, but we might be passing empty
arguments.

	Arnd
