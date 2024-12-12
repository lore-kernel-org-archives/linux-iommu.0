Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994238837
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 00:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733964230; cv=none; b=QyPz8j04S1CcUtrMAG/44yth/pRf/wqhVZzkNh0h24CIrHd0rlQo6NmilWmsEITfNCm3/pkwTlwfYunFjddCTtyzGIbNHBezwMWztOyNLtVwUYoD0Xppbqa+lxtkiSZ2Y9uqGcN07MnfDFTo6ZFm4BchfsqCaXsGiYbgRTh8Pxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733964230; c=relaxed/simple;
	bh=hYv5hL0UN1A7AC9q9NHwmxTmrIGgiJrTBeIHE/Fkri8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbcxCkjMvxYwW2m8cbtd7iSs/DaJFwDsWxslX+S4SDJlD/kYXfi1qOWr4va8FBdNgO7m0nIJ7BjWyr71CZxn+PCABjBLKeKCFprOmDlUn48f79X75kzcpaxUzWHrmvfWJcqzLkf1AaOyR1PiAZd71AYRa1IvL0toEQOfZkp86HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XRoJtj8V; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XRoJtj8V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733964228; x=1765500228;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hYv5hL0UN1A7AC9q9NHwmxTmrIGgiJrTBeIHE/Fkri8=;
  b=XRoJtj8V6DGPro/lTIuGatxiMDgA90DnWlpQ3nyjJL9eJwYCu3+mTssc
   3lPVOXwfSux8ingldqa3bYwOrTt7OOGiKzOm99WKHnVsU78ZAWW+DtsMs
   2FSiOPltvOPenxL6Ij8+llsCNJmJS2QVlckzd4+ibzoXol4j+GGdkdnuk
   OqAFK9Kuskr5IEKevwvJPP2S2XlElyDlDF0xyw/g8pbm8Y5Czq8X17Qw5
   6zwJQxcGT3oz2RymtOmr2dNLKShJhYfXxhrMFxxJCArcjz6A7XXdlB19t
   vKzNXBQrauzZEMqV9cFD/AnJGDH5WxaI0jZHNL63/Gk8rRktyhJPEyVZ/
   A==;
X-CSE-ConnectionGUID: VHRjFtcxQOOfI6nmEz1GUQ==
X-CSE-MsgGUID: ytjf4VZSQHq+c6196OTeUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34269129"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="34269129"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 16:43:48 -0800
X-CSE-ConnectionGUID: eVLtpLKJSNaUGQQmb2j9uA==
X-CSE-MsgGUID: zoZtu1tqRKKhcmOBvFuBpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119263328"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 16:43:47 -0800
Message-ID: <52932cf3-41af-4f71-a961-57b26e9fedad@linux.intel.com>
Date: Thu, 12 Dec 2024 08:42:13 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] iommu/vt-d: Drain PRQs when domain removed from RID
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: iommu@lists.linux.dev
References: <c5187676-2fa2-4e29-94e0-4a279dc88b49@stanley.mountain>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <c5187676-2fa2-4e29-94e0-4a279dc88b49@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/24 20:42, Dan Carpenter wrote:
> Hello Lu Baolu,
> 
> Commit c43e1ccdebf2 ("iommu/vt-d: Drain PRQs when domain removed from
> RID") from Nov 4, 2024 (linux-next), leads to the following Smatch
> static checker warning:
> 
> 	drivers/iommu/intel/prq.c:95 intel_iommu_drain_pasid_prq()
> 	warn: sleeping in atomic context

Thank you for the reporting, Dan. I will soon post a fix for this.

Thanks,
baolu
