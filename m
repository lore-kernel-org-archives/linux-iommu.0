From: JeffyChen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v4 04/13] iommu/rockchip: Fix error handling in attach
Date: Thu, 18 Jan 2018 22:22:53 +0800
Message-ID: <5A60ADBD.4050303@rock-chips.com>
References: <20180118115251.5542-1-jeffy.chen@rock-chips.com> <20180118115251.5542-5-jeffy.chen@rock-chips.com> <fa4277ef-ddfe-e23b-034c-167281cf0db1@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fa4277ef-ddfe-e23b-034c-167281cf0db1@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, xxm@rock-chips.com, tfiga@chromium.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On 01/18/2018 09:23 PM, Robin Murphy wrote:
>>
>> @@ -837,7 +837,7 @@ static int rk_iommu_attach_device(struct
>> iommu_domain *domain,
>>       ret = rk_iommu_enable_paging(iommu);
>>       if (ret)
>> -        return ret;
>> +        goto err_disable_stall;
>>       spin_lock_irqsave(&rk_domain->iommus_lock, flags);
>>       list_add_tail(&iommu->node, &rk_domain->iommus);
>> @@ -848,6 +848,11 @@ static int rk_iommu_attach_device(struct
>> iommu_domain *domain,
>>       rk_iommu_disable_stall(iommu);
>>       return 0;
>
> Nit: if you like, it looks reasonable to name the label
> "out_disable_stall" and remove these lines above here, to save the
> duplication between the error and success paths (since ret will already
> be 0 on the latter).
>
right, i think so, will do it in the next version.
> Either way,
>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
