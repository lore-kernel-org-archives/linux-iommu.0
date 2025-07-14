Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A29E17736
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 05:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752469298; cv=none; b=Nsce/pcd3rN2XX0Ejvz82Fx+wmIUcNMtQU1aw1Y+fC5RoPp7vde/wEGR870wldL+SobbvUzILfcll1IRInYdyhHEKEjdrkko1n0GpJCU93SxY36uBdna3RfU7AU5Tmbsp7Y7WSWAES/oWasQ0LU/5OfoYKUmjd4xzm/bsGizbEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752469298; c=relaxed/simple;
	bh=iedqWXXc29ebPMBnvx7D68L+yu2KdGdPjWBeZMUQXlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOY39VnarFlYrwigfB2GRZOl4CEoInMDYGmhbossZDliiicjmSx30uWPUI2j0UQipWGzYtxr3O5TcqQaHd0ZrrxZ+oKaYlj94fah3NpexdK57IXhno3YLsHXG+qCD8tkoTW9EzLS8mhiffwNac90sn6WlhxQNWcqF0jKMz5EGRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IPFP+ZsM; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IPFP+ZsM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752469297; x=1784005297;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iedqWXXc29ebPMBnvx7D68L+yu2KdGdPjWBeZMUQXlg=;
  b=IPFP+ZsMtR79Yvhi5ypSRwhzzuTqKN/+aUblzUGr78l/QFBhvJy2cG2X
   WVrXMAWSO8HK//3aAyg3SDU2quLV23IvPyfgM09r8Q1bvHfkNkEy2tnhg
   6mqmbE9wjiSvBhAe/tmMakhZ/5Ukx81r3ptPalNdB1d88VxPotz0muz3K
   gRLRm0p95vaAMHw58Ik7oBV185dOTAj6PzSDtuC1tD0BM3uerBJ+CYvbS
   eOxshW/1dBqxDLffOSLjVVU+rxcJ1OCDGHwsfYw+LlVvYyjSzzW27wuwD
   Mq8/doIi6QoBivWR/8zYlSZ4X3qiTTAj4RBU2Q1nH5czDuDuNMZOvkvTY
   w==;
X-CSE-ConnectionGUID: fgPv6KpkTGef68TQFq+X6A==
X-CSE-MsgGUID: 1gfBdoj8QjCZ87Phw1/IvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53765506"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="53765506"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 22:01:35 -0700
X-CSE-ConnectionGUID: /27e7M7tQW2TpifMLtzU+w==
X-CSE-MsgGUID: cYW4fiZwS2+Eqz53LvVTrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="157185063"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 22:01:34 -0700
Message-ID: <a91ac342-f0ee-4667-8135-adcedbe7221b@linux.intel.com>
Date: Mon, 14 Jul 2025 12:59:46 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: remove the CONFIG_X86 wrapping from iommu
 init hook
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>, dwmw2@infradead.org
Cc: fujita.tomonori@lab.ntt.co.jp, iommu@lists.linux.dev
References: <20250616131740.3499289-1-vineeth@bitbyteword.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250616131740.3499289-1-vineeth@bitbyteword.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/16/25 21:17, Vineeth Pillai (Google) wrote:
> iommu init hook is wrapped in CONFI_X86 and is a remnant of dmar.c when
> it was a common code in "drivers/pci/dmar.c". This was added in commit
> (9d5ce73a64be2 x86: intel-iommu: Convert detect_intel_iommu to use iommu_init hook)
> 
> Now this is built only for x86. This config wrap could be removed.
> 
> Signed-off-by: Vineeth Pillai (Google)<vineeth@bitbyteword.org>
> ---
>   drivers/iommu/intel/dmar.c | 3 ---
>   1 file changed, 3 deletions(-)

Queued for linux-next. Thanks!

--
baolu
