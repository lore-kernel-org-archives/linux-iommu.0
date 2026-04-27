Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0733491C9
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 02:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777258343; cv=none; b=bDhZ4T/m5BOjy0463UFP1zc/m4juwkm5ET6fHm8uiiNfTGMnvuHTM1CjWkcFtBZYsit10GcwZWnQBBamKgoIJ1nZ/K3U3ZNgXji1zzQ768HvJcnzLCpowkgYAKV7x6LVHwY4Rtsnzp+NNOAbmexYzDtgSOm1qKzUREJRp/7sli8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777258343; c=relaxed/simple;
	bh=5K890k43fSGDs5OQFvhgRIAUsdK6dg4lU2yHeHe5nNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/bFklwvLP0UQhJAptm0U0dWrY3KrI4fhVsrKNB0CyPEHV83GfrZRolwv5Cx4bLt4NYV3zNQ2Mrr4107/qOAFMLr1V2yGWc4LVkETh+JnFwRWo1ApaWrbpX7NqyURB0swdacAQ7NMXqUKW8aMH5pcv1LwnGTEhbNyBM0xPQjqUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dqdX1fx2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dqdX1fx2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777258341; x=1808794341;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5K890k43fSGDs5OQFvhgRIAUsdK6dg4lU2yHeHe5nNs=;
  b=dqdX1fx2V7kVazTeUxwKlgGp/rxJ9WP45apAImecvWQYZaOrsZ2uR7B/
   Xg6GwGVM3sUxZG7TZtx0e2Une2OFT3D9znMxASWd3J2r6sw1k88jAuq1y
   q9nclni1HX1tr5NqJhpQwFlWjhx4Psv3JsJ6wVTfU7yAv++im4f0K2zg2
   96QYjby7KjMcSITW/kHnBuK4d3/K2z43AV0oBeS6Rn62CbALoZm94WfvI
   itpFdQGTNx0gucl7thuv5/29zMsawyjbgnIBtlazwfZpUxrfNoqlKdJFq
   ZQML1osWyWeHPu8iMEp0w0ExVRbLDR0ytJ3z/9/py5y+ox4jPMEON3Zh9
   g==;
X-CSE-ConnectionGUID: iXnSI0hiTEuAwct9gz0CoQ==
X-CSE-MsgGUID: QCFNfJxUT1eAY1NsoMjeKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="103602360"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="103602360"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2026 19:52:20 -0700
X-CSE-ConnectionGUID: YzHfUQ+QSpaNwVwFMdnfhA==
X-CSE-MsgGUID: vbWdAf0tQwKCdEfTCg5VqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="230323037"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2026 19:52:19 -0700
Message-ID: <9157ae81-2663-4fc3-b7ca-265fa3d00936@linux.intel.com>
Date: Mon, 27 Apr 2026 10:50:08 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/pages: Fix iommu_pages_flush_incoherent() for
 non-x86
To: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, robin.murphy@arm.com, will@kernel.org, jgg@ziepe.ca,
 kevin.tian@intel.com
References: <20260424115051.2082174-1-smostafa@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260424115051.2082174-1-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/26 19:50, Mostafa Saleh wrote:
> The dma_sync_single_for_device() function expects a dma_addr_t, but
> iommu_pages_flush_incoherent() was incorrectly passing a virtual
> address.
> 
> Since iommu_pages_start_incoherent() enforces a 1:1 mapping between
> DMA addresses and physical addresses (checked via WARN_ON), we can
> convert the virtual address to a physical address before passing it to
> the DMA API.
> 
> This also  matches the behaviour of the other non-x86 in
> iommu_pages_free_incoherent(), which uses virt_to_phys(virt);
> 
> Fixes: 36ae67b13976 ("iommu/pages: Add support for incoherent IOMMU page table walkers")
> Signed-off-by: Mostafa Saleh<smostafa@google.com>
> ---
>   drivers/iommu/iommu-pages.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
