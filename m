From: JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v2 01/13] iommu/rockchip: Request irqs in rk_iommu_probe()
Date: Wed, 17 Jan 2018 15:45:13 +0800
Message-ID: <5A5EFF09.3070604@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
	<20180116132540.18939-2-jeffy.chen@rock-chips.com>
	<CAAFQd5AO6_GYMs0xac-4ECFH9pn_ssg8jsFVoif0WDQ-daSuRA@mail.gmail.com>
	<5A5EF672.6040304@rock-chips.com>
	<CAAFQd5Bnv3cLJ0wWY4+LJ+0GzDcm0F9QArY+QfFg692hd6UPjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAFQd5Bnv3cLJ0wWY4+LJ+0GzDcm0F9QArY+QfFg692hd6UPjQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ricky Liang <jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Tomasz,

On 01/17/2018 03:16 PM, Tomasz Figa wrote:
>>> >>
>>> >>This lacks consistency. of_irq_count() is used for counting, but
>>> >>platform_get_irq() is used for getting. Either platform_ or of_ API
>>> >>should be used for both and I'd lean for platform_, since it's more
>>> >>general.
>> >
>> >hmmm, right, i was thinking of removing num_irq, and do something like:
>> >while (nr++) {
>> >   err = platform_get_irq(dev, nr);
>> >   if (err == -EPROBE_DEFER)
>> >      break;
>> >   if (err < 0)
>> >      return err;
>> >   ....
>> >}
>> >
>> >but forgot to do that..
> Was there anything wrong with platform_irq_count() used by existing code?

just thought the platform_irq_count might ignore some errors(except for 
EPROBE_DEFER):

int platform_irq_count(struct platform_device *dev)
{
         int ret, nr = 0;

         while ((ret = platform_get_irq(dev, nr)) >= 0)
                 nr++;

         if (ret == -EPROBE_DEFER)
                 return ret;

         return nr;
}

but guess that would not matter..

>
>> >
>>> >>
>>>> >>>+               if (irq < 0) {
>>>> >>>+                       dev_err(dev, "Failed to get IRQ, %d\n", irq);
>>>> >>>                          return -ENXIO;
>>>> >>>                  }
>>>> >>>+               err = devm_request_irq(iommu->dev, irq, rk_iommu_irq,
>>>> >>>+                                      IRQF_SHARED, dev_name(dev),
>>>> >>>iommu);
>>>> >>>+               if (err)
>>>> >>>+                       return err;
>>>> >>>          }
>>> >>
>>> >>
>>> >>Looks like there is some more initialization below. Is the driver okay
>>> >>with the IRQ being potentially fired right here? (Shared IRQ handlers
>>> >>might be run at request_irq() time for testing.)
>>> >>
>> >right, forget about that. maybe we can check iommu->domain not NULL in
>> >rk_iommu_irq()
> Maybe we could just move IRQ requesting to the end of probe?
>
ok, that should work too.

and maybe we should also check power status in the irq handler? if it 
get fired after powered off...

> Best regards,
> Tomasz
>
>
>
