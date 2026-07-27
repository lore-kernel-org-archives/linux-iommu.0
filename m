Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C833955C3
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 02:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785120528; cv=none; b=T1pMSwnTNmC7awc6lgjfN/0siCwVXnHLTkRCs+k+Wbg+aPqwrnW/HZv+9fnB1AMpeuPdMn1ecQt0zkLC3y3Qxi+NLt9dM7BHzgSopqAZ5VSw/UKC/cl03si+Va7K5EleqqgmyIil9b94s/H9x5eVgGaSibzbvGfWnf9K3FS35Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785120528; c=relaxed/simple;
	bh=qMwEESXvGtyVm+remj+8+MQfVPUmxaaPjv1GlF1RnXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VPhMV+TQEAHjjp4YQDsHA3preEg3NGAHJH6wNYEhaMXue8Y9E/ZgC0LHC0RLHDTs3MP7aiN1lX9/B6uzCpreyExUT49J6yByuckGdpejDGJX349gMJJ7wkS+6Z/8YPtupXRk88vfNmFzZ886F9x2oLJe3yF+CbK162Sm/XHCTYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WUoJo1yV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUoJo1yV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785120526; x=1816656526;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=qMwEESXvGtyVm+remj+8+MQfVPUmxaaPjv1GlF1RnXU=;
  b=WUoJo1yV49crGfoon+9PC+4PGFhB3gjvBJeBoaq+thN/ZFEJiNaUsa62
   TYi9KeAKqIbwfIEZvMTKSekdqahgiEq5kr9QAc4uaOgnyMbwV07LyIKZP
   LzR7yCkSohSuKk0MIA2FIBSBDF+H1aDKzKUBFoC4O8I7vKLR0gyTUVCRT
   bxBHmSj55myzvFm0T+LRoyGyrGZPFAC+hfvxtCtgdC4gtiMGvlBjSiNjR
   3IKRG17sIRJKRP/YBczn66mJ5qUMcz17WFn42MaEY772vIdqY3WpgXOMB
   TZLlBYAT8QE2hGXTN/OhGNl35KrCaEF/idGlEh3bfSFJqEmHPn+A6OidK
   Q==;
X-CSE-ConnectionGUID: oV5ql3AhTfCCU9nojbGnwQ==
X-CSE-MsgGUID: 4IUsAhZMTxapfC63WYTq2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="103095826"
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="103095826"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 19:48:44 -0700
X-CSE-ConnectionGUID: Zx3zTIz0RpO4OFbNscpp5A==
X-CSE-MsgGUID: ojoyWPoiTjifDpuxMCwe3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="255921656"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 19:48:42 -0700
Message-ID: <02e80e6d-7709-425f-8b00-bcdf38368575@linux.intel.com>
Date: Mon, 27 Jul 2026 10:46:52 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/intel: Use logical OR operator for privilege mode
 check
To: lirongqing <lirongqing@baidu.com>, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260605004053.1867-1-lirongqing@baidu.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260605004053.1867-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/26 08:40, lirongqing wrote:
> From: Li RongQing<lirongqing@baidu.com>
> 
> Replace bitwise OR (|) with logical OR (||) in the privilege mode
> validation check. While both operators produce the same result for
> boolean values (0 or 1), using logical OR is semantically correct and
> makes the intent clearer.
> 
> No functional change, but improves code readability.
> 
> Signed-off-by: Li RongQing<lirongqing@baidu.com>
> ---
>   drivers/iommu/intel/prq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Queued for v7.3-rc1. Thanks a lot.
