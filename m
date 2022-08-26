Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E901FCC
	for <iommu@lists.linux.dev>; Fri, 26 Aug 2022 04:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661487504; x=1693023504;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YsDHteRcq1xMbpE+Et5nCrI0+XEVYx8Ur9biKx/cQPU=;
  b=S3CNfNWd5sWf7QXFsXIjAXBPsQwmCn55oKU47joGmuxigleijCJJZm+Q
   lmxGIMeSkkvR5roLNi0sdmCUj+sMh+CAz45j6KOiA9yCsYB1EQ7cHnwgA
   LaTUE2wCP99kRWVA1J2J5qUiwJP44uKCT23IoQq3ZJso2LngvaFAhe5Qp
   zRs1eLuQsfCHprK2jPoHWOOy00xc4RHfJ1+vW2bkQFkew0XhRjYxibl6+
   D3J5HPAGcFl+NBp16S0s8OZYoBDMrRzFCiqUwLgyjk12ZX6b9yrUpPGkw
   FT9PepjjoFrHiGGOpfnrXNHK0BI9KXSPK4zR+uNy+/N0VyNIwfvax1YQX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="274814855"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="274814855"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 21:17:15 -0700
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="587156893"
Received: from xjing1-mobl1.ccr.corp.intel.com (HELO [10.254.211.48]) ([10.254.211.48])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 21:17:08 -0700
Message-ID: <c160bb06-5739-d1bb-f9a9-722a24e567c7@linux.intel.com>
Date: Fri, 26 Aug 2022 12:17:06 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Cc: baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
 Liu Yi L <yi.l.liu@intel.com>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Zhu Tony <tony.zhu@intel.com>,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 00/13] iommu: SVA and IOPF refactoring
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220817012024.3251276-1-baolu.lu@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220817012024.3251276-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/8/17 9:20, Lu Baolu wrote:
> Hi folks,
> 
> The former part of this series introduces the IOMMU interfaces to attach
> or detach an iommu domain to/from a pasid of a device, and refactors the
> exsiting IOMMU SVA implementation by assigning an SVA type of iommu
> domain to a shared virtual address and replacing sva_bind/unbind iommu
> ops with a set_dev_pasid domain ops.
> 
> The latter part changes the existing I/O page fault handling framework
> from only serving SVA to a generic one. Any driver or component could
> handle the I/O page faults for its domain in its own way by installing
> an I/O page fault handler.
> 
> This series has been functionally tested on an x86 machine and compile
> tested for all architectures.
> 
> This series is also available on github:
> [2]https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v11
> 
> Please review and suggest.

Thank you all for review and test. I have updated this series and
uploaded a new version at

https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v12

Zhangfei and Tony have tested it on real Intel and arm64 hardware.

I will soon post it for further review.

Best regards,
baolu
