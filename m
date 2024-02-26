Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5EE2C95
	for <iommu@lists.linux.dev>; Mon, 26 Feb 2024 06:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708928374; cv=none; b=QSw8C5TUQaIy67/nu16r56tKY/RIQ7+fOI10rJ5MjZq0toPpZHm85VDhpZpAvFJqX4QtJpUM6JayfZw5oju5m3tKOfB5gStGMfwXBShYVod1ZBjuRwrPj1nW99mR5WVEzkbb3r+qsm6p5h3C4uRXk0KVoqA2FiNNdRg5tr5ZTx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708928374; c=relaxed/simple;
	bh=KcP2v2syPmwJPmaJwiiwGPULXNMJO+NfaGDnGfKueYE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CE73Oz1eXQYqC8hgyhk6mk03TjppW0BjFeYYuLOynZZZUDIBE8Y7U8l0kc3p6yWO9CcxrWwOChg4bD4v0r+gaS7ys8mG9sBDsVE0TsfhbRBWDgch5PJqodTUUUDEQTO5Afw9tqEx6esbnP/pF+4UsleZCAGKAdztag/SePBvgoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WrTKeRjJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WrTKeRjJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708928373; x=1740464373;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KcP2v2syPmwJPmaJwiiwGPULXNMJO+NfaGDnGfKueYE=;
  b=WrTKeRjJFaiBKXODuRL78QREDO/vM30pBz5D+VvsK3Q3TPd3ULf+wi8P
   YljwOcZ2DNApmIHOLv4wyVcfvgbzaSmsAmRhq1sUNGNzu0S2bCAX1SavO
   VGshe4emh+PihpjF6YVOTfhr2VYcMVuBsufkcWIpO0wnf+jW9RwtKh1CH
   7UGEXbONfsnyErUAigb7LfvLLN4DmyV1qdLLIkSs2AAu1xZqzPxb+Cyvw
   sfw4doHM7s85x6BNteaCu5IFogEhb7wpOJK7VtJfNRcubWP47ZuVm2KG6
   L3dwyk+GztYPvOTjzBWQTZtgkF6e/RF48lJtiYPeNzMAsHxA/WKPkdLa/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3359661"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3359661"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 22:19:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6561414"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 25 Feb 2024 22:19:31 -0800
Message-ID: <537e54f3-f169-4040-8b55-169f6b4bdbfa@linux.intel.com>
Date: Mon, 26 Feb 2024 14:13:37 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev
Subject: Re: [PATCH v2 00/13] iommu/vt-d: Remove superfluous IOMMU IOTLB
 invalidations
Content-Language: en-US
To: Tina Zhang <tina.zhang@intel.com>
References: <20240219125723.1645703-1-tina.zhang@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240219125723.1645703-1-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/24 8:57 PM, Tina Zhang wrote:
> Tina Zhang (12):
>    iommu/vt-d: Retire the treatment for revoking PASIDs with pending
>      pgfaults
>    iommu/vt-d: Remove initialization for dynamically heap-allocated
>      rcu_head
>    iommu/vt-d: Refactor intel_svm_set_dev_pasid function

Above three cleanup patches have been queued for v6.9.

Best regards,
baolu
