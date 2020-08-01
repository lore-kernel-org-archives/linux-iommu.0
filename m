Return-Path: <SRS0=Zw9n=BL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5DBC433E0
	for <iommu@archiver.kernel.org>; Sat,  1 Aug 2020 07:35:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9465206F6
	for <iommu@archiver.kernel.org>; Sat,  1 Aug 2020 07:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zfly7dQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9465206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A6EE688D3E;
	Sat,  1 Aug 2020 07:35:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 965TKk7IpFGn; Sat,  1 Aug 2020 07:35:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E787888C13;
	Sat,  1 Aug 2020 07:35:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC2C2C004F;
	Sat,  1 Aug 2020 07:35:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6EE9C004D
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 07:34:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E3486887BC
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 07:34:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ezrK-XWG-TuQ for <iommu@lists.linux-foundation.org>;
 Sat,  1 Aug 2020 07:34:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2781E887A7
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 07:34:55 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id t14so5894010wmi.3
 for <iommu@lists.linux-foundation.org>; Sat, 01 Aug 2020 00:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7lRj9OYys0ba/RdOYbAQ8eBJ+tW3z6dDGiS9qldwc+s=;
 b=zfly7dQOEuvxnFtkO+MgCGtl5a2vX1AaCnX0+XBo8eOZjPJIgqt/Y/ernfI3DK9d6s
 Uuddmp3PvWNnmJqV1g0o1n9GMP3hoLVgQMnXxiOCOaL9Ik3J/Ta1JBB9vp3QAovBRWDZ
 29fqpK2WmkKfGYRPraYXL1GtuR989k8IQAUje86yWblSbQ3CmXeg2VxSQSROk+Zz77rx
 WrCGjVANKZ/qqzqunnoVOPB64n6chfihYSUgs3dstTz1VWJgasYYEH6zg8T8ymxRUuZP
 qqDd5OhvI9yKfm6Elyr3HpJ/jsomnMr54Ci0mSgO/zCi9oRpojwGbo6UJJNp/f5nDDIQ
 qm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7lRj9OYys0ba/RdOYbAQ8eBJ+tW3z6dDGiS9qldwc+s=;
 b=VqZazPVvqlMoWVw5x/rLmlBNK/9xDfp85qaYm0ghvq77eH4a5S7DbMFMmk/5FLKm+Y
 E829lYmoEmJveY/TYr3v0a7yZHcb4esvzrU8mD3Dwz8KUl4nSRTianraRQQUyWBLLYaw
 Qtxa4dK9em0VDbjPRYGbsAJB3YZbqlsQ67CmfeJwU02dDscu3FYipht1rmOGmP0kHvQx
 NkPREQvW5YrfgCOaTsKGSGvrzMjVniGPYvDWGv4Nwsc3TSOrYu9ziRy2i6HkvLM9sMuW
 PZJ3uzpRLlu1VB6n1+FxOD/zTdiqr32U6SkSd90+O365vY7L1UkeIql6f+lEwWA+SahR
 +T4g==
X-Gm-Message-State: AOAM532a0n2dhZjFU3oeHZH3yu1S/gN9c2bRV8SkDzfvmZoTypi4Ld++
 BFAtRRso7gjzB179AqB2EMBEpSqfzwr1IxqoD1oS5A==
