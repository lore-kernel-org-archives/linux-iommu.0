Return-Path: <SRS0=PEfB=AW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78DBC433E1
	for <iommu@archiver.kernel.org>; Sat, 11 Jul 2020 18:44:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F1D420786
	for <iommu@archiver.kernel.org>; Sat, 11 Jul 2020 18:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXWbofu3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1D420786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3BF0321541;
	Sat, 11 Jul 2020 18:44:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cp2npsXnLryH; Sat, 11 Jul 2020 18:44:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5040C2272C;
	Sat, 11 Jul 2020 18:44:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31682C088E;
	Sat, 11 Jul 2020 18:44:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0ADC5C016F
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jul 2020 18:44:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E1BB687BE5
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jul 2020 18:44:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id akuItgFuKwtg for <iommu@lists.linux-foundation.org>;
 Sat, 11 Jul 2020 18:44:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 285CC87BC6
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jul 2020 18:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594493084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bS19/wWScaoigC28WtauFL/l6Ha+uxblMLUn/Mypy1E=;
 b=RXWbofu3M4GyKEjp+NncetAIqIGaQEgBkGa7dE7xksSHd3mKzM4aYajkYR0VST3yemP+HZ
 53XQYfwC7riQNuedUH4f3PNSpA4l2XCsmDmeAUJ0P5fAsSrmUhcHsCyAVXBaV9g8kIPtrH
 w5eLlh0j4+7ZM/7MwcLzNYIBY97KutA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-_XvXz4BMM9yhAP-hBXKdJA-1; Sat, 11 Jul 2020 14:44:41 -0400
X-MC-Unique: _XvXz4BMM9yhAP-hBXKdJA-1
Received: by mail-wm1-f72.google.com with SMTP id g124so11748764wmg.6
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jul 2020 11:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bS19/wWScaoigC28WtauFL/l6Ha+uxblMLUn/Mypy1E=;
 b=XT/eGRS1a0MapVA1geLQ/ca4UvRCqZ8Dx6dPELFZ8eZkeKM8s7qfLBweHXo1hZUUhu
 Fd/d3Kn8BK8aq7Rih1iecjVWvpWgGH30wGiMJSDPEphhiSdsjxMondTbNtJMVwbZrT18
 k2B3Ln7atJroL3EXZPasSrGToX7i8SNaf1ny8xRMCHA3oaxqZoCcpPQufv6afrAjAy/3
 tP+Fq/YZkpzMZmgmQFkJl9D0C+FdCXhPHSXEEdsswNWjAK2L8+Z096Lg/hfxbBdK98ym
 K+MeS9MO9YekL/kGx4Q9w1BRr/o4A0xvddWK76fHyGYaKIwGe4Kbos4PUh2ZeeNchT8F
 /50w==
X-Gm-Message-State: AOAM530cXmHgSUOXh/Lu/CbYea7F1EBslEWG65Zd2RkSwir+3OuKDfAp
 ZWw0T7bboJMN0q3Hso9bKtt89ATRHt2CRUgDGT23jQQarLQEpTrFLxNR/NwBDA6O+jwCmE8w/pO
 M5Z/d3gWMEnUFQEownYKLAOOrJ4fzEQ==
X-Received: by 2002:a1c:4d11:: with SMTP id o17mr10838365wmh.134.1594493079890; 
 Sat, 11 Jul 2020 11:44:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygwQmxPTGDCpKObOVAAUSmALBrwy00qKV5C2K74YeE+tRXIP/JRrrSaIMIkdPE6mekfNCtDg==
X-Received: by 2002:a1c:4d11:: with SMTP id o17mr10838336wmh.134.1594493079525; 
 Sat, 11 Jul 2020 11:44:39 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 a84sm4541096wmh.47.2020.07.11.11.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 11:44:38 -0700 (PDT)
Date: Sat, 11 Jul 2020 14:44:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
Message-ID: <20200711144334-mutt-send-email-mst@kernel.org>
References: <20200624163940-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s>
 <20200624181026-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006251014230.8121@sstabellini-ThinkPad-T480s>
 <20200626110629-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006291621300.8121@sstabellini-ThinkPad-T480s>
 <20200701133456.GA23888@infradead.org>
 <alpine.DEB.2.21.2007011020320.8121@sstabellini-ThinkPad-T480s>
 <20200701172219-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2007101019340.4124@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2007101019340.4124@sstabellini-ThinkPad-T480s>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: jgross@suse.com, Peng Fan <peng.fan@nxp.com>, konrad.wilk@oracle.com,
 jasowang@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 linux-imx@nxp.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
 linux-arm-kernel@lists.infradead.org
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

On Fri, Jul 10, 2020 at 10:23:22AM -0700, Stefano Stabellini wrote:
> Sorry for the late reply -- a couple of conferences kept me busy.
> 
> 
> On Wed, 1 Jul 2020, Michael S. Tsirkin wrote:
> > On Wed, Jul 01, 2020 at 10:34:53AM -0700, Stefano Stabellini wrote:
> > > Would you be in favor of a more flexible check along the lines of the
> > > one proposed in the patch that started this thread:
> > > 
> > >     if (xen_vring_use_dma())
> > >             return true;
> > > 
> > > 
> > > xen_vring_use_dma would be implemented so that it returns true when
> > > xen_swiotlb is required and false otherwise.
> > 
> > Just to stress - with a patch like this virtio can *still* use DMA API
> > if PLATFORM_ACCESS is set. So if DMA API is broken on some platforms
> > as you seem to be saying, you guys should fix it before doing something
> > like this..
> 
> Yes, DMA API is broken with some interfaces (specifically: rpmesg and
> trusty), but for them PLATFORM_ACCESS is never set. That is why the
> errors weren't reported before. Xen special case aside, there is no
> problem under normal circumstances.

So why not fix DMA API? Then this patch is not needed.


> 
> If you are OK with this patch (after a little bit of clean-up), Peng,
> are you OK with sending an update or do you want me to?

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
