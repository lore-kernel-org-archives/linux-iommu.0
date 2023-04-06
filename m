Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9019AA21;
	Thu,  6 Apr 2023 03:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680753227; x=1712289227;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R2SCAp1rnJv8siVz44WW8dQ1n5FlYjG1RN2XpmcPq94=;
  b=n/BfFkAWxiZtTq0kp2NIx3LAhjKVD71nba1klSC7x3k9B4NXckc9WXaZ
   exj+GI/Dg7xcXzunamRdEYCSbL/RY/4qzfV+PBJM624uYkauuxUglqjdu
   NkIHkWaFQ7IeonCepbiphLScvInm6cVNO6AA8uN6jgU6bUoXjUoxiLl/d
   naQbeCSf0mQ+3BdRJ3jkf4FyDSkOs4hTIN4wkjdi7SKA74uW+OgYBPzhI
   9m3GaCO2oHpRZp0I4qOh8YKz8Rjifmv5R3hjYNYAKOvfB0AvJH8z3Pu6w
   1lEileXucD8gLIuKKnJ2c5uGqmp80e4TXZVAZ4bzpT3AX0gSoA4pr384A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="405415763"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="405415763"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 20:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="861233846"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="861233846"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga005.jf.intel.com with ESMTP; 05 Apr 2023 20:53:43 -0700
Message-ID: <b5c854ae-a877-3ac4-ffa1-e91309a358f4@linux.intel.com>
Date: Thu, 6 Apr 2023 11:53:53 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v3 15/17] iommu: Allow IOMMU_RESV_DIRECT to work on ARM
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
 Will Deacon <will@kernel.org>
References: <15-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <15-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/6/23 7:38 AM, Jason Gunthorpe wrote:
> For now several ARM drivers do not allow mappings to be created until a
> domain is attached. This means they do not technically support
> IOMMU_RESV_DIRECT as it requires the 1:1 maps to work continuously.
> 
> Currently if the platform requests these maps on ARM systems they are
> silently ignored.
> 
> Work around this by trying again to establish the direct mappings after
> the domain is attached if the pre-attach attempt failed.
> 
> In the long run the drivers will be fixed to fully setup domains when they
> are created without waiting for attachment.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
