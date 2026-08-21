Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02620426431
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.212.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325716; cv=none; b=SWMdPN0CDokSdIXn/qpriNK2tENs+3j2FqE7A6Yh57V+bhTU7tv/70ZQOcx/znJZ+OksiBMRW4820htyMlxqRRJY0I/qtvLI99AFAwDR1r+YZVYaOO3JI9SrkwxfEnXSYUxjkMZHB/2pEZI10Eej1JKp4ax7FYkFBcJKMTqiwnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325716; c=relaxed/simple;
	bh=n3eLFYyFJGvlspqhrg87EXfB+uryTWRd4rmX7AdnMWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucdCaYOoxQDejznMBlenVAz496IOZGBmIUf7hrmG3hJg5igqTddajppdmYhe1+19gNaN9Ra932hlrjR7yeAHB3TAfo3qkzcIwSDlOb4vzw4+LdijgV2EgBCHApm4GFpgV5aPxxoeZezQl7t77g1xlkUqGsvJeq1KmyFadVYxMik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=gI1otO+L; arc=none smtp.client-ip=23.83.212.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="gI1otO+L"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B189E4618D3;
	Fri, 21 Aug 2026 14:02:16 +0000 (UTC)
Received: from pdx1-sub0-mail-a245.dreamhost.com (trex-green-3.trex.outbound.svc.cluster.local [100.117.167.247])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4AEE04617FA;
	Fri, 21 Aug 2026 14:02:12 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Continue-Callous: 60438e84001200e2_1787320936493_1558832494
X-MC-Loop-Signature: 1787320936493:1336680990
X-MC-Ingress-Time: 1787320936492
Received: from pdx1-sub0-mail-a245.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.167.247 (trex/8.0.2);
	Fri, 21 Aug 2026 14:02:16 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a245.dreamhost.com (Postfix) with ESMTPSA id 4hRMSM5Yxfz105D;
	Fri, 21 Aug 2026 07:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1787320932;
	bh=ZRLuj9Xk3RZA9EvUsFuxQsb2cwatVz4OG03wU5z0P88=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=gI1otO+LM4Nzt198FNaV/f7jw/s84jvdzipRgLtxFWorRp1Xmgn3iytdw15q4qTte
	 M+QKnV0cin0+AP0IxDU5GgpY6lQCAlEEfmmGyiXF5giF9LAfgGYTHm1aJ4vkXLGe06
	 jRibLSq3bbXrlttVHWBOJcSJ7O2mIf7xj+6ZHilJE+jOi9JD+Net73KaZsfEytQhdm
	 uogggZpZZ0JAjnPu9Sn6yfJQQtCf2IDesFqG+IN6S/afdgkCsZPcs1vjXjqTREg/Ku
	 SGDqEAABR28FLK87Fa9IW9UFzzVX07t9q70vUyj5PUqBBULio99e4PRITVriIgomqf
	 Cesj7eKDQnA2A==
Date: Fri, 21 Aug 2026 07:02:08 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, mcgrof@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/iova: Clear the slab cache pointers when
 destroying them
Message-ID: <20260821140208.xn5ntlotumk3huy2@offworld>
References: <20260816184339.420285-1-dave@stgolabs.net>
 <032dc5ff-3930-43ab-ad82-2f92b16c65e6@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <032dc5ff-3930-43ab-ad82-2f92b16c65e6@arm.com>
User-Agent: NeoMutt/20220429

On Mon, 17 Aug 2026, Robin Murphy wrote:

>On 16/08/2026 7:43 pm, Davidlohr Bueso wrote:
>>Both iova_cache_get() failure path and iova_cache_put() destroy the two
>>slab caches without clearing the pointers, leaving them dangling with
>>iova_cache_users at zero. The next iova_cache_get() then re-enters the
>>respective block, and if it fails early enough to reach 'out_err' before
>>re-creating both caches, it calls kmem_cache_destroy() a second time on
>>whichever cache is still stale:
>>
>>   BUG: KASAN: slab-use-after-free in iova_cache_get+0x216/0x280
>>   Read of size 1 at addr ffff888001b9fdc0 by task swapper/0/1
>>   CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.2.0-rc1 #2
>>   Call Trace:
>>    <TASK>
>>    dump_stack_lvl+0x53/0x70
>>    print_report+0xce/0x620
>>    kasan_report+0xce/0x100
>>    __kasan_check_byte+0x36/0x50
>>    kmem_cache_destroy+0x1b/0x1c0
>>    iova_cache_get+0x216/0x280
>>    ...
>>   Freed by task 1:
>>    kasan_save_stack+0x33/0x60
>>    kasan_save_track+0x14/0x30
>>    kasan_save_free_info+0x3b/0x60
>>    __kasan_slab_free+0x43/0x70
>>    kmem_cache_free+0xbe/0x3c0
>>    kobject_put+0x14d/0x280
>>    iova_cache_put+0x8e/0xd0
>>
>>Clear both pointers after destroying them, in both places.
>
>Out of curiosity, what architecture/kernel config have you found this
>with? I see the logic, but off the top of my head I'm somewhat
>struggling to imagine the scenario in which iova_cache_get() succeeds,
>the last user (so no iommu-dma) cleanly calls iova_cache_put() to be
>able to free the state, then another iova_cache_get() fails. Is
>everything else also falling apart in flames anyway at this point?

This was on x86-64, triggered through a dma fuzzer/stresser, but
could not reproduce this after leaving it running all week. What could
have happened, not sure, was that the program patched the code to
trigger the failure points, for which you can ignore this patch I guess.

Thanks,
Davidlohr
