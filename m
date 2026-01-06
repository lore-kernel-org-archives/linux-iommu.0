Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F711248F68
	for <iommu@lists.linux.dev>; Tue,  6 Jan 2026 03:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767670614; cv=none; b=QIP6Qa0E/hcFxBxajvbE6+K6k8RSlV2JRKoWC6MQn3hTvzS8nDZ53VE7fM8JsmnmxQPODesP2mhdOOzIQjGWW5gSljhslNKMO9zWzGJjtrlk82ZLFJwpEmzSBq2lPGp7F2W1cCSaFmFhQ7W+5+ArFxUUjLFTJyACV7TJtm4WCKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767670614; c=relaxed/simple;
	bh=XsQW5wSsgtMTTZFsdzB5cn8Q1qohlXcsC9vhzjbwW+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JyK+LjLyTstolj0qYik/REq0tL1+H2yLBIuLqPEauccWGAFB8tWqNZczBMXQWIOweEH3p8S/VjQX16NSMOX1smAHG7APiBSKAJZiYCb6oFrO684uRBlGeGsigSycpgcX7WBy1YIu2MnxJ98VnBqgDN85PgKvJavB3NMq7o62Fko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LYg55Trl; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYg55Trl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767670612; x=1799206612;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XsQW5wSsgtMTTZFsdzB5cn8Q1qohlXcsC9vhzjbwW+Y=;
  b=LYg55TrllcQmaU3tHuVkkVrcKf51F2ipLrbQBUErKNpa8izVoJIDuUoV
   YzuA5UpHanQenEmZ3BC/+uXX5iYEB2N7Pc/hT+NT74Op4jP4ab1ef3s9d
   +QhI8rpELgFvkYeUx5D9cSYC5msZRURpCOhyEZrFqoyugmrWeQTi/TW2/
   JzksxBydKenRlJp5YcsxYtdd4Vb4dNhbR4KhspXZYxdwtIZtDS1BXuUdd
   nWQwKh6WQRkh8GVc602Oo0lK+UmWFFs0astxNjMDI/oXfprT45cEeg2fG
   GPFZQDH40PzTm3FvXULms65DNghwDV7zHKvBZWQO6B1Yky9dkrssXfU2U
   g==;
X-CSE-ConnectionGUID: gHJDwkDPR9CUkSbI1pFLUg==
X-CSE-MsgGUID: t+M2+UKrRROBC8RPuJfWzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="71616970"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="71616970"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 19:36:51 -0800
X-CSE-ConnectionGUID: FJ1bPvWYTb22eMAWLwFObQ==
X-CSE-MsgGUID: ZeNBIBlhSsuicAbSGhWH+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="207592075"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 19:36:48 -0800
Message-ID: <5743e3a2-c034-4000-8477-707336f37c3a@linux.intel.com>
Date: Tue, 6 Jan 2026 11:37:08 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] iommu/vt-d: Ensure memory ordering in context &
 root entry updates
To: Jason Gunthorpe <jgg@ziepe.ca>, Dmytro Maluka <dmaluka@chromium.org>
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 Aashish Sharma <aashish@aashishsharma.net>,
 Grzegorz Jaszczyk <jaszczyk@chromium.org>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>, Kevin Tian <kevin.tian@intel.com>
References: <20251227175728.4358-1-dmaluka@chromium.org>
 <20260105181200.GH125261@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260105181200.GH125261@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/26 02:12, Jason Gunthorpe wrote:
> On Sat, Dec 27, 2025 at 06:57:23PM +0100, Dmytro Maluka wrote:
>> As discussed in [1], we don't currently prevent the compiler from
>> reordering memory writes when updating context entries, which is
>> potentially dangerous, as it may cause setting the present bit (i.e.
>> enabling DMA translation for the given device) before finishing setting
>> up other bits in the context entry (and thus creating a time window when
>> a DMA from the device may result in an unpredicted behavior).
>>
>> Fix this in the same way as how this is already addressed for PASID
>> entries, i.e. by using READ_ONCE/WRITE_ONCE in the helpers used for
>> setting individual bits in context entries, so that memory writes done
>> by those helpers are ordered in relation to each other (plus, prevent
>> load/store tearing and so on).
>>
>> While at it, similarly paranoidally fix updating root entries as well:
>> use WRITE_ONCE to make sure that the present bit is set atomically
>> together with the context table address bits, not before them.
> The PASID entries should not be manipulated 'livel' in a haphazard way
> like this in the first place!
> 
> Like AMD and ARM build the new PASID entry on the stack and then it
> should be copied to the DMA'able memory in a way that is consistent
> with the HW's atomicity granual, paying attention not to 'tear' it.
> 
> This manipulate-in-place is just asking for trouble, and can never
> support replace or full viommu requirements.. :\
> 
> So while it is perhaps an improvement to do this work, it would be
> better to fix the root cause issue if someone has time..

Agreed. The current Intel IOMMU driver uses a 'clear-populate-set'
pattern protected by a spinlock, which is why it doesn't support
'replace' yet. Dmytro's patch addresses the immediate risk of the
compiler reordering those writes and exposing invalid data to the
hardware.

Moving to an on-stack construction (like AMD/ARM) and updating
atomically is the right direction for the driver. We'll look into that
refactoring as a follow-up series to modernize the entry manipulation
logic.

Thanks,
baolu
