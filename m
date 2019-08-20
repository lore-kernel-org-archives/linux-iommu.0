Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27145C3A5A0
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 01:57:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3CB320644
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 01:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="In1BTMe1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3CB320644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A4F3CC9E;
	Tue, 20 Aug 2019 01:57:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D1589C96
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 01:57:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
	[209.85.215.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 353D189B
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 01:57:49 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id u17so2245295pgi.6
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 18:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=YscGleDJRumM37KpoeP9It3qdBX6Jq+PJ+LVaq76VuA=;
	b=In1BTMe1bBT147mQQjNrQc55xmeCRzFO7XzG8mo+r5v5RRSSDv1QKvKVNiw13FOkon
	BZMNPFfN/ROExiaBIqu/l2PAtOHQtznRfy5JdU1BRvwateXb1FeRt2PXsjSjcc8A4xZw
	a+8IBofDxl+wDBnR/X64woBmsXGSttk552CP/xZQGZenmaiEEdZGs2RP/gCDbKcrbUoG
	uyblaLSP4gY9IljYY5cCxD9aJYplmy80JFvfRH22M3hM3Pfiz6VoiKR9bESntvnCvPkh
	d+xdtOq2Mb9JXX3bXiQb6pyMHTMfcuPjWADn0MDepv391F79HbLYjFkygD4CGTFpC/po
	Bv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=YscGleDJRumM37KpoeP9It3qdBX6Jq+PJ+LVaq76VuA=;
	b=QE9XhGSK09WaU5XTk5tiJBnKVpR09MXPZ8e0VyRRWct6gL91pjfucQnKcSpQmk9tEp
	zPikwYd3DtY9X+7QaQC0/bUxM2icKd3bo/zuJSRGAXLh8axPPVOJboJ6uzWR34dNRfZJ
	cKPwhVU6fKErNavZCkXbhm4DCfTXQEtYDjAAc+ch/W0QTFY+BHlgh0mrDQCusPpBYreB
	Tji+MSTNyQ72MQ5hXFRRRhMiDAw5Vuo8+tEbF9xChSn10LM0G62i6p274A3NfHrEP0YL
	ccEW4CeKKylg/4HC/lWee2FWq7pzMb7nDFtaJ/EE/OG26PPvKl3UGyQfyvTHooZWmeGw
	l2gQ==
X-Gm-Message-State: APjAAAUKO2C48BI1j3iAwKLTRaRSfbDOMOtGck9orvy5aGYXdHuYiIyL
	tdGv6Gyp+RiDcsn9C/LA//A=
X-Google-Smtp-Source: APXvYqxUoHBY0bX7zJql5cH6zII/yXQkZnKNFobWnt5jN1qcIJDKHAdSt98O6ekYNDKLSZUHAIEQjA==
X-Received: by 2002:a17:90a:8b94:: with SMTP id
	z20mr12768773pjn.109.1566266268433; 
	Mon, 19 Aug 2019 18:57:48 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	y194sm18811690pfg.116.2019.08.19.18.57.47
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 19 Aug 2019 18:57:48 -0700 (PDT)
Date: Mon, 19 Aug 2019 18:58:52 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Hillf Danton <hdanton@sina.com>,
	Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>
Subject: Re: regression in ath10k dma allocation
Message-ID: <20190820015852.GA15830@Asurada-Nvidia.nvidia.com>
References: <8fe8b415-2d34-0a14-170b-dcb31c162e67@mni.thm.de>
	<20190816164301.GA3629@lst.de>
	<af96ea6a-2b17-9b66-7aba-b7dae5bcbba5@mni.thm.de>
	<20190816222506.GA24413@Asurada-Nvidia.nvidia.com>
	<20190818031328.11848-1-hdanton@sina.com>
	<acd7a4b0-fde8-1aa2-af07-2b469e5d5ca7@mni.thm.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <acd7a4b0-fde8-1aa2-af07-2b469e5d5ca7@mni.thm.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
	davem@davemloft.net, iommu@lists.linux-foundation.org,
	tobias.klausmann@freenet.de, robin.murphy@arm.com,
	Christoph Hellwig <hch@lst.de>, kvalo@codeaurora.org
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

Hello Hillf,

On Mon, Aug 19, 2019 at 12:38:38AM +0200, Tobias Klausmann wrote:
> 
> On 18.08.19 05:13, Hillf Danton wrote:
> > On Sat, 17 Aug 2019 00:42:48 +0200 Tobias Klausmann wrote:
> > > Hi Nicolin,
> > > 
> > > On 17.08.19 00:25, Nicolin Chen wrote:
> > > > Hi Tobias
> > > > 
> > > > On Fri, Aug 16, 2019 at 10:16:45PM +0200, Tobias Klausmann wrote:
> > > > > > do you have CONFIG_DMA_CMA set in your config?  If not please make sure
> > > > > > you have this commit in your testing tree, and if the problem still
> > > > > > persists it would be a little odd and we'd have to dig deeper:
> > > > > > 
> > > > > > commit dd3dcede9fa0a0b661ac1f24843f4a1b1317fdb6
> > > > > > Author: Nicolin Chen <nicoleotsuka@gmail.com>
> > > > > > Date:   Wed May 29 17:54:25 2019 -0700
> > > > > > 
> > > > > >        dma-contiguous: fix !CONFIG_DMA_CMA version of dma_{alloc, free}_contiguous()
> > > > > yes CONFIG_DMA_CMA is set (=y, see attached config), the commit you mention
> > > > > above is included, if you have any hints how to go forward, please let me
> > > > > know!
> > > > For CONFIG_DMA_CMA=y, by judging the log with error code -12, I
> > > > feel this one should work for you. Would you please check if it
> > > > is included or try it out otherwise?
> > > > 
> > > > dma-contiguous: do not overwrite align in dma_alloc_contiguous()
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=c6622a425acd1d2f3a443cd39b490a8777b622d7
> > > 
> > > Thanks for the hint, yet the commit is included and does not fix the
> > > problem!
> > > 
> Hi Hillf,
> 
> i just tested you first hunk (which comes from kernel/dma/direct.c if i'm
> not mistaken), it did not compile on its own, yet with a tiny bit of work it
> did, and it does indeed solve the regression. But if using that is the
> "right" way to do it, not sure, but its not on me to decide.
> 
> Anyway: Thanks for the hint,
> 
> Tobias
> 
> 
> > Hi Tobias
> > 
> > Two minor diffs below in hope that they might make sense.
> > 
> > 1, fallback unless dma coherent ok.
> > 
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -246,6 +246,10 @@ struct page *dma_alloc_contiguous(struct
> >   		size_t cma_align = min_t(size_t, align, CONFIG_CMA_ALIGNMENT);
> >   		page = cma_alloc(cma, count, cma_align, gfp & __GFP_NOWARN);
> > +		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
> > +			dma_free_contiguous(dev, page, size);
> > +			page = NULL;
> > +		}

Right...the condition was in-between. However, not every caller
of dma_alloc_contiguous() is supposed to have a coherent check.
So we either add a 'bool coherent_ok' to the API or revert the
dma-direct part back to the original. Probably former option is
better?

Thank you for the debugging. I have been a bit distracted, may
not be able to submit a fix very soon. Would you like to help?

Thanks!
Nicolin

> >   	}
> >   	/* Fallback allocation of normal pages */
> > --
> > 
> > 2, cleanup: cma unless contiguous
> > 
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -234,18 +234,13 @@ struct page *dma_alloc_contiguous(struct
> >   	size_t count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> >   	size_t align = get_order(PAGE_ALIGN(size));
> >   	struct page *page = NULL;
> > -	struct cma *cma = NULL;
> > -
> > -	if (dev && dev->cma_area)
> > -		cma = dev->cma_area;
> > -	else if (count > 1)
> > -		cma = dma_contiguous_default_area;
> >   	/* CMA can be used only in the context which permits sleeping */
> > -	if (cma && gfpflags_allow_blocking(gfp)) {
> > +	if (count > 1 && gfpflags_allow_blocking(gfp)) {
> >   		size_t cma_align = min_t(size_t, align, CONFIG_CMA_ALIGNMENT);
> > -		page = cma_alloc(cma, count, cma_align, gfp & __GFP_NOWARN);
> > +		page = cma_alloc(dev_get_cma_area(dev), count, cma_align,
> > +							gfp & __GFP_NOWARN);
> >   		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
> >   			dma_free_contiguous(dev, page, size);
> >   			page = NULL;
> > --
> > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
