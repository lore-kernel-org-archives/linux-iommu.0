Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8923F2609EE
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 01:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763430386; cv=none; b=gkB4x3iwRn9WAHf32a9xq2oWXde7XxbUJepPo22ouy19qGoz9Kpo47MtPB+OD/2RgPo4/SVRzRcF8nT/gxYp6+Q1zhqboIw8nNYPVFnJfRTNotnA/sjidc3u8HlGSx+SjgC8ifFXTN/deoxiz+8GURZKu1x1NkARExANoxcDF3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763430386; c=relaxed/simple;
	bh=cAk31hXkBsUpjyCA5nW1ZMencioyoEDEGKnyOJAnA+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KeAkcifeyoAsoQ+6T3hEisgSpQ1PZ0rTlQ+m3AZIl/FijvyVmJ4pJ1ll/QBcNmXe46f2+eE5wnaky+YgdkVyWAVOPG1cuJV2Mjsw39H82AxqUgGKeKbMpZLG3WIZ2nqID8jz6G4zXvOXi77ylWzeN+HQmYgmITQVij5AwiLAYeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QQXxCFMC; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQXxCFMC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763430385; x=1794966385;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cAk31hXkBsUpjyCA5nW1ZMencioyoEDEGKnyOJAnA+w=;
  b=QQXxCFMCw6IQGicIv5Fk7sObYeIgkw3USmrFEsR/seiLl3vCnAcW6Edb
   ecwuUn0x0jcknLUGi5fqBgY3dQsCk+ZEJK/+ZMxoLVKR3bZL92QbfM1Ix
   qpqA0krpfJuC8+GHEcMjvB/qp2fqZ6cpMwutBtzzfonMFldwfOrskohdh
   VNy2vvOt7fQOPmoLzSslnrBzlJltD5HloEbJPs3FNt51QAPJHwZa6+OQZ
   Ikx+whWhQ8/PE7VhgGKVpmqFm32NBFfv7RuCDSRr45OJuxnmKhEdljWI9
   MFyfjEASfhLORlivWJddwxwl9TW8219/E9tQmCpCL2XB8eScwJI1i+ZzI
   A==;
X-CSE-ConnectionGUID: zztZH6qdQLGUMhOIzkyOzA==
X-CSE-MsgGUID: bGuf40KdTUacaildK40osQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="76795825"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="76795825"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 17:46:24 -0800
X-CSE-ConnectionGUID: vsqEJNkPToiCGzQbBQjlKw==
X-CSE-MsgGUID: cfnIIiV+R3adEqiCDe5AhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="191404472"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 17:46:22 -0800
Message-ID: <8cc26739-99bf-46bb-bf33-90b4ad0052c0@linux.intel.com>
Date: Tue, 18 Nov 2025 09:42:09 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: set INTEL_IOMMU_FLOPPY_WA depend on
 BLK_DEV_FD
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Cc: dmaluka@google.com, shraash@google.com, efremov@linux.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251002161625.1155133-1-vineeth@bitbyteword.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251002161625.1155133-1-vineeth@bitbyteword.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/25 00:16, Vineeth Pillai (Google) wrote:
> INTEL_IOMMU_FLOPPY_WA workaround was introduced to create direct mappings
> for first 16MB for floppy devices as the floppy drivers were not using
> dma apis. We need not do this direct map if floppy driver is not
> enabled.
> 
> INTEL_IOMMU_FLOPPY_WA is generally not a good idea. Iommu will be
> mapping pages in this address range while kernel would also be
> allocating from this range(mostly on memory stress). A misbehaving
> device using this domain will have access to the pages that the
> kernel might be actively using. We noticed this while running a test
> that was trying to figure out if any pages used by kernel is in iommu
> page tables.
> 
> This patch reduces the scope of the above issue by disabling the
> workaround when floppy driver is not enabled. But we would still need to
> fix the floppy driver to use dma apis so that we need not do direct map
> without reserving the pages. Or the other option is to reserve this
> memory range in firmware so that kernel will not use the pages.
> 
> Fixes: d850c2ee5fe22 ("iommu/vt-d: Expose ISA direct mapping region via iommu_get_resv_regions")
> Fixes: 49a0429e53f2 ("Intel IOMMU: Iommu floppy workaround")
> 
> Signed-off-by: Vineeth Pillai (Google)<vineeth@bitbyteword.org>
> ---
>   drivers/iommu/intel/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Queued for v6.19-rc1. Thanks!
