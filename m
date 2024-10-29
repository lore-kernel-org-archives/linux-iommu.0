Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18441F4FA8
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 04:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730176776; cv=none; b=uj8LSJdwjrjHGw9cxvwumI2TST4WayvgijS1BtuN+I8Bgre3z5T3ijGvy7IexvUkx8czcQX99gPqzg5tmmBiznElvRZLUc9A0E+N7zWnhfn6r8aJe1Ao3PwCwbtfoubd/xsUNV6NXiop67L9G8LNn6h66KfZwVNHYuJE7bCWCb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730176776; c=relaxed/simple;
	bh=NxJ/XDTSw1UpyMDjO/sd+aNnVw1J3Cv6inQUL3gi6sI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Qm5Opo8W8DlCaXZKd5F4mEdcgSl2v6xJU4L+7lSowzEeQMvZwAThRP/UYHwQ73nMQc5bXIE6zWblsw2e/AfWh68gQDybExBTOSg5lyg5j6EMnlikBa0qpndcX6OGukGb0xbilQbZbZ/+o5u1zkNkwEUtm+3iAe64MBV6i0QGTE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zew1ghOV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zew1ghOV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730176775; x=1761712775;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NxJ/XDTSw1UpyMDjO/sd+aNnVw1J3Cv6inQUL3gi6sI=;
  b=Zew1ghOVeVxZYt7z9T04Xl0E1p5+ZCAUwMlco1mQIhdzAL4aguGt2Vnw
   /GN3N9u75Pj3MECz7u3czjoGKUmoJcv9sjIDNgZhTKslh+N5DVw68Lg3A
   X905ystZUt5lgnHufdP+P4jM/9RnACh4Yf7WA3ZtEMbO34jnXr5LyTtJd
   C8Ph3V4KWd7QQAQJdgjcnFG+zV9+DFq+eMwNLRmc7qjoTuPSgg1O7dQgr
   wVfcshY33q/fJPrA99ARhAshFcz7VYE3OxfkHsAzYbMUikh7P+DWD17M1
   cahPE93DvY4/GQohfsJiQZ3cUKdCfQgvBJfuBaG0byOJSdUS9cSPsUZSS
   w==;
X-CSE-ConnectionGUID: jixf1oYQSnWeahgAzXuGNw==
X-CSE-MsgGUID: tSr20GtcRTafQvAj0IB3Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="41193697"
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="41193697"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 21:39:35 -0700
X-CSE-ConnectionGUID: h0UWWNqhTsyf+BXJLK8XFg==
X-CSE-MsgGUID: 0S5bMY+eRMyYqQ45/Kg+cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="86606782"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.238.0.51]) ([10.238.0.51])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 21:39:31 -0700
Message-ID: <1ed9997b-e71c-4173-b89a-942018c09691@linux.intel.com>
Date: Tue, 29 Oct 2024 12:39:29 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com
Subject: Re: [PATCH -next] iommu/vt-d: Use PCI_DEVID() macro
To: Jinjie Ruan <ruanjinjie@huawei.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240829021011.4135618-1-ruanjinjie@huawei.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240829021011.4135618-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/29 10:10, Jinjie Ruan wrote:
> The macro PCI_DEVID() can be used instead of compose it manually.
> 
> Signed-off-by: Jinjie Ruan<ruanjinjie@huawei.com>
> ---
>   drivers/iommu/intel/iommu.c         | 4 ++--
>   drivers/iommu/intel/irq_remapping.c | 4 ++--
>   drivers/iommu/intel/pasid.c         | 2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)

Queued for v6.13. Thank you!

--
baolu
