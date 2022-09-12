Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F9C7F
	for <iommu@lists.linux.dev>; Mon, 12 Sep 2022 03:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662951930; x=1694487930;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=Vv/NFABKrupmGlwLBHHPWg5ZixXuw6qSJDDpj/HkRNg=;
  b=d6H5krnU1mEB/c0jNdh4y7yn+DmEn8VknOre8KzrJazoXiEr8/5FNmqq
   6w7BCKU4MQ7NTn+poBh1/9ePdct6R6AAAEpN2e4BvrWDxTnDRmm0wIGkt
   1GaUZwrNOwSIgbw7+LZS+YefoTq1dF4f0f5IMWrxeWUeucSDTCyRsPnJm
   5rLM6V5UPyoUL4zR+l06Q+V4PdXlqJYrvkOZLHtNRtufAGDlfqUAQXaAt
   GFJN1VZtYSqRvNh8/5UEH+XgLj15Z57kFnHYbF58nZ0dIlnpPJpD/BHTG
   nUwQt9yGHfdCFjPewlGIWtigUyZ3jX8eaHkzuybtxdbtP2QexqNmVqzNm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="278167593"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="278167593"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 20:05:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="646281428"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.195]) ([10.254.208.195])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 20:05:25 -0700
Message-ID: <ebeaa201-d2ab-1c3b-f865-743a7f7deef4@linux.intel.com>
Date: Mon, 12 Sep 2022 11:05:23 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Cc: baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
 Liu Yi L <yi.l.liu@intel.com>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Zhu Tony <tony.zhu@intel.com>,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Vinod Koul <vkoul@kernel.org>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v13 00/13] iommu: SVA and IOPF refactoring
In-Reply-To: <20220906124458.46461-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/9/6 20:44, Lu Baolu wrote:
> Hi folks,
> 
> The former part of this series introduces the IOMMU interfaces to attach
> or detach an iommu domain to/from a pasid of a device, and refactors the
> existing IOMMU SVA implementation by assigning an SVA type of iommu
> domain to a shared virtual address and replacing sva_bind/unbind iommu
> ops with set/remove_dev_pasid ops.
> 
> The latter part changes the existing I/O page fault handling framework
> from only serving SVA to a generic one. Any driver or component could
> handle the I/O page faults for its domain in its own way by installing
> an I/O page fault handler.
> 
> This series has been functionally tested by Tony Zhu on Intel hardware
> and Zhangfei Gao on arm64 (Kunpeng920) hardware. Thanks a lot for the
> efforts.
> 
> This series is also available on github:
> https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v13
> 
> Please review and suggest.

Hi Joerg,

Can you please help to look at this series. Is there anything to be
improved? Whose else "reviewed-by" would you like to see?

Best regards,
baolu
