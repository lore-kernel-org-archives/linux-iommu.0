Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62671EF1A
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 07:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945527; cv=none; b=ngrTlmsKbVOi1QAiybkDI7Bf7lxRrziZ5KLntlRhcHn/awI0WyYId4FtIAeqE9mA6R5PgTaOqRypqvGVpeopfGAthNylqWYsVxOauvGVa214dk2yleth6fBTmspXScGzOvnIlDo5CaP4uqhBakQSFsngOOGI6fLLZXZdBbYiYic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945527; c=relaxed/simple;
	bh=qBlu/gLPm5fn2qbaDjWZw70vCAz6VT4XY5Bl5R+9W3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jnZunt+5JrWMOTzjH30hFLhvnjYDgVP+/1h2yZ0X6KBi8nuIz+SlXS3F4OqQiIks/QrKv3QUeQBJqX2eoonj5x2OWWzyT7OnAV/k+RJATWDTDe+TJ4QZF/o5y2ny7rfekSLt3k/FrlnJv2/mTkByhu8QJhADmZjen1lknFw6kBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 955C2339;
	Wed, 24 Apr 2024 00:59:12 -0700 (PDT)
Received: from [10.57.74.127] (unknown [10.57.74.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CCBE3F64C;
	Wed, 24 Apr 2024 00:58:43 -0700 (PDT)
Message-ID: <adbd2725-25c9-469d-a9e4-14fffc1521aa@arm.com>
Date: Wed, 24 Apr 2024 08:58:41 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu/arm-smmu-v3: Enable HTTU for stage1 with
 io-pgtable mapping
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 joro@8bytes.org, kevin.tian@intel.com, nicolinc@nvidia.com,
 mshavit@google.com, robin.murphy@arm.com, will@kernel.org,
 joao.m.martins@oracle.com, jiangkunkun@huawei.com, zhukeqian1@huawei.com,
 linuxarm@huawei.com
References: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
 <20240222094923.33104-5-shameerali.kolothum.thodi@huawei.com>
 <364b6a6f-048c-426c-a9c4-aabef551e0c0@arm.com>
 <20240423173202.GB941030@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240423173202.GB941030@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/04/2024 18:32, Jason Gunthorpe wrote:
> On Tue, Apr 23, 2024 at 05:45:16PM +0100, Ryan Roberts wrote:
>> On 22/02/2024 09:49, Shameer Kolothum wrote:
>>> From: Kunkun Jiang <jiangkunkun@huawei.com>
>>>
>>> If io-pgtable quirk flag indicates support for hardware update of
>>> dirty state, enable HA/HD bits in the SMMU CD and also set the DBM
>>> bit in the page descriptor.
>>>
>>> And now report the dirty page tracking capability of SMMUv3.
>>>
>>> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
>>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>>> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>>
>> Section 3.13 of the spec states: "Where translation tables are shared between
>> CDs that contain the same ASID (within a translation regime), the CD HA and HD
>> fields must be identical."
>>
>> I don't think the way that smmu domains work, its possible to end up with a
>> single pgtable shared between multiple CDs? 
> 
> It is possible. iommufd can link a single hwpt -> iommu_domain ->
> smmu_domain to many different RIDs and to different PASIDs each with
> their own CD.

Ahh ok.

> 
>> So the driver should be able to guarantee this constraint is met?
> 
> It is expected to be done by this:
> 
>>> @@ -1271,6 +1271,12 @@ void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
>>>  		CTXDESC_CD_0_ASET |
>>>  		FIELD_PREP(CTXDESC_CD_0_ASID, smmu_domain->asid)
>>>  		);
>>> +
>>> +	/* To enable dirty flag update, set both Access flag and dirty state update */
>>> +	if (pgtbl_cfg->quirks & IO_PGTABLE_QUIRK_ARM_HD)
>>> +		target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HA |
>>> +					       CTXDESC_CD_0_TCR_HD);
>>> +
> 
> This function is the only place that programs the ASID into a CD entry
> for the domain, and it always derives the HA/HD bits in the same way
> from some immutable value stored in the iommu_domain structure.

But then I don't understand how this code can make the guarrantee? Whether or
not dirty tracking is enabled seems to be a property of the domain, not the page
table. (See arm_smmu_domain_finalise()). So if multiple domains can share a page
table surely some of those domains could end up with dirty tracking on and
others with it off. So there would be multiple CDs, all pointing to the same
pgtable but with different HA/HD values?

Or perhaps I've misunderstood your comment and there is actually always a 1:1
relationship between domain and pgtable? But a 1:* relationship between domain
and CD?

> 
> Jason

