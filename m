Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D4010E6
	for <iommu@lists.linux.dev>; Fri,  3 Mar 2023 02:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677811773; x=1709347773;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ESvh58jnHz4IXPBjDt02WyaBLz5hm1ckjLfmgT8Pgno=;
  b=aMoXlfZjeVMlE0zQ1UD2yb8fbT9aphtIF98eHhdMUtuyMbHCA4T2syrv
   FrCl5UTxKpQr1eGNf7Wnp4yZPvVcB+RMyJG+AuenzQBnU7lCNYBiULQaH
   ebKpooaKbJh/CJYetVARXuGQfIZSo5iWvL7fz5HAlpuIKL553wNFelDOV
   VoolpQKbh2UOmxKJnF7eHTor5sgnHFGSAwPV2Cnw5hwmY5Dk1WAXXW288
   hsS69QQgLS1D/xV9mHPWCf+sCr6jiKk+XTKVaFdPw1bLu5iG7tv3FkrUA
   ELPU8mC9b8QWsKi27ziVxX8hycvWSkNJj91yfnSngs7ybnBQPxF4uXa4A
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="399743486"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="399743486"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 18:49:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="818311002"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="818311002"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 02 Mar 2023 18:49:29 -0800
Message-ID: <2c9115d0-f251-c284-63d6-73714edc96b4@linux.intel.com>
Date: Fri, 3 Mar 2023 10:48:36 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Yu, Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH 1/4] iommu/vt-d: Implement set device pasid op for default
 domain
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "vkoul@kernel.org" <vkoul@kernel.org>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
 <fad7f28f-b4e8-c1c3-4ca4-a48c5c6d7f4a@linux.intel.com>
 <BN9PR11MB52762957011E60E935E82CC88CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52762957011E60E935E82CC88CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/3/23 10:36 AM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Thursday, March 2, 2023 10:07 PM
>>> +
>>> +	if (!sm_supported(iommu) || !info)
>>
>> @info has been referenced. !info check makes no sense.
>>
>> Add pasid_supported(iommu).
>>
>> Do you need to check whether the domain is compatible for this rid
>> pasid?
> 
> what kind of compatibility is concerned here? In concept a pasid
> can be attached to any domain if it has been successfully attached
> to rid. Probably we can add a check here that RID2PASID must
> point to the domain already.

"...if it has been successfully attached to rid..."

We should not have this assumption in iommu driver's callback. The iommu
driver has no (and should not have) knowledge about the history of any
domain.

> 
>>
>>> +		return -ENODEV;
>>> +
>>> +	if (WARN_ON(pasid == PASID_RID2PASID))
>>> +		return -EINVAL;
>>
>> Add a call to domain_attach_iommu() here to get a refcount of the domain
>> ID. And call domain_detach_iommu() in intel_iommu_remove_dev_pasid().
>>
> 
> Is it necessary? iommu core doesn't allow taking ownership
> if !xa_empty(&group->pasid_array) so if this pasid attach succeeds
> this device cannot be attached to another domain before pasid
> detach is done on the current domain.

It's not about the pasid, but the domain id.

This domain's id will be set to a field of the device's pasid entry. It
must get a refcount of that domain id to avoid use after free.

Best regards,
baolu
