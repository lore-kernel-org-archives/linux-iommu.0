Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1E4273FE
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NqTzU4o9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697461612; x=1728997612;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/wMfPWUxc6xnmZ3/sCLFu2waW0a1/OqDzvcryID9nSQ=;
  b=NqTzU4o9har47qEt9rj8YztmOgTzktu1QjNN8wp6n6cyGyLUmwrS+Da/
   iBNwfIxg1g+sb9rccIlIEoYMJo2PnpLcXK42DIjW/X4ct18hIdEg8RCHF
   2tE6w5cwq1SR9sEl1SyNf9ebhk4hKFa5bn3oNwSIslWEx5NsnqHmF0Q0u
   IlHrH3Q9q0DXL5ECKIZ1xVDni5i6NliMyEZfcGrbDCQWUPgt/XesK3xm9
   NWYbFR0cv3ntRw6GxIQcIJLltfziTxzIxswKDJnikVcPiea0375haRN85
   DAgEhgi1Y6yr4MXstAduTVCKNOJWmMQybz5IR2wl3eL0l+bgtCRreDPHU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365778173"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="365778173"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 06:06:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="790792620"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="790792620"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.91]) ([10.249.171.91])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 06:06:47 -0700
Message-ID: <8cdc1a89-464a-8ca5-7059-2911ed9819d4@linux.intel.com>
Date: Mon, 16 Oct 2023 21:06:44 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Yi Liu <yi.l.liu@intel.com>, Yi Y Sun <yi.y.sun@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v3 19/19] iommu/intel: Access/Dirty bit support for SL
 domains
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, iommu@lists.linux.dev
References: <20230923012511.10379-1-joao.m.martins@oracle.com>
 <20230923012511.10379-20-joao.m.martins@oracle.com>
 <6859c129-7366-423c-9348-96c5fff0d3a0@linux.intel.com>
 <e7354a51-4b9e-411c-b6ff-b39a14061b9c@oracle.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <e7354a51-4b9e-411c-b6ff-b39a14061b9c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/10/16 19:39, Joao Martins wrote:
>>> +    /* Device IOTLB doesn't need to be flushed in caching mode. */
>>> +    if (!cap_caching_mode(iommu->cap))
>>> +        devtlb_invalidation_with_pasid(iommu, dev, pasid);
>> For the device IOTLB invalidation, need to follow what spec requires.
>>
>>    If (pasid is RID_PASID)
>>     - Global Device-TLB invalidation to affected functions
>>    Else
>>     - PASID-based Device-TLB invalidation (with S=1 and
>>       Addr[63:12]=0x7FFFFFFF_FFFFF) to affected functions
>>
> devtlb_invalidation_with_pasid() underneath does:
> 
> 	if (pasid == PASID_RID2PASID)
> 		qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - VTD_PAGE_SHIFT);
> 	else
> 		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid, qdep, 0, 64 - VTD_PAGE_SHIFT);
> 
> ... Which is what the spec suggests (IIUC).

Ah! I overlooked this. Sorry about it.

> Should I read your comment above as to drop the cap_caching_mode(iommu->cap) ?

No. Your code is fine.

Best regards,
baolu
