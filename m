Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B193D63
	for <iommu@lists.linux.dev>; Fri, 23 Sep 2022 13:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663938493; x=1695474493;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=+jRBBhYHBopY23l9bBAFyyx9K8uw3Z3+aT+0POwRhTE=;
  b=Qa3iTBjfyxHS1GgqVqELe7q0sHYuEc4imP/R2Ugp7DWXSWmVursn3xpd
   tNhZnNtshUp52GodjfNj7Ffe6tN0RV9nuobfwFFNhHJBL6bTfDOG8rRmq
   UQqKjorr4410q9vUwHxKW7maFqr2QU3gTPNLit/LHcZTP9moYP/LhyNs0
   VOHAWtHqqo9po9BHfMBNvZM6ASwNLCXBBDEZ9+Z0rZdFhxAmhxzUE29d1
   aV1sP+JskuseSkfeerQuqRb5PF6GAdQZPLs5So21vNk+V/XKIc5cAj63z
   jGnDtuw6P+kwBdBZnRMB6f1+xtjvjNI6Vp/iQNLgPI7mLLeA9r7jFwkpg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="362398719"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="362398719"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 06:08:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="724121402"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.140]) ([10.254.214.140])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 06:08:06 -0700
Message-ID: <9fc74da5-7bee-affe-c603-860d23b5f02f@linux.intel.com>
Date: Fri, 23 Sep 2022 21:08:04 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Cc: baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
 Liu Yi L <yi.l.liu@intel.com>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Zhu Tony <tony.zhu@intel.com>,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Vinod Koul <vkoul@kernel.org>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
 <ebeaa201-d2ab-1c3b-f865-743a7f7deef4@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v13 00/13] iommu: SVA and IOPF refactoring
In-Reply-To: <ebeaa201-d2ab-1c3b-f865-743a7f7deef4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/9/12 11:05, Baolu Lu wrote:
> On 2022/9/6 20:44, Lu Baolu wrote:
>> Hi folks,
>>
>> The former part of this series introduces the IOMMU interfaces to attach
>> or detach an iommu domain to/from a pasid of a device, and refactors the
>> existing IOMMU SVA implementation by assigning an SVA type of iommu
>> domain to a shared virtual address and replacing sva_bind/unbind iommu
>> ops with set/remove_dev_pasid ops.
>>
>> The latter part changes the existing I/O page fault handling framework
>> from only serving SVA to a generic one. Any driver or component could
>> handle the I/O page faults for its domain in its own way by installing
>> an I/O page fault handler.
>>
>> This series has been functionally tested by Tony Zhu on Intel hardware
>> and Zhangfei Gao on arm64 (Kunpeng920) hardware. Thanks a lot for the
>> efforts.
>>
>> This series is also available on github:
>> https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v13
>>
>> Please review and suggest.
> 
> Hi Joerg,
> 
> Can you please help to look at this series. Is there anything to be
> improved? Whose else "reviewed-by" would you like to see?

It seems that Jean/Kevin/Jason/Yi are satisfied with this series now. I
will post a new version and check whether we are lucky to have it in
v6.1.

Best regards,
baolu
