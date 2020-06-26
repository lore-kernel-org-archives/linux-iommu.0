Return-Path: <SRS0=GrUw=AH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9120C433E0
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 16:04:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DF32207E8
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 16:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF32207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 22998204BE;
	Fri, 26 Jun 2020 16:04:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mhuPJmun7-SS; Fri, 26 Jun 2020 16:04:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8F1D3220EF;
	Fri, 26 Jun 2020 16:04:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62EE8C088C;
	Fri, 26 Jun 2020 16:04:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F882C016F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 16:04:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2DD8186D1E
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 16:04:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bCBAkyxgaYCT for <iommu@lists.linux-foundation.org>;
 Fri, 26 Jun 2020 16:04:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7B65486CBB
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 16:04:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B11B91FB;
 Fri, 26 Jun 2020 09:04:41 -0700 (PDT)
Received: from [10.57.13.97] (unknown [10.57.13.97])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D98A03F6CF;
 Fri, 26 Jun 2020 09:04:36 -0700 (PDT)
Subject: Re: [PATCH v3 02/14] iommu: Report domain nesting info
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Liu Yi L <yi.l.liu@intel.com>
References: <1592988927-48009-1-git-send-email-yi.l.liu@intel.com>
 <1592988927-48009-3-git-send-email-yi.l.liu@intel.com>
 <20200626074738.GA2107508@myrica>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <069bcf66-4db3-b4f1-2e09-a79d255d0850@arm.com>
Date: Fri, 26 Jun 2020 17:04:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200626074738.GA2107508@myrica>
Content-Language: en-GB
Cc: kevin.tian@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 yi.y.sun@intel.com, linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
 iommu@lists.linux-foundation.org, hao.wu@intel.com,
 Will Deacon <will@kernel.org>, jun.j.tian@intel.com
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

On 2020-06-26 08:47, Jean-Philippe Brucker wrote:
> On Wed, Jun 24, 2020 at 01:55:15AM -0700, Liu Yi L wrote:
>> IOMMUs that support nesting translation needs report the capability info
>> to userspace, e.g. the format of first level/stage paging structures.
>>
>> This patch reports nesting info by DOMAIN_ATTR_NESTING. Caller can get
>> nesting info after setting DOMAIN_ATTR_NESTING.
>>
>> v2 -> v3:
>> *) remvoe cap/ecap_mask in iommu_nesting_info.
>> *) reuse DOMAIN_ATTR_NESTING to get nesting info.
>> *) return an empty iommu_nesting_info for SMMU drivers per Jean'
>>     suggestion.
>>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> Cc: Eric Auger <eric.auger@redhat.com>
>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> ---
>>   drivers/iommu/arm-smmu-v3.c | 29 ++++++++++++++++++++--
>>   drivers/iommu/arm-smmu.c    | 29 ++++++++++++++++++++--
> 
> Looks reasonable to me. Please move the SMMU changes to a separate patch
> and Cc the SMMU maintainers:

Cheers Jean, I'll admit I've been skipping over a lot of these patches 
lately :)

A couple of comments below...

> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> 
> Thanks,
> Jean
> 
>>   include/uapi/linux/iommu.h  | 59 +++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 113 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index f578677..0c45d4d 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -3019,6 +3019,32 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
>>   	return group;
>>   }
>>   
>> +static int arm_smmu_domain_nesting_info(struct arm_smmu_domain *smmu_domain,
>> +					void *data)
>> +{
>> +	struct iommu_nesting_info *info = (struct iommu_nesting_info *) data;
>> +	u32 size;
>> +
>> +	if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
>> +		return -ENODEV;
>> +
>> +	size = sizeof(struct iommu_nesting_info);
>> +
>> +	/*
>> +	 * if provided buffer size is not equal to the size, should
>> +	 * return 0 and also the expected buffer size to caller.
>> +	 */
>> +	if (info->size != size) {
>> +		info->size = size;
>> +		return 0;
>> +	}
>> +
>> +	/* report an empty iommu_nesting_info for now */
>> +	memset(info, 0x0, size);
>> +	info->size = size;
>> +	return 0;
>> +}
>> +
>>   static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>>   				    enum iommu_attr attr, void *data)
>>   {
>> @@ -3028,8 +3054,7 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>>   	case IOMMU_DOMAIN_UNMANAGED:
>>   		switch (attr) {
>>   		case DOMAIN_ATTR_NESTING:
>> -			*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
>> -			return 0;
>> +			return arm_smmu_domain_nesting_info(smmu_domain, data);
>>   		default:
>>   			return -ENODEV;
>>   		}
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 243bc4c..908607d 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -1506,6 +1506,32 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
>>   	return group;
>>   }
>>   
>> +static int arm_smmu_domain_nesting_info(struct arm_smmu_domain *smmu_domain,
>> +					void *data)
>> +{
>> +	struct iommu_nesting_info *info = (struct iommu_nesting_info *) data;
>> +	u32 size;
>> +
>> +	if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
>> +		return -ENODEV;
>> +
>> +	size = sizeof(struct iommu_nesting_info);
>> +
>> +	/*
>> +	 * if provided buffer size is not equal to the size, should
>> +	 * return 0 and also the expected buffer size to caller.
>> +	 */
>> +	if (info->size != size) {
>> +		info->size = size;
>> +		return 0;
>> +	}
>> +
>> +	/* report an empty iommu_nesting_info for now */
>> +	memset(info, 0x0, size);
>> +	info->size = size;
>> +	return 0;
>> +}
>> +
>>   static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>>   				    enum iommu_attr attr, void *data)
>>   {
>> @@ -1515,8 +1541,7 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>>   	case IOMMU_DOMAIN_UNMANAGED:
>>   		switch (attr) {
>>   		case DOMAIN_ATTR_NESTING:
>> -			*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
>> -			return 0;
>> +			return arm_smmu_domain_nesting_info(smmu_domain, data);
>>   		default:
>>   			return -ENODEV;
>>   		}
>> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
>> index 1afc661..898c99a 100644
>> --- a/include/uapi/linux/iommu.h
>> +++ b/include/uapi/linux/iommu.h
>> @@ -332,4 +332,63 @@ struct iommu_gpasid_bind_data {
>>   	} vendor;
>>   };
>>   
>> +/*
>> + * struct iommu_nesting_info - Information for nesting-capable IOMMU.
>> + *				user space should check it before using
>> + *				nesting capability.
>> + *
>> + * @size:	size of the whole structure
>> + * @format:	PASID table entry format, the same definition with
>> + *		@format of struct iommu_gpasid_bind_data.
>> + * @features:	supported nesting features.
>> + * @flags:	currently reserved for future extension.
>> + * @data:	vendor specific cap info.
>> + *
>> + * +---------------+----------------------------------------------------+
>> + * | feature       |  Notes                                             |
>> + * +===============+====================================================+
>> + * | SYSWIDE_PASID |  Kernel manages PASID in system wide, PASIDs used  |
>> + * |               |  in the system should be allocated by host kernel  |
>> + * +---------------+----------------------------------------------------+
>> + * | BIND_PGTBL    |  bind page tables to host PASID, the PASID could   |
>> + * |               |  either be a host PASID passed in bind request or  |
>> + * |               |  default PASIDs (e.g. default PASID of aux-domain) |
>> + * +---------------+----------------------------------------------------+
>> + * | CACHE_INVLD   |  mandatory feature for nesting capable IOMMU       |
>> + * +---------------+----------------------------------------------------+
>> + *
>> + */
>> +struct iommu_nesting_info {
>> +	__u32	size;
>> +	__u32	format;
>> +	__u32	features;
>> +#define IOMMU_NESTING_FEAT_SYSWIDE_PASID	(1 << 0)
>> +#define IOMMU_NESTING_FEAT_BIND_PGTBL		(1 << 1)
>> +#define IOMMU_NESTING_FEAT_CACHE_INVLD		(1 << 2)
>> +	__u32	flags;
>> +	__u8	data[];
>> +};
>> +
>> +/*
>> + * struct iommu_nesting_info_vtd - Intel VT-d specific nesting info
>> + *
>> + *
>> + * @flags:	VT-d specific flags. Currently reserved for future
>> + *		extension.
>> + * @addr_width:	The output addr width of first level/stage translation
>> + * @pasid_bits:	Maximum supported PASID bits, 0 represents no PASID
>> + *		support.
>> + * @cap_reg:	Describe basic capabilities as defined in VT-d capability
>> + *		register.
>> + * @ecap_reg:	Describe the extended capabilities as defined in VT-d
>> + *		extended capability register.
>> + */
>> +struct iommu_nesting_info_vtd {
>> +	__u32	flags;
>> +	__u16	addr_width;

I think this might be worth promoting to a generic feature - Arm has the 
same notion of intermediate address size, and I'd imagine that pretty 
much any other two-stage translation system would as well (either 
explicitly or implicitly). It also comes close to something the DPDK 
folks raised where they wanted parity with a feature that currently 
scrapes AGAW out of some VT-d-specific place, so abstracting it to 
completely generic code, in a way that could eventually be generalised 
to reporting info for non-nested domains too, would be really nice.

What would also be cool is if the user was able to pass in a structure 
with preferred values for the address size and other capabilities when 
they request nesting in the first place. Right now we'll always set up 
the maximum possible sized page table for any domain, but if we knew 
ahead of time how many bits the user actually cared about then we could 
potentially be more efficient (e.g. use fewer levels of pagetable or a 
different translation granule).

Robin.

>> +	__u16	pasid_bits;
>> +	__u64	cap_reg;
>> +	__u64	ecap_reg;
>> +};
>> +
>>   #endif /* _UAPI_IOMMU_H */
>> -- 
>> 2.7.4
>>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
