Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B682BAE4
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 10:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710151400; cv=none; b=MfScyzPRjR9wESqUNN0ozOT3rfb6EubS1a2icVJ03w7CRAaAiG7fLiXIxS7l9GZHmHBy33plKVzWWaCNt3LgGg+tD/ibfuiM9JGqEujWPP6GGTvZfHkP5eI8y2Ugt6T/tvQr5MC6oZxw9WYlmjA/dJw6gyidQ3rlX7EwHwkag5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710151400; c=relaxed/simple;
	bh=9Gb3FxmFB2MS+CwHOYTUzLAR6NiPX2OXLbo5eP2DWRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lC5PIUl2qGyqgeTt/8eSba+BK9FiqU85ZFbzzBCUwkfVhDsCvM4Y1JIr4h2LDZmcDyo+zE3wcOudhDgJtCl6D/zSLBPSQjb39pTgl29a49KzhEvCY82SMZSTB9Gr0HrHcXQNKMTfN1OEN9kYa3o9tRFkSB15GgcuOkZKUy3YXOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ePNobSfB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ePNobSfB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710151399; x=1741687399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Gb3FxmFB2MS+CwHOYTUzLAR6NiPX2OXLbo5eP2DWRA=;
  b=ePNobSfBQpVJmnaSN0KZH7OGmflMxocfTYFUmToA4JOZNBKVNAtFJ3Q2
   1B9ZqDjTp1yFMpq9R554mg31P7Qd4H+CiYayMAtUfNrkV+npzf9eNvJT6
   F2KC1rWX83ZXuSxb/M5ZVG1yZNTq65/yM/34GThDS+ejy3ZXKcSnhg/sB
   6Se9gpLSCr3wTz+QSkO+ML4Nouh61c2h8pLxNxTDuY0+TR3e4C1DiDIoa
   PRVdKEeef/OD4CO2btVC8QA82ZIp3riGkmf3FvQTVZNAZC9dEQ9gJc2wg
   //der+Yf4vXLRRh0PSytHZ9g6WJCIwF8PwIJmYuIwmX5kTlggskNCqQ23
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4941581"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4941581"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 03:03:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="914354506"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="914354506"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 03:03:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rjcUw-0000000BaRR-1vxt;
	Mon, 11 Mar 2024 12:03:10 +0200
Date: Mon, 11 Mar 2024 12:03:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Howard Yen <howardyen@google.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, mathias.nyman@intel.com,
	hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	petr.tesarik.ext@huawei.com, broonie@kernel.org, james@equiv.tech,
	james.clark@arm.com, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v5 0/2] Add support for multiple coherent memory regions
Message-ID: <Ze7W3o67JLTKlLzR@smile.fi.intel.com>
References: <20240311094947.3738200-1-howardyen@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311094947.3738200-1-howardyen@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 11, 2024 at 09:49:45AM +0000, Howard Yen wrote:
> In the system I'm working on, there is an always-on subsystem which
> includes a small size memory, and several functions need to run and
> occupy the memory from the small memory if they need to run on the
> always-on subsystem. These functions must allocate the memory from the
> small memory region, so that they can get benefit from the always-on
> subsystem. So the small memory is split for multiple functions which are
> satisfied with their generic use cases. But in specific use cases, like
> USB3 devices which support the stream trasnsfer or multiple devices
> connect to the host, they required more memory than their pre-allocated
> memory region. I tried to implement it in a generic way and propose this
> patch to give it the ability to get the memory from the other larger
> memory to solve the issue.

> Changelog
> --------------------------------------------
> Changes in v5:
> - Fix build break.
> - Use of_property_count_u32_elems() instead of
>   of_property_count_elems_of_size().

Have you tried to use --histogram diff algo?

-- 
With Best Regards,
Andy Shevchenko


