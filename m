Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A93628
	for <iommu@lists.linux.dev>; Thu,  9 Mar 2023 01:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678324923; x=1709860923;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q1aDAPWSfqWw8MzeFLZh49l8q8u0K/Yqd7U27/xelmY=;
  b=IcHxGlu/SRw73r/DtAOV0UqOFMuhlpSh8b1tr5ear+97pXwuLpVOj9vK
   CiL7aRQp6+G1HnsvMzBSmviShJlCYYYfJeiAJh8XK3cvZxZMj+CbR6x4d
   SbKMQaF1EFawJ7Dk10Xo7CeGyt5HTa2CndEdBEnM/TXB2qS/AyLaw5gv6
   I473Gp2JXEVM4zG78avMvLTk3bOHEV+gyK79HNXP0ncqnOTBrQmNUUF94
   84htsY4/BbA1TYHhtFSFZogNEE/q1RmpPNQCiwM4l6b/llFIQBF3cGrgQ
   AEE2XHQqPk0wGJiJkpqwKLvoWz5t9/PlKOOIL1fBXR4tVfMoEKE7N1vhe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="337850701"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="337850701"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 17:22:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="851333022"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="851333022"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga005.jf.intel.com with ESMTP; 08 Mar 2023 17:22:00 -0800
Message-ID: <604a840b-ab12-5cd3-e41a-f481aafeaeed@linux.intel.com>
Date: Thu, 9 Mar 2023 09:21:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, kvm@vger.kernel.org,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 15/17] iommufd: Add IOMMU_HWPT_ALLOC
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>, linux-kselftest@vger.kernel.org
References: <15-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <15-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/8/23 8:35 AM, Jason Gunthorpe wrote:
> This allows userspace to manually create HWPTs on IOAS's and then use
> those HWPTs as inputs to iommufd_device_attach/replace().
> 
> Following series will extend this to allow creating iommu_domains with
> driver specific parameters.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
