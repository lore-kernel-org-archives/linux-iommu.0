Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F6327057D;
	Thu, 15 Oct 2026 06:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047116; cv=none; b=FsEjpOaUxRqYxVEMzgFIDpqQ+XQBHT5rKMGLXwP8iVObOCuNcciXzWNUYQd5yELObwcK/A6FsX7kcQSV2QgTCdCW0vA6XFtrGRVhXsu4c23gj1TdqTsyg6olt+xFa+gOTI6yTHQvQAanHntF6v2TpY9/h8HfX/qSLKtR3Bnj9Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047116; c=relaxed/simple;
	bh=4PIg90yopjQlPLry9vxHjabFyBihfeVNSbu+pE0Te6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXUfc35oEhRYU/3HIC9k9P4gm2n8dDFKgHqZ8vvapU1/sSBXa/tgXMnqoP55+mp2Yr1vWk8Yoaw8dFZ5v94KAMc+uTP0B9UqDWAw/3QThWg60xsrzFAy3hB34XZXJBKE1DCao3jFNU9uf7m0ZFOtCigpO0ehxSxMRztVkmja8LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OK3jaju0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OK3jaju0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792047115; x=1823583115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4PIg90yopjQlPLry9vxHjabFyBihfeVNSbu+pE0Te6I=;
  b=OK3jaju0K6G5rCOiQul7OyLCFDqhKtsnWHWqRy7OA7aWCiS/UZswYvUp
   A/E70eFOdvo+g7nOyT4gMPFzpqa+RYAYHEFnBcja2rer+5XwBzhypjdZ5
   aKJnHRc40QowDmHRDus1n3TSKLK9Kzfev0scsYGLeBRYk+muCt1sIGEeV
   Mfc6BgzCB17EruPu1FiO0aRju7KaU7ZcyzlIVZgq92zPPnzxoO32sXYNN
   7C0SFnrmpzFFmelRXsnq499KJ7bHYoiMUwXsYCexOIEVGs2pJBfaruHEq
   b9rRmwmTuRrptVFWhT6FnSGortzwxbRVd8PgsusjUa8mqEDGLteJDsy/S
   g==;
X-CSE-ConnectionGUID: H8dEWe7iTzu8KGffsgpvEw==
X-CSE-MsgGUID: 0+dif5RnRF+iUB6coakGZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="682335"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="682335"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 23:51:55 -0700
X-CSE-ConnectionGUID: 3xj7wT0gQaGztgVlW+zTew==
X-CSE-MsgGUID: qXIQBGKDTIuWxDpR+XHv1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1938384"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa007.fm.intel.com with ESMTP; 14 Oct 2026 23:51:52 -0700
Date: Thu, 15 Oct 2026 14:47:42 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, x86@kernel.org, linux-coco@lists.linux.dev,
	kvm@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, xiaoyao.li@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] x86/virt/tdx: Read global metadata for trusted
 IOMMU
Message-ID: <atB3DiLtGTlilVTN@yilunxu-OptiPlex-7050>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015010705.1973284-3-baolu.lu@linux.intel.com>

On Thu, Oct 15, 2026 at 09:07:03AM +0800, Lu Baolu wrote:
> Add support for reading the global metadata of the trusted IOMMU.
> 
> The trusted IOMMU feature is optionally enumerated via TDX_FEATURES0.

The feature name is not trusted IOMMU, the name in the spec is
TDX_CONNECT, but I believe people want a name with technical meaning,
maybe TDX TDISP? Open question for all reviewers.

> Check this feature bit before reading the metadata to avoid causing
> the entire TDX initialization to fail on platforms that do not support
> it.
> 
> The read value represents the number of pages required for the IOMMU
> metadata. The host will allocate this count of pages and provide them to
> the TDX module when it configures the IOMMU to operate in Secure TDX mode
> via the TDH.IOMMU.SETUP SEAMCALL.
> 
> Thanks to Xu Yilun for the initial draft.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  arch/x86/include/asm/tdx.h                  |  1 +
>  arch/x86/include/asm/tdx_global_metadata.h  |  5 +++++
>  arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 20 ++++++++++++++++++++
>  3 files changed, 26 insertions(+)
> 
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 8b5411d3eb67..9c9168822274 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -35,6 +35,7 @@
>  
>  /* Bit definitions of TDX_FEATURES0 metadata field */
>  #define TDX_FEATURES0_TD_PRESERVING	BIT_ULL(1)
> +#define TDX_FEATURES0_TDXCONNECT	BIT_ULL(6)

TDX_FEATURES0_TDX_CONNECT?

My actual point is that the name XX_TDX_CONNECT is good here.
