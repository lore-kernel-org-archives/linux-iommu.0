From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 4/5] iommu/mediatek: add support for mtk iommu
 generation one HW
Date: Tue, 24 May 2016 16:36:45 +0100
Message-ID: <5744750D.9080006@arm.com>
References: <1463658558-567-1-git-send-email-honghui.zhang@mediatek.com>
 <1463658558-567-5-git-send-email-honghui.zhang@mediatek.com>
 <57435AA1.3090602@arm.com> <1464083839.30939.54.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464083839.30939.54.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: Honghui Zhang <honghui.zhang@mediatek.com>
Cc: joro@8bytes.org, treding@nvidia.com, mark.rutland@arm.com, matthias.bgg@gmail.com, robh@kernel.org, youlin.pei@mediatek.com, devicetree@vger.kernel.org, pebolle@tiscali.nl, kendrick.hsu@mediatek.com, arnd@arndb.de, srv_heupstream@mediatek.com, catalin.marinas@arm.com, erin.lo@mediatek.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, tfiga@google.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org, djkurtz@google.com, p.zabel@pengutronix.de, yingjoe.chen@mediatek.com, linux-mediatek@lists.infradead.org, eddie.huang@mediatek.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
List-Id: iommu@lists.linux-foundation.org

On 24/05/16 10:57, Honghui Zhang wrote:
[...]
>>> @@ -48,6 +48,9 @@ struct mtk_iommu_domain {
>>>    	struct io_pgtable_ops		*iop;
>>>
>>>    	struct iommu_domain		domain;
>>> +	void				*pgt_va;
>>> +	dma_addr_t			pgt_pa;
>>> +	void				*cookie;
>>
>> These are going to be mutually exclusive with the cfg and iop members,
>> which implies it might be a good idea to use a union and not waste
>> space. Or better, just forward-declare struct mtk_iommu_domain here and
>> leave separate definitions private to each driver. The void *cookie is
>> also an unnecessary level of abstraction, I think.
>>
>
> Do you mean declare struct mtk_iommu_domain here, and implement a new
> struct in mtk_iommu_v1.c like
> struct mtk_iommu_domain_v1 {
> 	struct mtk_iommu_domain	domain;
> 	u32			*pgt_va;
> 	dma_addr_t		pgt_pa;
> 	mtk_iommu_data		*data;
> };
> If this is acceptable I would implement it in the next version.

Pretty much, except they both want to be called struct mtk_iommu_domain, 
so that a *declaration* for the sake of the m4u_dom member of struct 
mtk_iommu_data in the header file can remain common to both drivers - it 
then just picks up whichever private *definition* from the .c file being 
compiled.

>>>    };
>>>
>>>    struct mtk_iommu_data {
>>> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
>>> new file mode 100644
>>> index 0000000..55023e1
>>> --- /dev/null
>>> +++ b/drivers/iommu/mtk_iommu_v1.c
>>> @@ -0,0 +1,742 @@
>>> +/*
>>> + * Copyright (c) 2015-2016 MediaTek Inc.
>>> + * Author: Yong Wu <yong.wu@mediatek.com>
>>
>> Nit: is that in the sense that this patch should also have Yong's
>> signed-off-by on it, or in that it's your work derived from his version
>> in mtk_iommu.c?
>
> I write this driver based on Yong's version of mtk_iommu.c, should I add
> his signed-off-by for this patch? Or should I put a comment about this?
> Thanks.

OK, in that case I think the appropriate attribution would be along the 
lines of "Author: Honghui Zhang, based on mtk_iommu.c by Yong Wu" (if in 
doubt, grepping for "Based on" gives a feel for how this is commonly 
done). If the work that comprises this patch itself (i.e. the copying 
and modification of the existing code) is all yours then your sign-off 
alone is fine.

[...]
>>> +static int mtk_iommu_add_device(struct device *dev)
>>> +{
>>> +	struct iommu_group *group;
>>> +	struct device_node *np;
>>> +	struct of_phandle_args iommu_spec;
>>> +	int idx = 0;
>>> +
>>> +	while (!of_parse_phandle_with_args(dev->of_node, "iommus",
>>> +				   "#iommu-cells", idx,
>>> +				   &iommu_spec)) {
>>
>> Hang on, this doesn't seem right - why do you need to reimplement all
>> this instead of using IOMMU_OF_DECLARE()?
>
> All the clients of mtk generation one iommu share the same iommu domain,
> as a matter of fact, mtk generation one iommu only support one iommu
> domain. ALl the clients share the same iova address and use the same
> pagetable. That means all iommu clients needed to be attached to the
> same dma_iommu_mapping.

Ugh, right - I'd forgotten that the arch/arm DMA mapping code doesn't 
respect IOMMU groups or default domains at all. That's the real root 
cause of the issue here.

> If use IOMMU_OF_DELCARE, we need to call of_iommu_set_ops to set the
> iommu_ops, I do not want the iommu_ops be set since it would cause iommu
> client device in different dma_iommu_mapping.
>
> When an iommu client device has been created, the following sequence is
> called.
>
> of_platform_device_create
> 	->of_dma_config
> 		->arch_setup_dma_ops
> 			->arch_setup_iommu_dma_ops
> In this function of arch_setup_iommu_dma_ops would create a new
> dma_iommu_mapping for each iommu client device and then attach the
> device to this new dma_iommu_mapping. Since all the iommu clients share
> the very same pagetable, this will not workable for our HW.
> I could not release the dma_iommu_mapping in attach_device since the
> to_dma_iommu_mapping was set after device_attached.
> Any suggest for this?

On a second look, you're doing more or less the same thing that the 
Renesas IPMMU driver currently does, so it's probably OK as a workaround 
for now. Fixing the arch/arm code is part of the bigger ongoing problem 
of sorting out IOMMU probing and DMA configuration, and it doesn't seem 
fair to force that on you for the sake of one driver ;)

[...]
>>> +static int __maybe_unused mtk_iommu_resume(struct device *dev)
>>> +{
>>> +	struct mtk_iommu_data *data = dev_get_drvdata(dev);
>>> +	struct mtk_iommu_suspend_reg *reg = &data->reg;
>>> +	void __iomem *base = data->base;
>>> +
>>> +	writel_relaxed(data->m4u_dom->pgt_pa, base + REG_MMU_PT_BASE_ADDR);
>>
>> Hmm, this looks like the only case where m4u_dom actually seems
>> necessary - I'm pretty sure all the others could be fairly easily
>> reworked to not use it (I might try having a quick hack at the existing
>> M4U driver to see) - at which point we could just explicitly
>> save/restore the base register here and get rid of m4u_dom entirely.
>
> Let me take a while to think about this.

That was true in the context of arm64, but you're right that the current 
state of the 32-bit code does make m4u_dom more necessary, so I guess we 
may as well leave it as-is for now.

Robin.
