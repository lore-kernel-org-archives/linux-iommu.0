Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A022A290F
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 02:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742349642; cv=none; b=TeyZKkJWmghWFkjFSmWOTaYPSi/GVK9vSoA+KrTAFuPAVCDfb43RVAzJbGRU3BKmQoAWz5T4LnA1FVaZYCIfksj9ir9MWSBAYVJIqjG2TckWF56sd3klrOnJYuIASKRqjDOyPRexvHxPtXimfWyq5PJW9r9dmc2TgaQlH8W98Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742349642; c=relaxed/simple;
	bh=mdhc3gvaBZE0ncHQBJsgk6WgpOd6R6+YjCnKID6VLo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVaGhpOZ65Z4d88B+cLmdR5fzJoeUnOKC4r82QINNj9183+UOpq6kwo4avB+wbybGRVyd27ibwZywRjCLPiDH3cLSkqrrYqR8hc8ZhgltCXgTotQMIr/LRMWVRYhV5lRPjkJ5i+qrv9qtjSJMHxfovg5CIZjwjdh8ANBy6pODpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c6PRsOAp; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c6PRsOAp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742349642; x=1773885642;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mdhc3gvaBZE0ncHQBJsgk6WgpOd6R6+YjCnKID6VLo0=;
  b=c6PRsOApPeig5VEx2Qjz44XkoD9NmAgNHUjDkxqZGo5aKP8bxCliNO84
   aeEdIzl9pyV0/ygjZp78/HNkJ8OlfglzyVwbZeQSTu7M77lRqqqGWXkZB
   MdUSRXsAKsDbctBdn7nUoi7+6aQCtBcEFwxyHMsfwDZvfl2UQ2oB0R0Sp
   14ryXb0d/+TWFPWYYBHSCwHfQGIkjvVVqpsp5l5dMabCqSypVVIBrAYAs
   1o9wgN2RdZVmjxccJRey2/heiz/kXzvVYBvzWi3yIhF1ud9WQM3Ye9I21
   MTVcStkjKTBD2uweUoEQ/YTz53YUQAoXsa1vHxwuYC2WXLQXWtMGLmbET
   A==;
X-CSE-ConnectionGUID: H2+7NW4VTkKuS2vUQWocvw==
X-CSE-MsgGUID: +rSAXRlCTTmBOKWgj9tRvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="53734979"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="53734979"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 19:00:41 -0700
X-CSE-ConnectionGUID: NNGeby3BR4yylUZW/VqFTg==
X-CSE-MsgGUID: wjRSsQ56TSiXVb7PzNwMYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="123186021"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 19:00:39 -0700
Message-ID: <f79f50a0-6a7d-4cfa-ae25-e518d82dae1a@linux.intel.com>
Date: Wed, 19 Mar 2025 09:57:12 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iommu/vt-d: Fix posted vCPU vs. posted MSI bugs
To: Sean Christopherson <seanjc@google.com>,
 David Woodhouse <dwmw2@infradead.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20250315025135.2365846-1-seanjc@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250315025135.2365846-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/15/25 10:51, Sean Christopherson wrote:
> Fix bugs where using posted MSIs will clobber IRTEs that are configured to
> post IRQs to a vCPU, and where undoing vCPU posting fails to put the IRTE
> backing into posted MSI mode.
> 
> Sean Christopherson (2):
>    iommu/vt-d: Put IRTE back into posted MSI mode if vCPU posting is
>      disabled
>    iommu/vt-d: Don't clobber posted vCPU IRTE when host IRQ affinity
>      changes

Queued these two patches for the iommu tree. Thank you!

Thanks,
baolu
