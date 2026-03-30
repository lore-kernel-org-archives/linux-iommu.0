Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51133A8747
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774857537; cv=none; b=pb56Zks3GDLPwgHuD4+jQ+U6voPGMY30cqqckOfb54RBvIlUcphA1WGMAndbL9NB3HrmYdHq3AN2jBQcYKQ7vkKaDsrTUNd3qLLy0JwWy1gQWG4PfoPEG7x3EA59ijfAyzYD5B8c9yZ3z0tMYskS+9Ezr0SeKis4NWG/UbVPbvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774857537; c=relaxed/simple;
	bh=SnqWez0EW1SB1lVxWQ8nuKg8Q1eyyx9SvKbnQhvJvto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PBUQ0LeAOES+0Ib0P6e7K6HfbCzqtpiNnLUN1AZvzzRaN/jKhHpRDUvhZE5QuQiW/24Z5uCaoFHb/hMJ25UCX5D2YetBGMyedjtnrVpjRbOc6qrNGyJbYGK2z21hOjIFJkW5zFmgO7mS/s24zWrE4uzBS/j0+AQ+2p55YC+JF4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eB9yRU9P; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eB9yRU9P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774857537; x=1806393537;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SnqWez0EW1SB1lVxWQ8nuKg8Q1eyyx9SvKbnQhvJvto=;
  b=eB9yRU9PhK29mJvFiG8d3Lzbn2WAhvsn2rlSnVevdwtd1pZOQ7moRHnQ
   ObyPOb7daVnNtaNuhriSKri3zQjoaeHnVARRgkkveK5VocPES0557KuXV
   UmfwCGry88GHl0rAKrrrSsJjatn8KsKLEnW/g0QHyEprhdhxqF5V/CrOr
   oKPGHpm+tI5elZe3F6RB31zHFBFK+V6sRVceq8lU6Zy0lBSVaM5vkASac
   GHzWpIDpnAz8ZXxrQ+3FTgpEsfCTXkOMkJspsFbSHH8jwNhJobmtU6Q1A
   shYFl/518y2SaYpZIM+F0JqOMcS955/Xw6LdnX8nieXMnCi1N4573bMd1
   A==;
X-CSE-ConnectionGUID: ydgwc/ubSGW6dIE1t8GKYA==
X-CSE-MsgGUID: 87gbg6i/Sgqy5sx3GVjF0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="79445230"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="79445230"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 00:58:57 -0700
X-CSE-ConnectionGUID: hcQmstJsQsiuF/J35Y5QXw==
X-CSE-MsgGUID: bmeGm2TJT7mteTByAzXTlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="225155127"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 00:58:54 -0700
Message-ID: <783629f4-4793-48b3-adf8-f2cfac87053e@linux.intel.com>
Date: Mon, 30 Mar 2026 15:57:31 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] iommupt/vtd: Support dirty tracking on PASID
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, "dwmw2@infradead.org"
 <dwmw2@infradead.org>, "joro@8bytes.org" <joro@8bytes.org>,
 "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "Tian, Kevin" <kevin.tian@intel.com>
References: <20260205023405.41583-1-zhenzhong.duan@intel.com>
 <20260206004325.GB943673@ziepe.ca>
 <IA3PR11MB91365DCBEAF527F9D5D1EF22924BA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <9df42fd2-8a27-42be-b827-59d7308dc910@linux.intel.com>
 <dda82f56-c39d-448a-b460-c118ff5750da@intel.com>
 <IA3PR11MB9136EBB1956F4AD9AB27A2C99252A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <IA3PR11MB9136EBB1956F4AD9AB27A2C99252A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/30/26 10:04, Duan, Zhenzhong wrote:
> Hi Baolu,
> 
>> -----Original Message-----
>> From: Liu, Yi L<yi.l.liu@intel.com>
>> Subject: Re: [PATCH 0/3] iommupt/vtd: Support dirty tracking on PASID
>>
>> Hi Baolu,
>>
>> On 3/23/26 10:54, Baolu Lu wrote:
>>> On 3/23/26 09:51, Duan, Zhenzhong wrote:
>>>> Hi,
>>>>
>>>> Kindly ping, any comments?
>>> This series looks fine to me. I will queue it (with the typo in the
>>> subject fixed) for iommu/next if no further concerns. Thanks!
>> The series also looks good to me with one more nit besides the typo in
>> the subjects.
>>
>> I think it's better to name device_set_dirty_tracking() to be
>> domain_set_dirty_tracking() in patch 01.
> May I ask your preference so I could have it in next respin, device_set_dirty_tracking vs domain_set_dirty_tracking?

I prefer domain_set_dirty_tracking() according to what the helper does.

Thanks,
baolu
