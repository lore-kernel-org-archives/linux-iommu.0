Return-Path: <SRS0=WwkY=ED=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7E3C4363A
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 19:33:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E74A52475F
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 19:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbHcifXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74A52475F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3CDA38643D;
	Wed, 28 Oct 2020 19:33:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WsNYB_c3ryJN; Wed, 28 Oct 2020 19:33:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0EA71863CD;
	Wed, 28 Oct 2020 19:33:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CEC45C0859;
	Wed, 28 Oct 2020 19:33:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0EA1C0051
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 19:33:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 94E2686407
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 19:33:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2jjMILTUpC4d for <iommu@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 19:33:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D6054863CD
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 19:33:30 +0000 (UTC)
Received: by mail-oi1-f194.google.com with SMTP id s21so791224oij.0
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 12:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5zvcSUuNfHMXrNxsvhXWKua5WXhfqy+u4npY1sVlxa0=;
 b=nbHcifXZKYta1gH3g+oMBu+K1N7aQMsgY2S0qrfXwrIS//cX5av5B67ifJ3tMc52d3
 LvCdNd7QDNR6OqVdLN2Sp1VKhvpMHtpqGaRfB4pZ38II9kQ1eE5/xk8xqtiGXwI1hVzM
 1SebMNmNpmB3RbMoXDjZMjofUmAfsngzFWlzcs8d412YNLuG0YNN38wGp/bR1JtQwkln
 HDcvrNll6uwisNlaQoRnGLNmQ+OXmJcZ27nO+3RaYGO21HvBVmG3OXuiwobzOtR5zVCR
 ywaDkX5V40PPJptS5tmvpP9vAyELBTmJnHoL6unWFllBUAeBBscNEbP1CKAwwj+pr5Gh
 Xk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5zvcSUuNfHMXrNxsvhXWKua5WXhfqy+u4npY1sVlxa0=;
 b=I3GDsE3sCikXwXIq7C1WYbDGR87VZuQ7km2/4dI2xUuV0zAp0fY8Eo7BMPgv5c53qH
 GnbDzhpsdQdb4PvwWQEoGp3nAt00p/zc9eVLOYrqsEqws2UByCHJHYWVNcvWBnYrBhRG
 Jbp3g0ixmfzTtN3URvG0N6YDZEwd7gPvY4pIKSwxWpEi8X1IAvZvC2nXa+iL00i/mvav
 pyd23chEc1EfwxUA3UnIGD/39RUO9K22VxikhrIZEVFa7a+SEsXRj1+Pwp6bEvSI1gbe
 gA3L71LwNgYpas955woaQp1maxtpHUXNtn4VrG8z7LBoSK4my80SuSAQ9fA9GwLIKEGT
 7zqQ==
X-Gm-Message-State: AOAM531QtvnpHNarhw6bHbIHtk1UOgumLRwmgHLx0NBx455CpfZ/kHU6
 48Hq5ioJjjrOKL9bAEOvmzFOJhMYgFBjPgCXoQg=
X-Google-Smtp-Source: ABdhPJxGlBhmHxqQDKb6le5siMUuiKMn6BRekoZYJZOXfxXc79e3Tza0QTuWzZODQ5cA7pXPBU4/fpBUlciZa2xSVsk=
X-Received: by 2002:aca:5487:: with SMTP id i129mr430532oib.154.1603913610118; 
 Wed, 28 Oct 2020 12:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190802180758.9691-1-gavinli@thegavinli.com>
 <20190803062333.GC29348@lst.de>
 <CAFCwf122xMQJgqN9qJ1SXAHkVqg4GoNDC+NvXuj=-owXB=AO0A@mail.gmail.com>
 <20201028173152.GA10224@lst.de>
 <CAFCwf10HzngDA17sLxYRY_z1QcPp6NE+HYKnAzm_fEuN6FzmGA@mail.gmail.com>
 <20201028173939.GB10317@lst.de>
In-Reply-To: <20201028173939.GB10317@lst.de>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Wed, 28 Oct 2020 21:33:01 +0200
Message-ID: <CAFCwf13jRE_kXS_+Xd_pi103wvtP6oew8qDR3PyAZy=4jxZYYQ@mail.gmail.com>
Subject: Re: [PATCH v1] dma-mapping: normal memory for mmap() on coherent
 architectures
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Gavin Li <git@thegavinli.com>,
 gavinli@thegavinli.com,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>
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

On Wed, Oct 28, 2020 at 7:39 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Oct 28, 2020 at 07:38:04PM +0200, Oded Gabbay wrote:
> > > > https://lkml.org/lkml/2020/8/29/252)
> > > > Since then, we are plagued by the kernel log message that gavin has
> > > > mentioned, as we are mostly running in our C/I environment with 5.4.
> > > > I wondered if you know if there was any fix to that in the more recent kernels ?
> > > > If not, can I help to fix that ?
> > >
> > > What are the kernel log messages that gaving has mentioned?
> >
> > This one:
> > 11:22:43  [Wed Oct 28 11:22:34 2020] x86/PAT: synapse_tests:29265 map
> > pfn RAM range req uncached-minus for [mem 0xe6236b000-0xe6236bfff],
> > got write-back
> >
> > Thousands of the same message with different addresses of course.
>
> What kernel version is this on?  And what is the test case?

ok, so my previous message wasn't accurate. On 5.4 kernel it actually
does NOT happen.
It happens on 4.18 and 4.15 (kernels that are delivered in Ubuntu 18.04).
So I assume it was fixed somewhere between 4.19 to 5.4.
I'll try to dig the code to see where the change is exactly.

Thanks and sorry for the trouble,
Oded
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