X-Google-Smtp-Source: ABdhPJzaUyUorJDKjguqIql/aXfai+Jwhbr97ZmLjxJgexDGtwhBL8fksnzsHOuBJ0g6irmvRwljNjgttDgWOjc6sxE=
X-Received: by 2002:a7b:cf29:: with SMTP id m9mr6883589wmg.88.1596267293403;
 Sat, 01 Aug 2020 00:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200728104742.422960-1-hch@lst.de>
 <CAMi1Hd3=6ZZykF1yx_CChqx71k6T-wj12TzJiz_uJZbwrEtTXw@mail.gmail.com>
 <20200728120716.GA2507@lst.de>
 <CAMi1Hd1c3cNMYg+S5Pwuv30QCdcWJw+QxkWmNP34s3nb+_yUuA@mail.gmail.com>
 <20200728124114.GA4865@lst.de>
 <CAMi1Hd0wpcLVJ41h6gs4H0WEDVpNEs7N=wx+KQ_yRKeSv0kQ9g@mail.gmail.com>
 <20200728153055.GA16701@lst.de>
 <18a3b93cc5ba3e0e39ae1b14759ce31121d54045.camel@suse.de>
 <CAMi1Hd3QNtZVEFUgDprT==wcVHKv6TsvpT3RurVJTDb1op2LnA@mail.gmail.com>
 <a0c8eb70cedb05e310c2957a1c0f7968c1e39d53.camel@suse.de>
 <CAMi1Hd10=vZez7KhJYR688b9j-Sv6AM8EEDW8b8inYDXQk+6wg@mail.gmail.com>
 <d57334a4097e4615b01fdbcf7b5de0a0dc580b4e.camel@suse.de>
 <CAMi1Hd3Wc9tLRxgtX30AmGoSP6Go+p=17ezJhXFMxt+4Xn540A@mail.gmail.com>
In-Reply-To: <CAMi1Hd3Wc9tLRxgtX30AmGoSP6Go+p=17ezJhXFMxt+4Xn540A@mail.gmail.com>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Sat, 1 Aug 2020 13:04:17 +0530
Message-ID: <CAMi1Hd2q80DRLupke-ihywmX_3AX4HQ4PZNTuD=WxXe3AVM4gQ@mail.gmail.com>
Subject: Re: dma-pool fixes
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: jeremy.linton@arm.com, iommu@lists.linux-foundation.org,
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

On Fri, 31 Jul 2020 at 19:50, Amit Pundir <amit.pundir@linaro.org> wrote:
>
> On Fri, 31 Jul 2020 at 19:45, Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> >
> > On Fri, 2020-07-31 at 16:47 +0530, Amit Pundir wrote:
> > > On Fri, 31 Jul 2020 at 16:17, Nicolas Saenz Julienne
> >
> > [...]
> >
> > > > Ok, so lets see who's doing what and with what constraints:
> > >
> > > Here is the relevant dmesg log: https://pastebin.ubuntu.com/p/dh3pPnxS2v/
> >
> > Sadly nothing out of the ordinary, looks reasonable.
> >
> > I have an idea, I've been going over the downstream device tree and it seems
> > the reserved-memory entries, specially the ones marked with 'no-map' don't
> > fully match what we have upstream. On top of that all these reserved areas seem
> > to fall into ZONE_DMA.
> >
> > So, what could be happening is that, while allocating pages for the ZONE_DMA
> > atomic pool, something in the page allocator is either writing/mapping into a
> > reserved area triggering some kind of fault.
> >
> > Amir, could you go over the no-map reserved-memory entries in the downstream
> > device-tree, both in 'beryllium-*.dtsi' (I think those are the relevant ones)
> > and 'sdm845.dtsi'[1], and make sure they match what you are using. If not just
> > edit them in and see if it helps. If you need any help with that I'll be happy
> > to give you a hand.
>
> Thank you for the pointers. I'll try to match my dts' reserved-memory
> entries with the downstream dts. I'll let you know how it goes.
>

I matched my dts's reserved-memory nodes with downstream but it didn't help.

Most of the no-map reserved memory regions in the downstream kernel
are accompanied with "removed-dma-pool" compatibility, "to indicate a
region of memory which is meant to be carved out and not exposed to
kernel." [1][2]. Is this something which might be tripping my device
off? I tried to cherry-pick removed-dma-pool from msm kernel[3], to
see if that makes any difference but I might have missed a few
dependencies and my device didn't boot.

[1] https://android.googlesource.com/kernel/msm/+/e9171c1c69c31ec2226f0871fb5535b6f2044ef3%5E%21/#F0
[2] https://lore.kernel.org/patchwork/patch/670515/#857952
[3] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8250/commit/a478a8bf78ade799a5626cee45c2b247071b325f

> Regards,
> Amit Pundir
>
> >
> > Regards,
> > Nicolas
> >
> > [1] You could also extract the device tree from a device running with the
> >     downstream kernel, whatever is easier for you.
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
