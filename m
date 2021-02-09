Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A93AC433E0
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 08:30:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E787D64EC2
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 08:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E787D64EC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8307B86204;
	Tue,  9 Feb 2021 08:30:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LEDMer-JLMdS; Tue,  9 Feb 2021 08:30:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 13B84860D2;
	Tue,  9 Feb 2021 08:30:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03F22C0174;
	Tue,  9 Feb 2021 08:30:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4982CC013A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 08:30:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2DFC687281
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 08:30:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tj6fRz4CjnbX for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 08:30:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com
 [209.85.166.169])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9376C87269
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 08:30:11 +0000 (UTC)
Received: by mail-il1-f169.google.com with SMTP id p15so15336176ilq.8
 for <iommu@lists.linux-foundation.org>; Tue, 09 Feb 2021 00:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CD7Xj/h3myZPE11iClGnY0ITJjZw2WaNmh4Gs5ySEmU=;
 b=Z8/glXM4r2nvS+LxLw4u5mH2ajnyiNqMAp89KxvOsQ79QYUf+J9Uxi5WqPcaOfU9de
 0V8+b6akhQ45QuTYOPMxUyD9qmM8oScMqOS8Oj1e9r9VWtH5UVoa43jhATVtS5gBZMuR
 jtwW+wPVpUEXAjtRmVt/91CORyu68Fm8Gyuew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CD7Xj/h3myZPE11iClGnY0ITJjZw2WaNmh4Gs5ySEmU=;
 b=ieN56Vy7u5Bj/kRphL2P9QZAZR9LfAr0fAhN+d9lypTz1DgogoT4DOiRPDI4j/C+TA
 vO78x+reHeXKcOxivJIZkoSjDkRxTlbjsFHTyJ5fRumKDgFydbrIdkOTAmuDTRlhF24e
 bVwwSs2AVkiWwU4sb6Y+QaemYx9bPKZG+IrIo25mK0LvrbD2mb6crQdFy5079e4iRLCs
 ONRzE9eZ7ttSfWxWj7qC/pbEb2asUjwKtV2BcFkQbHvU6ZX5neuyxj+rlW8jYpVyI7Lx
 Ga2A9FtxAwNUZ8JD7rpVXffPxsDJru3nr12gnXaRKE4zQo6tcxGZ0rPGzIGEUAOX3jzJ
 yRfw==
X-Gm-Message-State: AOAM532sPwSF6VIJpTIdmHjY+8G/kOXXZrXqh5E7NyHDZEAeYrCqRNnJ
 EhpAsYNXc6mRi8yAuvcDBBCrv2wkllX/Iw==
X-Google-Smtp-Source: ABdhPJw+lgYtILasoUOw2lzMMtWsSAuUTtkZb09CfWejXNljIZ5lh8JYLYDXKlMX68Ca0nmSPNkK3Q==
X-Received: by 2002:a05:6e02:1bee:: with SMTP id
 y14mr11839550ilv.256.1612859410701; 
 Tue, 09 Feb 2021 00:30:10 -0800 (PST)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com.
 [209.85.166.47])
 by smtp.gmail.com with ESMTPSA id d9sm10144070ilo.20.2021.02.09.00.30.09
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Feb 2021 00:30:09 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id q7so17953625iob.0
 for <iommu@lists.linux-foundation.org>; Tue, 09 Feb 2021 00:30:09 -0800 (PST)
X-Received: by 2002:a5d:894d:: with SMTP id b13mr18083060iot.150.1612859408996; 
 Tue, 09 Feb 2021 00:30:08 -0800 (PST)
MIME-Version: 1.0
References: <20210202095110.1215346-1-hch@lst.de>
 <20210207184855.GA27553@lst.de>
 <CAAFQd5BzAvgiTLGFse+ZWUrFtZ1Ysf+p+e-4rW8gq_iP0xhWEA@mail.gmail.com>
 <20210209082213.GA31902@lst.de>
In-Reply-To: <20210209082213.GA31902@lst.de>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 9 Feb 2021 09:29:58 +0100
X-Gmail-Original-Message-ID: <CANiDSCuzKczCnAdC9b0r-6WVBFYXYnvQHKbxSeYq2QW1uVsDLQ@mail.gmail.com>
Message-ID: <CANiDSCuzKczCnAdC9b0r-6WVBFYXYnvQHKbxSeYq2QW1uVsDLQ@mail.gmail.com>
Subject: Re: add a new dma_alloc_noncontiguous API v2
To: Christoph Hellwig <hch@lst.de>
Cc: Sergey Senozhatsky <senozhatsky@google.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
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

On Tue, Feb 9, 2021 at 9:22 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Feb 08, 2021 at 08:33:50PM +0900, Tomasz Figa wrote:
> > Sorry for the delay. The whole series looks very good to me. Thanks a lot.
> >
> > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>
> Thanks.
>
> Ricardo, do the uvcvideo changes look good to you?  I'd like to queue
> the series up for this merge window.

Let me test them in real hardware today.

Thanks!


-- 
Ricardo Ribalda
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
