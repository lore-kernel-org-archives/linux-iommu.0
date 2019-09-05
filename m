Return-Path: <SRS0=Lu7X=XA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93B6C43331
	for <iommu@archiver.kernel.org>; Thu,  5 Sep 2019 22:37:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7545206DE
	for <iommu@archiver.kernel.org>; Thu,  5 Sep 2019 22:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Y1yQmcMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7545206DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2EC1719B9;
	Thu,  5 Sep 2019 22:37:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 53DC2F6D
	for <iommu@lists.linux-foundation.org>;
	Thu,  5 Sep 2019 22:37:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
	[209.85.215.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F3195A9
	for <iommu@lists.linux-foundation.org>;
	Thu,  5 Sep 2019 22:37:18 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id d10so2262532pgo.5
	for <iommu@lists.linux-foundation.org>;
	Thu, 05 Sep 2019 15:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=date:from:to:cc:subject:in-reply-to:message-id:references
	:user-agent:mime-version;
	bh=GjBspe2tpCYYNWjl2LkWvULdU+0U6Dxr2p5C7+1bhNo=;
	b=Y1yQmcMalmEQm/Vqme6jPHNnMCdfGOzjjTtdcAIQEZZxyHtB2fOyO9RcDwAenVynP1
	oU2EWbBV8k3A/zrgzHKlhFl+OCjJA7+iFcROUVfqu0zVQJtdvGeCfe7NjlSjJt95b1D/
	+sI71E2Mgibu6zo1UdRBXiR6W+COpXDLAoZJKjTAFkblQQyepPHdb4Yw2B60eqK0bc/c
	5EZFQrraRiPZCgjeT/i0tuIlybmJBkDEeBq26FP+YjU3DIMEx+nkahOJs0NYOvvE8G4b
	wnhaXgd+jxqZlunLBkPxADJY04Lpuw8sXJbBOQ+cwbRupYKGQyxmFyerDToQmxrK9FHT
	swJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
	:references:user-agent:mime-version;
	bh=GjBspe2tpCYYNWjl2LkWvULdU+0U6Dxr2p5C7+1bhNo=;
	b=g9weSDBBJonw9h++2VHkVxtDotQ4da5Fn2yeqrU390vJxU6cAykXfVdEGmI4Vr/9wt
	ud1+R7CO77qYkdDxQUbOf9rtx21fLY2I4GtpMG6YiIgYWKWOQjXCl9UqaM4KIynP6f3L
	xUbEd5WSso4Xslyrd9saTa062lk9Nzk7k53X9rG2G8tN0GNKtdaBafoIzrYepfblA+ua
	chPM6/Hzc6siLkUZEacdpyfRgw3uOMO81UQmxgvMEYww//yPxzlXw3TS0/W8ZqlJDyfC
	0/l1bo7ciucwYbvnkNaumlguP+scNbwCgW76tj1SIoLOECeFbBnhGDvTCdJRuJc9+BmP
	+SMQ==
X-Gm-Message-State: APjAAAXfhjAPmuDd2gvNwUtJEjnl2JoEPEbg8u4lKFbgnoUq/IXGMXU3
	TykamV511R31f+HYvYFmeaRHfQ==
X-Google-Smtp-Source: APXvYqzoKno8KkgU8EqN4eXlIDNTHy2pjuloFOR5UxHRMSEDann6aIsDU+iY4ucPt4NGFSgWYqVMFg==
X-Received: by 2002:a17:90a:32c8:: with SMTP id
	l66mr6539209pjb.44.1567723038296; 
	Thu, 05 Sep 2019 15:37:18 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
	([2620:15c:17:3:3a5:23a7:5e32:4598])
	by smtp.gmail.com with ESMTPSA id l72sm8557163pjb.7.2019.09.05.15.37.17
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 05 Sep 2019 15:37:17 -0700 (PDT)
Date: Thu, 5 Sep 2019 15:37:16 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [bug] __blk_mq_run_hw_queue suspicious rcu usage
In-Reply-To: <20190905060627.GA1753@lst.de>
Message-ID: <alpine.DEB.2.21.1909051534050.245316@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1909041434580.160038@chino.kir.corp.google.com>
	<20190905060627.GA1753@lst.de>
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

On Thu, 5 Sep 2019, Christoph Hellwig wrote:

> > Hi Christoph, Jens, and Ming,
> > 
> > While booting a 5.2 SEV-enabled guest we have encountered the following 
> > WARNING that is followed up by a BUG because we are in atomic context 
> > while trying to call set_memory_decrypted:
> 
> Well, this really is a x86 / DMA API issue unfortunately.  Drivers
> are allowed to do GFP_ATOMIC dma allocation under locks / rcu critical
> sections and from interrupts.  And it seems like the SEV case can't
> handle that.  We have some semi-generic code to have a fixed sized
> pool in kernel/dma for non-coherent platforms that have similar issues
> that we could try to wire up, but I wonder if there is a better way
> to handle the issue, so I've added Tom and the x86 maintainers.
> 
> Now independent of that issue using DMA coherent memory for the nvme
> PRPs/SGLs doesn't actually feel very optional.  We could do with
> normal kmalloc allocations and just sync it to the device and back.
> I wonder if we should create some general mempool-like helpers for that.
> 

Thanks for looking into this.  I assume it's a non-starter to try to 
address this in _vm_unmap_aliases() itself, i.e. rely on a purge spinlock 
to do all synchronization (or trylock if not forced) for 
purge_vmap_area_lazy() rather than only the vmap_area_lock within it.  In 
other words, no mutex.

If that's the case, and set_memory_encrypted() can't be fixed to not need 
to sleep by changing _vm_unmap_aliases() locking, then I assume dmapool is 
our only alternative?  I have no idea with how large this should be.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
