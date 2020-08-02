Return-Path: <SRS0=vGvh=BM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E361C433DF
	for <iommu@archiver.kernel.org>; Sun,  2 Aug 2020 04:47:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F077B2072A
	for <iommu@archiver.kernel.org>; Sun,  2 Aug 2020 04:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hM/sB8xs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F077B2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B5002878DB;
	Sun,  2 Aug 2020 04:47:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CX69Kz5ieIHK; Sun,  2 Aug 2020 04:47:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 10FBD8787C;
	Sun,  2 Aug 2020 04:47:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E88B9C0050;
	Sun,  2 Aug 2020 04:47:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9E11C004D
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 04:47:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A2E7E878DB
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 04:47:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PkTt0-uR2ywH for <iommu@lists.linux-foundation.org>;
 Sun,  2 Aug 2020 04:47:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4CF208787C
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 04:47:18 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id a15so31236145wrh.10
 for <iommu@lists.linux-foundation.org>; Sat, 01 Aug 2020 21:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fKklirf7InZkQFQZL2VcaArckG2y5hKYIU2U2BJuuvs=;
 b=hM/sB8xs/C/G4SRJeP3mPd1yMVyMcMIUGoKglm7w180BhPZZyky80Fmz9vemUwWrrh
 z6ZK2RpCIY0iYCHXmt/rs+eFCOWL2KBVHww5OVyzR9o1ogeJqgQkb6qccyfoPRdy6Jo+
 5VT/qaMh2EOPNnn1OzSJF+sUc+8mJ8ktCJagJ9kru8gEVp8hRXiKO5jZvgzGnhXNIyiF
 BCZwWdEJsheOa9HyyaBVuHUBG358kJD9H/WEbvcgMnDkvGp9OF1sq5FY3QoPFlFeqOUE
 hMHo57WBQWeNypuiuQ9TIs7u0zs8lP+SbOWKFRmhZylDJG9p5mfKWIpydd9+i/J23W2U
 toqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fKklirf7InZkQFQZL2VcaArckG2y5hKYIU2U2BJuuvs=;
 b=JK8uy7GQS7WUHJ8AMw9nKa1kVoQS5Iauazx78FlIJt1NWCStavqVPoIwZWl6Wz0M5d
 FLeoSrEgGK/win8S7cCjM93YE35EbBFN80tj7/Gl1j1OkuRuRygvFLUYAd4JOFaMwlYW
 jWclrgiq1XafWeb4UAQeAiFSGHLMsHHkgDz7RhSFOicVczuOxYBstr9pqO1UhE0SDaBX
 LAiFQ+CRjJJbD8gC0gp4sawbnEbC77QIo6omuy9md00oaw7RxpZtGkXnnL63ri2wtQP9
 aQ+v5WqUvJswq3vZYm5nfpU4THnk9bkhSYPHrjzgac4uhmiA2k2V3hKtmZNUy/r/cq5U
 PpuA==
X-Gm-Message-State: AOAM530bSaAbGHRyCWZcm1Kn+78EdugsYoCaYo+j+mkWu338vKep6mYH
 gjyvoxCO+vj2pEGVoUMkzpTjPEsftg5X70Y8VijKnA==
X-Google-Smtp-Source: ABdhPJyhqVWI6p9icQ0qcp2HOfvLh4vTEthxnZFvrNRyQ3xCBagaaIBC5QtiWCIojuks/iJ07fgvJodRPvvIuaYwTNA=
X-Received: by 2002:adf:fc06:: with SMTP id i6mr9488126wrr.79.1596343636715;
 Sat, 01 Aug 2020 21:47:16 -0700 (PDT)
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
In-Reply-To: <20200801173952.GA15542@lst.de>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Sun, 2 Aug 2020 10:16:40 +0530
Message-ID: <CAMi1Hd3wU3pH4dfxcxqKfWmLWxPXD--4hkYC+VQywwQn1mokMg@mail.gmail.com>
Subject: Re: revert scope for 5.8, was Re: dma-pool fixes
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, jeremy.linton@arm.com,
 iommu <iommu@lists.linux-foundation.org>, linux-rpi-kernel@lists.infradead.org,
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

On Sat, 1 Aug 2020 at 23:09, Christoph Hellwig <hch@lst.de> wrote:
>
> On Sat, Aug 01, 2020 at 05:27:04PM +0530, Amit Pundir wrote:
> > Hi, I found the problematic memory region. It was a memory
> > chunk reserved/removed in the downstream tree but was
> > seemingly reserved upstream for different drivers. I failed to
> > calculate the length of the total region reserved downstream
> > correctly. And there was still a portion of memory left unmarked,
> > which I should have marked as reserved in my testing earlier
> > today.
> >
> > Sorry for all the noise and thanks Nicolas, Christoph and David
> > for your patience.
>
> So you'll need to patch the upstream DTS to fix this up?  Do you also
> need my two fixes?  What about the Oneplus phones?  Can you send a
> mail with a summary of the status?

Poco's DTS is not upstreamed yet. I have updated it for this fix
and sent out a newer version for review.
https://lkml.org/lkml/2020/8/1/184

I didn't need to try your two add-on fixes. I'll give them a spin
later today.

I'm sure One Plus 6 and 6T will be running into similar problem.
I'll check with Caleb and send out a status mail with the summary.

Regards,
Amit Pundir
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
