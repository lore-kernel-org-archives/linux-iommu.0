Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EA2C433E0
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 17:01:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D62364E0C
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 17:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D62364E0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1F34386958;
	Thu, 28 Jan 2021 17:01:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JocF6iembxMx; Thu, 28 Jan 2021 17:01:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A4B7786910;
	Thu, 28 Jan 2021 17:01:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11105C0FA8;
	Thu, 28 Jan 2021 17:01:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55BA2C08A1
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 17:01:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3659C203E2
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 17:01:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yqzi4wat1XiG for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 17:01:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com
 [209.85.166.178])
 by silver.osuosl.org (Postfix) with ESMTPS id 9887820343
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 17:01:11 +0000 (UTC)
Received: by mail-il1-f178.google.com with SMTP id e7so5861571ile.7
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 09:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gar8fBlSsZFzuxpXobcokllNvMKbpQD2Smckqot5AV0=;
 b=R3385CEDtxrszE24UXwkp0ZU2U/OxxdtH7/PIESlm6ZDdnLzURn5PTJpKHAz3HOjFV
 4jddEodBYlle4AtEzG4w+16LjwVOb8uZLdLeydFODHiifeRe1u+cD6DkQHyQ70QWZRDh
 sLAUPg5YB8to0myR+Mth92WbIszUnr71jwtds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gar8fBlSsZFzuxpXobcokllNvMKbpQD2Smckqot5AV0=;
 b=LA1eSzSW5N5iGp07/bjlNqWqxvw3GMXiTV+ZGOX8XnJ83IONh6SsDcnucuZA88J70e
 Z6TVXHKVZ4qXRCsvbrsGendN1JQbaxxQRom7PeXXphRUo+u9pTGZhy50nv1yslwv0RWl
 7lOcFsDff4a/6bGWrWdHDMsLQDS2UCtSEzolapbbIkaZ9DC24bDtN0Z/8hnpVLYvosG1
 /GpKZZZ+o2MoAlN3uDBQtVX53My+gxw7xL6aKKWYk7b5x6jAjEbPJdwZQXqCpzw0Gwqq
 JZdiytg55vF5r26uET1bSERGmMdpgLF+R601aWYZq32xupcCbarxBiql6of9NS9uKfQl
 m4Kw==
X-Gm-Message-State: AOAM533TWpNwl+1zQvSjRw2wzgBdbCuj0pakrwn4WreeQbb4zLXw1P5K
 RvW+Nyj3VlRWK5Pb5REsfD9LLKAUwvtDGeAi
X-Google-Smtp-Source: ABdhPJwVxdrQx3cYcFc+RXkRS+t5QaVrLqdR+6ymsyBSx5qdW/5fb8HiKURUh7hx7k8SoznvU0hsQQ==
X-Received: by 2002:a92:a80d:: with SMTP id o13mr10866ilh.74.1611853270719;
 Thu, 28 Jan 2021 09:01:10 -0800 (PST)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com.
 [209.85.166.44])
 by smtp.gmail.com with ESMTPSA id y25sm2777071ioa.5.2021.01.28.09.01.09
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Jan 2021 09:01:10 -0800 (PST)
Received: by mail-io1-f44.google.com with SMTP id z22so6263896ioh.9
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 09:01:09 -0800 (PST)
X-Received: by 2002:a5d:9717:: with SMTP id h23mr506478iol.4.1611853268632;
 Thu, 28 Jan 2021 09:01:08 -0800 (PST)
MIME-Version: 1.0
References: <20210128145837.2250561-1-hch@lst.de>
 <20210128145837.2250561-7-hch@lst.de>
 <20210128150955.GA30563@lst.de>
In-Reply-To: <20210128150955.GA30563@lst.de>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 28 Jan 2021 18:00:57 +0100
X-Gmail-Original-Message-ID: <CANiDSCtV8eiH7r6-mX3QhsYvJapqRfYufu4-iqmeiy6GiwwE_A@mail.gmail.com>
Message-ID: <CANiDSCtV8eiH7r6-mX3QhsYvJapqRfYufu4-iqmeiy6GiwwE_A@mail.gmail.com>
Subject: Re: [PATCH 6/6] media: uvcvideo: Use dma_alloc_noncontiguos API
To: Christoph Hellwig <hch@lst.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Sergey Senozhatsky <senozhatsky@google.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
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

HI Christoph

Thanks for your comments

On Thu, Jan 28, 2021 at 4:09 PM Christoph Hellwig <hch@lst.de> wrote:
>
> I just included this patch as-is, but here are a few comments:
>
> On Thu, Jan 28, 2021 at 03:58:37PM +0100, Christoph Hellwig wrote:
> > +static void uvc_urb_dma_sync(struct uvc_urb *uvc_urb, bool for_device)
> > +{
> > +     struct device *dma_dev = dma_dev = stream_to_dmadev(uvc_urb->stream);
> > +
> > +     if (for_device)
> > +             dma_sync_sgtable_for_device(dma_dev, uvc_urb->sgt,
> > +                                         DMA_FROM_DEVICE);
> > +     else
> > +             dma_sync_sgtable_for_cpu(dma_dev, uvc_urb->sgt,
> > +                                      DMA_FROM_DEVICE);
> > +}
>
> Given that we vmap the addresses this also needs
> flush_kernel_vmap_range / invalidate_kernel_vmap_range calls for
> VIVT architectures.

We only read from the device to the cpu. Then can we run only
invalidate_kernel_vmap_range() ?

something like ?
else {
          dma_sync_sgtable_for_cpu(dma_dev, uvc_urb->sgt, DMA_FROM_DEVICE);
           invalidate_kernel_vmap_range(uvc_urb->buffer,
uvc_urb->stream->urb_size );
}

Thanks!






--
Ricardo Ribalda
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
