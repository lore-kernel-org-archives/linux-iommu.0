Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DFB8F65
	for <iommu@lists.linux.dev>; Wed, 17 Jan 2024 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705476066; cv=none; b=XY+DqmaoxdBzNqP551z5J9eV/r349dnMXTzDIaBI6dOhQPta8PQShWexqs/kZ6dsiv5hCUf5KPGd94mo9qQi8y2KVU7j2HVJT+vzmm1tKxTRMeeIlW6etCLMNQmPuw+7STwzB6F0P+uuB0VGcfHyotck6L9N4xBt7UW11Uddz7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705476066; c=relaxed/simple;
	bh=Oajwd5oF8v5If2yshtkXqaI3GZOjlJw6+wQ6+J1vxHo=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Cc:Subject:Content-Language:To:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding; b=IgrUZMB9vJ8QEv/K6+wDOOJq1RfbG9FVxibxBilNnqkubLLLWGZYA48yE/m3AvBLNBPSLi2slmvcOr8JUqlg4/GwNaj5svcGY9fRn13Xvf1D2hxQ9ROWPrARnrUrIyyzLKYSrwArEtSsrdBdPa4WjppH4apIvlwtlzQsH4GRlvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kl1Q6knq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kl1Q6knq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705476063; x=1737012063;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Oajwd5oF8v5If2yshtkXqaI3GZOjlJw6+wQ6+J1vxHo=;
  b=kl1Q6knqhplDPVXY934q0W4MVk41l78KpC3mAd+Cdgfe/iUfmLG94e6q
   0Z13jgQ7uzsggWVcQwO02ykfMcvxYl6IcpjBObqsw3Bytv03sKzMH3/mY
   nMd9cjrJL2nQTqoT7QvxW+OWjmREtoVLlEvHjq8DK+eS7kr3EdhYIMDwy
   uJOEdOEzkCNtPXBv1CcUpoSW3dp0GuoNN3knm8ewmjB394ckVxa+NHuT8
   q4V2Tqklys4hjgfJTlwoUPI4lm14WhXO9H+L8PX77M1tWpdY1IihY1HP9
   MpDacyx9gALo1znnADaaplxmgeGudeFYo0VxA1bbOieYxD4x+Rj/b9l1F
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="7485524"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="7485524"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 23:21:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="777350691"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="777350691"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.146]) ([10.249.171.146])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 23:21:00 -0800
Message-ID: <e0bd9c46-f4c8-4082-b0f3-3f841d04b7df@linux.intel.com>
Date: Wed, 17 Jan 2024 15:20:58 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH 04/11] iommu/vt-d: Retire struct intel_svm_dev
Content-Language: en-US
To: Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev
References: <20240116011146.18645-1-tina.zhang@intel.com>
 <20240116011146.18645-5-tina.zhang@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240116011146.18645-5-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/16 9:11, Tina Zhang wrote:
> The struct dev_pasid_info is used by IOMMU domain to keep pasid info of
> attached device. For sva domain, there is another structure which keeps
> info of attached device, named intel_svm_dev. Instead of using two structs
> for the same purpose, the struct dev_pasid_info can work for both sva
> domain and IOMMU domain. As a result, struct intel_svm_dev gets retired.
> 
> The rcu/did/sid/qdep fields of struct intel_svm_dev are moved from struct
> intel_svm_dev into struct dev_pasid_info. Besides, the names of functions
> which are related to struct intel_svm_dev get changed to dev_pasid_info.
> 
> Signed-off-by: Tina Zhang<tina.zhang@intel.com>
> ---
>   drivers/iommu/intel/iommu.h |  11 +---
>   drivers/iommu/intel/svm.c   | 110 ++++++++++++++++++------------------
>   2 files changed, 57 insertions(+), 64 deletions(-)

I like the direction that this patch is taking. I agree that
intel_svm_dev should be replaced with dev_pasid_info. However, since
dev_pasid_info is protected by domain->lock and intel_svm_dev is
protected by RCU, I recommend splitting this change into two patches:

- The first patch would modify the code to use domain->lock to protect
   intel_svm_dev.
- The second patch would then perform the actual replacement of
   intel_svm_dev with dev_pasid_info.

Best regards,
baolu
