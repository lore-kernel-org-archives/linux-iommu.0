Return-Path: <SRS0=rNTl=GV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94111C433E0
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 11:45:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFD8322D5B
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 11:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD8322D5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7791E8565B;
	Mon, 18 Jan 2021 11:45:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5c-v_tVzpmkV; Mon, 18 Jan 2021 11:45:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BCD018560C;
	Mon, 18 Jan 2021 11:45:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98E5AC08A1;
	Mon, 18 Jan 2021 11:45:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FF42C013A;
 Mon, 18 Jan 2021 11:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0D30087016;
 Mon, 18 Jan 2021 11:45:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B5JYyoaz6bhk; Mon, 18 Jan 2021 11:45:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4BCFF87011;
 Mon, 18 Jan 2021 11:45:02 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id h16so17212023edt.7;
 Mon, 18 Jan 2021 03:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=F68vHZ580IjEbmHg81pdR4Mjf0I0Fx2B1vaIOPSVpXY=;
 b=OIyazj+/o5gz9nsKm88Kja7lALX2H7QNfYXU66HQYUAMKaFrIYHhvaaOQgXYOx5xvj
 NbzzlBSw3IdSzjtZncd7bb0ZpnTs0hkgvmwZcTosEDKAqAEXLGlUMz8qZimwymqoFQ75
 Nc45TC+nY9J5ovFBzAdBeyfQKgxURxGdUb6mTL3UHGB7kDjztaFrAqL13ZYwBqCng0Ns
 FSb5Ki+LleZZkPzpBpvmXso/jPIMH7TwqZpYNVZ+qYWAe2eupYGnh8oisKDJ/ZxcP2jb
 U1SFVAEt2zRQ30Rydy9CQF2+3RBXfykTuJ+o5vnUYhHdpOoOU6ET3wuobGsqpmHxCBgC
 +luQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=F68vHZ580IjEbmHg81pdR4Mjf0I0Fx2B1vaIOPSVpXY=;
 b=JWxOikokKzjm6Q6WLwgRe84coa9BX2RTUG8vZx1c0ZHd6EtgTJKzC2HlXwhW5G6lg2
 NQqof2EE1QcBcDs4Ck8Heuuc1ioKZEHqImYK49M/mME5snsA8Slw9Rxxopd5oHk1woa5
 MlMG3SX6CYYWGdLS13EuXbMd7WlBi+LaCHl9wSNYKbujEyEuMshAp0Ujli19WbUJnWg8
 1ZJDKQIIEpCAC8jvKwUz/jJztiQuLWxIUFa0g1Hrx0uYo5YBkdirqyclb/TaIWq1ElKR
 0QevRL48ddWGjYcztzGz/3V4nDdFdYHBUE5Z2FKeVBYH2wIM5Ks24QqQCLez06/0w2pH
 sVlA==
X-Gm-Message-State: AOAM532Wys7+pSCJUzBHTS6tyOE4lBV+aHxrawMvSdZMcO1bpymLnaJF
 7AYh3CpqpQf8nmF7TDw0h8w=
X-Google-Smtp-Source: ABdhPJwqFgxj7V2Do365QrthtC6//2U204yKEYrYTmPS0An7gKR+Zn0Pp1gYvFmzq3svTIMwmF4PMQ==
X-Received: by 2002:a50:e84d:: with SMTP id k13mr18617210edn.154.1610970300844; 
 Mon, 18 Jan 2021 03:45:00 -0800 (PST)
Received: from martin (host-88-217-199-52.customer.m-online.net.
 [88.217.199.52])
 by smtp.gmail.com with ESMTPSA id bn21sm9318373ejb.47.2021.01.18.03.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Jan 2021 03:45:00 -0800 (PST)
Date: Mon, 18 Jan 2021 12:44:58 +0100
From: Martin Radev <martin.b.radev@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] swiotlb: Validate bounce size in the sync/unmap path
Message-ID: <YAV0uhfkimXn1izW@martin>
References: <X/27MSbfDGCY9WZu@martin>
 <20210113113017.GA28106@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210113113017.GA28106@lst.de>
Cc: thomas.lendacky@amd.com, file@sect.tu-berlin.de,
 robert.buhren@sect.tu-berlin.de, kvm@vger.kernel.org, konrad.wilk@oracle.com,
 mathias.morbitzer@aisec.fraunhofer.de, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, kirill.shutemov@linux.intel.com
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

On Wed, Jan 13, 2021 at 12:30:17PM +0100, Christoph Hellwig wrote:
> On Tue, Jan 12, 2021 at 04:07:29PM +0100, Martin Radev wrote:
> > The size of the buffer being bounced is not checked if it happens
> > to be larger than the size of the mapped buffer. Because the size
> > can be controlled by a device, as it's the case with virtio devices,
> > this can lead to memory corruption.
> > 
> 
> I'm really worried about all these hodge podge hacks for not trusted
> hypervisors in the I/O stack.  Instead of trying to harden protocols
> that are fundamentally not designed for this, how about instead coming
> up with a new paravirtualized I/O interface that is specifically
> designed for use with an untrusted hypervisor from the start?

Your comment makes sense but then that would require the cooperation
of these vendors and the cloud providers to agree on something meaningful.
I am also not sure whether the end result would be better than hardening
this interface to catch corruption. There is already some validation in
unmap path anyway.

Another possibility is to move this hardening to the common virtio code,
but I think the code may become more complicated there since it would
require tracking both the dma_addr and length for each descriptor.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
