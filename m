Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C7D4503A
	for <iommu@lists.linux.dev>; Sun, 19 May 2024 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716127431; cv=none; b=aJ38difLKE1w6dZv4xaNeWMMmvZ8hleEPBfQoD2EiM+U1lHq59D8oZ5fKyovi6qSPBH2EwFugy4gHDNlw/NqMklH0YVGlKCH/U32D1xAr7/hk2p1OYFa0fIXpUpfE9yvVAenKiF7o9qZcyO11L8W22VuGkF2G2zeeub5dIDgSAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716127431; c=relaxed/simple;
	bh=ARmOeQiHP4d/q5mgCSxMdhI46iVoSC/5ft3lev2E/AE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Kmv18lc9b4CU/IwibEx//KMG80CqNakD47+03y53/aNe30s5giMvFGOzWJr2REF/saRImK96acK9642i/E6cpnH+8qT8J38uutUYBvCTaOIljUhp+cuKnonC10K3IXOvCSe0xK0N3WqAllNvn48x5xGA0PUHhNMQ5W2PD6bnZOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EWpTMMZZ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EWpTMMZZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716127430; x=1747663430;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ARmOeQiHP4d/q5mgCSxMdhI46iVoSC/5ft3lev2E/AE=;
  b=EWpTMMZZhfJH/b+p4xNoCOP+iWov1yBV+suthkdQkiLk9W8D1XfH+bG4
   T14ZkxoIa8yjAbxdENIoRDj9wuG1IRyw9Pkphd71Xid2MUdE/nnc4YFxm
   y0fup0E+4HscvoBc9Qgu/Z8HB8X/7EhHOhCaJTs5Abqfi+Et3h7LZDyPZ
   iIKDb+4kFuycI25GrSn9MvcMnJpc1e5IXxdnTuUcLRWelPwLPFozrIoxC
   V8A4oECHES8H3/mv8Dk/RotdyCgNxfPipBNf3WNfQ3QX+AY0Gyz0WpV/6
   p9V+GjgWGY2GdBICghTur/I3pD4Royo8feYN/VAZLLTjMFEWiWG7raiT0
   w==;
X-CSE-ConnectionGUID: BHultP12TEC5iqmwqtBtoQ==
X-CSE-MsgGUID: k3XLMD6oTI+7LetximGMCQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="34769367"
X-IronPort-AV: E=Sophos;i="6.08,173,1712646000"; 
   d="scan'208";a="34769367"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 07:03:49 -0700
X-CSE-ConnectionGUID: hlDNrFh6TleY1OYmN5I/ww==
X-CSE-MsgGUID: ymjepgDyRPCCOahlLRk1iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,173,1712646000"; 
   d="scan'208";a="36690457"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.244.72]) ([10.125.244.72])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 07:03:46 -0700
Message-ID: <884a4104-27c8-4604-bd80-3b8cf84fd144@linux.intel.com>
Date: Sun, 19 May 2024 22:03:43 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/9] iommu: Add attachment handle to struct iopf_group
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-4-baolu.lu@linux.intel.com>
 <BN9PR11MB52762A339B6E103369C22F068CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52762A339B6E103369C22F068CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/15 15:31, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, April 30, 2024 10:57 PM
>>
>> Previously, the domain that a page fault targets is stored in an
>> iopf_group, which represents a minimal set of page faults. With the
>> introduction of attachment handle, replace the domain with the handle
> 
> It's better to use 'attach handle' as the code does.

Done.

> 
>> +	handle = iommu_attach_handle_get(dev->iommu_group, pasid, 0);
>> +	if (IS_ERR(handle))
>> +		return PTR_ERR(handle);
>>
>> -	if (!domain || !domain->iopf_handler) {
>> -		dev_warn_ratelimited(dev,
>> -			"iopf (pasid %d) without domain attached or handler
>> installed\n",
>> -			 fault->prm.pasid);
>> +	group->attach_handle = handle;
>> +	group->domain = handle->domain;
> 
> this change also removes the warning message. Is it desired?

Not desired.

Perhaps we can add a message when the iopf handling is aborted.
Something like below:

err_abort:
+        dev_warn_ratelimited(dev, "iopf with pasid %d aborted\n",
+                             fault->prm.pasid);
         iopf_group_response(group, IOMMU_PAGE_RESP_FAILURE);

Though I am not sure which is better dev_warn() or dev_info().

Best regards,
baolu
