Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC26D1C26
	for <iommu@lists.linux.dev>; Fri, 26 May 2023 04:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685075347; x=1716611347;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RRRs5dUTNUuOWDXssuoYxDV92ZsLMV24IIKkiNPRRBE=;
  b=bq9lVwSC7b9giHjFl2wgw2mAJBhfOLmLeFb4mcjUyxE8xeF2GvNfcJIm
   YtkoyJJOc+YgPg9fO/Zv+mPmLb6oOXMz1nIzJdpX1bZLhWGh75ehR+LFi
   vli1vaamkXmBvlRKLqOdJDlB276ickJ3iMGb196K5xSRCxUHd1vHSYbLA
   tc8nTLErNQdz8qQl6Wo8+sdRxKta+a4TMnOrKUDzNgpPlCIGa6NfPFacJ
   zUlhR1iYEya6S83PyekpIiLqgpNbYE9k1Sk4B0nZCie5VgP/2kJpqVGTd
   82uioif7aBsq78EpkxWzM2qBYN6dVFJ0lq3NSzIt9nmrfipDixDt3JtXD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="343610666"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="343610666"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 21:29:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="655500202"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="655500202"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga003.jf.intel.com with ESMTP; 25 May 2023 21:29:01 -0700
Message-ID: <9ac5d151-b3c6-93c4-2482-0eb04e076195@linux.intel.com>
Date: Fri, 26 May 2023 12:28:15 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, "cohuck@redhat.com" <cohuck@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v3 10/10] iommu/vt-d: Disallow nesting on domains with
 read-only mappings
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <20230511145110.27707-11-yi.l.liu@intel.com>
 <BN9PR11MB527673E35A8C123648997A238C419@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527673E35A8C123648997A238C419@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/24/23 3:44 PM, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, May 11, 2023 10:51 PM
>>
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>
>> When remapping hardware is configured by system software in scalable
>> mode
>> as Nested (PGTT=011b) and with PWSNP field Set in the PASID-table-entry,
>> it may Set Accessed bit and Dirty bit (and Extended Access bit if enabled)
>> in first-stage page-table entries even when second-stage mappings indicate
>> that corresponding first-stage page-table is Read-Only.
>>
>> As the result, contents of pages designated by VMM as Read-Only can be
>> modified by IOMMU via PML5E (PML4E for 4-level tables) access as part of
>> address translation process due to DMAs issued by Guest.
>>
>> Disallow the nested translation when there are read-only pages in the
>> corresponding second-stage mappings. And, no read-only pages are allowed
>> to be configured in the second-stage table of a nested translation.
>> For the latter, an alternative is to disallow read-only mappings in
>> any stage-2 domain as long as it's ever been used as a parent. In this
>> way, we can simply replace the user counter with a flag.
>>
>> In concept if the user understands this errata and does expect to
>> enable nested translation it should never install any RO mapping
>> in stage-2 in the entire VM life cycle."
> 
> IMHO the alternative is reasonable and simpler. If the user decides to
> enable nesting it should keep the nesting-friendly configuration static
> since whether nesting is enabled on a device is according to viommu
> configuration (i.e. whether the guest attaches the device to identity
> domain or non-identity domain) and it's not good to break the nesting
> setup just because the host inadvertently adds a RO mapping to s2 in
> the middle between guest is detached/put back to identity domain
> and then re-attach to an unmanaged domain.

Fair enough.

>>
>> +	if (!(prot & DMA_PTE_WRITE) && !domain->read_only_mapped) {
>> +		spin_lock_irqsave(&domain->lock, flags);
>> +		if (domain->nested_users > 0) {
>> +			spin_unlock_irqrestore(&domain->lock, flags);
>> +			return -EINVAL;
>> +		}
>> +
> 
> this is worth a one-off warning. Same in the other path.

Sure.

Best regards,
baolu
