From: JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v2 11/13] iommu/rockchip: Use OF_IOMMU to attach devices
	automatically
Date: Wed, 17 Jan 2018 15:20:46 +0800
Message-ID: <5A5EF94E.7010806@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
	<20180116132540.18939-12-jeffy.chen@rock-chips.com>
	<CAAFQd5C=SM21CmL8J334HseJ6SJH1wAVzKhrsk_cXMmpf8mK8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAFQd5C=SM21CmL8J334HseJ6SJH1wAVzKhrsk_cXMmpf8mK8g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, open-Y9sIeH5OGRo@public.gmane.org, list-Y9sIeH5OGRo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ricky Liang <jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Tomasz,

Thanks for your reply.

On 01/17/2018 01:44 PM, Tomasz Figa wrote:
> On Tue, Jan 16, 2018 at 10:25 PM, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>> Converts the rockchip-iommu driver to use the OF_IOMMU infrastructure,
>> which allows attaching master devices to their IOMMUs automatically
>> according to DT properties.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> ---
>>
>> Changes in v2: None
>>
>>   drivers/iommu/rockchip-iommu.c | 116 +++++++++++------------------------------
>>   1 file changed, 31 insertions(+), 85 deletions(-)
>>
>> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
>> index 51e4f982c4a6..c2d3ac82184e 100644
>> --- a/drivers/iommu/rockchip-iommu.c
>> +++ b/drivers/iommu/rockchip-iommu.c
> [snip]
>> +static int rk_iommu_of_xlate(struct device *dev,
>> +                            struct of_phandle_args *args)
>> +{
>> +       struct platform_device *iommu_dev;
>> +
>> +       iommu_dev = of_find_device_by_node(args->np);
>> +       if (!iommu_dev) {
>> +               dev_err(dev, "iommu %pOF not found\n", args->np);
>> +               return -ENODEV;
>> +       }
>> +
>> +       dev->archdata.iommu = platform_get_drvdata(iommu_dev);
>
> This will work only if that iommu was already probed. Do we have any
> guarantees that this callback is not called earlier?
in of_iommu.c, the of_iommu_xlate would check for fwnode before calling 
this.

but it's possible the probe failed after calling 
iommu_device_set_fwnode, so i'll try to add some checks here, and maybe 
adjust probe() to prevent it too.

>
> Best regards,
> Tomasz
>
>
>
