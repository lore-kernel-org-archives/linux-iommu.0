Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C491FA23
	for <iommu@lists.linux.dev>; Sat, 11 Feb 2023 03:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676087152; x=1707623152;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XBQR7irgij7HZnD6IBcFSJDQiO8ghGhLDVlW05U2Zw4=;
  b=ZkW6UU9Y2FGW0EVVnhqbHsrhzad2VUG5r2zdVcshvJ66Y6unFDVS6yCh
   d/hRLwP2ft9x5RsVu9zpRDTGCw3qU6xaTSbMXjMcOgZLAYrypefYmGGCk
   W6WeKPaXQn49iPt2ZBtSDjU+WmJiigIVAHaQlGvQQc+TS/I4ZDDdTs+e1
   dU0uPinNrg7DXRU1ecYLH5zyo8RK/lsyOSOi8ai5MgBWglx3nP6kEnwko
   9r5ciTCTfj2A1URWMMEA0Dvx5c6s9zTDO8i+ospdJjvwHVa9a7iw9HGBR
   w8bFKwIh6YwZhaTv1pnhwqYV6Nxv8d38FITC4RSI/1dele1SWZUYJUTpY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="329209885"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="329209885"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 19:45:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="756989518"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="756989518"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.168.175]) ([10.249.168.175])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 19:45:46 -0800
Message-ID: <0d24b2c6-1bd4-818c-ce71-ab3bd83ffe3f@linux.intel.com>
Date: Sat, 11 Feb 2023 11:45:44 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
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
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 2/6] iommu/vt-d: Implement hw_info for iommu capability
 query
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230209041642.9346-1-yi.l.liu@intel.com>
 <20230209041642.9346-3-yi.l.liu@intel.com>
 <BN9PR11MB52763CA91E0D9C0D26000E328CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52763CA91E0D9C0D26000E328CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/2/10 15:32, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, February 9, 2023 12:17 PM
>>
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>
>> To support nested translation in the userspace, it should check the
>> underlying hardware information for the capabilities.
> 
> remove this sentence. that belongs to next patch.
> 
>> +
>> +/**
>> + * struct iommu_device_info_vtd - Intel VT-d device info
>> + *
>> + * @flags: Must be set to 0
>> + * @__reserved: Must be 0
>> + * @cap_reg: Value of Intel VT-d capability register defined in chapter
>> + *	     11.4.2 of Intel VT-d spec.
>> + * @ecap_reg: Value of Intel VT-d capability register defined in chapter
>> + *	     11.4.3 of Intel VT-d spec.
> 
> let's be specific with section name e.g. "11.4.2 Capability Register" so if
> the chapter index is changed later people can still know where to look
> at.
> 
>> + *
>> + * Intel hardware iommu capability.
> 
> duplicated with the first line "Intel VT-d device info"

Above all agreed.

Best regards,
baolu

