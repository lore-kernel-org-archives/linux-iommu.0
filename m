From: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/7] VFIO_IOMMU_TYPE1 workaround to build for platform
	devices
Date: Mon, 28 Oct 2013 21:17:26 -0400
Message-ID: <526F0CA6.5080307@redhat.com>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
	<1380554923-17818-2-git-send-email-a.motakis@virtualopensystems.com>
	<1380562782.2674.178.camel@ul30vt.home>
	<9F6FE96B71CF29479FF1CDC8046E15036D37D9@039-SN1MPN1-003.039d.mgd.msft.net>
	<170DCB6D-6185-4C8A-977A-4DADF82DB274@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <170DCB6D-6185-4C8A-977A-4DADF82DB274-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>
Cc: "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'kim.phillips-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org'" <kim.phillips-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org" <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 10/02/2013 08:14 AM, Alexander Graf wrote:
>
> On 01.10.2013, at 21:21, Yoder Stuart-B08248 wrote:
>
>>>> static int __init vfio_iommu_type1_init(void)
>>>> {
>>>> -	if (!iommu_present(&pci_bus_type))
>>>> +#ifdef CONFIG_PCI
>>>> +	if (iommu_present(&pci_bus_type)) {
>>>> +		iommu_bus_type =&pci_bus_type;
>>>> +		/* For PCI targets, IOMMU_CAP_INTR_REMAP is required */
>>>> +		require_cap_intr_remap = true;
>>>> +	}
>>>> +#endif
>>>> +	if (!iommu_bus_type&&  iommu_present(&platform_bus_type))
>>>> +		iommu_bus_type =&platform_bus_type;
>>>> +
>>>> +	if(!iommu_bus_type)
>>>> 		return -ENODEV;
>>>>
>>>> 	return vfio_register_iommu_driver(&vfio_iommu_driver_ops_type1);
>>>
>>> Is it possible to have a system with both PCI and platform devices?  How
>>> would you support that?  Thanks,
>>
>> It most certainly is a requirement to support both.  This is how
>> all of our (FSL) SoCs will expect to work.
>
> I thought the PCI bus emits a cookie that the system wide IOMMU can then use to differentiate the origin of the transaction? So the same IOMMU can be used for PCI as well as platform routing.
>
*can* be the same IOMMU, yes;
have to, no, so there can be multiple IOMMUs of different types.

>
> Alex
>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
