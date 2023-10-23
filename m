Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED0F7480
	for <iommu@lists.linux.dev>; Mon, 23 Oct 2023 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqmZ7CqK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698063498; x=1729599498;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ER/XKUMDi6yIOgyLhD9h2AQXUmEiCID1DQSal1iAvEQ=;
  b=lqmZ7CqKtbCAYV+756KxQYCBQkN45b8CDC2Q7mVzVwCFXZ0JArJi+iyq
   B4Ogqw/mJpKefcBO1u8yGn/yt9Dv/82TQeD0nqNGbWKTCG5ZmQ/o+tbO9
   O7JpcrpZl5oxf1l3al9Zcp92pRwYjHLgp8aU+C2xj9oHhp5r3UXE9A8LO
   OfogWhbq2Eh+mEAmYkDxUvcXkYZ0Q3Pn7p9Qv3kSTr7hL16cmJWcV0/Y5
   gVt5W+DrBQYOtEMsvrj6k88ILtpOTCckYzJzgD2FLtz92Od6MoVilqy8G
   l6d2qUwMulrUJWUqS+N5yYeA0rFN9Wv6KgwxGoUPKQeEf50LFwZkzaBTM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="473040365"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="473040365"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 05:18:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="734649672"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="734649672"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.211.100]) ([10.254.211.100])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 05:18:10 -0700
Message-ID: <f041d424-ade2-4959-a677-01e3d7dd699b@linux.intel.com>
Date: Mon, 23 Oct 2023 20:18:08 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "Martins, Joao" <joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>
Subject: Re: [PATCH v6 8/8] iommu/vt-d: Disallow read-only mappings to nest
 parent domain
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20231020093246.17015-1-yi.l.liu@intel.com>
 <20231020093246.17015-9-yi.l.liu@intel.com>
 <23133231-c6d7-469e-8f55-2e7667acb097@linux.intel.com>
 <DS0PR11MB752977275A0791296C115FE6C3D8A@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <DS0PR11MB752977275A0791296C115FE6C3D8A@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/10/23 19:15, Liu, Yi L wrote:
>> I would also prefer to introduce is_nested_parent_domain to the user
>> domain allocation patch (patch 7/8). This field should be checked when
>> allocating a nested user domain.
> A ctually, no need. This should be a common check, so iommufd core already
> has the check. So the parent should be a nest parent domain, otherwise already
> returned in iommufd.
> 
> +	if (!parent->nest_parent)
> +		return ERR_PTR(-EINVAL);

I know this will not cause errors in the code. But since you are
introducing is_parent property in the vt-d driver. The integrity of the
property should be ensured. In this way, it will make the code more
readable and maintainable.

Best regards,
baolu
