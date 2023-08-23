Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A8B10E9
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 01:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692753854; x=1724289854;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q0BAVsMWcTSrvSbD3t5HhjUKbzro+4+pJwfTYyBr0KQ=;
  b=Xky/s32HuutVOxcqL9WqxmwcI6+CP84LYrf/akDMJBVsPA48tHyb1Lhw
   /ToQC7hArfTKoSw+JBIGxLoNXOHzK/JzRG+Neqk5XIDQDN88y6xKb5jXt
   vNudTcBLC/ovCpjUZW4K60G2PdS0viTwMX/lcoATMZ3wcLLLB4L1sG5Qf
   XYkvNsKpB/UAfFdpVW5haZo/hAyfXN0d9ODHnbmXSbKJHRuQcDKKfYQgo
   CtzLZQbVNn9KbLZwp2GrORbaya8FQP4KmocK/sqF666Vu0bgEyhOf7RgR
   JepJxvUvlCE8RG9Nkw7ulBcyJLgW9U7nhoKVMPnnjxi017/zzOR+khmMZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="354367101"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="354367101"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 18:24:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="771542173"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="771542173"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.189.105]) ([10.252.189.105])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 18:24:07 -0700
Message-ID: <c0c89983-cba4-1cb0-1cb5-9aae217da318@linux.intel.com>
Date: Wed, 23 Aug 2023 09:24:03 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/11] iommu: Prepare to deliver page faults to user
 space
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20230817234047.195194-1-baolu.lu@linux.intel.com>
 <ZOOtjJLumarsBzwN@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZOOtjJLumarsBzwN@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/22 2:31, Jason Gunthorpe wrote:
> On Fri, Aug 18, 2023 at 07:40:36AM +0800, Lu Baolu wrote:
>> When a user-managed page table is attached to an IOMMU, it is necessary
>> to deliver IO page faults to user space so that they can be handled
>> appropriately. One use case for this is nested translation, which is
>> currently being discussed in the mailing list.
>>
>> I have posted a RFC series [1] that describes the implementation of
>> delivering page faults to user space through IOMMUFD. This series has
>> received several comments on the IOMMU refactoring, which I am trying to
>> address in this series.
> 
> Looking at this after all the patches are applied..

Thank you very much for reviewing my patches.

> 
> iommu_report_device_fault() and iommu_queue_iopf() should be put in
> the same file.

Yes. I will move both into io-pgfault.c. After that, iommu_queue_iopf()
becomes static.

> 
> iommu_queue_iopf() seems misnamed since it isn't queuing anything. It
> is delivering the fault to the domain.

Yeah, perhaps we can rename it to iommu_handle_iopf().

/**
  * iommu_handle_iopf - IO Page Fault handler
  * @fault: fault event
  * @dev: struct device.

> 
> It is weird that iommu_sva_domain_alloc is not in the sva file

Agreed. I will move it to iommu-sva.c.

> iopf_queue_work() wrappers a work queue, but it should trampoline
> through another function before invoking the driver's callback and not
> invoke it with a weird work_struct - decode the group and get back the
> domain. Every single handler will require the group and domain.

The work queue wrapper is duplicate. I will remove it and let the driver
to call queue_work() directly.

> 
> Same for domain->iopf_handler, the domain should be an argument if we
> are invoking the function on a domain.
> 
> Perhaps group->domain is a simple answer.

Yes. I will add domain in fault group and make it part of the parameters
of the callback.

Best regards,
baolu
