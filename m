Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B7E3A4F50
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 03:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785121601; cv=none; b=memS3iuwnqNExJaFIXN576LmN/tS2n07DsIxh75OWV0jdwzI2epbxl0h4Bd7kxSQS00PbNSNu0SH85KhRCSAdIrg4OilDBCzQZ4vc6FgPfXforWk2ztCCovhgPHtpfXWpUNMDz777FlORbx6pQKaXo4EMZBDFswJkrre0pgOKJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785121601; c=relaxed/simple;
	bh=UMhIJ05AS2GGbHFkSkOUPbPFVrN21sq/uMpDwMhGGcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/tkhitbCIfKRyuUv2NuUP1dp/VcAwNpuzbYCnfzQJPrFA98PtExKqpEq6kKYWPABuf739I+y8ZpmuUmbJMKj/4/mupRKbMPqfGQbbXIMZnT8NdZE2SJaPw1cb24Cnn6MVx4xEhZZWH41sYWDXhzms1GY69i3scaznO37GAVp7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KmFzqNn0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KmFzqNn0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785121601; x=1816657601;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UMhIJ05AS2GGbHFkSkOUPbPFVrN21sq/uMpDwMhGGcU=;
  b=KmFzqNn0Tw5/jvGZgngTHm4vGzxRPikwI64PdjSM9BQqRfN28zB4PHSP
   ZCiTEfjn2EbFOSnHgqexP5ES4ZgAmcu8yDfmo4S3FhmyUBlnNxmUzui39
   lcuCNkfYas4mN+09WFbmf05V5TQ6/Esz86Gu3qf+5zqaXhtkZtB34D2je
   SQ6mc+gPmGZUqX740qlNCsK07v1578VJ5Z7PrSWlPRwTX+n5FJS+gZgoU
   JKzyD082MTXgNMmkXP6sCQG10c+XI3Lt28GQVbyFEqK7C4xLGIlbbFdiR
   Ia7yumbuuh+ymhfHb7AW/y/L5i7mo0DZFkiLpmXeGi9wjz8RqKg2mSXZy
   A==;
X-CSE-ConnectionGUID: XU1bKrQFSfep2YHmwu7CjQ==
X-CSE-MsgGUID: u52bpqvmS62FSWLp1Qpk4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="84664696"
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="84664696"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 20:06:40 -0700
X-CSE-ConnectionGUID: APUOnPj5RL+B8jwBlluTcg==
X-CSE-MsgGUID: 2wU+faQDRhur4ip1MqtmYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="262786740"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 20:06:37 -0700
Message-ID: <00e3ab5e-01c3-4106-9c1a-5dd190bcafcc@linux.intel.com>
Date: Mon, 27 Jul 2026 11:04:47 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] iommu/vt-d: Support a new DMAR flag
To: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Chris Wright <chrisw@sous-sol.org>,
 Jesse Barnes <jbarnes@virtuousgeek.org>,
 Asit Mallick <asit.k.mallick@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260702061216.388743-1-kevin.tian@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260702061216.388743-1-kevin.tian@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/26 14:12, Kevin Tian wrote:
> VT-d spec v5.2 introduces a new DMA_REMAP_OPT_OUT flag in the DMAR
> table, adding another knob to affect whether the DMA remapping
> capability should be turned on or off.
> 
> While at it, first clean up the existing on/off policy messed with
> user opts and various force_on conditions in the first 8 patches.
> 
> On top of the improved framework, the last patch introduces the
> support of the new bit.
> 
> Some cleanups will be done after this series:
> - Cache dmar->flags instead of reading ACPI table multiple times
> - Check intel_iommu_enabled at runtime instead of using dmar_policy
> - Clean up existing warning messages (e.g. force_on panic message
>    always has the "tboot:" prefix)
> 
> v2:
> - Rebase to 7.2-rc1
> - Policy-oriented renaming to avoid confusion with runtime state (Baolu)
> - Warning message/comment improvements (Baolu)
> - Always return error for unsupported force_on type
> - No need to do platform optin if tboot already forces on (old behavior)
> 
> v1:
> https://lore.kernel.org/linux-iommu/20260604051540.592925-1- 
> kevin.tian@intel.com/
> 
> Kevin Tian (9):
>    iommu/vt-d: Fix no_iommu to disable platform optin
>    iommu/vt-d: Force requesting ACS when tboot is enabled
>    iommu/vt-d: Remove dead code when CONFIG_INTEL_IOMMU is not set
>    iommu/vt-d: Consolidate dmar policy management and force_on logic
>    iommu/vt-d: Use dmar_can_force_on() for platform optin
>    iommu/vt-d: Call dmar_can_force_on() for tboot optin
>    iommu/vt-d: Remove the 'force_on' variable
>    iommu/vt-d: Remove dmar_disabled
>    iommu/vt-d: Support the new DMA_REMAP_OPT_OUT flag bit
> 
>   drivers/iommu/intel/dmar.c  | 95 +++++++++++++++++++++++++++++++++----
>   drivers/iommu/intel/iommu.c | 78 +++++++++++++++---------------
>   drivers/iommu/intel/iommu.h | 64 ++++++++++++++++++++-----
>   drivers/iommu/intel/svm.c   |  2 +-
>   include/linux/dmar.h        |  1 +
>   5 files changed, 180 insertions(+), 60 deletions(-)

Patch series queued for v7.3-rc1. Thanks a lot, Kevin.
