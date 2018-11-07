From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] of/device: Really only set bus DMA mask when appropriate
Date: Wed, 7 Nov 2018 12:36:44 +0000
Message-ID: <236295cc-1203-f65d-abf8-4d367836d70e@arm.com>
References: <b06321ac25a1211e572e650a630e5e1aa9f8173f.1541504601.git.robin.murphy@arm.com>
	<20181107103150.GA14853@rric.localdomain>
	<20181107120821.GK3795@rric.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181107120821.GK3795-vWBEXY7mpu582hYKe6nXyg@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Richter, Robert" <Robert.Richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "aaro.koskinen-X3B1VOXEql0@public.gmane.org" <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, "jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org" <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, "john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 2018-11-07 12:08 pm, Richter, Robert wrote:
> On 07.11.18 11:31:50, Robert Richter wrote:
>> On 06.11.18 11:54:15, Robin Murphy wrote:
>>> of_dma_configure() was *supposed* to be following the same logic as
>>> acpi_dma_configure() and only setting bus_dma_mask if some range was
>>> specified by the firmware. However, it seems that subtlety got lost in
>>> the process of fitting it into the differently-shaped control flow, and
>>> as a result the force_dma==true case ends up always setting the bus mask
>>> to the 32-bit default, which is not what anyone wants.
>>>
>>> Make sure we only touch it if the DT actually said so.
>>>
>>> Fixes: 6c2fb2ea7636 ("of/device: Set bus DMA mask as appropriate")
>>> Reported-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
>>> Reported-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
>>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>>
>> Tested-by: Robert Richter <robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>>
>> This patch makes the bad page state message on Cavium ThunderX below
>> disappear.
>>
>> Note: The Fixes: tag suggests the issue was already in 4.19, but I
>> have seen it in 4.20-rc1 first and it was pulled into mainline with:
>>
>>   cff229491af5 Merge tag 'dma-mapping-4.20' of git://git.infradead.org/users/hch/dma-mapping
> 
> I have bisected it and the issue was seen first with:
> 
>   b4ebe6063204 dma-direct: implement complete bus_dma_mask handling

Right, that was the point at which the underlying problem started 
interacting with SWIOTLB and making arm64 unhappy - the prior effect in 
in 4.19 was to inadvertently break DT-based dma_direct_ops users (like 
MIPS), whom the above commit actually partially unbroke again.

Thanks for testing,
Robin.

> 
>>
>> -Robert
>>
>>
>> [   37.634555] BUG: Bad page state in process swapper/5  pfn:f3ebb
>> [   37.640483] page:ffff7e0003cfaec0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
>> [   37.648493] flags: 0xffff00000001000(reserved)
>> [   37.652942] raw: 0ffff00000001000 ffff7e0003cfaec8 ffff7e0003cfaec8 0000000000000000
>> [   37.660691] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
>> [   37.668438] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>> [   37.674880] bad because of flags: 0x1000(reserved)
>> [   37.679672] Modules linked in: ip6t_REJECT nf_reject_ipv6 xt_tcpudp ipt_REJECT nf_reject_ipv4 xt_conntrack ip6table_nat nf_nat_ipv6 ip6table_mangle iptable_nat nf_nat_ipv4 nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle ip6table_filter ip6_tables iptable_filter crct10dif_ce cavium_rng_vf rng_core ipmi_ssif thunderx_zip thunderx_edac ipmi_devintf cavium_rng ipmi_msghandler ip_tables x_tables xfs libcrc32c nicvf nicpf thunder_bgx thunder_xcv i2c_thunderx mdio_thunder mdio_cavium ipv6
>> [   37.723866] CPU: 5 PID: 0 Comm: swapper/5 Not tainted 4.20.0-rc1-00012-gc106b1cbe843 #1
>> [   37.731874] Hardware name: Cavium ThunderX CRB/To be filled by O.E.M., BIOS 5.11 12/12/2012
>> [   37.740228] Call trace:
>> [   37.742677]  dump_backtrace+0x0/0x148
>> [   37.746334]  show_stack+0x14/0x1c
>> [   37.749643]  dump_stack+0x84/0xa8
>> [   37.752954]  bad_page+0xe4/0x144
>> [   37.756178]  free_pages_check_bad+0x7c/0x84
>> [   37.760355]  __free_pages_ok+0x22c/0x284
>> [   37.764272]  page_frag_free+0x64/0x68
>> [   37.767930]  skb_free_head+0x24/0x2c
>> [   37.771500]  skb_release_data+0x130/0x148
>> [   37.775504]  skb_release_all+0x24/0x30
>> [   37.779246]  kfree_skb+0x2c/0x54
>> [   37.782471]  ip_error+0x70/0x1d4
>> [   37.785693]  ip_rcv_finish+0x3c/0x50
>> [   37.789262]  ip_rcv+0xc0/0xd0
>> [   37.792225]  __netif_receive_skb_one_core+0x4c/0x70
>> [   37.797099]  __netif_receive_skb+0x2c/0x70
>> [   37.801190]  netif_receive_skb_internal+0x64/0x160
>> [   37.805976]  napi_gro_receive+0xa0/0xc4
>> [   37.809815]  nicvf_cq_intr_handler+0x930/0xc1c [nicvf]
>> [   37.814950]  nicvf_poll+0x30/0xb0 [nicvf]
>> [   37.818954]  net_rx_action+0x140/0x2f8
>> [   37.822697]  __do_softirq+0x11c/0x228
>> [   37.826354]  irq_exit+0xbc/0xd0
>> [   37.829491]  __handle_domain_irq+0x6c/0xb4
>> [   37.833581]  gic_handle_irq+0x8c/0x1a0
>> [   37.837324]  el1_irq+0xb0/0x128
>> [   37.840459]  arch_cpu_idle+0x10/0x18
>> [   37.844031]  default_idle_call+0x18/0x28
>> [   37.847948]  do_idle+0x194/0x258
>> [   37.851169]  cpu_startup_entry+0x20/0x24
>> [   37.855089]  secondary_start_kernel+0x144/0x168
>>
>>
>>> ---
>>>
>>> Sorry about that... I guess I only have test setups that either have
>>> dma-ranges or where a 32-bit bus mask goes unnoticed :(
>>>
>>> The Octeon and SMMU issues sound like they're purely down to this, and
>>> it's probably related to at least one of John's Hikey woes.
>>>
>>> Robin.
>>>
>>>   drivers/of/device.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>>> index 0f27fad9fe94..757ae867674f 100644
>>> --- a/drivers/of/device.c
>>> +++ b/drivers/of/device.c
>>> @@ -149,7 +149,8 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
>>>   	 * set by the driver.
>>>   	 */
>>>   	mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1);
>>> -	dev->bus_dma_mask = mask;
>>> +	if (!ret)
>>> +		dev->bus_dma_mask = mask;
>>>   	dev->coherent_dma_mask &= mask;
>>>   	*dev->dma_mask &= mask;
>>>   
>>> -- 
>>> 2.19.1.dirty
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
