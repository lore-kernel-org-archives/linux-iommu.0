Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF0B1C16
	for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 03:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689305834; x=1720841834;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YVaadt1wFIq28rSxWMk8wpdaqBs1DSHd1EywYDLLgmA=;
  b=RUykMHvZpgm9dbAgit6yKFx762UeY1fLry7IB3i6CddL0UxD6vMNY5sm
   32lFzdb76qMGTyV04pfx1cGuGUN4hz7sMXdPjuFIlvyEO/XegbvkZ6nJ4
   fjudQ0m4U0ZBuY4VhxImPoV8ACOkQtZvc3MWV7yP7WHp7uMovrEY+lYfn
   LLUC9wNY7bdfp3NJBlMycDxsK3UAJ0BEZcOzl9Oy/bSJCOHCr6n8QaBKk
   oS4T2EaAep0gLWwrkE9FgLqIXT6TOEyJDdWDgerNLY4GzVESTVMY4RJv0
   gmagkhbzDkz2kaklo4kkynInYDL6tWnROBKQ/ukAXGM64ZidAK6DVtgHZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="368933471"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="368933471"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 20:36:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="835874680"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="835874680"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.191.49]) ([10.252.191.49])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 20:36:49 -0700
Message-ID: <d89755de-bb7a-ee23-f308-2500aad81120@linux.intel.com>
Date: Fri, 14 Jul 2023 11:36:45 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
 Will Deacon <will@kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Yu, Fenghua" <fenghua.yu@intel.com>, "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v10 3/7] iommu/vt-d: Add domain_flush_pasid_iotlb()
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Joerg Roedel <joro@8bytes.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Robin Murphy <robin.murphy@arm.com>
References: <20230712163355.3177511-1-jacob.jun.pan@linux.intel.com>
 <20230712163355.3177511-4-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB5276EC6A22D3A3C9DE1C46678C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276EC6A22D3A3C9DE1C46678C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/7/13 15:52, Tian, Kevin wrote:
>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Sent: Thursday, July 13, 2023 12:34 AM
>> +static void domain_flush_pasid_iotlb(struct intel_iommu *iommu,
>> +				     struct dmar_domain *domain, u64 addr,
>> +				     unsigned long npages, bool ih)
>> +{
>> +	u16 did = domain_id_iommu(domain, iommu);
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&domain->lock, flags);
>> +	if (!list_empty(&domain->devices))
>> +		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr,
>> npages, ih);
>> +	spin_unlock_irqrestore(&domain->lock, flags);
> 
> btw I gave a comment before that the check of list_empty() changes
> the semantics instead of just creating a helper.
> 
> If it's the right thing to do please split it into a separate fix patch.

Perhaps move it into patch 6?

Best regards,
baolu
