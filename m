Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4E2361
	for <iommu@lists.linux.dev>; Tue,  7 Mar 2023 01:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678153363; x=1709689363;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UMoRhlPDP2tn6UvYThHFlyDazIgakuaROHX7ynKFduQ=;
  b=X0jGsPHEVrig5NZJ+2J1oeBj8mdkcaAtj07gM+XKI6Z66lLS9rxPV9pw
   b/QqaJxcJTo3GEahQgXYlWLIffSrVGex8gzdReQJCw5OSRAtkHaK4saIz
   43zhroHB0IRaRZqq7xs4wexr846+zRocU7efzfcPOC1rRYXLmcR0bHYNy
   SYJrNcdjhpISn07rSP8s0ZQFNBlqhZjC01YhePYO754n0XFPV2DwCmfZA
   kA/1DpOicWPJoH/TLkJfftDaIDhvtH9Yt6G6vg7frnJQOA+QgkhIAPAlh
   Baefd4n7LhV14x3LhhAzCiIFSxa2rZkdvSkmVD9I3iYK9cnUkqMqKlodK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398314456"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398314456"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 17:42:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="676384284"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="676384284"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga002.jf.intel.com with ESMTP; 06 Mar 2023 17:42:39 -0800
Message-ID: <f7b0cbef-3d7d-e5aa-1971-fe230d0c80e1@linux.intel.com>
Date: Tue, 7 Mar 2023 09:41:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, dmaengine@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Alistair Popple <apopple@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Stoakes <lstoakes@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux.dev
Subject: Re: [PATCH v2 08/16] iommu: define and export
 iommu_access_remote_vm()
Content-Language: en-US
To: Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>
References: <20230306163138.587484-1-fenghua.yu@intel.com>
 <20230306163138.587484-9-fenghua.yu@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230306163138.587484-9-fenghua.yu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/7/23 12:31 AM, Fenghua Yu wrote:
> Define and export iommu_access_remote_vm() to allow IOMMU related
> drivers to access user address space by PASID.
> 
> The IDXD driver would like to use it to write the user's completion
> record that the hardware device is not able to write to due to user
> page fault.

I don't quite follow here. Isn't I/O page fault already supported?

Best regards,
baolu
