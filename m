Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1217C433E0
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 16:15:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F7322583
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 16:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F7322583
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B5A40204FE;
	Mon, 25 Jan 2021 16:15:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m9o+LNVFCriT; Mon, 25 Jan 2021 16:15:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4BD1020444;
	Mon, 25 Jan 2021 16:15:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21D86C1E70;
	Mon, 25 Jan 2021 16:15:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7943C013A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 16:15:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 942B4871E6
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 16:15:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2QL6PgWwJBog for <iommu@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 16:15:44 +0000 (UTC)
X-Greylist: delayed 00:28:24 by SQLgrey-1.7.6
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D3B818716B
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 16:15:43 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id e15so10011645qte.9
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 08:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=WYtrk+5jMyfHMrIk+GFUJtKNShhaML4SL+BF9mnl4ek=;
 b=mEv+bdSqBPdjlX/bdjKIR3SI9YdPtbWuLoQeE76ZBBDrifSvgzpKe2Al9843jB5V2y
 jYAIfZmPEPaeZ5Oqkxoy8QvIVo91+adpqZujygppxIvbax/2vGxGjT3BDnBJ9PYWOzUB
 rbyhx9bsrcmb2rCRD0697Qhj/mNjh0DJinCAfGOX+TjDxCgWsCHPHxm7IgD04aftGPv0
 oJKvBKP3SKQlHkfSkivNxC9jF2Z+VXgar36M3oCMSTRxG3OdArdOxVO+jBLutbLw40hm
 Ywjxl5S6mpTmxxEMrSa2iGbxjeJX6ur9qiCgicoYFfxnWO/esqBDF0MtydZh82NCSBKW
 jxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WYtrk+5jMyfHMrIk+GFUJtKNShhaML4SL+BF9mnl4ek=;
 b=e26H9sUlsCga+24zTtynXqAg3t8Mp8ELLMMYKIxwPKk4erhOmAWan9oAuYMAIcXWEB
 HH03zFbZ6jmMUxOe0NYU5L+kYj1RSjPMP0SZqGgohkR/a/vfoNE9nz4Kqwv7w3sw4dtj
 UBqKzB/trGAqtSLQR9DYtgu5+IMKPf+JVnnNT1A23yxp7EPS7BxxJyU+L2i+fCUX+gYg
 unF6wzfYa25FD51jLFp8ni6E8TArji9e/sqsuFj1kzXriswhUI3RSTfbu6iRo4KvrQ7N
 qqwnnWbAx1qTeCrQt7sKbAdTdg+ofOkkhqEsPRNqBJtt3cn3DNJhY7gSJsCGJbAKyJkP
 6uMQ==
X-Gm-Message-State: AOAM533iK9EV2GOd/OlPyGBC3zMJamITIBQ8eikNiTV93SdZ+MNc0THE
 G+4ClssmKrwI2Bmh/WrBN9kN+QLUyl8/92uD
X-Google-Smtp-Source: ABdhPJxr0w4GGj4XFZfzo1ZpWgm8ksFBdTqQ/q89OryNoBYa59S4vVi7J2T2VaunByVM7HxRC+LHEw==
X-Received: by 2002:ac8:6987:: with SMTP id o7mr977438qtq.295.1611589638773;
 Mon, 25 Jan 2021 07:47:18 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.115.133])
 by smtp.gmail.com with ESMTPSA id o76sm409454qke.104.2021.01.25.07.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Jan 2021 07:47:18 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1l445F-006YE8-Qg; Mon, 25 Jan 2021 11:47:17 -0400
Date: Mon, 25 Jan 2021 11:47:17 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Message-ID: <20210125154717.GW4605@ziepe.ca>
References: <1611563696-235269-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1611563696-235269-1-git-send-email-wangzhou1@hisilicon.com>
Cc: Sihang Chen <chensihang1@hisilicon.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Zhangfei Gao <zhangfei.gao@linaro.org>, liguozhu@hisilicon.com,
 linux-accelerators@lists.ozlabs.org
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

On Mon, Jan 25, 2021 at 04:34:56PM +0800, Zhou Wang wrote:

> +static int uacce_pin_page(struct uacce_pin_container *priv,
> +			  struct uacce_pin_address *addr)
> +{
> +	unsigned int flags = FOLL_FORCE | FOLL_WRITE;
> +	unsigned long first, last, nr_pages;
> +	struct page **pages;
> +	struct pin_pages *p;
> +	int ret;
> +
> +	first = (addr->addr & PAGE_MASK) >> PAGE_SHIFT;
> +	last = ((addr->addr + addr->size - 1) & PAGE_MASK) >> PAGE_SHIFT;
> +	nr_pages = last - first + 1;
> +
> +	pages = vmalloc(nr_pages * sizeof(struct page *));
> +	if (!pages)
> +		return -ENOMEM;
> +
> +	p = kzalloc(sizeof(*p), GFP_KERNEL);
> +	if (!p) {
> +		ret = -ENOMEM;
> +		goto free;
> +	}
> +
> +	ret = pin_user_pages_fast(addr->addr & PAGE_MASK, nr_pages,
> +				  flags | FOLL_LONGTERM, pages);

This needs to copy the RLIMIT_MEMLOCK and can_do_mlock() stuff from
other places, like ib_umem_get

> +	ret = xa_err(xa_store(&priv->array, p->first, p, GFP_KERNEL));

And this is really weird, I don't think it makes sense to make handles
for DMA based on the starting VA.

> +static int uacce_unpin_page(struct uacce_pin_container *priv,
> +			    struct uacce_pin_address *addr)
> +{
> +	unsigned long first, last, nr_pages;
> +	struct pin_pages *p;
> +
> +	first = (addr->addr & PAGE_MASK) >> PAGE_SHIFT;
> +	last = ((addr->addr + addr->size - 1) & PAGE_MASK) >> PAGE_SHIFT;
> +	nr_pages = last - first + 1;
> +
> +	/* find pin_pages */
> +	p = xa_load(&priv->array, first);
> +	if (!p)
> +		return -ENODEV;
> +
> +	if (p->nr_pages != nr_pages)
> +		return -EINVAL;
> +
> +	/* unpin */
> +	unpin_user_pages(p->pages, p->nr_pages);

And unpinning without guaranteeing there is no ongoing DMA is really
weird

Are you abusing this in conjunction with a SVA scheme just to prevent
page motion? Why wasn't mlock good enough?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
