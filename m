Return-Path: <SRS0=ocWU=2F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2EDC43603
	for <iommu@archiver.kernel.org>; Sun, 15 Dec 2019 05:38:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E02152465B
	for <iommu@archiver.kernel.org>; Sun, 15 Dec 2019 05:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="cVq5RUxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02152465B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AFBCF20365;
	Sun, 15 Dec 2019 05:38:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pt-FztwCWMjg; Sun, 15 Dec 2019 05:38:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D1A2F20347;
	Sun, 15 Dec 2019 05:38:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1FA1C18DD;
	Sun, 15 Dec 2019 05:38:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1022EC0881
 for <iommu@lists.linux-foundation.org>; Sun, 15 Dec 2019 05:38:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F30B9875A1
 for <iommu@lists.linux-foundation.org>; Sun, 15 Dec 2019 05:38:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tnrniKRYWbnf for <iommu@lists.linux-foundation.org>;
 Sun, 15 Dec 2019 05:38:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9AD8687610
 for <iommu@lists.linux-foundation.org>; Sun, 15 Dec 2019 05:38:21 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id b9so1724309pgk.12
 for <iommu@lists.linux-foundation.org>; Sat, 14 Dec 2019 21:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=rYhW8ESLkaBmTx7qrwRV9ukpRcsTp5ZieGL9xLqhxqg=;
 b=cVq5RUxuoKRkBf5bRNowyvHttDHrpqivGM7mkFO6t77Q5EJexqHpl9Htjk0T96CQuj
 S0G8JrJ4G3Hyg890YJb+MHVqaVjA2svy6Fi8IFebbuKlxLnaLqtbanrJq96QUn9u3fs7
 G0FYimTXWqGNC7YEhZue5i/kIMXHrw2X4eJY6L76matWOp3yHT39QdazEmINyfGXUI6j
 asmhjJRETatjXBx6n2SAcjmYHRehILcZHIyFz/6Au0vmc1vfu9mC5y1d22mvBoPUbBw2
 sVWZuvDQE6jMJgettug1rPDLOFXGN3IZs6NvYKq2v9Z57VHR+jRDNWx85Hf7OxkkZIBt
 2+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=rYhW8ESLkaBmTx7qrwRV9ukpRcsTp5ZieGL9xLqhxqg=;
 b=Nga4/xaB8yc0RVc9C7RMzVaByanJdxLVHScBtrKWyJf8HfroP71Aquio90q/IPG5fU
 HlUvx0sYWv6zD6BoiQU/FuAb9q1wo9Rm45X2KE7hMija6Q8n8ean4ZAn+LuFI8BAIWfT
 rtuR3yPHLbj0kLUQwFyfYyHqBwGs7c2TK2xyJkumQB+MaV6ngS/0rPB7vSBabgmuaZRS
 TtidLHfFZqSAO4w2zwLLCk1dI2v2kzfXtaeK/1yDRbn5iiQZhc0hw4zfAtUQZLicFWg+
 XKGyzU3XRBx6imrlnRC+9ty8L0KGZzAkSmPyouxDrhb8TtnkR2tft/k8wxeIQ4mVi4BL
 5HcA==
X-Gm-Message-State: APjAAAWjBceAbkjVviMQ1J6YV/fZw48DWCd1+10clvdiaOETX+hm+5rC
 lXn09W4m215jVvbpc07vrw1QSg==
X-Google-Smtp-Source: APXvYqzT+FaHGqEnJrAVRzuXE5zg4gCcrhA3as3C3sjQD2G5tvRVpe7lYVzaZ7Z4aaCqB2S1c5AXMw==
X-Received: by 2002:a62:3043:: with SMTP id w64mr9342707pfw.227.1576388301007; 
 Sat, 14 Dec 2019 21:38:21 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id q13sm14923566pjc.4.2019.12.14.21.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Dec 2019 21:38:19 -0800 (PST)
Date: Sat, 14 Dec 2019 21:38:18 -0800 (PST)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [bug] __blk_mq_run_hw_queue suspicious rcu usage
In-Reply-To: <alpine.DEB.2.21.1912121550230.148507@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1912142118080.202749@chino.kir.corp.google.com>
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

Optimizations involving lowmem reserve ratio aside, is it ok that 
CONFIG_AMD_MEM_ENCRYPT develops a dependency on DMA_DIRECT_REMAP because 
set_memory_decrypted() must be allowed to block?

If so, we could allocate from the atomic pool when we can't block and the 
device requires unencrypted DMA from dma_direct_alloc_pages().  I assume 
we need this to be its own atomic pool specifically for 
force_dma_unencrypted() devices and to check addr_in_gen_pool() for this 
new unencrypted pool in dma_direct_free_pages().

I have no idea how large this unencrypted atomic pool should be sized.  We 
could determine a nice default and grow size for nvme itself, but as 
Christoph mentioned many drivers require non-blockable allocations that 
can be run inside a SEV encrypted guest.

Trivial implementation would be to just double the size of the unencrypted 
pool when it reaches half capacity.  Perhaps done with GFP_KERNEL | 
__GFP_DMA allocations in a workqueue.  We can reclaim from ZONE_DMA or 
ZONE_DMA32 in this context but when that fails I'm not sure if it's 
satisfactory to just fail the dma_pool_alloc() when the unecrypted pool 
runs out.

Heuristics can be tweaked, of course, but I want to make sure I'm not 
missing anything obvious with this approach before implementing it.  
Please let me know, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
