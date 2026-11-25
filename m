Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795573487;
	b=Szfb7//gvZu/EhsB5NCxGOSPnv6jNluqD7xyzmlhnLMCSUqN1//x8Fb6w6n1OXx9O3IE
	 0XTasUMss5WLXipoyPyozOOKCM21RJCxvXGS4q9ZZ/49CNphoyKoHka3rkzxnzC7dLi5u
	 w7X9o6C5+lLz+0HPs7OY+h6JNFkxIZhiXM7mRftLAHRWvc3LSke0WC/Q+66ENuigorwU7
	 7scATNjbEMKvsfHJvL1PWTpk8eCWNufI3tKrnpdQmOzK7LHlvHWCCErSRYMW3xy9k/gu0
	 jXTtXog+gZjas1GVJE99u39FYd8sTgX6bULdphnqlBqLQDDzCE45rn9KIGp8hPZ6c+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795573487;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=4fTvF26OI2l4Fr7nHRL8nlvUzB0xv783+Xk2oXIAEJ4=;
	b=5E2Psb6dMNbcUMp1BM+584BZ+R6CE6KxGBcBVuEeaV6mmp/Mb5CgZTs0SwctSCzMMSLa
	 FbUL+0p5+MjOE9fxpkb3dfhHIpQhC5CrE/NZ949uYmHiCWs1/axbSfNeo6/uvc3ebyXpn
	 xjhuSLoOL5Am+CmmqmKEstTmL9UA7hhfBbzkgFLMLWjLBvY9U4cBxhsEHa9NQPRaZlqwV
	 e089XFdTlul9bt8UA1xJFkrRbvuh0GqbVJ1J1Wu4cFxO9DLKF9PvPJucoRCPHFAWgF0zi
	 mAiF9/YPqoyvVlmvAWoDpgbcSXBQxGsHJQanpM63Cv93RMw4RL/c4YurmYEia2+NG0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Pwwgo+Y0;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82291606A323;
	Wed, 25 Nov 2026 02:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82291606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Pwwgo+Y0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795573487; x=1827109487;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VKcJIdH+SpIlQvhAa0tBVb0NecIc1/Vp8arIoi1U8Ns=;
  b=Pwwgo+Y08D3LuN6Jcop6xdO7qF1zbyZ+SwBEpW26SbYmfg1e8zxooAXn
   YN0BgAv/5B1U9lc4HaN0h1jVrZVUbBUepKYHiOeU2JIqwQMC4rohvQEqM
   EsUBtZLMZ+E/25oIchzXEyN3PF33LNhxzZO4QbyQKAjTt/sZ4+mQIu5Cb
   fHptA6nXombOJIm0c4ALxNVJyDdKCP6Sq6AM8vTNFmNlOGg1bPQsgi4yi
   UiXVmr8icwKn7zf86JEq/cVhUPbybSqG28+VjV/5kT0Q1KCzMiztcWk/v
   bQ03/5qoCRu4FM7MXYCHB/NEEyE9+PBAhm5mJD8i247tNu8+hOP1+mUhg
   w==;
X-CSE-ConnectionGUID: 38rGZZfCQkmVtBT3G3wi+Q==
X-CSE-MsgGUID: LWRtz1fgTxS3Sz11GVTkDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4413176"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4413176"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 18:24:46 -0800
X-CSE-ConnectionGUID: 8OOnHuh0QiObDfBtwtUclQ==
X-CSE-MsgGUID: O7hKwrtXQ1WTWTnPSsIahw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11864800"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 18:24:42 -0800
Message-ID: <8d3af929-2c41-4824-8e9a-d98e8d80b3f8@linux.intel.com>
Date: Wed, 25 Nov 2026 10:24:39 +0800
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
Cc: baolu.lu@linux.intel.com, Chao Gao <chao.gao@intel.com>,
 iommu@lists.linux.dev, x86@kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, xiaoyao.li@intel.com,
 Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/9] coco/tdx-host: Add skeleton to support PCI link
 encryption
To: Xu Yilun <yilun.xu@linux.intel.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-8-baolu.lu@linux.intel.com>
 <av1QxRYY9sXtC--P@intel.com>
 <d9f3eecf-5655-4779-9e8a-b3ff4cbdb667@linux.intel.com>
 <awRbQhb3HBfulvfC@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <awRbQhb3HBfulvfC@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/2026 11:26 PM, Xu Yilun wrote:
>>>> +static inline bool tdx_supports_tdisp(const struct tdx_sys_info *sysinfo)
>>>> +{
>>>> +	if (!(sysinfo->features.tdx_features0 & TDX_FEATURES0_TDXCONNECT))
>>>> +		return false;
>>>> +
>>>> +	return false; /* To be enabled when kernel is ready */
>>>> +}
>>>
>>> Patch 2 open-codes the same TDX_FEATURES0_TDXCONNECT check. Can this
>>> helper be moved to patch 2 and used there?
>>
>> These checks serve different purposes: the metadata patch checks whether
>> the TDX module supports TDX Connect; tdx_supports_tdisp() decides
>> whether the kernel is ready to register the link tsm. The latter may
>> include additional checks, such as quirks, so I would like to keep the
> 
> But I don't see the need to distinguish them. Any case the kernel is not
> ready to handle TDX Trusted I/O, but must read its metadata?
No such case. But I'd rather not have one helper gating both the TDX
core and tdx-host. Reading the metadata is harmless, while whether to
register the link tsm is a tdx-host-only policy. I'll move
tdx_supports_tdisp() into tdx-host as a static helper.

>> helper for the tsm registration.

Thanks,
baolu
