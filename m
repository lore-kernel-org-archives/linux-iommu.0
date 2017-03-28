From: Oza Oza via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [RFC PATCH 1/3] of/pci: dma-ranges to account highest possible
	host bridge dma_mask
Date: Tue, 28 Mar 2017 10:57:39 +0530
Message-ID: <CAMSpPPdnQdWeyTsnESRFx52gtxQLxwfPQwQgDFSN=katfW7suA@mail.gmail.com>
References: <1490419893-5073-1-git-send-email-oza.oza@broadcom.com>
	<CAL_JsqLtTiH7DhqKf_x7xy1KZYQyiOreK=M90HFr=8BDW9542w@mail.gmail.com>
Reply-To: Oza Oza <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAL_JsqLtTiH7DhqKf_x7xy1KZYQyiOreK=M90HFr=8BDW9542w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org" <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Mar 27, 2017 at 8:16 PM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Sat, Mar 25, 2017 at 12:31 AM, Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> wrote:
>> it is possible that PCI device supports 64-bit DMA addressing,
>> and thus it's driver sets device's dma_mask to DMA_BIT_MASK(64),
>> however PCI host bridge may have limitations on the inbound
>> transaction addressing. As an example, consider NVME SSD device
>> connected to iproc-PCIe controller.
>>
>> Currently, the IOMMU DMA ops only considers PCI device dma_mask
>> when allocating an IOVA. This is particularly problematic on
>> ARM/ARM64 SOCs where the IOMMU (i.e. SMMU) translates IOVA to
>> PA for in-bound transactions only after PCI Host has forwarded
>> these transactions on SOC IO bus. This means on such ARM/ARM64
>> SOCs the IOVA of in-bound transactions has to honor the addressing
>> restrictions of the PCI Host.
>>
>> current pcie frmework and of framework integration assumes dma-ranges
>> in a way where memory-mapped devices define their dma-ranges.
>> dma-ranges: (child-bus-address, parent-bus-address, length).
>>
>> but iproc based SOCs and even Rcar based SOCs has PCI world dma-ranges.
>> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
>
> If you implement a common function, then I expect to see other users
> converted to use it. There's also PCI hosts in arch/powerpc that parse
> dma-ranges.

the common function should be similar to what
of_pci_get_host_bridge_resources is doing right now.
it parses ranges property right now.

the new function would look look following.

of_pci_get_dma_ranges(struct device_node *dev, struct list_head *resources)
where resources would return the dma-ranges.

but right now if you see the patch, of_dma_configure calls the new
function, which actually returns the largest possible size.
so this new function has to be generic in a way where other PCI hosts
can use it. but certainly iproc(Broadcom SOC) , rcar based SOCs can
use it for sure.

although having powerpc using it;  is a separate exercise, since I do
not have any access to other PCI hosts such as powerpc. but we can
workout with them on thsi forum if required.

so overall, of_pci_get_dma_ranges has to serve following 2 purposes.

1) it has to return largest possible size to of_dma_configure to
generate largest possible dma_mask.

2) it also has to return resources (dma-ranges) parsed, to the users.

so to address above needs

of_pci_get_dma_ranges(struct device_node *dev, struct list_head
*resources, u64 *size)

dev -> device node.
resources -> dma-ranges in allocated list.
size -> highest possible size to generate possible dma_mask for
of_dma_configure.

let em know how this sounds.

Regards,
Oza.
