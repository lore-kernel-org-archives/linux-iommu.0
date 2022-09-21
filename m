Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233B31876
	for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 06:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663740527; x=1695276527;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6EnqeurB9knvf7hjHnRGpP20ctHeBAKLCwcD/QCEq+s=;
  b=D7e9ejLfCikRisaEjp478SYoTFkyGhYAtNUVfNPdnMx4QEZ7587aCGNW
   8IsHpGjBf1YhNyOmKfxPfEL5AMJ0zzSbowGkMgMzvrIp0li3dc7wgj8lp
   b3dazkQDLkx7UP/j3OeskULsk5nRigLP+ZxORexvkrQyXHBGXeC9FH24+
   y+btHkTSiiQXboZYnrfO/4YpVHfn1bC+OlwsAywXx920KXVnM6upsGkxG
   pb2ZTKPF5/lYHgu42qLToyB/xx+NYnnMZ56BsQcVDGhLN6o7vgw55wkfI
   3G4eI7vJ6E0aYontOZR2fUToFQPEHr9MoRwFwSmpEi4DqvNiWmg4r+p0N
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="299898087"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="299898087"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 23:08:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="649914489"
Received: from jzha151-mobl1.ccr.corp.intel.com (HELO [10.254.208.217]) ([10.254.208.217])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 23:08:44 -0700
Message-ID: <de65f9ae-dd74-3f70-35c7-861832a1de7b@linux.intel.com>
Date: Wed, 21 Sep 2022 14:08:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Cc: baolu.lu@linux.intel.com, kevin.tian@intel.com, baolu.lu@intel.com,
 raghunathan.srinivasan@intel.com, iommu@lists.linux.dev, joro@8bytes.org,
 will@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/vt-d: Check correct capability for sagaw
 determination
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>
References: <20220916071212.2223869-1-yi.l.liu@intel.com>
 <20220916071212.2223869-2-yi.l.liu@intel.com>
 <a5f2141a-d819-20de-1e6c-b9e93323998a@linux.intel.com>
 <23d38de5-3aab-3fe7-2b17-cbf1ab8d6cab@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <23d38de5-3aab-3fe7-2b17-cbf1ab8d6cab@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2022/9/21 11:35, Yi Liu wrote:
> On 2022/9/21 10:44, Baolu Lu wrote:
>> On 9/16/22 3:12 PM, Yi Liu wrote:
>>> Check 5-level paging capability for 57 bits address width instead of
>>> checking 1GB large page capability.
>>>
>>> Fixes: 53fc7ad6edf2 ("iommu/vt-d: Correctly calculate sagaw value of 
>>> IOMMU")
>>> Cc:stable@vger.kernel.org
>>> Reported-by: Raghunathan Srinivasan<raghunathan.srinivasan@intel.com>
>>> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
>>
>> Queued for v6.0. Thank you very much!
>>
>> https://lore.kernel.org/linux-iommu/20220921024054.3570256-1-baolu.lu@linux.intel.com
> 
> grt. btw. how about below? not sure why it didn't show up in this 
> series. 🙁
> 
> https://lore.kernel.org/linux-iommu/BN9PR11MB5276F062B5C0C08F10EFB49F8C4C9@BN9PR11MB5276.namprd11.prod.outlook.com/

This is not a fix. I will queue it for v6.1-rc1 later.

Best regards,
baolu
