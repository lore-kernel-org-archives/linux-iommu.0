Return-Path: <SRS0=ThSx=EQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01930C55ABD
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 09:33:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E6B520780
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 09:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i7K+5/+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6B520780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3BF4C21519;
	Tue, 10 Nov 2020 09:33:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uJLA6BzpoK0e; Tue, 10 Nov 2020 09:33:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 60C142050D;
	Tue, 10 Nov 2020 09:33:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4AECCC088B;
	Tue, 10 Nov 2020 09:33:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7ED21C016F
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 09:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7549D87183
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 09:33:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6jCuPVMrGeWs for <iommu@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 09:33:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9096187178
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 09:33:19 +0000 (UTC)
Received: by mail-ot1-f68.google.com with SMTP id z16so11866743otq.6
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 01:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4UkFzS0xqfoJt9doPeSUXNjV1Z9m4QzgZeqM5Nk8Yss=;
 b=i7K+5/+7cLZ5ZRdhNEamXRcWw2QQ5XKCYG2d+/ImIPCzSBjpmq/0TvrywlA9n7NxpH
 B766buJa+ieQ3fgGJlGjHosI3xzo0781KmeChVDqeRbxFFNxJfRC7WWIFV7adexCwpx+
 NTIuE0Bpoi0kHCRsaU97HNjA1Reud/62RUqaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4UkFzS0xqfoJt9doPeSUXNjV1Z9m4QzgZeqM5Nk8Yss=;
 b=WBhemCSof+r54Si+OC5JXQD9/RScnNCbSxxSYiYRmx+xzTqDHt2gfqkQuNoOT0+iw0
 iiV3HwAkTd7n7HtOGEwQrccqjJQlTK+lpFoTT3gWVgsUi9fQXwJIcGCXbedwG28a55wp
 2UHjTCvgHK4wVsogfbZV6oJOB5CwfoSTXF9xsC4iyKQNByE/WGeW4zwVHVeMtXaB24Pj
 hNJWFZ9uhljbrXkbHk5rGYoO2HD9iGrf0fVVZq1+CJ52/mGQ2ZiRoFjqCsGoOKSl9i0I
 LDD0spBqklX2EVw/usTVX9kwgzEV6WBMB/xDDNgeqWD2OZTs0My0Bpqv7IW6zdtQkqtb
 vv7w==
X-Gm-Message-State: AOAM530ky24+aoTOKsc9jMEMRTVGc0yCpkLHXuxzzAGW9SoDD5uon5jY
 /QerMDj407eRw8+Ex7Edxz0nUFzE+a1SuUrJ
X-Google-Smtp-Source: ABdhPJx2BLzNg0ZPrkOzmw6Quz6c6axX6V7UMAgTgrW4xDzr1CAcxSGkmaccAaccbLwvnktijY2zOg==
X-Received: by 2002:a05:6830:1699:: with SMTP id
 k25mr12436809otr.252.1605000798223; 
 Tue, 10 Nov 2020 01:33:18 -0800 (PST)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com.
 [209.85.167.171])
 by smtp.gmail.com with ESMTPSA id j21sm3224836otq.18.2020.11.10.01.33.17
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2020 01:33:17 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id w145so13590535oie.9
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 01:33:17 -0800 (PST)
X-Received: by 2002:aca:3c54:: with SMTP id j81mr551270oia.11.1605000796616;
 Tue, 10 Nov 2020 01:33:16 -0800 (PST)
MIME-Version: 1.0
References: <20200930160917.1234225-1-hch@lst.de>
 <20200930160917.1234225-9-hch@lst.de>
 <CAAFQd5CttttqMXb=iDPb+Z0WGUa2g=W6JwXJ-5HbhmrDyxP+cQ@mail.gmail.com>
 <CANiDSCtefXKw-xC3bskyggW-BzCmVPj6GGLvO=cCPZHbS1oTDA@mail.gmail.com>
 <20201110092506.GA24469@lst.de>
In-Reply-To: <20201110092506.GA24469@lst.de>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Nov 2020 10:33:05 +0100
X-Gmail-Original-Message-ID: <CANiDSCsBUBV1WA2To9x26Uhc5SU-4xuh3m4wUwXBcGwA6n8now@mail.gmail.com>
Message-ID: <CANiDSCsBUBV1WA2To9x26Uhc5SU-4xuh3m4wUwXBcGwA6n8now@mail.gmail.com>
Subject: Re: [PATCH 8/8] WIP: add a dma_alloc_contiguous API
To: Christoph Hellwig <hch@lst.de>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
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

On Tue, Nov 10, 2020 at 10:25 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Nov 09, 2020 at 03:53:55PM +0100, Ricardo Ribalda wrote:
> > Hi Christoph
> >
> > I have started now to give a try to your patchset. Sorry for the delay.
> >
> > For uvc I have prepared this patch:
> > https://github.com/ribalda/linux/commit/9094fe223fe38f8c8ff21366d893b43cbbdf0113
> >
> > I have tested successfully in a x86_64 noteboot..., yes I know there
> > is no change for that platform :).
> > I am trying to get hold of an arm device that can run the latest
> > kernel from upstream.
> >
> > On the meanwhile if you could take a look to the patch to verify that
> > this the way that you expect the drivers to use your api I would
> > appreciate it
>
> This looks pretty reaosnable.
>

Great

Also FYI, I managed to boot an ARM device with that tree. But I could
not test the uvc driver (it was a remote device with no usb device
attached)

Hopefully I will be able to test it for real this week.

Any suggestions for how to measure performance difference?

Thanks!

> Note that ifdef  CONFIG_DMA_NONCOHERENT in the old code doesn't actually
> work, as that option is an internal thing just for mips and sh..



-- 
Ricardo Ribalda
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
