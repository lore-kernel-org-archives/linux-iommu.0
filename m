Return-Path: <SRS0=Zw9n=BL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5429C433E0
	for <iommu@archiver.kernel.org>; Sat,  1 Aug 2020 18:29:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9613A206D4
	for <iommu@archiver.kernel.org>; Sat,  1 Aug 2020 18:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aVyoxdqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9613A206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 51AEE88737;
	Sat,  1 Aug 2020 18:29:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oGnsMDUzDp2G; Sat,  1 Aug 2020 18:29:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 909E686D96;
	Sat,  1 Aug 2020 18:29:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73DA4C0050;
	Sat,  1 Aug 2020 18:29:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27FDBC004D
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 18:29:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 16791858DA
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 18:29:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YRxdLL-bHVeI for <iommu@lists.linux-foundation.org>;
 Sat,  1 Aug 2020 18:29:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1E6CE858B5
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 18:29:00 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id i80so18469339lfi.13
 for <iommu@lists.linux-foundation.org>; Sat, 01 Aug 2020 11:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sXuxihBXhjr+PLWjjkH1QZyWeKeewPAZC64fnAii8+g=;
 b=aVyoxdqPdpAUBwUswfXfA44ZA7W17IWWgnRTsfUmR4XrysvUTyVrGcvxRnqlyMVubU
 uVav8QARs5uuw1uahrFwkiKQUQfSIj1HisRNT2ShNuYuthB+Ex5DZM2lYEfOHZsfOXI3
 ZYZwPicnL9sDn5ugnygB3TV4XeRy6EuON9tII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sXuxihBXhjr+PLWjjkH1QZyWeKeewPAZC64fnAii8+g=;
 b=MHME1Hg8ozvDHJNi/qHPfXDZPgvEaTzIzaiRtevQdobw6IzlB+KHsnL2dzI6sQtZpq
 pp8iiEQz4zGYYMs+OzfKLU7+xLtyqUxFK1pdGl/7v3bMUx9Zs1iRnz4qslnwAScTSXoC
 6GL5EnOV4D0KjwY26ghHajVmIyoiaO+rNK8SKlzHozPV6obL0MSyI7+y3Zf9QrBWtvxD
 7V7S4hNg/xDPdfI0wBr0D3LW80eW+jKb8ofI+HWOSGOXHttn8Bzp39z2zGr7YdbO6yKS
 XpuMDB9XjhRXF+Zmx0ZvVrO0oDOxR7xfxgcrStA37lCde0IFFVWZGBLrVRZeMgOYNheU
 chwA==
X-Gm-Message-State: AOAM533szaZLvp1qTJPBE4mV9kL2qtLUBSW4lHYeIwEN6KJvEpnJMUF2
 fEC6kU8PazHYRy8rBVoKc1+2wqlSdLPQdw==
X-Google-Smtp-Source: ABdhPJzWSwAEhQfNzWY66wyzQ6NVNsLTmQ3/0hyj4sLWKSAAsdg71N26dxey/d5+9EGG97KZ5ytQrg==
X-Received: by 2002:a05:6512:3e8:: with SMTP id
 n8mr4838548lfq.210.1596306537230; 
 Sat, 01 Aug 2020 11:28:57 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com.
 [209.85.167.51])
 by smtp.gmail.com with ESMTPSA id z25sm2512366lji.33.2020.08.01.11.28.55
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Aug 2020 11:28:55 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id v15so13949654lfg.6
 for <iommu@lists.linux-foundation.org>; Sat, 01 Aug 2020 11:28:55 -0700 (PDT)
X-Received: by 2002:a05:6512:3b7:: with SMTP id
 v23mr4907457lfp.10.1596306534640; 
 Sat, 01 Aug 2020 11:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAMi1Hd1c3cNMYg+S5Pwuv30QCdcWJw+QxkWmNP34s3nb+_yUuA@mail.gmail.com>
 <20200728124114.GA4865@lst.de>
 <CAMi1Hd0wpcLVJ41h6gs4H0WEDVpNEs7N=wx+KQ_yRKeSv0kQ9g@mail.gmail.com>
 <20200728153055.GA16701@lst.de>
 <18a3b93cc5ba3e0e39ae1b14759ce31121d54045.camel@suse.de>
 <CAMi1Hd3QNtZVEFUgDprT==wcVHKv6TsvpT3RurVJTDb1op2LnA@mail.gmail.com>
 <CAMi1Hd09EbzOgTU5P4EDS8BQ6J2jFntvyR49BePyAqJ15DBB0Q@mail.gmail.com>
 <20200731130903.GA31110@lst.de>
 <alpine.DEB.2.23.453.2007311204010.3836388@chino.kir.corp.google.com>
 <alpine.DEB.2.23.453.2008010105560.4078406@chino.kir.corp.google.com>
 <20200801085706.GA2991@lst.de>
 <CAMi1Hd2tCfbDUuBP=OKoG8fPVCTpiARmqrkPadEJjJ52fgc_-Q@mail.gmail.com>
In-Reply-To: <CAMi1Hd2tCfbDUuBP=OKoG8fPVCTpiARmqrkPadEJjJ52fgc_-Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 1 Aug 2020 11:28:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjY8LBgu5SyXnwf0W8AkwQGO38j=KHXoyAZ0XUw+TFQ7g@mail.gmail.com>
Message-ID: <CAHk-=wjY8LBgu5SyXnwf0W8AkwQGO38j=KHXoyAZ0XUw+TFQ7g@mail.gmail.com>
Subject: Re: revert scope for 5.8, was Re: dma-pool fixes
To: Amit Pundir <amit.pundir@linaro.org>
Cc: jeremy.linton@arm.com, iommu <iommu@lists.linux-foundation.org>,
 linux-rpi-kernel@lists.infradead.org, David Rientjes <rientjes@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Sat, Aug 1, 2020 at 4:57 AM Amit Pundir <amit.pundir@linaro.org> wrote:
>
> Hi, I found the problematic memory region. It was a memory
> chunk reserved/removed in the downstream tree but was
> seemingly reserved upstream for different drivers.

Is this happening with a clean tree, or are there external drivers
involved that trigger the problem?

Because if it's a clean tree, I guess I need to do an rc8 anyway, just
to get whatever workaround you then added to devicetree and/or some
driver to make it work again.

Or is there a quick fix that I can get today or early tomorrow? We had
some confusion this week due to a nasty include header mess, but
despite that there hasn't been anything else that has come up (so
far), so..

                       Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
