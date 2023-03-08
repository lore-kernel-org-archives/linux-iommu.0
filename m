Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B73613E
	for <iommu@lists.linux.dev>; Wed,  8 Mar 2023 11:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678276576; x=1709812576;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UBfvujX3Iv1nkdf7mtzG3zRFRnM9X/VsZJIweX1gv7k=;
  b=ep0Q6si5JKEfsZew5VY1268wARFarjOYol6juPJFUIMvALcr7nDZKAP5
   LV7pYaVkaT06CZVute837lnbfz287ge8QT+dYdYRF7ENe2NpTi0rz+oBh
   PmAGhHuR8dsy8SqqTan0uN4oz60EseICtcITvdt3yNDDMbiK8NA9QOJJK
   ykFFFKqi/Z2LnnyS7W6EEJAan0udlK2CXRZK6/M4XmZMoDuFTwlPN98cr
   yZgvWj23OBE59dC2deXSntXL4jKqhSaksDvnwkAWX/WeWormH5842oCMv
   No7wrXWQsLzdpCvvumBpaJWd3hspSJARDd82eg0RV+Jo2U0it9zYxTJIt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="422403765"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="422403765"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 03:56:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="820186565"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="820186565"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.208.136]) ([10.254.208.136])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 03:56:14 -0800
Message-ID: <cdf987df-87b5-0d03-7099-2d8569dcb8cc@linux.intel.com>
Date: Wed, 8 Mar 2023 19:56:12 +0800
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
Subject: Re: [PATCH v2 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>, linux-kselftest@vger.kernel.org
References: <3-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <3-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/8 8:35, Jason Gunthorpe wrote:
> The devices list was used as a simple way to avoid having per-group
> information. Now that this seems to be unavoidable, just commit to
> per-group information fully and remove the devices list from the HWPT.
> 
> The iommufd_group stores the currently assigned HWPT for the entire group
> and we can manage the per-device attach/detach with a list in the
> iommufd_group.
> 
> For destruction the flow is organized to make the following patches
> easier, the actual call to iommufd_object_destroy_user() is done at the
> top of the call chain without holding any locks. The HWPT to be destroyed
> is returned out from the locked region to make this possible. Later
> patches create locking that requires this.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
