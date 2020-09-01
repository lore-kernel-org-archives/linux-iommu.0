Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE0EC433E6
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 15:10:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E411206FA
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 15:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lCL5SLaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E411206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 25443870C3;
	Tue,  1 Sep 2020 15:10:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U9sP9DeYyZQB; Tue,  1 Sep 2020 15:10:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8732F870CE;
	Tue,  1 Sep 2020 15:10:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FB00C07FF;
	Tue,  1 Sep 2020 15:10:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50477C0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 15:10:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3E525861BC
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 15:10:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DraOzAZ5wYip for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 15:10:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5329986234
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 15:10:47 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id h4so2204688ejj.0
 for <iommu@lists.linux-foundation.org>; Tue, 01 Sep 2020 08:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BIr3FRHLWeYI5mpm2jHeXhPihRGMNnmHYOmMOMeHpR4=;
 b=lCL5SLaMFPqoPftiV2X8nocTTBdKqARvrqI17ufYPS0DtjiIyaSIs4CniiHZ/VEW8n
 WoqCHbvQzPHbcjvAM7+zD7U98QNr5oxI5U75nYwYeOtUdaj7M9sptx5fdS3otDiC5uUz
 5071XY7IwhHNlm+8JmyRZFrwvyyMI1Xxx/Jf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BIr3FRHLWeYI5mpm2jHeXhPihRGMNnmHYOmMOMeHpR4=;
 b=TgCu1Wv3WpQaZawlD2XjXtW0XzBeFMDLGWvSdwbNPPc8DKc223DoGeltDSFdMyq+v0
 YWpZe7WRLTv7tMBRn5yI7xZXM8khtLzF8/zvZce3y6d3n2be4aPXJfEYp8xoe/P2DJmb
 jSF3cYDnDJHctJOgXcdFF7kaBkk0aKqAvzK0jjLQjyck1NMRqugqbQ4QBjoqnZT8qhO6
 zdqmWWbGegdg5gQctOaFTFqePHGeUmcW/fxFMf5cuevs/tpnsVJ2dx6njaaz2ybq74St
 14faqQ+/1c/gOBpSLG+ZehXpenmTn8NwrTmfvMG3wQjxoQSN8ocCyipsEciGjAv1dlJZ
 a41Q==
X-Gm-Message-State: AOAM5327Jr/reSgRf2OmyejAKY3d0OVI+gDDGw8k5jmLhQpAqDOFRJ88
 wbjSW5erkwct743X9EnCdLNOhxHqNLRviQ==
X-Google-Smtp-Source: ABdhPJzjVLeL0NkLbJcqsFOHUWnfr9IYdk+6TGqsAhaPFOqjLQT6CCnK2j9n4eJWmafyGLqKqM7RRA==
X-Received: by 2002:a17:906:4047:: with SMTP id
 y7mr1795637ejj.21.1598973045416; 
 Tue, 01 Sep 2020 08:10:45 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com.
 [209.85.208.45])
 by smtp.gmail.com with ESMTPSA id g90sm1516881edd.64.2020.09.01.08.10.45
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 08:10:45 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id q21so1809219edv.1
 for <iommu@lists.linux-foundation.org>; Tue, 01 Sep 2020 08:10:45 -0700 (PDT)
X-Received: by 2002:a5d:5150:: with SMTP id u16mr2332024wrt.197.1598972568491; 
 Tue, 01 Sep 2020 08:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200819065555.1802761-1-hch@lst.de>
 <20200819065555.1802761-6-hch@lst.de>
 <CAAFQd5COLxjydDYrfx47ht8tj-aNPiaVnC+WyQA7nvpW4gs=ww@mail.gmail.com>
 <20200819135454.GA17098@lst.de>
 <CAAFQd5BuXP7t3d-Rwft85j=KTyXq7y4s24mQxLr=VoY9krEGZw@mail.gmail.com>
 <20200820044347.GA4533@lst.de> <20200820052004.GA5305@lst.de>
 <CAAFQd5CFiA2WBaaPQ9ezvMjYZfNw37c42UEy9Pk7kJyCi1mLzQ@mail.gmail.com>
 <20200820165407.GD12693@lst.de>
 <CAAFQd5D=NzgjosB51-O_cH27a8V6CPgCfaPSfHHz7nKJPbazgg@mail.gmail.com>
 <20200901110617.GA13232@lst.de>
In-Reply-To: <20200901110617.GA13232@lst.de>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 1 Sep 2020 17:02:20 +0200
X-Gmail-Original-Message-ID: <CAAFQd5CmPVSxmZJVn7HnNUn8srZbAbnfzpNMYw3KcDzn7xD2cg@mail.gmail.com>
Message-ID: <CAAFQd5CmPVSxmZJVn7HnNUn8srZbAbnfzpNMYw3KcDzn7xD2cg@mail.gmail.com>
Subject: Re: [PATCH 05/28] media/v4l2: remove V4L2-FLAG-MEMORY-NON-CONSISTENT
To: Christoph Hellwig <hch@lst.de>
Cc: alsa-devel@alsa-project.org, linux-ia64@vger.kernel.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 nouveau@lists.freedesktop.org, linux-nvme@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 linux-mm@kvack.org, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Joonyoung Shim <jy0922.shim@samsung.com>, linux-scsi@vger.kernel.org,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Ben Skeggs <bskeggs@redhat.com>, Matt Porter <mporter@kernel.crashing.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, Pawel Osciak <pawel@osciak.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 linux-mips@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>
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

On Tue, Sep 1, 2020 at 1:06 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Aug 20, 2020 at 07:33:48PM +0200, Tomasz Figa wrote:
> > > It wasn't meant to be too insulting, but I found this out when trying
> > > to figure out how to just disable it.  But it also ends up using
> > > the actual dma attr flags for it's own consistency checks, so just
> > > not setting the flag did not turn out to work that easily.
> > >
> >
> > Yes, sadly the videobuf2 ended up becoming quite counterintuitive
> > after growing for the long years and that is reflected in the design
> > of this feature as well. I think we need to do something about it.
>
> So I'm about to respin the series and wonder how we should proceed.
> I've failed to come up with a clean patch to keep the flag and make
> it a no-op.  Can you or your team give it a spin?
>

Okay, I'll take a look.

> Also I wonder if the flag should be renamed from NON_CONSISTENT
> to NON_COHERENT - the consistent thing is a weird wart from the times
> the old PCI DMA API that is mostly gone now.

It originated from the DMA_ATTR_NON_CONSISTENT flag, but agreed that
NON_COHERENT would be more consistent (pun not intended) with the rest
of the DMA API given the removal of that flag. Let me see if we can
still change it.

Best regards,
Tomasz
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
