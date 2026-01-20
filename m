Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FA236999B
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 07:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892522; cv=none; b=JtQBeU4PWrRONXN7ytb0xLmGRGZOQbT0Yo6L8hfo0wqL4lG+t+pwcfbaycyAKNBnLrA+bKBAb/8W8r/BV8Jzx+6OLmJTT73eEdMHvBX70h3JtlzD00aiiDXGNYYydAlY3pG014J3NaqPRXzJlwRq2eGI7ATwCTwXES+DHBBZXII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892522; c=relaxed/simple;
	bh=+HkME0g9l90Sr7977s1kVNayirvxXo1v68niPt8Hw/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WC4WezBIHe1OgiiXPqm9IZ3NnM67T4/rC2IHPHhHcaPmKAxBZFDrEeCFFbsUTUXtOBDgCMi2kjRzdqF6OiST12cuCgqr1PsCz/oAXVY5g1Eqro1bC3nS2Xwx+2BHqrCxSY2KkZlmQZWlB9LBi496PuiUbJpwq6p/wRwtSYfOVvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J89uTUUG; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J89uTUUG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768892516; x=1800428516;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+HkME0g9l90Sr7977s1kVNayirvxXo1v68niPt8Hw/8=;
  b=J89uTUUGbcwJpFq6dddOAOWf1OzJ9oxqcjzGK9fsyV/D3YtpeR656Y1B
   J70+RRZnR3GO+lmgAZC+Ia5HihRNXlIAb5VQnj4U529zT0cjvOISu5ceB
   17cjxx5OUbQuM3Br7XchmuT6eAX4BlsCkgjoNSzW8nitQe0wYr3Ulixuu
   XJVjHYUFPUklNjeKaG/vyO39qNj2UaqYnfqEJSjhRd2NHgrfRPcmQiAkP
   q3d8Ha78r/IFotgdaIxpPuANwrM/kYbT0ty1BirfT3URmxGXdhI9lbqkd
   Q8vpqrXJRAimYlaW9wt2dKVo8ga6yCn1/wvKvjztTorygT66+OQ+Iaic2
   g==;
X-CSE-ConnectionGUID: r1Asd/4xRO2vfifCi5Xkdw==
X-CSE-MsgGUID: 8Pfa179eRLu/iSEZeLrI3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="73958435"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="73958435"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:01:51 -0800
X-CSE-ConnectionGUID: Z6TmK4sZQ2SmL7sWeijtGA==
X-CSE-MsgGUID: 8d3FP9cdSwyjG+IQdwJS4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210181437"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:01:47 -0800
Message-ID: <69866166-32ce-48a7-9429-c6b77afa6eb0@linux.intel.com>
Date: Tue, 20 Jan 2026 15:01:43 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/vt-d: Flush cache for PASID table before using
 it
To: Dmytro Maluka <dmaluka@chromium.org>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 Aashish Sharma <aashish@aashishsharma.net>,
 Grzegorz Jaszczyk <jaszczyk@chromium.org>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>, Kevin Tian <kevin.tian@intel.com>
References: <20251221123508.37495-1-dmaluka@chromium.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251221123508.37495-1-dmaluka@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/25 20:35, Dmytro Maluka wrote:
> When writing the address of a freshly allocated zero-initialized PASID
> table to a PASID directory entry, do that after the CPU cache flush for
> this PASID table, not before it, to avoid the time window when this
> PASID table may be already used by non-coherent IOMMU hardware while
> its contents in RAM is still some random old data, not zero-initialized.
> 
> v1 -> v2:
> Add Fixes: tag.
> 
> Fixes: 194b3348bdbb ("iommu/vt-d: Fix PASID directory pointer coherency")
> Signed-off-by: Dmytro Maluka<dmaluka@chromium.org>
> ---
>   drivers/iommu/intel/pasid.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Queued for iommu next.

Thanks,
baolu
