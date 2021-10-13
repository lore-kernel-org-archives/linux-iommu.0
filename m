Return-Path: <SRS0=x0pP=PB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FB4C433F5
	for <iommu@archiver.kernel.org>; Wed, 13 Oct 2021 19:32:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A6C0611CC
	for <iommu@archiver.kernel.org>; Wed, 13 Oct 2021 19:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A6C0611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4845183281;
	Wed, 13 Oct 2021 19:32:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yAoqK4JFBhJW; Wed, 13 Oct 2021 19:32:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 214DA8305A;
	Wed, 13 Oct 2021 19:32:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03453C0011;
	Wed, 13 Oct 2021 19:32:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 484A8C000D
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 19:31:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 196E083281
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 19:31:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vjA6Dgni6PZC for <iommu@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 19:31:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A73D38305A
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 19:31:58 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E9BC611ED
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 19:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634153518;
 bh=I/2CgLAJMkMSOwsk84BPKoW2tEY0CQSRXkhHcU4catA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Jc0h2Eox3PHwnp3y6+KwW6rc676RHlq60iUsVFXvyJHUONF/8+wCv7kMGDfeBO6y2
 GPWS6SQjmff55/E2i5cD+Mr+zO2Lc2RJtbmuK2gvzy9DVngY7rraVzc2fWIZu48k5n
 Hb/TJU+tzAqr9CdFN5toxT+Ro+jTM7SSURe7MClO3xVhI8Fo+65ezKIVGHEuq6DMSA
 XX/bdFqngmGFumE/JlnHOo4fkkrU49VLgYcUWhe29veD59gis/TgtncvUIuc4uEzAY
 ZQRhPkwEVgfZXLz2moilx6A7+n6PQRDbm5MOSzqJGV7f01iMZXu6204a9IFiOs5sfU
 RP5Pr6L7xjDpw==
Received: by mail-wr1-f54.google.com with SMTP id m22so12044461wrb.0
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 12:31:58 -0700 (PDT)
X-Gm-Message-State: AOAM530J1wFUAmaMOMSGvm1xfTNm2WUxvSYcGrMJplqeKyVkCzVsr6ss
 3A8PeAIBF0S8xx4+OSXwNRJSbh+F/q0riNxRv4E=
X-Google-Smtp-Source: ABdhPJwcHRsa/5PmSl69f+dfHjeFIK64+QOndFfYOm6WuQn3kJkoiwT4wmudegInJ/4TOeZwKrZ/YtLZ+k7ty3IYRl4=
X-Received: by 2002:a05:600c:1548:: with SMTP id
 f8mr1223250wmg.35.1634153516635; 
 Wed, 13 Oct 2021 12:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211012151841.2639732-1-arnd@kernel.org>
 <20211013075803.GB6701@willie-the-truck>
 <CAK8P3a1GaQ1kjkjOP09eTUu6MR+RjhSDU9s-49MPQ1FSOMUDEg@mail.gmail.com>
 <20211013162024.GA7134@willie-the-truck>
In-Reply-To: <20211013162024.GA7134@willie-the-truck>
From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 13 Oct 2021 21:31:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0aLKv76AjuLO4kMa3hDj8LwsGxGhGToX935pdfsr15KQ@mail.gmail.com>
Message-ID: <CAK8P3a0aLKv76AjuLO4kMa3hDj8LwsGxGhGToX935pdfsr15KQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm: fix ARM_SMMU_QCOM compilation
To: Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Alex Elder <elder@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 John Stultz <john.stultz@linaro.org>, Kalle Valo <kvalo@codeaurora.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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

On Wed, Oct 13, 2021 at 6:20 PM Will Deacon <will@kernel.org> wrote:
> On Wed, Oct 13, 2021 at 10:33:55AM +0200, Arnd Bergmann wrote:
> > On Wed, Oct 13, 2021 at 9:58 AM Will Deacon <will@kernel.org> wrote:
> > > On Tue, Oct 12, 2021 at 05:18:00PM +0200, Arnd Bergmann wrote:

> > I was hoping you and Joerg could just pick your preferred patch
> > into the iommu fixes tree for v5.15.
> >
> > I currently have nothing else pending for my asm-generic tree that
> > introduced the regression, but I can take it through there if that helps
> > you.
>
> I also don't have any fixes pending, and I don't see any in Joerg's tree so
> it's probably quickest if you send it on yourself. Is that ok?

Sure, no problem. I ended up adding it to the arm/fixes branch of the
soc tree, as I just merged some other fixes there, and it seems as good
as any of the other trees.

      Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
