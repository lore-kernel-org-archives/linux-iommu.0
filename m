Return-Path: <SRS0=DkpR=AJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA26C433E1
	for <iommu@archiver.kernel.org>; Sun, 28 Jun 2020 04:25:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3BB8206F2
	for <iommu@archiver.kernel.org>; Sun, 28 Jun 2020 04:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="RQOD5BBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BB8206F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9227B87F04;
	Sun, 28 Jun 2020 04:25:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AZ1qX2ZerYZ0; Sun, 28 Jun 2020 04:25:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5D07287EBC;
	Sun, 28 Jun 2020 04:25:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40696C0865;
	Sun, 28 Jun 2020 04:25:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 755B3C016F
 for <iommu@lists.linux-foundation.org>; Sun, 28 Jun 2020 04:25:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 68EE288236
 for <iommu@lists.linux-foundation.org>; Sun, 28 Jun 2020 04:25:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CsJ7hLDhso2C for <iommu@lists.linux-foundation.org>;
 Sun, 28 Jun 2020 04:25:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BF93B88292
 for <iommu@lists.linux-foundation.org>; Sun, 28 Jun 2020 04:25:23 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id f9so6460536pfn.0
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 21:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=T6k3mUS0NyU/oVqx+193+R6qE7iZSRfZJ4keDgLyvLo=;
 b=RQOD5BBOUOC26pA97VueO5OK2Bgh40J4A0HPLYUXfmeH8MWKYoyUA2z4afWtMANAXD
 +69alJ6XTAgXMXX8JQ7u8Mpnk3skIXEXGMVe1vxIGpeuisO4+C+SwCnsj7N7ctUW1CJ/
 x0ImdAHsCK0HpkxIPutNwTpB6lpVUIgWGXIKof8shyqqbrHN/tDfq84acBbTFbCI9AJl
 d2tAA57OvD3r8JmRkdDi+N62fWnWylytHh/Yy1EJPtCVIiwbpfr3mb1FcC3uVLkTuFnG
 m9QEU37k0MI48Hryx7zx2+kW043E7AwHk3gQ3G1GxnSXRB8a/YSU6wp+J20aVIxyoKc5
 sW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=T6k3mUS0NyU/oVqx+193+R6qE7iZSRfZJ4keDgLyvLo=;
 b=VCkGzrrSHH9FFxeh04XsI/l7nle1KjBpc7VdY5oEqn/SU9NFWHph7yAFZ97YoA8GcV
 2ZIQaGkNas0Iiw+k3A07yZHYL+mlNT5NzgPP4Wx2Xh1n3XWnPTtkk1m7xg57Xe0gHKd2
 eQlOTSMMjkWL/L6bA9U2rE0b8ALYhh2FqoseDQciMvZ+NcigUaOaVY8RzuxTnraX1WWE
 gZnkZ7IeCsbsv4hegf425QIVJor6KTVTiTguB7S0XbzZTkoYR/AB5Bm5wXCJdU9lAlWk
 j4jDWM9HPlG4xXn0JTcJZFLnmrSoRcph0y9id2VfUo/t9kniytnQLEAGbdzyj5QFaLjE
 nu/w==
X-Gm-Message-State: AOAM533EnBZ/cXC2cTsScoDQctlDUwc/aDyKk6d+G83Mu2luM3hDk6Vl
 ArJT+s6sGUKQ0r8PGcrrpIts5Q==
X-Google-Smtp-Source: ABdhPJzQXFRnjjCyGFerSlarK8lzzF7IXh0YSHV55/dv+KxzFDN3rMB78EAtPtATQehvaa2OaDcNgQ==
X-Received: by 2002:a62:aa0e:: with SMTP id e14mr8983062pff.128.1593318323161; 
 Sat, 27 Jun 2020 21:25:23 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id t126sm5550162pfd.214.2020.06.27.21.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2020 21:25:22 -0700 (PDT)
Date: Sat, 27 Jun 2020 21:25:21 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [patch] dma-pool: warn when coherent pool is depleted
In-Reply-To: <20200621211200.GA158319@roeck-us.net>
Message-ID: <alpine.DEB.2.22.394.2006272124470.591864@chino.kir.corp.google.com>
References: <20200621211200.GA158319@roeck-us.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Sun, 21 Jun 2020, Guenter Roeck wrote:

> > When a DMA coherent pool is depleted, allocation failures may or may not
> > get reported in the kernel log depending on the allocator.
> > 
> > The admin does have a workaround, however, by using coherent_pool= on the
> > kernel command line.
> > 
> > Provide some guidance on the failure and a recommended minimum size for
> > the pools (double the size).
> > 
> > Signed-off-by: David Rientjes <rientjes@google.com>
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> 
> Also confirmed that coherent_pool=256k works around the crash
> I had observed.
> 

Thanks Guenter.  Christoph, does it make sense to apply this patch since 
there may not be an artifact left behind in the kernel log on allocation 
failure by the caller?

> Guenter
> 
> > ---
> >  kernel/dma/pool.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> > --- a/kernel/dma/pool.c
> > +++ b/kernel/dma/pool.c
> > @@ -239,12 +239,16 @@ void *dma_alloc_from_pool(struct device *dev, size_t size,
> >  	}
> >  
> >  	val = gen_pool_alloc(pool, size);
> > -	if (val) {
> > +	if (likely(val)) {
> >  		phys_addr_t phys = gen_pool_virt_to_phys(pool, val);
> >  
> >  		*ret_page = pfn_to_page(__phys_to_pfn(phys));
> >  		ptr = (void *)val;
> >  		memset(ptr, 0, size);
> > +	} else {
> > +		WARN_ONCE(1, "DMA coherent pool depleted, increase size "
> > +			     "(recommended min coherent_pool=%zuK)\n",
> > +			  gen_pool_size(pool) >> 9);
> >  	}
> >  	if (gen_pool_avail(pool) < atomic_pool_size)
> >  		schedule_work(&atomic_pool_work);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
