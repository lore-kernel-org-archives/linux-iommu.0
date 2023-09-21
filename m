Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B38F800
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 01:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695260085; x=1726796085;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+bidcrUQSX3/sahN7fs73gHIxO3mCixzrWi3NOAA3ag=;
  b=egw7qUb3YvUj5D3Y95HXJNdEfBMsy2Db09Yus/AHqBenXbnN0x/B+N2+
   qL9YvSpdIbfo7K/1uRnqdeET6DeL0ujgEtDaBkovJNpv/9/wAb9fegBVu
   tu8XgSLO+sE/P9PKGvGs+ZASCIpXymq6k9FJBHNn9gIsZCBkponbRGBs8
   V4GnELuKpfyGibhlZeUyop1yZ98UccN4G68VmG8a4CguakxAoHnDqL6eq
   SR9W8pqev8clKlOfMczWXMNL2zaKNBHnuldBVCbeRSemmiOOumvIKbAxR
   vnQwHQtZtC/KpRrhXdrBMjAYcugwefCWZNDseAMPjq6ca7hEZrAgigvXY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359773161"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="359773161"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 18:34:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723540733"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="723540733"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga006.jf.intel.com with ESMTP; 20 Sep 2023 18:34:35 -0700
Message-ID: <ea19494d-8de6-e907-a735-7f2e5f98f9fb@linux.intel.com>
Date: Thu, 21 Sep 2023 09:31:27 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: baolu.lu@linux.intel.com, "joro@8bytes.org" <joro@8bytes.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
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
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "Martins, Joao" <joao.m.martins@oracle.com>
Subject: Re: [PATCH 6/6] iommu/vt-d: Add domain_alloc_user op
Content-Language: en-US
To: "Liu, Yi L" <yi.l.liu@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20230919092523.39286-1-yi.l.liu@intel.com>
 <20230919092523.39286-7-yi.l.liu@intel.com>
 <7aa8fd9e-e43d-db68-bdb6-fe4f891255ca@linux.intel.com>
 <20230920130522.GV13733@nvidia.com>
 <DS0PR11MB7529609BC4574A17ECE469A2C3F9A@DS0PR11MB7529.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <DS0PR11MB7529609BC4574A17ECE469A2C3F9A@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/23 9:10 PM, Liu, Yi L wrote:
>>>> +
>>>> +	domain = iommu_domain_alloc(dev->bus);
>>> No need to bounce between core and driver. Just,
>>>
>>> 	intel_iommu_domain_alloc(IOMMU_DOMAIN_UNMANAGED);
>>>
>>> and fully initialize it before return.
>> If you are going to do that then intel_iommu_domain_alloc() should
>> fully initialize the domain, not here.
> I've also considered what Baolu described, but it requires to do some
> extra initialization which is duplicated with iommu_domain_alloc().
> So I chose this simple way.

Okay, got you.

Once Jason's paging domain and Robin's bus->iommu_ops retirement series
have landed, the VT-d driver will need some refactoring. Therefore, I'm
fine with you using a simpler approach here. I'll refactor everything
later.

Best regards,
baolu
