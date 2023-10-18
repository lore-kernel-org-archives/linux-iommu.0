Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD7C4412
	for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 02:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FGM4RPwO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697594997; x=1729130997;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CWfYXO9YG2yfmLl8n6WbRtsy+sID2wgUiX8Hew6Sflo=;
  b=FGM4RPwOVewE6VDgeALm42qfLc4VB2XeWa0wvRfHa5UDaRONK0C739vL
   CMXs999HCrXdOgSr5i7u/eo+6sQ5xtnl2s2Js62Zo7LefS7/ZcvgImAet
   YQcYvasDmPauS1Jejozd9YvC9BqaRXJ9briNKEONYDs24dRhp66WjObQF
   qhiawt+NswRmtM53r0mf1BbTz7Q+JQs0BVnLw5tKtkEVRIc+tHS+Bwubr
   JFJkNh8Ke942HSP3sV2T4eqbgNOiKLzVySN89dVznyO6MhhBXyIbs7qHs
   nMWX+w7I1+zl6332QTpdYoHKvAWiDU/2ntD+jvElWck5hW6WqKG3h+SWr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384798696"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="384798696"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 19:09:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="1087721657"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="1087721657"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 17 Oct 2023 19:09:53 -0700
Message-ID: <22958804-ad42-4ea4-a8f7-cf1c5c3a5532@linux.intel.com>
Date: Wed, 18 Oct 2023 10:06:13 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Yi Liu <yi.l.liu@intel.com>, Yi Y Sun <yi.y.sun@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 19/19] iommu/intel: Access/Dirty bit support for SL
 domains
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>
References: <20230923012511.10379-1-joao.m.martins@oracle.com>
 <20230923012511.10379-20-joao.m.martins@oracle.com>
 <c4816f4b-3fde-4adb-901f-4d568a4fd95a@linux.intel.com>
 <764f159d-a19c-4a1d-86a6-a2791ff21e10@oracle.com>
 <20231016114210.GM3952@nvidia.com>
 <037d2917-51a2-acae-dc06-65940a054880@linux.intel.com>
 <20231016125941.GT3952@nvidia.com>
 <3e30e72a-c1c6-55a6-8e52-6a6250d2d8de@linux.intel.com>
 <4cc0c4a0-3c00-4b29-a43b-ddfc57f2e4c0@oracle.com>
 <81bd3937-482c-23be-840f-6766ca0ec65d@linux.intel.com>
 <8e5d944f-d89e-4618-a6c6-0eb096354e2d@oracle.com>
 <db5d7ebf-496d-47df-aa1c-3db2f12edc19@oracle.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <db5d7ebf-496d-47df-aa1c-3db2f12edc19@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/17/23 10:25 PM, Joao Martins wrote:
> On 17/10/2023 15:16, Joao Martins wrote:
>> On 17/10/2023 13:41, Baolu Lu wrote:
>>> On 2023/10/17 18:51, Joao Martins wrote:
>>>> On 16/10/2023 14:01, Baolu Lu wrote:
>>>>> On 2023/10/16 20:59, Jason Gunthorpe wrote:
>>>>>> On Mon, Oct 16, 2023 at 08:58:42PM +0800, Baolu Lu wrote:
>>>>>>> On 2023/10/16 19:42, Jason Gunthorpe wrote:
>>>>>>>> On Mon, Oct 16, 2023 at 11:57:34AM +0100, Joao Martins wrote:
>>>>>>>>
>>>>>>>>> True. But to be honest, I thought we weren't quite there yet in PASID
>>>>>>>>> support
>>>>>>>>> from IOMMUFD perspective; hence why I didn't aim at it. Or do I have the
>>>>>>>>> wrong
>>>>>>>>> impression? From the code below, it clearly looks the driver does.
>>>>>>>> I think we should plan that this series will go before the PASID
>>>>>>>> series
>>>>>>> I know that PASID support in IOMMUFD is not yet available, but the VT-d
>>>>>>> driver already supports attaching a domain to a PASID, as required by
>>>>>>> the idxd driver for kernel DMA with PASID. Therefore, from the driver's
>>>>>>> perspective, dirty tracking should also be enabled for PASIDs.
>>>>>> As long as the driver refuses to attach a dirty track enabled domain
>>>>>> to PASID it would be fine for now.
>>>>> Yes. This works.
>>>> Baolu Lu, I am blocking PASID attachment this way; let me know if this matches
>>>> how would you have the driver refuse dirty tracking on PASID.
>>>
>>> Joao, how about blocking pasid attachment in intel_iommu_set_dev_pasid()
>>> directly?
>>>
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index c86ba5a3e75c..392b6ca9ce90 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -4783,6 +4783,9 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain
>>> *domain,
>>>          if (context_copied(iommu, info->bus, info->devfn))
>>>                  return -EBUSY;
>>>
>>> +       if (domain->dirty_ops)
>>> +               return -EOPNOTSUPP;
>>> +
>>>          ret = prepare_domain_attach_device(domain, dev);
>>>          if (ret)
>>>                  return ret;
>>
>> I was trying to centralize all the checks, but I can place it here if you prefer
>> this way.

We will soon remove this check when pasid is supported in iommufd. So
less code change is better for future work.

>>
> Minor change, I'm changing error code to -EINVAL to align with non-PASID case.

Yes. Make sense. -EINVAL means "not compatible". The caller can retry.

Best regards,
baolu
