From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v8 1/5] iommu/arm-smmu: Destroy domain context in failure
	path
Date: Thu, 8 Mar 2018 11:02:49 +0530
Message-ID: <CAFp+6iH7DdMnG2oMXWDGXNUjQsB1aPwOXEnrfHR-VoJzzqUPUA@mail.gmail.com>
References: <20180302101050.6191-1-vivek.gautam@codeaurora.org>
	<20180302101050.6191-2-vivek.gautam@codeaurora.org>
	<d3500b33-8ce6-d767-7e9b-2fd75fea6cbb@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <d3500b33-8ce6-d767-7e9b-2fd75fea6cbb-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, robh+dt <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 7, 2018 at 5:50 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> On 02/03/18 10:10, Vivek Gautam wrote:
>>
>> If we fail after initializing domain_context, we should destroy
>> the context to free up resources.
>
>
> Have another think about why the "problem" this patch caters for cannot ever
> happen (hint: consider how domain->smmu is used in
> arm_smmu_init_domain_context()). And then also about the really
> catastrophically bad problem it actually introduces (hint:
> "iommu_attach(domain, good_dev); iommu_attach(domain, bad_dev);")

Got it, we would end up destroying good_dev's domain context with this.
Thanks

regards
Vivek

>
> Robin.
>
>
>> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>
>>   * New patch added in this series.
>>
>>   drivers/iommu/arm-smmu.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 69e7c60792a8..ffc152c36002 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -1223,11 +1223,16 @@ static int arm_smmu_attach_dev(struct iommu_domain
>> *domain, struct device *dev)
>>                 dev_err(dev,
>>                         "cannot attach to SMMU %s whilst already attached
>> to domain on SMMU %s\n",
>>                         dev_name(smmu_domain->smmu->dev),
>> dev_name(smmu->dev));
>> -               return -EINVAL;
>> +               ret = -EINVAL;
>> +               goto destroy_domain;
>>         }
>>         /* Looks ok, so add the device to the domain */
>>         return arm_smmu_domain_add_master(smmu_domain, fwspec);
>> +
>> +destroy_domain:
>> +       arm_smmu_destroy_domain_context(domain);
>> +       return ret;
>>   }
>>     static int arm_smmu_map(struct iommu_domain *domain, unsigned long
>> iova,
>>
>



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
