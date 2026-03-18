Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9601DDA9
	for <iommu@lists.linux.dev>; Wed, 18 Mar 2026 06:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773816239; cv=none; b=T5SIq9LuqzhOosIZ9W7qN/O/hmUehA7sh3rMR93gJ+VT1xv00aZSnxeNq3jKw73aiWojDRNIc9MpHDUPhqu8rAlqwhXk2KjR50AjBv5xfcCDZX/NBYDpnQJnwpH9zQrAZV4/xEsmUAfOQSxj94ZFJy3RFaDJAaR4p8TtSTAh2UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773816239; c=relaxed/simple;
	bh=k+/aIjON1w3XB49p4mTcj8eoPlBg7zpImJv+IVIjRMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXS1kasGawmaKefzhxopRkmsoI2R3v47AOrOkBLrbGBJlVJwdYhq9dLgNXihfMGH+sHzWimBHqkleXQEASrJrV/uyi8M2+qjgbwYuw6rrlpD4rshz7971B0e2A2GPlGIbNDD9Ch80hIXF5ObIH5UC4JW7CT3jG4B7DkL8t+4jl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZEjBkAU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZEjBkAU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773816237; x=1805352237;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k+/aIjON1w3XB49p4mTcj8eoPlBg7zpImJv+IVIjRMc=;
  b=QZEjBkAUa3FwXZJm9Uhc1bIfCr9JX6a9gfFZFGZxFHGxID3bPh6CsejK
   OlzSyOQvBTvxtDSynj4bCkL7Ej4bVSmKjRgUCJM/UaM6VyrdO1L0Ewv97
   0CvMHobFWwu9siiNY1FXZroXj8BX7fBEbBx6Pj/KWYifUz+/pNwxSfI82
   TtzN9fz2OiZ3k9mpqiDYHDWyv0FqvriJUEgBTREiHU8kyhQOyUN0YN83p
   TOMLGKEjPTSXPnHW0v5Y2O4EugkM6TpbEhA7gLpayp9jrDVELLu8h+UNU
   mvPeudzcbfkiPS0EyA66cLT6LoLq4cernHCfI6WPIHfYRASP31xrSKhCg
   A==;
X-CSE-ConnectionGUID: n9fWosQ6TzaENa3P6xJh9Q==
X-CSE-MsgGUID: TVkQcJSNTU+Ik2QW4JA6OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="97471344"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="97471344"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 23:43:57 -0700
X-CSE-ConnectionGUID: uG7nyVY4SGu/cL4EV2HQBg==
X-CSE-MsgGUID: AJyHP0++QdClngc+/2NzzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="227199465"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 23:43:54 -0700
Message-ID: <8665ed69-9364-4f8a-9238-6adf9b5590a0@linux.intel.com>
Date: Wed, 18 Mar 2026 14:42:52 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux error `[DMA Write NO_PASID] Request device [3c:00.0] fault
 addr 0x0 [fault reason 0x05] PTE Write access is not set`
To: Paul Menzel <pmenzel@molgen.mpg.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <88e33b0c-e89f-47a2-9125-d85693d4816f@molgen.mpg.de>
 <d38a2cda-4b29-43ec-ab08-b55c79714810@linux.intel.com>
 <311a59f3-10bb-4a43-b86d-2f1ef316a01c@molgen.mpg.de>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <311a59f3-10bb-4a43-b86d-2f1ef316a01c@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/16/26 22:54, Paul Menzel wrote:
>>> On the Intel Kaby Lake laptop Dell XPS 13 9360, Linux logs the error 
>>> below:
>>>
>>>      [17959.189315] ACPI: EC: event unblocked
>>>      [17959.197876] DMAR: DRHD: handling fault status reg 2
>>>      [17959.197882] DMAR: [DMA Write NO_PASID] Request device 
>>> [3c:00.0] fault addr 0x0 [fault reason 0x05] PTE Write access is not set
>>>      [17959.198366] DMAR: DRHD: handling fault status reg 2
>>>      [17959.198369] DMAR: [DMA Write NO_PASID] Request device 
>>> [3c:00.0] fault addr 0x0 [fault reason 0x05] PTE Write access is not set
>>>      [17959.198923] DMAR: DRHD: handling fault status reg 2
>>>      [17959.201477] nvme nvme0: 4/0/0 default/read/poll queues
>>>
>>> 3c:00.0 is the NVMe controller/device.
>>>
>>>      $ lspci -nn -s 3c:00.0
>>>      3c:00.0 Non-Volatile memory controller [0108]: SK hynix PC300 
>>> NVMe Solid State Drive 512GB [1c5c:1284]
>>>
>>> This seems to happen only *sometimes* when resuming from ACPI S3.
>>>
>>> To my knowledge, this is *not* a new problem. Please find the log 
>>> messages attached. (Ignore the other DMAR error for now.)
>>
>> These IOMMU DMA faults are triggered when the NVMe controller attempts
>> DMA writes to system memory address 0x0. The IOMMU hardware blocked
>> these accesses because the system software has not granted the device
>> permission to write to this specific address. It's unlikely a bug or
>> problem in the iommu driver as far as I can see.
> I am seeing the same issue on a Dell XPS 15 7590 with Intel NVMe 
> controller:
> 
>      $ lspci -nn -s 3d:00.0
>      3d:00.0 Non-Volatile memory controller [0108]: Intel Corporation 
> SSD DC P4101/Pro 7600p/760p/E 6100p Series [8086:f1a6] (rev 03)
> 
> Logs from Debian’s Linux 6.19.8:

Did you see this warning with the v6.18 kernel or earlier?

> 
>      [  726.138732] DMAR: DRHD: handling fault status reg 3
>      [  726.138736] DMAR: [DMA Read NO_PASID] Request device [3d:00.0] 
> fault addr 0xffffd000 [fault reason 0x06] PTE Read access is not set
>      [  726.141470] nvme nvme0: 12/0/0 default/read/poll queue
> 
> It’d be great if this could be fixed.

Thanks,
baolu
