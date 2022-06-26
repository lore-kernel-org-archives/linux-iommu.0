Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F7B7A
	for <iommu@lists.linux.dev>; Sun, 26 Jun 2022 01:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656206149; x=1687742149;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kWtrTWhVygy80koAHRds8cQZJGpxEZcR9U+1akiF+8M=;
  b=e4qkuvTSPbeKTBxGctDPx/QqwnHMHfc15gKG/D7jfeiKuKnFh14a5y/K
   zzcKtP9rk9RINjFOwVmiIfUE75KgGUxdyfYVZ+enYdzHBjF0ckfNVe28x
   opc446Y1hsL9VGOKOzV0iMjr0/90RwukgGQZdbYWdQmz9M+YRIisQBSYZ
   HcEZ225Omqgfc50mo5/uBKZLm9Y4OUHMU7KrdD1NcIQNwLacQY5jhVqDe
   La20XhoLlQE97Z1jwLLeima18I+7c2GelSkoyxh8hLTwIyMWWafvvllbS
   U8Wm3+Kc6m52h3ef1XzMhsELMmBi+W65KbDU2N69/1QCyyhfOaijLoZ0Q
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10389"; a="269973966"
X-IronPort-AV: E=Sophos;i="5.92,223,1650956400"; 
   d="scan'208";a="269973966"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 18:15:48 -0700
X-IronPort-AV: E=Sophos;i="5.92,223,1650956400"; 
   d="scan'208";a="645839129"
Received: from jzhu26-mobl1.ccr.corp.intel.com (HELO [10.249.168.26]) ([10.249.168.26])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 18:15:44 -0700
Message-ID: <068df2f5-1e14-8249-ac14-55864e6a4488@linux.intel.com>
Date: Sun, 26 Jun 2022 09:15:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
 Liu Yi L <yi.l.liu@intel.com>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 00/11] iommu: SVA and IOPF refactoring
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220621144353.17547-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID: <20220626011542.K-OIdgCwYyOPvXOw3AAjBT_ZeG1N2xib5gPMsfj54-A@z>

Hi folks,

On 2022/6/21 22:43, Lu Baolu wrote:
> Hi folks,
> 
> The former part of this series refactors the IOMMU SVA code by assigning
> an SVA type of iommu_domain to a shared virtual address and replacing
> sva_bind/unbind iommu ops with set/block_dev_pasid domain ops.
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
> [2]https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v9
> 
> Please review and suggest.

Just a gentle ping on this series.

Do you have further inputs? I am trying to see if we can merge this
series for v5.20. The drivers also depend on it to enable their kernel
DMA with PASID.

Sorry to disturb you.

Best regards,
baolu
