Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDC4F505
	for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 01:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719364301; cv=none; b=Do0/y41huLnt7f1I9XgrqbrYLKBglyFhi7un3mKWG7+hNob3mH8PyZ1vbuWLcza1zhh6GEb7MgOjzWs5Gf7/t9AM8RZquxnjXQ+l7G5sfXn8e2zZ1bpqN0vS+yGqimS+Py4qrBlzeCNpwjMYnrU3es8DOEhPHNRaRRgfLcwfXNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719364301; c=relaxed/simple;
	bh=OJYkJ1W9WEO78a37/kIPbjQZk8CkmjV0blAWidZa0tM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PCvKaPtALo63ZWVFCxqmzdXxV/oPwa9FsAirMPAs5FLsxE7AZKS63hEJSjntdK2dARn55iAaI+YZxCRpzAgxPRUXLYfBWZ8dSKYbocY6xiMU1v8+2rd1PS12GNWqJuzFKwfQUHtQVbfnyeUs6kv740lKMlLra7dR2fBcYo5o16I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cwb54Dy0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cwb54Dy0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719364300; x=1750900300;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OJYkJ1W9WEO78a37/kIPbjQZk8CkmjV0blAWidZa0tM=;
  b=Cwb54Dy0Kwbw8mQU+Djidu95oO02MnQ60LaQQFmx44XL2tCis7TuEP09
   KLSy4HUHJ3Xqh+W6sbri45rfnYHMR/x1moDRfx7SPI7V7IB5bgWsfSlU9
   TnqQBmhZ/ze1ec2BLRs+pOVqqqRkZu83jaCyEP9V3jwOqN8CI/6xQ0/uF
   ZXTwAigc9PpPpJe6kRlIn8wJvFnalz6jBA77S8KaTtEzZWdLMU5sk/ThV
   YSOW9MUUyZtTKzg/uxO4OagolYaorI8b8oaxH8AkzMxE6waMpcEheiclB
   6pvpjq/OKOBaugdGPIsc3+xIlPbvd7GzPXD/RMd/YMQRtQaZxjhdRiLHw
   g==;
X-CSE-ConnectionGUID: zGf8d3BMS1uJUmMnDpjYlA==
X-CSE-MsgGUID: AyOJzPsgSMu9I2J0pt1wTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16560847"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="16560847"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 18:11:39 -0700
X-CSE-ConnectionGUID: 9hbx//XYRQ2pHhD+puVXcg==
X-CSE-MsgGUID: eJGexdI+S8+6vrSlqdtCTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="43696087"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 25 Jun 2024 18:11:37 -0700
Message-ID: <33c93a17-b888-47a8-be54-8fb0f7fee0ec@linux.intel.com>
Date: Wed, 26 Jun 2024 09:09:04 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/intel: Enable pci capabilities before assigning
 cache tags
To: j.granados@samsung.com, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
References: <20240625-jag-ats_cache_tag_fix-v1-1-67f956e3fa93@samsung.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240625-jag-ats_cache_tag_fix-v1-1-67f956e3fa93@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/24 9:49 PM, Joel Granados via B4 Relay wrote:
> From: Joel Granados<j.granados@samsung.com>
> 
> Enable the pci capabilities by calling iommu_enable_pci_caps before we
> assign a cache tag. The cache_tag_assign_domain call in
> dmar_domain_attach_device uses the device_domain_info->ats_enabled
> element to decide on the cache_tag_type value. Therefore ats_enabled
> needs to be evaluated before the call to the tag cache assignment.
> 
> Signed-off-by: Joel Granados<j.granados@samsung.com>
> ---
> The "what" and "why" are included in the commit message.
> 
> Tried to place cache_tag_assign_domain before the early return in
> "if(dev_is_real_dma_subdevice(dev))". This means that the call to
> iommu_enable_pci_caps landed before the setup functions [1] which is not
> an issue as they seem to be orthogonal (I would like to be proven wrong
> here).
> 
> An alternative to this patch would be to use a different way of checking
> if the device is ATS enabled in __cache_tag_assign_domain.
> 
> Comments greatly appreciated

Thank you very much for the patch. But we already have a similar patch
which has been picked by Joerg for 6.10-rc.

https://lore.kernel.org/linux-iommu/20240620062940.201786-1-baolu.lu@linux.intel.com/

Can you please check whether above patch works for you?

Best regards,
baolu
