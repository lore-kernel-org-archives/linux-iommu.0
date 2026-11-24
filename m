Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795499199;
	b=bz4OH7w/wBVlkYi3Q/OKSZXDZYpu19eXGsoewbKpMzOeYF2I/4jznJkmAuWSs/Fzoz+y
	 XAb9kXFBaEw5gP5hMUSfsdpMWM58sC3I6Ab8uki8hW2e8V2QwQHxsx/8j3IDoa8O+IIfA
	 7UdfIlzEgu+Lvvoq94V4PvfaGsAXD1JpQ+Q7uW7D2J8C14en5cROlb88GMwGNnjA/zAt0
	 UZp0qS3JXmMqhFbUf1CUr2AeqnNSxVEhkvmCXWZrGEuC+BFJ0wzX8cGyGO/N+weqxSDUh
	 hl0ww82kTtM6fkALYH+ZRYk6mRjtgV5ZxxvtZ66azbqp4k5RYPykmdbC8RXLrogNbdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795499199;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=jsMI+Ds46cM6xnlO1TFFO5B5dFdMLZbHbUi3x2wrsRU=;
	b=U+IJYzakxv3MDdAPdQewuiVM7JV0XGH5MCJTGrEiGeSjdaI2FJW+Icdi+lGK533AFEZA
	 kRb48n6KJJb2zM2tjnw/q2kEtvZEzBxb+o9nLyjiCvDGu7pG0ApPTb1INS9B8Yrv70X/3
	 ktgE5I73l2WvPDk4lyPK1giGR4LRI7KTn0bK6spr3ufrjRw7pAVrHZm4+PhDPGZq+9COJ
	 yEt4zpv2sfqc3KedbYzxDlSVkfGeLb2I2rF5YIOp6ihM/J+A+0zMs02pKLyZWYgkdxY2V
	 iBEREVbdC0SOhYwBVVaoI3ZBELIJyFAV5cx/n+KdOnz4UkegmxvIPlSuuNHW7bDMYYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a174nxv9;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1500606A31E;
	Tue, 24 Nov 2026 05:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1500606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a174nxv9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795499198; x=1827035198;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Rsqn8C+lyW0grTpsQkc/ILwRR9+emcI8MVVSWwxpppQ=;
  b=a174nxv9nJnMlsHp2InXEipcPHAM+iUMgWqdu2ejufO7MhiVwGXgVftY
   TXIFkIRvpDFQ52Gucv5cBBRl0nhafJ5XHIjN1WSXpb8XqmbIUi7jVk69x
   vaT8aBK7F4kXaSO2dXmh+25zac3Pz61fcHfeTaLW1mcz98Etn4r3+z1EI
   m8oDVTLT+159s713J/6C6Jr6jQWMLQoHLJ7sMlNYXMOipnX13yOF920ra
   Zw3dD2YQTQ8sx7CRTxO7mPYQEGPlsmBwEDsk1pUW+8tErYnTE1dsnunf/
   7HKlLflyqaVZoAWaNoNKe1YCau/Cj3Cj8ROtmZe5liVsaQVguw0r2rQlQ
   w==;
X-CSE-ConnectionGUID: aWbu9jeFT9+VGWHkMZbdzw==
X-CSE-MsgGUID: BDceRcNrQleTZextdBfoRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4207688"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4207688"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 21:46:38 -0800
X-CSE-ConnectionGUID: 1I3+CKVHSkultcLGWbpzKg==
X-CSE-MsgGUID: G8Z/XUfUTgy0S1A4expfiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="13272001"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 21:46:34 -0800
Message-ID: <ac7208aa-04a0-4fd6-bb32-b9478678fd19@linux.intel.com>
Date: Tue, 24 Nov 2026 13:46:31 +0800
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
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev, x86@kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, xiaoyao.li@intel.com,
 Chao Gao <chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] x86/virt/tdx: Add SEAMCALL wrappers for IOMMU
 setup/clear
