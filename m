From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v5 08/13] iommu/rockchip: Control clocks needed to access
 the IOMMU
Date: Wed, 14 Feb 2018 15:33:56 +0530
Message-ID: <edc5002d-c83f-cf11-ecfb-0c4400b10d07@codeaurora.org>
References: <20180124103516.2571-1-jeffy.chen@rock-chips.com>
 <20180124103516.2571-9-jeffy.chen@rock-chips.com>
 <f06d2d9f-3869-ed02-43f4-f4ea4a104a57@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f06d2d9f-3869-ed02-43f4-f4ea4a104a57-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 1/24/2018 7:19 PM, Robin Murphy wrote:
> On 24/01/18 10:35, Jeffy Chen wrote:
>> From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>>
>> Current code relies on master driver enabling necessary clocks before
>> IOMMU is accessed, however there are cases when the IOMMU should be
>> accessed while the master is not running yet, for example allocating
>> V4L2 videobuf2 buffers, which is done by the VB2 framework using DMA
>> mapping API and doesn't engage the master driver at all.
>>
>> This patch fixes the problem by letting clocks needed for IOMMU
>> operation to be listed in Device Tree and making the driver enable them
>> for the time of accessing the hardware.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> ---
>>
>> Changes in v5:
>> Use clk_bulk APIs.
>>
>> Changes in v4: None
>> Changes in v3: None
>> Changes in v2: None

[snip]

>>   +static int rk_iommu_of_get_clocks(struct rk_iommu *iommu)
>> +{
>> +    struct device_node *np = iommu->dev->of_node;
>> +    int ret;
>> +    int i;
>> +
>> +    ret = of_count_phandle_with_args(np, "clocks", "#clock-cells");
>> +    if (ret == -ENOENT)
>> +        return 0;
>> +    else if (ret < 0)
>> +        return ret;
>> +
>> +    iommu->num_clocks = ret;
>> +    iommu->clocks = devm_kcalloc(iommu->dev, iommu->num_clocks,
>> +                     sizeof(*iommu->clocks), GFP_KERNEL);
>> +    if (!iommu->clocks)
>> +        return -ENOMEM;
>> +
>> +    for (i = 0; i < iommu->num_clocks; ++i) {
>> +        iommu->clocks[i].clk = of_clk_get(np, i);
>> +        if (IS_ERR(iommu->clocks[i].clk)) {
>> +            ret = PTR_ERR(iommu->clocks[i].clk);
>> +            goto err_clk_put;
>> +        }
>> +    }
>
> Just to confirm my understanding from a quick scan through the code, 
> the reason we can't use clk_bulk_get() here is that currently, 
> clocks[i].id being NULL means we'd end up just getting the first clock 
> multiple times, right?
>
> I guess there could be other users who also want "just get whatever 
> clocks I have" functionality, so it might be worth proposing that for 
> the core API as a separate/follow-up patch, but it definitely doesn't 
> need to be part of this series.

Just to understand. Is it okay to make the driver "just get whatever 
clocks device node gives"?
Doesn't the driver need to be aware of which all clocks are supposed to 
be obtained and enabled
  It's should good for debug to let the world know which clock we failed 
to get.

regards
Vivek

>
> I really don't know enough about correct clk API usage, but modulo the 
> binding comments it certainly looks nice and tidy now;
>
> Acked-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>
> Thanks,
> Robin.
[snip]

> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
