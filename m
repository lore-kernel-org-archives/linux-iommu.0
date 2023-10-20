Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ECE199D3
	for <iommu@lists.linux.dev>; Fri, 20 Oct 2023 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BedBb2U2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697804419; x=1729340419;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TtO2xAOjFTqqWN9AGE5WjjbobtfUiNkYAkAsqkDI+Zg=;
  b=BedBb2U2qpvOHAJj4c6CqaMsqCxC0k/ov7SRsXOGsgh/FHmXNd1oSwfi
   8sUe6A3O1k0krrGPQfD9D84NoQ9zAJkXaop+F9O1QIFeY03l/fUP0R/fc
   7ew7dgvjw8Y2REFrmEaEEWLouKYjDZWVCvK1uWjHs898rdaC2XQ1pr+/a
   1LuCYNtnB2GJChOWy7FNyJrGgSoAMUBNhcq7f4N6Qygh46b6Gldyum+Hf
   aouq6DHVjh1PTs96aNY0elf5dZtGF2dG0SAJvPG2ldSNZRnfjoO0oKKpZ
   MxSW90qipPtnEfyCToANwrE78OcUPlkdWoENSMEcI14u0jjvLDvEXiYbD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="472708028"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="472708028"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 05:20:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="707213299"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="707213299"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.211.102]) ([10.254.211.102])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 05:20:03 -0700
Message-ID: <49f095e8-b27a-4fba-9fd4-152271fb4a14@linux.intel.com>
Date: Fri, 20 Oct 2023 20:20:00 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
 chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com, peterx@redhat.com,
 jasowang@redhat.com, shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhenzhong.duan@intel.com, joao.m.martins@oracle.com, xin.zeng@intel.com
Subject: Re: [PATCH v6 5/8] iommu/vt-d: Make domain attach helpers to be
 extern
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, alex.williamson@redhat.com,
 jgg@nvidia.com, kevin.tian@intel.com, robin.murphy@arm.com
References: <20231020093246.17015-1-yi.l.liu@intel.com>
 <20231020093246.17015-6-yi.l.liu@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231020093246.17015-6-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/10/20 17:32, Yi Liu wrote:
> This makes the helpers visible to nested.c.
> 
> Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 15 ++++++---------
>   drivers/iommu/intel/iommu.h |  7 +++++++
>   2 files changed, 13 insertions(+), 9 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

