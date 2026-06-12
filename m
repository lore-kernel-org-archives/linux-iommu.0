Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4764938888C
	for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781279357; cv=none; b=pvM/yUifH1eTH42UEwQwgDDq5yImqF42+lPlSa5uhYneRSP/E+laVKZJh+xbW1s7Cl+ZGjnFU3RV+s9Ju9XNU/sgRdu4Jyntd+9DS4SaL6daGdUDNMvi1arVvdgk37WGPzS8+QUdFjkvCAffQvPnyRsDGYMCZ+klhLGOczHZaZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781279357; c=relaxed/simple;
	bh=cmuWdLZnmzJuZ8tXKo4lxxPTQfJsAC0PwDxyx65gUu8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W+JyAkUxwvlfnKPHm+G1XTkANLiArqCqMxOcmmK9B3UsYNFJdVp4HOshKKeV0VEwpk3zQXbXp5eUkDGFWeGW4wZhEfkn3HmKODliR5XWcNzxqZxziJvcT4yhSsdzP5PYbKtDbgq/M1iwpDoVhZWqB3hq4Tsd7W2/vDsuX5f1hFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JgA7DWi7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JgA7DWi7"
Received: from [192.168.201.246] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 14F1A20B716A;
	Fri, 12 Jun 2026 08:48:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 14F1A20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781279330;
	bh=ybPZw5yBtrj6GVFw2KVnqqBTS8qRsLDltQqfValjFxw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=JgA7DWi7ZLWaGC2D7GogwAo1CIXnmwCqMg3eHKeMj6UqY4+ZxFbiSvVrbmA92sk9T
	 xCHcYeACw33e3x+pT0S+bAMp4AfX4iLXKTQXdBwQEQb8TEv9xctkfcyXYRKxV4KF1a
	 fdPmHBqUEgNb7gCblCZhN+NHqoLb0k9e9gCqNo5s=
Message-ID: <4d7fee09-a71c-4158-820b-54d0ab5a5fa8@linux.microsoft.com>
Date: Fri, 12 Jun 2026 08:49:03 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 easwar.hariharan@linux.microsoft.com, mhklinux@outlook.com,
 wei.liu@kernel.org, zhangyu1@linux.microsoft.com,
 jacob.pan@linux.microsoft.com, schakrabarti@linux.microsoft.com
Subject: Re: [PATCH V2] iommu/hyperv: Create hyperv subdirectory under
 drivers/iommu
To: Mukesh R <mrathor@linux.microsoft.com>
References: <20260603225010.1347623-1-mrathor@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20260603225010.1347623-1-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/2026 15:50, Mukesh R wrote:
> Create hyperv subdirectory under drivers/iommu in anticipation of more
> hyperv related files from upcoming PCI passthru and pv-IOMMU patches.
> Also, the current file hyperv-iommu.c actually implements irq remapping on
> x86, so rename to more appropriate hv-irq-remap-x86.c and move it under
> the new hyperv subdirectory. Since this file implements irq_remap_ops
> exposed by drivers/iommu/irq_remapping.h, it cannot be relocated to the
> irq directory. This is in sync with other backend directories like amd
> and intel there.
> 
> Lastly, this file should not be tied to CONFIG_HYPERV_IOMMU, but to
> CONFIG_HYPERV and CONFIG_IRQ_REMAP.
> 
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
> V2: rename hv-irq-remap.c to hv-irq-remap-x86.c
> ---
>  MAINTAINERS                                              | 2 +-
>  drivers/iommu/Kconfig                                    | 9 ---------
>  drivers/iommu/Makefile                                   | 2 +-
>  drivers/iommu/hyperv/Makefile                            | 2 ++
>  .../iommu/{hyperv-iommu.c => hyperv/hv-irq-remap-x86.c}  | 8 +-------
>  drivers/iommu/irq_remapping.c                            | 2 +-
>  6 files changed, 6 insertions(+), 19 deletions(-)
>  create mode 100644 drivers/iommu/hyperv/Makefile
>  rename drivers/iommu/{hyperv-iommu.c => hyperv/hv-irq-remap-x86.c} (99%)
Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
