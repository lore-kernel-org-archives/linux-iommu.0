From: Tomasz Figa via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH v5 08/13] iommu/rockchip: Control clocks needed to access
	the IOMMU
Date: Wed, 14 Feb 2018 20:27:28 +0900
Message-ID: <CAAFQd5DHYn2VK2GwSa0E_hX9Zh3BL5K0b1BnQqz+xzfmhPzhpg@mail.gmail.com>
References: <20180124103516.2571-1-jeffy.chen@rock-chips.com>
	<20180124103516.2571-9-jeffy.chen@rock-chips.com>
	<f06d2d9f-3869-ed02-43f4-f4ea4a104a57@arm.com>
	<edc5002d-c83f-cf11-ecfb-0c4400b10d07@codeaurora.org>
Reply-To: Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <edc5002d-c83f-cf11-ecfb-0c4400b10d07-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ricky Liang <jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 14, 2018 at 7:03 PM, Vivek Gautam
<vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>
>
> On 1/24/2018 7:19 PM, Robin Murphy wrote:
>>
>> On 24/01/18 10:35, Jeffy Chen wrote:
>>>
>>> From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>>>
>>> Current code relies on master driver enabling necessary clocks before
>>> IOMMU is accessed, however there are cases when the IOMMU should be
>>> accessed while the master is not running yet, for example allocating
>>> V4L2 videobuf2 buffers, which is done by the VB2 framework using DMA
>>> mapping API and doesn't engage the master driver at all.
>>>
>>> This patch fixes the problem by letting clocks needed for IOMMU
>>> operation to be listed in Device Tree and making the driver enable them
>>> for the time of accessing the hardware.
>>>
>>> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>> Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>>> ---
>>>
>>> Changes in v5:
>>> Use clk_bulk APIs.
>>>
>>> Changes in v4: None
>>> Changes in v3: None
>>> Changes in v2: None
>
>
> [snip]
>
>
>>>   +static int rk_iommu_of_get_clocks(struct rk_iommu *iommu)
>>> +{
>>> +    struct device_node *np = iommu->dev->of_node;
>>> +    int ret;
>>> +    int i;
>>> +
>>> +    ret = of_count_phandle_with_args(np, "clocks", "#clock-cells");
>>> +    if (ret == -ENOENT)
>>> +        return 0;
>>> +    else if (ret < 0)
>>> +        return ret;
>>> +
>>> +    iommu->num_clocks = ret;
>>> +    iommu->clocks = devm_kcalloc(iommu->dev, iommu->num_clocks,
>>> +                     sizeof(*iommu->clocks), GFP_KERNEL);
>>> +    if (!iommu->clocks)
>>> +        return -ENOMEM;
>>> +
>>> +    for (i = 0; i < iommu->num_clocks; ++i) {
>>> +        iommu->clocks[i].clk = of_clk_get(np, i);
>>> +        if (IS_ERR(iommu->clocks[i].clk)) {
>>> +            ret = PTR_ERR(iommu->clocks[i].clk);
>>> +            goto err_clk_put;
>>> +        }
>>> +    }
>>
>>
>> Just to confirm my understanding from a quick scan through the code, the
>> reason we can't use clk_bulk_get() here is that currently, clocks[i].id
>> being NULL means we'd end up just getting the first clock multiple times,
>> right?
>>
>> I guess there could be other users who also want "just get whatever clocks
>> I have" functionality, so it might be worth proposing that for the core API
>> as a separate/follow-up patch, but it definitely doesn't need to be part of
>> this series.
>
>
> Just to understand. Is it okay to make the driver "just get whatever clocks
> device node gives"?
> Doesn't the driver need to be aware of which all clocks are supposed to be
> obtained and enabled
>  It's should good for debug to let the world know which clock we failed to
> get.

Yeah, in general that's desired. However, it is at least impractical
to specify all the clocks in Rockchip case, because it's different for
each block and depends on the master next to which it is located.

Best regards,
Tomasz
