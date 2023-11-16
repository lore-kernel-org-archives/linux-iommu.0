Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1D3FBE2
	for <iommu@lists.linux.dev>; Thu, 16 Nov 2023 07:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JemptJSB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700119498; x=1731655498;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xzxCiQMFYJij7t6O0mSmHnDg/h78ww1UnMJV0w34NHk=;
  b=JemptJSBdpoLLGJ8tU4XTzclXK+gvu4JCctjDn+ACdWay/HITzK8tLLn
   y1N2fD88FUakbHYV+x8qmVgEbf6ForiwAlOpzjtH9+/zetHsCjZw0UwRi
   OC3hySqrBLSgBdW57JzA1V4hh2goGEIM3FUK1lDO9Em37AQ9p3UGdFzea
   ULqbN+vNnqdX2cXq0ZfO7FBLaSgpBaeM1GG5gQZ+OOcwZc4JjQQU5dV2J
   8kPDWWN7Cz+ShVcNdDPxeV6a+OYnrpzVbngFKuaviGy2Ob9yr/DQ1wNv+
   yUrKOXB10WvrWVqxn7RwbfBDpedZQ0JczJR3UIZOsBPXZn/YTRrd3edPx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="422124654"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="422124654"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 23:24:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="938757177"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="938757177"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.31.199]) ([10.255.31.199])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 23:24:54 -0800
Message-ID: <b825e828-6dff-4064-896e-df4de24aa6d6@linux.intel.com>
Date: Thu, 16 Nov 2023 15:24:51 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Abdul Halim, Mohd Syazwan" <mohd.syazwan.abdul.halim@intel.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Add MTL to quirk list to skip TE
 disabling
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20231116022324.30120-1-baolu.lu@linux.intel.com>
 <BN9PR11MB527667F09E2FAD729AE2BC2C8CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527667F09E2FAD729AE2BC2C8CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/11/16 11:27, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, November 16, 2023 10:23 AM
>>
>> From: "Abdul Halim, Mohd Syazwan"
>> <mohd.syazwan.abdul.halim@intel.com>
>>
>> The VT-d spec requires (10.4.4 Global Command Register, TE field) that:
>>
>> Hardware implementations supporting DMA draining must drain any in-flight
>> DMA read/write requests queued within the Root-Complex before
>> completing
>> the translation enable command and reflecting the status of the command
>> through the TES field in the Global Status register.
> 
> this talks about 'enable'...
> 
>>
>> Unfortunately, some integrated graphic devices fail to do so after some
>> kind of power state transition. As the result, the system might stuck in
>> iommu_disable_translation(), waiting for the completion of TE transition.
> 
> ...while this fixes 'disable'. wrong citation?

Right. It's confusing. I will change it to below.

"
...before switching address translation on or off and reflecting the
status of the command through the TES field in the Global Status
register.
"

> 
>> @@ -5080,7 +5080,7 @@ static void quirk_igfx_skip_te_disable(struct
>> pci_dev *dev)
>>   	ver = (dev->device >> 8) & 0xff;
>>   	if (ver != 0x45 && ver != 0x46 && ver != 0x4c &&
>>   	    ver != 0x4e && ver != 0x8a && ver != 0x98 &&
>> -	    ver != 0x9a && ver != 0xa7)
>> +	    ver != 0x9a && ver != 0xa7 && ver != 0x7d)
>>   		return;
>>
> 
> this fix alone is fine, but I found this quirk overall is not cleanly handled.
> 
> Basically it sets iommu_skip_te_disable as true, leading to early return
> in iommu_disable_translation():
> 
> 	if (iommu_skip_te_disable && iommu->drhd->gfx_dedicated &&
> 	   (cap_read_drain(iommu->cap) || cap_write_drain(iommu->cap)))
> 		return;
> 
> However the caller of iommu_disable_translation() is not aware of this
> quirk and continues as if the iommu is disabled. IMHO this is problematic
> w/o meeting the caller's assumption.
> 
> e.g. kdump and suspend. We may want to abort those paths early in case
> of such quirk...

I can see your point.

This fix is just to add a new device model to the established quirk
list. All devices (including the new one) in this quirk list have
undergone thorough verification. Therefor, I'd like to keep it as-is.

We can refine the quirk implementation in a separated patch series with
sufficient consideration and verification. Does this work for you?

Best regards,
baolu
