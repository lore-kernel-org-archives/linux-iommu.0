Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA870185D
	for <iommu@lists.linux.dev>; Fri, 29 Sep 2023 03:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695958695; x=1727494695;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zbPrmOIIJUfnS7tuPZ/1BgvJEKiBHEh45wX3E42jh9M=;
  b=P/2C5SC/ste+xrCCS+tVesgn6u3n9uK5tdx2r1+FdPyzHBdcD3QFcDnx
   BDvIrhP76gjzYlRWednof44H8SyfZLC3Uum2EIjjEu6W3XvyMKqBgf2RH
   HmeQyWvRNc1+wP5QGff1TfxXRFoVOvOD2GV4mak+xx+4I0k9jTr/eCGb5
   7kj9YV3HZ3IUCodv/ps/JgV1XiY92n/YbvCOD2KU2iyoRXZ8bsjyBLf0o
   XTwCO9eRm6utaq5UNLaPkjXuSTSpEHj6VDXkCrNLD+0/ujzfoIBNPR/7r
   Z9p1CjR5SrYdlvf75fYSgQFQVruorYqaWsIih5Mt24B3pgmkXR5Zzm+bJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="361602590"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="361602590"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 20:38:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="893279930"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="893279930"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2023 20:36:53 -0700
Message-ID: <c987d035-a0be-cf00-fc5f-9f0ae781ef85@linux.intel.com>
Date: Fri, 29 Sep 2023 11:34:47 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
 chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com, peterx@redhat.com,
 jasowang@redhat.com, shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v2 4/6] iommufd/hw_pagetable: Support allocating nested
 parent domain
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, alex.williamson@redhat.com,
 jgg@nvidia.com, kevin.tian@intel.com, robin.murphy@arm.com
References: <20230928071528.26258-1-yi.l.liu@intel.com>
 <20230928071528.26258-5-yi.l.liu@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230928071528.26258-5-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/23 3:15 PM, Yi Liu wrote:
> This extends IOMMU_HWPT_ALLOC to allocate domains used as parent (stage-2)
> in nested translation.
> 
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommufd/hw_pagetable.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
