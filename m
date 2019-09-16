Return-Path: <SRS0=3WiH=XL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432A4C49ED7
	for <iommu@archiver.kernel.org>; Mon, 16 Sep 2019 23:45:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0511B2067D
	for <iommu@archiver.kernel.org>; Mon, 16 Sep 2019 23:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="r5a/XbNS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0511B2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8D44D13C2;
	Mon, 16 Sep 2019 23:45:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4756313BA
	for <iommu@lists.linux-foundation.org>;
	Mon, 16 Sep 2019 23:45:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
	[209.85.210.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E066870D
	for <iommu@lists.linux-foundation.org>;
	Mon, 16 Sep 2019 23:45:26 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id i1so913887pfa.6
	for <iommu@lists.linux-foundation.org>;
	Mon, 16 Sep 2019 16:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=date:from:to:cc:subject:in-reply-to:message-id:references
	:user-agent:mime-version;
	bh=gPeqNA84uKm/2CLfm5fXdDKqLvuPs/0PfIC1lZBDVcE=;
	b=r5a/XbNS/jvudcLZbnEeEeBgDSpXdAkOEjlEqjWaVl7O/Keuu9SWppYwdpzqS9XUXd
	I++cPOGgE3jNUdIa30WtGkrBMf4xdS9Zym5SrGinlequi+YmMUh3dt3nzoY9x4MaQWbL
	a1PPBz0ECe86QyfBSkBMtFmZttbnAAC9nF7T3lvNBSbvbSfKh3CY6yHLQClu7mta6BxQ
	qFbfpNyr2CMtxnhne3PMeSYau+1m6+CUl680SgEhuv4n7UrmGSjgdWsNsQX3wZLaNXlB
	xWZyM1MT6hkXu/o0YiAC0cwF3yKfzKv0gwjjjK9Rc4eSqWan27FtAEqudrqfcz8ao8b2
	yYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
	:references:user-agent:mime-version;
	bh=gPeqNA84uKm/2CLfm5fXdDKqLvuPs/0PfIC1lZBDVcE=;
	b=YOtzgpeTYKQifBXXAben+FfHeXelYKb9MSMvDcRRbEybdwgrXII00CAfl7yB88tVLa
	1YIULE54gv4SV00R4QRlcVGXtpFPtY2NEjNhyC2CzDvYKs9XjX1G98GXaSZXHsj4lsAC
	tdimGsaTpEwjsAYD0drXPWVAjsTE67jRuxLTwOKvrIK/FQlvXgk7l4tM46nxj1CR1zoU
	A96BidK7aYWxC+zSgoZlIt/hQ/97sBx+QD6kAbDlqyu1xgZwzH96JRbX150R6xjjTtsh
	aVTcFX1gvXb3En0ZATvw1wmgTrpeKLxJWz3VEkKuDYDUlmBKlmARqPGjOqeuwAiOSzay
	CG1Q==
X-Gm-Message-State: APjAAAUvufGOjuT+SYzbpO7C+/1zzSuTJsLRkwx4lyhLElZaP8xSMWMW
	LOdLzc/ekLlsQq7mHbp3iHiA5A==
X-Google-Smtp-Source: APXvYqw92C74smlwK4lp/45d9xzXzuNO1t7cK8J2Wk45GzI+dOKhN4oA5k/eAQn9NkOzFT8IyuIcgA==
X-Received: by 2002:a62:b406:: with SMTP id h6mr1028857pfn.260.1568677526290; 
	Mon, 16 Sep 2019 16:45:26 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
	([2620:15c:17:3:3a5:23a7:5e32:4598])
	by smtp.gmail.com with ESMTPSA id m24sm183103pgj.71.2019.09.16.16.45.25
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 16 Sep 2019 16:45:25 -0700 (PDT)
Date: Mon, 16 Sep 2019 16:45:24 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [bug] __blk_mq_run_hw_queue suspicious rcu usage
In-Reply-To: <alpine.DEB.2.21.1909051534050.245316@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1909161641320.9200@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1909041434580.160038@chino.kir.corp.google.com>
	<20190905060627.GA1753@lst.de>
	<alpine.DEB.2.21.1909051534050.245316@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: Jens Axboe <axboe@kernel.dk>, Tom Lendacky <thomas.lendacky@amd.com>,
	Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
	iommu@lists.linux-foundation.org, Peter Gonda <pgonda@google.com>,
	Jianxiong Gao <jxgao@google.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, 5 Sep 2019, David Rientjes wrote:

> > > Hi Christoph, Jens, and Ming,
> > > 
> > > While booting a 5.2 SEV-enabled guest we have encountered the following 
> > > WARNING that is followed up by a BUG because we are in atomic context 
> > > while trying to call set_memory_decrypted:
> > 
> > Well, this really is a x86 / DMA API issue unfortunately.  Drivers
> > are allowed to do GFP_ATOMIC dma allocation under locks / rcu critical
> > sections and from interrupts.  And it seems like the SEV case can't
> > handle that.  We have some semi-generic code to have a fixed sized
> > pool in kernel/dma for non-coherent platforms that have similar issues
> > that we could try to wire up, but I wonder if there is a better way
> > to handle the issue, so I've added Tom and the x86 maintainers.
> > 
> > Now independent of that issue using DMA coherent memory for the nvme
> > PRPs/SGLs doesn't actually feel very optional.  We could do with
> > normal kmalloc allocations and just sync it to the device and back.
> > I wonder if we should create some general mempool-like helpers for that.
> > 
> 
> Thanks for looking into this.  I assume it's a non-starter to try to 
> address this in _vm_unmap_aliases() itself, i.e. rely on a purge spinlock 
> to do all synchronization (or trylock if not forced) for 
> purge_vmap_area_lazy() rather than only the vmap_area_lock within it.  In 
> other words, no mutex.
> 
> If that's the case, and set_memory_encrypted() can't be fixed to not need 
> to sleep by changing _vm_unmap_aliases() locking, then I assume dmapool is 
> our only alternative?  I have no idea with how large this should be.
> 

Brijesh and Tom, we currently hit this any time we boot an SEV enabled 
Ubuntu 18.04 guest; I assume that guest kernels, especially those of such 
major distributions, are expected to work with warnings and BUGs when 
certain drivers are enabled.

If the vmap purge lock is to remain a mutex (any other reason that 
unmapping aliases can block?) then it appears that allocating a dmapool 
is the only alternative.  Is this something that you'll be addressing 
generically or do we need to get buy-in from the maintainers of this 
specific driver?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
