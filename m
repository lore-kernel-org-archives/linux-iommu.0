Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D276C433F5
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 21:17:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C90C261181
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 21:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C90C261181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 961A9840BC;
	Wed, 22 Sep 2021 21:17:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k8AiuR8XLZIa; Wed, 22 Sep 2021 21:17:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B24A7840B9;
	Wed, 22 Sep 2021 21:17:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94782C000F;
	Wed, 22 Sep 2021 21:17:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6602EC000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 21:17:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 556EC614E1
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 21:17:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CCDvCIA7HXeD for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 21:17:18 +0000 (UTC)
X-Greylist: delayed 00:16:11 by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6661D6148D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 21:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632345437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/gYLvFBwTWP63mHQyIOLQDvO3hmF+2iVnEein9qF53Y=;
 b=G9NZG6L/GhdGFp2d4yc9CQ4GNDzxJvhr/lIijCMfUKX2htWSvOl/974bv6FPF/qUoKqqlo
 uohIIlFQLsFlE6HbqRPVsVxMoP5+LYNCuXOY8RF0K1frItrU0+qPfDxMVjkFP6nv/opKGH
 3W6JDmDfI8YUc8NCcEmZUPL4XAAsRUI=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-lmHfmd4KPwubot9HT4ZUJA-1; Wed, 22 Sep 2021 17:17:16 -0400
X-MC-Unique: lmHfmd4KPwubot9HT4ZUJA-1
Received: by mail-oo1-f72.google.com with SMTP id
 q3-20020a056820028300b002a9a312d6fdso2459855ood.21
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 14:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=/gYLvFBwTWP63mHQyIOLQDvO3hmF+2iVnEein9qF53Y=;
 b=yVikutsVyGD9ZqDxSJBZLE/Yed4OzCuluLUGEzjhziGaaGp/hCt6Jx9GlvPUR6YqDO
 Ol7H5u/Mif8fHP1Ym5GCjCOReNC5wAhG54kOjtYwER3gslMyMIZNSvRESLezggh9cQIf
 j795GqL9dEUo0uLz/yBpvbCh+XUjLCS+6vX1j+C1g+3pMVvhLjncnndJXaYlVC8ETe66
 FXJ5zVc53HqoSijLU2sZ5kOS8vjypBfRIQnq9MGRuCoCVms8n9xsBWRTr5RFcBJPZ2o1
 VrR9JQISmzkxHRUP/2AximAPCCr/uB+0aqvCtl7OZkX1b9hoCcctU4nNWuyXZCwRFHll
 JsHg==
X-Gm-Message-State: AOAM533v3kAR2lJUW6SnZgMSPaNHBpPD9JlSmGXwbvY0qKpAk2hDiL8I
 3TlI5q9RfG/QMxfDImE4LdG6bQVgJ5BXWX3lQWYSzIpsgZoZVx0yRzJ3Py3adLN0QIMCHSfR7nU
 s69DBxmY7XoykvdMuK1MHwbys6ZnpUw==
X-Received: by 2002:a05:6830:2486:: with SMTP id
 u6mr1135221ots.93.1632345435217; 
 Wed, 22 Sep 2021 14:17:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxc6iyyZw+WQTCkXn6zRwyOEIFjLLsl9TFY8nydX9jzhc7fYSxkdPKhBdO818HVxgfS9lMqEQ==
X-Received: by 2002:a05:6830:2486:: with SMTP id
 u6mr1135191ots.93.1632345435007; 
 Wed, 22 Sep 2021 14:17:15 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id j4sm802381oia.56.2021.09.22.14.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Sep 2021 14:17:14 -0700 (PDT)
Date: Wed, 22 Sep 2021 15:17:12 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 05/20] vfio/pci: Register device to /dev/vfio/devices
Message-ID: <20210922151712.20162912.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB5433D909662D484EFE9C82E28CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-6-yi.l.liu@intel.com>
 <20210921164001.GR327412@nvidia.com>
 <20210921150929.5977702c.alex.williamson@redhat.com>
 <BN9PR11MB5433D909662D484EFE9C82E28CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>,
 "parav@mellanox.com" <parav@mellanox.com>, "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

On Wed, 22 Sep 2021 01:19:08 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Wednesday, September 22, 2021 5:09 AM
> > 
> > On Tue, 21 Sep 2021 13:40:01 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Sun, Sep 19, 2021 at 02:38:33PM +0800, Liu Yi L wrote:  
> > > > This patch exposes the device-centric interface for vfio-pci devices. To
> > > > be compatiable with existing users, vfio-pci exposes both legacy group
> > > > interface and device-centric interface.
> > > >
> > > > As explained in last patch, this change doesn't apply to devices which
> > > > cannot be forced to snoop cache by their upstream iommu. Such devices
> > > > are still expected to be opened via the legacy group interface.  
> > 
> > This doesn't make much sense to me.  The previous patch indicates
> > there's work to be done in updating the kvm-vfio contract to understand
> > DMA coherency, so you're trying to limit use cases to those where the
> > IOMMU enforces coherency, but there's QEMU work to be done to support
> > the iommufd uAPI at all.  Isn't part of that work to understand how KVM
> > will be told about non-coherent devices rather than "meh, skip it in the
> > kernel"?  Also let's not forget that vfio is not only for KVM.  
> 
> The policy here is that VFIO will not expose such devices (no enforce-snoop)
> in the new device hierarchy at all. In this case QEMU will fall back to the
> group interface automatically and then rely on the existing contract to connect 
> vfio and QEMU. It doesn't need to care about the whatever new contract
> until such devices are exposed in the new interface.
> 
> yes, vfio is not only for KVM. But here it's more a task split based on staging
> consideration. imo it's not necessary to further split task into supporting
> non-snoop device for userspace driver and then for kvm.

Patch 10 introduces an iommufd interface for QEMU to learn whether the
IOMMU enforces DMA coherency, at that point QEMU could revert to the
legacy interface, or register the iommufd with KVM, or otherwise
establish non-coherent DMA with KVM as necessary.  We're adding cruft
to the kernel here to enforce an unnecessary limitation.

If there are reasons the kernel can't support the device interface,
that's a valid reason not to present the interface, but this seems like
picking a specific gap that userspace is already able to detect from
this series at the expense of other use cases.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
