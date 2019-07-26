Return-Path: <SRS0=gbr8=VX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA80BC76191
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 19:21:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C04AB218B8
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 19:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNZsrUD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04AB218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8E62FCE5;
	Fri, 26 Jul 2019 19:21:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B6EE7AD7
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 19:21:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
	[209.85.210.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 35DDF896
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 19:21:52 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id c3so1824404pfa.13
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 12:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=2Rz9/+cZDdXi6JgpgzZoSTYFdovjC7oAOseUIfVaYjY=;
	b=JNZsrUD/q13t3xzQM7rEE7Z/nNqSFpGoghgy4pCBk9v0qMjLLgADL7XyQXynYhvH1a
	tjZUKZ5qQ55lkcjdKhccnh4DSidp/MQxoR0DglCs2c9x3E7uDDfx0LZzC6PLxaqQNRzj
	YhnHKs5l9MVSS7SSzrrWccaDnDohB2H0wToRbLsRmdYhG5j/s760M7YftOdy4qK2esz9
	DP45nqNS08w2azq61yXgDrvEpnrlVci4zdeephVnjt2shmKikLRteGY/kxrEwxXQdzXY
	IbGQrMXQzp2PGrAMgLx4TkXGNtMXvVrXNaBQTSy2Xtw5w4yHpU0n4SRti5nJ6Tb+JkU1
	sbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=2Rz9/+cZDdXi6JgpgzZoSTYFdovjC7oAOseUIfVaYjY=;
	b=iNtvRiiMzFxOp2Ocy42zdfswDcJLsJI5egHWcVw89muoRrq1LzCKT714GADj2+Hr9V
	FCdFO6oVjkKhR4j7kPL2jiAHcpsx6kLiELB9RyQWVcvE6yt5V4FiC5cVYhzlTW1DK+dQ
	5GNxuTsezdJ8Q545rhWbCv1QMGDn1g0SegBztPocB28cc4LLAnqXm86ExZfvj/hqzrHC
	Zd8xMmpCEC58h9CQz0j6hZ7wCvNabCtDskDebuI4J5I9TO70OCG8T+gTrS2CeTcxLbEp
	nuz2XYDbvSaeVdQq/3RUhYEeboTS3M2ch1WzPZ5SZApii8HuRecFn9Eitnvz08imdAHy
	DlaQ==
X-Gm-Message-State: APjAAAXtlo6DVo/TAcBT0JyMh2v9y8IT5VnsNpJpgXRsxFTRU4EE5wbP
	tfel5RrC61Qn6RKbDMCaWiw=
X-Google-Smtp-Source: APXvYqzLKB5X+aflbN9I1nljyryl4PPtNW4+gbR3wsVeOLLZw2lp7KPhRX8Jp5GQ0WHsaev+ZOkl4w==
X-Received: by 2002:a17:90a:8c90:: with SMTP id
	b16mr98899278pjo.133.1564168911656; 
	Fri, 26 Jul 2019 12:21:51 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	i3sm58842258pfo.138.2019.07.26.12.21.51
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 26 Jul 2019 12:21:51 -0700 (PDT)
Date: Fri, 26 Jul 2019 12:22:35 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] dma-contiguous: do not overwrite align in
	dma_alloc_contiguous()
Message-ID: <20190726192235.GA32144@Asurada-Nvidia.nvidia.com>
References: <20190725233959.15129-1-nicoleotsuka@gmail.com>
	<20190725233959.15129-2-nicoleotsuka@gmail.com>
	<20190726062849.GE22881@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190726062849.GE22881@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: robin.murphy@arm.com, iommu@lists.linux-foundation.org,
	dafna.hirschfeld@collabora.com, linux-kernel@vger.kernel.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Jul 26, 2019 at 08:28:49AM +0200, Christoph Hellwig wrote:
> On Thu, Jul 25, 2019 at 04:39:58PM -0700, Nicolin Chen wrote:
> > The dma_alloc_contiguous() limits align at CONFIG_CMA_ALIGNMENT for
> > cma_alloc() however it does not restore it for the fallback routine.
> > This will result in a size mismatch between the allocation and free
> > when running in the fallback routines, if the align is larger than
> > CONFIG_CMA_ALIGNMENT.
> > 
> > This patch adds a cma_align to take care of cma_alloc() and prevent
> > the align from being overwritten.
> > 
> > Fixes: fdaeec198ada ("dma-contiguous: add dma_{alloc,free}_contiguous() helpers")
> > Reported-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> >  kernel/dma/contiguous.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> > index bfc0c17f2a3d..fa8cd0f0512e 100644
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -233,6 +233,7 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
> >  	int node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
> >  	size_t count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> >  	size_t align = get_order(PAGE_ALIGN(size));
> > +	size_t cma_align = CONFIG_CMA_ALIGNMENT;
> >  	struct page *page = NULL;
> >  	struct cma *cma = NULL;
> >  
> > @@ -241,11 +242,11 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
> >  	else if (count > 1)
> >  		cma = dma_contiguous_default_area;
> >  
> > +	cma_align = min_t(size_t, align, cma_align);
> > +
> >  	/* CMA can be used only in the context which permits sleeping */
> > -	if (cma && gfpflags_allow_blocking(gfp)) {
> > -		align = min_t(size_t, align, CONFIG_CMA_ALIGNMENT);
> > -		page = cma_alloc(cma, count, align, gfp & __GFP_NOWARN);
> > -	}
> > +	if (cma && gfpflags_allow_blocking(gfp))
> > +		page = cma_alloc(cma, count, cma_align, gfp & __GFP_NOWARN);
> 
> Shouldn't cma_align be confined to the block guarded by
> "if (cma && gfpflags_allow_blocking(gfp))" so that we can optimize it
> away for configurations that do not support CMA?

Had my local 1st version doing just like that but then wanted to
simplify the statement within that if-condition so redid in this
way. Will change it back as you suggested. Thanks
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
