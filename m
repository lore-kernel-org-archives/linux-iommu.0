Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377BE29E10F
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 06:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763447022; cv=none; b=sH6f/hV8luP8mCdwSllQ77qJ3OOKtj6lG2Yc1suUw5goOASsVfvbJmbYpVBmgzVRpgsVreRVqc3aqEwpUdV7x8GY60BogZm9BJYnoIuG9N/0xsv1P2eOlIv5PsvLSNPw58DRtn4thXyOe868HBVI/mzKYLXwZ34j9Wq+Sxqcl24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763447022; c=relaxed/simple;
	bh=o0Os0yCWoDXKZYizKvM7nchHjT3IMt9PymQ9wsTSCAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WxUJmyLUNNxMbtqn+FrWu48MrsVv9GYAP7eSt55BDQ7rEsBFx1JKQ/gyC2xEiCjKAFDOQavPJwfe3zTN2ducQ1Q+mYoFY9xo5iFGMor8xkSTPy9F2nMkxbVmBcCJojJAvyUZgZKCuTSxS0fRlB+DcqGKMpzBuClg5GuVs3T/RCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gvHWM6gw; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gvHWM6gw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763447020; x=1794983020;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o0Os0yCWoDXKZYizKvM7nchHjT3IMt9PymQ9wsTSCAU=;
  b=gvHWM6gwKcpCLofRSeY36K5v2j8cK7V8kQxHY42yQ0Pu4IXXeYHkiER5
   Zpl3ZSzrBsyAs/TZt7XCl2itggTFwcHEtcH157R6rw3g+1WSLKWAWaOJf
   GcKtl/QS0Eki1dAs16BiG8AMCN/Vwk5Q5QnOSN5dzf55eHCAga/E/Vi+T
   jI8++r/XwvBSjhCSdp7JrhNtHj+Hv0KQRzlHqNAQshBpGNPOaznhzcosU
   jYcF7K9cHA2vRFaTdKSCCk0+hy26fp/KtX8mxbwuvz3/1BUi6s0TKUm9e
   rZ4yz4PSaJJXFtdjEBWzXKQQaF7acqZn53PYuloqk5vtXIUr3BiOsLE5o
   g==;
X-CSE-ConnectionGUID: d1EkkbTISJiuxO0YtO57Wg==
X-CSE-MsgGUID: dx2msSEuRjWySVyZzbCzoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="76811710"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76811710"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 22:23:39 -0800
X-CSE-ConnectionGUID: yS5W5kFpQVySZliJZaBRyw==
X-CSE-MsgGUID: WPRLsngoQ3Gsm6IB1j1V4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="214064899"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 22:23:37 -0800
Message-ID: <bf5de414-ef1a-42bb-8d20-c14d8d1dc037@linux.intel.com>
Date: Tue, 18 Nov 2025 14:19:24 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: REGRESSION on linux-next (next-20251106)
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "De Marchi, Lucas" <lucas.demarchi@intel.com>,
 "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
 "Saarinen, Jani" <jani.saarinen@intel.com>,
 "Auld, Matthew" <matthew.auld@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <4f15cf3b-6fad-4cd8-87e5-6d86c0082673@intel.com>
 <20251118012944.GA60885@nvidia.com>
 <BN9PR11MB5276C5F6D952CFFEC7CBF0D68CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276C5F6D952CFFEC7CBF0D68CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/25 12:04, Tian, Kevin wrote:
>> I'm still interested to know if there is an iommu error that is
>> somehow not getting into the log?
> Just re-checked the code:
> 
> dmar_fault() -> dmar_fault_do_one() -> dmar_fault_dump_ptes():
> 
>          pr_info("Dump %s table entries for IOVA 0x%llx\n", iommu->name, addr);
> 
> before reaching that point, there are several early exits:
> 
> - advanced fault log, which I don't think will happen (Baolu?)

Advanced fault log is not used in the VT-d driver.

Thanks,
baolu
