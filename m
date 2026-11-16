Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794836740;
	b=0cX8cKmLL4fTEWl8auzwnE8GgUnIoigBSJw8lcR1DYAyC8Zq6nSxDJLYtgflFK47dcjZ
	 lAfJIeut8oDlX03KukJXczP0Olgp+6NDIBEh5k2OlvYWzVTHeo8GkCn4LmyGP+Bqzwmwg
	 s/dyrMGl4VePsmsiTK9N145jT5l/6UO+2lpc/JRsPPN5FogItDgMEhOG0aGnHzCx8qNdH
	 OWNmgAK5LOImOq1BaCUJ2N/ANs509W3fQr1rHtp0jCXtiygL81Pq/rIaqldDN+631O4pA
	 /5hB99DvUBvElsA3Q8TcJ5Br1+WXyYysnv65jAhYUsugKIeHVs3+EdOX7LRw6OmbYkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836740;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=eshOQbcKbrMl1i+qtIVojA3Znht4HEAuvnYf7G2Dhas=;
	b=o0roGyZwNDj55Vcq4T8aDmV0MW2vV3qJuVyvXj15HCppU+4NSyUagN5jLwD7YT0pgQmY
	 u/sgg2N8rd5cIS5nSeB7s+Dy5ytyFd6dmssuEkmnQXJVEV+ROLbNEK4wqAytzx/lsrUsB
	 JkCJBorSZkkzAKqO+p5v7JlSPpSEg4by+tk2sEbe4TjpMf2i8yzFDgX+K2aiSAawGr556
	 DuYg92UVtlaFgrWaYYojiojIUaPTzzJNVF9QmScUhJkhCWlPol+661ruXh7assA99rthC
	 zc45D1z1RQs04adRYSUxOuqdqyzo3vK18WClBh9+Xm8eu+VeqzCWiO9C8qFbEGmtcJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="EY/qHBm4";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81A5606A332
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 13:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A81A5606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=EY/qHBm4
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 945F81713;
	Mon, 16 Nov 2026 05:45:29 -0800 (PST)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8CB93F632;
	Mon, 16 Nov 2026 05:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794836732; bh=kFZlstDwxM/ommFvM0+u8jqde33w4UioUYPnawX+A/U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EY/qHBm4tv3i3Oh8jE6/w3KaICV5E08ozfG3EJ8d4hqnwdPP9UsOqYnNZTUBMMilz
	 Tl1oPA+6EwAyBOyCHwmHQ5/PGN+s+Jv6wMmNniVW7jlk0lxExhTrp/vAJ9VZaCMApN
	 6xeDkOQP/dtDwDc+F6Fx4Utav5sUwb3H19EwLyHQ=
Message-ID: <609175e0-4e1c-4130-a9f1-0cfc7815c134@arm.com>
Date: Mon, 16 Nov 2026 13:45:25 +0000
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-debug: Avoid uninitialized hash traversal in mapping
 dumps
To: Anthony Iliopoulos <ailiop@suse.com>, Avi Weiss <thnkslprpt@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261115082505.2012573-2-thnkslprpt@gmail.com>
 <E9412813-7A76-46D0-94E5-0537E9FF5DB8@suse.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <E9412813-7A76-46D0-94E5-0537E9FF5DB8@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/11/2026 12:09 am, Anthony Iliopoulos wrote:
> On Sun, Nov 15, 2026 at 10:25:06AM +0200, Avi Weiss wrote:
>> Booting with dma_debug=off causes dma_debug_init() to return before
>> initializing the hash buckets. The debugfs dump file is registered
>> independently, so reading it traverses an uninitialized list and
>> triggers a NULL pointer dereference in dump_show(). The
>> debug_dma_dump_mappings() helper has the same unchecked traversal.
> 
> So the debug_dma_dump_mappings() issue seems preexisting (the risk was
> there since its introduction in commit ac26c18bd35d, given that it
> doesn't check if dma_debug has been initialized), and it is not related
> to decoupling the debugfs init.
> 
>> Skip both dump paths until dma_debug_initialized is set. Check the
>> initialization state rather than global_disable so that mappings
>> recorded before DMA debugging disables itself at runtime remain
>> available.
> 
> I suppose this makes sense for debug_dma_dump_mappings, but I am not
> sure we need this for dump_show. See my next comment.
> 
>> With CONFIG_DMA_API_DEBUG=y and CONFIG_DEBUG_FS=y, reading the dump
>> with dma_debug=off triggers an oops in the unpatched kernel. The
>> patched kernel returns an empty dump, while dumping with DMA debugging
>> enabled still returns mapping information.
>>
>> Fixes: 173735c346c4 ("dma-debug: fix debugfs initialization order")
>> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
>> ---
>>   kernel/dma/debug.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
>> index 36c1f7cbb2ae..2f487246d8ce 100644
>> --- a/kernel/dma/debug.c
>> +++ b/kernel/dma/debug.c
>> @@ -543,6 +543,9 @@ void debug_dma_dump_mappings(struct device *dev)
>>   	int idx;
>>   	phys_addr_t cln;
>>   
>> +	if (!dma_debug_initialized)
>> +		return;
>> +
>>   	for (idx = 0; idx < HASH_SIZE; idx++) {
>>   		struct hash_bucket *bucket = &dma_entry_hash[idx];
>>   		struct dma_debug_entry *entry;
>> @@ -576,6 +579,9 @@ static int dump_show(struct seq_file *seq, void *v)
>>   	int idx;
>>   	phys_addr_t cln;
>>   
>> +	if (!dma_debug_initialized)
>> +		return 0;
>> +
> 
> I think it makes better sense to skip creating debugfs files altogether
> when debugging is disabled, which was also the case before 15b28bbcd567.

TBH there's probably an argument for just getting rid of 
debug_dma_dump_mappings() now too... Hands up anyone who's using a 
20-year-old AMD GART as any kind of development machine at all, let 
alone for DMA API debugging of new drivers?

Anyone?

Cheers,
Robin.

> 
>>   	for (idx = 0; idx < HASH_SIZE; idx++) {
>>   		struct hash_bucket *bucket = &dma_entry_hash[idx];
>>   		struct dma_debug_entry *entry;
>>
>> base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
>> -- 
>> 2.43.0
>>
> 
> Regards,
> Anthony

