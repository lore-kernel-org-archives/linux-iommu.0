Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5E4C2D0E2
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 09:00:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D0023741
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 09:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hj+dKOLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D0023741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1AF35874E6;
	Thu, 24 Sep 2020 09:00:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hNQ8I2A93lTU; Thu, 24 Sep 2020 09:00:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2A7D2874BB;
	Thu, 24 Sep 2020 09:00:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07F03C0889;
	Thu, 24 Sep 2020 09:00:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7A7EC0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 09:00:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D1E922E0D8
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 09:00:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nuva10VXhIIW for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 09:00:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 85D7E2045D
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 09:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600938050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GUGrf6sKN5n1jpxMEY27z8eDMfPfaHEAHvK9zipmPr8=;
 b=hj+dKOLUeE1sMBJk8zFWRmLGTpb45D8rgn+MT8XgeG7zTLnQpuGaJX75WrciS86pm81uou
 9oyMUp7eFPkm8aOJr7H54LWLNAuTRyUZr8hNUOuJ9wOd/NlVOXJNNmOrSBomc6g3bckmIU
 AvZkrkd3TMMNqY7UB+dD/J9oA/rrOYc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-0XSbKcDzNFq5_LWQjtvsfA-1; Thu, 24 Sep 2020 05:00:41 -0400
X-MC-Unique: 0XSbKcDzNFq5_LWQjtvsfA-1
Received: by mail-wm1-f70.google.com with SMTP id c200so978516wmd.5
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 02:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GUGrf6sKN5n1jpxMEY27z8eDMfPfaHEAHvK9zipmPr8=;
 b=R+4ZCtU2bPayu+3naOS1Y3byMIvOYegOAto9Y0+IWev/xUzX+N3OuFDi2/ol71jr75
 ZmaCdESc6ozkLQ6pLybp18t6pUmptTK0ketyfDgMx39pCnm4qVE7ltsZgNs7AhVIsQuk
 gQPGKqeqQC4x6j2AvaqcwO6ew47mI4/NJ/UBY0LG3+vjTGysE7/pkWHyZ5l8X4YThQaJ
 O3lvm1ts0a+tvegKNUwFunAAjxfPA3Zxkr+3jposvCBIvYmVkqCkKVg9+CZdjbscT1Ne
 aTI2c04sG5donuzTCsWVLczhpggz3wvS2A+cOszImU8j9cZFnd8JoILy1uwthn91nue/
 WsVA==
X-Gm-Message-State: AOAM532PFTqzrYseCQto+vMELwpcLk5KfSqnwox6g8rxrRWWdT8lroXT
 CzDm3thq2x24yz7Rolq/DMuPHU9VzogC+BW26pRyjpq/oBmPBBH1o2JD2xbVeI3BcewQ/EOEPBZ
 +3VvP29Lk/LpnM/Uz8UHoclrZVtT5Pw==
X-Received: by 2002:adf:fe42:: with SMTP id m2mr3827874wrs.367.1600938040405; 
 Thu, 24 Sep 2020 02:00:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwM6amM8onmWtTQ2m03dl19rxCsYdxhcLJwZMHlUC1IovGw8tlcX+SAAylK/ze3a948rFpahg==
X-Received: by 2002:adf:fe42:: with SMTP id m2mr3827842wrs.367.1600938040173; 
 Thu, 24 Sep 2020 02:00:40 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id h16sm3001574wre.87.2020.09.24.02.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 02:00:39 -0700 (PDT)
Date: Thu, 24 Sep 2020 05:00:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200924045958-mutt-send-email-mst@kernel.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, bhelgaas@google.com, jasowang@redhat.com
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

On Fri, Sep 04, 2020 at 06:24:12PM +0200, Auger Eric wrote:
> Hi,
> 
> On 8/21/20 3:15 PM, Jean-Philippe Brucker wrote:
> > Add a topology description to the virtio-iommu driver and enable x86
> > platforms.
> > 
> > Since [v2] we have made some progress on adding ACPI support for
> > virtio-iommu, which is the preferred boot method on x86. It will be a
> > new vendor-agnostic table describing para-virtual topologies in a
> > minimal format. However some platforms don't use either ACPI or DT for
> > booting (for example microvm), and will need the alternative topology
> > description method proposed here. In addition, since the process to get
> > a new ACPI table will take a long time, this provides a boot method even
> > to ACPI-based platforms, if only temporarily for testing and
> > development.
> > 
> > v3:
> > * Add patch 1 that moves virtio-iommu to a subfolder.
> > * Split the rest:
> >   * Patch 2 adds topology-helper.c, which will be shared with the ACPI
> >     support.
> >   * Patch 4 adds definitions.
> >   * Patch 5 adds parser in topology.c.
> > * Address other comments.
> > 
> > Linux and QEMU patches available at:
> > https://jpbrucker.net/git/linux virtio-iommu/devel
> > https://jpbrucker.net/git/qemu virtio-iommu/devel
> I have tested that series with above QEMU branch on ARM with virtio-net
> and virtio-blk translated devices in non DT mode.
> 
> It works for me:
> Tested-by: Eric Auger <eric.auger@redhat.com>
> 
> Thanks
> 
> Eric

OK so this looks good. Can you pls repost with the minor tweak
suggested and all acks included, and I will queue this?

Thanks!

> > 
> > [spec] https://lists.oasis-open.org/archives/virtio-dev/202008/msg00067.html
> > [v2] https://lore.kernel.org/linux-iommu/20200228172537.377327-1-jean-philippe@linaro.org/
> > [v1] https://lore.kernel.org/linux-iommu/20200214160413.1475396-1-jean-philippe@linaro.org/
> > [rfc] https://lore.kernel.org/linux-iommu/20191122105000.800410-1-jean-philippe@linaro.org/
> > 
> > Jean-Philippe Brucker (6):
> >   iommu/virtio: Move to drivers/iommu/virtio/
> >   iommu/virtio: Add topology helpers
> >   PCI: Add DMA configuration for virtual platforms
> >   iommu/virtio: Add topology definitions
> >   iommu/virtio: Support topology description in config space
> >   iommu/virtio: Enable x86 support
> > 
> >  drivers/iommu/Kconfig                     |  18 +-
> >  drivers/iommu/Makefile                    |   3 +-
> >  drivers/iommu/virtio/Makefile             |   4 +
> >  drivers/iommu/virtio/topology-helpers.h   |  50 +++++
> >  include/linux/virt_iommu.h                |  15 ++
> >  include/uapi/linux/virtio_iommu.h         |  44 ++++
> >  drivers/iommu/virtio/topology-helpers.c   | 196 ++++++++++++++++
> >  drivers/iommu/virtio/topology.c           | 259 ++++++++++++++++++++++
> >  drivers/iommu/{ => virtio}/virtio-iommu.c |   4 +
> >  drivers/pci/pci-driver.c                  |   5 +
> >  MAINTAINERS                               |   3 +-
> >  11 files changed, 597 insertions(+), 4 deletions(-)
> >  create mode 100644 drivers/iommu/virtio/Makefile
> >  create mode 100644 drivers/iommu/virtio/topology-helpers.h
> >  create mode 100644 include/linux/virt_iommu.h
> >  create mode 100644 drivers/iommu/virtio/topology-helpers.c
> >  create mode 100644 drivers/iommu/virtio/topology.c
> >  rename drivers/iommu/{ => virtio}/virtio-iommu.c (99%)
> > 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
