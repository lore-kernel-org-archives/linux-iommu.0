Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF7A7E6;
	Thu,  6 Apr 2023 04:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680756232; x=1712292232;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H+3tq7Z8BoI8bQectQNrsA3G/+sAKdQ5T3kjzxedhDc=;
  b=cY5hpcl6BJUfGc6F+5/RZM/xghVTlQYPzj17L+KKqifUfHKCT2MexadE
   ckpAWTRYhqaX2TL8l+FKvyBKx88QK870objtMagofTblEMvjDvuYz3Oqi
   MfTleWGO68dXsQZpZR8j4I+fkinm/ifTi3QKEr6ECesMFYggvO+UokfS4
   lFFtGwReTCxht1+oUYK8wJJBjoCTO4tPSdlkUCZNHG3VWDdk1VmmWVTXT
   vw5/W6azLYA17NgfOq+0zu65e580KW8t8+D1CcL/eKdM57avqRCWe88MU
   yUJLavcz47HVnIztEtCMLW3VI9Dj1xmfO2wtdTTEA43tLZLzkeRzCXaCV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="370472886"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="370472886"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 21:43:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="756228106"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="756228106"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga004.fm.intel.com with ESMTP; 05 Apr 2023 21:43:48 -0700
Message-ID: <143dda1a-2325-693a-710c-d47872580dc0@linux.intel.com>
Date: Thu, 6 Apr 2023 12:43:59 +0800
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
Subject: Re: [PATCH v3 14/17] iommu: Consolidate the default_domain setup to
 one function
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
 Will Deacon <will@kernel.org>
References: <14-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <14-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/6/23 7:38 AM, Jason Gunthorpe wrote:
> Make iommu_change_dev_def_domain() general enough to setup the initial
> default_domain or replace it with a new default_domain. Call the new
> function iommu_setup_default_domain() and make it the only place in the
> code that stores to group->default_domain.
> 
> Consolidate the three copies of the default_domain setup sequence. The flow
> flow requires:
> 
>   - Determining the domain type to use
>   - Checking if the current default domain is the same type
>   - Allocating a domain
>   - Doing iommu_create_device_direct_mappings()
>   - Attaching it to devices
>   - Store group->default_domain
> 
> This adjusts the domain allocation from the prior patch to be able to
> detect if each of the allocation steps is already the domain we already
> have, which is a more robust version of what change default domain was
> already doing.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
