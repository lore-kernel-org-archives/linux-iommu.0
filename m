Return-Path: <SRS0=ASoY=BD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D70C433E4
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 02:13:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1712065E
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 02:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSWVYNKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1712065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B440288204;
	Fri, 24 Jul 2020 02:13:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EEG1jHvR1kxG; Fri, 24 Jul 2020 02:13:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 015A687722;
	Fri, 24 Jul 2020 02:13:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E12D9C004D;
	Fri, 24 Jul 2020 02:13:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4065CC004C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 02:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 366B5883A8
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 02:13:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iIvWaPI1TknC for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jul 2020 02:13:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id ADE33882E0
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 02:13:29 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id s26so4211005pfm.4
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 19:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=0ezvLmjG/q+RN9ebJWxPsibO7j9/WR9vnJdI3K9oadE=;
 b=NSWVYNKJrWJKr2yxjaxueLtwySQ2EaaRUNUnt+tSStycg2DVdHneqQEmH7QhsXJsqT
 fA/ihqpy3pL9ODXCnAG9RJaQTe1qvSTMrzlhgyPiXSE6QCIMN9rYUnfox0JcPfdErGZl
 gbg9y8tzBBBXmMU76dvS3OcSjaaeVBtG0cEGdCmQ/FsjDLx8iGqR58iVaTjpQlNvaown
 tqxVtcKjGbfUvEM5CFKc7VCWyKWH2dMDv3/j6ZBtXGCIN+0fv25tY6o3h/Qll840rMxS
 UE2b5jy0eGEji5Iz40up+lGUqJTETq7fJMnAylLNkPkSV6bhcBxUQHjSLjW8x0DpPz6a
 RYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0ezvLmjG/q+RN9ebJWxPsibO7j9/WR9vnJdI3K9oadE=;
 b=Fje+SnJaFlI/FMKIsIAT3SdvbQCWslDOCpGVdcyV6nvnR0HAh3XV0v31VAPxunq2QG
 8ch0/jxThc9EkmfM1GEx7Nk8TlFmF8Rvuq+IEE9AmaO6GWe76zjFskPuRmYq/GFGSo/B
 xxBskkAmrUwcSoybhMaCLPl/FefKavwl9+oPyuGUd/EgCmXzPNJz76BF44cc2fOgrAua
 wsMTUd40+YD7pk1Frw77w+CTTZtU1gVCKRWhmPVshI/m5kRO9dl1G7ErUPQh6aKeIKA7
 YszhpaHA5m4wk8mriHA39Wr+Ipftc4Ea/UEoP+AnlH3qE04Q/jK8tKbUSDWc75AnREou
 0+Kw==
X-Gm-Message-State: AOAM5302WDkBMyGwQxA2CQZVGZ2p2elzXKW0Cq6fUUwd3JoKSbgI7r1m
 W7ebWl1eDqaLzCkJNCFSY27sOXaDvWnKfA==
X-Google-Smtp-Source: ABdhPJye+C0NXMFLBsqdFyUgu7PNP9+YDj8e6Eg/1bzhyT0DRd4zxD8aK7Tye8PUtKHxK7R/OSa2aA==
X-Received: by 2002:a65:4b85:: with SMTP id t5mr6715879pgq.36.1595556809199;
 Thu, 23 Jul 2020 19:13:29 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id k26sm4341096pgt.90.2020.07.23.19.13.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 23 Jul 2020 19:13:28 -0700 (PDT)
Date: Thu, 23 Jul 2020 19:12:53 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] dma-contiguous: cleanup dma_alloc_contiguous
Message-ID: <20200724021246.GA10498@Asurada-Nvidia>
References: <20200723120133.94105-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200723120133.94105-1-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Christoph,

On Thu, Jul 23, 2020 at 02:01:33PM +0200, Christoph Hellwig wrote:
> Split out a cma_alloc_aligned helper to deal with the "interesting"
> calling conventions for cma_alloc, which then allows to the main
> function to be written straight forward.  This also takes advantage
> of the fact that NULL dev arguments have been gone from the DMA API
> for a while.

I am still seeing some potential NULL dev callers:
drivers/staging/emxx_udc/emxx_udc.c:2596:			ep->virt_buf = dma_alloc_coherent(NULL, PAGE_SIZE,
drivers/tty/synclink.c:3667:		info->buffer_list = dma_alloc_coherent(NULL, BUFFERLISTSIZE, &info->buffer_list_dma_addr, GFP_KERNEL);
drivers/tty/synclink.c:3777:			BufferList[i].virt_addr = dma_alloc_coherent(NULL, DMABUFFERSIZE, &BufferList[i].dma_addr, GFP_KERNEL);

Personally I don't feel that it hurts to check the dev pointer
as we do now, but if you are confident with this version:

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
