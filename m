Return-Path: <SRS0=hFKH=2D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A59C2D0BF
	for <iommu@archiver.kernel.org>; Fri, 13 Dec 2019 09:33:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78A6F2077B
	for <iommu@archiver.kernel.org>; Fri, 13 Dec 2019 09:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Gu8Vs9E+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A6F2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0741687236;
	Fri, 13 Dec 2019 09:33:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EUgr6AgqN6uO; Fri, 13 Dec 2019 09:33:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 67069871BF;
	Fri, 13 Dec 2019 09:33:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E1F0C1D7C;
	Fri, 13 Dec 2019 09:33:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC929C0881
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 09:33:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DB5838720E
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 09:33:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KkqmduyImDZY for <iommu@lists.linux-foundation.org>;
 Fri, 13 Dec 2019 09:33:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 494C0871BF
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 09:33:38 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id bc8so989969plb.12
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 01:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=KY94rQv5/loJQD4i0BZGc7jhqbYj6PtDGEFoVjzh9zM=;
 b=Gu8Vs9E+vFF8vFlZQHcm1Yilp0uo8ZYeY6s7APVwLAVv5v7A2KXo3Kxip03kVC8Qkj
 O6PwgC2GHF+SKubgVvhFvfGrBl+qy6z0udspUM2ac4H/mev6Y16cSo19BM5izD2spoip
 CTi0RjECdgrDGROEss9lxv5N0Z4RQgv8fnpmnHedCtGzypL7egdRd5P8NPkY7cvwB6eC
 iV71N7KxJhG81qEhh9VYzoVv1gEo9U6MXwLuKDzocT6jKASm+eULMERULn8xU390DPZ/
 GYR6LXfSyJLJ1IWjHcKALyk/0phkNfS6aLbfPIehzQEPOZvIXPv/pQ7oUfRTqc0zYEmk
 2b3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=KY94rQv5/loJQD4i0BZGc7jhqbYj6PtDGEFoVjzh9zM=;
 b=TEcDj+jMk2/pRCDA4oE3wxV4DbSDeWzGQlKRC4h/Z79wSUhcbcMBb5zPUV8NkqXdnn
 BpvcCvjVvIvVe1mbeRqAnsEbQMx60TCsripeieHHaOGmTnBjiigek5JHPdoDRBgHgnRN
 s2/03oD9jUF6IdVNOaI+bRLwkNNZWoc4fHMrtiqYdHh105XYHsgR7LowJSQZjm5siWGH
 QZq6O8OntzhmBTU6plhjnZr6C+L2nPVkQlLBTrKKX/VYegDY4i3FkT9JiCVfksG55Nd5
 Sf9eNIXPidJUKvdH9xVKT4PoA057bpPc3mSS3iQjcXg66aMZ6wiHi9wnaPlN4x6Iga89
 aE4Q==
X-Gm-Message-State: APjAAAWbSMnkDNnr/MJFsJoYwNacbprDKw+UU6hJKLQ5sCnATSSw4LMX
 af/4tC6zGTw1TbreTAdmCwzzJQ==
X-Google-Smtp-Source: APXvYqzb/2sdxXklFn5oYYxrkweQPjFaA8rYmyPMWm55R8sUbiLqH6XoQbqXDLTUeCKbBETB0Sy8Ow==
X-Received: by 2002:a17:90a:db49:: with SMTP id
 u9mr14893672pjx.13.1576229617625; 
 Fri, 13 Dec 2019 01:33:37 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id w12sm10425259pfd.58.2019.12.13.01.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2019 01:33:36 -0800 (PST)
Date: Fri, 13 Dec 2019 01:33:35 -0800 (PST)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [bug] __blk_mq_run_hw_queue suspicious rcu usage
In-Reply-To: <alpine.DEB.2.21.1912121550230.148507@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1912130121500.215313@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1909041434580.160038@chino.kir.corp.google.com>
 <20190905060627.GA1753@lst.de>
 <alpine.DEB.2.21.1909051534050.245316@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1909161641320.9200@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1909171121300.151243@chino.kir.corp.google.com>
 <1d74607e-37f7-56ca-aba3-5a3bd7a68561@amd.com>
 <20190918132242.GA16133@lst.de>
 <alpine.DEB.2.21.1911271359000.135363@chino.kir.corp.google.com>
 <20191128064056.GA19822@lst.de>
 <alpine.DEB.2.21.1912121550230.148507@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: Jens Axboe <axboe@kernel.dk>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 "Singh, Brijesh" <brijesh.singh@amd.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ming Lei <ming.lei@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Peter Gonda <pgonda@google.com>, Keith Busch <kbusch@kernel.org>,
 Jianxiong Gao <jxgao@google.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, 12 Dec 2019, David Rientjes wrote:

> Since all DMA must be unencrypted in this case, what happens if all 
> dma_direct_alloc_pages() calls go through the DMA pool in 
> kernel/dma/remap.c when force_dma_unencrypted(dev) == true since 
> __PAGE_ENC is cleared for these ptes?  (Ignoring for a moment that this 
> special pool should likely be a separate dma pool.)
> 
> I assume a general depletion of that atomic pool so 
> DEFAULT_DMA_COHERENT_POOL_SIZE becomes insufficient.  I'm not sure what 
> size any DMA pool wired up for this specific purpose would need to be 
> sized at, so I assume dynamic resizing is required.
> 
> It shouldn't be *that* difficult to supplement kernel/dma/remap.c with the 
> ability to do background expansion of the atomic pool when nearing its 
> capacity for this purpose?  I imagine that if we just can't allocate pages 
> within the DMA mask that it's the only blocker to dynamic expansion and we 
> don't oom kill for lowmem.  But perhaps vm.lowmem_reserve_ratio is good 
> enough protection?
> 
> Beyond that, I'm not sure what sizing would be appropriate if this is to 
> be a generic solution in the DMA API for all devices that may require 
> unecrypted memory.
> 

Secondly, I'm wondering about how the DMA pool for atomic allocations 
compares with lowmem reserve for both ZONE_DMA and ZONE_DMA32.  For 
allocations where the classzone index is one of these zones, the lowmem 
reserve is static, we don't account the amount of lowmem allocated and 
adjust this for future watermark checks in the page allocator.  We always 
guarantee that reserve is free (absent the depletion of the zone due to 
GFP_ATOMIC allocations where we fall below the min watermarks).

If all DMA memory needs to have _PAGE_ENC cleared when the guest is SEV 
encrypted, I'm wondering if the entire lowmem reserve could be designed as 
a pool of lowmem pages rather than a watermark check.  If implemented as a 
pool of pages in the page allocator itself, and today's reserve is static, 
maybe we could get away with a dynamic resizing based on that static 
amount?  We could offload the handling of this reserve to kswapd such that 
when the pool falls below today's reserve amount, we dynamically expand, 
do the necessary unencryption in blockable context, and add to the pool.  
Bonus is that this provides high-order lowmem reserve if implemented as 
per-order freelists rather than the current watermark check that provides 
no guarantees for any high-order lowmem.

I don't want to distract from the first set of questions in my previous 
email because I need an understanding of that anyway, but I'm hoping 
Christoph can guide me on why the above wouldn't be an improvement even 
for non encrypted guests.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
