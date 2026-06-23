Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5A53D566E
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217382; cv=none; b=rYr96bHnmBigRS2TnYFVpanhOrK4IHq4dHFOSf/jVXXEsY+ZbykUQboDqVOl7OaPXUyP0ts4/bLCvC5mTl64ngAU7+IXVKcd8Ahgve2QMRPLwPcUtXr7onNQLBNMqwxczQidrvw2tRJR5wQuDTvLG0ek5VDAigs+k8hQ1dM1uIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217382; c=relaxed/simple;
	bh=AS3ac8Xg+L+HLbpB75f/tFX26Y7zBshQVYWslZ0Kumo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KoDmDxWxjNuhpSMP751RT0Wcv8RAaYYBGx1w+UxEPn9Wrj3uJiS0i0RP9suYpua1BiFiXhEuBblGsIwex5/iKm01KHq6YRRAPsFAplAnXWM/6G5XOtOkdfbqrQvvRi1LvaDrD38IojE56M4iVFP4AnpIfHjDXBRx4SSLWkw/G54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=O+BtR/rr; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="O+BtR/rr"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F11D11A25;
	Tue, 23 Jun 2026 05:22:53 -0700 (PDT)
Received: from [10.1.28.85] (010265703453.cambridge.arm.com [10.1.28.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7AC83F632;
	Tue, 23 Jun 2026 05:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782217378; bh=AS3ac8Xg+L+HLbpB75f/tFX26Y7zBshQVYWslZ0Kumo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O+BtR/rrZBeMOKGocts1cI2w3dFk6T3DYNF8k50KsTJcg0Dv8xRsP2mpjOXfLnOGU
	 yqKLF1taBDUA6Z1uoWcPJi9jykvb8Cl+uRMIOmsGTPC5ouo4nxhDWYS+LU36LyLEuN
	 yqNoNk5jtUtlqSE9OqQwH/R/MzB4+ZTEOodHJmSw=
Message-ID: <3be73669-0aa6-4dec-87ce-37b979953739@arm.com>
Date: Tue, 23 Jun 2026 13:22:48 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] swiotlb: eliminate per-map atomic contention on
 used/hiwater tracking
To: Michael Kelley <mhklinux@outlook.com>, Jun Miao <jun.miao@intel.com>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "chenhgs@chinatelecom.cn" <chenhgs@chinatelecom.cn>,
 "fan.du@intel.com" <fan.du@intel.com>, LKML <linux-kernel@vger.kernel.org>
References: <20260622122114.2563254-1-jun.miao@intel.com>
 <SN6PR02MB415757A3F56268BE3AF01D35D4EE2@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <SN6PR02MB415757A3F56268BE3AF01D35D4EE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-06-23 3:35 am, Michael Kelley wrote:
[...]
> Another approach to the contention problem would be to have a separate
> CONFIG option that is narrower than CONFIG_DEBUG_FS, so that the
> computation of the hiwater mark can be dropped entirely in production
> environments. Or the setting could be dynamic at runtime via a
> static_call, defaulting to not computing the hiwater mark while still
> allowing a sysadmin to turn it on to see workload usage of the swiotlb.

Yeah, in terms of usefulness to admins, I'd imagine a sysctl to enable 
stats collection would probably be better than a config option - I doubt 
that most folks who just want to tune a standard distro kernel for their 
VM workload would want to have to rebuild it. A command line option 
might also be a fair compromise if that's how the eventual SWIOTLB 
tuning will be controlled anyway.

Thanks,
Robin.
