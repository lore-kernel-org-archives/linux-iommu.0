Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7923603D3
	for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 03:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785294110; cv=none; b=g/R2Uha5HoIyhYe3PaPiPQdlS+l4/lbylzXX10YZcCmhVpUZBMZZp0xGvznxjNYcAXjsRZf7v97qEiC5c1PWjHvp2netqxe2pn7rGav9rumcoVYYtcrcQaXDZ7g2Eaf4i5TVNTneDzODX7884lxUZdwwvBNv6Sm9ZVGpOoS4qdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785294110; c=relaxed/simple;
	bh=B8JCgPdcNvl/rmF+wcs8jZsX3BvWk+dF83UlnPEBmgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+qIVKypsNMMtzP+5GSCTnIyBxI89yEpJzP/RAeDAbC0OrkORddoN6NC3/oEUf5ssQqS1ZsNGJZGDZg1mu+pg9R5pRT+YIZE2hJrLwWYKVHOZ7utP6sIxXqSg94kk/Gy5XqvH7XWsncPAFT9uIIJlaqlUSCTSfjIBfpzPQHkNfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aUkNkCMk; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aUkNkCMk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785294108; x=1816830108;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B8JCgPdcNvl/rmF+wcs8jZsX3BvWk+dF83UlnPEBmgw=;
  b=aUkNkCMkk+M06+bPLErrqcxBSwnsMm6QR81J3kOSQ3fgheQoZcvKGNxW
   mfnKP6M15+T67PXyfhMjyf3aPGMFhMYDBAXvry9bho/uJFcjjLSVx5PGV
   QekoNIUGk+rBuDKSjmn4CP9/znNpmKh35CPvGvUg/9+4AQr5m1qks/k6R
   IU7BWsuysfu15aBOcmUHz3tklDqJEK3tuoaDYUZJcBx92ft42WjYswLWp
   0MOSgCQEkBAl0e4iCT5h+Q9qsauvNuhT31BrYo1UpmC7QyLenYYAAI1ej
   RYTzJmj0MsrEJptTEMCAq1ioMqydT1VjbkMSDzRfnAZeZwi8DVdittxzs
   A==;
X-CSE-ConnectionGUID: JzoGvSqMTbuATRG2ri+Geg==
X-CSE-MsgGUID: WAFx+OsuSIq6WLPEaanxYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103298222"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="103298222"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 20:01:48 -0700
X-CSE-ConnectionGUID: QIyjsvblSXKpeRaNDN6ikQ==
X-CSE-MsgGUID: /1r5axWwRkmsDMdGAq3c4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="259947375"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 20:01:45 -0700
Message-ID: <a28064f2-b302-46e3-9438-45d83092167e@linux.intel.com>
Date: Wed, 29 Jul 2026 10:59:52 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] iommupt: Return zero for invalid iova_to_phys()
 ranges
To: Shuai Xue <xueshuai@linux.alibaba.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, jgg@ziepe.ca, kevin.tian@intel.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 oliver.yang@linux.alibaba.com, zhuo.song@linux.alibaba.com
References: <cover.1785050951.git.xueshuai@linux.alibaba.com>
 <90a86345b06d43437592da48f1d624c748c4d4ad.1785050951.git.xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <90a86345b06d43437592da48f1d624c748c4d4ad.1785050951.git.xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/26/26 15:43, Shuai Xue wrote:
> DOMAIN_NS(iova_to_phys) returns a phys_addr_t and follows the IOMMU
> iova_to_phys() convention of returning 0 when there is no valid
> translation.
> 
> make_range() returns a negative errno if the input IOVA cannot be
> represented by this page table format. Returning that errno directly
> casts it to phys_addr_t. Callers treat zero as no translation and use
> non-zero values as physical addresses, so this can make them consume a
> bogus physical address instead of seeing a failed translation.
> 
> Match the page-table walk failure path and return 0 for range validation
> failures too.
> 
> Fixes: 9d4c274cd7d5 ("iommupt: Add iova_to_phys op")
> Cc:stable@vger.kernel.org
> Assisted-by:Qoder:Qwen-3.8-MAX-Preview
> Signed-off-by: Shuai Xue<xueshuai@linux.alibaba.com>
> ---
>   drivers/iommu/generic_pt/iommu_pt.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
