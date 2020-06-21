Return-Path: <SRS0=X07A=AC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC098C433E0
	for <iommu@archiver.kernel.org>; Sun, 21 Jun 2020 21:12:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF9725298
	for <iommu@archiver.kernel.org>; Sun, 21 Jun 2020 21:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6RKGL4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF9725298
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 186EA88A65;
	Sun, 21 Jun 2020 21:12:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nTfTu8NJgdTS; Sun, 21 Jun 2020 21:12:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 62CB388228;
	Sun, 21 Jun 2020 21:12:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45C15C07FF;
	Sun, 21 Jun 2020 21:12:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA172C016F
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 21:12:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A4B3C88BAE
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 21:12:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ApQd0znYsvrq for <iommu@lists.linux-foundation.org>;
 Sun, 21 Jun 2020 21:12:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1EE0B88A43
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 21:12:03 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id p3so4505524pgh.3
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 14:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=5Qe/ojxL/WbEUbkj+sYdL2ReXOMy86ieWc6LpdIrkow=;
 b=r6RKGL4qGHvw7XsVSMWYtIIZ2Jp2YisDw0HZnipUsXGl0y/Rj8cWweNo2/PsE5pyn5
 ZyFZvk/p4wBbXEOTSg8t2P1RHCJpLdKZNWEly1F8+ibMzPzRLU1MYTd5XElxlo32TIL2
 cgzZDpr4j1yM+5CxUlkg0V5nOCaFDLwjYIZxTA6VC6GbTnMT09qVV8vHpXDv797VAhD3
 9fjs7rFKH8TM9m676G5ecoa+rqee7gxIxHxgyrYCigqZs03ZMXHXsaWMtDhDIXChsZJT
 ZR6q0wmSLK98aQpyfZqYAxGnVAGtpq//7ua3ra7XZ7T3ufJO7PzUeJIggVhmpYq8ParQ
 PB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :mime-version:content-disposition:user-agent;
 bh=5Qe/ojxL/WbEUbkj+sYdL2ReXOMy86ieWc6LpdIrkow=;
 b=FXFmMQ1cBDJ0GLyRgdi84hhY52+QFtb1Izl/aYRQ1ydAXQf9Sw39/NaT+q+YVdD5/4
 1OhsbSJ0WxuOYY2lwkXcVwvkIKIzpthrNNZ2sb64NKbBRueyVWuH1tAkn588yCjMk6ii
 Uio5SdfRRkqf1SpiURd1mIwrZeti/eysorZDXT3Z/V0hNY2p6kop9UrxeprrOPER5JrK
 JF3edPvMLSnFfe/+uh5nyCBsOdkCi3EUkyWnapaPMhYDFp0OhkP7pHj5oNg1E/GIlDKx
 VCeH+8/tsUyQQUDmRdTy+MVX0VaYd+4xCxqqQOWSAHFyMoJcYS8LW9gtgA2RIKC05oaJ
 VG9Q==
X-Gm-Message-State: AOAM532ReySABzpXSf7ZMzdUz1919fZTtB/DpwP9NUqxmeb2bHuqcF67
 EubVo/XvwVBTetNGWYvKyQ0=
X-Google-Smtp-Source: ABdhPJzL27D7dHCiiuzQzs6kuoS3kOVvNpzTQk7p3tE9/mdd1lD6BVzy7x5Tf30nggWdEwnRFqM8yQ==
X-Received: by 2002:a63:7c4d:: with SMTP id l13mr10527112pgn.12.1592773922412; 
 Sun, 21 Jun 2020 14:12:02 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id i125sm9184113pgd.21.2020.06.21.14.12.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 21 Jun 2020 14:12:01 -0700 (PDT)
Date: Sun, 21 Jun 2020 14:12:00 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: David Rientjes <rientjes@google.com>
Subject: Re: [patch] dma-pool: warn when coherent pool is depleted
Message-ID: <20200621211200.GA158319@roeck-us.net>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

On Sun, Jun 21, 2020 at 01:43:02PM -0700, David Rientjes wrote:
> When a DMA coherent pool is depleted, allocation failures may or may not
> get reported in the kernel log depending on the allocator.
> 
> The admin does have a workaround, however, by using coherent_pool= on the
> kernel command line.
> 
> Provide some guidance on the failure and a recommended minimum size for
> the pools (double the size).
> 
> Signed-off-by: David Rientjes <rientjes@google.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Also confirmed that coherent_pool=256k works around the crash
I had observed.

Guenter

> ---
>  kernel/dma/pool.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -239,12 +239,16 @@ void *dma_alloc_from_pool(struct device *dev, size_t size,
>  	}
>  
>  	val = gen_pool_alloc(pool, size);
> -	if (val) {
> +	if (likely(val)) {
>  		phys_addr_t phys = gen_pool_virt_to_phys(pool, val);
>  
>  		*ret_page = pfn_to_page(__phys_to_pfn(phys));
>  		ptr = (void *)val;
>  		memset(ptr, 0, size);
> +	} else {
> +		WARN_ONCE(1, "DMA coherent pool depleted, increase size "
> +			     "(recommended min coherent_pool=%zuK)\n",
> +			  gen_pool_size(pool) >> 9);
>  	}
>  	if (gen_pool_avail(pool) < atomic_pool_size)
>  		schedule_work(&atomic_pool_work);
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
