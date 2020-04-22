Return-Path: <SRS0=sVNY=6G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC1EC5518C
	for <iommu@archiver.kernel.org>; Wed, 22 Apr 2020 19:50:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEBFD2071E
	for <iommu@archiver.kernel.org>; Wed, 22 Apr 2020 19:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N4XJyGIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEBFD2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 97A8B22728;
	Wed, 22 Apr 2020 19:50:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rUcLskbv06tR; Wed, 22 Apr 2020 19:50:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7115A2271C;
	Wed, 22 Apr 2020 19:50:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53880C1797;
	Wed, 22 Apr 2020 19:50:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C311C0175
 for <iommu@lists.linux-foundation.org>; Wed, 22 Apr 2020 19:50:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0AC8B88476
 for <iommu@lists.linux-foundation.org>; Wed, 22 Apr 2020 19:50:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wqs70IU9pWvH for <iommu@lists.linux-foundation.org>;
 Wed, 22 Apr 2020 19:50:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ua1-f67.google.com (mail-ua1-f67.google.com
 [209.85.222.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3F45088448
 for <iommu@lists.linux-foundation.org>; Wed, 22 Apr 2020 19:50:12 +0000 (UTC)
Received: by mail-ua1-f67.google.com with SMTP id y10so3132296uao.8
 for <iommu@lists.linux-foundation.org>; Wed, 22 Apr 2020 12:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3SOZ/kuYPJyFAJV3DkFh+WewThK39UItCMPkriQP28k=;
 b=N4XJyGIORMnB7t4xAh0V4FafNe7aQpOGecPfMWtYdZA1QWheksB21HqlyRprFqBNlx
 1WFMRq7wGfLDwgMeBX/p5CovR+swvRXlk7Z/YeQtBbrhcReV/vZ47nhBDqDGNPC3GPPh
 VWul0+ZhqslDhGi2ur2rAQ33vUyHb0HULuIHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3SOZ/kuYPJyFAJV3DkFh+WewThK39UItCMPkriQP28k=;
 b=Qkt7JE9nENSCP7sBupIq5gCA/aAa7T3uvudqtt7C2CbtDbtxCg3wncTKHnCvng5Vic
 8NZJ6UPmNwbIwh2dv4svY0YgU6uUUJBgQv6axpZOOIF1OB8XoUSfvYG+XkDVJCsBMQxM
 iGbpXuejgFLp2yHws9BNlAISFjLRJPbgRqkOKRqgzqBx+d/CKEWaFkGUxmRfLDRLo2xr
 czLU5NED2KBUwOAOyR/E2Zwk+6UFEWdo3imOgoJw7wCJ4NenfdIeTejHiS1R5pVPQ88I
 v3oMy6nty/fgfFeyy5+jjK7Kl1S/34kw2i7EbIb69tVJPRKgPdY0OzGzmVymNUT2HSyZ
 WLEw==
X-Gm-Message-State: AGi0PuYbZKBDoXx4/on3LYDxNUsnNWmXvYwMHPRbMcF1MRDeUN0urPea
 /x2DyqhYxbXFoqHmzTBSDPNq6xDoMZg=
X-Google-Smtp-Source: APiQypILApYooECvATlowNsNhXnQiynTLDuEuIYBCqJFmOTUl1qdubnpHfZ7uPToDaH/lgUJB+vPbg==
X-Received: by 2002:a67:e998:: with SMTP id b24mr416502vso.222.1587585010686; 
 Wed, 22 Apr 2020 12:50:10 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com.
 [209.85.222.52])
 by smtp.gmail.com with ESMTPSA id w2sm97160vso.19.2020.04.22.12.50.09
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 12:50:10 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a6so3154721uao.2
 for <iommu@lists.linux-foundation.org>; Wed, 22 Apr 2020 12:50:09 -0700 (PDT)
X-Received: by 2002:a67:fc46:: with SMTP id p6mr410935vsq.169.1587585008976;
 Wed, 22 Apr 2020 12:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200327132852.10352-1-saiprakash.ranjan@codeaurora.org>
 <0023bc68-45fb-4e80-00c8-01fd0369243f@arm.com>
 <37db9a4d524aa4d7529ae47a8065c9e0@codeaurora.org>
 <5858bdac-b7f9-ac26-0c0d-c9653cef841d@arm.com>
 <d60196b548e1241b8334fadd0e8c2fb5@codeaurora.org>
 <CAD=FV=WXTN6xxqtL6d6MHxG8Epuo6FSQERRPfnoSCskhjh1KeQ@mail.gmail.com>
 <890456524e2df548ba5d44752513a62c@codeaurora.org>
 <20200331074400.GB25612@willie-the-truck>
 <1bf04938249bcd5b2111c1921facfd25@codeaurora.org>
In-Reply-To: <1bf04938249bcd5b2111c1921facfd25@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 22 Apr 2020 12:49:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VBM6cS1UmWTUJ2vrt0a2zn7xV3C53tpthBx58M2=1JPg@mail.gmail.com>
Message-ID: <CAD=FV=VBM6cS1UmWTUJ2vrt0a2zn7xV3C53tpthBx58M2=1JPg@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: Demote error messages to debug in
 shutdown callback
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS , Joerg Roedel <joro@8bytes.org>,
 " <iommu@lists.linux-foundation.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
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

Hi,

On Tue, Mar 31, 2020 at 12:53 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Hi Will,
>
> On 2020-03-31 13:14, Will Deacon wrote:
> > On Tue, Mar 31, 2020 at 01:06:11PM +0530, Sai Prakash Ranjan wrote:
> >> On 2020-03-30 23:54, Doug Anderson wrote:
> >> > On Sat, Mar 28, 2020 at 12:35 AM Sai Prakash Ranjan
> >> > <saiprakash.ranjan@codeaurora.org> wrote:
> >> > >
> >> > > > Of course the fact that in practice we'll *always* see the warning
> >> > > > because there's no way to tear down the default DMA domains, and even
> >> > > > if all devices *have* been nicely quiesced there's no way to tell, is
> >> > > > certainly less than ideal. Like I say, it's not entirely clear-cut
> >> > > > either way...
> >> > > >
> >> > >
> >> > > Thanks for these examples, good to know these scenarios in case we
> >> > > come
> >> > > across these.
> >> > > However, if we see these error/warning messages appear everytime then
> >> > > what will be
> >> > > the credibility of these messages? We will just ignore these messages
> >> > > when
> >> > > these issues you mention actually appears because we see them
> >> > > everytime
> >> > > on
> >> > > reboot or shutdown.
> >> >
> >> > I would agree that if these messages are expected to be seen every
> >> > time, there's no way to fix them, and they're not indicative of any
> >> > problem then something should be done.  Seeing something printed at
> >> > "dev_error" level with an exclamation point (!) at the end makes me
> >> > feel like this is something that needs immediate action on my part.
> >> >
> >> > If we really can't do better but feel that the messages need to be
> >> > there, at least make them dev_info and less scary like:
> >> >
> >> >   arm-smmu 15000000.iommu: turning off; DMA should be quiesced before
> >> > now
> >> >
> >> > ...that would still give you a hint in the logs that if you saw a DMA
> >> > transaction after the message that it was a bug but also wouldn't
> >> > sound scary to someone who wasn't seeing any other problems.
> >> >
> >>
> >> We can do this if Robin is OK?
> >
> > It would be nice if you could figure out which domains are still live
> > when
> > the SMMU is being shut down in your case and verify that it *is* infact
> > benign before we start making the message more friendly. As Robin said
> > earlier, rogue DMA is a real nightmare to debug.
> >
>
> I could see this error message for all the clients of apps_smmu.
> I checked manually enabling bypass and removing iommus dt property
> for each client of apps_smmu.

Any update on the status here?  If I'm reading the conversation above,
Robin said: "we'll *always* see the warning because there's no way to
tear down the default DMA domains, and even if all devices *have* been
nicely quiesced there's no way to tell".  Did I understand that
properly?  If so, it seems like it's fully expected to see this
message on every reboot and it doesn't necessarily signify anything
bad.

-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
