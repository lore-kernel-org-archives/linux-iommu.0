From: JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v2 12/13] iommu/rockchip: Add runtime PM support
Date: Wed, 17 Jan 2018 15:26:42 +0800
Message-ID: <5A5EFAB2.7040001@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
	<20180116132540.18939-13-jeffy.chen@rock-chips.com>
	<CAAFQd5DCxgsL52+5XetV9MRDecL7dN6_QdHysKUOWaEqSf=ijw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAFQd5DCxgsL52+5XetV9MRDecL7dN6_QdHysKUOWaEqSf=ijw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On 01/17/2018 02:20 PM, Tomasz Figa wrote:
> On Tue, Jan 16, 2018 at 10:25 PM, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>> When the power domain is powered off, the IOMMU cannot be accessed and
>> register programming must be deferred until the power domain becomes
>> enabled.
>>
>> Add runtime PM support, and use runtime PM device link from IOMMU to
>> master to startup and shutdown IOMMU.
> [snip]
>> @@ -875,28 +889,19 @@ static size_t rk_iommu_unmap(struct iommu_domain *domain, unsigned long _iova,
>>
>>   static struct rk_iommu *rk_iommu_from_dev(struct device *dev)
>>   {
>> -       return dev->archdata.iommu;
>> +       struct rk_iommudata *data = dev->archdata.iommu;
>> +
>> +       return data ? data->iommu : NULL;
>>   }
>
> Is this change intentionally added to this patch? I see this
> potentially relevant for the previous patch in this series.
right, will do that.

>
> [snip]
>> +static int rk_iommu_startup(struct rk_iommu *iommu)
>>   {
>> -       struct rk_iommu *iommu;
>> +       struct iommu_domain *domain = iommu->domain;
>>          struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
>> -       unsigned long flags;
>>          int ret, i;
>>
>> -       /*
>> -        * Allow 'virtual devices' (e.g., drm) to attach to domain.
>> -        * Such a device does not belong to an iommu group.
>> -        */
>> -       iommu = rk_iommu_from_dev(dev);
>> -       if (!iommu)
>> -               return 0;
>> -
>> -       if (iommu->domain)
>> -               rk_iommu_detach_device(iommu->domain, dev);
>> -
>>          ret = rk_iommu_enable_clocks(iommu);
>>          if (ret)
>>                  return ret;
>>
>
> Don't we need to check here (and in _shutdown() too) if we have a
> domain attached?
hmmm, right, the startup might been called by resume, so should check 
iommu->domain here.

but the shutdown would be called at the end of detach or suspend, it 
could be not attached or attached.
>
>> +       mutex_lock(&iommu->pm_mutex);
>>          ret = rk_iommu_enable_stall(iommu);
>>          if (ret)
>> -               goto err_disable_clocks;
>> +               goto err_unlock_mutex;
> [snip]
>> +       iommu->domain = NULL;
>> +
>> +       spin_lock_irqsave(&rk_domain->iommus_lock, flags);
>> +       list_del_init(&iommu->node);
>> +       spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
>> +
>> +       if (pm_runtime_get_if_in_use(iommu->dev) > 0) {
>
> Actually, if the above call returns -EINVAL, don't we still need to
> call rk_iommu_shutdown(), because it just means runtime PM is disabled
> and the IOMMU is always powered on?
ok, will fix that.
>
>> +               rk_iommu_shutdown(iommu);
>> +               pm_runtime_put(iommu->dev);
>> +       }
>> +}
> [snip]
>> +       spin_lock_irqsave(&rk_domain->iommus_lock, flags);
>> +       list_add_tail(&iommu->node, &rk_domain->iommus);
>> +       spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
>> +
>> +       if (pm_runtime_get_if_in_use(iommu->dev) <= 0)
>
> Ditto.
>
>> +               return 0;
>> +
>> +       ret = rk_iommu_startup(iommu);
>> +       if (ret)
>> +               rk_iommu_detach_device(data->domain, dev);
> [snip]
>> @@ -1108,7 +1175,9 @@ static int rk_iommu_of_xlate(struct device *dev,
>>                  return -ENODEV;
>>          }
>>
>> -       dev->archdata.iommu = platform_get_drvdata(iommu_dev);
>> +       data->iommu = platform_get_drvdata(iommu_dev);
>> +       dev->archdata.iommu = data;
>> +
>
> I think this change might be mistakenly squashed to this patch instead
> of previous.
right, will do.
>
> Best regards,
> Tomasz
>
>
>
