From: Oleksandr <Oleksandr_Tyshchenko@epam.com>
Subject: Re: [v4,0/3] iommu/ipmmu-vmsa: r8a7796 support V4
Date: Tue, 12 Sep 2017 13:52:23 +0300
Message-ID: <9f59e912-24df-cfde-538c-f8c78480c29b@epam.com>
References: <149787025647.32495.1584960416060100962.sendpatchset@little-apple>
 <934fcc8c-4716-e027-12aa-297ad0e55535@epam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <934fcc8c-4716-e027-12aa-297ad0e55535@epam.com>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: joro@8bytes.org, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, horms+renesas@verge.net.au, robin.murphy@arm.com, m.szyprowski@samsung.com, olekstysh@gmail.com
List-Id: iommu@lists.linux-foundation.org


Hi, all.

Gentle reminder.

On 05.09.17 19:52, Oleksandr wrote:
>
> Hi, Magnus, maintainers, all.
>
> On 19.06.17 14:04, Magnus Damm wrote:
>> iommu/ipmmu-vmsa: r8a7796 support V4
>>
>> [PATCH v4 1/3] iommu/ipmmu-vmsa: Add r8a7796 DT binding
>> [PATCH v4 2/3] iommu/ipmmu-vmsa: Increase maximum micro-TLBS to 48
>> [PATCH v4 3/3] iommu/ipmmu-vmsa: Hook up r8a7796 DT matching code
>>
>> This series adds r8a7796 support to the IPMMU driver. The DT binding
>> gets updated, maximum number of micro-TLBs are increased and the
>> driver is adjusted to match on the new DT binding.
> I am interested in adding IPMMU-VMSA support to Xen hypervisor.
>
> I did some preparations for making IPMMU-VMSA to feel comfortable [1] 
> inside Xen
> followed by direct porting Linux IPMMU-VMSA driver and ARM LPAE 
> page-table allocator [2] to it.
>
> I decided to base on the "BSP" driver [3] because it had more complete 
> support than the "mainline" one [4].
>
> During review I got a feedback that "BSP" driver wasn't the best 
> choice to be ported.
> Xen ARM maintainers worry about "BSP" driver which haven't had a 
> thorough review by the Linux community and as the result might have 
> bugs which will never be fixed, etc.
>
> So, for the IPMMU-VMSA support to be accepted by Xen community I 
> should either write our own driver based on BSP/mainline/whatever 
> which contains only relevant to Xen things or
> direct port from "mainline" driver. As the second option relies on the 
> required support [5] which isn't in mainline yet, it is not clear when 
> this support gets merged and how it will be modified/reworked before,
> we preliminarily decided to follow the first option. But, I would like 
> to consider second option again. Despite the complexity of second 
> option, it has one significant benefit.
>
> I see that Linux driver is being developed quite actively and looking 
> over all related patch series I got a feeling that required support 
> was about to reach upstream.
>
> Could you, please, clarify some questions which, I hope, help us to 
> make a decision:
> 1. Do you have approximate time-frame for getting this support in?
> 2. Are fundamental/significant changes planned for this support?
>
> Also, may I ask for a link to github branch which contains current 
> (and likely r8a7795 and 32-bit ARM update) patch series?
>
> Thank you in advance!
>
> And sorry for the most likely incorrect format of this email.
>
> [1] https://www.mail-archive.com/xen-devel@lists.xen.org/msg115901.html
> [2] https://lists.xen.org/archives/html/xen-devel/2017-07/msg02679.html
> [3] 
> https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas-bsp.git/tree/drivers/iommu/ipmmu-vmsa.c?h=v4.9/rcar-3.5.3
> [4] 
> http://elixir.free-electrons.com/linux/latest/source/drivers/iommu/ipmmu-vmsa.c
> [5] 
> https://lists.linuxfoundation.org/pipermail/iommu/2017-June/022567.html
> https://lists.linuxfoundation.org/pipermail/iommu/2017-June/022577.html
>     https://lkml.org/lkml/2017/7/17/393
>>
>> Changes since V3:
>>   - Rebased on top of [PATCH v4 00/09] iommu/ipmmu-vmsa: r8a7795 
>> support V4
>>   - Patch 3/3 updated with Reviewed-by - thanks Geert!
>>
>> Changes since V2:
>>   - Patch 2/3 updated with an outer set of () - thanks Ramesh!
>>   - Patch 2/3 updated with Reviewed-by - thanks Geert!
>>   - Patch 3/3 updated to include white list support
>>
>> Changes since V1:
>>   - Patch 1/3 updated with more Acked-by tags
>>   - Patch 2/3 updated with high I/O register range support
>>
>> Patch 1/3 is ready for upstream merge and includes the following tags:
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Acked-by: Simon Horman <horms+renesas@verge.net.au>
>> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> Patch 2/3 and 3/3 are quite trivial but have no acked-by so far.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> ---
>>
>>   Developed on top of next-20170614 with the following series applied
>>   [PATCH 00/04] iommu/ipmmu-vmsa: 32-bit ARM update
>>   [PATCH v4 00/09] iommu/ipmmu-vmsa: r8a7795 support V4
>>
>>   Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt |    1
>>   drivers/iommu/ipmmu-vmsa.c |   24 +++++++---
>>   2 files changed, 18 insertions(+), 7 deletions(-)
>
