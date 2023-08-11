Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06512110E
	for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 02:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691721627; x=1723257627;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aqqOTgbaDxU7YQXJKJJ6d5riUgAVtDn0mUBNSHHE+e4=;
  b=KeO+xk8jy6thejBK3qhypXCEQt/AZ9G/fRcQJ1ZSZTsAWl6uS2hvf17V
   noGKFDvzv8/C7xVPPJnKfjVKEBoqyKRxhTKXy6tZq1n2B+8Xwk68yiilP
   i43Fz/J/tj/V18HD0s0amHTULOH7KvAhf+xSHUXmhU9Lx+mEyO+niIAGr
   1zPwH7ar9Hku4b0A/JUFokGZn7TEqxb127665l7CU2nqss5oCt8oFAQU8
   b8PegQRdcKDzKr1wLOK4oOAXD/44dZ80yB8HOwJepg/QuTNYKj123DHV2
   lMYFCsnmaGrzLs865JWe5JuvN+NxlvncRiwJ4xnfRA/kwgk3ipjgewabB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="370477444"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="370477444"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 19:40:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="1063148644"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="1063148644"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.65]) ([10.254.214.65])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 19:40:17 -0700
Message-ID: <b154c6d4-45db-0f4c-d704-fe1ab8e4d6a5@linux.intel.com>
Date: Fri, 11 Aug 2023 10:40:15 +0800
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
Subject: Re: [PATCH v2 12/12] iommu: Add helper to set iopf handler for domain
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-13-baolu.lu@linux.intel.com>
 <ZNU4Hio8oAHH8RLn@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZNU4Hio8oAHH8RLn@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/11 3:18, Jason Gunthorpe wrote:
> On Thu, Jul 27, 2023 at 01:48:37PM +0800, Lu Baolu wrote:
>> To avoid open code everywhere.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h | 11 ++++++++++-
>>   drivers/iommu/iommu.c | 20 ++++++++++++++++++--
>>   2 files changed, 28 insertions(+), 3 deletions(-)
> 
> Seems like overkill at this point..
> 
> Also, I think this is probably upside down.
> 
> We want to create the domains as fault enabled in the first place.
> 
> A fault enabled domain should never be attached to something that
> cannot support faults. It should also not support changing the fault
> handler while it exists.
> 
> Thus at the creation point would be the time to supply the fault handler
> as part of requesting faulting.
> 
> Taking an existing domain and making it faulting enabled is going to
> be really messy in all the corner cases.

Yes. Agreed.

> 
> My advice (and Robin will probably hate me), is to define a new op:
> 
> struct domain_alloc_paging_args {
>         struct fault_handler *fault_handler;
>         void *fault_data
> };
> 
> struct iommu_domain *domain_alloc_paging2(struct device *dev, struct
>         domain_alloc_paging_args *args)
> 
> The point would be to leave the majority of drivers using the
> simplified, core assisted, domain_alloc_paging() interface and they
> just don't have to touch any of this stuff at all.
> 
> Obviously if handler is given then the domain will be initialized as
> faulting.

Perhaps we also need an internal helper for iommu drivers to check the
iopf capability of the domain.

Best regards,
baolu
