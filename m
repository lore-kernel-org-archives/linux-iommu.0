Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C517E6
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 01:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678411139; x=1709947139;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y1JTmxABvb0PyFMB3d9kKRqC+XS4w9esUbuFu4rqTFs=;
  b=UlF8GUzVD3r4qAKPe/FU0QW3in9fxev1HV9U0q/wYXjXrhYf7pjvuyRK
   eAvYpPRMBWVQK1ZF1/7lNKqNvm7grpKxDpcR0GT1nbf2pzhPKIWCjKkAb
   xPHfmbvBcg03XOpn8asrmQLmV8G5l6xwtvH5uS2M+V84Qrr1fQ5CMd9Fn
   GAn+5L9xE4ZPxPZb43LDqxGnGZPK2eLvskoSlHCGgGtjik+mdDZcIjpK+
   Au60rbQQxLizQrm5pDYxTnUpk1eYzue4JAoWFkD5+Ypw1ntQn6UXGMSMT
   6CXFpTZLFmHDMU5+HDXLiq8FmdanfYqb53xhvf4eJLHVlvhbIsxWvYHer
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="364266624"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="364266624"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 17:18:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="787820716"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="787820716"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2023 17:18:54 -0800
Message-ID: <1e204316-835d-2824-0360-499d4781bd3f@linux.intel.com>
Date: Fri, 10 Mar 2023 09:17:54 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
 chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com, peterx@redhat.com,
 jasowang@redhat.com, shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 03/12] iommufd/hw_pagetable: Use domain_alloc_user op for
 domain allocation
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, alex.williamson@redhat.com,
 jgg@nvidia.com, kevin.tian@intel.com, robin.murphy@arm.com
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-4-yi.l.liu@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230309080910.607396-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/9/23 4:09 PM, Yi Liu wrote:
> This converts IOMMUFD to use iommu_domain_alloc_user() for iommu_domain
> creation.

Nit: I don't think this is a "convert" because iommu_domain_alloc() is
still there.

> 
> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> Co-developed-by: Nicolin Chen<nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>

Anyway, I agree with the idea,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

