Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B01C2C9;
	Sun, 12 Jan 2025 00:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736642552; cv=none; b=pzAG2ZUrMozCw47/Bij5441b61imhY0b2ItT1TqjZImU2WRinZWkkmODBHsFBxTZX2vaAKEZ4W7AMElAHfckk3jMaW45lCQSJDH2bb1hH/xrXQamtS4cZaMTwDCN5XH1l3crZAeGbU5Ys7TSvW9b6i8r2V73aNCkJM8R1kGYe2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736642552; c=relaxed/simple;
	bh=Z1BKUv222L4W5EpLjlS5rXbNNqX1dnJIFJb1SINHK6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tr9MUsPtJTFTmUooa8vrIsEDFZN4LwJwXijA+ZulU6UoSaHx1VB1w0jjTTuJ2BXdIXudVdZwI+7zY35rBdCxjhYxguL4vWtChymxHRQuzVHMHVy1trLt9JO0QBHl23R+3yYM1W7hkSNpfk2RHhEtXTYeZkpKJDM/53ros0a3qsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hd9p6Igj; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hd9p6Igj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736642550; x=1768178550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z1BKUv222L4W5EpLjlS5rXbNNqX1dnJIFJb1SINHK6c=;
  b=hd9p6Igj2m3lwTVtguUCxltxP0j2YxLfoWvEXopxsww03CxTMHdRAKUO
   9/mw9ZZfbc+J+itmkTnwFPa5FzhVdVPgiiYvZjqZ6gYgpkGgL7Amx5cB3
   bFg9CNt08nIQTS8kcd7rU7C0PDgJGUXyB0l8wU4nD9/vwTCWCIfB6tVOV
   4H/QqegvADCbWErFbAEYUnrlko+wCx3ThHxpw5SdOXaaYGbLH2f9gKyzp
   ByEZdw7atnWR8ASfEqRubUhr9NPBwEaVhtJ2shAHx+cffmi5hVMfsmwB/
   SZpV7eH772ya6X0wT/YtdOG+CeVN7e5VNJjIKVM2b1M2044udB84AbG3b
   g==;
X-CSE-ConnectionGUID: +c+4FlbcRb2/4thwg9aTQg==
X-CSE-MsgGUID: IXh4qiTDSWmMHvDEAiBODw==
X-IronPort-AV: E=McAfee;i="6700,10204,11312"; a="59387757"
X-IronPort-AV: E=Sophos;i="6.12,308,1728975600"; 
   d="scan'208";a="59387757"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2025 16:42:30 -0800
X-CSE-ConnectionGUID: 0P+b6rxfT0W1z3/oMwlZdw==
X-CSE-MsgGUID: OufXYvbTTXeHj7WKqoVPBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,308,1728975600"; 
   d="scan'208";a="104131216"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 11 Jan 2025 16:42:24 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWm3a-000LN4-1o;
	Sun, 12 Jan 2025 00:42:22 +0000
Date: Sun, 12 Jan 2025 08:41:22 +0800
From: kernel test robot <lkp@intel.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	daniel.almeida@collabora.com, aliceryhl@google.com,
	robin.murphy@arm.com, rust-for-linux@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	iommu@lists.linux.dev, Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
Message-ID: <202501120855.PXuydC6T-lkp@intel.com>
References: <20250108122825.136021-3-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108122825.136021-3-abdiel.janulgue@gmail.com>

Hi Abdiel,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.13-rc6]
[also build test ERROR on linus/master]
[cannot apply to next-20250110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abdiel-Janulgue/rust-error-Add-EOVERFLOW/20250108-202929
base:   v6.13-rc6
patch link:    https://lore.kernel.org/r/20250108122825.136021-3-abdiel.janulgue%40gmail.com
patch subject: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
config: um-randconfig-001-20250112 (https://download.01.org/0day-ci/archive/20250112/202501120855.PXuydC6T-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project f5cd181ffbb7cb61d582fe130d46580d5969d47a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250112/202501120855.PXuydC6T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501120855.PXuydC6T-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0425]: cannot find function `dma_alloc_attrs` in crate `bindings`
   --> rust/kernel/dma.rs:145:23
   |
   145   |               bindings::dma_alloc_attrs(
   |                         ^^^^^^^^^^^^^^^ help: a function with a similar name exists: `dma_alloc_pages`
   |
   ::: rust/bindings/bindings_generated.rs:39433:5
   |
   39433 | /     pub fn dma_alloc_pages(
   39434 | |         dev: *mut device,
   39435 | |         size: usize,
   39436 | |         dma_handle: *mut dma_addr_t,
   39437 | |         dir: dma_data_direction,
   39438 | |         gfp: gfp_t,
   39439 | |     ) -> *mut page;
   | |__________________- similarly named function `dma_alloc_pages` defined here
--
>> error[E0425]: cannot find function `dma_free_attrs` in crate `bindings`
   --> rust/kernel/dma.rs:262:23
   |
   262   |               bindings::dma_free_attrs(
   |                         ^^^^^^^^^^^^^^ help: a function with a similar name exists: `dma_free_pages`
   |
   ::: rust/bindings/bindings_generated.rs:39442:5
   |
   39442 | /     pub fn dma_free_pages(
   39443 | |         dev: *mut device,
   39444 | |         size: usize,
   39445 | |         page: *mut page,
   39446 | |         dma_handle: dma_addr_t,
   39447 | |         dir: dma_data_direction,
   39448 | |     );
   | |_____- similarly named function `dma_free_pages` defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
