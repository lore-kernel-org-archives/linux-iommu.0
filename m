Return-Path: <SRS0=X4VR=IJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B519C433E0
	for <iommu@archiver.kernel.org>; Thu, 11 Mar 2021 16:58:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 173FE64FE2
	for <iommu@archiver.kernel.org>; Thu, 11 Mar 2021 16:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173FE64FE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9371D605BF;
	Thu, 11 Mar 2021 16:58:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bUJKriU4A5ih; Thu, 11 Mar 2021 16:58:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CB9B605DE;
	Thu, 11 Mar 2021 16:58:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55281C000C;
	Thu, 11 Mar 2021 16:58:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D146C000A
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 16:58:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 29EB94CF79
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 16:58:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rob7yW9p-dEs for <iommu@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 16:58:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 087A34AA2C
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 16:58:09 +0000 (UTC)
Received: by mail-il1-x132.google.com with SMTP id f10so19526120ilq.5
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 08:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mIw9mpEdtb6xII0/h1pkc9zwar1BCKRrPfEkXgVTjbI=;
 b=AIAwsmpNhzzKXCSsCR+48hrHBgLwiA3le2y40XyItCCiAznTDaLmhQioZKLeYJvj5l
 sYEbViFUJgais0HaTWgDIKrsLRgDvtzoSnhADRD5JFma2Nxe/M4xvkYsCOdCEa2pYKHu
 jWNVeYX37GDpBx1ePo+F+81oLh3OgZLt4anZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mIw9mpEdtb6xII0/h1pkc9zwar1BCKRrPfEkXgVTjbI=;
 b=QAMiOCn9M8xW0RkxY4IRCnfUzQEsqiIgUE6ReJnJ1tCIITvUi78XRMpglumLA7sTzi
 SsBYbT5tyBHDxi2DxBt/nNgAqSDGlvkL7GYFvJs4HD27HAhHzHn0bbUfGcGOTqJ5bp9e
 L27D2cSkIVxfr67irHDRFCF5f/ta66PaD4jCD0ksZb01hp9dT4s/LXPVJs7CAfTpNg0+
 9dW8USJhvrRDPbkHKs811D0qAR+b9De1w7F5zVtxITjupcvcbjg4JaIZd8Ae1b+sN0DZ
 IKx6IXKE21bgWKDBbQwVGA5nx6L/oOBJokOKxwm0R4ZKVe3yxTYwSsfELJoGgz9iG8hb
 Fy+w==
X-Gm-Message-State: AOAM530Euh95ryAI6bOUXvqs6U9v2zdhIMm11yO9P19Hu85+PZxRY8Mi
 fBYaOZi1SM81eRbP373joB3NHwB7+le5QBJI
X-Google-Smtp-Source: ABdhPJwB5vq4yDxu8WWAQXQE36iTcccgSTp9MXEKn2Esg8ITcijPDI6q09U2SGjworHtKq1VZGkwVw==
X-Received: by 2002:a05:6e02:1a42:: with SMTP id
 u2mr7455529ilv.175.1615481889037; 
 Thu, 11 Mar 2021 08:58:09 -0800 (PST)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com.
 [209.85.166.53])
 by smtp.gmail.com with ESMTPSA id r5sm1507892ilb.75.2021.03.11.08.58.08
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Mar 2021 08:58:08 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id n132so22688693iod.0
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 08:58:08 -0800 (PST)
X-Received: by 2002:a05:6638:2711:: with SMTP id
 m17mr4497331jav.115.1615481887730; 
 Thu, 11 Mar 2021 08:58:07 -0800 (PST)
MIME-Version: 1.0
References: <20210301085236.947011-1-hch@lst.de>
 <20210311165250.GB25023@lst.de>
In-Reply-To: <20210311165250.GB25023@lst.de>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 11 Mar 2021 17:57:56 +0100
X-Gmail-Original-Message-ID: <CANiDSCuFkTYMGeL8WK_3VkYy4a1h3hY4NKWTtz=bho844Fa2zw@mail.gmail.com>
Message-ID: <CANiDSCuFkTYMGeL8WK_3VkYy4a1h3hY4NKWTtz=bho844Fa2zw@mail.gmail.com>
Subject: Re: add a new dma_alloc_noncontiguous API v3
To: Christoph Hellwig <hch@lst.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sergey Senozhatsky <senozhatsky@google.com>,
 Robin Murphy <robin.murphy@arm.com>
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

Hi Christoph

I tried to run it in an arm device and it worked fine.


On Thu, Mar 11, 2021 at 5:52 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Any comments?  Especially on the uvcvideo conversion?
>
> On Mon, Mar 01, 2021 at 09:52:30AM +0100, Christoph Hellwig wrote:
> > Hi all,
> >
> > this series adds the new noncontiguous DMA allocation API requested by
> > various media driver maintainers.
> >
> > Changes since v2:
> >  - rebased to Linux 5.12-rc1
> >  - dropped one already merged patch
> >  - pass an attrs argument to dma_alloc_noncontigous
> >  - clarify the dma_vmap_noncontiguous documentation a bit
> >  - fix double assignments in uvcvideo
> >
> > Changes since v1:
> >  - document that flush_kernel_vmap_range and invalidate_kernel_vmap_range
> >    must be called once an allocation is mapped into KVA
> >  - add dma-debug support
> >  - remove the separate dma_handle argument, and instead create fully formed
> >    DMA mapped scatterlists
> >  - use a directional allocation in uvcvideo
> >  - call invalidate_kernel_vmap_range from uvcvideo
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> ---end quoted text---



-- 
Ricardo Ribalda
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
