Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A3D43E07A
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790878950; cv=none; b=CwA4iVJ82iM9zrh4nRi219vaxYowPNZ5VlpUsJgzrs9AUNfIvQkSW5VoprZn4xaWJmiqBDELIVlpATZT1D6T3nVthwWCkzx1QCSPcGiSJJgyNcOyNriaPihaFfw4m6cVU09Ks+XPU5siYApXeIFtJ7Ja/Gbo8qp6if9Md+7gv0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790878950; c=relaxed/simple;
	bh=Y94ugADCjd5S4s4n0Tg88CMgCId4+Gj9yqv40QY1BOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYrPcIYH5VojraeD+pbQ4gtPjvm1pp7q/OZghvkRUlP0M2NVDa8ao2skMn6w96EHx8me/0QXcvs/fBqD2U9okIYdP6PBqEp5KQnYPxmHCRH0KBRfKczK833XrafAPjgd+xgfBZrN4LeyAJX94wLtsfbJNbBzXbqcW5bVuAbCGus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iHoBLnBp; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iHoBLnBp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790878945; x=1822414945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y94ugADCjd5S4s4n0Tg88CMgCId4+Gj9yqv40QY1BOI=;
  b=iHoBLnBpz7Ncj2YN7PyQXGQzQ5VHvD2xbzxa86r66p4AWBBXUR5+Frjz
   anDOKgvSjdcY5aGMs5qF82Om5QVORClSaubnC+uwk7hDS32yzMS0R3pdr
   3ZwmW0T3juBTMSSnbUjpxAgXZQwzOqdxdAh6Q1CMaTNqwXtCA0gnNhFjR
   AtkEc595LweAbZz7LydQ8m5ss2fQ3BQBBOgXrSHsR7mqEzdd16GNZRQYd
   7bvgDcT0/5I9ywyb1/PYQwyjk9JOpb+HR/4+ayIuiCqdNQ4X9/wIuv+0e
   p1SVztBQwwsJTfZ6x3kqWdJ7hqVo8g/2kuMbWpbnqa1Cpv3GtltUnlVtV
   A==;
X-CSE-ConnectionGUID: c4Gd2+P3Tu6o/LXodCKmLQ==
X-CSE-MsgGUID: rpfRtFNiQTK/3Lq5gHY+bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90704758"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="90704758"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 11:22:20 -0700
X-CSE-ConnectionGUID: L5g60cWbRa2/8tjijxT4Ww==
X-CSE-MsgGUID: StWR2umvRNqgnHBGcd2t7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="302298846"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.27])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 11:22:14 -0700
Date: Thu, 1 Oct 2026 21:22:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-efi@vger.kernel.org, Will Deacon <will@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
	Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Sen Wang <sen@ti.com>
Subject: Re: [PATCH v2 0/5] ACPI: Replace acpi_get_first_physical_node() with
 acpi_bus_get_primary_device()
Message-ID: <ar6k1MMzNDTbdLvO@ashevche-desk.local>
References: <4766532.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4766532.LvFx2qVVIh@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 30, 2026 at 08:30:47PM +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> This is a partial resend of
> 
> https://lore.kernel.org/linux-acpi/7995179.EvYhyI6sBW@rafael.j.wysocki/
> 
> that only includes patches that have not been ACKed and the last one that
> depends on all of the others.  It is based on linux-next.
> 
> This series replaces acpi_get_first_physical_node(), which is inherently racy
> and therefore generally unsafe to use, with acpi_bus_get_primary_device(), that
> doesn't have this problem, everywhere in the code.
> 
> I will appreciate ACKs from maintainers of the code updated by the patches, so
> I can pick them up and get rid of the problematic interface in one go.

The whole lot is straightforward,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


