Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAD062B
	for <iommu@lists.linux.dev>; Wed,  8 Mar 2023 03:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678245551; x=1709781551;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HnUh6zuWuK6/JGibCICoiHRkUWu1XWxkLwlxoYZmjKs=;
  b=U37iBepvz6Ipvz3YcTLnbXiMYinJ3XJLXqU+XUqo0jdV69We7+XM4RLn
   AAYIskgsFPOdppD6RuT4lwDTEvSGO1j8T6WIBRxDWQUySR8Rr+QoKy83J
   wT3UQ4Ch+EGcVCd5N/z9skAHK8HBDg87OSw8wjtwpAXxrCKNhojq83yMe
   QxSvZ0FNz205jsfISlJSXLMbAXKcinsS+XbVs1mxUeuOvM8z70MQMVKz6
   mrb0OGfP9a4Z9hv7ur7MHQ3XhGzCcoxgyg5hjXc2eIB0xBPxKMzJIsOPH
   YNmXGma64wL7rYI3pOhJozrWDDGiVmOG1BASZ7fTQk5kGGcFgfFD0m+2/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="315700886"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="315700886"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 19:19:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="1006145193"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="1006145193"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga005.fm.intel.com with ESMTP; 07 Mar 2023 19:19:09 -0800
Message-ID: <3469063c-7ed4-3fda-0280-2cc6b4e6fd98@linux.intel.com>
Date: Wed, 8 Mar 2023 11:18:11 +0800
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
Subject: Re: [PATCH v2 02/17] iommufd: Add iommufd_group
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>, linux-kselftest@vger.kernel.org
References: <2-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <2-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/8/23 8:35 AM, Jason Gunthorpe wrote:
> When the hwpt to device attachment is fairly static we could get
> away with the simple approach of keeping track of the groups via a
> device list. But with replace this is infeasible.
> 
> Add an automatically managed struct that is 1:1 with the iommu_group
> per-ictx so we can store the necessary tracking information there.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

The iommufd_get_group() helper looks long. I went through it carefully
and didn't find any problems. However, is it possible to add a mutex in
ictx to protect the group array? Can it be simpler?

either way,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
