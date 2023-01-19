Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E373D6E
	for <iommu@lists.linux.dev>; Thu, 19 Jan 2023 20:52:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F004C1515;
	Thu, 19 Jan 2023 12:53:01 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0AD73F67D;
	Thu, 19 Jan 2023 12:52:19 -0800 (PST)
Message-ID: <dc636d1e-43f6-3ba1-7199-c78eaf88a7c7@arm.com>
Date: Thu, 19 Jan 2023 20:52:15 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 7/8] iommu: Clean up open-coded ownership checks
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: joro@8bytes.org, will@kernel.org, hch@lst.de, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <cover.1673978700.git.robin.murphy@arm.com>
 <47109befd7a32d03bffe54192bf02f8c8a223858.1673978700.git.robin.murphy@arm.com>
 <Y8mahcvlGlHNlh6q@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Y8mahcvlGlHNlh6q@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/01/2023 7:31 pm, Jason Gunthorpe wrote:
> On Thu, Jan 19, 2023 at 07:18:25PM +0000, Robin Murphy wrote:
>> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>> index 270c3d9128ba..b2d3d309be1e 100644
>> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>> @@ -79,16 +79,6 @@ static struct qcom_iommu_domain *to_qcom_iommu_domain(struct iommu_domain *dom)
>>   
>>   static const struct iommu_ops qcom_iommu_ops;
>>   
>> -static struct qcom_iommu_dev * to_iommu(struct device *dev)
>> -{
>> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>> -
>> -	if (!fwspec || fwspec->ops != &qcom_iommu_ops)
>> -		return NULL;
>> -
>> -	return dev_iommu_priv_get(dev);
>> -}
>> -
>>   static struct qcom_iommu_ctx * to_ctx(struct qcom_iommu_domain *d, unsigned asid)
>>   {
>>   	struct qcom_iommu_dev *qcom_iommu = d->iommu;
>> @@ -361,7 +351,7 @@ static void qcom_iommu_domain_free(struct iommu_domain *domain)
>>   
>>   static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>>   {
>> -	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev);
>> +	struct qcom_iommu_dev *qcom_iommu = dev_iommu_priv_get(dev);
>>   	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
>>   	int ret;
> 
> The confusing checks for null qcom_iommu following this should go away
> too, right?
> 
> It should not be possible to have an ops set on the device but have an
> invalid priv..

Yeah, this was just an audit of already-redundant fwspec->ops checks, 
but another one for redundant dev_iommu_priv checks is probably 
worthwhile too.

Cheers,
Robin.
