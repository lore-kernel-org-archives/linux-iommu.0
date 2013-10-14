From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: SMMU: add devices attached to the SMMU to an
	IOMMU group
Date: Mon, 14 Oct 2013 18:07:19 +0100
Message-ID: <20131014170719.GR10491@mudshark.cambridge.arm.com>
References: <1381497887-14586-1-git-send-email-a.motakis@virtualopensystems.com>
	<20131014124815.GC10491@mudshark.cambridge.arm.com>
	<CAG8rG2wftreREPnCbH8cKtsHD4TXBFAYGfY0ZMmsX3UW757r4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAG8rG2wftreREPnCbH8cKtsHD4TXBFAYGfY0ZMmsX3UW757r4Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Cc: open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, "B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org" <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, "moderated list:ARM SMMU DRIVER" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 14, 2013 at 04:13:15PM +0100, Antonios Motakis wrote:
> On Mon, Oct 14, 2013 at 2:48 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> > > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > > index 0f45a48..8b71332 100644
> > > --- a/drivers/iommu/arm-smmu.c
> > > +++ b/drivers/iommu/arm-smmu.c
> > > @@ -1502,6 +1502,8 @@ static int arm_smmu_add_device(struct device *dev)
> > >  {
> > >       struct arm_smmu_device *child, *parent, *smmu;
> > >       struct arm_smmu_master *master = NULL;
> > > +     struct iommu_group *group;
> > > +     int ret;
> > >
> > >       spin_lock(&arm_smmu_devices_lock);
> > >       list_for_each_entry(parent, &arm_smmu_devices, list) {
> > > @@ -1534,13 +1536,27 @@ static int arm_smmu_add_device(struct device *dev)
> > >       if (!master)
> > >               return -ENODEV;
> > >
> > > +     group = iommu_group_get(dev);
> >
> > I'm not especially familiar with IOMMU groups (I understand them as the
> > minimum translation granularity, which would mean single StreamID for the
> > ARM SMMU), but under what circumstances would you expect to receive a
> > non-NULL group here? I can't see any other code adding devices to groups
> > (outside of other drivers)...
> >
> 
> You are right, only other IOMMU drivers will add a device to a group.
> There was a discussion about this when I posted a similar patch for
> the Exynos System MMU driver, see
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/185675.html
> 
> The idea is to check in the case of add_device() being called multiple
> times, which is not the case most of the time, but still a sane
> safeguard.

Ok, but it feels a bit weird. The current code (arm_smmu_add_device)
basically does a bunch of sanity checking against the DT data in order to
find where the master sits in the device topology. Then it updates
dev->archdata.iommu to point at the relevant SMMU instance.

So, the interesting case is where the device was previously associated with
a *different* IOMMU. In that case, the current code clobbers the iommu field
with the new smmu, whereas the new code could end up getting very confused
with respect to IOMMU groups.

A better way is probably to check that dev->archdata.iommu is NULL before we
assign to it. If not, then spit out a warning and return an error. That
would also mean you could get rid of the group get/put calls.

Will
