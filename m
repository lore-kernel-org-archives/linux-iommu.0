Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999734;
	b=ikCyMyikplXQt7jySfLyX6buSiJmA9Zq6Mnt6a1q8JYus6RHpqbKTMKZnPOAc0S4wsTU
	 vVnAZczwDjY89rCkZTPw1QsWTq04Rn2qYzyJLxyuC56YpLDuL4P2ziBauedzkLE2mLRJ9
	 aDZfAfty3IRa1oBOtq4SE8WpBBG6N943cNX2bp5MODElmdwpp/5lBxZFf3sWYg8RpSjag
	 0/4Pcse0dmmnotSTRSgKs0YZ5SUL14i6KE2aFk5lsuo1BM5XlZGHJx1znZ0zbIRho0PSh
	 ap3uWf03i6ZsfShlrwRh9MZ0QkYd9XCQqYMxu6+ccFE7os0gaMk7cf3+gnKuQf4Jbgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999734;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=/ppIoJSSygapoFf8d3+W2D7zVwbW79N+eyf0qrsR1iM=;
	b=GtAyAydlAQYcPLkey94QPyFRsi7fS2eDrz21veLCnZislMlwDKLt3h5nZodr96uyOrcV
	 7MOIOd8O4SOuz9KWYHY5tfyv89LyZH72Q8VGksgNEXuiFGC4niF/HRUkQtcBwD1JPOgQp
	 phTWI9/XE/qr7W6H5Qp7AzrPohfjJSqnt0EY3gtTUI3tIiNfZPIsExRh7jFthOok0RNzQ
	 93TODIGnSbE2TzJWAqQ/r0S1//ShDe6edna7GevqDFtWAuFIPvAb7wzDk06pAuZI5pwW5
	 KxOVbvIA4dVZa3JryNlb5+YEKzF4Sp9iu6zy/MhQiwbFkYB3g9nWHU4EV+6kJLW6VXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ike5EReS;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAD6606A338;
	Wed, 18 Nov 2026 11:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BAD6606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ike5EReS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794999733; x=1826535733;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8XWiTu/a1gGNV02ADUvGH4Yse9XH4Pb47goXb3WR6MI=;
  b=ike5EReS8TjY69i2zToJ2+gtuRlc+OsB4/1T+G1e5uobiSF40cQr/KKq
   63Ep+3xMTU58msk6Z4aPjbG9Ku2q+CjebBE2LFI8l5aSTX1DVOBOfwTj/
   d4k/tCJlQ7s/hie8v9R8Qq3FG04ZNOwltG/h0t43w8tSYbkp1PSPl4Q+x
   8/McJKQplHtNOMU840fuG5sREaYv5syIlWg131f6libR3kIiRBNItiO/d
   Kj3NDempG0ok2VxmOOzKy8zQDICcBTC2APrBTPKDl15pYYEev7GBaGZ4l
   Ivna9EboQSROSOhXvTpS5uYRl8Ux0Z1Rvny7z0+j1mUlVcgiW2DqPu+fj
   Q==;
X-CSE-ConnectionGUID: OuiZYSclSpq0A4uTbDBjTg==
X-CSE-MsgGUID: X2ljhNxqTo27MRc87xBaOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3684585"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3684585"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 03:02:13 -0800
X-CSE-ConnectionGUID: yv3n1dy3RVeyjTiA3kzxkA==
X-CSE-MsgGUID: fvst2zP6QrWSrIoYwPxrTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9909357"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 03:02:10 -0800
Message-ID: <ed90de7e-6019-4d42-bc6e-5b586b460a31@linux.intel.com>
Date: Wed, 18 Nov 2026 19:02:07 +0800
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
Subject: Re: [PATCH v3 1/9] x86/virt/tdx: Add SEAMCALL wrappers for IOMMU
 setup/clear
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, x86@kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, yilun.xu@linux.intel.com,
 xiaoyao.li@intel.com, Chao Gao <chao.gao@intel.com>,
 linux-kernel@vger.kernel.org
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-2-baolu.lu@linux.intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20261112043054.2664857-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/2026 12:30 PM, Lu Baolu wrote:
[...]

> +
> +/* No cache flush is needed; hardware keeps caches coherent across KeyIDs. */

Nit: 
It's a bit confusing without the all the background.
Once Rick's patch [1] removes tdx_clflush_page() and its comment, a reader may wonder
why this wrapper explains the cache flush but the others don't.

Is it better to drop the comment and explain it in the change log?

[1] https://lore.kernel.org/all/20261015191710.3632302-2-rick.p.edgecombe@intel.com/


> +u64 tdh_iommu_setup(u64 reg_base, struct tdx_iommu_mt_param *param,
> +		    u64 *tdx_iommu_id)
> +{
> +	struct tdx_module_args args = {
> +		.rcx = reg_base,
> +		.rdx = __pa(param),
> +	};
> +	u64 ret;
> +
> +	/*
> +	 * Retry only on TDX_INTERRUPTED_RESUMABLE:
> +	 *
> +	 *  - TDX_INTERRUPTED_RESUMABLE guarantees forward progress between
> +	 *    calls.
> +	 *  - On TDX_INTERRUPTED_RESUMABLE, all registers except RAX remain
> +	 *    unchanged.
> +	 *
> +	 * The ABI spec also allows retrying on TDX_OPERAND_BUSY, but that
> +	 * status doesn't guarantee forward progress, so retrying could spin
> +	 * forever. The host serializes all TDH.IOMMU.SETUP and
> +	 * TDH.IOMMU.CLEAR calls for an IOMMU, so the TDX module should never
> +	 * report the operand as busy.
> +	 */
> +	do {
> +		ret = seamcall_ret(TDH_IOMMU_SETUP, &args);
> +	} while (ret == TDX_INTERRUPTED_RESUMABLE);
> +
> +	*tdx_iommu_id = args.rcx;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(tdh_iommu_setup, "tdx-host");
> +
> +u64 tdh_iommu_clear(u64 tdx_iommu_id)
> +{
> +	struct tdx_module_args args = {
> +		.rcx = tdx_iommu_id,
> +	};
> +	u64 ret;
> +
> +	/*
> +	 * Don't retry on TDX_OPERAND_BUSY. See the comment in
> +	 * tdh_iommu_setup().
> +	 */
> +	do {
> +		ret = seamcall(TDH_IOMMU_CLEAR, &args);
> +	} while (ret == TDX_INTERRUPTED_RESUMABLE);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(tdh_iommu_clear, "tdx-host");

