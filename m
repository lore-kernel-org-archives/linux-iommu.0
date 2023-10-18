Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DB48F41
	for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 02:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MqFVRTH6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697596571; x=1729132571;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qAsqCySP1xPuDyaG6+jAnZQYD37eye7rcWsdeW4wC0k=;
  b=MqFVRTH6uIDnL/q4bSRcHmYShdra4vsaYW3pocM4Dpp7OginhyF3K3+C
   UuYXSY+/OASIL0a9Po+5Wu6Y0YktBE52VJ/OWe6b4T3OMOuE8wfek0lOO
   4RM1mgVzHjwZedDHlfPErGwGlw5dnT6kc8iYr3EoiC6U0GPqnqidXeqT3
   w6vZjGKUVk8wTqv65Vs9TQi5ujYwA1Qw3FrL+s8M6rkhECYEkrI3dOVkR
   h/AdD9iPYj+PO87ufNqTlV59YO6DH6ldpVwuuutYfyPS8gHjMyxULcG65
   1WhO/S8kJPZxKc3VCmZwJXOqOXjmwbj8goP73oKhwJuyDuEUa48vg5xtO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="450144276"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="450144276"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 19:36:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="4163967"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa001.jf.intel.com with ESMTP; 17 Oct 2023 19:34:59 -0700
Message-ID: <350f8544-8967-4f9e-bdcc-a464cdeadeea@linux.intel.com>
Date: Wed, 18 Oct 2023 10:32:25 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Nicolin Chen <nicolinc@nvidia.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
Subject: Re: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on
 kernel-managed domains
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-9-yi.l.liu@intel.com>
 <BN9PR11MB527658EAF017FF3576667EEA8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZSnkiKoCspmG1+/j@Asurada-Nvidia>
 <BN9PR11MB52763227866603ED7795AA068CD7A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231016115736.GP3952@nvidia.com>
 <BN9PR11MB5276FDC375685CE04A7AD93B8CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276FDC375685CE04A7AD93B8CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/23 4:52 PM, Tian, Kevin wrote:
>>> another problem is that intel_iommu_enforce_cache_coherency()
>>> doesn't update existing entries. It only sets a domain flag to affect
>>> future mappings. so it means the 2nd idev is also broken.
>> This is such a gap, intel driver should not permit that.
> yes. @Baolu, can you add a fix?

Sure thing!

Best regards,
baolu
