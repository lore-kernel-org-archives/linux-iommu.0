Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794922516;
	b=0ZVhYMMv7DxQ9bX+JGtc38ox+1p7bZ6s3LhDEODtYhPcW/g/h9MqUplyA+3mGadp3S06
	 29MJB3i3ieZ2l3aAb3RpbGRaVLOQTUMSrfzgfXE26VCTTPVgW6BFj51077NWRZkzRkp7P
	 vCxlw0Amwj8JXlzcgahzeEBwiTVKv6BQSA9HbaSIgIxUMbAsKrOks0VguqW9IupPSfO82
	 QbA12EqNuj/o0a9ptsfQK2ZzIrC4p7dTlAMEAZuEJKaPDTfv1fHX63+yIwFeXvyf5QoA6
	 vYSo9NGuqm8uxDOYFgps0N22KmJGtP2oP1UBjUia2vJekGQqK1/TP6IDs3cxa+YWyew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794922516;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=EFX2yIyrHAd/8VFoISAI9yJxJbG4dUZg6w3jxNvGRko=;
	b=Beq6JzUKXHxqmX4+1/WblZWX8K8c+bLZ2DwNFtfd0Sw+qyspUI1iZiBeiw10GTL8WudS
	 ryiLk7RRpWg56509X2THVwrVCsGyFWiVQyumw/Bz9bjFmCJFFBMvw1P7oMYIH4qz7f09z
	 0IiaFVBSdlQYinhVRtIqdK893pe8nh9hfLO0S7yY7DYNb0HIfZEo5T6dV9rmZ5MtCfKlB
	 236M3h6oB/4MWIK9QPbwpM4zeLVXSgLK0r1B9b8rIebQZcLDX2ZqsknyWIxQfAHInFdXu
	 hzx6+5TPdUQYrdvQ/QRWsMhz9VeVKDK0UBDIT8Ld0mH/rbgr5AxJyrcKVrGUXDNp+Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=II1s7i5t;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1BC606A331
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 13:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E1BC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=II1s7i5t
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261117133507euoutp0213001ebbee6afb44a017f794bced0f0e~o2IKzavue0882308823euoutp02X
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 13:35:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261117133507euoutp0213001ebbee6afb44a017f794bced0f0e~o2IKzavue0882308823euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794922507;
	bh=EFX2yIyrHAd/8VFoISAI9yJxJbG4dUZg6w3jxNvGRko=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=II1s7i5t7SASuJOymU5Cv0mPRU23QdOzGTVMsq+hjxyw1vzCUCcRSo+WPwMwEKc56
	 /7HEh1fepPaUR2KVfJWACHOD91PuImEcEjD2NJPLHIQ9MiREtAmxI1O3wkD1Z32Gmx
	 Goiti5wvEEH883ohY9hO7gTE3ADwVpn3OCmobOOE=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261117133504eucas1p14aee6e1d3b716ecd4eac84c21058c78d~o2IIkbNDp2647226472eucas1p1D;
	Tue, 17 Nov 2026 13:35:04 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261117133504eusmtip2249a3600a4be2a7cefdbb1bd4ce187e4~o2IILas3v1494014940eusmtip2T;
	Tue, 17 Nov 2026 13:35:04 +0000 (GMT)
Message-ID: <05c05ec4-b321-49d4-acf7-b9fa4223dba9@samsung.com>
Date: Tue, 17 Nov 2026 14:35:04 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-debug: Avoid uninitialized hash traversal in
 mapping dumps
To: Robin Murphy <robin.murphy@arm.com>, Anthony Iliopoulos
	<ailiop@suse.com>, Avi Weiss <thnkslprpt@gmail.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <609175e0-4e1c-4130-a9f1-0cfc7815c134@arm.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261117133504eucas1p14aee6e1d3b716ecd4eac84c21058c78d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261116134536eucas1p1b30ea07e1a1e3be753ff25a653be59a6
X-EPHeader: CA
X-CMS-RootMailID: 20261116134536eucas1p1b30ea07e1a1e3be753ff25a653be59a6
References: <20261115082505.2012573-2-thnkslprpt@gmail.com>
	<E9412813-7A76-46D0-94E5-0537E9FF5DB8@suse.com>
	<CGME20261116134536eucas1p1b30ea07e1a1e3be753ff25a653be59a6@eucas1p1.samsung.com>
	<609175e0-4e1c-4130-a9f1-0cfc7815c134@arm.com>

On 16.11.2026 14:45, Robin Murphy wrote:
> On 16/11/2026 12:09 am, Anthony Iliopoulos wrote:
>> On Sun, Nov 15, 2026 at 10:25:06AM +0200, Avi Weiss wrote:
>>> Booting with dma_debug=off causes dma_debug_init() to return before
>>> initializing the hash buckets. The debugfs dump file is registered
>>> independently, so reading it traverses an uninitialized list and
>>> triggers a NULL pointer dereference in dump_show(). The
>>> debug_dma_dump_mappings() helper has the same unchecked traversal.
>>
>> So the debug_dma_dump_mappings() issue seems preexisting (the risk was
>> there since its introduction in commit ac26c18bd35d, given that it
>> doesn't check if dma_debug has been initialized), and it is not related
>> to decoupling the debugfs init.
>>
>>> Skip both dump paths until dma_debug_initialized is set. Check the
>>> initialization state rather than global_disable so that mappings
>>> recorded before DMA debugging disables itself at runtime remain
>>> available.
>>
>> I suppose this makes sense for debug_dma_dump_mappings, but I am not
>> sure we need this for dump_show. See my next comment.
>>
>>> With CONFIG_DMA_API_DEBUG=y and CONFIG_DEBUG_FS=y, reading the dump
>>> with dma_debug=off triggers an oops in the unpatched kernel. The
>>> patched kernel returns an empty dump, while dumping with DMA debugging
>>> enabled still returns mapping information.
>>>
>>> Fixes: 173735c346c4 ("dma-debug: fix debugfs initialization order")
>>> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
>>> ---
>>>   kernel/dma/debug.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
>>> index 36c1f7cbb2ae..2f487246d8ce 100644
>>> --- a/kernel/dma/debug.c
>>> +++ b/kernel/dma/debug.c
>>> @@ -543,6 +543,9 @@ void debug_dma_dump_mappings(struct device *dev)
>>>       int idx;
>>>       phys_addr_t cln;
>>>   +    if (!dma_debug_initialized)
>>> +        return;
>>> +
>>>       for (idx = 0; idx < HASH_SIZE; idx++) {
>>>           struct hash_bucket *bucket = &dma_entry_hash[idx];
>>>           struct dma_debug_entry *entry;
>>> @@ -576,6 +579,9 @@ static int dump_show(struct seq_file *seq, void *v)
>>>       int idx;
>>>       phys_addr_t cln;
>>>   +    if (!dma_debug_initialized)
>>> +        return 0;
>>> +
>>
>> I think it makes better sense to skip creating debugfs files altogether
>> when debugging is disabled, which was also the case before 15b28bbcd567.
>
> TBH there's probably an argument for just getting rid of debug_dma_dump_mappings() now too...

Agreed, remove it completely and register the debugfs entries only if (dma_debug_initialized).


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

