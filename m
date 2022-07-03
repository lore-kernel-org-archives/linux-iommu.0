Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B281FB3
	for <iommu@lists.linux.dev>; Sun,  3 Jul 2022 04:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656822920; x=1688358920;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pU3gfZt21o7N90tOYZMfEo8wFf2wBbFCrf4XK6NkYGQ=;
  b=UEud5efx18JiM3OGwEHYpklz2FDBC6nj9WnNCDPjAAYVbcxwN6soq9HR
   1Eejoc3JFQlM662LI3UxIRAwEljfavbPeYcKFke54231SQJ1uJuxUSPae
   zQeGsugL3Us5sc5glQ2VGixlNgQT7Hh9EIFuo/sZvzZ7Rr/mbiPmRT+04
   B2h5QF6gnu4kJmVA4Vw5ImDhJKvR7dkrB7fl53Qb7jGQGS3T1A/ALFoZz
   rTZgZQnZkZc9nDZenDJQlZMB1g3M28WlqLCj+XkuhGf32igGocrKV4K8C
   N+z3i1o6lm4QCHYPIyENVRA98wGPP1NyLbANv+LavyD1nMRP5S1MShkD2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="280456664"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="280456664"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 21:35:20 -0700
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="648966391"
Received: from sunqi-mobl1.ccr.corp.intel.com (HELO [10.249.173.69]) ([10.249.173.69])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 21:35:18 -0700
Message-ID: <49a1839a-c99d-258a-8f85-5a291c646038@linux.intel.com>
Date: Sun, 3 Jul 2022 12:35:17 +0800
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
Subject: Re: [PATCH v3 10/11] iommu/vt-d: Use device_domain_lock accurately
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
 <20220629074725.2331441-11-baolu.lu@linux.intel.com>
 <BN9PR11MB52763F336B2535BC89E2C7498CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52763F336B2535BC89E2C7498CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID: <20220703043517.DwCEWmgW1VNfKd4cZiEQ1ezl2X9woxKPrQWdDZRPKjA@z>

On 2022/7/1 16:15, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, June 29, 2022 3:47 PM
>>
>> +	spin_lock_irqsave(&device_domain_lock, flags);
>>   	list_for_each_entry(info, &domain->devices, link) {
>> -		if (!info->dev)
>> -			continue;
>> -
> 
> suppose you can replace all spin_lock_irqsave() with spin_lock()
> in patch5 instead of leaving some replacement to next patch.
> 

Make sense to me. Will update this.

Best regards,
baolu
