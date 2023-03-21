Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BD71FA0
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 05:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679377455; x=1710913455;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aYKfSTlUBleYkVyElMNA3zlWKwAfGp8fUVwgAyZJIkA=;
  b=jORDNh5EijYYRMMyHfsU6cjpvJvaldyxZcq+TXR23Wpc9n1rWmR4ZyIA
   Hc/mobZh+u/WKODpXQTAkwTnzc4NRAWK3XCItegq4SyEXvfRm0EG/21o2
   nNxmBiRYsms7qyfMcOyQ8I4SnataN654KdcmQjy1lblzDfoZSzrnycmX/
   knYPy6V/XxSPnd0lEFC4fzrFtyUH74SQ/FelbHmyRL8ybjKue0WdA6KkX
   mqocBrdr2pgQoluoDFB/UMu4ESFcDN25jyR06ElUyMaXG2g7qlv9qS5ku
   lU8we1fuK31giGuEkEu30kVmuziO0EtuXWkdPLHyMEGrZz9HqaqnM9i2J
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="340397928"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="340397928"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 22:44:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="791933553"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="791933553"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga002.fm.intel.com with ESMTP; 20 Mar 2023 22:44:11 -0700
Message-ID: <9c5d1951-5475-863b-b258-1a4cbc242f0b@linux.intel.com>
Date: Tue, 21 Mar 2023 13:43:00 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 dmaengine@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iommu/vt-d: Allow SVA with device-specific IOPF
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20230309025639.26109-1-baolu.lu@linux.intel.com>
 <20230309025639.26109-3-baolu.lu@linux.intel.com>
 <20230320090006.180efbed@jacob-builder>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230320090006.180efbed@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/23 12:00 AM, Jacob Pan wrote:
> Hi BaoLu,

Hi Jacob,

> 
> On Thu,  9 Mar 2023 10:56:36 +0800, Lu Baolu<baolu.lu@linux.intel.com>
> wrote:
> 
>> Currently enabling SVA requires IOPF support from the IOMMU and device
>> PCI PRI. However, some devices can handle IOPF by itself without ever
>> sending PCI page requests nor advertising PRI capability.
>>
>> Allow SVA support with IOPF handled either by IOMMU (PCI PRI) or device
>> driver (device-specific IOPF). As long as IOPF could be handled, SVA
>> should continue to work.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 7c2f4bd33582..d2fcab9d8f61 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4650,7 +4650,18 @@ static int intel_iommu_enable_sva(struct device
>> *dev) if (!(iommu->flags & VTD_FLAG_SVM_CAPABLE))
>>   		return -ENODEV;
>>   
>> -	if (!info->pasid_enabled || !info->pri_enabled ||
>> !info->ats_enabled)
>> +	if (!info->pasid_enabled)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * Devices having device-specific I/O fault handling should not
>> +	 * support PCI/PRI.
>> +	 */
>> +	if (!info->pri_supported)
>> +		return 0;
> If you put this check at the very beginning, everything else should it be
> the same, right?

Even for device specific IOPF, PASID/ATS are still required on the IOMMU
side.

> 
> Still feel a little weird that, SVA is tied to PRI for PCI PRI but not for
> device specific IOPF.

PCI PRI and device specific IOPF *should* be equivalent. But the IOMMU
side has no means to check the capability of device-specific IOPF.
Therefore, IOMMU can only default that if the device driver enables SVA
on a non-PRI device, it will handle IOPF in its own way.

Best regards,
baolu
