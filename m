From: JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v2 13/13] iommu/rockchip: Support sharing IOMMU between
	masters
Date: Wed, 17 Jan 2018 21:32:00 +0800
Message-ID: <5A5F5050.5040308@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
	<20180116132540.18939-14-jeffy.chen@rock-chips.com>
	<1bd5378d-8285-e0d9-8105-f9dd9f8cfdcb@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1bd5378d-8285-e0d9-8105-f9dd9f8cfdcb-5wv7dgnIgG8@public.gmane.org>
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

On 01/17/2018 09:00 PM, Robin Murphy wrote:
> On 16/01/18 13:25, Jeffy Chen wrote:
>> There would be some masters sharing the same IOMMU device. Put them in
>> the same iommu group and share the same iommu domain.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> ---
>>
>> Changes in v2: None
>>
>>   drivers/iommu/rockchip-iommu.c | 39
>> +++++++++++++++++++++++++++++++--------
>>   1 file changed, 31 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iommu/rockchip-iommu.c
>> b/drivers/iommu/rockchip-iommu.c
>> index c8de1456a016..6c316dd0dd2d 100644
>> --- a/drivers/iommu/rockchip-iommu.c
>> +++ b/drivers/iommu/rockchip-iommu.c
>> @@ -100,11 +100,13 @@ struct rk_iommu {
>>       struct iommu_device iommu;
>>       struct list_head node; /* entry in rk_iommu_domain.iommus */
>>       struct iommu_domain *domain; /* domain to which iommu is
>> attached */
>> +    struct iommu_group *group;
>>       struct mutex pm_mutex; /* serializes power transitions */
>>   };
>>   struct rk_iommudata {
>>       struct device_link *link; /* runtime PM link from IOMMU to
>> master */
>> +    struct iommu_domain *domain; /* domain to which device is
>> attached */
>
> I don't see why this is needed - for example, mtk_iommu does the same
> thing without needing to track the active domain in more than one place.
>
> Fundamentally, for this kind of IOMMU without the notion of multiple
> translation contexts, the logic should look like:
>
>      iommudrv_attach_device(dev, domain) {
>          iommu = dev_get_iommu(dev);
>          if (iommu->curr_domain != domain) {
>              update_hw_state(iommu, domain);
>              iommu->curr_domain = domain;
>          }
>      }
>
> which I think is essentially what you have anyway. When a group contains
> multiple devices, you update the IOMMU state for the first device, then
> calls for subsequent devices in the group do nothing since they see the
> IOMMU state is already up-to-date with the new domain.
>
right, will remove it.
> Robin.
