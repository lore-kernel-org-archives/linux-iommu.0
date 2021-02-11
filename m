Return-Path: <SRS0=8k88=HN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C223C433DB
	for <iommu@archiver.kernel.org>; Thu, 11 Feb 2021 13:20:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B0464E8A
	for <iommu@archiver.kernel.org>; Thu, 11 Feb 2021 13:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B0464E8A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7EC878756F;
	Thu, 11 Feb 2021 13:20:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R5man+M36+x9; Thu, 11 Feb 2021 13:20:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F29E08756B;
	Thu, 11 Feb 2021 13:20:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9979C0174;
	Thu, 11 Feb 2021 13:20:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2541C013A
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 13:20:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E0BBF873A3
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 13:20:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TTMhzI8WM1Lo for <iommu@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 13:20:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com
 [209.85.166.48])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 485C58734F
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 13:20:43 +0000 (UTC)
Received: by mail-io1-f48.google.com with SMTP id m17so5611185ioy.4
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 05:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JCKRoPINZ+vg1pxHvLz7YyDZ6J4aOJvyJXVgjObIKG4=;
 b=mGtVpa0p8+nSp/876Rbyd65LQvkTFLdveKIyns6pGgv6mx2iRe0YWPRl3iis9qOqvg
 SWS5kLaKLirExWjuhlC2pM8F8OODaHEmGJjxA5or2xmJkXM8I9eOSsM2oHc7TLfOl25g
 PlNP7gQIMu8xOmSaw+laMsyYggSZn0rR09/To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JCKRoPINZ+vg1pxHvLz7YyDZ6J4aOJvyJXVgjObIKG4=;
 b=JJ5YGatC1ptbLqZhFkOrs7vI2bD+2dQC3OqZD+VHH/dhBPyeftQ2Jq6HAExCweNho2
 3tfT/pMOlGI3wF5blA82A2f659sIuEY7eTqo5ykk0ct6xam7m+hiilRURz02ErNRZLW5
 +b6lTApazrcBfQmoIs5jqPSCxtwNQzV623VAQLiI/XIUgohx41f4DXC2sYKK8CUPtbTp
 PEX9RVppQakslPBtZUmkBkRY3DNdFJixUSJHQJOigNSzQOHT8sQA8YVoIJcfbq6tjjgv
 U9aFRbbAUic/AN5qTVJFBpG1z4My9HyEkk/qhwjbm/dHIWxlJU7YUHYr7rxAYyCoi3wu
 P+yg==
X-Gm-Message-State: AOAM532kx9ZsbBn1jwKNhKUCrMqoNg5ygDsoMx/WJV4FIc+NJZmJGZeN
 HlTnMiLgf0ERZA0T6ISry2Kjan0LfPgtTQ==
X-Google-Smtp-Source: ABdhPJyKkxHULk66zlQlkmHf+HZMc3KuyVTi/vk/EHyAiT7wixYgmOpJybDWSeE9JzybxN4R/X+jhA==
X-Received: by 2002:a02:83ca:: with SMTP id j10mr8571589jah.129.1613049642183; 
 Thu, 11 Feb 2021 05:20:42 -0800 (PST)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com.
 [209.85.166.41])
 by smtp.gmail.com with ESMTPSA id z7sm2653118iod.8.2021.02.11.05.20.41
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Feb 2021 05:20:41 -0800 (PST)
Received: by mail-io1-f41.google.com with SMTP id u20so5598772iot.9
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 05:20:41 -0800 (PST)
X-Received: by 2002:a02:8642:: with SMTP id e60mr8507360jai.13.1613049640964; 
 Thu, 11 Feb 2021 05:20:40 -0800 (PST)
MIME-Version: 1.0
References: <20210202095110.1215346-1-hch@lst.de>
 <20210207184855.GA27553@lst.de>
 <CAAFQd5BzAvgiTLGFse+ZWUrFtZ1Ysf+p+e-4rW8gq_iP0xhWEA@mail.gmail.com>
 <20210209082213.GA31902@lst.de>
 <CANiDSCuzKczCnAdC9b0r-6WVBFYXYnvQHKbxSeYq2QW1uVsDLQ@mail.gmail.com>
 <CANiDSCvPodsmcOi1fMwvZsyMxWsRQWNT7VkbZs4=XePYXfiXow@mail.gmail.com>
 <20210209170217.GA10199@lst.de>
 <CANiDSCs8dXVoWuwkVs=v+=s770MpzH1xiDuj-080-98ynuz97g@mail.gmail.com>
 <20210211130625.GA20155@lst.de>
In-Reply-To: <20210211130625.GA20155@lst.de>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 11 Feb 2021 14:20:30 +0100
X-Gmail-Original-Message-ID: <CANiDSCupVLQMbJVKrrKBJvJxHgteeVFik7LAJy5zbUi2ESwsGA@mail.gmail.com>
Message-ID: <CANiDSCupVLQMbJVKrrKBJvJxHgteeVFik7LAJy5zbUi2ESwsGA@mail.gmail.com>
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

HI Christoph

On Thu, Feb 11, 2021 at 2:06 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Feb 11, 2021 at 10:08:18AM +0100, Ricardo Ribalda wrote:
> > Hi Christoph
> >
> > What are your merge plans for the uvc change?
> > http://git.infradead.org/users/hch/dma-mapping.git/commit/3dc47131f8aacc2093f68a9971d24c754e435520
> >
> > Are you going to remove the patch on your Merge request and then send
> > it for review to Laurent? or merge it through your tree with a S-o-B
> > him?
>
> I though I had all the ACKs to queue it up.  Is that not what was
> intended?  Queueing up the API without a user is generally a bad idea.
>

I am pretty sure we need the ack from Laurent. He maintains uvc

@Laurent Pinchart what are your thoughts?

Thanks!


-- 
Ricardo Ribalda
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
