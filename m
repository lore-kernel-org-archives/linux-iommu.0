Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE091DFF0
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 06:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294324; cv=none; b=Scmf94m6pSJDuCePC/Zq3sJytTMgy0BvkM2Z8Uvmi1dHFzV4xJrc9FQ+M79uFtcPcxDZHUoHP8yus700OMQih61ZhxpgyNCq+6A3UN5QOs5fYzwBEgTJQPsKSQtyr1bufyC6uIGi5MXCi6Mbutb5dPIS0wNdHu7KtMZJi39KohM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294324; c=relaxed/simple;
	bh=XuRoZY1M5qVJCyfSDEK16Q75dbFHzP5bA7re1g/Vdcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oi9o51nF0MHYiAqDfm0b7jjOfh/CuLL0zzrWJDJWKP3CCejZqPdF0ngeWGw3EL4nLm/KH3zYQF5UtpC49U40lbdfny19E/T8Re1H7LLepbAHBXnE90uNq1NqFp6aDRcsJKODG2klULKblb/0Fjm86ioQM4IT6LdKdy/hiNMOZac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lnR8CQ44; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lnR8CQ44"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780294324; x=1811830324;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XuRoZY1M5qVJCyfSDEK16Q75dbFHzP5bA7re1g/Vdcs=;
  b=lnR8CQ44juu16R34JxWOoqBtz+qvTO2fXOtwnuiM/aD3RdjkgRyI48T7
   wHewDye+5XjcUgF6dOqnZ+1jSyEaKZpzGTYAEeTb9emqFpMpgYiAJg/kJ
   bkw7BP2x9bZp+GSEdUvYhBkVY3I/+EqZszYmtvlLzj7s0hYsTVejBrc/F
   aBrvVPEAc7B36UvTtY4CLhsXChGTGErG0cJvA5nTCP1pGzQYvtMZliGMW
   0Q/1YA9qC28mj3AWmiE5QcQ4zxRLgoZ85BG6P1+jur41yvJTlq5QCuNXp
   EZzo5JeSRpbye++eIC2R9OCjJiJmTGQZTBY5wYaCr6qR7epv+ra8p54mI
   A==;
X-CSE-ConnectionGUID: w97aYZmHQb6Yi+nufWGhKg==
X-CSE-MsgGUID: QdaiSfKlQb2h75zr+sGTog==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="91354776"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="91354776"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 23:12:03 -0700
X-CSE-ConnectionGUID: tXZhua9lTxOk01+MkX/+/w==
X-CSE-MsgGUID: FGCALYNqQ6C2XMOYHfMfqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="242662778"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 23:12:01 -0700
Message-ID: <a600e838-9ef0-494b-90ca-3c522584ebfb@linux.intel.com>
Date: Mon, 1 Jun 2026 14:11:09 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/vt-d: improve IOMMU fault information
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: xlpang@linux.alibaba.com, oliver.yang@linux.alibaba.com
References: <4adaa6b9-6dc0-4d78-8eeb-dbe9059e76a8@linux.alibaba.com>
 <20260528022943.1697564-1-guanghuifeng@linux.alibaba.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260528022943.1697564-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/26 10:29, Guanghui Feng wrote:
> In some environments, multiple PCIe segments exist, and PCIe device
> information needs to be differentiated and identified based on the
> segment. When an IOMMU fault event occurs, the IOMMU and device segment
> information should be output in detail in dmar_fault_do_one.
> 
> Signed-off-by: Guanghui Feng<guanghuifeng@linux.alibaba.com>
> ---
>   drivers/iommu/intel/dmar.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)

Queued for linux-next. Thank you!
