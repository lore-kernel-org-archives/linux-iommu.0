From: Antonios Motakis <a.motakis@virtualopensystems.com>
Subject: Re: [PATCH 1/2] ARM: SMMU: add devices attached to the SMMU to an
 IOMMU group
Date: Mon, 14 Oct 2013 17:13:15 +0200
Message-ID: <CAG8rG2wftreREPnCbH8cKtsHD4TXBFAYGfY0ZMmsX3UW757r4Q@mail.gmail.com>
References: <1381497887-14586-1-git-send-email-a.motakis@virtualopensystems.com>
	<20131014124815.GC10491@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131014124815.GC10491@mudshark.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, "moderated list:ARM SMMU DRIVER" <linux-arm-kernel@lists.infradead.org>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "tech@virtualopensystems.com" <tech@virtualopensystems.com>, "agraf@suse.de" <agraf@suse.de>, "B08248@freescale.com" <B08248@freescale.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 14, 2013 at 2:48 PM, Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Antonios,
>
> On Fri, Oct 11, 2013 at 02:24:46PM +0100, Antonios Motakis wrote:
> > IOMMU groups are expected by certain users of the IOMMU API,
> > e.g. VFIO. Add new devices found by the SMMU driver to an IOMMU
> > group to satisfy those users.
>
> Cheers for looking at this: VFIO has been on my TODO list for some time.
>
> > Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
> > ---
> >  drivers/iommu/arm-smmu.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 0f45a48..8b71332 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -1502,6 +1502,8 @@ static int arm_smmu_add_device(struct device *dev)
> >  {
> >       struct arm_smmu_device *child, *parent, *smmu;
> >       struct arm_smmu_master *master = NULL;
> > +     struct iommu_group *group;
> > +     int ret;
> >
> >       spin_lock(&arm_smmu_devices_lock);
> >       list_for_each_entry(parent, &arm_smmu_devices, list) {
> > @@ -1534,13 +1536,27 @@ static int arm_smmu_add_device(struct device *dev)
> >       if (!master)
> >               return -ENODEV;
> >
> > +     group = iommu_group_get(dev);
>
> I'm not especially familiar with IOMMU groups (I understand them as the
> minimum translation granularity, which would mean single StreamID for the
> ARM SMMU), but under what circumstances would you expect to receive a
> non-NULL group here? I can't see any other code adding devices to groups
> (outside of other drivers)...
>
Hi Will,

You are right, only other IOMMU drivers will add a device to a group.
There was a discussion about this when I posted a similar patch for
the Exynos System MMU driver, see
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/185675.html

The idea is to check in the case of add_device() being called multiple
times, which is not the case most of the time, but still a sane
safeguard.

>
> Will
