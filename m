Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E0E257A
	for <iommu@lists.linux.dev>; Tue, 28 Jun 2022 10:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656413372; x=1687949372;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ozYJ2T8okmfO8Th4y6FGXh53KS7mtcLx/ds3l3ySpzI=;
  b=WavxV4n3h4Ns9F3p0BzezRxJuhXIvx/GC+aqZ74AT11+T9nZaAU5MCAM
   0kEY0cRZSiSqPXjMBzfnZQxwxeMG4Cv9vxrjMLXHekDJG5QmkWurFEVky
   SEZNsLcqOXpt4w6w5ATyN2pVE0/ycy38nrpfHEuMTQ4D6CPbdUrGQUQo7
   s/lGPFvX1k6vRfjS3OykhRKlXujBLPX9KaxZ5HycmS9zHxXe/+58deA8A
   dvGp7NbvXXblxD9GJtKXh3jWdijKJxFzErtO53GEUq3ra8bFkA6sEl9w0
   84mZ+Lpuqp/b37mZ2Vdfzsb3/WIsEcgS84YzNge+gpzQMSnpm6kEVdiyi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="262117280"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="262117280"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 03:49:31 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646863531"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64]) ([10.249.169.64])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 03:49:27 -0700
Message-ID: <2d516d37-960f-ed88-4395-6f5d58aa0009@linux.intel.com>
Date: Tue, 28 Jun 2022 18:49:25 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Pan, Jacob jun"
 <jacob.jun.pan@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v9 09/11] iommu: Prepare IOMMU domain for IOPF
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-10-baolu.lu@linux.intel.com>
 <BN9PR11MB527687EE83BC26F08A7D99908CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527687EE83BC26F08A7D99908CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID: <20220628104925.2_EtnEbxC2im4PHcObx_taKMaXX0c9agQbD6z25PwM4@z>

On 2022/6/28 16:29, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 21, 2022 10:44 PM
>> +/*
>> + * I/O page fault handler for SVA
>> + */
>> +enum iommu_page_response_code
>> +iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
>> +{
>> +	vm_fault_t ret;
>> +	struct mm_struct *mm;
>> +	struct vm_area_struct *vma;
>> +	unsigned int access_flags = 0;
>> +	struct iommu_domain *domain = data;
>> +	unsigned int fault_flags = FAULT_FLAG_REMOTE;
>> +	struct iommu_fault_page_request *prm = &fault->prm;
>> +	enum iommu_page_response_code status =
>> IOMMU_PAGE_RESP_INVALID;
>> +
>> +	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
>> +		return status;
>> +
>> +	mm = domain->mm;
> 
> What about directly passing domain->mm in as the fault data?
> 
> The entire logic here is only about mm instead of domain.

Yes. Updated.

Best regards,
baolu

