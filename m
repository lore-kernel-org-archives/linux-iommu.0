Return-Path: <SRS0=58s/=DO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7547C41604
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 12:22:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36F9A206D9
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 12:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IxPec1in"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F9A206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A55F486A7B;
	Wed,  7 Oct 2020 12:22:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2TICwn8wC5+S; Wed,  7 Oct 2020 12:22:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DB68286972;
	Wed,  7 Oct 2020 12:22:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9C48C016F;
	Wed,  7 Oct 2020 12:22:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED27BC0051
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 12:21:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D736B86A03
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 12:21:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qFq42bDWO2dj for <iommu@lists.linux-foundation.org>;
 Wed,  7 Oct 2020 12:21:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id AD1BC869FE
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 12:21:58 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id v19so1923841edx.9
 for <iommu@lists.linux-foundation.org>; Wed, 07 Oct 2020 05:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7rvcLVVp+iunfwmEIXwaT4iDFBQHHexJb1eiNV9hSvU=;
 b=IxPec1inBA3XKBVEkijHSe0RQpCGY6i5Zx4zjTGEvIdZRZSojpCqwegqlq2Nq47fA9
 ETWPZvj3lKfnnCodpnQMTpne/EEaRSnqKApQLAY/QOOMuJ6ODlUD5K+xr8MH0mWFKI+v
 b4AQOPg5faD6fDmYthS1vWnOiZeopihoSJ764=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7rvcLVVp+iunfwmEIXwaT4iDFBQHHexJb1eiNV9hSvU=;
 b=qE3qRrdpqtDHXFgDfDd+y5yk/hjGvF+eQO/lZ+jtrQqqmYOc79xwAi0CReDr/pSNUz
 fl7OaNg9z4cMoLF9ZhMCqsoA31zhZBKyj/UU8CnZfXdHGL+B5af0EhYF+Br5nvr9Q8c9
 +J7p9OLOUkD3ZWjmjjHnFhloIfljS3U/4y7DzWuEN8m/KaEaSZpUOiu/sPABkworKbZY
 CudweOWPLJQ5M9Dxn0oFxoTR4zOTnFkNASlU4hvkhUDpD4lO00Tp88GV/lBoQqDlIliT
 J9Bfl3XDXqTUXT+2GLvF+anYdERsanzr7XJXMwLwcdZRcPKyR7+1+zfZiuOltaSPsXq5
 Oq8A==
X-Gm-Message-State: AOAM530p1pWga6cHt/VCJak6ERlMPgSqqdYjUog/MU4/o/plksC1v6nV
 U87g4D8OF+Lbc+q3SHnt3aZdIhXTnv+UAA==
X-Google-Smtp-Source: ABdhPJwfdN+SSXvxtDj69gd2/38Z2oV1O2JJGrcqKcQpPLgis5lpn3e9MYQpIjF3A1R1jf6x8eN7rQ==
X-Received: by 2002:a50:d591:: with SMTP id v17mr3338006edi.92.1602073316733; 
 Wed, 07 Oct 2020 05:21:56 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com.
 [209.85.221.49])
 by smtp.gmail.com with ESMTPSA id o13sm1392420ejr.120.2020.10.07.05.21.54
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 05:21:55 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id n15so1926182wrq.2
 for <iommu@lists.linux-foundation.org>; Wed, 07 Oct 2020 05:21:54 -0700 (PDT)
X-Received: by 2002:adf:f2ce:: with SMTP id d14mr2420557wrp.32.1602073314520; 
 Wed, 07 Oct 2020 05:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200930160917.1234225-1-hch@lst.de>
 <20200930160917.1234225-9-hch@lst.de>
 <20201002175040.GA1131147@chromium.org> <20201005082629.GA13850@lst.de>
 <CAAFQd5DcFjTUpOYkaz4nGxozgOc9oGf9QngjbpXWdcwXTT=kmw@mail.gmail.com>
 <20201007062150.GA10601@lst.de>
In-Reply-To: <20201007062150.GA10601@lst.de>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 7 Oct 2020 14:21:43 +0200
X-Gmail-Original-Message-ID: <CAAFQd5AtN-ykAF_2mAqGxVugeEegYxfYdS6gD4O3zCY1jznNYA@mail.gmail.com>
Message-ID: <CAAFQd5AtN-ykAF_2mAqGxVugeEegYxfYdS6gD4O3zCY1jznNYA@mail.gmail.com>
Subject: Re: [PATCH 8/8] WIP: add a dma_alloc_contiguous API
To: Christoph Hellwig <hch@lst.de>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
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

On Wed, Oct 7, 2020 at 8:21 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Oct 06, 2020 at 10:56:04PM +0200, Tomasz Figa wrote:
> > > Yes.  And make sure the API isn't implemented when VIVT caches are
> > > used, but that isn't really different from the current interface.
> >
> > Okay, thanks. Let's see if we can make necessary changes to the videobuf2.
> >
> > +Sergey Senozhatsky for awareness too.
>
> I can defer the changes a bit to see if you'd really much prefer
> the former interface.  I think for now the most important thing is
> that it works properly for the potential users, and the prime one is
> videobuf2 for now.  drm also seems like a big potential users, but I
> had a really hard time getting the developers to engage in API
> development.

My initial feeling is that it should work, but we'll give you a
definitive answer once we prototype it. :)

We might actually give it a try in the USB HCD subsystem as well, to
implement usb_alloc_noncoherent(), as an optimization for drivers
which have to perform multiple random accesses to the URB buffers. I
think you might recall discussing this by the way of the pwc and
uvcvideo camera drivers.

Best regards,
Tomasz
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
