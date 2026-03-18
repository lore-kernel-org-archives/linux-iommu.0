Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CB02C028F
	for <iommu@lists.linux.dev>; Wed, 18 Mar 2026 03:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773803478; cv=none; b=F5kQ4X/aMMFCx3rwe8+T75cSwNJe8xKhuXP3Y90KbuFQn6Dnhzq4udiEkynB3xutc/JJHhf/3lOaZInnG0ke/KqnGkrZrrdb4j/LjenMMVcd4bnE+xEORO/SFH/nVjdwULBwUFdVb1LMYy949cKuypXPOc8toLNUY8fbWwQpszY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773803478; c=relaxed/simple;
	bh=Gz6iFxb1bv30cGiXJqKtDWhed4Gd6LBZ+Z9quH/MeUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M59hNnsC+fcrBB/yZ/22286jXCNITPVCpIh/StMR4jxE8E2wKIw8S2cbyYU5kScwYXd3xDwhInhcFMzz1dVH3Qv8lNLQ4mm2T/hA/PJ0Ow0afS2tcjCTwN9GAjT/DEUN4L4bo3rQgNUch5Dr51AFB076rmNOgQfV4mVChFUrScw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BADGe/PE; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BADGe/PE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773803478; x=1805339478;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Gz6iFxb1bv30cGiXJqKtDWhed4Gd6LBZ+Z9quH/MeUw=;
  b=BADGe/PE9OBCFW0EhlUZkVLa3Cr2N2yd2pWcYAYFbsoe/BvPCxKWHIY8
   xamZfyFwil+plQ9/m10Mls8boETsH93PZu7X/a8xTkTaWrXmuK4SpASti
   54avdUbIq5h/Ih4Uhx4syMKXX9xH7NhmAiTfPIcIu3wG20tmcLsLzOw/D
   275l40n1QQ7Q7V9j/P7ZcVuh66KJmQ2FKz0/zIflnuewQvqf3cU0bj70D
   q60peId7mSUzktYX5tjZnpBrO1N68FE+zeMFEXbTV/FQJoxWxbyMYhV6H
   PCEPJ9rCw8x9fIPQwy7LQdCLTv60f5loRPzEcJTHQ7yKl2uFmTJVvE9Qh
   g==;
X-CSE-ConnectionGUID: ZxpToeWQQY+yXA5UXK7pFg==
X-CSE-MsgGUID: WR/hnYGPSFOMqOj+vzfO0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="73869815"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="73869815"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 20:11:17 -0700
X-CSE-ConnectionGUID: g1AIhIR+SIqjvcWoxsmfTQ==
X-CSE-MsgGUID: ViOPTHaPRXawSaoMXT7r6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="252941923"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 20:11:14 -0700
Message-ID: <e89a6ce3-d0a9-4e91-9786-83c2bdb2efd3@linux.intel.com>
Date: Wed, 18 Mar 2026 11:10:12 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] iommu: Lift and generalize the STE/CD update code
 from SMMUv3
To: Will Deacon <will@kernel.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Dmytro Maluka <dmaluka@chromium.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
 <20260309060648.276762-2-baolu.lu@linux.intel.com>
 <aa9W4ZKYWHr9-UNy@google.com> <aa9fQchZJER8QvY0@google.com>
 <61267acf-e42e-4d1e-9942-e241ccffa606@linux.intel.com>
 <abfStwmSjgy--e4H@willie-the-truck>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <abfStwmSjgy--e4H@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/16/26 17:51, Will Deacon wrote:
> On Sat, Mar 14, 2026 at 04:13:27PM +0800, Baolu Lu wrote:
>> On 3/10/26 08:06, Samiullah Khawaja wrote:
>>> On Mon, Mar 09, 2026 at 11:33:23PM +0000, Samiullah Khawaja wrote:
>>>> On Mon, Mar 09, 2026 at 02:06:41PM +0800, Lu Baolu wrote:
>>>>> From: Jason Gunthorpe<jgg@nvidia.com>
>>>>>
>>>>> Many IOMMU implementations store data structures in host memory that can
>>>>> be quite big. The iommu is able to DMA read the host memory using an
>>>>> atomic quanta, usually 64 or 128 bits, and will read an entry using
>>>>> multiple quanta reads.
>>>>>
>>>>> Updating the host memory datastructure entry while the HW is
>>>>> concurrently
>>>>> DMA'ing it is a little bit involved, but if you want to do this
>>>>> hitlessly,
>>>>> while never making the entry non-valid, then it becomes quite
>>>>> complicated.
>>>>>
>>>>> entry_sync is a library to handle this task. It works on the notion of
>>>>> "used bits" which reflect which bits the HW is actually sensitive to and
>>>>> which bits are ignored by hardware. Many hardware specifications say
>>>>> things like 'if mode is X then bits ABC are ignored'.
>>>>>
>>>>> Using the ignored bits entry_sync can often compute a series of ordered
>>>>> writes and flushes that will allow the entry to be updated while keeping
>>>>> it valid. If such an update is not possible then entry will be made
>>>>> temporarily non-valid.
>>>>>
>>>>> A 64 and 128 bit quanta version is provided to support existing iommus.
>>>>>
>>>>> Co-developed-by: Lu Baolu<baolu.lu@linux.intel.com>
>>>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>>>> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
>>>>> ---
>>>>> drivers/iommu/Kconfig               |  14 +++
>>>>> drivers/iommu/Makefile              |   1 +
>>>>> drivers/iommu/entry_sync.h          |  66 +++++++++++++
>>>>> drivers/iommu/entry_sync_template.h | 143 ++++++++++++++++++++++++++++
>>>>> drivers/iommu/entry_sync.c          |  68 +++++++++++++
>>>>> 5 files changed, 292 insertions(+)
>>>>> create mode 100644 drivers/iommu/entry_sync.h
>>>>> create mode 100644 drivers/iommu/entry_sync_template.h
>>>>> create mode 100644 drivers/iommu/entry_sync.c
> Shouldn't we move the SMMU driver over to this, rather than copy-pasting
> everything? If not, then why is it in generic IOMMU code?

Yes. I will start to do this from the next version.

Thanks,
baolu
