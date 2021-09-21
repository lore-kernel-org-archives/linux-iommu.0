Return-Path: <SRS0=55Rd=OL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C187AC433F5
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 21:09:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC0B60F38
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 21:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4FC0B60F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C20F81501;
	Tue, 21 Sep 2021 21:09:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eqsnzMx5IKHT; Tue, 21 Sep 2021 21:09:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EB99080F5F;
	Tue, 21 Sep 2021 21:09:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC3B4C000F;
	Tue, 21 Sep 2021 21:09:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F7B6C000D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 21:09:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 01C278105C
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 21:09:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3PALWxtG2Hpv for <iommu@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:09:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 160D780F5F
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 21:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632258575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MlpLbPlo4KBTm6av7Erxbr1sl480yKpqTzkq1T4fFto=;
 b=TCkyNfbRuqsk8jROr5iyRuLkPuVtwkIGoGtnyIC061bD7LwA5xPL8mfK/3FY0rcrI4zmyQ
 gYSV2uR6k6hn8rz3JYU5T0AGwoD5hkpMNzpXy2rWltfuhFnCR3QTAwRYbIglK3W453CnVE
 TrtjXkbghCRZFLAew7mhwHpSlA6PvO0=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-po3H3y-eP0ynGklwFNTBvQ-1; Tue, 21 Sep 2021 17:09:32 -0400
X-MC-Unique: po3H3y-eP0ynGklwFNTBvQ-1
Received: by mail-oi1-f198.google.com with SMTP id
 q22-20020a0568080a9600b002695b5be070so413451oij.8
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 14:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MlpLbPlo4KBTm6av7Erxbr1sl480yKpqTzkq1T4fFto=;
 b=zJbalnARDSkgOkf6fzaktjUSZ8eJhTnoEce8CdsSEu/CHhfvD0qv9t/MEHUjMSA1GF
 ANf+TtREtawhCEXwVCU3GEZenp6CrGDRORYDbQNUqlQur4qpCb0oqcuhVZLlt1sYjPzG
 MXuz1V4GCGffSCKJM0bcUpbXQJ2ED9dUBz+l4IGDrqB3c58DCuUNN3JZIu/Fy6RyI9jT
 y1l+Ph+u1+lbtqvGU3umwD545thG9FcwvmQ/fwYVYTpUV5GUa9W4r4jCB7cEvJbvAJG+
 3EksjdelaiA0hbkiLm1Ufa3XobH09aB+1ULS5fBVJPtCTtoV4WPxP5RbKXu/SJfdcIDb
 POjA==
X-Gm-Message-State: AOAM530dYYEBpWbrU1/DtJw9gerwy5GiSYxhIkHuLODXdxjP5cuO+r4m
 11qyKmHVpsjP4Ug+MgpBqzWpgkC0JCu1THVYbELrqnxY51JCNSpu07+TQQAtX6GC6arkXs1QyGM
 JTN7QsOUnUkE7V9o/i2yQJGw2acffVQ==
X-Received: by 2002:aca:120f:: with SMTP id 15mr1525419ois.62.1632258571931;
 Tue, 21 Sep 2021 14:09:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhqVoP+OVs+kyF/lfOuiIjVaG7CDYwxfFsiO8jsmgxqmlxGTrRDnls5rys+4wGpfrkbujdyw==
X-Received: by 2002:aca:120f:: with SMTP id 15mr1525386ois.62.1632258571725;
 Tue, 21 Sep 2021 14:09:31 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id k23sm55513ood.12.2021.09.21.14.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Sep 2021 14:09:31 -0700 (PDT)
Date: Tue, 21 Sep 2021 15:09:29 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 05/20] vfio/pci: Register device to /dev/vfio/devices
Message-ID: <20210921150929.5977702c.alex.williamson@redhat.com>
In-Reply-To: <20210921164001.GR327412@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-6-yi.l.liu@intel.com>
 <20210921164001.GR327412@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, jasowang@redhat.com, kwankhede@nvidia.com, hch@lst.de,
 jean-philippe@linaro.org, dave.jiang@intel.com, ashok.raj@intel.com,
 corbet@lwn.net, kevin.tian@intel.com, parav@mellanox.com, lkml@metux.net,
 david@gibson.dropbear.id.au, dwmw2@infradead.org, jun.j.tian@intel.com,
 linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, pbonzini@redhat.com, robin.murphy@arm.com
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

On Tue, 21 Sep 2021 13:40:01 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Sun, Sep 19, 2021 at 02:38:33PM +0800, Liu Yi L wrote:
> > This patch exposes the device-centric interface for vfio-pci devices. To
> > be compatiable with existing users, vfio-pci exposes both legacy group
> > interface and device-centric interface.
> > 
> > As explained in last patch, this change doesn't apply to devices which
> > cannot be forced to snoop cache by their upstream iommu. Such devices
> > are still expected to be opened via the legacy group interface.

This doesn't make much sense to me.  The previous patch indicates
there's work to be done in updating the kvm-vfio contract to understand
DMA coherency, so you're trying to limit use cases to those where the
IOMMU enforces coherency, but there's QEMU work to be done to support
the iommufd uAPI at all.  Isn't part of that work to understand how KVM
will be told about non-coherent devices rather than "meh, skip it in the
kernel"?  Also let's not forget that vfio is not only for KVM.
 
> > When the device is opened via /dev/vfio/devices, vfio-pci should prevent
> > the user from accessing the assigned device because the device is still
> > attached to the default domain which may allow user-initiated DMAs to
> > touch arbitrary place. The user access must be blocked until the device
> > is later bound to an iommufd (see patch 08). The binding acts as the
> > contract for putting the device in a security context which ensures user-
> > initiated DMAs via this device cannot harm the rest of the system.
> > 
> > This patch introduces a vdev->block_access flag for this purpose. It's set
> > when the device is opened via /dev/vfio/devices and cleared after binding
> > to iommufd succeeds. mmap and r/w handlers check this flag to decide whether
> > user access should be blocked or not.  
> 
> This should not be in vfio_pci.
> 
> AFAIK there is no condition where a vfio driver can work without being
> connected to some kind of iommu back end, so the core code should
> handle this interlock globally. A vfio driver's ops should not be
> callable until the iommu is connected.
> 
> The only vfio_pci patch in this series should be adding a new callback
> op to take in an iommufd and register the pci_device as a iommufd
> device.

Couldn't the same argument be made that registering a $bus device as an
iommufd device is a common interface that shouldn't be the
responsibility of the vfio device driver?  Is userspace opening the
non-group device anything more than a reservation of that device if
access is withheld until iommu isolation?  I also don't really want to
predict how ioctls might evolve to guess whether only blocking .read,
.write, and .mmap callbacks are sufficient.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
