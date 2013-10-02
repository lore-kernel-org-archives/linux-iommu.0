From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [PATCH 1/7] VFIO_IOMMU_TYPE1 workaround to build for platform
	devices
Date: Wed, 2 Oct 2013 13:13:46 +0200
Message-ID: <CAG8rG2yAp2+RhUcHb78VD0GoiT6NBftX1JCqSmyNf+iP5N3now@mail.gmail.com>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
	<1380554923-17818-2-git-send-email-a.motakis@virtualopensystems.com>
	<1380562782.2674.178.camel@ul30vt.home>
	<9F6FE96B71CF29479FF1CDC8046E15036D37D9@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E15036D37D9-TcFNo7jSaXOLgTCmFNXF2K4g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kim.phillips-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <kim.phillips-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org" <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Oct 1, 2013 at 9:21 PM, Yoder Stuart-B08248
<B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
>> >  static int __init vfio_iommu_type1_init(void)
>> >  {
>> > -   if (!iommu_present(&pci_bus_type))
>> > +#ifdef CONFIG_PCI
>> > +   if (iommu_present(&pci_bus_type)) {
>> > +           iommu_bus_type = &pci_bus_type;
>> > +           /* For PCI targets, IOMMU_CAP_INTR_REMAP is required */
>> > +           require_cap_intr_remap = true;
>> > +   }
>> > +#endif
>> > +   if (!iommu_bus_type && iommu_present(&platform_bus_type))
>> > +           iommu_bus_type = &platform_bus_type;
>> > +
>> > +   if(!iommu_bus_type)
>> >             return -ENODEV;
>> >
>> >     return vfio_register_iommu_driver(&vfio_iommu_driver_ops_type1);
>>
>> Is it possible to have a system with both PCI and platform devices?  How
>> would you support that?  Thanks,
>
> It most certainly is a requirement to support both.  This is how
> all of our (FSL) SoCs will expect to work.
>

Both with an IOMMU present?

> I need to understand better why 'iommu_bus_type' exists at
> all...

It exists because the API expects to know the bus type. Ideally, this
would be solved at the IOMMU API level, and we would be able to be
completely bus agnostic in the TYPE1 driver.

>
> Stuart
