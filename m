Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93054400
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 03:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740366069; cv=none; b=VjI1lFoBGWrvRy05UZd/W7cc6OxvE1g2fQk3O/iKH117BJmEJWE3KRfhh7MH1Puxvk2lrRCn2DSWHl2ud8xR2Dmp2S+dhoSmDr4C+Mt8TaT8s2Ldipa2Htjhjqd2jH3Zv/SL63/yiTYdRrwvww4xgqUt1CO+sigIMdmPU3bX9Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740366069; c=relaxed/simple;
	bh=iEMgmZ320l1GIx1iK+nPEtP8CcJwwglSqgIvNAU7Kwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HBE3rpwfiM18t+XsU7j0ZaoBiowSKxqgJp7MLqs94FO3JmcVSVe/Y4/8cA3bUW9CpTsHaYr3AdusrJvhT6tI5Deoes+gbGeeuRVt5eDLeD/AE3iGWAB1nywPlsNDC0J5t8RsEjzgAia29egQGgaoy7FJj/mR+0Qh4HYvJ02nmnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CPiBsUfl; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CPiBsUfl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740366068; x=1771902068;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iEMgmZ320l1GIx1iK+nPEtP8CcJwwglSqgIvNAU7Kwc=;
  b=CPiBsUflB+Z8xxzJXm3Vu1ej4cD9p+ByKC889T0j83YzCvD0BVLOa+re
   +L0Ub1Q6c9LGmWuJUBLEzfkE78D2aUBPULny4rABgYk9EN+sv+iWuboQB
   +bzsGNhFq6dkxc3buSejkTjM+F/1jgWJ8yTZBjXJ18cWAZDkboH2o3Sff
   N1fGg2NmWm1fxgBI/gxORoliS9gUvIGLhXiWscuu+czkFd+N65gmN9720
   8YKtWXBc/gB2fwwRns/9KVInZuYYtZ3MF/gS/2fopwIskxnBKThmGJ6Lq
   aaiM4eYPom3zwrUG5Q+yTi3i/MLEueavojeCBoYQ0EIh7OYa/ur4GPz/W
   w==;
X-CSE-ConnectionGUID: Y3kV7BAgQXGhndmy8VRhpg==
X-CSE-MsgGUID: dO0mfj4GT6aJCY2U23bvBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="41126059"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="41126059"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 19:01:08 -0800
X-CSE-ConnectionGUID: 24jg0MOdS4i60z22GlWDFA==
X-CSE-MsgGUID: rY2qlPwWQUy6dxqqtD8Daw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="115905653"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 19:01:05 -0800
Message-ID: <6555deb7-17a5-4e0b-b167-fef6785a9961@linux.intel.com>
Date: Mon, 24 Feb 2025 10:57:53 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] iommu: Store either domain or handle in
 group->pasid_array
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "will@kernel.org" <will@kernel.org>
References: <20250221143335.49874-1-yi.l.liu@intel.com>
 <20250221143335.49874-4-yi.l.liu@intel.com>
 <a4a1e65e-3614-419c-a5e3-6ff2aa4f1369@linux.intel.com>
 <BN9PR11MB52764D5D3DFA97B187DAACE38CC02@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52764D5D3DFA97B187DAACE38CC02@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/25 10:38, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Sunday, February 23, 2025 9:23 PM
>>
>> On 2025/2/21 22:33, Yi Liu wrote:
>>> @@ -3454,13 +3468,17 @@ struct iommu_attach_handle *
>>>    iommu_attach_handle_get(struct iommu_group *group, ioasid_t pasid,
>> unsigned int type)
>>>    {
>>>    	struct iommu_attach_handle *handle;
>>> +	void *entry;
>>>
>>>    	xa_lock(&group->pasid_array);
>>> -	handle = xa_load(&group->pasid_array, pasid);
>>> -	if (!handle)
>>> +	entry = xa_load(&group->pasid_array, pasid);
>> Could entry be NULL? If so, a null check might be needed here.
> a NULL entry will go to the else branch in following check hence
> get an -ENOENT error.

xa_pointer_tag() implicitly returns 0 when the entry is a NULL. I
believe this behavior is unintended. The comments of this helper says,

  * If you have stored a tagged pointer in the XArray, call this function
  * to get the tag of that pointer.

So I feel that it's a better code style if we check entry before calling
xa_pointer_tag() to make the logic explicit.

Thanks,
baolu
