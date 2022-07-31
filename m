Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A4028F6
	for <iommu@lists.linux.dev>; Sun, 31 Jul 2022 13:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659274410; x=1690810410;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L128BTCkAu3V8yEsnQdkBwexWdo++stpksb66pAAfVo=;
  b=lG9DJAE9LrCz0EJXG40SThu47J7J9WvjbnT99nlEXu4mZRM6PLaJLZof
   vtsn5iFSsvjsWVdjZodOJMGcIl3pHqoSlNjvjw2TJQL0CxwQnkgo1A+JY
   bvovfdrUrv7L3pFDwfa00CvJc7akm30599lFcztmhprHvEMXpP4XF9Nci
   0ELkaFiuoEhFJcIExdLD/uEq0f63wf5YYvT4cmymyeFIWeQwj9Oo54dGs
   gJBZ8/no4pMDo6pLeC0/zllsd1K0bP0MLEd/5Ro8Ku2C6KWy1RlKKJB4+
   oGeD8emiyI6UOMhZCsN41bWQcsokkFHoI9ZN1S2KPklwG9Os08K9rEqxM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="314812552"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="314812552"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 06:33:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="629930609"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.191]) ([10.254.208.191])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 06:33:24 -0700
Message-ID: <31134c57-8f2c-d5a9-20d3-1c089a6ff58f@linux.intel.com>
Date: Sun, 31 Jul 2022 21:33:22 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc: baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Zhu Tony <tony.zhu@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 01/12] iommu: Add max_pasids field in struct
 iommu_device
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-2-baolu.lu@linux.intel.com>
 <a837d035-1897-99f1-03e5-0d02ab9f2b4f@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <a837d035-1897-99f1-03e5-0d02ab9f2b4f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Yi,

Thanks for reviewing my series.

On 2022/7/31 19:54, Yi Liu wrote:
> On 2022/7/5 13:06, Lu Baolu wrote:
>> Use this field to keep the number of supported PASIDs that an IOMMU
>> hardware is able to support. This is a generic attribute of an IOMMU
> 
> a nit. it should be the max pasid value an IOMMU hardware can support
> instead of number of PASIDs. right?

More accurately, it's maximum number of PASIDs supported by IOMMU
hardware".

Best regards,
baolu
