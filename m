Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643ED1117
	for <iommu@lists.linux.dev>; Tue, 22 Nov 2022 09:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669110083; x=1700646083;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1Swr/I9sQW6CPiPNNMpEuYMvaDwNwo1muk4uoR1T45A=;
  b=MlKT3a1oxtXzaiDybW1KlZo0vciWan/AGjKDaHUQXdzJ12vxLsm+jzOh
   SDBEsJ2Lxa+ukI3nkJSH5rzSd97fYVECYW5X2KxMqZ2m61xTMNwnkLlNH
   2I3jXOEig0olej4OIWX6QzxiX3NshpxMvZPsDdUzO1d0jXsvk4FLowmoX
   ZDMSEMmEOfXTMeM25M6t600L5E+JdTAAN4DdcsH2bKSCxzLXKhY1TODIG
   eYd9Gfny64hqJ9VFK+1vRWVGzadbf7FN+1lODvmkDfJyWJfqvqz+EWJaD
   z2bqsS83qDRTvJZRxhPvBKteaKEH7is1sj54KlWcWXuzaKpL8el4CeQzr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="400065664"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="400065664"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 01:41:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="970412655"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="970412655"
Received: from yadanwan-mobl1.ccr.corp.intel.com (HELO [10.254.215.189]) ([10.254.215.189])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 01:41:21 -0800
Message-ID: <25981cc9-243e-bece-4e85-86f3c880d96f@linux.intel.com>
Date: Tue, 22 Nov 2022 17:41:19 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] [PULL REQUEST] Intel IOMMU updates for Linux v6.2
To: Joerg Roedel <joro@8bytes.org>
References: <20221122002949.148140-1-baolu.lu@linux.intel.com>
 <Y3yRMXGPcYbXH9uL@8bytes.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y3yRMXGPcYbXH9uL@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Joerg,

On 2022/11/22 17:06, Joerg Roedel wrote:
> Hi Baolu,
> 
> On Tue, Nov 22, 2022 at 08:29:42AM +0800, Lu Baolu wrote:
>> Lu Baolu (7):
>>    iommu/vt-d: Allocate pasid table in device probe path
>>    iommu/vt-d: Add device_block_translation() helper
>>    iommu/vt-d: Add blocking domain support
>>    iommu/vt-d: Rename iommu_disable_dev_iotlb()
>>    iommu/vt-d: Rename domain_add_dev_info()
>>    iommu/vt-d: Remove unnecessary domain_context_mapped()
>>    iommu/vt-d: Use real field for indication of first level
> 
> Applied the first 6 patches. The last one has conflicts and doesn't
> apply on top of my x86/vt-d branch. Could you please have a look please?

I guess the last patch conflicts with below commit:

242b0aaeabbe ("iommu/vt-d: Preset Access bit for IOVA in FL non-leaf 
paging entries")

which was merged in v6.1-rc6. Can you please bring the x86/vt-d branch
to v6.1-rc6, or do you want me to rebase that patch on the existing top
of the branch?

Best regards,
baolu
