From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/4] iommu/msm: Add iommu_group support
Date: Mon, 24 Jul 2017 10:55:53 +0100
Message-ID: <e148ac58-2fda-454f-c8b1-e01dd1c1347c@arm.com>
References: <cover.1500637633.git.robin.murphy@arm.com>
 <b87d44e09fa18efbb9daf6258c1f8ecbedaac23c.1500637633.git.robin.murphy@arm.com>
 <f5071164-c965-b6bf-c330-90ff6ea0c956@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f5071164-c965-b6bf-c330-90ff6ea0c956-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Content-Language: en-GB
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 24/07/17 08:34, Sricharan R wrote:
> Hi Robin,
> 
>> As the last step to making groups mandatory, clean up the remaining
>> drivers by adding basic support. Whilst it may not perfectly reflect the
>> isolation capabilities of the hardware, using generic_device_group()
>> should at least maintain existing behaviour with respect to the API.
>>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>  drivers/iommu/msm_iommu.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
>> index d0448353d501..04f4d51ffacb 100644
>> --- a/drivers/iommu/msm_iommu.c
>> +++ b/drivers/iommu/msm_iommu.c
>> @@ -393,6 +393,7 @@ static struct msm_iommu_dev *find_iommu_for_dev(struct device *dev)
>>  static int msm_iommu_add_device(struct device *dev)
>>  {
>>  	struct msm_iommu_dev *iommu;
>> +	struct iommu_group *group;
>>  	unsigned long flags;
>>  	int ret = 0;
>>  
>> @@ -406,7 +407,16 @@ static int msm_iommu_add_device(struct device *dev)
>>  
>>  	spin_unlock_irqrestore(&msm_iommu_lock, flags);
>>  
>> -	return ret;
>> +	if (ret)
>> +		return ret;
>> +
>> +	group = iommu_group_get_for_dev(dev);
>> +	if (IS_ERR(group))
>> +		return PTR_ERR(group);
>> +
>> +	iommu_group_put(group);
>> +
>> +	return 0;
>>  }
>>  
> 
>  While this is correct for completing the group support, this adds the default domain and
>  that might break in the driver while attaching a private domain. The msm_iomm_attach_dev
>  needs to be fixed by calling msm_iommu_detach_dev while trying to attach a new domain when
>  already connected to a default one. But let me test and confirm this.

The default domain shouldn't matter, since msm_iommu_domain_alloc() will
refuse to create DMA ops or identity domains in the first place. In the
absence of a default domain, __iommu_detach_group() will still end up
calling ops->detach_dev, so I don't think the ultimate behaviour is any
different with this change. Testing is of course welcome, though ;)

Robin.
