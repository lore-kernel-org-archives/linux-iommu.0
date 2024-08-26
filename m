Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4E085283
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 07:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656837; cv=none; b=NUo5JB1Ih21RSNSBCbJeS80tSPtWRm9Vlgya13sT2nQqQ2ajCHQ8XuiTvWyk/qIFJqoWunCSbbwJI5nuu14UVpkD3M27hTVFB1wcLIV68ReQoDrxV1szbiZGQcTaXnupTG3yT19uIhHQcNGqSTdD4KCELDRKWCNzV4OAP760NoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656837; c=relaxed/simple;
	bh=IrUxmpZGow8T5FQL4KYV6iv1TAPKK39AEpAFrFRxsdc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DTfyFwaa4vUTejm9pWaVE4mfu2GUOVDhVnTNNn9VOutCSCCKqn1s8hMBXtOzAbZs7FDO+9uMds2Hdg/3RIuOw80x5U1i6+mIyzXqt0g/k+pm9sQWycrRagLKZWhLIN/r2fdQfmnbfql0AhfEvjPogipBOJrLsh9dnSn+JHM8lWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nMhNPf4Q; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nMhNPf4Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724656835; x=1756192835;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IrUxmpZGow8T5FQL4KYV6iv1TAPKK39AEpAFrFRxsdc=;
  b=nMhNPf4QKXjOV7IKnXmcKI7o5XhJxfK7sLvsiz2uv+xchwKL/zYqnT5s
   TxH4h4Hsf4NCiNaYrLF0j0rt8Lcxce6qFr2U6kysmfv48fYJvmrkKDZUo
   FmU90z3djLfKMa5w0Gigz7GP26d+2q6Suvp3U2BvlY6Jn0bjVmQBih5EW
   PPgKNorJ4IcgtWqhDdgbD2sP6Z4qEEH6DmmIQ2J51V8k9O2Nh6FDhxRyz
   d1+JwySiK3zYbDC1kvpb1KPZt5jYBVDMbtpr88HJ4h0RcfXM2uZiWy9iK
   fwAkjDmHIJv+yXruxieFnHJk8V3imxbPtSvIlmATxBsX0RevFecNIpSxs
   w==;
X-CSE-ConnectionGUID: ztX7rtiqRWOCCTTG2zINzw==
X-CSE-MsgGUID: dosFlLfSTo+fw5QnMXZO3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="26940616"
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="26940616"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 00:20:34 -0700
X-CSE-ConnectionGUID: UD+BlqXWRi+ik+1ElQrRzw==
X-CSE-MsgGUID: h8cJo7pwQdS9KVqzdY3FSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="93146444"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 00:20:31 -0700
Message-ID: <92ec8153-60db-4642-be1b-f7bba93d617d@linux.intel.com>
Date: Mon, 26 Aug 2024 15:20:29 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix incorrect domain ID in context flush
 helper
To: Joerg Roedel <joro@8bytes.org>
References: <20240815124857.70038-1-baolu.lu@linux.intel.com>
 <ZswrYlqb4U3Bq6b4@8bytes.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZswrYlqb4U3Bq6b4@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/26 15:14, Joerg Roedel wrote:
> On Thu, Aug 15, 2024 at 08:48:57PM +0800, Lu Baolu wrote:
>>   drivers/iommu/intel/iommu.h | 2 +-
>>   drivers/iommu/intel/iommu.c | 8 ++++++--
>>   drivers/iommu/intel/pasid.c | 7 ++++---
>>   3 files changed, 11 insertions(+), 6 deletions(-)
> Applied for -rc, thanks.
> 
> Side note: Please send critical fixes as a pull request next time, as I
> usually do not look deeply into patches for drivers which are actively
> maintained.

Yes, sure.

Thanks,
baolu
