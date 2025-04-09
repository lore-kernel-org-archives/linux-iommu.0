Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFE7266B4F
	for <iommu@lists.linux.dev>; Wed,  9 Apr 2025 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209789; cv=none; b=dBjuVrgJ7RUitzYo4nqHeECgKT+W5x0088YldJCdhHlMOte27MzhwGMUVgrK68YSNcTtSlDScyORvQ0i6Pvzk2GVA5ahaTdeLEtfr9LyTVq/RchQwf72KfxoR1g0m497OXNgRdq19JkuJujo6CKsA1+tVTehXGZXyLC11qrwaXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209789; c=relaxed/simple;
	bh=/vJiaEGa7ZXWl2oIN/BQ5HE6aRoL2SxIvA9u+06UpVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6X472u1dcCjBE1hLCSoslDlUxqyNDcbHAAzzGYoCFRIZL1w4qRtoI4Qgpy5XzgHttQyju3fOlbvfQE+ILKh77uKAk8qJ1yoMRuaKD3hMeNUicRsyBEvm5fpDF7G54o+Vpf1FAlF/rPorZFuyXXTyDdAHY2k/kElJKohfS//GNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJIO8Edo; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJIO8Edo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744209787; x=1775745787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/vJiaEGa7ZXWl2oIN/BQ5HE6aRoL2SxIvA9u+06UpVk=;
  b=BJIO8Edo/d3tAmLAs8y4uxHNqIPVvi0RjyPtKUclgancBcZdVvtjAwkG
   KTxg1gvWzMuJBY0AjNShdjXPbMh65/bQLtOpeO0qZvxUR09hQCSDRm78Y
   Sil4kS8KGR9X61MnZ3cQDLNOnoPy2gSnottAUat/4avQyqf7bEpDvawxr
   nGPI0O4BI56moUXluaExvsW6zRS9lX2FiBdSs0zXpercKhynnwxIBUwnF
   4HSlQ1p9tJK4ov44qfd+TtotCff7SgRJ+OjFIz5JkmSKO9a8jzXylHfjf
   CxP4VjI/KiG0VdkheQueQwEipNVLDp7DGyutc3JPtU/npP7ogrbX9slv5
   Q==;
X-CSE-ConnectionGUID: dsrZwWyxSu2hx/RoWCORRA==
X-CSE-MsgGUID: d+jzNsGgR9KUtF63T+dFEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="48392939"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="48392939"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 07:43:07 -0700
X-CSE-ConnectionGUID: A+4H22IKQBqovk7crlialQ==
X-CSE-MsgGUID: c7b7ZYAeSKiXHuDL/fJSug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="133472167"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 07:43:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u2Wdp-0000000AlWV-0Bxh;
	Wed, 09 Apr 2025 17:43:01 +0300
Date: Wed, 9 Apr 2025 17:43:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Michal Nazarewicz <mina86@mina86.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] [RESEND 3] dma/contiguous: avoid warning about
 unused size_bytes
Message-ID: <Z_aHdH7Ei_cffeIL@smile.fi.intel.com>
References: <20250409122131.2766719-1-arnd@kernel.org>
 <CGME20250409122452eucas1p2fd6f06f30de0c6b37b510a10081b724a@eucas1p2.samsung.com>
 <20250409122441.2875424-1-arnd@kernel.org>
 <59af67fa-ca0d-48f6-8b78-b1c694af9dfd@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59af67fa-ca0d-48f6-8b78-b1c694af9dfd@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 09, 2025 at 04:35:57PM +0200, Marek Szyprowski wrote:
> On 09.04.2025 14:24, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > When building with W=1, this variable is unused for configs with
> > CONFIG_CMA_SIZE_SEL_PERCENTAGE=y:
> >
> > kernel/dma/contiguous.c:67:26: error: 'size_bytes' defined but not used [-Werror=unused-const-variable=]
> >
> > Change this to a macro to avoid the warning.

> > -static const phys_addr_t size_bytes __initconst =
> > -	(phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
> > +#define size_bytes (CMA_SIZE_MBYTES * SZ_1M)

This had phys_addr_t type before, do we still have the platforms when it can be
bigger than 32-bit integer?

-- 
With Best Regards,
Andy Shevchenko


