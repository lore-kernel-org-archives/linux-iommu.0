Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414FD37145
	for <iommu@lists.linux.dev>; Tue, 27 Feb 2024 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709017059; cv=none; b=MvwV/gj6XP7+IAmxoWzTWlXn+2XBaRYl33vIawjlVXqXOemY2rz1kWyjR/YZQywc2vd5L4prH0lSRUq1A08sT9ega3XcYR18LmxR5QnU9+JpEopDbF41zOwt4HvpBVwrSVkyFajovT8WkSb4ZRR/qnZ6OE3b6/HlaXt8wOZ5ACo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709017059; c=relaxed/simple;
	bh=YvGZDgLgIVJF+BHE7Jc79utI2MU3LMX2wIjPPgVMfJQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V6pIDNT9KTSXBmXcpGqtqj2bt2ewhsZtl4PV7T0TDNagqs1C3dZY/e8etTlvxT0iz+qs0YijvFeGNJ0Vg8IUkmz0L3JEqZmsWEIEAFyuUfQ2auIfeeY0hpvp+uk7u4yEmPx79g25WLxS+7YHxs77/QO8QlChdomBNWzpMBOiizw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IId5QlNo; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IId5QlNo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709017058; x=1740553058;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YvGZDgLgIVJF+BHE7Jc79utI2MU3LMX2wIjPPgVMfJQ=;
  b=IId5QlNoPjDwC08tl04I8OwsBq6eAAi1MMgxhjbI8gHKnX2SzIYsHjRl
   T+TdcGdeY+fwxvH2WbGGwpG6os9xoBSz3vWo5IZECOsFaSgNmz1w1Lu5C
   bwGiG9YF8eh8oAm+yxFgB3Z7e4CTnihRiv0Xuo7TgBCG5Gt5SVW5IbpUR
   b/6R7re18BTIz05jKLAhYstpZyWFk+C7ZjWlPI2SBPKq8fiGzINrVKBRu
   7Eh/rHgs+k4NsssIR/K6cnLxWF0HpdbNit0wBoP467O0KIOq0qPFAeRD+
   rkhjPCT1CvSdMkLE7TPKq2HQezYp+SWvRDRelEpcW/mYgGlaF9o/ur7P5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14766528"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="14766528"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 22:57:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7146296"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa006.fm.intel.com with ESMTP; 26 Feb 2024 22:57:35 -0800
Message-ID: <07bce1eb-85cb-48be-9e46-8e9d075f9452@linux.intel.com>
Date: Tue, 27 Feb 2024 14:51:40 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc] iommu/sva: Fix SVA handle sharing in multi device case
Content-Language: en-US
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, jean-philippe <jean-philippe@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, "Zhang, Tina" <tina.zhang@intel.com>,
 kevin.tian@intel.com
References: <20240227064821.128-1-zhangfei.gao@linaro.org>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240227064821.128-1-zhangfei.gao@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 2:48 PM, Zhangfei Gao wrote:
> iommu_sva_bind_device will directly goto out in multi-device
> case when found existing domain, ignoring list_add handle,
> which causes the handle to fail to be shared.
> 
> Fixes: 65d4418c5002 ("iommu/sva: Restore SVA handle sharing")
> Signed-off-by: Zhangfei Gao<zhangfei.gao@linaro.org>
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
