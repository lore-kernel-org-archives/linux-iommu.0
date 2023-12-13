Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C61ECE
	for <iommu@lists.linux.dev>; Wed, 13 Dec 2023 02:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YbvCQSiA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702433925; x=1733969925;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9NrtGXpCILFoIwZ2JfsOrOGHmtAmNMQVqNtQuAv4cBM=;
  b=YbvCQSiAtqK7VmWvRP1h5WCXdmmt4+ewLyq7QTQbM5tiN5pUucIdVT0M
   Oe+abJRWYWXaWF09UJie8j17JUkfEWxbl3dQptdKHYvD/ahU+5kFJB4tX
   WtmjjLVAUArOEUpHlCP7CAVnNxzi8+Yrb+mVP77H45rT1GTfb7c1F2CnJ
   YXt7jsXuWPHgtzntsv/BWI0KKG4rs9eQkjCnGVqQCfPn8kNHvDJF/NGnm
   mpbYAx5eWzoVlIXKnU+tTNX9oPYmJ8v7zy0pTZkC9xlkOgtqhAGAZ6lb/
   bDC/HYtLKeuFLTlTvgGt1iyHbAFrcz/RRXsMHMMFTRXD3WM4t2tFFmWZz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="461376940"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="461376940"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 18:18:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="723466699"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="723466699"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga003.jf.intel.com with ESMTP; 12 Dec 2023 18:18:40 -0800
Message-ID: <6334aaf3-ed7c-4ded-827d-423b861a0b28@linux.intel.com>
Date: Wed, 13 Dec 2023 10:14:00 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Longfang Liu <liulongfang@huawei.com>, Yan Zhao <yan.y.zhao@intel.com>,
 iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 12/12] iommu: Use refcount for fault data access
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20231207064308.313316-1-baolu.lu@linux.intel.com>
 <20231207064308.313316-13-baolu.lu@linux.intel.com>
 <20231211152456.GB1489931@ziepe.ca>
 <416b6639-8904-4b31-973c-d5522e2731d8@linux.intel.com>
 <20231212151447.GC3013885@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231212151447.GC3013885@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/12/23 11:14 PM, Jason Gunthorpe wrote:
> On Tue, Dec 12, 2023 at 01:17:47PM +0800, Baolu Lu wrote:
>> On 12/11/23 11:24 PM, Jason Gunthorpe wrote:
>>> Also iopf_queue_remove_device() is messed up - it returns an error
>>> code but nothing ever does anything with it 🙁 Remove functions like
>>> this should never fail.
>> Yes, agreed.
>>
>>> Removal should be like I explained earlier:
>>>    - Disable new PRI reception
>> This could be done by
>>
>> 	rcu_assign_pointer(param->fault_param, NULL);
>>
>> ?
> Not without a synchronize_rcu
> 
> disable new PRI reception should be done by the driver - it should
> turn off PRI generation in the IOMMU HW and flush any HW PRI queues.

Yeah! Get you now.

Best regards,
baolu
