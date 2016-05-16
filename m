From: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Subject: Re: [RFC PATCH 09/11] drivers: acpi: implement acpi_dma_configure
Date: Mon, 16 May 2016 17:26:03 +0200
Message-ID: <5739E68B.2080907@semihalf.com>
References: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1460654743-7896-10-git-send-email-lorenzo.pieralisi@arm.com>
	<CAOZdJXXtZq6uyE+5sseX7M_6Kq8wFG+37qd5TNSusKj=0gd8zA@mail.gmail.com>
	<5714BA5A.2040008@arm.com> <5739E416.6000501@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5739E416.6000501-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Timur Tabi <timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, vikrams-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 16.05.2016 17:15, Tomasz Nowicki wrote:
> On 18.04.2016 12:43, Robin Murphy wrote:
>> On 15/04/16 19:29, Timur Tabi wrote:
>>> On Thu, Apr 14, 2016 at 12:25 PM, Lorenzo Pieralisi
>>> <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org> wrote:
>>>> +void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
>>>> +{
>>>> +       struct iommu_ops *iommu;
>>>> +
>>>> +       iommu = iort_iommu_configure(dev);
>>>> +
>>>> +       /*
>>>> +        * Assume dma valid range starts at 0 and covers the whole
>>>> +        * coherent_dma_mask.
>>>> +        */
>>>> +       arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, iommu,
>>>> +                          attr == DEV_DMA_COHERENT);
>>>> +}
>>>
>>> I have a network driver that is impacted by this code, so thank you
>>> for posting this. (See
>>> https://www.mail-archive.com/netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg106249.html).
>>>
>>> One one SOC, the driver needs to set the mask to 32 bits.  On another
>>> SOC, it needs to set it to 64 bits.  On device tree, the driver will
>>> use dma-ranges.
>>
>> That's the wrong way to look at it - the driver isn't _using_
>> dma-ranges, you're merely relying on the OF code setting the _default_
>> DMA mask differently based on the property. If your driver is in the
>> minority of those which actually care about DMA masks, then it should be
>> calling dma_set_mask_and_coherent() appropriately and not relying on the
>> default.
>
> I don't see the clear strategy for setting DMA mask as well.
>
> Lets consider DT boot method example:
> 1. SMMUv2 supports 48bit translation and 1:1 address map
> dma-ranges = <0x0 0x0 0x0 0x0 0x00010000 0x0>;
> and we are adding PCI device:
>
> pci_device_add -> DMA_BIT_MASK(32) by default
>    pci_dma_configure
>      of_dma_configure -> reads dma-ranges and calculates 48bit DMA mask,
> but it picks minimum, we stay with DMA_BIT_MASK(32)
>
> now PCI dev turns out to be e1000e NIC:
> e1000_probe
>    dma_set_mask_and_coherent -> tries to set DMA_BIT_MASK(64)
>      dma_set_mask -> there is no set_dma_mask ops for SMMUv2 so we let

Sorry, there is no .set_dma_mask ops for ARM64 (not SMMUv2)

Tomasz
