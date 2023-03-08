Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76EB3C31
	for <iommu@lists.linux.dev>; Wed,  8 Mar 2023 12:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678279330; x=1709815330;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=29o2cwZcp0uNN2yTXLNULJ5waAjC0u0sMMDpQGf4E3s=;
  b=cAqolY0WUvgls1D6opaCc5YhP6bR34kn+9T6PPaeFjT0wkTf+p9gt+/Z
   nOn8l/+NtZ7qz0b1SNZzXZ3UYkDNx+antvbzHDnB1fTc9TjTmhqUHWrL5
   /Zb37qjAZvG2lwrZbzntT7DNGt9N4mS9fNVZqQnaywgmnxNz7j3VaLL8X
   uWotYsU1zRHh8t2AjT8oERtLk3/WctUsgeIf7BpM4YZ49Cr5RYY5QNsz8
   sQgUmzbqyDva92kr0quxxEZ/VTwkF+5V+ZS1oDyn7fmHrGO7iRFoZdzte
   9JNXrYWNJdA6M4193cl9XJ35sjoCfb/mzfkoVsFJSJUYwnsxP8RHPQ8gl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="333612095"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="333612095"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 04:42:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="745896286"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="745896286"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.208.136]) ([10.254.208.136])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 04:42:08 -0800
Message-ID: <3c7670bf-4929-63ef-fd3e-9a170d05bab1@linux.intel.com>
Date: Wed, 8 Mar 2023 20:42:06 +0800
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
Subject: Re: [PATCH v2 08/17] iommufd: Move putting a hwpt to a helper
 function
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>, linux-kselftest@vger.kernel.org
References: <8-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <8-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/8 8:35, Jason Gunthorpe wrote:
> Next patch will need to call this from two places.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
