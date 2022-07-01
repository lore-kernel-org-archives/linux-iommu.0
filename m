Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE81110E9
	for <iommu@lists.linux.dev>; Fri,  1 Jul 2022 08:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656663149; x=1688199149;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uIBc20BRpWux/L4QNgzOIj1nZj/HX/ViDlZzamfMVRw=;
  b=EGL5Mk9G9WyJV+cuOM82r8PgPRKjWjjdhbkkaO7JKh1ZknEJbN1GP/a/
   vO7+0nrPke/y1unCrdLFLIavL/T5lQ295VHssu9ci/pAllu3S4OkFfele
   e2nAUQAXypvBx/HjUwJjgj7YIa5rOVG2BBBR/zdguZnOTRHh5dYX6TJiq
   Z4ZqXHRytBp1lGPm9egUtOQJg8xAu0wmWz+P8QC5zSbZeqOYaCshz12rq
   nF+EWmq7AUfHLuVa+638UngcPCxzgxwhlPtT/WjlA/cRHPVC/2akPAWyJ
   YAV+s4ZuqydBmSogE5Vv9KA6D3ue5BSpxP3yBG+ETU7ARgJv0mDjXO6jP
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="283319520"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="283319520"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 01:12:28 -0700
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="659344362"
Received: from wenjuhe-mobl1.ccr.corp.intel.com (HELO [10.249.171.195]) ([10.249.171.195])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 01:12:26 -0700
Message-ID: <50a05134-349a-0921-2a70-63f303bf86a4@linux.intel.com>
Date: Fri, 1 Jul 2022 16:12:23 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Pan, Jacob jun"
 <jacob.jun.pan@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/11] iommu/vt-d: Optimize the use of locks
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
 <BN9PR11MB527645CF20DA53BF9009A9118CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527645CF20DA53BF9009A9118CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID: <20220701081223.D5WhhP3NET-VV4ou2G9MbRMwJ3U5sMIA8cxA_oIfPfk@z>

On 2022/7/1 15:53, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, June 29, 2022 3:47 PM
>>
>> v3:
>>   - Split reduction of lock ranges from changing irqsave.
>>     https://lore.kernel.org/linux-
>> iommu/BN9PR11MB52760A3D7C6BF1AF9C9D34658CAA9@BN9PR11MB5276.
>> namprd11.prod.outlook.com/
>>   - Fully initialize the dev_info before adding it to the list.
>>     https://lore.kernel.org/linux-
>> iommu/BN9PR11MB52764D7CD86448C5E4EB46668CAA9@BN9PR11MB5276.
>> namprd11.prod.outlook.com/
>>   - Various code and comments refinement.
>>
> 
> This doesn't say why original patch2 was removed:
> 
> 	"iommu/vt-d: Remove for_each_device_domain()"
> 
> It took me a while to realize that it's already covered by your another
> patch fixing RID2PASID. 😊

My fault! I forgot to mention it in the change log. Sorry about it.

Best regards,
baolu
