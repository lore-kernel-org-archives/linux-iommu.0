Return-Path: <SRS0=v9UM=BK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA57BC433E0
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 14:21:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A137B21744
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 14:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GkbZ8/E2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A137B21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7EF2F86AE6;
	Fri, 31 Jul 2020 14:21:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7iNItsjylz73; Fri, 31 Jul 2020 14:21:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7541885FDE;
	Fri, 31 Jul 2020 14:21:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D6F4C004F;
	Fri, 31 Jul 2020 14:21:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2EDBC004D
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 14:21:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A86AF8608D
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 14:21:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6V_NceifyAnB for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 14:21:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AEB8385FDE
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 14:21:26 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id a14so28189956wra.5
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 07:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NKr7BOXTkAnLT6uiZncw/IsWBEsvXxatEpt2z5EmQp4=;
 b=GkbZ8/E2DS1Cl/y46LT1JZkOQRxSeLMq0zmOvfBNRCeOj1HFsa7XL7Qp2E2if2/4qA
 iB/4B2845GZPn0bXrKASPnhiNpJE+4fS4Ohskzp+E3ZZ3s9ncuSaehdTYx4oEtm9qlHI
 ZRI0KKd8a+zoYHabmGZzUXMp6zOs+V9oJuY0SZGxeCpdd9Xu3zOtya6vFq5i95l/DWp0
 M/6YmMJqLZC5PLTcfqfX7UXoeQVtTjQShbN800JE62fLBp9nQt1XerzLAOp/2pZYxiNO
 hq/Vx1pXhN++puiSQMThEtTvnWkIj3lAXHFGaul5heQVVQprVjAtdeH3tPjs63zKjsNG
 cUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NKr7BOXTkAnLT6uiZncw/IsWBEsvXxatEpt2z5EmQp4=;
 b=AIstAstqrKcsKBcsovl8TM/YuYKltNJOlI53vfwbfrh84I/O7uJmk7YqjATzAtkhG4
 btfRUiPqoySGgaMb+57pwj1hZYJRO2QbZ1u4RPalEc90e1TmVAV432unn/ix/MY1N5I+
 DBSA6mUPQrzuZurveXrXV60IMceIl0uPn5+P7GFVQK6SU95VEouHu4086FtpJgnlTiF6
 SfFyX7GpWx+uWcTSYDpyp248RuMXyPQbOJu8FPXIOz/ACDiotT3lnOJns/aAdzWMLPEv
 99Zh1A0r+H2WAWEiINbWmNolouwuMx10geRFrh3F08g3ZBGudgXINss73/cC9EU+g4KF
 DJOA==
X-Gm-Message-State: AOAM530sMQwrmErSvbnIgT0/92pKNwZHOE4nNKn4MJjhE/aOOPOghFSV
 /2cemGp1zAYyKB12FvbmIFN5DX//b+CffpEmMc2jNg==
X-Google-Smtp-Source: ABdhPJxld8VMioHZI6b8wT28Y4q/j2MffjJrZ4PA0RDAqFkHqy7b6MHMCBdDse8F+yglXhib29g5dLAEQbFJecK+Ta0=
X-Received: by 2002:adf:9ec1:: with SMTP id b1mr3708168wrf.171.1596205285159; 
 Fri, 31 Jul 2020 07:21:25 -0700 (PDT)
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
In-Reply-To: <d57334a4097e4615b01fdbcf7b5de0a0dc580b4e.camel@suse.de>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Fri, 31 Jul 2020 19:50:49 +0530
Message-ID: <CAMi1Hd3Wc9tLRxgtX30AmGoSP6Go+p=17ezJhXFMxt+4Xn540A@mail.gmail.com>
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

On Fri, 31 Jul 2020 at 19:45, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Fri, 2020-07-31 at 16:47 +0530, Amit Pundir wrote:
> > On Fri, 31 Jul 2020 at 16:17, Nicolas Saenz Julienne
>
> [...]
>
> > > Ok, so lets see who's doing what and with what constraints:
> >
> > Here is the relevant dmesg log: https://pastebin.ubuntu.com/p/dh3pPnxS2v/
>
> Sadly nothing out of the ordinary, looks reasonable.
>
> I have an idea, I've been going over the downstream device tree and it seems
> the reserved-memory entries, specially the ones marked with 'no-map' don't
> fully match what we have upstream. On top of that all these reserved areas seem
> to fall into ZONE_DMA.
>
> So, what could be happening is that, while allocating pages for the ZONE_DMA
> atomic pool, something in the page allocator is either writing/mapping into a
> reserved area triggering some kind of fault.
>
> Amir, could you go over the no-map reserved-memory entries in the downstream
> device-tree, both in 'beryllium-*.dtsi' (I think those are the relevant ones)
> and 'sdm845.dtsi'[1], and make sure they match what you are using. If not just
> edit them in and see if it helps. If you need any help with that I'll be happy
> to give you a hand.

Thank you for the pointers. I'll try to match my dts' reserved-memory
entries with the downstream dts. I'll let you know how it goes.

Regards,
Amit Pundir

>
> Regards,
> Nicolas
>
> [1] You could also extract the device tree from a device running with the
>     downstream kernel, whatever is easier for you.
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
