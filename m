Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA2B1E89C;
	Sun, 21 Dec 2025 00:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766275617; cv=none; b=R8oGl3SYA48RtchKeHFLo+/rEptYncguK0FNCKr/n/UeC+u/OC30S1XMepsRUCPtGeV5PGj/qJne5VpGWO9RIjMkjQbYluiDzRrm29ghQ+U4f9oVo7LSEnS2qOM6zMGKRAqnC/zh0IzT2VKH8jOrwVMy33t0cT/g80gJofzoFlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766275617; c=relaxed/simple;
	bh=sOt6CEZpOSyORmbi/kzA8CZ3ShnRxK4EN8upthUlT8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMeQYxLFJwzKiEt2v4oLAaaamJORtzjmdO2k4Mqw+clQ4aSHXj+C3aFXmaTHTTZz7qme4aMOEg5KHUHF7FIbUCFz6wEtLiBE3ka8b3RUnqSX9vMIQnDDN6IAcKxIJODsACQfGtFWpC2tW0Goq03BnKtAca2IkxGwuwRR4cOyLGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mz4HMRBS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mz4HMRBS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766275615; x=1797811615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sOt6CEZpOSyORmbi/kzA8CZ3ShnRxK4EN8upthUlT8w=;
  b=Mz4HMRBSEG79si1dVVPxJRijHpw0jSVxuDcP+TmEMqGKfq4Rn/TAQHPR
   lVrC335T7Y8L6iORTKXeoEWFKqVWUZ0LMUwEKTHG6MBUAXgThIhWFQjZN
   XZ9Pc1V4HWNtndNlhneR09oMdxyZJHpGjVvoK3+etJnJ2SXwLSgkNQDiF
   FQQgc9VRiKfa/hFt5wW+BLcQT0CBxijwmfQBlrc0ibO7hU4M/N4hreyj9
   CyGZlsl4Ahy89QIpD5TB1RU+Uvwm88sLpLKrpK+Wr5e3MsIvpyxJqo0ge
   gW9nBJo7ibHiuWH6y/A9mO3o/xEIaQQ0yew8djgPxqIc0L1AgmJa0RJEV
   A==;
X-CSE-ConnectionGUID: r2Lr4yVhSSOZCYkuWR9MWg==
X-CSE-MsgGUID: AIyjDkvSSN2E3uCr9mfyog==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="72035922"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="72035922"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 16:06:55 -0800
X-CSE-ConnectionGUID: uQzW/VJJQIqjaHIxzp2Fmg==
X-CSE-MsgGUID: JPj19i+eQvy24iR01DTvYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="199099060"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by fmviesa006.fm.intel.com with ESMTP; 20 Dec 2025 16:06:50 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vX6yG-000000004qW-0ki6;
	Sun, 21 Dec 2025 00:06:48 +0000
Date: Sun, 21 Dec 2025 01:06:34 +0100
From: kernel test robot <lkp@intel.com>
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Will Deacon <will@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: oe-kbuild-all@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Asahi Lina <lina+kernel@asahilina.net>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	iommu@lists.linux.dev, linux-mm@kvack.org,
	Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v4] io: add io_pgtable abstraction
Message-ID: <202512210130.LVNt1EfI-lkp@intel.com>
References: <20251219-io-pgtable-v4-1-68aaa7a40380@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219-io-pgtable-v4-1-68aaa7a40380@google.com>

Hi Alice,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3e7f562e20ee87a25e104ef4fce557d39d62fa85]

url:    https://github.com/intel-lab-lkp/linux/commits/Alice-Ryhl/io-add-io_pgtable-abstraction/20251219-185557
base:   3e7f562e20ee87a25e104ef4fce557d39d62fa85
patch link:    https://lore.kernel.org/r/20251219-io-pgtable-v4-1-68aaa7a40380%40google.com
patch subject: [PATCH v4] io: add io_pgtable abstraction
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20251221/202512210130.LVNt1EfI-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251221/202512210130.LVNt1EfI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512210130.LVNt1EfI-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: this function has a `#[must_use]` attribute with no message, but returns a type already marked as `#[must_use]`
   --> rust/kernel/io/pgtable.rs:162:5
   |
   162 | /     pub unsafe fn map_pages(
   163 | |         &self,
   164 | |         iova: usize,
   165 | |         paddr: PhysAddr,
   ...   |
   169 | |         flags: alloc::Flags,
   170 | |     ) -> (usize, Result) {
   | |________________________^
   |
   = help: either add some descriptive message or remove the attribute
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#double_must_use
   = note: `-W clippy::double-must-use` implied by `-W clippy::all`
   = help: to override `-W clippy::all` add `#[allow(clippy::double_must_use)]`

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
