Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA0C2E62A8
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 06:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763447276; cv=none; b=fV/DiDwLfh0tADKrR1d3EyY3uzsf/6TWcH8HZk76pOwJM/t2UBQSTYrApa8VnOR6clG3fPyAGK/JBEc/s3Sc2tGwSnALpnnlcHQTLzYGtypddlV6w0e44w3xjjKu/gdC3D6HpOF1F96/IypRMFBvcRu9EiR18WLsP2Gsf+nZNNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763447276; c=relaxed/simple;
	bh=qjBNPO7akwtbKWj3lWzGjKv3g/58FuL7oZxZeQoOHGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtvrbrAp7qntfnJES64E35BLATlEmUll3V8/yabV/qnsXN9g8bf0RsokvFh8GtjcJJt7Xi90fmc+GFcFHPcBgk0l6TlV6hz88sOsJ6glaQcX88zzyE3GZbsjTcW6Twcswj637XMr2lwsKQizLKzCeX6fh8sXNN9ZAkMN+ssU42M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XoZnOQzD; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XoZnOQzD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763447274; x=1794983274;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qjBNPO7akwtbKWj3lWzGjKv3g/58FuL7oZxZeQoOHGI=;
  b=XoZnOQzDoY8mfcL7xty96WNRraDZ8my/2nBr3zW0q3BFxofrxHKFd51c
   udNt+1SmsjddN2zqURa2U0C/NE8LN0qf9AUb8PQtXcnhDbKk7s8Fogqau
   ohhGF7b4nxKTxG+zhT88F/kNwFbzDwgluWnknzS3StNqUvPjQFZCIzq67
   PjwQsX8cDFNIif1rqqYsvb/u2xtLK1TkGWPhbKXTafMQ8s4+w/f8m1j1A
   CuMhjwyA3RR0cxszmBRaOYOqoKgnwdhgEjgtcYS7GIfbPh7h/E5Wnwq6W
   1CHlmTb0JtNMzy4VnAkx3TN2u1WOuK/afd8Bj3ToLqX+gp/jVO+kvlwIu
   g==;
X-CSE-ConnectionGUID: El/NoPNmRPuAEdB8GCeBtg==
X-CSE-MsgGUID: 8/wD5k0EQGC7uABXFRpzEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="64460978"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="64460978"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 22:27:54 -0800
X-CSE-ConnectionGUID: 5J5NUgveTGupXBGK3jEYeQ==
X-CSE-MsgGUID: n+vYmvMKSTqJ9vm45RIe4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190331718"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 22:27:52 -0800
Message-ID: <5ec170fa-d5e1-473d-a7b8-8d1737efb241@linux.intel.com>
Date: Tue, 18 Nov 2025 14:23:38 +0800
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
>> 46 bits is not particularly big... Hmm, I wonder if we have some issue
>> with the sign-extend? iommupt does that properly and IIRC the old code
>> did not. Which of the page table formats is this using second stage or
>> first stage?
> Assume it's first stage for kernel IOVA, if available in hw

It's the first stage (x86_64 fmt) according to the PASID entry setup:

IOMMU dmar0: Root Table Address: 0x105a82000
B.D.F	Root_entry				Context_entry				PASID	PASID_table_entry
00:02.0	0x0000000000000000:0x0000000105a85001 
0x0000000000000000:0x0000000105a84405	0 
0x0000000105a86000:0x0000000000000002:0x0000000000000049

Thanks,
baolu
