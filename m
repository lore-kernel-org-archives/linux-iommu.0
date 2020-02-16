Return-Path: <SRS0=EPxn=4E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41D5C76199
	for <iommu@archiver.kernel.org>; Sun, 16 Feb 2020 09:50:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F41820857
	for <iommu@archiver.kernel.org>; Sun, 16 Feb 2020 09:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSwqVpZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F41820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DCE46877B1;
	Sun, 16 Feb 2020 09:50:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dflEOAXABa00; Sun, 16 Feb 2020 09:50:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 536CC877A0;
	Sun, 16 Feb 2020 09:50:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3767DC07FF;
	Sun, 16 Feb 2020 09:50:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 790D8C013E
 for <iommu@lists.linux-foundation.org>; Sun, 16 Feb 2020 09:50:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 631F48579E
 for <iommu@lists.linux-foundation.org>; Sun, 16 Feb 2020 09:50:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UKEXQgWCfMeo for <iommu@lists.linux-foundation.org>;
 Sun, 16 Feb 2020 09:50:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D4C5685766
 for <iommu@lists.linux-foundation.org>; Sun, 16 Feb 2020 09:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581846639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ib1DnkGh+UyvdqCLLKTPNNeMXjObgOPxob5BC7ny2no=;
 b=VSwqVpZbl6QxFsbC+nukY38p/CLGSC06mtbePs1RPeQUfYwGwHOnEHq3uBT+kZMR4VTNuP
 IV7EUdkzSdjbG08IMZ+BM6BdACRHQoxOL/xiQ1EJzWzODwwotZ6FD/ZayzDv4x4Ax1yeix
 gNnMcAZLp6Z9PgPxLW9+tI3JEMbbVOU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-csR0GUnLNECUf-77W2faUw-1; Sun, 16 Feb 2020 04:50:37 -0500
Received: by mail-wr1-f72.google.com with SMTP id 50so7102930wrc.2
 for <iommu@lists.linux-foundation.org>; Sun, 16 Feb 2020 01:50:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ib1DnkGh+UyvdqCLLKTPNNeMXjObgOPxob5BC7ny2no=;
 b=dY1WTarZxnIykLFt7Q5yTc2x8KS9ljrU6ufUfeyjB+amGCzIrxDm+EAzpNi3lPtCqG
 yjZEG1o5o72uoM3iAsIzpa/YI6cxCUzuir7Im1S9EFPRvABbfpietyfw37CpLJGVYXFx
 Ydq51WJiV1wssV4f9cQ4MYXr8F27Dc7rbmBlwf3ubeYYAxd8ka+46UURGnizVsCMUnDj
 SJ3msJBLGlHZzeZX7Nwt1kQPXfIbj6wkuMFfxy3HoEcMXiEChaZLEAypgKGxXcKBvzKY
 MmQQJzubWJQQ91x9UAQTsB+TP3L+Gg04pFpDZpjfcme52qqQlXgQMMw+bkro1nvWqiLV
 XyZA==
X-Gm-Message-State: APjAAAU3wn2/puuarVXQysj+JpMMZraMDfc1BzUR8gpn4i0ZsxhEYdlf
 0VIlZnADpkhhd0sr4LWov17GFiDQ47nt0ZSflnaH/0dlZHzBPOwJz8tapKSAltqIiVMT9w7PBDv
 VTrnEZYT99pLHBw50nvl4IXXcZd9E4w==
X-Received: by 2002:a05:600c:248:: with SMTP id 8mr15618225wmj.1.1581846636752; 
 Sun, 16 Feb 2020 01:50:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqyNMrFQHqv71dSXZ95RCgwdZYNzMl1jbONDS4h2qzyUzW0mleNi/Wo/HmWAmrPfI1kdiDOM+g==
X-Received: by 2002:a05:600c:248:: with SMTP id 8mr15618205wmj.1.1581846636526; 
 Sun, 16 Feb 2020 01:50:36 -0800 (PST)
Received: from redhat.com (bzq-79-176-28-95.red.bezeqint.net. [79.176.28.95])
 by smtp.gmail.com with ESMTPSA id
 21sm15813973wmo.8.2020.02.16.01.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2020 01:50:35 -0800 (PST)
Date: Sun, 16 Feb 2020 04:50:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/3] iommu/virtio: Enable x86 support
Message-ID: <20200216045006-mutt-send-email-mst@kernel.org>
References: <20200214160413.1475396-1-jean-philippe@linaro.org>
 <20200214160413.1475396-4-jean-philippe@linaro.org>
 <311a1885-c619-3c8d-29dd-14fbfbf74898@arm.com>
MIME-Version: 1.0
In-Reply-To: <311a1885-c619-3c8d-29dd-14fbfbf74898@arm.com>
X-MC-Unique: csR0GUnLNECUf-77W2faUw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 linux-pci@vger.kernel.org, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, bhelgaas@google.com
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

On Fri, Feb 14, 2020 at 04:57:11PM +0000, Robin Murphy wrote:
> On 14/02/2020 4:04 pm, Jean-Philippe Brucker wrote:
> > With the built-in topology description in place, x86 platforms can now
> > use the virtio-iommu.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >   drivers/iommu/Kconfig | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 068d4e0e3541..adcbda44d473 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -508,8 +508,9 @@ config HYPERV_IOMMU
> >   config VIRTIO_IOMMU
> >   	bool "Virtio IOMMU driver"
> >   	depends on VIRTIO=y
> > -	depends on ARM64
> > +	depends on (ARM64 || X86)
> >   	select IOMMU_API
> > +	select IOMMU_DMA
> 
> Can that have an "if X86" for clarity? AIUI it's not necessary for
> virtio-iommu itself (and really shouldn't be), but is merely to satisfy the
> x86 arch code's expectation that IOMMU drivers bring their own DMA ops,
> right?
> 
> Robin.

In fact does not this work on any platform now?

> >   	select INTERVAL_TREE
> >   	help
> >   	  Para-virtualised IOMMU driver with virtio.
> > 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
