Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD6C7D3F4
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882509; cv=none; b=GaYTJ69V7h/XK+IJfoSDtn5w4DFgtIBR0x5UHZb1XjEq2CAr5f0K2iABGGt91XHxVktRoM1T8DlQKSx4zXOVywTrlEnr8ut67D/G1ep/StYUpIaCZUVbJE8LKMS2wqx+jbr1qVCzEc61OYP37Cu4rX3LNSCALOgTzhrmK7b8FH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882509; c=relaxed/simple;
	bh=n3jfsyzyB7Wp+wndUMUhHwNwNTBPJi6SzUWEzRp4+Xk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FSSXrbyfbrd923ZxPn1BbSkznMiLz5RIisAbuaQOK5dHfapd6mj7fazNi2OdPdFsv/hqQssGEutvGWTSUJXfLmdllZWGlPAhRZrVmchAR5EeOL9VZIxQ46rRmDmsuUCS5ivN7YR+4hjPG7HA+eADGuEPxC66MVuqJYmce99bAvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dTndi2zK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dTndi2zK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730882508; x=1762418508;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n3jfsyzyB7Wp+wndUMUhHwNwNTBPJi6SzUWEzRp4+Xk=;
  b=dTndi2zKJA/LgndLUghyyB6XIw0NZVX4FYm9y6cYJHap7qwzIjLfo60p
   26QbH26eVPjlDSb4zFue48QKicj1x96kCNdbPuFbQI7n+2SjfxG3xbwff
   eUxqIXbzgtrPd8dXNVN9xIYYAXSXh0l3B75iE4EGhHda7VNr0dYx9vBVH
   ldwH2H4cbgO68/fQWY7mNy7Zvn5B1xTC5RRxx1YITWoCw9/FXSRew6eXf
   rKkoMGAxT7OW5pKyvJ2yfdsUDwy1vUtWBcdwDuAX0F3gqx3o+PilEr9fp
   nyanNAAWjmrp3QGMNTm/oW4zSg4CLBf4wszTXjDgRoqnyHwn076sWaHiW
   g==;
X-CSE-ConnectionGUID: 3eoD6xA7Qy6PRF3DJKybGQ==
X-CSE-MsgGUID: oaZZ5qY0TACa4MjH2xansA==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="34595432"
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="34595432"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 00:41:48 -0800
X-CSE-ConnectionGUID: pBxoe7ZWRM+CvbMwV0j1zA==
X-CSE-MsgGUID: QUxcNiljTYGTgQMUd/ormg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="85239228"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 00:41:44 -0800
Message-ID: <778d4e7b-cb4f-48d6-9b5d-de5e18c1a367@linux.intel.com>
Date: Wed, 6 Nov 2024 16:41:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
 "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v4 11/13] iommu/vt-d: Add set_dev_pasid callback for
 nested domain
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>
References: <20241104131842.13303-1-yi.l.liu@intel.com>
 <20241104131842.13303-12-yi.l.liu@intel.com>
 <BN9PR11MB5276F52B50577B8963A20BEB8C532@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276F52B50577B8963A20BEB8C532@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/11/6 16:17, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Monday, November 4, 2024 9:19 PM
>>
>> +
>> +	dev_pasid = domain_add_dev_pasid(domain, dev, pasid);
>> +	if (IS_ERR(dev_pasid))
>> +		return PTR_ERR(dev_pasid);
>> +
>> +	ret = domain_setup_nested(iommu, dmar_domain, dev, pasid, old);
>> +	if (ret)
>> +		goto out_remove_dev_pasid;
>> +
>> +	domain_remove_dev_pasid(old, dev, pasid);
>> +
> 
> forgot one thing. Why not required to create a debugfs entry for
> nested dev_pasid?

This debugfs node is only created for paging domain.
