Return-Path: <SRS0=5+/2=4Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67104C10F00
	for <iommu@archiver.kernel.org>; Sat,  7 Mar 2020 00:36:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A2D2051A
	for <iommu@archiver.kernel.org>; Sat,  7 Mar 2020 00:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="eu2LmHTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A2D2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C8870870F4;
	Sat,  7 Mar 2020 00:36:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QeB_KVsyyqU5; Sat,  7 Mar 2020 00:36:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3B392870EB;
	Sat,  7 Mar 2020 00:36:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E02DC18DA;
	Sat,  7 Mar 2020 00:36:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07564C013E
 for <iommu@lists.linux-foundation.org>; Sat,  7 Mar 2020 00:36:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E162C88582
 for <iommu@lists.linux-foundation.org>; Sat,  7 Mar 2020 00:36:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vRuvEHxuPxMr for <iommu@lists.linux-foundation.org>;
 Sat,  7 Mar 2020 00:36:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
 [209.85.216.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B9DCB8857F
 for <iommu@lists.linux-foundation.org>; Sat,  7 Mar 2020 00:36:09 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id lt1so1744125pjb.2
 for <iommu@lists.linux-foundation.org>; Fri, 06 Mar 2020 16:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=iQN4zhJ6gBuJKLE8KIK1cxkBH9N65rsEBT3TSzucx+4=;
 b=eu2LmHTzZatSpWXnyqQgwxY6vHjsxT3DBgnHFPIgUh05TCzeDd6g3W2Fq6R8IGy07T
 4XCC2t/8YXu++lulhOj4jT45tpq1Z96LVAaoSHkVnK1h9PaDrWAkZ3Nm/mpvF5RkK3Qe
 V5MdZ/9yEHaOumBM1tVotFpLW+lXscQ2BKGiQdXplBDbU3nZAxiuUy8kn+JmEB6bn92V
 KBml2dtUS7X3dM0OXrhNoRC+3HZM0o26ziS6o5n43QOpFWSnfWuk12mhTm4PVtTxj2hT
 fv6g0YFYNqiqa4wwzv2n7uvm2DgUWQYZPyUFnkGJuxhQ0anP1oTrxPoqS5XPOzPeY78v
 WBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=iQN4zhJ6gBuJKLE8KIK1cxkBH9N65rsEBT3TSzucx+4=;
 b=CtIRMrYjq7dN+EzFsKKvoDDOEv6yhx9Qh7U5RhOffCAQX1abCdSA2DUZHeJbt9rpxx
 Xqevfr8NbTUWNtnOoYF7DyPadg6H5HY7zHDKM/LxLshEz11hhhJMP3lKwP98s3uHPP9q
 0r5lQfuwWFvyzzbqBWsPu9z5/EFBN13dDxUa3qHYePuTt+4ceZMjrx2dFjtQ6lYaE+x2
 TqPWwAzS1dulOChiYgG8Vwj/mieBpdtyrXFuLdJIECTVMTzl1SVLpp6ruwmgR3b4t4Z3
 EICEPSZGAuwv87Zhi6me4gY5J9TIOVmX+IeKqTvnrGeywwCPAkjVvVhgAO1chg/BrP5Y
 rfzA==
X-Gm-Message-State: ANhLgQ3xvvB+TuX3tAkHFeAsmkfMltMyDbSxRe0SnT9YHecVVO1zgErk
 E8wrBz9DcsO7lUsY5Ue5ouoAng==
X-Google-Smtp-Source: ADFU+vtfYToP6REtbWXHCtEWR3i7fS41u9MkA2s+ci8D1inDN5qS5L8FCEUfetDWg0rQbJ5CRedjJw==
X-Received: by 2002:a17:90a:20cf:: with SMTP id
 f73mr6192744pjg.42.1583541368949; 
 Fri, 06 Mar 2020 16:36:08 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id r13sm10421590pjp.14.2020.03.06.16.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 16:36:08 -0800 (PST)
Date: Fri, 6 Mar 2020 16:36:07 -0800 (PST)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [rfc 5/6] dma-direct: atomic allocations must come from
 unencrypted pools
In-Reply-To: <20200305154456.GC5332@lst.de>
Message-ID: <alpine.DEB.2.21.2003061623060.27928@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com>
 <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com>
 <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2003011538040.213582@chino.kir.corp.google.com>
 <20200305154456.GC5332@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: Tom Lendacky <thomas.lendacky@amd.com>, "Singh,
 Brijesh" <brijesh.singh@amd.com>, "Grimm, Jon" <jon.grimm@amd.com>,
 baekhw@google.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

On Thu, 5 Mar 2020, Christoph Hellwig wrote:

> On Sun, Mar 01, 2020 at 04:05:23PM -0800, David Rientjes wrote:
> > When AMD memory encryption is enabled, all non-blocking DMA allocations
> > must originate from the atomic pools depending on the device and the gfp
> > mask of the allocation.
> > 
> > Keep all memory in these pools unencrypted.
> > 
> > Signed-off-by: David Rientjes <rientjes@google.com>
> > ---
> >  arch/x86/Kconfig    | 1 +
> >  kernel/dma/direct.c | 9 ++++-----
> >  kernel/dma/remap.c  | 2 ++
> >  3 files changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1523,6 +1523,7 @@ config X86_CPA_STATISTICS
> >  config AMD_MEM_ENCRYPT
> >  	bool "AMD Secure Memory Encryption (SME) support"
> >  	depends on X86_64 && CPU_SUP_AMD
> > +	select DMA_DIRECT_REMAP
> 
> I think we need to split the pool from remapping so that we don't drag
> in the remap code for x86.
> 

Thanks for the review, Christoph.  I can address all the comments that you 
provided for the series but am hoping to get a clarification on this one 
depending on how elaborate the change you would prefer.

As a preliminary change to this series, I could move the atomic pools and 
coherent_pool command line to a new kernel/dma/atomic_pools.c file with a 
new CONFIG_DMA_ATOMIC_POOLS that would get "select"ed by CONFIG_DMA_REMAP 
and CONFIG_AMD_MEM_ENCRYPT and call into dma_common_contiguous_remap() if 
we have CONFIG_DMA_DIRECT_REMAP when adding pages to the pool.

I think that's what you mean by splitting the pool from remapping, 
otherwise we still have a full CONFIG_DMA_REMAP dependency here.  If you 
had something else in mind, please let me know.  Thanks!

> >  	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> > -	    dma_alloc_need_uncached(dev, attrs) &&
> 
> We still need a check here for either uncached or memory encryption.
> 
> > @@ -141,6 +142,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
> >  	if (!addr)
> >  		goto free_page;
> >  
> > +	set_memory_decrypted((unsigned long)page_to_virt(page), nr_pages);
> 
> This probably warrants a comment.
> 
> Also I think the infrastructure changes should be split from the x86
> wire up.
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
