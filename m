Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADFC74040
	for <iommu@lists.linux.dev>; Mon, 12 May 2025 02:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747018082; cv=none; b=cs7SaSd5PveTjevJSuk5heanDywwBqHInntU4Jx1gncNEHIYtRtnoIzHJmZG295IgrTj6X1OsD8lxHv9wqZwkFwv1LhGUIYLTj9gSUPlG9/f4Zv3uyjxmoChGke9ROjdtZJchhmLthN9M9WnwPpFDSIf9iinMqQvXzLmrL1sdwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747018082; c=relaxed/simple;
	bh=YkcK6mn/altZN5LQp/Tf6R9mkFeK+cXtpkB7o19gGoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kbaVeIvos2wt8a2xGqWy/+avktDEmRVjTlC3XllpJRhEtZ49CB81NionuhHYCAuC1Y01TlXGP5ob54HWBN1JT7THGGBtKwd85wsfyuW2I/YS2kl1LbudfctdX8nhVRvMGlvUXducKB+tpc72yCHCDbuCDPwAIilYvxc+Sq5+KBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qncy88iB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qncy88iB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747018081; x=1778554081;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=YkcK6mn/altZN5LQp/Tf6R9mkFeK+cXtpkB7o19gGoI=;
  b=Qncy88iB/6mScX+F1NRUgyWo2KcACp3UTjbcrXm3HGP7Mvz35YxXCN5f
   uI8j4+F+rxP0Q8UlCgr8kjjoUnpiPaZ9Rp8NaCVmr0ijzXuaGkO5TNjSR
   CSsxDY8aKIrMnop0arMUl6GHZjJ8X4CkG1P9lBoK830jr2XTzvpmTAehY
   pvN5mq/TJFVyPZuGOPyEU5kBwKxgDW0/xDumYbvPic9NKyQDZoWU9q4aU
   M8sk19Si0Q4oQSBiMAkB7FnLHOpq+OWbRtS3n1PYNauTc9Xsvl5MacnpV
   czOX6rpJwqvFS/QtHA67oxv726kcfA9uBXUuty6sQMOp6IADxNwU2RvTq
   A==;
X-CSE-ConnectionGUID: OYnuP7QcRTGj9N2Zjn6d4w==
X-CSE-MsgGUID: CU9HLNIcR/WCvQTTv9bc7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="51454938"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="51454938"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 19:48:00 -0700
X-CSE-ConnectionGUID: SHZMynSlSH6XXrLOix3m9Q==
X-CSE-MsgGUID: bsp7XzVSR1uMwfvLBW8yJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="137166684"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 19:47:59 -0700
Message-ID: <e8608bf9-45d6-4627-9a1a-88be0ff55cd3@linux.intel.com>
Date: Mon, 12 May 2025 10:43:24 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] iommu/vt-d: Fix ATS support check for integrated
 endpoints
To: Wei Wang <wei.w.wang@intel.com>, dwmw2@infradead.org,
 kevin.tian@intel.com, yi.l.liu@intel.com, jroedel@suse.de,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250509140021.4029303-1-wei.w.wang@intel.com>
 <20250509140021.4029303-4-wei.w.wang@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250509140021.4029303-4-wei.w.wang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/9/25 22:00, Wei Wang wrote:
> The VT-d spec states that "SATC reporting structure identifies devices
> that have address translation cache and that is validated per requirements
> described in the 'Device TLB in System-on-Chip (SoC) Integrated Devices'

This is a spec recommendation for hardware implementation of the trusted
ATS. I recommend supporting it alongside HPT support in the mainline
kernel.

This 1/3 and 2/3 look good to me. Thank you and I will queue them for
next.

> section. It is recommended that system software enable ATC for this
> device". It is possible for an integrated device to have PCI ATC
> capability implemented but not validated per the requirements, and thus
> not appear in the SATC structure as recommended for ATS enablement.
> 
> The current implementation checks ATS support for integrated endpoints in
> two places. First, it verifies if the integrated endpoint device is listed
> in SATC. If not, it proceeds to the second check that always returns true
> for integrated devices. This could result in endpoint devices not
> recommended in SATC presenting "supported = true" to the caller.
> 
> Add integrated_device_ats_supported() for the integrated device ATS check
> in a single location, which improves readability. The above issue is
> also fixed in the function via returning false in that case.
> 
> Signed-off-by: Wei Wang<wei.w.wang@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 42 +++++++++++++++++++++++++------------
>   1 file changed, 29 insertions(+), 13 deletions(-)

Thanks,
baolu
