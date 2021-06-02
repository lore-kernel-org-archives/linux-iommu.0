Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44497C4708F
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 18:01:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E061B61DB9
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 18:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E061B61DB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7ECD34026F;
	Wed,  2 Jun 2021 18:01:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9XjiePjeltoB; Wed,  2 Jun 2021 18:01:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 173F7401D0;
	Wed,  2 Jun 2021 18:01:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E06C3C000D;
	Wed,  2 Jun 2021 18:01:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EE57C0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 18:01:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 749D560B25
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 18:01:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1wSUkYdIV1_t for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 18:01:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A8617605CF
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 18:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622656883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GOWP8as2a04gvaXr2BrNnViaTGVhZuXkKrD7YE2poSY=;
 b=fMqyMmnEfXJgOIWFDD1lrYPygOAhHz2v80einG5mfOHrPhakOTfBO3tpYc10GzBfseNGUZ
 vuoeilkApqWb7nNPxbqNwUXyvYkq0Ny0njAySVqlND6CW1zXZFHDyuncY/Nf8QRKZdXMaj
 ZsfbTpdo5UOYmD0AR51YHeqL14vfGeE=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-OeFFOXu2NImO6AyvmYLuMA-1; Wed, 02 Jun 2021 14:01:15 -0400
X-MC-Unique: OeFFOXu2NImO6AyvmYLuMA-1
Received: by mail-oo1-f71.google.com with SMTP id
 x22-20020a4a39560000b0290245a21af9a1so1945569oog.1
 for <iommu@lists.linux-foundation.org>; Wed, 02 Jun 2021 11:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GOWP8as2a04gvaXr2BrNnViaTGVhZuXkKrD7YE2poSY=;
 b=QMdE0X3IlFBmIIHDH5CSZZozpegvzOBL84SSl+3QBFD9e/l0h4ZXGCQ8WbpNjrO9pc
 3nsD9YMN9Ni+iY8GoE/n3+Oi/XmtVBQKl99BzAn0gQXJA8193oF2oJkJ1PWTiqTzehx5
 BzzJIT1rqprAyusu2sqeXFlEdagf6C2gCjU6dPSEJkJ327KI2dvteOoA8ptxirO3x3l7
 FiJ2TOfOSdxVxT7C/wpVU82qLPk8pBeX15v9Fg4p1XR0qE6qvyRfGfGWyM+eSNfz7apf
 a9UrrGi1YaOnDnOYFEqFyrvS1iXq7+VG199Ph2DmzMMPKk2IgNl4N9KdVv88vzHQ3Z8n
 Q2Aw==
X-Gm-Message-State: AOAM531/qV0rSEGqdc5C916lA3zMR6Z+oKtXTIHLpjVfJW6+Syf429d2
 f2jtjXL498CsJ7RWpnAQ8yNLTbu/cvc2pxoIVfKNrifvy9nGMqy3GyByaNnXH1CEynLPD3+M8fh
 0/IIRPuURGebhyq2Kmu/Uik01uiu9Rw==
X-Received: by 2002:a4a:8111:: with SMTP id b17mr20369537oog.5.1622656874262; 
 Wed, 02 Jun 2021 11:01:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrk3qRkou4FT+ap8Ib7IcLQ3KgCOffHmpgm57ql01tRBX5u1yu/4tSn54gl3AujN8OJ/KF+w==
X-Received: by 2002:a4a:8111:: with SMTP id b17mr20369498oog.5.1622656873779; 
 Wed, 02 Jun 2021 11:01:13 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id u6sm133070otk.63.2021.06.02.11.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jun 2021 11:01:13 -0700 (PDT)
Date: Wed, 2 Jun 2021 12:01:11 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210602120111.5e5bcf93.alex.williamson@redhat.com>
In-Reply-To: <20210602173510.GE1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528200311.GP1002214@nvidia.com>
 <MWHPR11MB188685D57653827B566BF9B38C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601162225.259923bc.alex.williamson@redhat.com>
 <MWHPR11MB1886E8454A58661DC2CDBA678C3D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210602160140.GV1002214@nvidia.com>
 <20210602111117.026d4a26.alex.williamson@redhat.com>
 <20210602173510.GE1002214@nvidia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj, 
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

On Wed, 2 Jun 2021 14:35:10 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Jun 02, 2021 at 11:11:17AM -0600, Alex Williamson wrote:
> 
> > > > > present and be able to test if DMA for that device is cache
> > > > > coherent.    
> > > 
> > > Why is this such a strong linkage to VFIO and not just a 'hey kvm
> > > emulate wbinvd' flag from qemu?  
> > 
> > IIRC, wbinvd has host implications, a malicious user could tell KVM to
> > emulate wbinvd then run the op in a loop and induce a disproportionate
> > load on the system.  We therefore wanted a way that it would only be
> > enabled when required.  
> 
> I think the non-coherentness is vfio_device specific? eg a specific
> device will decide if it is coherent or not?

No, this is specifically whether DMA is cache coherent to the
processor, ie. in the case of wbinvd whether the processor needs to
invalidate its cache in order to see data from DMA.

> If yes I'd recast this to call kvm_arch_register_noncoherent_dma()
> from the VFIO_GROUP_NOTIFY_SET_KVM in the struct vfio_device
> implementation and not link it through the IOMMU.

The IOMMU tells us if DMA is cache coherent, VFIO_DMA_CC_IOMMU maps to
IOMMU_CAP_CACHE_COHERENCY for all domains within a container.

> If userspace is telling the vfio_device to be non-coherent or not then
> it can call kvm_arch_register_noncoherent_dma() or not based on that
> signal.

Not non-coherent device memory, that would be a driver issue, cache
coherence of DMA is what we're after.

> > > It kind of looks like the other main point is to generate the
> > > VFIO_GROUP_NOTIFY_SET_KVM which is being used by two VFIO drivers to
> > > connect back to the kvm data
> > > 
> > > But that seems like it would have been better handled with some IOCTL
> > > on the vfio_device fd to import the KVM to the driver not this
> > > roundabout way?  
> > 
> > Then QEMU would need to know which drivers require KVM knowledge?  This
> > allowed transparent backwards compatibility with userspace.  Thanks,  
> 
> I'd just blindly fire a generic 'hey here is your KVM FD' into every
> VFIO device.

Yes, QEMU could do this, but the vfio-kvm device was already there with
this association and required no uAPI work.  This one is the least IOMMU
related of the use cases.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
