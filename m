Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F40C20EE
	for <iommu@lists.linux.dev>; Thu, 16 Mar 2023 07:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678951884; x=1710487884;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/RZV+NKoVH+A+UzBt07KdobJa/g/QegZ+SlgrfhPIfk=;
  b=bSfiil7DolxZJBMvsjFFpHwdoVkxbmXV4hY6e7jAJzV4aUtqbfBp1vK6
   2eDvYasxdQ4iEEHaxAdd3iCdeACZjn+HIm6VgMglMS80NuUZFvySuJujM
   SKGSe5QaK8STrfxqCCvb3PBolvEDJ9VgcUWjFrxN/sHTGEgbfiPXkP/R1
   VpTq8DbydQzNzy8f3DC97titW8M53CWmk09bKLPdewkSWciw4TfIHIgbJ
   MbkJBPywucrWVctva4e20T+FYdQvqkx+F/86uS/T7h6OvZN9Thj5QXyxO
   KHSMGA0ONK7xRhJLJ2rx2A/6aIoDSkwpuW0TPRfDaGkWa942i25X6+7ZW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="321755347"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="321755347"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 00:31:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="657087475"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="657087475"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.173.173]) ([10.249.173.173])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 00:31:21 -0700
Message-ID: <9cd8f9b8-2362-2145-6f5d-edf47087aca3@linux.intel.com>
Date: Thu, 16 Mar 2023 15:31:19 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Yu, Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] iommu/vt-d: Allow SVA with device-specific IOPF
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
References: <20230309025639.26109-1-baolu.lu@linux.intel.com>
 <20230309025639.26109-3-baolu.lu@linux.intel.com>
 <BN9PR11MB5276F50D86F8DA507CC18AF18CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276F50D86F8DA507CC18AF18CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/16 15:09, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, March 9, 2023 10:57 AM
>>
>> @@ -4650,7 +4650,18 @@ static int intel_iommu_enable_sva(struct device
>> *dev)
>>   	if (!(iommu->flags & VTD_FLAG_SVM_CAPABLE))
>>   		return -ENODEV;
>>
>> -	if (!info->pasid_enabled || !info->pri_enabled || !info->ats_enabled)
>> +	if (!info->pasid_enabled)
>> +		return -EINVAL;
>> +
> 
> I think you still want to check ats_enabled even for device specific IOPF.

Yeah! Updated.

Best regards,
baolu
