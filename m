Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFE2803
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 02:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694573243; x=1726109243;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4cbEGO6IVZ670Bn0msjrzLBr0sS4CiHbeKPk7wJW3wY=;
  b=B8/hKu+fuP0sTPyQzjMjZoryK8xi5fguBVWZYak5G5VuHAi82DkuMfVD
   VliRIIbN8eGl51BthJvbYzOT0YBphemO0WAJ+ItZnLKjb+HoIFLo75ozj
   K84nceHQW1+8NSasdtioSakpQyN2yb/MfBcvYGhn3ACJEhPx4Lz0WEvYE
   24dgP8eUP4vDrE/L6BJQEGVhZblx5gDHapR2Zs8DHx4SBwwJEspNuqeMb
   QhlkqUgYhvWPelXltzEd5TmTcm5Z0DMtpKM5FCkvtUHJwC8MkL9aygdnI
   JqY9JIK+Tw/sEOwa8iOztk7myTnL58IO6ADFT8zSjP2ozWGV18sYZbZmR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="378460621"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="378460621"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 19:47:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="990735142"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="990735142"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 12 Sep 2023 19:47:18 -0700
Message-ID: <6e550123-4307-571c-d70e-d66ac0bf66ad@linux.intel.com>
Date: Wed, 13 Sep 2023 10:44:19 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 09/10] iommu: Make iommu_queue_iopf() more generic
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20230825023026.132919-1-baolu.lu@linux.intel.com>
 <20230825023026.132919-10-baolu.lu@linux.intel.com>
 <BN9PR11MB52762A33BC9F41AB424915688CE3A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <cbfbe969-1a92-52bf-f00c-3fb89feefd66@linux.intel.com>
 <BN9PR11MB52768891BC89107AD291E45C8CE6A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <67aa00ae-01e6-0dd8-499f-279cb6df3ddd@linux.intel.com>
 <BN9PR11MB527610423B186F1C5E734A4B8CE4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <068e3e43-a5c9-596b-3d39-782b7893dbcc@linux.intel.com>
 <BN9PR11MB52768F9AEBC4BF39300E44478CF2A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <926da2a0-6b3e-cb24-23d1-1d9bce93b997@linux.intel.com>
 <BN9PR11MB5276CF3330478AFC4FD3C2768CF0A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276CF3330478AFC4FD3C2768CF0A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/13/23 10:25 AM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Monday, September 11, 2023 8:27 PM
>>
>>>
>>> Out of curiosity. Is it a valid configuration which has
>> REQUEST_PASID_VALID
>>> set but RESP_PASID_VALID cleared? I'm unclear why another response
>>> flag is required beyond what the request flag has told...
>>
>> This seems to have uncovered a bug in VT-d driver.
>>
>> The PCIe spec (Section 10.4.2.2) states:
>>
>> "
>> If a Page Request has a PASID, the corresponding PRG Response Message
>> may optionally contain one as well.
>>
>> If the PRG Response PASID Required bit is Clear, PRG Response Messages
>> do not have a PASID. If the PRG Response PASID Required bit is Set, PRG
>> Response Messages have a PASID if the Page Request also had one. The
>> Function is permitted to use the PASID value from the prefix in
>> conjunction with the PRG Index to match requests and responses.
>> "
>>
>> The "PRG Response PASID Required bit" is a read-only field in the PCI
>> page request status register. It is represented by
>> "pdev->pasid_required".
>>
>> So below code in VT-d driver is not correct:
>>
>> 542 static int intel_svm_prq_report(struct intel_iommu *iommu, struct
>> device *dev,
>> 543                                 struct page_req_dsc *desc)
>> 544 {
>>
>> [...]
>>
>> 556
>> 557         if (desc->lpig)
>> 558                 event.fault.prm.flags |=
>> IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
>> 559         if (desc->pasid_present) {
>> 560                 event.fault.prm.flags |=
>> IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
>> 561                 event.fault.prm.flags |=
>> IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
>> 562         }
>> [...]
>>
>> The right logic should be
>>
>> 	if (pdev->pasid_required)
>> 		event.fault.prm.flags |=
>> IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
>>
>> Thoughts?
>>
> 
> yes, it's the right fix. We haven't seen any bug report probably because
> all SVM-capable devices have pasid_required set? 😊

More precisely, the idxd devices have pasid_required set. :-)

Anyway, I will post a formal fix for this.

Best regards,
baolu
