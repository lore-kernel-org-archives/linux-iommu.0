Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F71413B5A0
	for <iommu@lists.linux.dev>; Thu, 11 Apr 2024 02:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803896; cv=none; b=Ro0VGy64rtlUL23oX+HtCB/Z2BLMWMn1hOu3+45CBirvG6D2M1X9JA9gESE42yeID8Exo/9iyTB43FcKkVadBrwJPkzB7Ugi7FK2SLwAYQtKl35/2aZGp3/C/Wy5MGB1FMcRW5OSNvnctGjkfQuOLMprfkctyHcVi1F1nRI5PCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803896; c=relaxed/simple;
	bh=+IjIZMalViYNIFm87QlzJL3Il2vDG4G2fnXAb7Pe05c=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XctZlTan/JK7PVaMc8VbvuXFouJGWQ/zyow6NhJT7KHVGdjelb2ZLL2mf25ip/AR257YF6NEiZO6cFdVEt1QpzvGRNjcZ2Xmm06V3GveD+LVZTtloGGn/4zqld8CDX3Hypln2dSK5VNaQIRWa+mJCNWPJhl0DrjDi54lDl/556E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aCdBw2kk; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aCdBw2kk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712803895; x=1744339895;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+IjIZMalViYNIFm87QlzJL3Il2vDG4G2fnXAb7Pe05c=;
  b=aCdBw2kkTGoM48tmmhxqoerevsvFSE8gO9Wb68SnhzI5aJa8B+7GykVq
   9T6FPfMsD6vpI1hgcCFW5YVx6CibR5gy4B/1JkrOhVK268UEFmw0LA1Qy
   ORutVt81QOn0ZK5DDaaWVGsbhBAT40rpHgpgLxQNBS7zPhLk1VMTP3ECH
   BCfvJ2aNu/7mYXJuXvssO2mf6FMryohrQ/uI16G8wYtqWjDGH//8+5MhG
   ZcyKI2Dxq4+qjsFlBjWrj/uDLUli5SSAXDYH1OxS6TCqP5cGjkch7QpkP
   gtLtTcDJoWGRH9R81uBJPk73vAZdAcdNOd3BX/TqFl6FTcWH2Fp2bSIeV
   w==;
X-CSE-ConnectionGUID: kW+rNYLvTXiOm3hV87i+iQ==
X-CSE-MsgGUID: VHNafsnmRQq9lJX5PDk55Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="33596804"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="33596804"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:51:34 -0700
X-CSE-ConnectionGUID: 1jdd4WVgQqmXtxbY0XSdzw==
X-CSE-MsgGUID: gYLGA8N5Rve38AGIgaxb/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="21196604"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 10 Apr 2024 19:51:33 -0700
Message-ID: <8ec541a1-679d-4305-838d-bd679dca647e@linux.intel.com>
Date: Thu, 11 Apr 2024 10:50:20 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com
Subject: Re: [PATCH] iommu/vt-d: fix wrong use of pasid config
To: "Liang, Kan" <kan.liang@linux.intel.com>,
 Xuchun Shang <xuchun.shang@linux.alibaba.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev
References: <20240401060753.3321318-1-xuchun.shang@linux.alibaba.com>
 <5e29fc2d-0f75-4929-af74-224c5f891c2f@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <5e29fc2d-0f75-4929-af74-224c5f891c2f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/24 8:58 PM, Liang, Kan wrote:
> 
> On 2024-04-01 2:07 a.m., Xuchun Shang wrote:
>> The commit "iommu/vt-d: Add IOMMU perfmon support" introduce IOMMU
>> PMU feature, but use the wrong config when set pasid filter.
>>
>> Fixes: 7232ab8b89e9 ("iommu/vt-d: Add IOMMU perfmon support")
>> Signed-off-by: Xuchun Shang<xuchun.shang@linux.alibaba.com>
> Reviewed-by: Kan Liang<kan.liang@linux.intel.com>

Queued for v6.9-rc. Thanks Xuchun and Kan.

Best regards,
baolu
