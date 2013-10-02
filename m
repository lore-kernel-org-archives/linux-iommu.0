From: Yoder Stuart-B08248 <B08248@freescale.com>
Subject: RE: [PATCH 1/7] VFIO_IOMMU_TYPE1 workaround to build for platform
 devices
Date: Wed, 2 Oct 2013 12:55:40 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E15036D3D28@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
	<1380554923-17818-2-git-send-email-a.motakis@virtualopensystems.com>
	<1380562782.2674.178.camel@ul30vt.home>
	<9F6FE96B71CF29479FF1CDC8046E15036D37D9@039-SN1MPN1-003.039d.mgd.msft.net>
 <CAG8rG2yAp2+RhUcHb78VD0GoiT6NBftX1JCqSmyNf+iP5N3now@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAG8rG2yAp2+RhUcHb78VD0GoiT6NBftX1JCqSmyNf+iP5N3now@mail.gmail.com>
Content-Language: en-US
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Antonios Motakis <a.motakis@virtualopensystems.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "agraf@suse.de" <agraf@suse.de>, "tech@virtualopensystems.com" <tech@virtualopensystems.com>, "kim.phillips@linaro.org" <kim.phillips@linaro.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Antonios Motakis [mailto:a.motakis@virtualopensystems.com]
> Sent: Wednesday, October 02, 2013 6:14 AM
> To: Yoder Stuart-B08248
> Cc: Alex Williamson; kvmarm@lists.cs.columbia.edu; iommu@lists.linux-
> foundation.org; linux-samsung-soc@vger.kernel.org; kvm@vger.kernel.org;
> agraf@suse.de; tech@virtualopensystems.com; kim.phillips@linaro.org
> Subject: Re: [PATCH 1/7] VFIO_IOMMU_TYPE1 workaround to build for
> platform devices
> 
> On Tue, Oct 1, 2013 at 9:21 PM, Yoder Stuart-B08248
> <B08248@freescale.com> wrote:
> >> >  static int __init vfio_iommu_type1_init(void)
> >> >  {
> >> > -   if (!iommu_present(&pci_bus_type))
> >> > +#ifdef CONFIG_PCI
> >> > +   if (iommu_present(&pci_bus_type)) {
> >> > +           iommu_bus_type = &pci_bus_type;
> >> > +           /* For PCI targets, IOMMU_CAP_INTR_REMAP is required */
> >> > +           require_cap_intr_remap = true;
> >> > +   }
> >> > +#endif
> >> > +   if (!iommu_bus_type && iommu_present(&platform_bus_type))
> >> > +           iommu_bus_type = &platform_bus_type;
> >> > +
> >> > +   if(!iommu_bus_type)
> >> >             return -ENODEV;
> >> >
> >> >     return vfio_register_iommu_driver(&vfio_iommu_driver_ops_type1);
> >>
> >> Is it possible to have a system with both PCI and platform devices?
> How
> >> would you support that?  Thanks,
> >
> > It most certainly is a requirement to support both.  This is how
> > all of our (FSL) SoCs will expect to work.
> >
> 
> Both with an IOMMU present?

Yes.  We expect to be able to pass through PCI devices and
platform devices at the same time...all with IOMMU isolation.

Stuart
