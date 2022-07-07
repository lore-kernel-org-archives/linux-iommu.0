Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4641A367
	for <iommu@lists.linux.dev>; Thu,  7 Jul 2022 03:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657162909; x=1688698909;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nh9x4dao7rW+cOue8YAdxg9Nyj1lCalyV2yGX6Iu6Vs=;
  b=arb7XPX4zYjRkVJEK8V+X3OKf+6SqzeNyOsX1jHRJP/rkUNjPEa27Ppz
   t1sbFSCJ43JyCs2X/QxYikHFWTsaMr5AmomQYE9zQJqaJBuW+RqeVSEhk
   Tg2epz14DRpnY0KTfh2r8K7ZWTo+tFwenxmdwh06zP+4U/1Y8em7IXq3O
   wB43CMHxs9PF9BkKIJIM3uJ2c3brV2g8rKp89/oDlBXJKrcqMWvl+r85l
   GFmHVkXnX9fMkROzAVLc2fzrlmvl6r5tI/uW+DHZqPEBT+kXicm0s9GzP
   nyGv80ZSxr01DLQ5aTIDle0SfE8qneM0pqJ1hqOI+IaEDSkUoJWQv1mb1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="285041312"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="285041312"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 20:01:48 -0700
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="650936196"
Received: from hualiu-mobl1.ccr.corp.intel.com (HELO [10.249.171.209]) ([10.249.171.209])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 20:01:44 -0700
Message-ID: <efe50b1b-f23d-987f-36b4-c6583cfcde6e@linux.intel.com>
Date: Thu, 7 Jul 2022 11:01:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Pan, Jacob jun"
 <jacob.jun.pan@intel.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
 "Zhu, Tony" <tony.zhu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 05/12] iommu: Add IOMMU SVA domain support
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-6-baolu.lu@linux.intel.com>
 <BN9PR11MB527676D80CA7348890320BDE8C839@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527676D80CA7348890320BDE8C839@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/7/7 09:52, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, July 5, 2022 1:07 PM
>>
>> + *	IOMMU_DOMAIN_SVA	- DMA addresses are shared process address
>> + *				  spaces represented by mm_struct's.
>>    */
> 
> s/address spaces/addresses/

Updated.

> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Best regards,
baolu
