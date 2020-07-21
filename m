Return-Path: <SRS0=qNYd=BA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D49EC433E3
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 12:17:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 391FA21702
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 12:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XN5HhjfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391FA21702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 67F0E844B3;
	Tue, 21 Jul 2020 12:17:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NSlmtaGfFYti; Tue, 21 Jul 2020 12:17:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C19AD86B26;
	Tue, 21 Jul 2020 12:17:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A073BC08A6;
	Tue, 21 Jul 2020 12:17:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25FC5C016F
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 12:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 227FE86B31
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 12:17:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A724ez06ofnM for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jul 2020 12:17:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BD88386B26
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 12:17:11 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id z15so20954953wrl.8
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 05:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KT7CX+sV+20uXbQeUHLKwJRh4dFo+b84KZ0oSyhNRfY=;
 b=XN5HhjfATGppAb/bzZwx8DxcgGcmmNsfzUyvlDJbm81UC3NYyMUkLKRGe1kgn+OioN
 wm62TH5oghm13XAMiQZPfo4536IJO2M8FJ48AkSV2otgbMJdjnx0Xbu/FCtqXlq3VIRS
 wz8b04vcCyn7Haf9oOhgl7eESlHwNtiPMKgcTNbJ0GSQP0ntKnyuLUUqii9U6Z8TTReC
 Zt0rgtUu+Fltegl0jRDJKNwDRqqjt1asnuZqJJvXm3llD+6dLI4f25XxShnNoWGYRusB
 Ir+vN0coE9A7NpH/r4VfaGPtx4W0ShW6FBYDR/TLQSsp7kGJaW7izkFCyym4eEGA8Ak1
 k+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KT7CX+sV+20uXbQeUHLKwJRh4dFo+b84KZ0oSyhNRfY=;
 b=RZXyIrRWLgVHMHzH8PAUs6ejs6R08oIVlDvqEFHR6snKHjYgjU9inPxasBFLH1oo70
 rm466iqTym5wgluP3jP2IPmuNgr5xnoLD3t9f9tJri7TDIsEZMPRL5tUKcGHOtP43zGK
 0Wkl3Zw10+g3DkQk8wctIRMyskxm5fKidfLDlXx876kUYKB2lRaTWvDDMNJj/PGOGB4v
 daa0Fw8yjODpmUa4voEzDdaLW3ypR4eOUuc5fGPRfr4jX67mAUSnX6c1bwm4DCZ5+4oL
 IE7S90h4x9ycDh9fwjx0F6rX8vCFTSXSzcKYGHwgkVN5h5Lrh3ctGqfAsaJfxZiFAonV
 /61A==
X-Gm-Message-State: AOAM532KkaO09kJHqZK64bEbF8bV5vLQgLS8Qh5XVniNKgZV9CS/UHTy
 5T2wpW7qgbgM1kTl46oi2B4ASpBkM/5CIvG1JavbTA==
X-Google-Smtp-Source: ABdhPJx4z7MCM5tpI6zvfRV8FQfJ9qttJ8tedgub4aMmQrbH0qjxyJ964ZeuquruCLa0CB/KJmQaM62p2OFpzYEaoxI=
X-Received: by 2002:adf:f44b:: with SMTP id f11mr14490610wrp.114.1595333830109; 
 Tue, 21 Jul 2020 05:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200708164936.9340-1-nsaenzjulienne@suse.de>
 <CAMi1Hd35tRM=cnmzwX=SDgu-OoXi1Xj+twFkoULaVZBbTpe6sw@mail.gmail.com>
 <550b30a86c0785049d24c945e2c6628d491cee3a.camel@suse.de>
 <CAMi1Hd2V2pJjP=USS4r-Z3vK-aq7_aBy-jcVNk1GvbdEQAuzWg@mail.gmail.com>
 <011994f8a717a00dcd9ed7682a1ddeb421c2c43f.camel@suse.de>
 <20200721112842.GB27356@lst.de>
 <d073fc344a4ec458aa3456b6838e2000f042f8e2.camel@suse.de>
In-Reply-To: <d073fc344a4ec458aa3456b6838e2000f042f8e2.camel@suse.de>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Tue, 21 Jul 2020 17:46:33 +0530
Message-ID: <CAMi1Hd3=ZNBWKoUgFVxxDus==N=70EKdT7j2at6FfPDBCo7PAQ@mail.gmail.com>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, jeremy.linton@arm.com,
 Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux-foundation.org,
 John Stultz <john.stultz@linaro.org>, linux-rpi-kernel@lists.infradead.org,
 David Rientjes <rientjes@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

On Tue, 21 Jul 2020 at 17:07, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Tue, 2020-07-21 at 13:28 +0200, Christoph Hellwig wrote:
> > On Tue, Jul 21, 2020 at 01:15:23PM +0200, Nicolas Saenz Julienne
> > wrote:
> > > I'm at loss at what could be failing here. Your device should be
> > > able
> > > to address the whole 8GB memory space, which AFAIK is the max
> > > available
> > > on that smartphone family. But maybe the device-tree is lying, who
> > > knows...
> >
> > Maybe we should give your patch to allocate from CMA but check the
> > address a try?  (just because we can..)
>
> Yes, good idea!
>
> Amir, could you also test this patch[1] (having reverted the one that
> casues trouble) and report on whether it boots or not?

Can't boot with that patch either.

Regards,
Amit Pundir


>
> Regards,
> Nicolas
>
> [1] https://lore.kernel.org/linux-iomhttps://lore.kernel.org/linux-iom
> mu/fe14037b02fd887a73cd91c115dccc4485f8446e.camel@suse.de/T/#t
>
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
