Return-Path: <SRS0=hFKH=2D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FE9C43603
	for <iommu@archiver.kernel.org>; Fri, 13 Dec 2019 00:13:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43289206E2
	for <iommu@archiver.kernel.org>; Fri, 13 Dec 2019 00:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="O/yuRss+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43289206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 03439889EE;
	Fri, 13 Dec 2019 00:13:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X3fzmeiXwqJ5; Fri, 13 Dec 2019 00:13:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 61948889D5;
	Fri, 13 Dec 2019 00:13:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45B27C1796;
	Fri, 13 Dec 2019 00:13:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22B05C0881
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 00:13:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0A68B86E4C
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 00:13:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FW5U5EVk-aP0 for <iommu@lists.linux-foundation.org>;
 Fri, 13 Dec 2019 00:13:10 +0000 (UTC)
X-Greylist: delayed 00:05:11 by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6EDBF86E3F
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 00:13:10 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id l24so563266pgk.2
 for <iommu@lists.linux-foundation.org>; Thu, 12 Dec 2019 16:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=TS0VnFP4wmXpcgCTt3VYjH+yAnIJ0NLMtHmpsTJa70s=;
 b=O/yuRss+BmZ0/IH2KRo97L+6BZmXdi3DpHxPfoVh2jQ3ueWoHUSRG7f/nZ2tXcFePX
 t7hVQ2MzfV2M9LIiTlTZSck/vK4+qW4P2UYOjnYJiKW+flXb/33cDmhArQ5csCgbhZ2q
 8Hv6DdbCeZnPRoQOp23dWt9nsaZFojFhLZscMYxiPvVzc6UJxWiOxmqkdd0AeYxBZrde
 XcI/dd/wvFdLDrxBKyLOCY+eDBr4ctN//dre2jP+c4Q1RQV8FXJJrK02IJxHtmj7eq1c
 uel8zAyvN2cBnlPr27m7WKBd/j0A4xvfIDapzLqaQouB8RkJIQgE7Podaj9OjV8c3gFl
 tOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=TS0VnFP4wmXpcgCTt3VYjH+yAnIJ0NLMtHmpsTJa70s=;
 b=Hxz5Nb9s427hT02yEkscxvMo9Mv9wIFhdkDVIkZa461NhTRl2f445aZOAf759cw0i4
 6tGLlpOuOjvZIlNUgp0Gqm/uFX2kJQxhDQFfwqJgb1kBwtkxElVzjXb7kZpTXq25+lB1
 UD5finSVFfObucjiXLMZcO9AZOGG7ZxEC2QMe7SO0V/BUN3Cjv/9LrKs1WlUKUjPdJUo
 Q91KFM8hpmwvVL/Ns/F5ry7lqXMW7Ay8M4HI1k9YVW+DkgsgJ7fIcSBo1rBG39FqNhuv
 gAIwo1xjWfwznPGc/VI2ScsY3tlMUmTXKsnektVHCeiTjvjI+j7DfZBh3uoqYjlWH1Fd
 0waw==
X-Gm-Message-State: APjAAAXfs37Al/eaU26m1SciheeXeu48BRBPAdUsDdIIxdcs0BrfHo2O
 YMh5U2dJge0CKOgf9jP8INafsg==
X-Google-Smtp-Source: APXvYqx/i0ywI7DTLrKi/bBPr/aFnvWO3tdi/Z2760zPqzRzVEImTZT+GZuvpFTW34rG0LzAjoEd6Q==
X-Received: by 2002:a62:7986:: with SMTP id
 u128mr13463087pfc.192.1576195678234; 
 Thu, 12 Dec 2019 16:07:58 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id g8sm8537407pfh.43.2019.12.12.16.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2019 16:07:56 -0800 (PST)
Date: Thu, 12 Dec 2019 16:07:56 -0800 (PST)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [bug] __blk_mq_run_hw_queue suspicious rcu usage
In-Reply-To: <20191128064056.GA19822@lst.de>
Message-ID: <alpine.DEB.2.21.1912121550230.148507@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1909041434580.160038@chino.kir.corp.google.com>
 <20190905060627.GA1753@lst.de>
 <alpine.DEB.2.21.1909051534050.245316@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1909161641320.9200@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1909171121300.151243@chino.kir.corp.google.com>
 <1d74607e-37f7-56ca-aba3-5a3bd7a68561@amd.com>
 <20190918132242.GA16133@lst.de>
 <alpine.DEB.2.21.1911271359000.135363@chino.kir.corp.google.com>
 <20191128064056.GA19822@lst.de>
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

On Thu, 28 Nov 2019, Christoph Hellwig wrote:

> > So we're left with making dma_pool_alloc(GFP_ATOMIC) actually be atomic 
> > even when the DMA needs to be unencrypted for SEV.  Christoph's suggestion 
> > was to wire up dmapool in kernel/dma/remap.c for this.  Is that necessary 
> > to be done for all devices that need to do dma_pool_alloc(GFP_ATOMIC) or 
> > can we do it within the DMA API itself so it's transparent to the driver?
> 
> It needs to be transparent to the driver.  Lots of drivers use GFP_ATOMIC
> dma allocations, and all of them are broken on SEV setups currently.
> 

Not my area, so bear with me.

Since all DMA must be unencrypted in this case, what happens if all 
dma_direct_alloc_pages() calls go through the DMA pool in 
kernel/dma/remap.c when force_dma_unencrypted(dev) == true since 
__PAGE_ENC is cleared for these ptes?  (Ignoring for a moment that this 
special pool should likely be a separate dma pool.)

I assume a general depletion of that atomic pool so 
DEFAULT_DMA_COHERENT_POOL_SIZE becomes insufficient.  I'm not sure what 
size any DMA pool wired up for this specific purpose would need to be 
sized at, so I assume dynamic resizing is required.

It shouldn't be *that* difficult to supplement kernel/dma/remap.c with the 
ability to do background expansion of the atomic pool when nearing its 
capacity for this purpose?  I imagine that if we just can't allocate pages 
within the DMA mask that it's the only blocker to dynamic expansion and we 
don't oom kill for lowmem.  But perhaps vm.lowmem_reserve_ratio is good 
enough protection?

Beyond that, I'm not sure what sizing would be appropriate if this is to 
be a generic solution in the DMA API for all devices that may require 
unecrypted memory.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
