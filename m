Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85263D63
	for <iommu@lists.linux.dev>; Fri, 23 Sep 2022 13:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663938758; x=1695474758;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X+p5MF00JMc7VDvFne6EpeMaGyGhX0RXnAUIQvwk4cs=;
  b=bmfrzHoq8aPDkehSKYEUpbiytuuR8vStB/prtOO0OkgNAqqXG18J6GF1
   zZsmrVHjZBTGDKZeTI62rI+UushC9IVsCBW5FVkN+WOZBepOZF5sZKcDv
   YeSMzVfgy0W5QUReA587YSQWY78XcXRovOk+yoI+/CNx8I/6FW973VJeA
   rKu/4WAcIchnAMYBY2rPAIp9MSmYIU3tJh4CUyll2H6SSaYa2Fbm94+cY
   aR64fFbzNqk59TzFMKdSARADZgqycFHAAq57enlsM6szv2KYN9zTTX5qk
   XEqYdBVANoYveKmik9/sL5zVw6C2+wlpZF/wOps8Z5fYjs1XflpTvLQ63
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="299306745"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="299306745"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 06:12:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="724122153"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.140]) ([10.254.214.140])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 06:12:33 -0700
Message-ID: <ef381875-80eb-6b85-2d4b-f5d8b8036618@linux.intel.com>
Date: Fri, 23 Sep 2022 21:12:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Eric Auger <eric.auger@redhat.com>,
 Liu Yi L <yi.l.liu@intel.com>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Zhu Tony <tony.zhu@intel.com>,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 07/13] iommu/vt-d: Add SVA domain support
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
 <20220906124458.46461-8-baolu.lu@linux.intel.com>
 <YyyECCbmfsaDpDgJ@nvidia.com>
 <075278e0-77ce-2361-8ded-6cd6bb20216f@linux.intel.com>
 <Yy2jbsaXuoxgR+fj@nvidia.com>
 <a0b43338-183b-3ece-c85a-e904bee27eef@linux.intel.com>
 <Yy2viUjvZsW6gx9/@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Yy2viUjvZsW6gx9/@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/9/23 21:07, Jason Gunthorpe wrote:
> On Fri, Sep 23, 2022 at 08:41:56PM +0800, Baolu Lu wrote:
>> On 2022/9/23 20:15, Jason Gunthorpe wrote:
>>> On Fri, Sep 23, 2022 at 10:21:51AM +0800, Baolu Lu wrote:
>>>
>>>> At the beginning of this project, I wanted to consolidate the mm
>>>> notifications into the core. However, ARM SMMUv3 and Intel handle the mm
>>>> notifications a little differently. Then I decided to do this work
>>>> separately from the current series.
>>> It doesn't look really different..
>> They are essentially the same, but slightly different. For example, arm
>> smmuv3 provides .free_notifier, and I don't think it could be merged to
>> the release callback.
> free_notifier allows to use mmu_notifier_put() instead of
> mmu_notifier_unregister() which avoids a synchronize_rcu() penalty on
> teardown. Intel should copy the same design.

Ah! Thanks for the guide. I will head in this direction.

Best regards,
baolu
