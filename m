Return-Path: <SRS0=CTmu=TY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F22C072B5
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 03:50:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 290B12133D
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 03:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I13Gm5o+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 290B12133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DC607E78;
	Fri, 24 May 2019 03:50:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 99E47E62
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 03:50:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
	[209.85.210.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 50F9F6C5
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 03:50:22 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id b76so4454306pfb.5
	for <iommu@lists.linux-foundation.org>;
	Thu, 23 May 2019 20:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=Meys5AbfHefJr2MxUEnx8+OGhp7ATRQ7K3gNKd4wdrU=;
	b=I13Gm5o+tN+033OCvQGYRdseWRYb9y90+wOF9EOUaj5QRKDbsWYikvdOqa1LdVYQEF
	2ZhjMALlX6tUrs4zDwq1lDEx7N9iOWHW8f55MRV5cptdY9kFlQIxNj/MkE6ngkkcj94E
	alV39V4sXHGmtUolQpKWYkEkBxkp8DzTJ4SGfD4WzrUJNVCoixeDMhYE2dhMyilMw2ag
	TV4Kvy3VTjC6YN5gvxd017GB+M3IZxKYs2+45rwxyjsVyd59inqpXo0xdPcb6v22bT/I
	Iz9pS2laGebLE5B2y8xaoswYxzXi0rdnnGrcsA/IhWJ1i6IxND6Hh/AQ4WdgnGhUunqw
	FuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=Meys5AbfHefJr2MxUEnx8+OGhp7ATRQ7K3gNKd4wdrU=;
	b=iYspExq7LDqQTqVkBobxeA8177QrBaq84IzxIrssks2r6bHVcPtTeAkKLnD4CxkwdB
	Klf564sffF/cyovMQzIxwMPJ1Jal2cXWIfPWwgsqxJdrQy5sw5wKpc5sNjUxDt1vWifE
	usxPnkAgOKA5rV05nsDHXqRqfyZhWOkQU+JhupFvPOBFr3dloDoxZ/2hK1Gqb4FyDFzd
	P5DE1mV47VGyJs2Cp3REMviiEMLJHBDZ/zmCuj0hWmTSIZJ8zgwuWSW+aqWEiIr77P3D
	BEhGwgsNHV4vjhKe0AuUAZCsaBcegaKKPdMwLZscUQnmI8fQxUAC9kt8gD4HieHqjvDI
	GqXw==
X-Gm-Message-State: APjAAAVLPAUlkW59FkqXI4isGU3ZEWoaGoNyIbh6wpUH8zlHUM/9dmPE
	ytqzvJXfV8SVDV30wiYNSfs=
X-Google-Smtp-Source: APXvYqwM0tDEcOnafEzffzv+1HVI6tauA6VBDlswnPyYwQPKUIu5No+afsn7pJoH7g4zS0Uyp/cWMA==
X-Received: by 2002:a63:2a06:: with SMTP id q6mr16134258pgq.290.1558669821822; 
	Thu, 23 May 2019 20:50:21 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	h11sm903497pfn.170.2019.05.23.20.50.21
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 20:50:21 -0700 (PDT)
Date: Thu, 23 May 2019 20:49:04 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: dann frazier <dann.frazier@canonical.com>
Subject: Re: [PATCH v2 1/2] dma-contiguous: Abstract dma_{alloc,
	free}_contiguous()
Message-ID: <20190524034904.GA30034@Asurada-Nvidia.nvidia.com>
References: <20190506223334.1834-1-nicoleotsuka@gmail.com>
	<20190506223334.1834-2-nicoleotsuka@gmail.com>
	<CALdTtnurdNe4+oJjSJfWw1ONf8-xvJ8KhonQkJNj+4LDZT7jAQ@mail.gmail.com>
	<CALdTtnuwRKkna_y5_5BdEYWNRbOQnLvtfz1PY-d4r78tj5hgVw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALdTtnuwRKkna_y5_5BdEYWNRbOQnLvtfz1PY-d4r78tj5hgVw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: chris@zankel.net, keescook@chromium.org, linux-xtensa@linux-xtensa.org,
	tony@atomide.com, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org, jcmvbkbc@gmail.com,
	iommu@lists.linux-foundation.org, dwmw2@infradead.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	wsa+renesas@sang-engineering.com, sfr@canb.auug.org.au,
	akpm@linux-foundation.org, treding@nvidia.com,
	Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>, iamjoonsoo.kim@lge.com
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

On Thu, May 23, 2019 at 08:59:30PM -0600, dann frazier wrote:
> > > diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> > > index b2a87905846d..21f39a6cb04f 100644
> > > --- a/kernel/dma/contiguous.c
> > > +++ b/kernel/dma/contiguous.c
> > > @@ -214,6 +214,54 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
> > >         return cma_release(dev_get_cma_area(dev), pages, count);
> > >  }
> >
> > This breaks the build for me if CONFIG_DMA_CMA=n:
> >
> >   LD [M]  fs/9p/9p.o
> > ld: fs/9p/vfs_inode.o: in function `dma_alloc_contiguous':
> > vfs_inode.c:(.text+0xa60): multiple definition of
> > `dma_alloc_contiguous'; fs/9p/vfs_super.o:vfs_super.c:(.text+0x500):
> > first defined here
> >
> > Do the following insertions need to be under an #ifdef CONFIG_DMA_CMA ?
> 
> Ah, no - the problem is actually a missing "static inline" in the
> !CONFIG_DMA_CMA version of dma_alloc_contiguous().

Yea, I saw it. Thanks for the testing and pointing it out.

Sending v3.....
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
