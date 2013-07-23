From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [PATCH] iommu/exynos: add devices attached to the System MMU to
	an IOMMU group
Date: Tue, 23 Jul 2013 14:04:56 +0200
Message-ID: <CAG8rG2xJ4z9cwrMtLhOrPKnw+fdL_H4doDPARNfvLj+JHTjByQ@mail.gmail.com>
References: <1374573694-30595-1-git-send-email-a.motakis@virtualopensystems.com>
	<00d701ce878f$da099fe0$8e1cdfa0$%dae@samsung.com>
	<CAG8rG2wNG9wVjKxtaDzLRybvh3wPVR08j9G9OPcK=a2Gwbtg-g@mail.gmail.com>
	<00e601ce8796$bdca50c0$395ef240$%dae@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <00e601ce8796$bdca50c0$395ef240$%dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, kvm-arm <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 23, 2013 at 1:21 PM, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>
>
>> -----Original Message-----
>> From: Antonios Motakis [mailto:a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org]
>> Sent: Tuesday, July 23, 2013 8:00 PM
>> To: Inki Dae
>> Cc: Linux ARM Kernel; Linux IOMMU; Linux Samsung SOC; kvm-arm; Cho
> KyongHo;
>> Joerg Roedel; Sachin Kamat; Jiri Kosina; Wei Yongjun; open list
>> Subject: Re: [PATCH] iommu/exynos: add devices attached to the System MMU
>> to an IOMMU group
>>
>> On Tue, Jul 23, 2013 at 12:31 PM, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>> >
>> >
>> >
>> > > -----Original Message-----
>> > > From: linux-samsung-soc-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-samsung-
>> soc-
>> > > owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Antonios Motakis
>> > > Sent: Tuesday, July 23, 2013 7:02 PM
>> > > To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
>> > iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
>> > > linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> > > Cc: kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org; Antonios Motakis; Cho KyongHo; Joerg
>> > > Roedel; Sachin Kamat; Jiri Kosina; Wei Yongjun; open list
>> > > Subject: [PATCH] iommu/exynos: add devices attached to the System MMU
>> to
>> > > an IOMMU group
>> > >
>> > > IOMMU groups are expected by certain users of the IOMMU API,
>> > > e.g. VFIO. Since each device is behind its own System MMU, we
>> > > can allocate a new IOMMU group for each device.
>> > >
>> > > This patch depends on Cho KyongHo's patch series titled "[PATCH v7
>> 00/12]
>> > > iommu/exynos: Fixes and Enhancements of System MMU driver with DT",
>> > > applied on a Linux 3.10.1 kernel. It has been tested on the Arndale
>> board.
>> > >
>> > > Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
>> > > ---
>> > >  drivers/iommu/exynos-iommu.c | 24 ++++++++++++++++++++++++
>> > >  1 file changed, 24 insertions(+)
>> > >
>> > > diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-
>> iommu.c
>> > > index 51d43bb..9f39eaa 100644
>> > > --- a/drivers/iommu/exynos-iommu.c
>> > > +++ b/drivers/iommu/exynos-iommu.c
>> > > @@ -1134,6 +1134,28 @@ static phys_addr_t
>> exynos_iommu_iova_to_phys(struct
>> > > iommu_domain *domain,
>> > >       return phys;
>> > >  }
>> > >
>> > > +static int exynos_iommu_add_device(struct device *dev)
>> > > +{
>> > > +     struct iommu_group *group;
>> > > +     int ret;
>> > > +
>> > > +     group = iommu_group_alloc();
>> >
>> > Is that correct? I don't see why you allocate a group object every time
>> > add_device callback is called. That doesn't have any meaning we have to
>> use
>> > iommu group feature. I think the implementation should be one more
>> devices
>> > per a group. So I guess a given device object should be wrapped by
>> higher
>> > device object than the given device object. For a good example, you can
>> > refer to intel-iommu.c file.
>>
>> With an Intel IOMMU it can be the case that 2 devices have to share
>> the same IOMMU mappings (i.e. you can't program them separately). With
>> the Exynos System MMU, there is always one System MMU per device, so
>> there is nothing stopping you from programming any 2 devices' mappings
>> differently. So yes, the right thing to do here is to have a one to
>> one relationship between devices and IOMMU groups.
>
> In case of Exynos drm driver, a unified iommu mapping table is used for all
> devices (fimd, g2d, hdmi, fimc, gsc, rotator) based on drm so they use the
> same iommu mapping table even though they have each iommu hardware unit. And
> the iommu mapping table is just logical data structure for hardware
> translation process by each DMA. Actually, I am considering using iommu
> group feature for more generic implementation.

But is this grouping imposed by the hardware in some way, or is it
just the way you handle them in software? In the latter case, then
what you are looking for are IOMMU domains (which can contain multiple
groups). IOMMU groups describe something that is imposed by the
hardware.

>
> And one question. Why do you allocate a iommu group object if we should have
> one to one relationship between devices and iommu groups? In this case, is
> there any reason you have to use the iommu group object?

Generic IOMMU code (such as VFIO) will check for IOMMU groups to
determine how the devices behind an IOMMU relate to each other.
Returning a unique IOMMU group object per device provides this
information - that each device can also be programmed separately. VFIO
relies on this behavior - if it doesn't find any IOMMU group objects
it will refuse to use the device.

Additionally, this information can be seen by userspace. Being able to
programmatically determine that there is a one to one relationship is
certainly useful.

I don't think the lack of IOMMU groups implies no grouping - I think
it implies unknown grouping or an incomplete driver, so in my opinion
VFIO is correct in refusing to work without IOMMU groups. So any
future ARM support for VFIO, will also rely on IOMMU groups.

>
> Thanks,
> Inki Dae
>
>>
>> (resending because of html mail)
>>
>> Cheers,
>> Antonios
>>
>> >
>> >
>> > Thanks,
>> > Inki Dae
>> >
>> > > +     if (IS_ERR(group)) {
>> > > +             dev_err(dev, "Failed to allocate IOMMU group\n");
>> > > +             return PTR_ERR(group);
>> > > +     }
>> > > +
>> > > +     ret = iommu_group_add_device(group, dev);
>> > > +     iommu_group_put(group);
>> > > +
>> > > +     return ret;
>> > > +}
>> > > +
>> > > +static void exynos_iommu_remove_device(struct device *dev)
>> > > +{
>> > > +     iommu_group_remove_device(dev);
>> > > +}
>> > > +
>> > >  static struct iommu_ops exynos_iommu_ops = {
>> > >       .domain_init = &exynos_iommu_domain_init,
>> > >       .domain_destroy = &exynos_iommu_domain_destroy,
>> > > @@ -1142,6 +1164,8 @@ static struct iommu_ops exynos_iommu_ops = {
>> > >       .map = &exynos_iommu_map,
>> > >       .unmap = &exynos_iommu_unmap,
>> > >       .iova_to_phys = &exynos_iommu_iova_to_phys,
>> > > +     .add_device     = exynos_iommu_add_device,
>> > > +     .remove_device  = exynos_iommu_remove_device,
>> > >       .pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
>> > >  };
>> > >
>> > > --
>> > > 1.8.1.2
>> > >
>> > > --
>> > > To unsubscribe from this list: send the line "unsubscribe linux-
>> samsung-
>> > > soc" in
>> > > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >
>
