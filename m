From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH 06/10] iommu: of: Handle IOMMU lookup failure with
	deferred probing or error
Date: Wed, 30 Nov 2016 19:31:10 +0530
Message-ID: <001601d24b12$384b7710$a8e26530$@codeaurora.org>
References: <1480465344-11862-1-git-send-email-sricharan@codeaurora.org>
	<CGME20161130002345epcas1p2486d2d61930d132210d9cb7d19bcbb48@epcas1p2.samsung.com>
	<1480465344-11862-7-git-send-email-sricharan@codeaurora.org>
	<8e91ce72-9d37-f4be-9224-856a1a4c3e1d@samsung.com>
	<5043bd01-2fc3-851d-2d6f-ba5fea96c774@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5043bd01-2fc3-851d-2d6f-ba5fea96c774-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Robin Murphy' <robin.murphy-5wv7dgnIgG8@public.gmane.org>, 'Marek Szyprowski' <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

>On 30/11/16 07:54, Marek Szyprowski wrote:
>> Hi Sricharan and Robin,
>>
>>
>> On 2016-11-30 01:22, Sricharan R wrote:
>>> From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
>>>
>>> Failures to look up an IOMMU when parsing the DT iommus property need to
>>> be handled separately from the .of_xlate() failures to support deferred
>>> probing.
>>>
>>> The lack of a registered IOMMU can be caused by the lack of a driver for
>>> the IOMMU, the IOMMU device probe not having been performed yet, having
>>> been deferred, or having failed.
>>>
>>> The first case occurs when the device tree describes the bus master and
>>> IOMMU topology correctly but no device driver exists for the IOMMU yet
>>> or the device driver has not been compiled in. Return NULL, the caller
>>> will configure the device without an IOMMU.
>>>
>>> The second and third cases are handled by deferring the probe of the bus
>>> master device which will eventually get reprobed after the IOMMU.
>>>
>>> The last case is currently handled by deferring the probe of the bus
>>> master device as well. A mechanism to either configure the bus master
>>> device without an IOMMU or to fail the bus master device probe depending
>>> on whether the IOMMU is optional or mandatory would be a good
>>> enhancement.
>>>
>>> Signed-off-by: Laurent Pichart
>>> <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
>>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>> [rm: massive PCI hacks]
>>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>>> ---
>>>   drivers/base/dma-mapping.c | 4 ++--
>>>   drivers/iommu/dma-iommu.c  | 1 +
>>>   drivers/iommu/of_iommu.c   | 5 +++--
>>>   drivers/of/device.c        | 9 +++++++--
>>>   drivers/pci/probe.c        | 6 ++++--
>>>   include/linux/of_device.h  | 9 ++++++---
>>>   include/linux/pci.h        | 4 ++--
>>>   7 files changed, 25 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
>>> index b2a5629..576fdfb 100644
>>> --- a/drivers/base/dma-mapping.c
>>> +++ b/drivers/base/dma-mapping.c
>>> @@ -351,9 +351,9 @@ void dma_common_free_remap(void *cpu_addr, size_t
>>> size, unsigned long vm_flags)
>>>   int dma_configure(struct device *dev)
>>>   {
>>>       if (dev_is_pci(dev))
>>> -        pci_dma_configure(dev);
>>> +        return pci_dma_configure(dev);
>>>       else if (dev->of_node)
>>> -        of_dma_configure(dev, dev->of_node);
>>> +        return of_dma_configure(dev, dev->of_node);
>>>       return 0;
>>>   }
>>>   diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index c5ab866..d2a7a46 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -148,6 +148,7 @@ int iommu_dma_init_domain(struct iommu_domain
>>> *domain, dma_addr_t base,
>>>       base_pfn = max_t(unsigned long, 1, base >> order);
>>>       end_pfn = (base + size - 1) >> order;
>>>   +    dev_info(dev, "0x%llx 0x%llx, 0x%llx 0x%llx, 0x%llx 0x%llx\n",
>>> base, size, domain->geometry.aperture_start,
>>> domain->geometry.aperture_end,
>>
>> This causes a NULL pointer dereference if caller passes NULL device
>> pointer.
>> There is such caller in drivers/gpu/drm/exynos/exynos_drm_iommu.h.
>> Trivial to fix as it looks like a leftover from developement or
>> debugging stage.
>
>Yes, this is some development crap which was never intended to go
>upstream. Hence "massive PCI hacks" ;)
>
>Other than the first two patches, the rest of the stuff from me here was
>just an experiment which I'm not entirely convinced by the outcome of -
>I don't particularly like the resulting fragmentation of having
>pci_dma_configure() awkwardly floating around on its own in pci.c.

Ha, sorry looks like that i have misunderstood that then. I thought that
the V3 changes that i had for pci was hacky and the reworked patches
in your latest branch were correct. So do you suggest that the
pci_dma_configure gets removed and the pci related changes gets handled
in of_iommu_configure /acpi_dma_configure itself ?

Regards,
Sricharan
