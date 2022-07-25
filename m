Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6EE62D
	for <iommu@lists.linux.dev>; Mon, 25 Jul 2022 09:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658741953; x=1690277953;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FeSuo0JJdNSjMoYJ09VPheK/a4W0VdfiJn8DvjdV9n0=;
  b=JJ6jNQM6dt1Tvy6ap5ILbAKcqLwLdj9su1uyimaQZV9vLguncdRlNLZ6
   EWUA6ro5AnI99P0v98tN52odtiXKXuUafbxkMuywmm1W27M4X1+d/JGnS
   M71xqUoX6iMUHXhPxja4sIJBsvH8fsJQWKQEvk8rOlImi5F6KGKVCbFbl
   vhlsTrUosNGIFEUblxpgUMzmtB4Xcptl2PEUxXXRH3MwqSPovInu2hgAt
   yk37QA9t/tnUTLmaBl7EOJYcbW8GKCycwRT/MLYiJuVWrtjAEv6DWV4Bz
   WXVRRBfihufmhOki4e+Y0o0Kpg0QXai0dXrdofpgwaDvJDQv5Wn6z0VoL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="268049992"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="268049992"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 02:39:13 -0700
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="658112475"
Received: from liangk-mobl.ccr.corp.intel.com (HELO [10.255.30.67]) ([10.255.30.67])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 02:39:11 -0700
Message-ID: <c24bd222-9356-0564-414d-d54ca1e2b79b@linux.intel.com>
Date: Mon, 25 Jul 2022 17:39:11 +0800
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
 <8e970367-746e-0e74-ba39-e941fdbfdab7@linux.intel.com>
 <BN9PR11MB52765FEEC0ED0EAB5D691FA38C959@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52765FEEC0ED0EAB5D691FA38C959@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/7/25 15:40, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Sunday, July 24, 2022 11:00 AM
>>
>> Hi Kevin,
>>
>> On 2022/7/21 15:39, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Tuesday, July 19, 2022 7:53 AM
>>>>
>>>> @@ -88,7 +89,8 @@ extern struct list_head dmar_drhd_units;
>>>>    static inline bool dmar_rcu_check(void)
>>>>    {
>>>>    	return rwsem_is_locked(&dmar_global_lock) ||
>>>> -	       system_state == SYSTEM_BOOTING;
>>>> +	       system_state == SYSTEM_BOOTING ||
>>>> +	       (IS_ENABLED(CONFIG_INTEL_IOMMU)
>>>> && !intel_iommu_enabled);
>>>>    }
>>>
>>> intel_iommu_enabled is 0 if CONFIG_INTEL_IOMMU is not set.
>>>
>>> same for other similar checks.
>>
>> Sorry that I didn't get your point. If CONFIG_INTEL_IOMMU is not set,
>> IS_ENABLED(CONFIG_INTEL_IOMMU) is 0. The adding check has no effect.
>> Did
>> I miss anything?
>>
> 
> My point was that the check on CONFIG_INTEL_IOMMU is unnecessary.

Oh, if INTEL_IOMMU is not configured, the interrupt remapping could also
be supported, so we still need the rcu protection. We only relax the rcu
check when INTEL_IOMMU is configured, but not enabled yet.

Best regards,
baolu

