Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F070D13B7AF
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 03:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725508197; cv=none; b=tzOC6KvbMpuFZoKGXOucOQY1xpE3P0WLqgvGFiMYL9SA12wv16NuqbAijoK8u0wWavGbobSGOQmVwNwk+LfQm3ragDXCpy5S4RBWM0IozsXXi5+Ehf20YLYzj1M7og6nbVjwO+A0ZyXl+x6OMjHoeiwClBoHzi6OCZThrY2bFmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725508197; c=relaxed/simple;
	bh=RAteYIaNnUAZW65hHa+40QC8nCjTx4WeIyD12L3SoJE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XjhJVbB0JnyOR0UxrbtrOpPw9AzSLVwcIRgdDl5IhFwzKkvbTv20JumhU+4zqn4qCi202YKHXQJ6SS7MlsLkRqFArWQXL9xWp5XcabOnS0t6fQwKC5aaIAZKb9JJ1kaX1VPLCMtbcvncjF+nCJivzq8lIyHk+tkPavLGi3TvOtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OCHlZUwI; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OCHlZUwI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725508195; x=1757044195;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RAteYIaNnUAZW65hHa+40QC8nCjTx4WeIyD12L3SoJE=;
  b=OCHlZUwIolb3ClLVcyxnThY4gQoA1LoStASsXO+Kdw7k9l0XkyZmCiFT
   ptxdVs+551IcnJGVn31z9wKKQ6n0MZbdiFfwZ/0ifKOoDslILUZ1FKWqF
   P6Uxcyfb4upyzYUkD7nGqrUtGH1FBlZFiAH0ipn/Ju7iD64EmFHt92l69
   qitN3N9cMXX+KMYc3F4k2QrziRIhAcD87BEvKeh6P35p9tXUUOgJ7laBz
   BLVeHjbsgEIjF2+2BXkLpXzy1Sw9G/p1knNVJ8cYhKzTitqEadCQdIo2C
   qsoDGPomLoQci8QVrDCp8bpiQnxMOIJYyPfLyQHsHputOVDpI5GMlHGn7
   A==;
X-CSE-ConnectionGUID: m4vqPFr0QQGxhyI22JBbkw==
X-CSE-MsgGUID: yDxJONihR9CxGXHcDZ5Oug==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="23761798"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="23761798"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 20:49:54 -0700
X-CSE-ConnectionGUID: UXc+KRgWS2u2yWZRevyL/w==
X-CSE-MsgGUID: k84odTRHTHGLh5cC11PvSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="65722623"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 04 Sep 2024 20:49:52 -0700
Message-ID: <97bc177f-49ba-48cc-9dd3-37f79b1432b6@linux.intel.com>
Date: Thu, 5 Sep 2024 11:45:55 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, jani.saarinen@intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Prevent boot failure with devices
 requiring ATS
To: Mark Pearson <mpearson-lenovo@squebb.ca>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>
References: <20240904060705.90452-1-baolu.lu@linux.intel.com>
 <0dc9ac00-1148-4c64-8c12-4d08a2a27429@app.fastmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <0dc9ac00-1148-4c64-8c12-4d08a2a27429@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 2:00 AM, Mark Pearson wrote:
> Hi Lu,
> 
> Tested this on an X1 Carbon G12 with a kernel built form drm-tip and this patch - and was able to boot successfully with pci=noats
> 
> Tested-by: Mark Pearson<mpearson-lenovo@squebb.ca>

Thank you!

> 
> Mark
> 
> PS - note on small typo below.
> 
> On Wed, Sep 4, 2024, at 2:07 AM, Lu Baolu wrote:
>> SOC-integrated devices on some platforms require their PCI ATS enabled
>> for operation when the IOMMU is in scalable mode. Those devices are
>> reported via ACPI/SATC table with the ATC_REQUIRED bit set in the Flags
>> field.
>>
>> The PCI subsystem offers the 'pci=noats' kernel command to disable PCI
>> ATS on all devices. Using 'pci=noat' with devices that require PCI ATS
> pci=noats

Fixed.

Thanks,
baolu
