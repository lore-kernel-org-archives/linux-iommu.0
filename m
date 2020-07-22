Return-Path: <SRS0=03l9=BB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A55C433EB
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 14:54:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD2C420781
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 14:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkHfU4pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2C420781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 80961204E7;
	Wed, 22 Jul 2020 14:54:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PaGvbEVwv1xU; Wed, 22 Jul 2020 14:54:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E8A9320425;
	Wed, 22 Jul 2020 14:54:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA607C004E;
	Wed, 22 Jul 2020 14:54:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27BF7C004C
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 14:54:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DDCF8204D0
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 14:54:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CCX9AmF2-KZ9 for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jul 2020 14:54:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
 [209.85.166.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 0645020425
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 14:54:05 +0000 (UTC)
Received: by mail-io1-f65.google.com with SMTP id v8so2860855iox.2
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 07:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OADXM0KWhLmqJmz0AqH4iopPYtJqKSmc3a8uf13KWHw=;
 b=dkHfU4piZQZLLU82ppQk6hVZ1uOkXtvbi59PgVcl8jb6Ejh+q9DW36WOjv28VKkqY9
 pD6KJOdK9g5wr8Bf8nxLY5Mv8LL5satch+ApNwHniPPNkwfeG3WTJ9Cg1s2lACEqzEYK
 4YMv2auliqhoEadsIVDN36WHfUvPaVt1VIN1RK9cHiXEV3xbkckBqLV1AipyasoMJ47M
 m8DAovJAtklZO+LJrBfwL8/ANB/XQk6RTKqhxcHnhQHFPFWH+ktkkb0QIPsxPDrVNNxr
 xeexIWsb18SKDnS1HT1OPjjkOPoLXPLxdpblesyzzU+SUu2SaBsO3D0mZv4M9WZEFtkk
 S7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OADXM0KWhLmqJmz0AqH4iopPYtJqKSmc3a8uf13KWHw=;
 b=HLfXjSTV1s6f88F9wOXTrIg5zv0OxjE0I1P2ihmA7mEx/aVAF1ny3geHtO2sfTLK/H
 0ac/jVdKGNtys4gSK2b37fLNAvVp2enHe7Hlk6GpfR5dt5LRY055FlsbVR84uCFPZ4JI
 kqd1MWYpvgi8ngzKHUgZEQHmtSbHIRKrr+H37gyIIqckFVhA8v+ny3vMr1hliGWNXKCT
 283eXt1+QLQKO9URyz0/HQ9pqrOvhZtVc0LhSW8ZPAf6f2bfb8qAQVH010SgU0Sgouf0
 nY8ZHfdJy+reywTh1QEDoiVc8ShU7RhQZJRhTLwEgJObkh59jOuVS2pvKhScAj6aDfdf
 Nwuw==
X-Gm-Message-State: AOAM53088sMkeRLviNK1m4F6zqH1b/yOMbQ6nDajFychyAC/tEQDK7Cn
 LptcZoR089a0wRex8HDsB1XOJlEHXCHlMzgPrIQ=
X-Google-Smtp-Source: ABdhPJzQJaAbYewU9MA/Ib3Rq2MJiG21mch8BEVHivLJt9xht7ckNEsFHmwyL3Ftc7Y59rl2ChMAE0kzTIm12ZPM8xc=
X-Received: by 2002:a6b:c9c4:: with SMTP id z187mr141353iof.27.1595429644293; 
 Wed, 22 Jul 2020 07:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200720155217.274994-1-robdclark@gmail.com>
 <CA+G9fYtj1RBYcPhXZRm-qm5ygtdLj1jD8vFZSqQvwi_DNJLBwQ@mail.gmail.com>
 <20200722131009.GD27672@8bytes.org>
In-Reply-To: <20200722131009.GD27672@8bytes.org>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 22 Jul 2020 07:54:40 -0700
Message-ID: <CAF6AEGteY6Mwy+jQaj6Vo0e4bMW6P1q19PMmdOqQrxr-RQxkQg@mail.gmail.com>
Subject: Re: [PATCH] iommu/qcom: Use domain rather than dev as tlb cookie
To: Joerg Roedel <joro@8bytes.org>
Cc: Rob Clark <robdclark@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Andy Gross <agross@kernel.org>, Robin Murphy <robin.murphy@arm.com>
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

On Wed, Jul 22, 2020 at 6:10 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Tue, Jul 21, 2020 at 12:45:17AM +0530, Naresh Kamboju wrote:
> > On Mon, 20 Jul 2020 at 21:21, Rob Clark <robdclark@gmail.com> wrote:
> > >
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > The device may be torn down, but the domain should still be valid.  Lets
> > > use that as the tlb flush ops cookie.
> > >
> > > Fixes a problem reported in [1]
> >
> > This proposed fix patch applied on top of linux mainline master
> > and boot test PASS on db410c.
> >
> > The reported problem got fixed.
>
> Is this needed for v5.8/stable? A fixes tag would be great too.

looks like, yes:

Fixes: 09b5dfff9ad6 ("iommu/qcom: Use accessor functions for iommu
private data")

BR,
-R

>
> Regards,
>
>         Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
