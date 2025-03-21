Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D133D2FB
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 03:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742527114; cv=none; b=gsNio5E2qf4u27crwcrFsgX3ynoalMi9y+1kkSo95UFBh7bKN2bBrsflrCGhYUaWiO9S2crkSVm89szEmgbhNqvr51FFCJWDGBQbENM3uvR8bbZl9PQxOHq9DDqaEoyv1r1TA5wGJleac0+Zu+bwivr68+f040yYQ3ABxP3MoQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742527114; c=relaxed/simple;
	bh=Gi0UOdfpOqPWxIXYSExKgv20uhAtDQBBEMbgQMpiLNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CvSBH/0cEGJDSxquLjvP4FUgBWB4doGgRDkp+fsR6xw7l4Bnq9zsRcDsh+va7h5BCqKPtLLgQXK8LzUFMHmFHl0jMWQerW/82h0UKBtpObl5cYH1XxKqkgWXbUx/66F6ZsVSIJL6+h8oxSAXRry0VL/w3HZTNO236/g3D8NwEqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K+BJoQLh; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K+BJoQLh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742527112; x=1774063112;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Gi0UOdfpOqPWxIXYSExKgv20uhAtDQBBEMbgQMpiLNY=;
  b=K+BJoQLhQBtjLrSyv9whR1ScQsiEuVg/aCenrAwlAyGgd6shnY3rkx9H
   rYgoa3SNNeBffDhYL0UdonOeo5aLtT0U7oINEK3HomYRdRhPVwLdVwyll
   lgkhkCoYjeK4Y5SOiPpaYgKFsy+HPeob255DQvJGbklLI2nJY8kDfhVx0
   6Klj4SgWMAp3lMpelQKoqO35Nnnr6Q7s+Fiz50cN4JYjv5nncFWN0aAh3
   zloO0wFx6FKPELhH+1OQWt/Pj+SSwpEfWZaaOR+Z5FtRwo4DPOT/LGM8/
   WkU+hDM6WmvZBpUAglROz6C1U0li5fBY6yteM7Uj8kg97QKvLyWlRgV8P
   w==;
X-CSE-ConnectionGUID: tQNVg2HTTpa8Qy/RzQT+cg==
X-CSE-MsgGUID: 0D6LVh1xSJOY52HLTvfJ6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43516007"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43516007"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 20:18:31 -0700
X-CSE-ConnectionGUID: xMo+rPH6TZqLvM5JbqnlTQ==
X-CSE-MsgGUID: zRRZUyHfQfmn08QMGj600Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123733084"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 20:18:29 -0700
Message-ID: <a832adb5-6eaf-43cd-8668-a3da4f66ec0f@linux.intel.com>
Date: Fri, 21 Mar 2025 11:14:58 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/18] iommufd/device: Replace idev->igroup with local
 variable
To: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, jgg@nvidia.com
Cc: joro@8bytes.org, iommu@lists.linux.dev, nicolinc@nvidia.com
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-6-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250320134744.5777-6-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/25 21:47, Yi Liu wrote:
> With more use of the fields of igroup, use a local vairable instead of
> using the idev->igroup heavily.
> 
> No functional change expected.
> 
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Nicolin Chen<nicolinc@nvidia.com>
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
