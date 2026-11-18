Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009163;
	b=RYfr24qnFSjwgAgjxd+qyYQcGc+09bAkVzuBotwG4DuyGvALtLzIEzLxx01XI06ji6LK
	 8wfFMQ2ZV8dyR5ZsuKU92IBU5bnl24pNiN/oehbU8eupqjP1PP6WCuefUE9H9fE0cLHoA
	 w8rUTOoiWIHQ6zWIp6zHCfqsACCp8cE+0TqPPgGxqkzqLRVcyHCEkVGbCFn8aqit0bTG/
	 E/HLDzF3iH+wfQc7O3r11E+le2Msx/Kt2YLjeehHBUBU4gnx20ifRcU/B2hLU386+BENQ
	 91M7lgTpBjZ70qafU/LfMpwSB6HtMHbpZG4rtGzGVYgfZ461DHDnBXDBPmji+njmvVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009163;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=P5amnMFmkk1U32m2YD+GsUy1RT645N9p0/NZF3FHtFA=;
	b=e2EpJhqkYGZO2sDyLqvmXcTd+nK4ZXfqt/F/WHKAc2Ap582nO0vTue7nyBa8fnhH+C3i
	 jfSCLxmPn4dBbPWMg4wDr1W/hVdW8O44j3SjDBFHms3bikJPIHLBpXzntqJ6rTfxIGIXf
	 zM3l5aE10v0rtEWrQSVlm2UXnlvNm1ykL7nEeCml4Quvvn8R5lVyygUUsvFrPe/cJM/RW
	 Q6RfM94AFc+t0be6Y8nxGo+Y5plUoT0lpWV5QERSelJPRpcLPAFDHIcyJWLid6ifBOTYp
	 FqmHc9haJHuI/xWZgzqyZ87JJurwYNaH2tKlSV64arNbWHXcPD+ZTz3i/PWoBbBOe7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NW4kbaXL;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5B7606A333;
	Wed, 18 Nov 2026 13:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B5B7606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NW4kbaXL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795009163; x=1826545163;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A4iQEPFybw1sRbcxr5iH4nnAnGJWaKiX97qffwMmJIM=;
  b=NW4kbaXLG2Eqs40d95I8oxqG4PScLIFmIgGljmxJwe4aoNbEJqDGmN+s
   Rd4vL8QQJanE/SjBAgQmT1T9YJ9NinOMGtIePKO2T+uHXadJso2lSMJ7m
   H83NmK5BItHUnxluP2OWcrvv8sf/QchYrN/It5LAS/InNPqULp8/o/9ZJ
   nEamWxu1YpzRtkAcI/q3T4tNoUWS1tRXZ/WtjDqo36rJJNqR0Z1jSoUHi
   JdG0mUQhB4CJ9gGGy0O/Q9feHim5keg/3RX1YVsCSdNQexAxrUHucBAiJ
   U/hH0K+Tx2AjNlsmsZ9Jdz4GdHel8PMji9/2W6hqSC+k5xD5YdzAqGDrj
   A==;
X-CSE-ConnectionGUID: XRI8FYeYSLKgK4Jwau+Dpw==
X-CSE-MsgGUID: r/AXhdjSTmeMEIT8PN6afQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3896894"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3896894"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 05:39:23 -0800
X-CSE-ConnectionGUID: zqlSqNI8Sjaw6/B6bSzzZQ==
X-CSE-MsgGUID: bZrXZ01eQ8i3+sen5hIh7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10544232"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 05:39:20 -0800
Message-ID: <f2c46640-959d-4fb6-a313-0f907c127414@linux.intel.com>
Date: Wed, 18 Nov 2026 21:39:16 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] x86/virt/tdx: Read global metadata for trusted
 IOMMU
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, x86@kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, yilun.xu@linux.intel.com,
 xiaoyao.li@intel.com, Chao Gao <chao.gao@intel.com>,
 linux-kernel@vger.kernel.org
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-3-baolu.lu@linux.intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20261112043054.2664857-3-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/2026 12:30 PM, Lu Baolu wrote:
> Add support for reading the global metadata of the trusted IOMMU.
> 
> The trusted IOMMU feature is optionally enumerated via TDX_FEATURES0.

Nit:
The feature enumerated is TDX Connect, I don't think they are interchangeable.
Trusted IOMMU is part of TDX Connect, right?

> Check this feature bit before reading the metadata to avoid causing
> the entire TDX initialization to fail on platforms that do not support
> it.
> 
> The read value represents the number of pages required for the IOMMU
> metadata. The host will allocate this count of pages and provide them to
> the TDX module when it configures the IOMMU to operate in Secure TDX mode
> via the TDH.IOMMU.SETUP SEAMCALL.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  arch/x86/include/asm/tdx.h                  |  1 +
>  arch/x86/include/asm/tdx_global_metadata.h  |  5 +++++
>  arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 20 ++++++++++++++++++++
>  3 files changed, 26 insertions(+)
> 
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index d077990802b9..0ed0062c9b0a 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -35,6 +35,7 @@
>  
>  /* Bit definitions of TDX_FEATURES0 metadata field */
>  #define TDX_FEATURES0_TD_PRESERVING	BIT_ULL(1)
> +#define TDX_FEATURES0_TDXCONNECT	BIT_ULL(6)
>  #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
>  #define TDX_FEATURES0_DYNAMIC_PAMT	BIT_ULL(36)
>  #define TDX_FEATURES0_EXT		BIT_ULL(39)
> diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
> index f18e63b671c2..e5e54159ad36 100644
> --- a/arch/x86/include/asm/tdx_global_metadata.h
> +++ b/arch/x86/include/asm/tdx_global_metadata.h
> @@ -51,12 +51,17 @@ struct tdx_sys_info_ext {
>  	u32 required_pages;
>  };
>  
> +struct tdx_sys_info_connect {
> +	u16 iommu_mt_page_count;
> +};
> +
>  struct tdx_sys_info {
>  	struct tdx_sys_info_version version;
>  	struct tdx_sys_info_features features;
>  	struct tdx_sys_info_tdmr tdmr;
>  	struct tdx_sys_info_td_ctrl td_ctrl;
>  	struct tdx_sys_info_td_conf td_conf;
> +	struct tdx_sys_info_connect tdx_connect;
>  };
>  
>  #endif
> diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> index 9ab4d021017f..9b46f34cb469 100644
> --- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> +++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> @@ -139,6 +139,20 @@ static __init int get_tdx_sys_info_ext(struct tdx_sys_info_ext *sysinfo_ext)
>  	return 0;
>  }
>  
> +static __init int get_tdx_sys_info_connect(struct tdx_sys_info_connect *sysinfo_connect)
> +{
> +	int ret;
> +	u64 val;
> +
> +	ret = read_sys_metadata_field(0x3000000100000003, &val);
> +	if (ret)
> +		return ret;
> +
> +	sysinfo_connect->iommu_mt_page_count = val;
> +
> +	return 0;
> +}
> +
>  static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
>  {
>  	int ret = 0;
> @@ -164,5 +178,11 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
>  	if (!ret && tdx_supports_dynamic_pamt(sysinfo))
>  		ret = get_tdx_sys_info_tdmr_dpamt(&sysinfo->tdmr);
>  
> +	if (ret)
> +		return ret;
> +
> +	if (sysinfo->features.tdx_features0 & TDX_FEATURES0_TDXCONNECT)
> +		ret = get_tdx_sys_info_connect(&sysinfo->tdx_connect);
> +
>  	return ret;
>  }

