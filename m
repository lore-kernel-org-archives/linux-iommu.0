Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AFE371
	for <iommu@lists.linux.dev>; Sat, 18 Mar 2023 08:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679128490; x=1710664490;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cF6OACTGETpdCpNE9ogXPkHWW2QM4YLy7vWuh9G3Jv0=;
  b=R+nAQOk2jLT9gccjhN7yg2x7iD5z50sKuBS5sK46DlWwuGKjuB9RGXS2
   eioh5QPnzDar1D/DbiBt6u7yCF8yqC0EUwTbsrlG6nZtgN9B5ZLsrBwJr
   gar0CYLuB2sCNjovo7vj7UfCoOrQx9MjKz4qfhTFstbRdQ0xhrOoPvPn1
   m4NZnApY0FbnCMOu7sYrEMh17NP5qnfDRUaFHew084+Zb5RE2tQgMYokF
   Mjm1cwKafsXYkTFECBZv0GoNn5GRDpCLbCqICITuSgasBonhNXoxRtQmm
   bGorkQ4IL+sFMCc9TxAxgk+It4RmekbVXWPiwJLzbDkyKRY8RLNAMGtfG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="424693795"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="424693795"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 01:34:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="769637754"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="769637754"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.252]) ([10.254.210.252])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 01:34:45 -0700
Message-ID: <89ae04a9-bba3-c93e-c8ec-92e8afaf6316@linux.intel.com>
Date: Sat, 18 Mar 2023 16:34:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
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
Subject: Re: [PATCH 02/12] iommu: Add nested domain support
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-3-yi.l.liu@intel.com>
 <BN9PR11MB5276265987486AC84D2039818CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276265987486AC84D2039818CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/17 18:25, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, March 9, 2023 4:09 PM
>>
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>
>> Introduce a new domain type for a user space I/O address, which is nested
> 
> 'a ... address'? let's call it 'user I/O page table'.
> 

Okay, sure.

Best regards,
baolu
