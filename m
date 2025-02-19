Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012A71A8F74
	for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 06:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739945182; cv=none; b=EUl4bb8C+ydPsYCkYvwu255vwVHXDzPkYDXK+Ewu1tiAUOz7usGtSxWILyeQk5oNtJBsF/Ao33qvtClSb1uCjGbQkM/3rlHz9PyNeUs560Zk2xRlHmZFvaPmCVOR8FstHosb+5/OjOW6kOGnkHTBUJgw1vOTl1Ecr6UWQKMZU9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739945182; c=relaxed/simple;
	bh=Q0vDJ4/yiYVAbhNp0b6zWsQL6kY+rh0THMX+K0cEdWY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XpQGU239i7rJIWEVzXllmlJdodgMpzcmN31ydp4ZrDcHcTzbknwMZxkiPONNUSHXccEcnmj1fkfvB6s4OAOe5GChj8nB1ySCsOa2WIC4He0RmIkeVhzOGp7Pz6WxYvkGTjgLFJuTLQ+e5ACMkNDtUFwrdwe4TSTCpa0OkTVG05s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SmChwW+U; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SmChwW+U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739945179; x=1771481179;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q0vDJ4/yiYVAbhNp0b6zWsQL6kY+rh0THMX+K0cEdWY=;
  b=SmChwW+UmDcmJ27gFoMzP63Zs2wGPFjMPjQtSK/5vYF++sd9+fb9oXim
   4NEia2nM6F7DOxl+7FxeVVtzKbxCP2JZiGhupqAjjy5YkFQiWt2mXB5la
   GJ/J+sF8SOidqVwwYesRwOdou0AqK6tilpCM5km1DL4qfOWUVlCoGtJqM
   ya7cpcndj+kG+bV8pSpbN4JE9yNGkDTn2nKEOhZQ+WiIXUvpCwitIxlLX
   KnoJi+goe9czpwAdsav6YVcDLzF+kmCgS6hvU98J1orWBu5mXRJeNbjqR
   szvb0dKqrJ5ZgpirKzs8yj1qUovZ6VcL0EZBXiScmmrDSHRHkedsHgYL9
   w==;
X-CSE-ConnectionGUID: UWryua9fQx6C8xQNBaHJFg==
X-CSE-MsgGUID: BBzk46wcTnqcsVRbK4L1RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44316090"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="44316090"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 22:06:19 -0800
X-CSE-ConnectionGUID: d+QKcR/OSi6tLcQA+DoR8A==
X-CSE-MsgGUID: MHlpaKrSTlC7nHsJBJ0nAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="114469593"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.17]) ([10.124.240.17])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 22:06:17 -0800
Message-ID: <c3d31f11-2a27-49a5-9e80-087a98d31cce@linux.intel.com>
Date: Wed, 19 Feb 2025 14:06:15 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH 00/12] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Jason Gunthorpe <jgg@ziepe.ca>, Zhangfei Gao <zhangfei.gao@linaro.org>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <CABQgh9FMy7oVt9+enSpJxXvkux+czMFqbsPZVgmBV+rFWWvhGA@mail.gmail.com>
 <20250214125600.GA3696814@ziepe.ca>
 <CABQgh9FQYe46hfjcs+o6GfLaS7OfSqrmvXUzOKd6PRK8oBF8Jw@mail.gmail.com>
 <d578bf4c-f475-42bf-9cb8-21941fc7af88@linux.intel.com>
 <CABQgh9EG3gjtw19qvr7OhxKmR8E6+xwBf9b3=WPNrXRc-m9DjQ@mail.gmail.com>
 <59998dcc-9452-4efd-be69-d95754217633@linux.intel.com>
 <20250218135751.GH3696814@ziepe.ca>
 <CABQgh9F8BJr_bkEQD6s6DSsLw2jwpgq-p73YL=439_WwH8P5zw@mail.gmail.com>
 <20250218165312.GJ3696814@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250218165312.GJ3696814@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/2/19 0:53, Jason Gunthorpe wrote:
> On Tue, Feb 18, 2025 at 11:25:59PM +0800, Zhangfei Gao wrote:
> 
>> I have tested it, and it solved the issue.
> Great, thanks, Baolu can you updated the patch?

Yes, sure. Will be included in the next version.

Thanks,
baolu
