Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DA21118
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 03:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691119705; x=1722655705;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hlHNuoRdEe2YIyLpE1StOcVDQ8E30zW8HoVrh6pz52g=;
  b=V+IlK7VNt8+DYYBrfD+xW0DPjKTFwiEr1QaoGdwMIubaXbu9VJTYYzar
   B9tN0f57i4V6K/J8OqlF8VHSzd5wcVDuK26nLzl938MRlb3tJiNLu+MtR
   q7FnxppaCgFKPmyjCltJppL7RGaMUZbU6KhRf+Q3k4+hvs7/qQBU01QEK
   f+prNa8RbZnrSCzgZLpKa9r27URxPYiaJtENikZp6Y93GhBoVZSTUiQG9
   5mxfCw/XDLIeRK4PhfkZdaIDb4Y9Q7v5nnrYyXDik1l2HBPHLv9JXg9uA
   cLyWo2Jizul37PEU/VvLsktNqXOSYn6oc5e4tkOMG6cxoEICxHnyxLtJ6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="433906635"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="433906635"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 20:28:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="843878729"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="843878729"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.88]) ([10.254.210.88])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 20:28:21 -0700
Message-ID: <bb2cb2e8-4654-e866-f7f0-57130c6ac630@linux.intel.com>
Date: Fri, 4 Aug 2023 11:28:18 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 09/12] iommu: Move iopf_handler() to iommu-sva.c
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-10-baolu.lu@linux.intel.com>
 <BN9PR11MB527611063D3B88224AB769B48C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527611063D3B88224AB769B48C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/3 16:21, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, July 27, 2023 1:49 PM
>>
>> @@ -219,3 +219,52 @@ void mm_pasid_drop(struct mm_struct *mm)
>>
>>   	ida_free(&iommu_global_pasid_ida, mm->pasid);
>>   }
>> +
>> +static int iopf_complete_group(struct device *dev, struct iopf_fault *iopf,
>> +			       enum iommu_page_response_code status)
> 
> iommu_sva_complete_iopf()
> 
>> +
>> +static void iopf_handler(struct work_struct *work)
>> +{
> 
> iommu_sva_iopf_handler()
> 

Ack to both.

Best regards,
baolu
