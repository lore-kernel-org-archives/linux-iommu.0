Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BBF2DC334
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 10:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768819128; cv=none; b=DTyYqe7ukKUlUOmDP7YfY5civEOdL6+/LZNnnJFWAYqBKxPpA8qHhHRVeSWtAQ/ShdWpruXasQqP3baaXlPuJ8yHnpJD8di/9az/qrO018QxBY9aUx/Dl+V68NDQUIye6yxTY1QTxHVwoamReOxh2LcESCxavoXMiiMq0M+jaG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768819128; c=relaxed/simple;
	bh=vYRiHaxSMY/GrPhmusiLm/wN6g35BdjNX3fcj6y1Yxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=CrJOHGDEQz7s5KkXaYTvD1Uj/mNLv/fMZKpdHZ/vHAXbyas7tbiSvHfYL1Z9pGBP6l/dD3hpL6vAZmQgZxdywq0qlf2+cQfBxJ3UQoINioLXjNtsk9iy4f+VwRB8luop8+2NA33dGFVolNPsx59TJ8m8wNvXAXmIG+PZOsy28VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ggTC86J0; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ggTC86J0"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260119103844euoutp01157c9689ddf6c80951a4993cadd75dc1~MG59EE-ay1950019500euoutp01J
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 10:38:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260119103844euoutp01157c9689ddf6c80951a4993cadd75dc1~MG59EE-ay1950019500euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768819124;
	bh=h6T1OAseONU5xESAp7DldoRF/tx4f3Urlb72aBL0shY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ggTC86J0tuNir92HdO3ZuqKiwG+33RBa5m/KJMQHzp307IUNPZHcXARfyLutyZBlp
	 BwxzhDEaWMHOPDuafLcV+9LuXVZvuDCF3v0WlY7wPgYq29mYKCMJ8ETrC0HiNebEnF
	 3D/nLvqBlON+m5EAOKDFvMK3U0BDf71e8IrdgQZk=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260119103843eucas1p13969f70041187467385971a512493b86~MG58fQVze1992819928eucas1p1p;
	Mon, 19 Jan 2026 10:38:43 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260119103842eusmtip18efa3015d962d36d6aae889482359cc9~MG57VTnAg2814528145eusmtip1K;
	Mon, 19 Jan 2026 10:38:42 +0000 (GMT)
Message-ID: <89f8895f-436d-4a73-a2c8-d61a2f4ee41a@samsung.com>
Date: Mon, 19 Jan 2026 11:38:42 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] of: reserved_mem: Allow reserved_mem framework detect
 "cma=" kernel param
To: Rob Herring <robh@kernel.org>
Cc: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>,
	ye.li@oss.nxp.com, kernel@oss.qualcomm.com, saravanak@google.com,
	akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, robin.murphy@arm.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux.dev,
	quic_c_gdjako@quicinc.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAL_JsqK5QEZfyRTDY4z88mX_eYENibea1ZM8H_bEfCCsOOwY4A@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260119103843eucas1p13969f70041187467385971a512493b86
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251210002053eucas1p1d1408ad0fb49a49bf4371687f8df7395
X-EPHeader: CA
X-CMS-RootMailID: 20251210002053eucas1p1d1408ad0fb49a49bf4371687f8df7395
References: <CGME20251210002053eucas1p1d1408ad0fb49a49bf4371687f8df7395@eucas1p1.samsung.com>
	<20251210002027.1171519-1-oreoluwa.babatunde@oss.qualcomm.com>
	<X-TH#1.CAL_JsqL6VVQ7K_ZAbHJ8Gb7ei_jusLx6wRn=AdOVgV50dX0ejQ@mail.gmail.com>
	<99dc91c9-59fd-47c5-b1d9-157bda86ad59@samsung.com>
	<CAL_JsqK5QEZfyRTDY4z88mX_eYENibea1ZM8H_bEfCCsOOwY4A@mail.gmail.com>

On 18.12.2025 15:42, Rob Herring wrote:
> On Thu, Dec 18, 2025 at 3:55 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> On 10.12.2025 15:07, Rob Herring wrote:
>>> On Tue, Dec 9, 2025 at 6:20 PM Oreoluwa Babatunde
>>> <oreoluwa.babatunde@oss.qualcomm.com> wrote:
>>>> When initializing the default cma region, the "cma=" kernel parameter
>>>> takes priority over a DT defined linux,cma-default region. Hence, give
>>>> the reserved_mem framework the ability to detect this so that the DT
>>>> defined cma region can skip initialization accordingly.
>>> Please explain here why this is a new problem. Presumably the
>>> RESERVEDMEM_OF_DECLARE hook after commit xxxx gets called before the
>>> early_param hook. And why is it now earlier?
>>>
>>> I don't really like the state/ordering having to be worried about in 2 places.
>> I also don't like this spaghetti, but it originates from
>> commit 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved
>> memory regions are processed") and the first fixup for it: 2c223f7239f3
>> ("of: reserved_mem: Restructure call site for
>> dma_contiguous_early_fixup()").
> Honestly, this code wasn't great before. Every time it is touched it
> breaks someone.

Indeed it got a bit complicated and needs some improvement, but first I 
want to fix the the reported regression. This patch does this and it 
looks that there are no ideas how to fix this in a different way. Rob, 
could I apply it via dma-mapping-fixes?

>> It looks that it is really hard to make reserved memory
>> initialization fully dynamic assuming that the cma related fixups have
>> to be known before populating kernel memory pages tables. I also advised
>> in
>> https://lore.kernel.org/all/be70bdc4-bddd-4afe-8574-7e0889fd381c@samsung.com/
>> to simply increase the size of the static table to make it large enough for the sane use cases, but
>> it turned out that this approach was already discussed and rejected:
>> https://lore.kernel.org/all/1650488954-26662-1-git-send-email-quic_pdaly@quicinc.com/
> I guess the question is what's a sane limit? After 128, are we going
> to accept 256? I really suspect we are just enabling some further
> abuse of /reserved-memory downstream. For example, I could imagine
> there's micromanaging the location of media/graphics buffers so they
> end up in specific DRAM banks to optimize accesses. No one ever wants
> to detail why they want/need more regions.
>
>> Maybe it would make sense to revert the mentioned changes and get back
>> to such simple approach - to make the size of the static table
>> configurable in the Kconfig?
> I'd rather not resort to a kconfig option.
>
> We could go back to processing all the regions at the beginning
> (growing the static size), and then just shrinking allocation. Or
> maybe it could just be freed entirely. I don't think we really need to
> keep the state around forever.

I will check if this can be refactored somehow.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

