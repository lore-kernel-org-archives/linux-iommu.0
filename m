Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59FC200B89
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 04:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730176975; cv=none; b=b2Xm1trfHDihsj0ZKxZwaYgQaIFh/W8Cg5HG8UFLHFoqw18OnzXGd+9q5t+GOtpwmTut9+1MHXS02c2nUpglmUGuLti3ScHip/RMoZJIOlRbBr7SvB3dEF+k83wN9WaODquzi3h/UhNxQE2ahf7jHH9dKIs94aZcbh5krOWP/q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730176975; c=relaxed/simple;
	bh=FMv1SMzCCaIcu5A3KfXQYWBrzrewT4qJneSbHJ30744=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RXSTeRPFeNVzB44GJcm7p9COwDBlu8tsE8xpF9wiDw/ca7A6w3qwyOu7iaNuwQPshwDKWUBmkhWHOp95TzmQ62uBmgSVYGgQBvfgW45AR7pO3rIjUBVkkP2R4/yAvLWrmsEs9SI8w0DEURmx3cE2A6Lk4Sgg25x1zWp4OaDxzXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WyqkPQS0; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WyqkPQS0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730176975; x=1761712975;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FMv1SMzCCaIcu5A3KfXQYWBrzrewT4qJneSbHJ30744=;
  b=WyqkPQS0+X8CiE3CWI9Ya59WjeXofPHeTwuRbfLQ+/hBPxHValOtrYGO
   pSO8ZMBM2FR1LAMJ2C8kdo1tHkSahJbeOIClNA98UPp83zWD9kaRGTLZT
   Ca+LyrFvBQF4SdD6ocWTrFG4+8EZbEZb6HXbF4H3UHqg0D+l0R4iJkC2C
   x/gbGongDZaZdgUkKev1DVSWyKnsX6qHlJ3ChcNyJp83w9qsCb/+EN2Nz
   ldjN87ILTyYfM+zK3Q6rfAzgfInye5Ku/TcXTZRfxuPKyyNScX9Zap/kO
   ry7o0HlqFEMc0h7C3hc2i3Xb1djljy0qwnNR74lYFRU0gIrWlDFQmc+CI
   Q==;
X-CSE-ConnectionGUID: yY349pf3SbaZZZMZqeOxwA==
X-CSE-MsgGUID: MOpQghd9SHiz/piU2mGCEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="41193944"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="41193944"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 21:42:54 -0700
X-CSE-ConnectionGUID: UbKZlTQPR661bfRfSnQn1A==
X-CSE-MsgGUID: ckFTUfP3SuisHj6b1rhVyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82161920"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.238.0.51]) ([10.238.0.51])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 21:42:51 -0700
Message-ID: <2551f5b6-a1f3-4d4b-a17e-3451bdabfa90@linux.intel.com>
Date: Tue, 29 Oct 2024 12:42:48 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, dwmw2@infradead.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, chao.p.peng@intel.com
Subject: Re: [PATCH v3 0/2] vtd: Minor cleanup
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241024092146.715063-1-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241024092146.715063-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/24 17:21, Zhenzhong Duan wrote:
> Hi,
> 
> This cleanup the vtd dump code to dump lower entry after check current
> level entry's present bit. Also fix the print to avoid confusing.
> 
> See patch log for details.
> 
> Thanks
> Zhenzhong
> 
> Changelog:
> v3:
> - Fix a missed check
> - Refine commit log further
> 
> v2:
> - Add Fixes tag in patch1 (Baolu)
> - Refine commit log in patch2 (Baolu)
> 
> 
> Zhenzhong Duan (2):
>    iommu/vt-d: Fix checks and print in dmar_fault_dump_ptes()
>    iommu/vt-d: Fix checks and print in pgtable_walk()
> 
>   drivers/iommu/intel/iommu.c | 40 ++++++++++++++++++++++++-------------
>   1 file changed, 26 insertions(+), 14 deletions(-)

Queued for v6.13. Thank you!

--
baolu
