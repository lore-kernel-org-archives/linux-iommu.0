From: JeffyChen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v2 01/13] iommu/rockchip: Request irqs in rk_iommu_probe()
Date: Wed, 17 Jan 2018 20:46:08 +0800
Message-ID: <5A5F4590.1060107@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com> <20180116132540.18939-2-jeffy.chen@rock-chips.com> <0b341bbd-6823-a041-9cac-e35bdc9e9bdc@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0b341bbd-6823-a041-9cac-e35bdc9e9bdc@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, xxm@rock-chips.com, tfiga@chromium.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On 01/17/2018 08:18 PM, Robin Murphy wrote:
>>
>> @@ -91,7 +92,6 @@ struct rk_iommu {
>>       void __iomem **bases;
>>       int num_mmu;
>>       int *irq;
>
> Nit: irq seems to be redundant now as well.
oops, will fix it.
>
>> -    int num_irq;
>>       bool reset_disabled;
>>       struct iommu_device iommu;
>>       struct list_head node; /* entry in rk_iommu_domain.iommus */
>> @@ -830,13 +830,6 @@ static int rk_iommu_attach_device(struct
>> iommu_domain *domain,
>>       iommu->domain = domain;
>> -    for (i = 0; i < iommu->num_irq; i++) {
>> -        ret = devm_request_irq(iommu->dev, iommu->irq[i], rk_iommu_irq,
>> -                       IRQF_SHARED, dev_name(dev), iommu);
>> -        if (ret)
>> -            return ret;
>> -    }
>> -
>>       for (i = 0; i < iommu->num_mmu; i++) {
>>           rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
>>                      rk_domain->dt_dma);
>> @@ -885,9 +878,6 @@ static void rk_iommu_detach_device(struct
>> iommu_domain *domain,
>>       }
>>       rk_iommu_disable_stall(iommu);
>> -    for (i = 0; i < iommu->num_irq; i++)
>> -        devm_free_irq(iommu->dev, iommu->irq[i], iommu);
>> -
>>       iommu->domain = NULL;
>>       dev_dbg(dev, "Detached from iommu domain\n");
>> @@ -1138,7 +1128,7 @@ static int rk_iommu_probe(struct platform_device
>> *pdev)
>>       struct rk_iommu *iommu;
>>       struct resource *res;
>>       int num_res = pdev->num_resources;
>> -    int err, i;
>> +    int err, i, irq, num_irq;
>>       iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
>>       if (!iommu)
>> @@ -1165,23 +1155,17 @@ static int rk_iommu_probe(struct
>> platform_device *pdev)
>>       if (iommu->num_mmu == 0)
>>           return PTR_ERR(iommu->bases[0]);
>> -    iommu->num_irq = platform_irq_count(pdev);
>> -    if (iommu->num_irq < 0)
>> -        return iommu->num_irq;
>> -    if (iommu->num_irq == 0)
>> -        return -ENXIO;
>> -
>> -    iommu->irq = devm_kcalloc(dev, iommu->num_irq, sizeof(*iommu->irq),
>> -                  GFP_KERNEL);
>> -    if (!iommu->irq)
>> -        return -ENOMEM;
>> -
>> -    for (i = 0; i < iommu->num_irq; i++) {
>> -        iommu->irq[i] = platform_get_irq(pdev, i);
>> -        if (iommu->irq[i] < 0) {
>> -            dev_err(dev, "Failed to get IRQ, %d\n", iommu->irq[i]);
>> +    num_irq = of_irq_count(dev->of_node);
>
> To follow up on the other reply, I'm not sure you really need to count
> the IRQs beforehand at all - you're going to be looping through
> platform_get_irq() and handling errors anyway, so you may as well just
> start at 0 and keep going until -ENOENT (or use platform_get_resource()
> to double-check whether an index should be valid, as we do in arm_smmu).
ok, will do that.
>
> Otherwise, it looks like everything that the IRQ handler needs in the
> iommu struct (dev, num_mmu and bases) is already initialised by this
> point, so we should be OK with respect to races.
ok.
>
> Robin.
