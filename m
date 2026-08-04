Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA5C45C71E
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840949; cv=none; b=oBNjS2TlMUOGXDGar5kmpGUJBCVQuqt/WFNbIzHA0G73CqceApeLIjdco8HAfCbw1GS9WyHsCfW0g0Vkl6K1G87egxpnh2DzyVY0FqM5ZiDAGjW9vCdtODOOSz5OBd4vQ32eX8lna1RMr8GL7yzM1aGqRT3EA9cGywgwJlvXpyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840949; c=relaxed/simple;
	bh=tbr5O2Rz09amCN8AJoq0IHBDDUWPNm4xpsyW+Pt+Lm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=IMcR/sReICtFvzmc1N1hOe80V+I7DmEYEKZm0X1nBHxXW+Lb88zJmQ4bd/PmyQBdS8U0yBfIKmDRT0bI/WHUKk54lZVbfkpcS+mp3dsNnFrYb/ASD8Pvcaki6jlpWpZucLtW2ydnXvao1kXeCxDyxKECz1zYlDO/ZRvB1Zde3Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fzkTsbOR; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fzkTsbOR"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260804105540euoutp0102645c8756436929ab81aa5e8c8422d0~IlN_pJ0wd0572305723euoutp01H
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 10:55:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260804105540euoutp0102645c8756436929ab81aa5e8c8422d0~IlN_pJ0wd0572305723euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1785840940;
	bh=2+cuFZcGVamLpYAiEx+DVb9udYvPUP5J4cqO1R1HvVQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=fzkTsbORdss/kFbVVYfbzQNxpQlKWxxN7hlt+8pGNGD2z6iBgyb3tv4rh8sfysgdP
	 hb3JSmgiq6eFIVlosnarolHmgix3ETriWciidoS0oA2uUBAXXyrWi3UXGg/fLPxZ5c
	 kYxp7Csx4Bjr6edlHQ2yJimDBMHUKI8fusKZdVyk=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260804105540eucas1p16cd7c89a310c02a9d008a9fc4a60bec8~IlN_ZrEEJ2642926429eucas1p1e;
	Tue,  4 Aug 2026 10:55:40 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260804105539eusmtip13c8a59c9c8add51122ea98af63dfe5cb~IlN98JcbD0518005180eusmtip1R;
	Tue,  4 Aug 2026 10:55:39 +0000 (GMT)
Message-ID: <8e51a0f6-b73e-40a9-a157-aa31b5106320@samsung.com>
Date: Tue, 4 Aug 2026 12:55:39 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma/swiotlb: make high watermark tracking boot-time
 opt-in
To: Michael Kelley <mhklinux@outlook.com>, Frank Chen
	<frankchen158@126.com>, "hch@lst.de" <hch@lst.de>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "fan.du@intel.com"
	<fan.du@intel.com>, "jun.miao@intel.com" <jun.miao@intel.com>,
	"chenhgs@chinatelecom.cn" <chenhgs@chinatelecom.cn>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <BN7PR02MB41489054FA36992B3DB2800FD4C32@BN7PR02MB4148.namprd02.prod.outlook.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260804105540eucas1p16cd7c89a310c02a9d008a9fc4a60bec8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260720183047eucas1p2bc1cb9914937542d91afa98096fd3b2d
X-EPHeader: CA
X-CMS-RootMailID: 20260720183047eucas1p2bc1cb9914937542d91afa98096fd3b2d
References: <20260622122114.2563254-1-jun.miao@intel.com>
	<20260714032520.1058536-1-frankchen158@126.com>
	<CGME20260720183047eucas1p2bc1cb9914937542d91afa98096fd3b2d@eucas1p2.samsung.com>
	<BN7PR02MB41489054FA36992B3DB2800FD4C32@BN7PR02MB4148.namprd02.prod.outlook.com>

On 20.07.2026 20:30, Michael Kelley wrote:
> From: Frank Chen <frankchen158@126.com> Sent: Monday, July 13, 2026 8:25 PM
>> From: chenhuguanshen <chenhgs@chinatelecom.cn>
>>
>> Under heavy concurrent DMA traffic on CoCo VMs, inc_used_and_hiwater()
>> performs an atomic_long_add_return() plus a CAS loop on the global
>> used_hiwater, and dec_used() performs an atomic_long_sub() on total_used.
>> All CPUs contend on the same cacheline, causing measurable throughput
>> degradation at scale.
>>
>> Historically these counters were only compiled in under CONFIG_DEBUG_FS,
>> which means production kernels with debugfs paid the atomic overhead
>> unconditionally once the symbols were present. Make the tracking
>> boot-time opt-in instead so that it is disabled by default with near-zero
>> overhead via static_call, and can be enabled via "swiotlb=track_hiwater"
>> parameter on demand for debugging.
>>
>> Changes:
>>
>> - The previous inc_used_and_hiwater() maintained a separate atomic
>>   total_used counter for accurate hiwater updates. This is replaced with
>>   mem_used() which sums across areas. While less precise (no cross-area
>>   locking), the result is adequate for high watermark statistics and
>>   avoids the overhead of maintaining total_used on every alloc/free.
> I'm not sold on giving up an accurate hiwater calculation. If it's
> optional, let's have the option be to maintain total_used on every
> alloc/free so the hiwater calculation is accurate.
>
> Maintaining hiwater based on mem_used() is already pretty low
> overhead in that it only does a global atomic operation if the hiwater is
> raised. After a startup transient that establishes a typical steady-state
> hiwater, most ongoing swiotlb alloc/free operations won't raise
> the hiwater and so won't do any atomic operations to maintain it.
>
> To recap, there are three levels of hiwater maintenance:
>
> 1) None
> 2) Based on the less precise mem_used()
> 3) Based on an atomically update global total_used value
>
> The perf difference between #1 and #2 seems minimal outside of
> the initial ramp to a steady-state hiwater value. The perf impact
> of #3 can indeed be more significant, especially at high CPU counts.
>
> Having the kernel boot line offer all three is arguably overkill.
> I'd suggest offering #1 and #3 (with #1 as the default), or #2
> and #3 (with #2 as the default and !CONFIG_DEBUG_FS providing
> #1).
>
> There's another aspect here as well. Robin Murphy had 
> suggested a sysctl option, so that the accurate hiwater maintenance
> could be turned on/off at runtime, not just a boot time. My earlier
> comment about boot time was probably unclear. I was thinking in
> terms of a runtime option that could *also* be set at boot time, which
> sysctl does. But I'll admit that enabling accurate hiwater calculation
> at runtime is tricky because some swiotlb buffers may be allocated
> at the time of the enablement, and total_used could go negative
> when those are freed. For runtime sysctl enablement, would
> probably have to do stop_machine() to freeze everything, and set
> total_used to the value of mem_used() so that everything is
> correct. I haven't worked through all the details.
>
> All that said, I don't want to make too big of an issue out of this,
> and end up over-engineering with complexity that exceeds the
> value. I could be persuaded to have boot time enablement but
> not runtime enablement. I'm less happy with losing entirely
> the accurate calculation (my #3 above) that's in the current
> upstream code.

Indeed keeping the accurate measurements is important to track potential

spikes of hiwater level. However imho it would be enough to use boot time

enablement.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

