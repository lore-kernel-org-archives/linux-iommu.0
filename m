Return-Path: <SRS0=8k88=HN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2598BC433DB
	for <iommu@archiver.kernel.org>; Thu, 11 Feb 2021 09:08:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A72BB64DCF
	for <iommu@archiver.kernel.org>; Thu, 11 Feb 2021 09:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72BB64DCF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5731E8755B;
	Thu, 11 Feb 2021 09:08:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EpYOt54m6CEF; Thu, 11 Feb 2021 09:08:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 13CD287553;
	Thu, 11 Feb 2021 09:08:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0FC7C0174;
	Thu, 11 Feb 2021 09:08:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA419C013A
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 09:08:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C173A6F48C
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 09:08:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KA2kjSVgkMa8 for <iommu@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 09:08:33 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id CE5BF6F4F8; Thu, 11 Feb 2021 09:08:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com
 [209.85.166.46])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 28A4E6F48C
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 09:08:32 +0000 (UTC)
Received: by mail-io1-f46.google.com with SMTP id e133so4908628iof.8
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 01:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kdA1Kwoq/S/LKCIqEWml1fSvv8WMuf1jYn8nBhMfcnI=;
 b=VUe+0kbaY+lBr2aOAuw3nZWDJynOj1vx+bapgsEHj20UriFRNFl8g9448c3tGnRubi
 +EvwR0jgW8sfzeMtztTntSjlCZcTr67yBraggSLDUOTlaKo5GBN06hoxX9GWra1YGQiL
 NLztfh16+p4gv4RNidsFwTb/kVDRP5dc/m0TY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kdA1Kwoq/S/LKCIqEWml1fSvv8WMuf1jYn8nBhMfcnI=;
 b=So/TOMeiTTxoU1a2fyq0nyHsyd21Wv8kLu1V2hVvRNLcHZz9G942LXrgiFyHccYkyv
 162SEiICI7wCQfuK9qX5JByjpeqJHBHItF5tXDiULTulHgQEi+CfJlR4f0/9Op6nU+TW
 OQrM57ncsxrh5AZyyivWt02sh/y0Fo1ieEM4TGfwzLT+Stzi45u/D6wwjkf5zRgW/adn
 AFRovCTZdFqHkuhzK9Y1WbaARGVw8X/HYs2wyealYGGl3tNH7XeFem9fYWBEMiCkqhfx
 nfJf28aJqarO3wyz1e/wyPoxg4sS1aN8OB520x0qBPKvnK101dbjYC35lvGkNUtHO4WJ
 0vig==
X-Gm-Message-State: AOAM533l19vOmBklwZoxYrvC0uYLcKiS3VWQ1Wy81ar3nwiOvF3YRtvH
 vbUUTg3MmCcqJ0Ba0c4sUsaeZUZvhsn2NA==
X-Google-Smtp-Source: ABdhPJyOci/ErKmwvZkSOD5Q33IQ0cuLedsFknmygRbfLzzGqkT+GDafP27QPPMw0P2QYIoIdx2M3Q==
X-Received: by 2002:a02:ccc5:: with SMTP id k5mr7735688jaq.105.1613034511150; 
 Thu, 11 Feb 2021 01:08:31 -0800 (PST)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com.
 [209.85.166.182])
 by smtp.gmail.com with ESMTPSA id i3sm2249084ilm.56.2021.02.11.01.08.29
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Feb 2021 01:08:29 -0800 (PST)
Received: by mail-il1-f182.google.com with SMTP id o7so4469436ils.2
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 01:08:29 -0800 (PST)
X-Received: by 2002:a92:730a:: with SMTP id o10mr4922650ilc.160.1613034508965; 
 Thu, 11 Feb 2021 01:08:28 -0800 (PST)
MIME-Version: 1.0
References: <20210202095110.1215346-1-hch@lst.de>
 <20210207184855.GA27553@lst.de>
 <CAAFQd5BzAvgiTLGFse+ZWUrFtZ1Ysf+p+e-4rW8gq_iP0xhWEA@mail.gmail.com>
 <20210209082213.GA31902@lst.de>
 <CANiDSCuzKczCnAdC9b0r-6WVBFYXYnvQHKbxSeYq2QW1uVsDLQ@mail.gmail.com>
 <CANiDSCvPodsmcOi1fMwvZsyMxWsRQWNT7VkbZs4=XePYXfiXow@mail.gmail.com>
 <20210209170217.GA10199@lst.de>
In-Reply-To: <20210209170217.GA10199@lst.de>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 11 Feb 2021 10:08:18 +0100
X-Gmail-Original-Message-ID: <CANiDSCs8dXVoWuwkVs=v+=s770MpzH1xiDuj-080-98ynuz97g@mail.gmail.com>
Message-ID: <CANiDSCs8dXVoWuwkVs=v+=s770MpzH1xiDuj-080-98ynuz97g@mail.gmail.com>
Subject: Re: add a new dma_alloc_noncontiguous API v2
To: Christoph Hellwig <hch@lst.de>
Cc: Sergey Senozhatsky <senozhatsky@google.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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

What are your merge plans for the uvc change?
http://git.infradead.org/users/hch/dma-mapping.git/commit/3dc47131f8aacc2093f68a9971d24c754e435520

Are you going to remove the patch on your Merge request and then send
it for review to Laurent? or merge it through your tree with a S-o-B
him?

Thanks

On Tue, Feb 9, 2021 at 6:02 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Feb 09, 2021 at 03:46:13PM +0100, Ricardo Ribalda wrote:
> > Hi Christoph
> >
> > I have tested it in both arm and x86, since there are not significant
> > changes with the previous version I did not do a performance test.
>
> I'll take this as a Tested-by.



-- 
Ricardo Ribalda
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
