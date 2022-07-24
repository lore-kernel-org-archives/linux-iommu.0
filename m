Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA237E
	for <iommu@lists.linux.dev>; Sun, 24 Jul 2022 02:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658631579; x=1690167579;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tu+rlCbzZUYmb39RdyQ4XYT1JbhjzZ6xE7dWDudpVkc=;
  b=diGD3ujnvdfVeyG2huAL8mqH2w/zGXUTtiOWo8lR+ncDf19Ft76s2re8
   zE9sAHKvBUlBgpKThh8vHyRwvgIbHvdyouyB2RtPR54PgXTY4BsNdCycr
   /x5COBRfM2IB3nydnDj12hrUDcJlbM2X76SERHnrWVIgAbhPoBKns348/
   inWFS23tuomQkUyWF+zM0ugToWoyzCNLRqAZwS3A8N6HS3rlyfIZlAuqN
   tHEFWCDnlKzT3N5IkC5YjmohbatiM7u55Xpxyk+lg9VF2rhYjg5movEPN
   EwOFIXoBn59tPK8KLu7pTXZoSd2jebWtwfd/iQGm330lD0QU9Q3cPeDFr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="373813603"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="373813603"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 19:59:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="657692682"
Received: from zjiang1-mobl.ccr.corp.intel.com (HELO [10.249.170.155]) ([10.249.170.155])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 19:59:36 -0700
Message-ID: <8e970367-746e-0e74-ba39-e941fdbfdab7@linux.intel.com>
Date: Sun, 24 Jul 2022 10:59:34 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix possible recursive locking in
 intel_iommu_init()
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20220718235325.3952426-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276287E75395A59865812978C919@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276287E75395A59865812978C919@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kevin,

On 2022/7/21 15:39, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, July 19, 2022 7:53 AM
>>
>> @@ -88,7 +89,8 @@ extern struct list_head dmar_drhd_units;
>>   static inline bool dmar_rcu_check(void)
>>   {
>>   	return rwsem_is_locked(&dmar_global_lock) ||
>> -	       system_state == SYSTEM_BOOTING;
>> +	       system_state == SYSTEM_BOOTING ||
>> +	       (IS_ENABLED(CONFIG_INTEL_IOMMU)
>> && !intel_iommu_enabled);
>>   }
> 
> intel_iommu_enabled is 0 if CONFIG_INTEL_IOMMU is not set.
> 
> same for other similar checks.

Sorry that I didn't get your point. If CONFIG_INTEL_IOMMU is not set,
IS_ENABLED(CONFIG_INTEL_IOMMU) is 0. The adding check has no effect. Did
I miss anything?

Best regards,
baolu

