Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF82BC433E0
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 14:46:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28BFC64DB2
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 14:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28BFC64DB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CC533860F6;
	Tue,  9 Feb 2021 14:46:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5qPW5wlxz2xo; Tue,  9 Feb 2021 14:46:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5E97E85DEC;
	Tue,  9 Feb 2021 14:46:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 353D3C0174;
	Tue,  9 Feb 2021 14:46:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39ED3C013A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 14:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 35BA386AFD
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 14:46:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NOfSDWRHxTbz for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 14:46:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com
 [209.85.166.173])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E0AEA86A74
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 14:46:27 +0000 (UTC)
Received: by mail-il1-f173.google.com with SMTP id u15so1313968iln.12
 for <iommu@lists.linux-foundation.org>; Tue, 09 Feb 2021 06:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qVmduRDg6ZoezGmMc2NOjO9dKMtO5r7SHhLDuNpUA1w=;
 b=WFrX2nLmj6lzLxXwwRLmHplG+/4tGaqXd5F9tKmrpv0+CO88dg427I0RaNJUHcUdtl
 s+UXjDspolANS3R9Rg9KKCc/sy5aAZFcT22cgFhNe08kUqAs0wzlF+V6nniyL9Nz/4ff
 ABijo72HwNtukB2a0YkAo0BBqtLdSTQT9enFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qVmduRDg6ZoezGmMc2NOjO9dKMtO5r7SHhLDuNpUA1w=;
 b=aLxA7C+8uTix/ropquMzywcNdkV0FMLhz4kX9e/FzXiWUVRpY6rXYaVNc8GSq2kEAa
 9bK1bu/GYueMdW+APmgK9M+xX7cAc7Fil4FqW8bXnuVPM8zifRVzbbXTaFr/gYGLqObq
 p7AK8f+JCEc05N3KRnwJVi0fhxQy54f5685I3WWLdbL8XShImAn0DAhD3zkwt+WtC7mz
 lzeWg6vd4IoJ2F6D8c3P99o5S5DRcK6+ct1Kt+Y0+xZJGh0sd4ighY3KZDph5tkfJG0Q
 ERrUia/oaSKiTSeo9tOcXqUCdL0+N8aPTmV8+3TWi7kKIjJu+/PKuwGEGmwQk2tvUoi1
 1Nrg==
X-Gm-Message-State: AOAM533rYcFV8eKahBcVE36fGN9OChG/czNwUQS5iN065mb6OwW/re+5
 1juO3fWyBmV2WfxqsIAfZQ5IUuu6jn420SKA
X-Google-Smtp-Source: ABdhPJwVmDF0i5wd0S1Vfqn3VNYN2WkHizjtz02udNOcGU91xu0vn3LtcDQxtW0UFaqE8yu+gZgB7Q==
X-Received: by 2002:a05:6e02:f14:: with SMTP id
 x20mr1656654ilj.85.1612881986999; 
 Tue, 09 Feb 2021 06:46:26 -0800 (PST)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com.
 [209.85.166.178])
 by smtp.gmail.com with ESMTPSA id x15sm1377472ilv.31.2021.02.09.06.46.24
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Feb 2021 06:46:25 -0800 (PST)
Received: by mail-il1-f178.google.com with SMTP id o7so11776801ils.2
 for <iommu@lists.linux-foundation.org>; Tue, 09 Feb 2021 06:46:24 -0800 (PST)
X-Received: by 2002:a05:6e02:1d0e:: with SMTP id
 i14mr18857395ila.69.1612881984309; 
 Tue, 09 Feb 2021 06:46:24 -0800 (PST)
MIME-Version: 1.0
References: <20210202095110.1215346-1-hch@lst.de>
 <20210207184855.GA27553@lst.de>
 <CAAFQd5BzAvgiTLGFse+ZWUrFtZ1Ysf+p+e-4rW8gq_iP0xhWEA@mail.gmail.com>
 <20210209082213.GA31902@lst.de>
 <CANiDSCuzKczCnAdC9b0r-6WVBFYXYnvQHKbxSeYq2QW1uVsDLQ@mail.gmail.com>
In-Reply-To: <CANiDSCuzKczCnAdC9b0r-6WVBFYXYnvQHKbxSeYq2QW1uVsDLQ@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 9 Feb 2021 15:46:13 +0100
X-Gmail-Original-Message-ID: <CANiDSCvPodsmcOi1fMwvZsyMxWsRQWNT7VkbZs4=XePYXfiXow@mail.gmail.com>
Message-ID: <CANiDSCvPodsmcOi1fMwvZsyMxWsRQWNT7VkbZs4=XePYXfiXow@mail.gmail.com>
Subject: Re: add a new dma_alloc_noncontiguous API v2
To: Christoph Hellwig <hch@lst.de>
Cc: Sergey Senozhatsky <senozhatsky@google.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
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

Hi Christoph

I have tested it in both arm and x86, since there are not significant
changes with the previous version I did not do a performance test.

Thanks!


On Tue, Feb 9, 2021 at 9:29 AM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Hi Christoph
>
> On Tue, Feb 9, 2021 at 9:22 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Mon, Feb 08, 2021 at 08:33:50PM +0900, Tomasz Figa wrote:
> > > Sorry for the delay. The whole series looks very good to me. Thanks a lot.
> > >
> > > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> >
> > Thanks.
> >
> > Ricardo, do the uvcvideo changes look good to you?  I'd like to queue
> > the series up for this merge window.

Tested-by: Ricardo Ribalda <ribalda@chromium.org>

>
> Let me test them in real hardware today.
>
> Thanks!
>
>
> --
> Ricardo Ribalda



-- 
Ricardo Ribalda
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
