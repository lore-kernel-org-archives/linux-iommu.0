Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB31D17C6
	for <iommu@lists.linux.dev>; Tue, 14 Mar 2023 02:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678759750; x=1710295750;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G1/3y3dcSdq3xNv7u6FChjU9738dM/KXkMNrLkFY6Kc=;
  b=jhDuUuraWUdb875ZqylZ96TtReyv6PtpUHdb2EPAsgiLBnE3JxR5dewt
   PgxlxhasCdL8NCq/nGssDDTUaV8w05IVhC5YwvaLAWiLc0GDT5ktMRUth
   qKoRHKkdJo6j9S8lEXPcKfi0Xj2wG7/em5gI1HjmucZ+DsT5vwrBUBIIO
   3lZqTrw/tKbGdUjqeqjmZp18Tb66oO39T9GoEw9q3Z7lxjEWlbbzGTbwT
   5ii00eebBUDDKJQWpePuhLdnfErIBjYso7Wxl6ausSh8DBBV56oqktJvp
   I8zlGNJbzIjWDqgOSQDN4vDWxAqFXw3s87czbV2YVrC1Ib9onuR8AEel7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="399897778"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="399897778"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 19:09:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="656171382"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="656171382"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 13 Mar 2023 19:09:04 -0700
Message-ID: <c2607062-9fd1-ae66-7b2a-b1e09ff754c7@linux.intel.com>
Date: Tue, 14 Mar 2023 10:08:00 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 "Yu, Fenghua" <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>,
 Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v6 3/7] iommu/sva: Remove PASID to mm lookup function
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
 Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Robin Murphy <robin.murphy@arm.com>, Dave Hansen <dave.hansen@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, X86 Kernel <x86@kernel.org>,
 bp@alien8.de, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net, vkoul@kernel.org,
 dmaengine@vger.kernel.org, linux-doc@vger.kernel.org
References: <20230313204158.1495067-1-jacob.jun.pan@linux.intel.com>
 <20230313204158.1495067-4-jacob.jun.pan@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230313204158.1495067-4-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/23 4:41 AM, Jacob Pan wrote:
> There is no user of iommu_sva_find() function, remove it so that PASID
> allocator can be a simple IDA. Device drivers are expected to store
> and keep track of their own PASID metadata.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
