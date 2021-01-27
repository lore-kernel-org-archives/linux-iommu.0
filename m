Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1D9C433DB
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 21:35:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E3F664DC4
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 21:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3F664DC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BEDAB873E0;
	Wed, 27 Jan 2021 21:35:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7xFRYbP71uMq; Wed, 27 Jan 2021 21:35:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 25B84873C9;
	Wed, 27 Jan 2021 21:35:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FF8AC08A1;
	Wed, 27 Jan 2021 21:35:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C396C013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 21:35:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3088E86366
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 21:35:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Ch8XT3TQSHn for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 21:35:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com
 [209.85.166.47])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7FDCC86362
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 21:35:16 +0000 (UTC)
Received: by mail-io1-f47.google.com with SMTP id h11so3404325ioh.11
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 13:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B1OrPnRGym/IRixVkvzf03+5dttK+B+Ggd5w3Ge31lw=;
 b=WCzSGAO7mjzX3wOjkJ8Xi+N96UOte29yYftfMjgzGN07dKBxV6KHe6Mgk00CEi1ttL
 60aWRQW3pAzpzTDPTMn35ux/Qi8CBERZCGV0kWR2Tq7KcxKkkiycwEzw3bglvBpsUXa8
 jpX/rB8VmbY4VBdDKdaML9sNTelm7OUgk3Lac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B1OrPnRGym/IRixVkvzf03+5dttK+B+Ggd5w3Ge31lw=;
 b=RPyfWGQ7DV41wSEq7cs1hm61RTG+GYOrhzHK6cBG6JPhKl7F5nijMlzofXQd9a1tTF
 mApA6RtwiN0VxuooRSDa7DO+k6thsSy5IAkUcxNqKCRep/6YvGGF6aXAqmRuLTAFPdV9
 6XGQ9TPNhtW0FTEccLQ4qZoZS2jNMNTmbNVvQOmZwEkVgYoQWbXEVKTRtc+Dy13dmKUe
 6X4v+l1IuxR2Zn1AiN9NR+bGyS7f9iYdeOfqdLSR6MX8qOoyB7DiVbFGlLDRb1YSCQEQ
 OgGxDu09ewcdk1m5cNklnTYSLrqMu8oh7MMA2A+GuhoOGxKJPrwZ5eNvnQLKWo4yZqQp
 YpOg==
X-Gm-Message-State: AOAM533gSjWtrrnIwB6UotyWBxqzdrMyB8zXP+sPkKhd25q+fGXp1/7+
 IJp37Yv/dgVT2/7t7/Xmz/76lD6mH8Zv8m71
X-Google-Smtp-Source: ABdhPJzVchJD8Bd36B+a1+7EhlKGeIbzA9nOell36FYhbtRFndTpWdjx/kMn9FrY8ps1NUd5gz5/KA==
X-Received: by 2002:a5d:968e:: with SMTP id m14mr8898806ion.26.1611783315646; 
 Wed, 27 Jan 2021 13:35:15 -0800 (PST)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com.
 [209.85.166.171])
 by smtp.gmail.com with ESMTPSA id 186sm1437678iou.23.2021.01.27.13.35.13
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Jan 2021 13:35:14 -0800 (PST)
Received: by mail-il1-f171.google.com with SMTP id p15so2586438ilq.8
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 13:35:13 -0800 (PST)
X-Received: by 2002:a05:6e02:194e:: with SMTP id
 x14mr10530200ilu.218.1611783313321; 
 Wed, 27 Jan 2021 13:35:13 -0800 (PST)
MIME-Version: 1.0
References: <20201201033658.GE3723071@google.com>
 <20201201144916.GA14682@lst.de>
 <CAAFQd5BBEbmENrrZ-vMK9cKOap19XWmfcxwrxKfjWx-wEew8rg@mail.gmail.com>
 <20201208071320.GA1667627@google.com> <20201209111639.GB22806@lst.de>
 <CANiDSCtsOdJUK3r_t8UNKhh7Px0ANNFJkuwM1fBgZ7wnVh0JFA@mail.gmail.com>
 <20210111083614.GA27589@lst.de>
 <CANiDSCvuvj47=nhoWhvzc5raMxM60w+JYRWjd0YepcbcbkrUjA@mail.gmail.com>
 <20210126170659.GA9104@lst.de>
 <CANiDSCsz+9DJesOTJ5C5HGEH-wwuTmEd3c8yLoHjnDz=2+ndJw@mail.gmail.com>
 <20210127155608.GA20272@lst.de>
In-Reply-To: <20210127155608.GA20272@lst.de>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 27 Jan 2021 22:35:02 +0100
X-Gmail-Original-Message-ID: <CANiDSCsHquQWgeGurmh83UDm3xPzkzaRTV0EOKQs=Q_a349f=Q@mail.gmail.com>
Message-ID: <CANiDSCsHquQWgeGurmh83UDm3xPzkzaRTV0EOKQs=Q_a349f=Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] media: uvcvideo: Use dma_alloc_noncontiguos API
To: ". Christoph Hellwig" <hch@lst.de>
Cc: Sergey Senozhatsky <senozhatsky@google.com>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
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

On Wed, Jan 27, 2021 at 4:56 PM . Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Jan 27, 2021 at 12:29:08AM +0100, Ricardo Ribalda wrote:
> > - Is there any platform where dma_alloc_noncontiguos can fail?
> > This is, !ops->alloc_noncontiguous and !dev->coherent_dma_mask
> > If yes then we need to add a function to let the driver know in
> > advance that it has to use the coherent allocator (usb_alloc_coherent
> > for uvc)
>
> dev->coherent_dma_mask is set by the driver.  So the only reason why
> dma_alloc_noncontiguos will fail is because is because it can't
> allocate any memory.
>
> > - In dma_alloc_noncontiguos, on the dma_alloc_pages fallback. If we
> > have a device where the dma happens in only one direction, could not
> > get more performance with DMA_FROM/TO_DEVICE instead of
> > DMA_BIDIRECTIONAL ?
>
> Yes, we could probably do that.
>
> >
> >
> > Then I have tried to use the API, and I have encountered a problem: on
> > uvcvideo the device passed to the memory allocator is different for
> > DMA_PAGES and NON_CONTIGUOUS:
> > https://github.com/ribalda/linux/blob/042cd497739f71c8d4a83a67ee970369e2baca4a/drivers/media/usb/uvc/uvc_video.c#L1236
> >
> > I need to dig a bit tomorrow to figure out why this is, I have
> > hardware to test both paths, so it should not be too difficult.
>
> I always found the USB dma alloc API a little weird, but we might have
> to follow the scheme of the usb coherent wrappers there.

I have used the current API here:

https://git.kernel.org/pub/scm/linux/kernel/git/ribalda/linux.git/log/?h=uvc-noncontiguous

And I think the result is very clean. Great work!

I have tested it in X86 and in arm64, with similar performance as the
previous patchset.

Maybe you want to cherry pick that commit into your series I can also
send the patch to the list for review if you prefer so.

At least in 5.11 rc5 I the same dmadev worked in arm64 and x86.

Best regards!


-- 
Ricardo Ribalda
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
