Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C9EA21;
	Thu,  6 Apr 2023 03:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680751731; x=1712287731;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ABnMoHUGIAVQUEkp3jWl1cYgBp5vZkOHc8L6mtCaNv0=;
  b=ktcrs9r+OZ6Xh5eVnPVUeJ13qBVcTaMJFmLh5e30SVU2OYzY0lPlWh/B
   pYsL8ul18jAHpGss4/yIuxrPLcsNqmRbYuEGXpy5bGkRZH8yBjgEITn/M
   TqWokMv/yUw0NV/nhoeTJLnp1Nkp0uLfEd+cnRGcF6yNlq9gBJhI0sAYx
   tedtPdEcM1YbawqPRHtLsZF5LSmc3R4yT+kkSdaolcNk6zT63Aki/nDbF
   QDwG1HCmtjSbksh3/UzdHgGsBCukLzCFVLwBBXtC84FEIhsau8P/ldbLf
   b9bUJ1aqHzCr9OaJBAVOYnPM7EH8kUQZuEnw8UM1RXYGPRViWjrl48YkH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="323005021"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="323005021"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 20:28:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="664274820"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="664274820"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2023 20:28:46 -0700
Message-ID: <52d12f8a-d82e-218c-c2f1-d0d6a096c30e@linux.intel.com>
Date: Thu, 6 Apr 2023 11:28:57 +0800
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
Subject: Re: [PATCH v3 07/17] iommu: Make iommu_group_do_dma_first_attach()
 simpler
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
 Will Deacon <will@kernel.org>
References: <7-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <7-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/6/23 7:38 AM, Jason Gunthorpe wrote:
> It should always attach to the current group->domain, so don't take in a
> domain parameter. Use the __iommu_device_set_domain() common code to
> handle the attach.
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