To: Xu Yilun <yilun.xu@linux.intel.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-2-baolu.lu@linux.intel.com>
 <awQNpgjgIlwhXrqT@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <awQNpgjgIlwhXrqT@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/2026 5:55 PM, Xu Yilun wrote:
>> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
>> index 4cce77b6a31f..a1f35188a272 100644
>> --- a/arch/x86/virt/vmx/tdx/tdx.c
>> +++ b/arch/x86/virt/vmx/tdx/tdx.c
>> @@ -2567,3 +2567,56 @@ void tdx_sys_disable(void)
>>   	if (ret && (ret & TDX_SW_ERROR) != TDX_SW_ERROR)
>>   		pr_err("TDH.SYS.DISABLE failed: 0x%016llx\n", ret);
>>   }
>> +
>> +/* No cache flush is needed; hardware keeps caches coherent across KeyIDs. */
>> +u64 tdh_iommu_setup(u64 reg_base, struct tdx_iommu_mt_param *param,
> 
> param is too general, name it iommu_mt, is it better?

Agreed. In a function whose arguments are all parameters, @param doesn't
say anything. I will rename param to iommu_mt.

> 
>> +		    u64 *tdx_iommu_id)
>> +{
>> +	struct tdx_module_args args = {
>> +		.rcx = reg_base,
>> +		.rdx = __pa(param),
>> +	};
>> +	u64 ret;
>> +
>> +	/*
>> +	 * Retry only on TDX_INTERRUPTED_RESUMABLE:
>> +	 *
>> +	 *  - TDX_INTERRUPTED_RESUMABLE guarantees forward progress between
>> +	 *    calls.
>> +	 *  - On TDX_INTERRUPTED_RESUMABLE, all registers except RAX remain
>> +	 *    unchanged.
>> +	 *
>> +	 * The ABI spec also allows retrying on TDX_OPERAND_BUSY, but that
>> +	 * status doesn't guarantee forward progress, so retrying could spin
>> +	 * forever. The host serializes all TDH.IOMMU.SETUP and
>> +	 * TDH.IOMMU.CLEAR calls for an IOMMU, so the TDX module should never
>> +	 * report the operand as busy.
> 
> Many SEAMCALLs return TDX_OPERAND_BUSY, and this is the generally expected
> handling. I don't think we don't need the comment if nothing special.

I'd like to keep a shorter note. It's the usual handling for TDX folks,
but people outside TDX may read this path too.

> 
>> +	 */
>> +	do {
>> +		ret = seamcall_ret(TDH_IOMMU_SETUP, &args);
>> +	} while (ret == TDX_INTERRUPTED_RESUMABLE);
>> +
>> +	*tdx_iommu_id = args.rcx;
> 
> I remember there was an internal debate about whether to only assign the
> output upon success.
> 
> There are several examples in tdx.c that assign the output regardless.
> But all of them holds error information, which makes total sense to
> assign on error.

Oh, I overlooked this.

> 
> This rcx output however doesn't hold info on error. So I think early
> exit is the right choice. Also see tdh_phymem_pamt_remove()

Agreed. rcx carries nothing useful on failure. Will return early and
only set tdx_iommu_id on success.

>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_FOR_MODULES(tdh_iommu_setup, "tdx-host");
>> +
>> +u64 tdh_iommu_clear(u64 tdx_iommu_id)
>> +{
>> +	struct tdx_module_args args = {
>> +		.rcx = tdx_iommu_id,
>> +	};
>> +	u64 ret;
>> +
>> +	/*
>> +	 * Don't retry on TDX_OPERAND_BUSY. See the comment in
>> +	 * tdh_iommu_setup().
>> +	 */
> 
> ditto
> 
>> +	do {
>> +		ret = seamcall(TDH_IOMMU_CLEAR, &args);
>> +	} while (ret == TDX_INTERRUPTED_RESUMABLE);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_FOR_MODULES(tdh_iommu_clear, "tdx-host");
>> -- 
>> 2.43.0
>>

Thanks,
baolu
