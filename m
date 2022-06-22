Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBFF137A
	for <iommu@lists.linux.dev>; Wed, 22 Jun 2022 11:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655899036; x=1687435036;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q2XnILATBKEg2okUGd1tyEzLN3TTBjUfdFRatA/QoRs=;
  b=iDqh7o5PmuOxDHvCLpe3QIYGad0bTy+9SGZ9sA46ieksLhdpFPKmBuCw
   aPLTz1mmmHN6ShCJt8kuNXgQmVMPjIt5bL3g4N7nZWdoTHfsCIaIYggid
   gp2md+8gcKL4kIdlCViBkQ6L3l8sipbpkFXxdmL3WR/rE3sOh3poOb9Ia
   FQM6TKrn7jvZyaAYsjcgaMphFZe5TOrK2nqnSI1uT5KPQ6jNXNqqx0iBA
   XRnsMrFSpRiC7yZ9sZFf0B+V62xiYpFvAzkwQ8GOoGILzNRl0H2joYuMe
   a8wQpiXgBa0h+cU8frCxVxVIA8XSd1dsXOH6WvUljeo3sJGeKjeNTZ/jn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="281471570"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="281471570"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 04:57:16 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="834076732"
Received: from xzhan99-mobl1.ccr.corp.intel.com (HELO [10.249.172.26]) ([10.249.172.26])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 04:57:14 -0700
Message-ID: <3ce651de-f375-176e-3435-735365dd3d8f@linux.intel.com>
Date: Wed, 22 Jun 2022 19:57:12 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iommu: Clean up release_device checks
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1655822151.git.robin.murphy@arm.com>
 <02671dbfad7a3343fc25a44222350efcb455fe3c.1655822151.git.robin.murphy@arm.com>
 <59002dbd-d72a-4f9c-7ad8-808ee8d2ff05@linux.intel.com>
 <bc4add1b-8b89-7989-5afb-df6b5338eb3d@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <bc4add1b-8b89-7989-5afb-df6b5338eb3d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID: <20220622115712.70h3OozzCt1doHXERuWctkdByG5Cg6YDIuw1niq4rmw@z>

On 2022/6/22 15:17, Robin Murphy wrote:
> On 2022-06-22 02:36, Baolu Lu wrote:
>> On 2022/6/21 23:14, Robin Murphy wrote:
>>> Since .release_device is now called through per-device ops, any call
>>> which gets as far as a driver definitely*is*  for that driver, for a
>>> device which has successfully passed .probe_device, so all the checks to
>>> that effect are now redundant and can be removed. In the same vein we
>>> can also skip freeing fwspecs which are now managed by core code.
>>
>> Does this depend on any other series? I didn't see iommu_fwspec_free()
>> called in the core code. Or I missed anything?
> 
> dev_iommu_free() cleans up param->fwspec directly (see b54240ad4943). 
> FWIW the plan is that iommu_fwspec_free() should eventually go away - of 
> the remaining uses after this, two are in fact similarly redundant 
> already, since there's also a dev_iommu_free() in the probe failure 
> path, and the other two should disappear in part 2 of fixing the bus 
> probing mess (wherein the of_xlate step gets pulled into 
> iommu_probe_device as well, and finally works correctly again).

Yes, it is. Thanks for the explanation.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
