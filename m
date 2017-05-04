From: Oza Oza via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH 1/3] of/pci/dma: fix DMA configuration for PCI masters
Date: Fri, 5 May 2017 00:42:41 +0530
Message-ID: <CAMSpPPeJ-uADj19OygoEyBQaw+V2scz7c_2a8x=-_qujBGcLhA@mail.gmail.com>
References: <1493786795-28153-1-git-send-email-oza.oza@broadcom.com>
	<d7203258-e39a-a59b-d14f-c0c92a1d3f41@arm.com>
Reply-To: Oza Oza <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <d7203258-e39a-a59b-d14f-c0c92a1d3f41-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oza Pawandeep <oza.pawandeep-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, BCM Kernel Feedback <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, May 4, 2017 at 11:32 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> [apologies for the silence - I've been on holiday]
>
> On 03/05/17 05:46, Oza Pawandeep wrote:
>> current device framework and of framework integration assumes
>> dma-ranges in a way where memory-mapped devices define their
>> dma-ranges. (child-bus-address, parent-bus-address, length).
>
> Well, yes, that is simply the definition of dma-ranges, and remains true
> regardless of the particular format of either bus address.
>
>> of_dma_configure is specifically written to take care of memory
>> mapped devices. but no implementation exists for pci to take
>> care of pcie based memory ranges.
>
> That still doesn't make sense. To repeat myself again, PCI devices *ARE*
> memory-mapped devices. Yes, there do exist some platforms where I/O
> space is not treated as MMIO, but config space and memory space are very
> much memory-mapped however you look at them, and in the context of DMA,
> only memory space is relevant anyway.
>
> What *is* true about the current code is that of_dma_get_range() expects
> to be passed an OF node representing the device itself, and doesn't work
> properly when passed the node of the device's parent bus directly, which
> happens to be what pci_dma_configure() currently does. That's the only
> reason why it doesn't work for (single-entry) host controller dma-ranges
> today. This does not mean it's a PCI problem, it is simply the case that
> pci_dma_configure() is the only caller currently hitting it. Other
> discoverable, DMA-capable buses like fsl-mc are still going to face the
> exact same problem with or without this patch.
>

the new v2 is hooking callbacks for defualt and pci bus.
so now the implementation will not really look cluttered.
and for fsl-mc buses, we could choose to implement it in default bus callbacks.
will post the patch-set soon.

also with these patch-set we really do not need to prepare emulated child node.


>> for e.g. iproc based SOCs and other SOCs(suc as rcar) have PCI
>> world dma-ranges.
>> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
>>
>> this patch serves following:
>>
>> 1) exposes interface to the pci host driver for their
>> inbound memory ranges
>>
>> 2) provide an interface to callers such as of_dma_get_ranges.
>> so then the returned size get best possible (largest) dma_mask.
>> because PCI RC drivers do not call APIs such as
>> dma_set_coherent_mask() and hence rather it shows its addressing
>> capabilities based on dma-ranges.
>> for e.g.
>> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
>> we should get dev->coherent_dma_mask=0x7fffffffff.
>>
>> 3) this patch handles multiple inbound windows and dma-ranges.
>> it is left to the caller, how it wants to use them.
>> the new function returns the resources in a standard and unform way
>>
>> 4) this way the callers of for e.g. of_dma_get_ranges
>> does not need to change.
>>
>> 5) leaves scope of adding PCI flag handling for inbound memory
>> by the new function.
>
> Which flags would ever actually matter? DMA windows aren't going to be
> to config or I/O space, so the memory type can be assumed, and the
> 32/64-bit distinction is irrelevant as it's not a relocatable BAR;
> DMA-able system memory isn't going to be read-sensitive, so the
> prefetchable flag shouldn't matter; and not being a BAR none of the
> others would be relevant either.
>
>>
>> Bug: SOC-5216
>> Change-Id: Ie045386df91e1e0587846bb147ae40d96f6d7d2e
>> Signed-off-by: Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Reviewed-on: http://gerrit-ccxsw.broadcom.net/40428
>> Reviewed-by: vpx_checkpatch status <vpx_checkpatch-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Reviewed-by: CCXSW <ccxswbuild-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Reviewed-by: Ray Jui <ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Tested-by: vpx_autobuild status <vpx_autobuild-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Tested-by: vpx_smoketest status <vpx_smoketest-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Tested-by: CCXSW <ccxswbuild-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Reviewed-by: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>>
>> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
>> index 0ee42c3..ed6e69a 100644
>> --- a/drivers/of/of_pci.c
>> +++ b/drivers/of/of_pci.c
>> @@ -283,6 +283,83 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
>>       return err;
>>  }
>>  EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
>> +
>> +/**
>> + * of_pci_get_dma_ranges - Parse PCI host bridge inbound resources from DT
>> + * @np: device node of the host bridge having the dma-ranges property
>> + * @resources: list where the range of resources will be added after DT parsing
>> + *
>> + * It is the caller's job to free the @resources list.
>> + *
>> + * This function will parse the "dma-ranges" property of a
>> + * PCI host bridge device node and setup the resource mapping based
>> + * on its content.
>> + *
>> + * It returns zero if the range parsing has been successful or a standard error
>> + * value if it failed.
>> + */
>> +
>> +int of_pci_get_dma_ranges(struct device_node *np, struct list_head *resources)
>> +{
>> +     struct device_node *node = of_node_get(np);
>> +     int rlen;
>> +     int ret = 0;
>> +     const int na = 3, ns = 2;
>> +     struct resource *res;
>> +     struct of_pci_range_parser parser;
>> +     struct of_pci_range range;
>> +
>> +     if (!node)
>> +             return -EINVAL;
>> +
>> +     parser.node = node;
>> +     parser.pna = of_n_addr_cells(node);
>> +     parser.np = parser.pna + na + ns;
>> +
>> +     parser.range = of_get_property(node, "dma-ranges", &rlen);
>> +
>> +     if (!parser.range) {
>> +             pr_debug("pcie device has no dma-ranges defined for node(%s)\n",
>> +                       np->full_name);
>> +             ret = -EINVAL;
>> +             goto out;
>> +     }
>> +
>> +     parser.end = parser.range + rlen / sizeof(__be32);
>> +
>> +     for_each_of_pci_range(&parser, &range) {
>
> This is plain wrong - of_pci_range_parser_one() will translate upwards
> through parent "ranges" properties, which is completely backwards for
> DMA addresses.
>
> Robin.
>
>> +             /*
>> +              * If we failed translation or got a zero-sized region
>> +              * then skip this range
>> +              */
>> +             if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
>> +                     continue;
>> +
>> +             res = kzalloc(sizeof(struct resource), GFP_KERNEL);
>> +             if (!res) {
>> +                     ret = -ENOMEM;
>> +                     goto parse_failed;
>> +             }
>> +
>> +             ret = of_pci_range_to_resource(&range, np, res);
>> +             if (ret) {
>> +                     kfree(res);
>> +                     continue;
>> +             }
>> +
>> +             pci_add_resource_offset(resources, res,
>> +                                     res->start - range.pci_addr);
>> +     }
>> +
>> +     return ret;
>> +
>> +parse_failed:
>> +     pci_free_resource_list(resources);
>> +out:
>> +     of_node_put(node);
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(of_pci_get_dma_ranges);
>>  #endif /* CONFIG_OF_ADDRESS */
>>
>>  #ifdef CONFIG_PCI_MSI
>> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
>> index 0e0974e..617b90d 100644
>> --- a/include/linux/of_pci.h
>> +++ b/include/linux/of_pci.h
>> @@ -76,6 +76,7 @@ static inline void of_pci_check_probe_only(void) { }
>>  int of_pci_get_host_bridge_resources(struct device_node *dev,
>>                       unsigned char busno, unsigned char bus_max,
>>                       struct list_head *resources, resource_size_t *io_base);
>> +int of_pci_get_dma_ranges(struct device_node *np, struct list_head *resources);
>>  #else
>>  static inline int of_pci_get_host_bridge_resources(struct device_node *dev,
>>                       unsigned char busno, unsigned char bus_max,
>> @@ -83,6 +84,12 @@ static inline int of_pci_get_host_bridge_resources(struct device_node *dev,
>>  {
>>       return -EINVAL;
>>  }
>> +
>> +static inline int of_pci_get_dma_ranges(struct device_node *np,
>> +                                     struct list_head *resources)
>> +{
>> +     return -EINVAL;
>> +}
>>  #endif
>>
>>  #if defined(CONFIG_OF) && defined(CONFIG_PCI_MSI)
>>
>
