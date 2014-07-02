From: Olav Haugan <ohaugan@codeaurora.org>
Subject: Re: [RFC/PATCH 7/7] iommu-api: Add domain attribute to enable coherent
 HTW
Date: Wed, 02 Jul 2014 15:11:13 -0700
Message-ID: <53B48381.9050707@codeaurora.org>
References: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org> <1404147116-4598-8-git-send-email-ohaugan@codeaurora.org> <e64e7ca617d64093bbe5dc7caf9283e1@BL2PR03MB468.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <e64e7ca617d64093bbe5dc7caf9283e1@BL2PR03MB468.namprd03.prod.outlook.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Varun Sethi <Varun.Sethi@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vgandhi@codeaurora.org" <vgandhi@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

On 7/1/2014 1:49 AM, Varun Sethi wrote:
> 
> 
>> -----Original Message-----
>> From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
>> bounces@lists.linux-foundation.org] On Behalf Of Olav Haugan
>> Sent: Monday, June 30, 2014 10:22 PM
>> To: linux-arm-kernel@lists.infradead.org; iommu@lists.linux-
>> foundation.org
>> Cc: linux-arm-msm@vger.kernel.org; will.deacon@arm.com;
>> thierry.reding@gmail.com; vgandhi@codeaurora.org
>> Subject: [RFC/PATCH 7/7] iommu-api: Add domain attribute to enable
>> coherent HTW
>>
>> Add a new iommu domain attribute that can be used to enable cache
>> coherent hardware table walks (HTW) by the SMMU. HTW might be supported
>> by the SMMU HW but depending on the use case and the usage of the SMMU in
>> the SoC it might not be always beneficial to always turn on coherent HTW
>> for all domains/iommu's.
>>
> [Sethi Varun-B16395] Why won't you want to use the coherent table walk feature?

Very good question. We have found that turning on IOMMU coherent HTW is
not always beneficial to performance (performance either the same or
slightly worse in some cases). Even if the perf. is the same we would
like to avoid using precious L2 cache for no benefit to the IOMMU.
Although our HW supports this feature we don't always want to turn this
on for a specific use case/domain (bus master).

>> Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
>> ---
>>  drivers/iommu/msm_iommu-v1.c | 16 ++++++++++++++++
>>  include/linux/iommu.h        |  1 +
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/drivers/iommu/msm_iommu-v1.c b/drivers/iommu/msm_iommu-v1.c
>> index 2c574ef..e163ffc 100644
>> --- a/drivers/iommu/msm_iommu-v1.c
>> +++ b/drivers/iommu/msm_iommu-v1.c
>> @@ -1456,8 +1456,16 @@ static int msm_domain_get_attr(struct iommu_domain
>> *domain,
>>  			       enum iommu_attr attr, void *data)  {
>>  	s32 ret = 0;
>> +	struct msm_iommu_priv *priv = domain->priv;
>>
>>  	switch (attr) {
>> +	case DOMAIN_ATTR_COHERENT_HTW:
>> +	{
>> +		s32 *int_ptr = (s32 *) data;
>> +
>> +		*int_ptr = priv->pt.redirect;
>> +		break;
>> +	}
>>  	default:
>>  		pr_err("Unsupported attribute type\n");
>>  		ret = -EINVAL;
>> @@ -1471,8 +1479,16 @@ static int msm_domain_set_attr(struct iommu_domain
>> *domain,
>>  			       enum iommu_attr attr, void *data)  {
>>  	s32 ret = 0;
>> +	struct msm_iommu_priv *priv = domain->priv;
>>
>>  	switch (attr) {
>> +	case DOMAIN_ATTR_COHERENT_HTW:
>> +	{
>> +		s32 *int_ptr = (s32 *) data;
>> +
>> +		priv->pt.redirect = *int_ptr;
>> +		break;
>> +	}
>>  	default:
>>  		pr_err("Unsupported attribute type\n");
>>  		ret = -EINVAL;
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h index
>> 63dca6d..6d9596d 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -81,6 +81,7 @@ enum iommu_attr {
>>  	DOMAIN_ATTR_FSL_PAMU_STASH,
>>  	DOMAIN_ATTR_FSL_PAMU_ENABLE,
>>  	DOMAIN_ATTR_FSL_PAMUV1,
>> +	DOMAIN_ATTR_COHERENT_HTW,
> [Sethi Varun-B16395] Would it make sense to represent this as DOMAIN_ATTR_SMMU_COHERENT_HTW? I believe this is specific to SMMU.

Yes, it does.

Thanks,

Olav Haugan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
