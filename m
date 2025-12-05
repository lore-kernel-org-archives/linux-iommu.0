Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8806E76026
	for <iommu@lists.linux.dev>; Fri,  5 Dec 2025 05:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764913046; cv=none; b=caKRLbvwmq1MDssSXkcjS8Ezs8zzadC+IWkinb9XZog+1/ibB7cAL9QEw0ev9xajt+rltZW/Quecva32MvexUSS54ku+P9seUF6ep6gluccEQ2jPF53jmjKnzAREtMTglxX5gWw/XL0Eyet5QRG4Iba8LUZx9uglIarXFd08yOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764913046; c=relaxed/simple;
	bh=2QEUYVrchw+ivWGczpLQsZHWMr4uw/hoamN9904kPj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oiyHYMRNRi5l1nooietTTouD08XUdgAP+A+zp4TgwJQkk/TL5YVxYLxK/bbLVzOgAZx0k/B+ZBCAcoCPO73WUtC9cZqATm5BvrgzL+k9x9e6fMfwajkS9idbVbJqp2Geql6gzta/nl4drXCsaxcecl+Vc7EDn9TowX0GfKxfmWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLRsbaUY; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLRsbaUY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764913044; x=1796449044;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2QEUYVrchw+ivWGczpLQsZHWMr4uw/hoamN9904kPj4=;
  b=bLRsbaUY08fceotgmHYuXZg5nrDcSPXelTeFy4ezaARnHog8j8Ac9Cpd
   FYW4qbdR9vt7UQTEn078ReLBI+DDAM46Hon6cdn8Xxwrwp2NimadkEyx0
   R6hS9g6HTDYrzEFC8D6TSTw1IXWojoiUhYuFcwDL19RkkGNB0K10fKRcY
   6mrraMVeZVbQUNSArGu4KjaS98VLD+hyHAGloaavJFytFPUZdgt6VvYNz
   Dufy/pbO2cME/CTiLpE9Hb/eQqpF6u1X8wQfhHBc7TzBjXmeIHyku8hZ3
   gTEA4fPILuYcCAeBjDtcBTGpz2ERtCbFwuNW+DEYHgYt1r9xUnbdegduk
   g==;
X-CSE-ConnectionGUID: 6n69rkglQ06UHJ0RMHRR4A==
X-CSE-MsgGUID: J7JyDvgdTaG/wAgbyRbLow==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="66906116"
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; 
   d="scan'208";a="66906116"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 21:37:23 -0800
X-CSE-ConnectionGUID: 2jQtR01eSQeumJISKO4MoQ==
X-CSE-MsgGUID: Jh4TrudZQI+sidwPYUIpsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; 
   d="scan'208";a="199683928"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 21:37:22 -0800
Message-ID: <b9c23895-ae8f-4c71-a0b4-5956e2719901@linux.intel.com>
Date: Fri, 5 Dec 2025 13:32:51 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel IOMMU] Question about memory ordering in context/PASID
 entry updates
To: Dmytro Maluka <dmaluka@chromium.org>, iommu@lists.linux.dev
Cc: David Woodhouse <dwmw2@infradead.org>,
 "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 Aashish Sharma <aashish@aashishsharma.net>,
 Grzegorz Jaszczyk <jaszczyk@chromium.org>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>, Kevin Tian <kevin.tian@intel.com>
References: <aTG7gc7I5wExai3S@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <aTG7gc7I5wExai3S@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/25 00:49, Dmytro Maluka wrote:
> When updating a context or PASID entry, we'd better make sure we set the
> present bit after setting up other bits, not before, right? And indeed,

Yes, you are right.

> for example, in domain_context_mapping_one() we are doing it in the
> following order:
> 
> 	context_clear_entry(context);
> 	<set other bits>
> 	context_set_present(context);
> 
> But it doesn't look like we have any compiler barriers to actually
> ensure this order? (And in case of context entries, there is even no
> WRITE_ONCE or anything like that.)

Yes, we should do that to ensure the order.

> So, are we just hoping that the compiler will not reorder it?
> 
> What am I missing?

We didn't implement that primarily because we hadn't encountered any
real issues, operating under the assumption that the root/context
entries population is completed before DMA translation is really
enabled.

However, that assumption is incorrect, as users can change a device's
default domain in VT-d legacy mode. This action triggers a context entry
change while DMA translation is already running. So, yes, this is a bug.

Thanks,
baolu
