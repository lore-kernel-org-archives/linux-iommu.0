From: JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [RESEND PATCH v6 14/14] iommu/rockchip: Support sharing IOMMU
	between masters
Date: Thu, 01 Mar 2018 19:14:10 +0800
Message-ID: <5A97E082.3020109@rock-chips.com>
References: <20180301101837.27969-1-jeffy.chen@rock-chips.com>
	<20180301101837.27969-15-jeffy.chen@rock-chips.com>
	<44efebd3-ab48-4e12-cf92-66b6563f7644@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <44efebd3-ab48-4e12-cf92-66b6563f7644-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On 03/01/2018 07:03 PM, Robin Murphy wrote:
>>
>> +static struct iommu_group *rk_iommu_device_group(struct device *dev)
>> +{
>> +    struct rk_iommu *iommu;
>> +
>> +    iommu = rk_iommu_from_dev(dev);
>> +
>> +    return iommu->group;
>
> Oops, seems I overlooked this in my previous review - it should really be:
>
>      return iommu_group_get(iommu->group);
>
> or the refcounting will be unbalanced on those future systems where it
> really will be called more than once.
>
hmmm, right, it should be return iommu_group_ref_get(iommu->group);

i was following omap iommu:
static struct iommu_group *omap_iommu_device_group(struct device *dev)
{
         struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
         struct iommu_group *group = ERR_PTR(-EINVAL);

         if (arch_data->iommu_dev)
                 group = arch_data->iommu_dev->group;

         return group;
}

will fix it too in the version.

> Robin.
