From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v1 7/7] iommu/arm-smmu-v3: Enable ACPI based HiSilicon
 erratum 161010801
Date: Wed, 17 May 2017 09:05:20 +0100
Message-ID: <2271be83-fd92-a3d9-ce61-a5471cde51be@huawei.com>
References: <20170513094731.3676-1-shameerali.kolothum.thodi@huawei.com>
 <20170513094731.3676-8-shameerali.kolothum.thodi@huawei.com>
 <a4e62cb2-9eb6-99a0-3443-df77ae9af8f8@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA838350A62@FRAEML521-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA838350A62-WFPaWmAhWqtUuCJht5byYAK1hpo4iccwjNknBlVQO8k@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org" <devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "Wangzhou (B)" <wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "Guohanjun (Hanjun Guo)" <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 16/05/2017 15:03, Shameerali Kolothum Thodi wrote:
>> > Lorenzo made a point that it might be relatively straightforward to just
>> > follow the IORT mapping for the SMMU through to the ITS MADT entry and
>> > pull the ITS geometry out of that. It would certainly be nicer to have
>> > such a helper abstracted away in the IORT code than have to go parsing
>> > vendor-specific tables directly in the SMMU driver. I reckon it might be
>> > worth taking that idea a bit further to see how it looks.
> Ok. John has already mentioned this idea in our off-list discussion and we
> have one implementation where we go through the IORT node ID mappings
> array to find out the associated IORT ITS  node. It then iterates over the ACPI
> MADT  GIC ITS table entries, , looking for a match for the GIC ITS id, and
> retrieves the base address of the matching ITS.
>
> But as you said, it requires some helper from the IORT code , otherwise we
> will end up adding all the ACPI table parse code in SMMUv3. We will take
> another look at this.
>
> Thanks,
> Shameer
>

It could also be worth considering hard-coding the reserved address in 
the SMMUv3 driver for this model. This would not involve (more) reliance 
on CSRT or IORT driver. However, note that hip07 has multiple SMMUs, and 
we only need to enable the quirk for the SMMU in front the PCIe host 
controller.

John

BTW, FYI, hi161x is alias for hip07/06


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
