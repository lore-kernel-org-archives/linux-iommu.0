From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 1/7] VFIO_IOMMU_TYPE1 workaround to build for platform devices
Date: Wed, 2 Oct 2013 14:14:54 +0200
Message-ID: <170DCB6D-6185-4C8A-977A-4DADF82DB274@suse.de>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com> <1380554923-17818-2-git-send-email-a.motakis@virtualopensystems.com> <1380562782.2674.178.camel@ul30vt.home> <9F6FE96B71CF29479FF1CDC8046E15036D37D9@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E15036D37D9@039-SN1MPN1-003.039d.mgd.msft.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Yoder Stuart-B08248 <B08248@freescale.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Antonios Motakis <a.motakis@virtualopensystems.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "tech@virtualopensystems.com" <tech@virtualopensystems.com>, "'kim.phillips@linaro.org'" <kim.phillips@linaro.org>
List-Id: iommu@lists.linux-foundation.org


On 01.10.2013, at 21:21, Yoder Stuart-B08248 wrote:

>>> static int __init vfio_iommu_type1_init(void)
>>> {
>>> -	if (!iommu_present(&pci_bus_type))
>>> +#ifdef CONFIG_PCI
>>> +	if (iommu_present(&pci_bus_type)) {
>>> +		iommu_bus_type = &pci_bus_type;
>>> +		/* For PCI targets, IOMMU_CAP_INTR_REMAP is required */
>>> +		require_cap_intr_remap = true;
>>> +	}
>>> +#endif
>>> +	if (!iommu_bus_type && iommu_present(&platform_bus_type))
>>> +		iommu_bus_type = &platform_bus_type;
>>> +
>>> +	if(!iommu_bus_type)
>>> 		return -ENODEV;
>>> 
>>> 	return vfio_register_iommu_driver(&vfio_iommu_driver_ops_type1);
>> 
>> Is it possible to have a system with both PCI and platform devices?  How
>> would you support that?  Thanks,
> 
> It most certainly is a requirement to support both.  This is how
> all of our (FSL) SoCs will expect to work.

I thought the PCI bus emits a cookie that the system wide IOMMU can then use to differentiate the origin of the transaction? So the same IOMMU can be used for PCI as well as platform routing.


Alex
