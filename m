Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AE1A21;
	Thu,  6 Apr 2023 03:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680750859; x=1712286859;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/8hOr+s6VmkPEvRsneynDTKSnVSIpXgL8+RNoA3j9Qs=;
  b=S9w3wKj1ipdw7jTdwEVB881zohWqHCVykw1t8Wif8pvNuI5g8Nh/bTAY
   +77kZEu0l2f5tT/BGMtqu/WFU+NTGu+3JqGEfAVgIvVhC638EGxxqTA9k
   fp/8HlQXkU9xvxR2gvz/eeWiZTtPBI7m3zSgQ1xQf3WNjF2aqF2ZivUh6
   Piw3YktNYVpU5+wwNe+4vmHcZQoc4ezxYNAPDiw8YaB6yV8FqVvWd++yu
   GQ/zKjFnjdvkd+hKTeiaw3XA/ZHNcJk+Oxc9SE4impYlU+LVhuD9rnoTl
   2Q/heVQrVfQ0mBBf4D2cHBSOb55uzLtPw1yEYxI8YMjwnwRBRvB9twUSK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="322275861"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="322275861"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 20:14:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="1016707552"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="1016707552"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga005.fm.intel.com with ESMTP; 05 Apr 2023 20:14:15 -0700
Message-ID: <fd676ef4-4f43-8d0b-1a46-3ca92010d151@linux.intel.com>
Date: Thu, 6 Apr 2023 11:14:25 +0800
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
Subject: Re: [PATCH v3 10/17] iommu: Do iommu_group_create_direct_mappings()
 before attach
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
 Will Deacon <will@kernel.org>
References: <10-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <10-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/6/23 7:38 AM, Jason Gunthorpe wrote:
> The iommu_probe_device() path calls iommu_create_device_direct_mappings()
> after attaching the device.
> 
> IOMMU_RESV_DIRECT maps need to be continually in place, so if a hotplugged
> device has new ranges the should have been mapped into the default domain
> before it is attached.
> 
> Move the iommu_create_device_direct_mappings() call up.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
