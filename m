Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE97E613A
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 10:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691577664; x=1723113664;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JJghwIXXHT4UB5NHzHlq8b7Yl1CvVOGiPlOyugRhpog=;
  b=YP1LERDpm6Vy6TyAdsSuJw/PeY20LV1o+aLG+b4orbKEi+UzbnHSdpmm
   8BWk12fv8a++iTFXEMpF7FCBBlsg1xQQu4Cw5Cdw89tDMKnNGyw17+uUN
   AWF+nvt+8a6NVxqwK4v7a2miicxp/I8bpwpRQudOW6Jx+2iQjq4OvTA7p
   51e9H6SdEdXKOI4yXlWgSCDbcfzsJY/tXwT0y2aYZCoSWt6b4/3rAMDyB
   0uoxUsXJwBs2TqMmhyQqOdEtqA30U6iD0e/x4FGGoj+DgUmVJu/27t4SJ
   Mme3+pBE0l9rnRQwZHOjx7seqOa/ajR/mPBvo5IqUARvmMMHeLxorgQvo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="371078329"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="371078329"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 03:41:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="761335613"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="761335613"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.171]) ([10.254.210.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 03:40:59 -0700
Message-ID: <0771c28d-1b31-003e-7659-4f3f3cbf5546@linux.intel.com>
Date: Wed, 9 Aug 2023 18:40:56 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/12] iommu: Prepare for separating SVA and IOPF
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-9-baolu.lu@linux.intel.com>
 <BN9PR11MB52769D22490BB09BB25E0C2E8C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZNKMz04uhzL9T7ya@ziepe.ca>
 <BN9PR11MB527629949E7D44BED080400C8C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527629949E7D44BED080400C8C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/9 8:02, Tian, Kevin wrote:
>> From: Jason Gunthorpe <jgg@ziepe.ca>
>> Sent: Wednesday, August 9, 2023 2:43 AM
>>
>> On Thu, Aug 03, 2023 at 08:16:47AM +0000, Tian, Kevin wrote:
>>
>>> Is there plan to introduce further error in the future? otherwise this should
>>> be void.
>>>
>>> btw the work queue is only for sva. If there is no other caller this can be
>>> just kept in iommu-sva.c. No need to create a helper.
>>
>> I think more than just SVA will need a work queue context to process
>> their faults.
>>
> 
> then this series needs more work. Currently the abstraction doesn't
> include workqueue in the common fault reporting layer.

Do you mind elaborate a bit here? workqueue is a basic infrastructure in
the fault handling framework, but it lets the consumers choose to use
it, or not to.

Best regards,
baolu
