Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795406643;
	b=1uR3cctRifSrUPoOBUhLSnvI8rAjsdeCiirjaLlGPxHc5+wUs82URK/+tplch2kXwZtO
	 kFcVP00/8xtDQj/SbMSNW0oPeHuM4wJddD3YS1Xp/6A9Xy3OIhEaGh94Rpf8lPePcIfRQ
	 TyQ+8e2S918UJd8BL6YhkJ0FtOAtt28bzpluHwPX47rgnI9jgCCH1t9AOzFEFmDonJ+ry
	 QCX0LJJxinh7B5K93NXh5hPu/K8H6/3eWFfSqq+NITkAiumW+XucXzNWzed38HNz6hNq7
	 cpYjbDGP24UFUzhnGd591YYULsytVMvNrIAoarwcUVyIB+kLzFrv+CZsBlwiieOHfcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795406643;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=L/ndKiHqAwsG8Q63MvIVcW/zI5TqmT0H63EXMbag2hU=;
	b=CcyOFY5s4ZjKU5XqQjr83wcsSTsI59s7JR2eq8j0GgBfSaFcchTqABlb3HyPQh1KwNXu
	 qOsVx6OO8pQ33mxznQLTN/0bWht4iGI676toRxuGT3mLSjVhgauF1ewGJGBzsrr9tUCfl
	 SrM0Z5mGWrCVESljjzFMBbBYQzPXMjAPLV+S9px3jxKY31/ORTeaonLPz5OHJBbLjGsut
	 w31BkIv3R6woDp4y+DgN8+1IAoPIkqTTPP/6NpLvAsfCpUiOi1yneqg0u9S2SWYHKz1rw
	 0fdJcF15uu1nVil+EZ0r5EhYFzJI7EedHBGzoqJYUvnonNaJ8EkVuY8Ou2RhLYUgp0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g1YBC98m;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7A1606A327;
	Mon, 23 Nov 2026 04:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B7A1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g1YBC98m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795406644; x=1826942644;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/2JPg26k4eGPhYoW5PqQdEQbXOwMlhbiHh908evguOc=;
  b=g1YBC98mv1bhOyI0Y09bkql/vF1jYGtkhEh7ygq6gpwJap92nqBDYul6
   fb0Ah6655wj9YDq2O2TY0R7kPut/9/9XxHS4xHP4Xnperti3U1K5Y3l1t
   hmdvwobA2awFBi53lXOTC7S5VdBIkSErocOBzxjffON7q3Q8icjKZVceJ
   2eh9C3e8dqEP5Wo8ol3cRF7oV5zbJ7fj0dd6C2QG5+TE43FBvuFoJZJMS
   4iVz6XgL5S1v4aCrpE3RN0X/GMKQw0eiymiPxGsLvHOYGv6UNf5Rf/Qj7
   40gZkanZNBO5pMjekAPIIRcHL2GQh21w6PQECIItC00JImJq6q/jdlLTV
   Q==;
X-CSE-ConnectionGUID: dPD+H1O7Qf+L8r1PjyeK6g==
X-CSE-MsgGUID: PTx8e0WPQxGV39RD1lQySw==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4219242"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4219242"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 20:04:02 -0800
X-CSE-ConnectionGUID: DRGib1DfRMmtM12iuyOqIA==
X-CSE-MsgGUID: xAJ+eoy9SSG6p9BwuMHvmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11085664"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 20:03:58 -0800
Message-ID: <70abb0ba-63f0-4edd-9359-bfd220b8ae3b@linux.intel.com>
Date: Mon, 23 Nov 2026 12:03:56 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev, x86@kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, yilun.xu@linux.intel.com,
 xiaoyao.li@intel.com, Chao Gao <chao.gao@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] x86/virt/tdx: Add SEAMCALL wrappers for IOMMU
 setup/clear
To: Binbin Wu <binbin.wu@linux.intel.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-2-baolu.lu@linux.intel.com>
 <ed90de7e-6019-4d42-bc6e-5b586b460a31@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ed90de7e-6019-4d42-bc6e-5b586b460a31@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/2026 7:02 PM, Binbin Wu wrote:
> On 11/12/2026 12:30 PM, Lu Baolu wrote:
> [...]
> 
>> +
>> +/* No cache flush is needed; hardware keeps caches coherent across KeyIDs. */
> Nit:
> It's a bit confusing without the all the background.
> Once Rick's patch [1] removes tdx_clflush_page() and its comment, a reader may wonder
> why this wrapper explains the cache flush but the others don't.
> 
> Is it better to drop the comment and explain it in the change log?
> 
> [1]https://lore.kernel.org/all/20261015191710.3632302-2- 
> rick.p.edgecombe@intel.com/

Agreed and updated.

Thanks,
baolu
