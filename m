Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCD118C907
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 03:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740627049; cv=none; b=MjQA2m87+l+6Q/PaDWPLfWZ7cihQrEL2wsy4px/DN23sj2jxw6gM5lpIqcsTies45HTDPRKcjvnhYWSlSjWGFzzzvggpmhYEMIsH1m25i4qAmbTGkxjxaA2zD+xSNa6aYOBNgGdAe+8vagPz3y8s22F6LS/SRR60TCD8s0y5ApI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740627049; c=relaxed/simple;
	bh=yA0ZEtSvt+H6QdHS95/RRM2WexXG+gRtjJqzME2QPJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9MEPUMJxHxvogXV1MKoZysIdGgpwwhy2VTXgL+EGHJsU11pmOLGiqHQDES4SA6lq+qD7959k7FwM2A4VRdrrT6elMe/P54osJAzOTqNJh9rjLD49wB+r169fuGLvLloYTJkLxiwVKhf/5RrNia6m29wN3P9/AyWJnhNO+P/YIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CJYiDULL; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CJYiDULL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740627048; x=1772163048;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yA0ZEtSvt+H6QdHS95/RRM2WexXG+gRtjJqzME2QPJk=;
  b=CJYiDULLvbgxixUQ+YXSAo+VOZnqp+T7l2CPgbo+TpocP9qSgCU6UqQ1
   0S9iLCHfcMm2n0Hc6ehUTeSAbrlc+Gr3D1Q01oiqAaQFckBDTUhDfAxA3
   7+P7u1J0tgf1FJ1AqLT2T6fy0ll7p4uQNxpKFAkAjsW7r9DsCy9ZnG/Bf
   b83BqZWGeiOehg84pUfqX6eWfSJRsFNpz6tIvh6ojBA1tADVUQG6XcNt4
   xRjzF+P9WVA3E68S66WfhIk74wDBCFGVniorNAWFIFY0mXAqWcjCuOMwj
   gud+ur9HZUktDKz55sqlk446kGPufSddsol0YAGuyi2ohcCCA1k+WNcjV
   w==;
X-CSE-ConnectionGUID: qSpVEr1gQO2+Hg9LPRog0w==
X-CSE-MsgGUID: XwA0ZyMsTDCAUuoAqtXKZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45281687"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="45281687"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 19:30:45 -0800
X-CSE-ConnectionGUID: S8+wtgzeSaaqnAlWb/00Rw==
X-CSE-MsgGUID: HlnSqAJXRmWutIl7umIYuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="117070757"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 19:03:05 -0800
Message-ID: <0dd5b2d3-cc87-470a-bbdc-af78a9c1e8a8@linux.intel.com>
Date: Thu, 27 Feb 2025 10:59:49 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/12] iommu: Introduce a replace API for device pasid
To: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, jgg@nvidia.com
Cc: joro@8bytes.org, iommu@lists.linux.dev, nicolinc@nvidia.com
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-3-yi.l.liu@intel.com>
 <5c2d63d1-78ee-4466-9574-a6e4a2da8ee4@linux.intel.com>
 <5809773e-bcb3-42f1-ae0c-e509c589f9c8@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <5809773e-bcb3-42f1-ae0c-e509c589f9c8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/27/25 10:29, Yi Liu wrote:
>>          entry = iommu_make_pasid_array_entry(domain, handle);
>>          curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
>>                            XA_ZERO_ENTRY, GFP_KERNEL);
>>          if (xa_is_err(curr))
>>                  return xa_err(curr);
>>
>>          /* Not a replace case */
>>          if (!curr) {
>>                  xa_release(&group->pasid_array, pasid);
>>                  return -EINVAL;
>>          }
>>
>>          curr_domain = pasid_array_entry_to_domain(curr);
>>          if (curr_domain == domain)
>>                  return 0;
> 
> even if domains are the same, we cannot assume the handles are the same. If
> not the same, we still need to update the xa_array. Otherwise, UAF of the
> old handle may occur although I don't think current caller does it. Or if
> no old handle, handle needs to be stored.

Okay, fair enough.
