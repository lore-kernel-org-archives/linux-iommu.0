Return-Path: <SRS0=vGvh=BM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D37C433E0
	for <iommu@archiver.kernel.org>; Sun,  2 Aug 2020 15:04:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 679F92072A
	for <iommu@archiver.kernel.org>; Sun,  2 Aug 2020 15:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n+aIAs6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679F92072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3EE8385A00;
	Sun,  2 Aug 2020 15:04:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RfD9PwLCefpI; Sun,  2 Aug 2020 15:04:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 38A51855CB;
	Sun,  2 Aug 2020 15:04:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B4C0C0050;
	Sun,  2 Aug 2020 15:04:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47B87C004C
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 15:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 31012875C7
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 15:04:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L9zGQjdwzBeS for <iommu@lists.linux-foundation.org>;
 Sun,  2 Aug 2020 15:04:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2048D87466
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 15:04:48 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id x5so12219698wmi.2
 for <iommu@lists.linux-foundation.org>; Sun, 02 Aug 2020 08:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eW7G50BEHZFxUEoF4R4WWrRMfn3bV+ZtvDiP+IO1PBc=;
 b=n+aIAs6a9Chu+KDVgSRWCIIahC/gDYEVAI3sMDEjK4t52boIIv2PJGr66jygzwTXxB
 Z02ocwWgSrkKdoLohAAGIFlSRS9L5aLqUMvfkJxscoOHhiQR1a8MnKGwfyD6fQ2kNZcl
 YZezhd+ZK2Cf7Nwz7N1eNwlGL5A9b8y7Ens1vZnk73Yoy/w6Nax0YWdjNzd1MI/NdeWL
 hIqONEpuAknT5gwlzj/Ee+q7SmQjt5fKEgbgAVkggxYck6uZPcK/ZdUOFVS4FR0tn1c+
 x5ZYpxKaMm9vT367sT4eVJAE1ROd5zqBZ0S9D37BaCDfneBOGXhrFfaCBRYGspBMuxwE
 eiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eW7G50BEHZFxUEoF4R4WWrRMfn3bV+ZtvDiP+IO1PBc=;
 b=lLHmOGn+5TKm5SuUe+3baetxbQho7NDgrbuulqBa8PLYLSUluxjsWOArgksRR8gzlA
 ICaVNxFHwzfXhUhJKMb016fzFklZriXMog/ARtF5lhR1JeuPE4pJb9yi8YZNlyVwxoiX
 xrC67Zbk34GIzD7qeqF9WqzLu73dn2ieL5VVtMrqH2qpO+60tZx4YTlEL5AGakW/D3IP
 gJJ8rTJR4cs4B8e0C4/ul+wj6Um4cLQMdWv5PK74LYlQSV6gmx3+5UJQT+jtud+8CCr9
 yGXWepL4m3d9rNaQ47Fd9psl3RNDgYDniwr3HO76e0zLAH32JjYSAWp9OrlEmBNgFAR8
 44sw==
X-Gm-Message-State: AOAM531PoKkBBZo36NaJECTFRwiMbwAGPcKSTdR7bBgF+e6nRgOhcgsR
 hSQIu8DVSgOYNM7WmpQ+8L8jfoUFB2Lh3xS7AOMauQ==
X-Google-Smtp-Source: ABdhPJy7J1bS68K42bIqrV9oSxB4crqnaXKbRRRxbzPWYv9FaKdMqrSpQ66PLAqCQrk0O2r8rKbexTzbOHqZ6yNIVHo=
X-Received: by 2002:a05:600c:2209:: with SMTP id
 z9mr11768642wml.70.1596380686479; 
 Sun, 02 Aug 2020 08:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAMi1Hd0wpcLVJ41h6gs4H0WEDVpNEs7N=wx+KQ_yRKeSv0kQ9g@mail.gmail.com>
 <20200728153055.GA16701@lst.de>
 <18a3b93cc5ba3e0e39ae1b14759ce31121d54045.camel@suse.de>
 <CAMi1Hd3QNtZVEFUgDprT==wcVHKv6TsvpT3RurVJTDb1op2LnA@mail.gmail.com>
 <CAMi1Hd09EbzOgTU5P4EDS8BQ6J2jFntvyR49BePyAqJ15DBB0Q@mail.gmail.com>
 <20200731130903.GA31110@lst.de>
 <alpine.DEB.2.23.453.2007311204010.3836388@chino.kir.corp.google.com>
 <alpine.DEB.2.23.453.2008010105560.4078406@chino.kir.corp.google.com>
 <20200801085706.GA2991@lst.de>
 <CAMi1Hd2tCfbDUuBP=OKoG8fPVCTpiARmqrkPadEJjJ52fgc_-Q@mail.gmail.com>
 <20200801173952.GA15542@lst.de>
 <CAMi1Hd3wU3pH4dfxcxqKfWmLWxPXD--4hkYC+VQywwQn1mokMg@mail.gmail.com>
In-Reply-To: <CAMi1Hd3wU3pH4dfxcxqKfWmLWxPXD--4hkYC+VQywwQn1mokMg@mail.gmail.com>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Sun, 2 Aug 2020 20:34:10 +0530
Message-ID: <CAMi1Hd2MLYx_NkXug+Ow7qFn+tzkMFQy_u0iF_-J6amnXZhckA@mail.gmail.com>
Subject: Re: revert scope for 5.8, was Re: dma-pool fixes
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 iommu <iommu@lists.linux-foundation.org>, jeremy.linton@arm.com,
 Caleb Connolly <caleb@connolly.tech>, linux-rpi-kernel@lists.infradead.org,
 David Rientjes <rientjes@google.com>, Robin Murphy <robin.murphy@arm.com>
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

On Sun, 2 Aug 2020 at 10:16, Amit Pundir <amit.pundir@linaro.org> wrote:
>
> On Sat, 1 Aug 2020 at 23:09, Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Sat, Aug 01, 2020 at 05:27:04PM +0530, Amit Pundir wrote:
> > > Hi, I found the problematic memory region. It was a memory
> > > chunk reserved/removed in the downstream tree but was
> > > seemingly reserved upstream for different drivers. I failed to
> > > calculate the length of the total region reserved downstream
> > > correctly. And there was still a portion of memory left unmarked,
> > > which I should have marked as reserved in my testing earlier
> > > today.
> > >
> > > Sorry for all the noise and thanks Nicolas, Christoph and David
> > > for your patience.
> >
> > So you'll need to patch the upstream DTS to fix this up?  Do you also
> > need my two fixes?  What about the Oneplus phones?  Can you send a
> > mail with a summary of the status?
>
> Poco's DTS is not upstreamed yet. I have updated it for this fix
> and sent out a newer version for review.
> https://lkml.org/lkml/2020/8/1/184
>
> I didn't need to try your two add-on fixes. I'll give them a spin
> later today.

Hi Christoph,

I see no obvious regressions with your twin dma-pool fixes on my
PocoF1 phone.

Caleb also confirmed that a similar reserved-memory region fix in his
One Plus 6 device-tree worked for him too.

>
> I'm sure One Plus 6 and 6T will be running into similar problem.
> I'll check with Caleb and send out a status mail with the summary.
>
> Regards,
> Amit Pundir
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
