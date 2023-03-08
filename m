Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519DC6AA3
	for <iommu@lists.linux.dev>; Wed,  8 Mar 2023 12:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678277191; x=1709813191;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Yd93i2dOo6ed11qzFdtxF6UdpnUwTKEvMIcacA1cc3E=;
  b=joAJ4PVSn7oRDkc+1mt18sUk8HZoef7lv4ZVlBa1hMuPDulwuzZprFzc
   k81tAubwVeE/Y5aC8M6xBJXrW3x+TKWsv0JsCBeWA6nTRNxZ+emawhRvC
   +LM6jQmJw7L0VC6UfCx1LPc/UVK61RgtEq5QapkBMYhrXlaHQBy4rAS/w
   LT3tXCox6ejGiEGBFpEUZAgr+1TwGoS5+ZBU54Zk06w13/yKgzif6HdJF
   Fietxa8Y63YvygT6tDrBQPyYwR58AELjU0cs4BMshZFqmgW/kZaT2S1Rt
   c93EcG4B6nCoIf+f8PIcFSoqJ1vWwH3NNbEkG1hFI1ojnf7rrrTmnpq8T
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="337653895"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="337653895"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 04:06:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="787100271"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="787100271"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.208.136]) ([10.254.208.136])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 04:06:28 -0800
Message-ID: <1d261af5-d34d-bfdd-d7ce-70bdc7368d9d@linux.intel.com>
Date: Wed, 8 Mar 2023 20:06:26 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc: baolu.lu@linux.intel.com, kvm@vger.kernel.org,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 04/17] iommu: Export iommu_get_resv_regions()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>, linux-kselftest@vger.kernel.org
References: <4-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <4-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/8 8:35, Jason Gunthorpe wrote:
> iommufd wants to use this in the next patch. For some reason the
> iommu_put_resv_regions() was already exported.

"virtio-iommu calls it and can be modular."

https://lore.kernel.org/all/20220708093332.GA28988@lst.de/

> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
