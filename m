From: Oza Oza <oza.oza@broadcom.com>
Subject: Re: [RFC PATH] of/pci/dma: fix DMA configruation for PCI masters
Date: Wed, 3 May 2017 10:21:48 +0530
Message-ID: <CAMSpPPcRNLcB4EQ4QuFt0ZkaTQWZsm88B38xwxpfWztDhZPnpA@mail.gmail.com>
References: <1492848487-11768-1-git-send-email-oza.oza@broadcom.com> <CAL_JsqKg9YuDd21eaoDXKfLUqyD05nWz7=SqxTKAL-Dcpp6MZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqKg9YuDd21eaoDXKfLUqyD05nWz7=SqxTKAL-Dcpp6MZw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Oza Pawandeep <oza.pawandeep@gmail.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 24, 2017 at 7:50 PM, Rob Herring <robh@kernel.org> wrote:
> On Sat, Apr 22, 2017 at 3:08 AM, Oza Pawandeep <oza.oza@broadcom.com> wrote:
>> current device frmework and of framework integration assumes dma-ranges
>> in a way where memory-mapped devices define their dma-ranges.
>> dma-ranges: (child-bus-address, parent-bus-address, length).
>>
>> but iproc based SOCs and other SOCs(suc as rcar) have PCI world dma-ranges.
>> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
>>
>> of_dma_configure is specifically witten to take care of memory mapped devices.
>> but no implementation exists for pci to take care of pcie based memory ranges.
>> in fact pci world doesnt seem to define standard dma-ranges
>>
>> this patch served following purposes
>>
>> 1) exposes intrface to the pci host driver for thir inbound memory ranges
>>
>> 2) provide an interface to callers such as of_dma_get_ranges.
>> so then the returned size get best possible (largest) dma_mask.
>> for e.g.
>> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
>> we should get dev->coherent_dma_mask=0x7fffffffff.
>>
>> 3) this patch handles multiple inbound windows and dma-ranges.
>> it is left to the caller, how it wants to use them.
>> the new function returns the resources in a standard and unform way
>>
>> 4) this way the callers of of_dma_get_ranges does not need to change.
>> and
>>
>> 5) leaves scope of adding PCI flag handling for inbound memory
>> by the new function.
>>
>> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
>>
>> diff --git a/drivers/of/address.c b/drivers/of/address.c
>> index 02b2903..ec21191 100644
>> --- a/drivers/of/address.c
>> +++ b/drivers/of/address.c
>> @@ -6,6 +6,7 @@
>>  #include <linux/ioport.h>
>>  #include <linux/module.h>
>>  #include <linux/of_address.h>
>> +#include <linux/of_pci.h>
>>  #include <linux/pci.h>
>>  #include <linux/pci_regs.h>
>>  #include <linux/sizes.h>
>> @@ -829,10 +830,30 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
>>         int len, naddr, nsize, pna;
>>         int ret = 0;
>>         u64 dmaaddr;
>> +       struct resource_entry *window;
>> +       LIST_HEAD(res);
>>
>>         if (!node)
>>                 return -EINVAL;
>>
>> +       if (strcmp(np->name, "pci")) {
>
> Using the name is not reliable though I did recently add a dtc check
> for this. Of course, 'pcie' is valid too (and probably should be used
> for what you are testing). type is what you want to use here. We
> already have bus matching function and bus specific handlers in
> address.c. Whatever solution you come up with should be integrated
> with the existing bus specific handlers.
>
> Rob

Hi Rob,

I have addressed your comments.

now I have pushed 3 patchsets, which completely solves the problem for our SOC.

[PATCH 1/3] of/pci/dma: fix DMA configuration for PCI masters.

Regards,
Oza.
