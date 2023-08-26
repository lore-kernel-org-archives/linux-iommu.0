Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D88E37C
	for <iommu@lists.linux.dev>; Sat, 26 Aug 2023 07:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693033505; x=1724569505;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mhlcGuQVeMpelWJSHYtiMjji6VrBxAVhVDBLt5DLy0k=;
  b=d23VCOMy7hsAndKhlBQY+eKop08gC6a1MCBIXM8XECwEvNeJs1gOn5SH
   6MkTOFwhCiUqzEVcUfvtfsV+Czeh/FDBW3E7wVHWSIY7sipJMJRwlnFLi
   2o428NuRfozJqNLfgMb6zTZmMdtFduxtQ4Z8BRs2S6MiRBUedJWhXBhP6
   YQbYMZz5i+e1qj325mb43tOQg6xbngeWETT4NV5RGeqTsn4ffCahSr9Se
   sgC8Z2b/BML/YN0lqD20crvpLaWY59DQgBBxnfEG3Ni8nhM1+0ybhSF96
   RFqIcOAvcMHG1jKZZLG9ddKLdb3WaX9FYeWseUPqNskezKkEHlKO7+mVi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="461218397"
X-IronPort-AV: E=Sophos;i="6.02,203,1688454000"; 
   d="scan'208";a="461218397"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2023 00:05:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="803180456"
X-IronPort-AV: E=Sophos;i="6.02,203,1688454000"; 
   d="scan'208";a="803180456"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga008.fm.intel.com with ESMTP; 26 Aug 2023 00:05:01 -0700
Message-ID: <7985c942-0cdb-7637-6610-fa5a8963f2ae@linux.intel.com>
Date: Sat, 26 Aug 2023 15:02:25 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 07/10] iommu: Merge iommu_fault_event and iopf_fault
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20230825023026.132919-1-baolu.lu@linux.intel.com>
 <20230825023026.132919-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276E342E0E774CABA484B258CE3A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276E342E0E774CABA484B258CE3A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/23 4:03 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Friday, August 25, 2023 10:30 AM
>>
>> -/**
>> - * struct iommu_fault_event - Generic fault event
>> - *
>> - * Can represent recoverable faults such as a page requests or
>> - * unrecoverable faults such as DMA or IRQ remapping faults.
>> - *
>> - * @fault: fault descriptor
>> - * @list: pending fault event list, used for tracking responses
>> - */
>> -struct iommu_fault_event {
>> -	struct iommu_fault fault;
>> -	struct list_head list;
>> -};
>> -
> 
> iommu_fault_event is more forward-looking if unrecoverable fault
> will be supported in future. From this angle it might make more
> sense to keep it to replace iopf_fault.

Currently IOMMU drivers use

int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
                        unsigned long iova, int flags)

to report unrecoverable faults. There is no need for a generic fault
event structure.

So alternatively, we can use iopf_fault for now and consolidate a
generic fault data structure when there is a real need.

Best regards,
baolu
