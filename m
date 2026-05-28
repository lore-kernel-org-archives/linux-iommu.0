Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3771C2AA
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 02:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779934519; cv=none; b=dvE8kNL4I3sCSt/b1McveIAaGqF4yQj4UO0fmUVvHEvdjr4qdc6Aige4G9bzKcOlIXZJJ/0YiLyscqPsDkXuTL+Z0tHRcakr1l6pSfOe79SpTOFdtdYXsEP/XSKqe8DRCVOSGts6Ld/SDSFIUEd4EMqzOs4fWqxof4u6+7VsHNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779934519; c=relaxed/simple;
	bh=ySsSe3kocKWFBSTn5/xRtppthxxbKUxezG8r+kQ73n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+faXZU9Jjw9BZGknQIPsHoZalgx5r5GZKkzg4j7tXeL2B0rdb4fLxglYNzU65g59kBIcAg7O1mqgkG8zXXe1dbfFVwYGLNM0zP8ca5JNYWcLuD68BJFU6UamFclvk7bYGY/43PMoR/+za/KSX85mprnYEwHSh4e9ZJzAkHYyoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=e6iVcMqd; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="e6iVcMqd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779934509; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CqkkvmL1ny0yRU021Gn+ORvLvnGOWCzhAer9Us3sPlQ=;
	b=e6iVcMqdqLvy+RkcExmpkLvuEPmAiiFC+bcq38V3AbcSsJ5VHudkjNT0l+x8gev0pcqBZMWwSdWK3kx+LjGWbvBFJ62wTOttUkSrNCRoWjqoKbqHhtanOX8zvF+UiqgXtYoL8Oyh6rA0kI29NWnRohINgEKoo5Wju+1o/NF6NoM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X3l.fhs_1779934492;
Received: from 30.221.133.224(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X3l.fhs_1779934492 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 May 2026 10:15:08 +0800
Message-ID: <4adaa6b9-6dc0-4d78-8eeb-dbe9059e76a8@linux.alibaba.com>
Date: Thu, 28 May 2026 10:14:52 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: improve IOMMU fault information
To: Baolu Lu <baolu.lu@linux.intel.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: xlpang@linux.alibaba.com, oliver.yang@linux.alibaba.com
References: <20260525034755.3645658-1-guanghuifeng@linux.alibaba.com>
 <f7c018b4-01e0-4693-99aa-de8d370c8a42@linux.intel.com>
From: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <f7c018b4-01e0-4693-99aa-de8d370c8a42@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/5/26 9:57, Baolu Lu 写道:
> On 5/25/26 11:47, Guanghui Feng wrote:
>> In some environments, multiple PCIe segments exist, and PCIe device
>> information needs to be differentiated and identified based on the
>> segment. When an IOMMU fault event occurs, the IOMMU and device segment
>> information should be output in detail in dmar_fault_do_one.
>>
>> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
>> ---
>>   drivers/iommu/intel/dmar.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>> index d33c119a935e..ca9afbb55e76 100644
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -1894,7 +1894,8 @@ static int dmar_fault_do_one(struct intel_iommu 
>> *iommu, int type,
>>       reason = dmar_get_fault_reason(fault_reason, &fault_type);
>>         if (fault_type == INTR_REMAP) {
>> -        pr_err("[INTR-REMAP] Request device [%02x:%02x.%d] fault 
>> index 0x%llx [fault reason 0x%02x] %s\n",
>> +        pr_err("[DMAR:%s] [INTR-REMAP] Request device 
>> [%04x:%02x:%02x.%d] fault index 0x%llx [fault reason 0x%02x] %s\n",
>> +               iommu->name, iommu->segment,
>>                  source_id >> 8, PCI_SLOT(source_id & 0xFF),
>>                  PCI_FUNC(source_id & 0xFF), addr >> 48,
>>                  fault_reason, reason);
>> @@ -1903,14 +1904,18 @@ static int dmar_fault_do_one(struct 
>> intel_iommu *iommu, int type,
>>       }
>>         if (pasid == IOMMU_PASID_INVALID)
>> -        pr_err("[%s NO_PASID] Request device [%02x:%02x.%d] fault 
>> addr 0x%llx [fault reason 0x%02x] %s\n",
>> +        pr_err("[DMAR:%s] [%s NO_PASID] Request device 
>> [%04x:%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
>> +               iommu->name,
>
> Do you really need to dump "iommu->name"? It is purely assigned by the
> IOMMU driver software. Do you mind explaining what kind of information
> you want to get from it?
>
Thanks for your reply.

1. In environments with multiple PCIe segments/domains, precise 
differentiation based on device information

is needed when an IOMMU fault occurs. Therefore, segment information was 
added.

2. Adding IOMMU information to an IOMMU fault is not mandatory. Related 
IOMMU information

can be obtained through various methods such as 
/sys/bus/pci/devices/[bdf]/iommu.


A new patch will be resubmitted for modification.

>>                  type ? "DMA Read" : "DMA Write",
>> +               iommu->segment,
>>                  source_id >> 8, PCI_SLOT(source_id & 0xFF),
>>                  PCI_FUNC(source_id & 0xFF), addr,
>>                  fault_reason, reason);
>>       else
>> -        pr_err("[%s PASID 0x%x] Request device [%02x:%02x.%d] fault 
>> addr 0x%llx [fault reason 0x%02x] %s\n",
>> +        pr_err("[DMAR:%s] [%s PASID 0x%x] Request device 
>> [%04x:%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
>> +               iommu->name,
>>                  type ? "DMA Read" : "DMA Write", pasid,
>> +               iommu->segment,
>>                  source_id >> 8, PCI_SLOT(source_id & 0xFF),
>>                  PCI_FUNC(source_id & 0xFF), addr,
>>                  fault_reason, reason);
>
> Thanks,
> baolu
