Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E1023EA92
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 02:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772159026; cv=none; b=NQz0WtUXgXa21Or72WJASs2Lk/qV9zMoCwKjqjfgCQNuJzG4PPMu/ynpRaGX50x71GNeVgLFSfxLvM7oxtmPqonsS4FMFgtcZ1XkpGGZVSC56cht4gUCFr98UDfY9T8QdyMRk4+uL4RI7oUYieXzGEneVcxYy3h+G4wml63srh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772159026; c=relaxed/simple;
	bh=IqH0hcEoWlP5eHsUoZbwB3m+r8sXCdOO5V0jhCXqXfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NSJpO9ETro6HPKqk75vxioKgWcmCW3yT/BHOYnLpChBU4YUJCMl3CBU4UzJVmAb1JSNgI8BqIv1ge9rYKDMvbFx2wNFE+l5qFV/uDwGmCA9EFBnOwB89a/yg9+ZfOWAnY13cBz8xICubAJAhvlmjrsNUvYUXZmnEFPZtxM+7nvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PGVJ7RdG; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PGVJ7RdG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772159025; x=1803695025;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IqH0hcEoWlP5eHsUoZbwB3m+r8sXCdOO5V0jhCXqXfA=;
  b=PGVJ7RdG002OPZof00gFBo+hsPIhgxf5LbRs6YEHj3FnA6eB60QLOPF1
   KlwAeXFp2doNn0SXmRUiRLVDb873FCkygVa3AjV1K9WS829IDCIcXMTRc
   FQ+R220Q5+xNijj7tAIbrq5eBahaPAN5p/Y4M31lXa8VcZ/7le22opXgQ
   rPOCodzqzzsCEJ6+vPslVl71gzXNq6Gz61G3ViJcYO64YzJAKiIAUskj0
   FFy4gCxBQZ78h+CPeY3if6BzWoJv2LSq66MYOHYZATijNxPo6SYVVA7Aq
   p+5Pr3kUc/xHl6OYWXNkmb0w0mkNz2nCCUT3Q8JuHbQ+siUQAe8W07ri1
   Q==;
X-CSE-ConnectionGUID: PnBja5WpSKqu/lVJy78MHw==
X-CSE-MsgGUID: h8U1V4GyQRCN5VvwlP8YVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="84591454"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="84591454"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 18:23:44 -0800
X-CSE-ConnectionGUID: noRFRGkWTHOGEzQ8MYP6Rg==
X-CSE-MsgGUID: Yto6NlIiQ++5zkhqioBREA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="221380703"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 18:23:43 -0800
Message-ID: <d38a2cda-4b29-43ec-ab08-b55c79714810@linux.intel.com>
Date: Fri, 27 Feb 2026 10:23:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux error `[DMA Write NO_PASID] Request device [3c:00.0] fault
 addr 0x0 [fault reason 0x05] PTE Write access is not set`
To: Paul Menzel <pmenzel@molgen.mpg.de>, David Woodhouse <dwmw2@infradead.org>
Cc: iommu@lists.linux.dev, linux-nvme@lists.infradead.org
References: <88e33b0c-e89f-47a2-9125-d85693d4816f@molgen.mpg.de>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <88e33b0c-e89f-47a2-9125-d85693d4816f@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/8/26 03:10, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On the Intel Kaby Lake laptop Dell XPS 13 9360, Linux logs the error below:
> 
>      [17959.189315] ACPI: EC: event unblocked
>      [17959.197876] DMAR: DRHD: handling fault status reg 2
>      [17959.197882] DMAR: [DMA Write NO_PASID] Request device [3c:00.0] 
> fault addr 0x0 [fault reason 0x05] PTE Write access is not set
>      [17959.198366] DMAR: DRHD: handling fault status reg 2
>      [17959.198369] DMAR: [DMA Write NO_PASID] Request device [3c:00.0] 
> fault addr 0x0 [fault reason 0x05] PTE Write access is not set
>      [17959.198923] DMAR: DRHD: handling fault status reg 2
>      [17959.201477] nvme nvme0: 4/0/0 default/read/poll queues
> 
> 3c:00.0 is the NVMe controller/device.
> 
>      $ lspci -nn -s 3c:00.0
>      3c:00.0 Non-Volatile memory controller [0108]: SK hynix PC300 NVMe 
> Solid State Drive 512GB [1c5c:1284]
> 
> This seems to happen only *sometimes* when resuming from ACPI S3.
> 
> To my knowledge, this is *not* a new problem. Please find the log 
> messages attached. (Ignore the other DMAR error for now.)

These IOMMU DMA faults are triggered when the NVMe controller attempts
DMA writes to system memory address 0x0. The IOMMU hardware blocked
these accesses because the system software has not granted the device
permission to write to this specific address. It's unlikely a bug or
problem in the iommu driver as far as I can see.

> Kind regards,
> 
> Paul

Thanks,
baolu
