Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DA91A680A
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 06:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294012; cv=none; b=GYw5vHmm8Rh8tnPFsf/CC2sIBpZPDoEzfRKGSdONS5Gds4PjeYxfuJohB0/wmFrEhoc7UVDET2xakO9nvbbP2tece/tvQfB5cF6vlJ3WuwhFV45zOrHzVk6+5VvWnSjYFcOMtpzomoPv8741r+iZwoLgQ7B2yKRzqm7nXNm/Uvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294012; c=relaxed/simple;
	bh=d/bU7+3QPb2SsereKv4a4BVrD7OMN7CDxnAyUvjilgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4TsUkx3DdcS8PRbGkWARWcZyq/NX2OesXmysr/o++YZVeNEYAC0WIfQjWp8vHSO3ig/Xi90DaX93/dBh6ZJ7HeO0U4EPgwg40HGLRntj4P0YIjfrJqbHDH4BOHM6R6XBCtFGYwi20ulOwKxKaNoRO5tU+Nh/jxpMKk8l0Q0lOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=maQuMSOO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="maQuMSOO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780294011; x=1811830011;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d/bU7+3QPb2SsereKv4a4BVrD7OMN7CDxnAyUvjilgs=;
  b=maQuMSOOkqsqWgQFWAnSjy05Fc/MrqSWrINif42w3jK8zpRRIY7vJdOj
   oI5SNOtVwXzpe7TXVEpUjHUrB/L61o1EeSlGdsbwYl3FsTfKNn0AlapoQ
   D1zu9iC8+/HSWRWWs2pX3oN/BqsPJaew+aNsI1f8rF8xU/AAFGUUsZTP+
   96Kls4iaBGO/Yfe6zZEa1SDUS4Ov1foZHcYgyrBHFSKfmW0AM3nAYXRrP
   wXO7+iHp9W6DYdq7bmSWmBW3MSG67er44KknqeC+Z5lXRLws3T3sANUOG
   C/ENs8uxIhb58rmpmJbPlqZq9+XZghc1vd2/oh0cAkO+1fV3ExVTGI7CD
   A==;
X-CSE-ConnectionGUID: 2Ygqn4FBRHaJITOpb3vhTw==
X-CSE-MsgGUID: zynkHVDMSau517HKzaD6HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="84904161"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="84904161"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 23:06:51 -0700
X-CSE-ConnectionGUID: gN7GR6mNQxOfPUJKS7Tgng==
X-CSE-MsgGUID: igpOs3eLSA6/g5xfp6fQWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="245302169"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 23:06:50 -0700
Message-ID: <752dcf0e-01e7-47a0-8244-67e3bb1dd078@linux.intel.com>
Date: Mon, 1 Jun 2026 14:05:59 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: remove typo from pasid_pte_config_nested()
To: =?UTF-8?Q?Micha=C5=82_Grzelak?= <michal.grzelak@intel.com>,
 iommu@lists.linux.dev
Cc: David Woodhouse <dwmw2@infradead.org>
References: <20260509174503.831134-1-michal.grzelak@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260509174503.831134-1-michal.grzelak@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/10/26 01:45, Michał Grzelak wrote:
> Rename pasid_pte_config_nestd() into pasid_pte_config_nested(). Do it to
> match other function names ending with _nested().
> 
> Signed-off-by: Michał Grzelak<michal.grzelak@intel.com>
> ---
>   drivers/iommu/intel/pasid.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Queued for linux-next. Thank you!
