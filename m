Return-Path: <SRS0=MJs7=WM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05433C3A59D
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 22:24:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB0DE206C2
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 22:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCD6NB8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0DE206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 80E17AE7;
	Fri, 16 Aug 2019 22:24:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7D5CBAE0
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 22:24:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
	[209.85.210.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2C90A786
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 22:24:07 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id i30so3803394pfk.9
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 15:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=Z/RL8I+CX00aaoEA3B93OfzM8SWXYflpbq6Zuf69+2Q=;
	b=PCD6NB8TBlV/+xuB6WcPJ6ZvxS8yBi9wwHXyInSFgGxD55G8j3R8gvP+bb7gQEsNel
	UwNGTdYr/oghTCCM65TW7ecBXltVDwyWqZ00zBm7d+o407wI90UM2BCigLgBv0jeZ81O
	lkNJjNOSM64BSGDg9E+zVE5guJUEt9jJZ2g/yKy4nf7mLCjWoD0SQ+ktXySUAosoe4XF
	7R/yLHB0JMOGiJMpzOMQ9YPqLLYK5K7o78nQqxgz1cLOZZLgb/7is+F0K5ME2dGnPUde
	3mN7TuHHVDYc7FP3VXJU1NmS/FejfhOLwpyI+PPnL96RsC4P9x0Fv+xATfQSmMHPr9UB
	mHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=Z/RL8I+CX00aaoEA3B93OfzM8SWXYflpbq6Zuf69+2Q=;
	b=IsknSmwTOq1b+jUXAiSkT6EnC+8jAJbmEXubKxdDJ02Xe3WaA0jF0fqoNlOLFiAuht
	v3J0dZnqnvvf44S1ssaQ8PfKPJn9+NaTdx66iqqC83BrUqSV3JyQVer3Wwh9EmgUOm7T
	TNi8uswjEeX3POoldNxQBCny9gHNHKh7yzGbDDrrLKNc6n0LCuhFcfTE9Eb/VT86KmWE
	CqLBtOPst3xk5YY/5oZBQU8n2q1Y0e25eMvGPFJEbi/MkR/8Zcm2vXKEHFp8ovd9KYck
	FMW8GyJ4NtNa4DHmVXzYIdVJz09UhtC1M77tTuJNpDjFOstZgXKTfI5BlGM6JfGr1yqO
	9v+Q==
X-Gm-Message-State: APjAAAU8q8kFRpcfwPRDuZJBh4F1HE+Uf+hXv6t8AmU8ABYubm96ReOV
	PlQgHF2pkRUDSvQWTmkh6DY=
X-Google-Smtp-Source: APXvYqwfeEddZmSKMzfnbRIkkn5pkJotwXSMMLkGDy7aeLpXD5GJCVFazyjo4DIpIG1cw6MwYNKbuQ==
X-Received: by 2002:a17:90a:e38e:: with SMTP id
	b14mr9226497pjz.125.1565994246561; 
	Fri, 16 Aug 2019 15:24:06 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	v21sm7433880pfe.131.2019.08.16.15.24.05
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 16 Aug 2019 15:24:06 -0700 (PDT)
Date: Fri, 16 Aug 2019 15:25:07 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>
Subject: Re: regression in ath10k dma allocation
Message-ID: <20190816222506.GA24413@Asurada-Nvidia.nvidia.com>
References: <8fe8b415-2d34-0a14-170b-dcb31c162e67@mni.thm.de>
	<20190816164301.GA3629@lst.de>
	<af96ea6a-2b17-9b66-7aba-b7dae5bcbba5@mni.thm.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <af96ea6a-2b17-9b66-7aba-b7dae5bcbba5@mni.thm.de>
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

Hi Tobias

On Fri, Aug 16, 2019 at 10:16:45PM +0200, Tobias Klausmann wrote:
> > do you have CONFIG_DMA_CMA set in your config?  If not please make sure
> > you have this commit in your testing tree, and if the problem still
> > persists it would be a little odd and we'd have to dig deeper:
> > 
> > commit dd3dcede9fa0a0b661ac1f24843f4a1b1317fdb6
> > Author: Nicolin Chen <nicoleotsuka@gmail.com>
> > Date:   Wed May 29 17:54:25 2019 -0700
> > 
> >      dma-contiguous: fix !CONFIG_DMA_CMA version of dma_{alloc, free}_contiguous()

> yes CONFIG_DMA_CMA is set (=y, see attached config), the commit you mention
> above is included, if you have any hints how to go forward, please let me
> know!

For CONFIG_DMA_CMA=y, by judging the log with error code -12, I
feel this one should work for you. Would you please check if it
is included or try it out otherwise?

dma-contiguous: do not overwrite align in dma_alloc_contiguous()
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=c6622a425acd1d2f3a443cd39b490a8777b622d7

Thanks
Nicolin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
