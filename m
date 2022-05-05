Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC73BC433EF
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 07:09:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5121283F41;
	Thu,  5 May 2022 07:09:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GdvpGerK2eWb; Thu,  5 May 2022 07:09:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0A4EA83F46;
	Thu,  5 May 2022 07:09:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC889C0039;
	Thu,  5 May 2022 07:09:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EB9BC0032
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 07:09:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EA68D40112
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 07:09:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uh1u64Lhfsfe for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 07:09:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C3869400A4
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 07:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651734555; x=1683270555;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=yhEMFM3HV8KL3mz6avPBIxBH3iRpk8vn+fzx1P5KEos=;
 b=df5WmAZnA/k3/qftCCWHoIif/evgqb6Aeh4wfGfn1ZHrayvTl8s+3mqp
 g06gFmbY9vjd2EraZqN6EzsNv0Ml9ptX8eufnlmskSqL2UmcwVDsUPYZA
 8H+vaUeFlThb1xOMBtiuAcNSiwApW76W1wrMokdYgctzTEOkHfGWz2Tu7
 FahqBVkPc2gIhz68joAkHYv7wLwhm2VhEvXrY4QfFVi1s/47M8Qua3kk0
 +oWvpHDkohZpC1xGqcH1XP51qoml/mbKIkOhE7l6Ry8zvrNIesa3gLyR1
 WWbMAme2uIFUggQs++Npwvv7dmqDU8szWnH4kr12JEP/ZHUW/IqEgu5mC w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="268174723"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; d="scan'208";a="268174723"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 00:09:14 -0700
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; d="scan'208";a="563109211"
Received: from minhaowa-mobl.ccr.corp.intel.com (HELO [10.255.30.75])
 ([10.255.30.75])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 00:09:10 -0700
Message-ID: <2979ec44-e509-761c-3a0f-95ffec0986f3@linux.intel.com>
Date: Thu, 5 May 2022 15:09:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 07/12] arm-smmu-v3/sva: Add SVA domain support
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-8-baolu.lu@linux.intel.com> <YnFwiLkvYtLn43Qv@myrica>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YnFwiLkvYtLn43Qv@myrica>
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022/5/4 02:12, Jean-Philippe Brucker wrote:
> On Mon, May 02, 2022 at 09:48:37AM +0800, Lu Baolu wrote:
>> Add support for SVA domain allocation and provide an SVA-specific
>> iommu_domain_ops.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 14 +++++++
>>   .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 42 +++++++++++++++++++
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 21 ++++++++++
>>   3 files changed, 77 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> index cd48590ada30..7631c00fdcbd 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> @@ -759,6 +759,10 @@ struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
>>   void arm_smmu_sva_unbind(struct iommu_sva *handle);
>>   u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
>>   void arm_smmu_sva_notifier_synchronize(void);
>> +int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
>> +				  struct device *dev, ioasid_t id);
>> +void arm_smmu_sva_detach_dev_pasid(struct iommu_domain *domain,
>> +				   struct device *dev, ioasid_t id);
>>   #else /* CONFIG_ARM_SMMU_V3_SVA */
>>   static inline bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>>   {
>> @@ -804,5 +808,15 @@ static inline u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
>>   }
>>   
>>   static inline void arm_smmu_sva_notifier_synchronize(void) {}
>> +
>> +static inline int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
>> +						struct device *dev, ioasid_t id)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +static inline void arm_smmu_sva_detach_dev_pasid(struct iommu_domain *domain,
>> +						 struct device *dev,
>> +						 ioasid_t id) {}
>>   #endif /* CONFIG_ARM_SMMU_V3_SVA */
>>   #endif /* _ARM_SMMU_V3_H */
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>> index c623dae1e115..3b843cd3ed67 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>> @@ -541,3 +541,45 @@ void arm_smmu_sva_notifier_synchronize(void)
>>   	 */
>>   	mmu_notifier_synchronize();
>>   }
>> +
>> +int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
>> +				  struct device *dev, ioasid_t id)
>> +{
>> +	int ret = 0;
>> +	struct iommu_sva *handle;
>> +	struct mm_struct *mm = iommu_sva_domain_mm(domain);
>> +
>> +	if (domain->type != IOMMU_DOMAIN_SVA || !mm)
> 
> We wouldn't get that far with a non-SVA domain since iommu_sva_domain_mm()
> would dereference a NULL pointer. Could you move it after the domain->type
> check, and maybe add a WARN_ON()?  It could help catch issues in future
> API changes.

Sure. I will make it like this,

int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
                                   struct device *dev, ioasid_t id)
{
         int ret = 0;
         struct mm_struct *mm;
         struct iommu_sva *handle;

         if (domain->type != IOMMU_DOMAIN_SVA)
                 return -EINVAL;

         mm = iommu_sva_domain_mm(domain);
         if (WARN_ON(!mm))
                 return -ENODEV;
... ...

> 
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&sva_lock);
>> +	handle = __arm_smmu_sva_bind(dev, mm);
>> +	if (IS_ERR(handle))
>> +		ret = PTR_ERR(handle);
>> +	mutex_unlock(&sva_lock);
>> +
>> +	return ret;
>> +}
>> +
>> +void arm_smmu_sva_detach_dev_pasid(struct iommu_domain *domain,
>> +				   struct device *dev, ioasid_t id)
>> +{
>> +	struct arm_smmu_bond *bond = NULL, *t;
>> +	struct mm_struct *mm = iommu_sva_domain_mm(domain);
>> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>> +
>> +	mutex_lock(&sva_lock);
>> +	list_for_each_entry(t, &master->bonds, list) {
>> +		if (t->mm == mm) {
>> +			bond = t;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!WARN_ON(!bond) && refcount_dec_and_test(&bond->refs)) {
>> +		list_del(&bond->list);
>> +		arm_smmu_mmu_notifier_put(bond->smmu_mn);
>> +		kfree(bond);
>> +	}
>> +	mutex_unlock(&sva_lock);
>> +}
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index afc63fce6107..bd80de0bad98 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -1995,10 +1995,31 @@ static bool arm_smmu_capable(enum iommu_cap cap)
>>   	}
>>   }
>>   
>> +static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
>> +{
>> +	kfree(domain);
>> +}
>> +
>> +static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
>> +	.attach_dev_pasid	= arm_smmu_sva_attach_dev_pasid,
>> +	.detach_dev_pasid	= arm_smmu_sva_detach_dev_pasid,
>> +	.free			= arm_smmu_sva_domain_free,
>> +};
>> +
>>   static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>>   {
>>   	struct arm_smmu_domain *smmu_domain;
>>   
>> +	if (type == IOMMU_DOMAIN_SVA) {
>> +		struct iommu_domain *domain;
>> +
>> +		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
>> +		if (domain)
>> +			domain->ops = &arm_smmu_sva_domain_ops;
>> +
>> +		return domain;
>> +	}
>> +
> 
> I'd prefer moving all of this to arm-smmu-v3-sva.c and just call
> arm_smmu_sva_domain_alloc() here

Sure.

> 
> Otherwise the patch looks fine. I'll rework the driver when I find some
> time, because we can now remove arm_smmu_bond and move smmu_mn to the SVA
> domain, maybe also remove sva_lock but I haven't thought it through.

Yes. Intel SVA code also needs further cleanup. It's in my non-urgent
task list.

> 
> Thanks,
> Jean
> 
>>   	if (type != IOMMU_DOMAIN_UNMANAGED &&
>>   	    type != IOMMU_DOMAIN_DMA &&
>>   	    type != IOMMU_DOMAIN_DMA_FQ &&
>> -- 
>> 2.25.1
>>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
