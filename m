Return-Path: <SRS0=UfkB=G5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897CAC433DB
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 23:29:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E3892067C
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 23:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3892067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AC06D86697;
	Tue, 26 Jan 2021 23:29:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gmbS0yrZbyau; Tue, 26 Jan 2021 23:29:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E9E4E8669F;
	Tue, 26 Jan 2021 23:29:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1A26C08A1;
	Tue, 26 Jan 2021 23:29:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B280C013A
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 23:29:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8085C204DB
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 23:29:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FGK6BVtLklgG for <iommu@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 23:29:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com
 [209.85.166.46])
 by silver.osuosl.org (Postfix) with ESMTPS id 89BE020459
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 23:29:22 +0000 (UTC)
Received: by mail-io1-f46.google.com with SMTP id n2so37300654iom.7
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 15:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CBy1erHkLMBcGk0Q3oow7s6KaRas0EaJCp36zieGK9E=;
 b=WkNRoEB8P5ECNzKdEHU1MaY1ENG6KFbiRYwxbKJgSn8K+bUaEv2F6ui/00GOkBbZw1
 DpHQFu74uw5I0+o/wfDdMfhbHoEjtEnlpK5FUIHFg83cKzDTFbXIl50qxrcJjlMeI8oV
 JPuFdPCN5FPGu20ODhMYQkx2qhQ0Hb0aqdWQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CBy1erHkLMBcGk0Q3oow7s6KaRas0EaJCp36zieGK9E=;
 b=VzlSrAicNl25tZVYdQmwx8jrfsJvlq2Sk2BfNj4lo+DjRNPy/1zfbkeaubxsNu3UCa
 kESoMnUEq8jIRwBHyqjVbZq4AFWEwo/eSgHS5ftO+rijj2z+a1jGTZxQshyAlgdZRvvp
 jtPjBqTCBNeMg+S9YD9X5o2YOM0KZi7DUdkwijomSURzWdRg361PBZBqksFcsZnOeGpF
 tMIIclPbF/ZSvQiTU+mh3rCmcGCJEcDaqExdx24OO/w4qpsCYkbsQxsNp6ZWKRQFaSL3
 U9vWQZ6gqLcGo1U24G/wE75qwDHVrPfGBKSXhEawdKiPBMnIEQ02BBgI0JyKpKFmQ/Hi
 NCcQ==
X-Gm-Message-State: AOAM531FXSIP729Kp5E1ogX9dhONRkh4b/RsdZ/XMGSl1oUmPPhoQCF5
 4bc7Lf+drXHOcanC8Z2gOXA/Ryl2APFNwA==
X-Google-Smtp-Source: ABdhPJwqn+3u8k+IBdlqGtfdn0RFLmb1SAapwJ9xn4leF74NBQUNOWZRWGjer0Xbl+Qzj+Ua5gPKyg==
X-Received: by 2002:a6b:b50a:: with SMTP id e10mr2712901iof.50.1611703761543; 
 Tue, 26 Jan 2021 15:29:21 -0800 (PST)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com.
 [209.85.166.48])
 by smtp.gmail.com with ESMTPSA id e5sm91211ilu.27.2021.01.26.15.29.20
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Jan 2021 15:29:20 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id u8so24156220ior.13
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 15:29:20 -0800 (PST)
X-Received: by 2002:a05:6638:3012:: with SMTP id
 r18mr6700227jak.13.1611703759669; 
 Tue, 26 Jan 2021 15:29:19 -0800 (PST)
MIME-Version: 1.0
References: <20201125221917.150463-1-ribalda@chromium.org>
 <20201130083410.GD32234@lst.de>
 <20201201033658.GE3723071@google.com> <20201201144916.GA14682@lst.de>
 <CAAFQd5BBEbmENrrZ-vMK9cKOap19XWmfcxwrxKfjWx-wEew8rg@mail.gmail.com>
 <20201208071320.GA1667627@google.com> <20201209111639.GB22806@lst.de>
 <CANiDSCtsOdJUK3r_t8UNKhh7Px0ANNFJkuwM1fBgZ7wnVh0JFA@mail.gmail.com>
 <20210111083614.GA27589@lst.de>
 <CANiDSCvuvj47=nhoWhvzc5raMxM60w+JYRWjd0YepcbcbkrUjA@mail.gmail.com>
 <20210126170659.GA9104@lst.de>
In-Reply-To: <20210126170659.GA9104@lst.de>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 27 Jan 2021 00:29:08 +0100
X-Gmail-Original-Message-ID: <CANiDSCsz+9DJesOTJ5C5HGEH-wwuTmEd3c8yLoHjnDz=2+ndJw@mail.gmail.com>
Message-ID: <CANiDSCsz+9DJesOTJ5C5HGEH-wwuTmEd3c8yLoHjnDz=2+ndJw@mail.gmail.com>
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

Thanks for the series!

I have a couple of questions:

- Is there any platform where dma_alloc_noncontiguos can fail?
This is, !ops->alloc_noncontiguous and !dev->coherent_dma_mask
If yes then we need to add a function to let the driver know in
advance that it has to use the coherent allocator (usb_alloc_coherent
for uvc)

- In dma_alloc_noncontiguos, on the dma_alloc_pages fallback. If we
have a device where the dma happens in only one direction, could not
get more performance with DMA_FROM/TO_DEVICE instead of
DMA_BIDIRECTIONAL ?


Then I have tried to use the API, and I have encountered a problem: on
uvcvideo the device passed to the memory allocator is different for
DMA_PAGES and NON_CONTIGUOUS:
https://github.com/ribalda/linux/blob/042cd497739f71c8d4a83a67ee970369e2baca4a/drivers/media/usb/uvc/uvc_video.c#L1236

I need to dig a bit tomorrow to figure out why this is, I have
hardware to test both paths, so it should not be too difficult.


Thanks again






On Tue, Jan 26, 2021 at 6:07 PM . Christoph Hellwig <hch@lst.de> wrote:
>
> Please take a quick look at this branch:
>
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma_alloc_noncontiguous
>
> Warning: hot off the press, and only with the v4l conversion as that
> seemed at little easier than uvcvideo.



--
Ricardo Ribalda
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
