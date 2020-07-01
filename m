Return-Path: <SRS0=cxdO=AM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21848C433DF
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 20:47:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4F720853
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 20:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcVf4PX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4F720853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9139D303CD;
	Wed,  1 Jul 2020 20:47:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CJDGIIFCx8Og; Wed,  1 Jul 2020 20:47:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3E1A3266BD;
	Wed,  1 Jul 2020 20:47:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A3BBC0865;
	Wed,  1 Jul 2020 20:47:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68F6AC0733
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 20:47:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2DFC0265F1
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 20:47:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kPoPx8EHWXDD for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jul 2020 20:47:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by silver.osuosl.org (Postfix) with ESMTPS id F2330265B2
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 20:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593636460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MbiyraTJ4trv3FWb4qCBJhr5R70RrnDBw9rQbrUZ784=;
 b=EcVf4PX8QJc0r25MhOFc1NxheBhBUF1n0HSsBUvQv5AZvGQn7BVcYnSZtAgYS5zabfLcvo
 TSYXJ2zuZB8j8vLi/1/tS9SFRm4DqJvyWJMEQFi6mKTQVgM6W1TWKrG4toyamZ/qIcEgNv
 NE0r4vhyahqydk8cPhj3MIy0oIze7dQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-UUDMozEVO4KAsAfewibyqw-1; Wed, 01 Jul 2020 16:47:36 -0400
X-MC-Unique: UUDMozEVO4KAsAfewibyqw-1
Received: by mail-wm1-f72.google.com with SMTP id t145so25259037wmt.2
 for <iommu@lists.linux-foundation.org>; Wed, 01 Jul 2020 13:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MbiyraTJ4trv3FWb4qCBJhr5R70RrnDBw9rQbrUZ784=;
 b=szxReFg+20TYT9ZPUBZhnpz+ax4FXFLHNOSP0QGAnSsVunie1SQOi29F4N+pA8ASVL
 xVMgamBc4i8B7XULSNSiG2p+KskV+Xq/Pwm34xZYCQeYzNr/khot14oBqbItuGO3JQsP
 fQpIBqEtLrBiv6l46jiFHwhpq3PUqgL4uZrxe60rCT2B8LaiOcBigrDCEm9o3B1RAKQA
 qxgeQOkkZ+I10dTZFeKJ67hguddmcAoLNVrHM810CKLQJVwN5apLcB2xVnlV0EE+x36r
 RW5KPX8EtnT3rQYrCCfMSmZ9ZM/P1Hms58cG0Hv4/Qrnvi2mdNQ1FhHZQlHxmK4uBwZ+
 BRtA==
X-Gm-Message-State: AOAM532ZEfbPUIqn0mVdMJpuz9c1h0Os1pIcsLQlHt1kTb9c/CGHSRrd
 /sE21ZTRSazTNM8u4DuIiyghKVjEssaLh+xwGu1YIrXm6MNrLgKuCly3CrXfI97xz5s+Ae8g0vZ
 gzLf01uWDyWRm938m4nQE/MibYID+Fw==
X-Received: by 2002:adf:ed47:: with SMTP id u7mr30433380wro.201.1593636455541; 
 Wed, 01 Jul 2020 13:47:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzi4/QeFIvFvIhW8MFrahcm+NHf1Nr8du8L4WlMn+iG6s23576AuHveqgE2W9yZnAvkgrNyJg==
X-Received: by 2002:adf:ed47:: with SMTP id u7mr30433344wro.201.1593636455219; 
 Wed, 01 Jul 2020 13:47:35 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 h2sm8337653wrw.62.2020.07.01.13.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 13:47:32 -0700 (PDT)
Date: Wed, 1 Jul 2020 16:47:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
Message-ID: <20200701164501-mutt-send-email-mst@kernel.org>
References: <20200624050355-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s>
 <20200624163940-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s>
 <20200624181026-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006251014230.8121@sstabellini-ThinkPad-T480s>
 <20200626110629-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006291621300.8121@sstabellini-ThinkPad-T480s>
 <20200701133456.GA23888@infradead.org>
 <alpine.DEB.2.21.2007011020320.8121@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2007011020320.8121@sstabellini-ThinkPad-T480s>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
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

On Wed, Jul 01, 2020 at 10:34:53AM -0700, Stefano Stabellini wrote:
> On Wed, 1 Jul 2020, Christoph Hellwig wrote:
> > On Mon, Jun 29, 2020 at 04:46:09PM -0700, Stefano Stabellini wrote:
> > > > I could imagine some future Xen hosts setting a flag somewhere in the
> > > > platform capability saying "no xen specific flag, rely on
> > > > "VIRTIO_F_ACCESS_PLATFORM". Then you set that accordingly in QEMU.
> > > > How about that?
> > > 
> > > Yes, that would be fine and there is no problem implementing something
> > > like that when we get virtio support in Xen. Today there are still no
> > > virtio interfaces provided by Xen to ARM guests (no virtio-block/net,
> > > etc.)
> > > 
> > > In fact, in both cases we are discussing virtio is *not* provided by
> > > Xen; it is a firmware interface to something entirely different:
> > > 
> > > 1) virtio is used to talk to a remote AMP processor (RPMesg)
> > > 2) virtio is used to talk to a secure-world firmware/OS (Trusty)
> > >
> > > VIRTIO_F_ACCESS_PLATFORM is not set by Xen in these cases but by RPMesg
> > > and by Trusty respectively. I don't know if Trusty should or should not
> > > set VIRTIO_F_ACCESS_PLATFORM, but I think Linux should still work
> > > without issues.
> > > 
> > 
> > Any virtio implementation that is not in control of the memory map
> > (aka not the hypervisor) absolutely must set VIRTIO_F_ACCESS_PLATFORM,
> > else it is completely broken.
> 
> Lots of broken virtio implementations out there it would seem :-(

Not really, most of virtio implementations are in full control of
memory, being part of the hypervisor.

> 
> > > The xen_domain() check in Linux makes it so that vring_use_dma_api
> > > returns the opposite value on native Linux compared to Linux as Xen/ARM
> > > DomU by "accident". By "accident" because there is no architectural
> > > reason why Linux Xen/ARM DomU should behave differently compared to
> > > native Linux in this regard.
> > > 
> > > I hope that now it is clearer why I think the if (xen_domain()) check
> > > needs to be improved anyway, even if we fix generic dma_ops with virtio
> > > interfaces missing VIRTIO_F_ACCESS_PLATFORM.
> > 
> > IMHO that Xen quirk should never have been added in this form..
> 
> Would you be in favor of a more flexible check along the lines of the
> one proposed in the patch that started this thread:
> 
>     if (xen_vring_use_dma())
>             return true;
> 
> 
> xen_vring_use_dma would be implemented so that it returns true when
> xen_swiotlb is required and false otherwise.

I'll need to think about it. Sounds reasonable on the surface ...

-- 
MST

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
