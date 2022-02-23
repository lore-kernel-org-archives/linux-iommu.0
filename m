Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EFAC4167D
	for <iommu@archiver.kernel.org>; Wed, 23 Feb 2022 21:53:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04919401BB;
	Wed, 23 Feb 2022 21:53:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cwbrpjAODJ4S; Wed, 23 Feb 2022 21:53:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CB02C409AC;
	Wed, 23 Feb 2022 21:53:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89A97C001A;
	Wed, 23 Feb 2022 21:53:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 280CFC0011
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 21:53:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0F93180C2C
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 21:53:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VnLZwiI4EdIv for <iommu@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 21:53:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 444E980C29
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 21:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645653224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QHc4p6P496hz/XkslW9zde1DsEfB8iSDkjx5qIKJc48=;
 b=L7gzNj9StIEUcC5xQmVVb7HRsLT5sLhhcaIhW9mJYoxtkxTnPxnn9jUZngwhqyxyO1b4/q
 Dux5YbnbShPYmAYm9nAjhXL4fQLqVlxjG/5oklcogr/gdk19Y9+IqD7vG73pJtTr1HRKEu
 re0RjXwzql23zYF7RCeTKdJIC3Zx6/g=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-H5u1X9hWP1WI520vCJ_kaw-1; Wed, 23 Feb 2022 16:53:42 -0500
X-MC-Unique: H5u1X9hWP1WI520vCJ_kaw-1
Received: by mail-oo1-f70.google.com with SMTP id
 j18-20020a4ae852000000b003181c031d81so166055ooj.22
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 13:53:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=QHc4p6P496hz/XkslW9zde1DsEfB8iSDkjx5qIKJc48=;
 b=YCgftDvzH9VoRPzL1MDaO5436pAsfkmiDQ7xK9WlJJGScI54l8rm+jI2lzLq/ntexH
 CENHPb3OK7T2ryPhCQ+fYo/3lNrzYruYtnuvh23WHg6bRek2jxhQleyxiQh2Rsked6kp
 cQHqJKDFdV5eZoxYmVvwxXoFuU3ilXOkKeEO/9be81dpCI6P8ERYxvf7n9jtX7suZd1x
 PL/lltnLZ+4JB5UeMGhXWqNVvIWaweju9hcBSbySY1XpxhZaY4LMWzI/CbCE0MIfNYea
 hsxSucEAZ+0nbRm2mjUejVjxw3i2O+SG3QpuaK0SspqRJbnMw4KI0jrIUsXi8ONvkC3I
 y5cQ==
X-Gm-Message-State: AOAM530k1YTAdPU8pMxWTSTaGuu15Sb2h/tmnb2xQZoaZEOBX6wlrQgx
 hr/AsN/4KKyiw987fXaxbvumDdJdnsap4jCcNJh7nUaW9Isc4R34+x+h8R9vr4A/LBhAfkfCG34
 hZLVgbDUbtv7B2C+Au1O8yTIgJk/zJg==
X-Received: by 2002:a05:6870:3e0d:b0:d3:fe6d:57c3 with SMTP id
 lk13-20020a0568703e0d00b000d3fe6d57c3mr780585oab.225.1645653222097; 
 Wed, 23 Feb 2022 13:53:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVZWjYYf1lHUEZ749G1CD7yMY7PoElR7MtLZJgwYZu5lf142+Ut2Mxb4MgP1wHkjXeQTJkxQ==
X-Received: by 2002:a05:6870:3e0d:b0:d3:fe6d:57c3 with SMTP id
 lk13-20020a0568703e0d00b000d3fe6d57c3mr780550oab.225.1645653221851; 
 Wed, 23 Feb 2022 13:53:41 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
 by smtp.gmail.com with ESMTPSA id 128sm369711oor.15.2022.02.23.13.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Feb 2022 13:53:41 -0800 (PST)
Date: Wed, 23 Feb 2022 14:53:39 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v6 10/11] vfio: Remove iommu group notifier
Message-ID: <20220223145339.57ed632e.alex.williamson@redhat.com>
In-Reply-To: <20220218005521.172832-11-baolu.lu@linux.intel.com>
References: <20220218005521.172832-1-baolu.lu@linux.intel.com>
 <20220218005521.172832-11-baolu.lu@linux.intel.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Stuart Yoder <stuyoder@gmail.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
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

On Fri, 18 Feb 2022 08:55:20 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> The iommu core and driver core have been enhanced to avoid unsafe driver
> binding to a live group after iommu_group_set_dma_owner(PRIVATE_USER)
> has been called. There's no need to register iommu group notifier. This
> removes the iommu group notifer which contains BUG_ON() and WARN().
> 
> The commit 5f096b14d421b ("vfio: Whitelist PCI bridges") allowed all
> pcieport drivers to be bound with devices while the group is assigned to
> user space. This is not always safe. For example, The shpchp_core driver
> relies on the PCI MMIO access for the controller functionality. With its
> downstream devices assigned to the userspace, the MMIO might be changed
> through user initiated P2P accesses without any notification. This might
> break the kernel driver integrity and lead to some unpredictable
> consequences. As the result, currently we only allow the portdrv driver.
> 
> For any bridge driver, in order to avoiding default kernel DMA ownership
> claiming, we should consider:
> 
>  1) Does the bridge driver use DMA? Calling pci_set_master() or
>     a dma_map_* API is a sure indicate the driver is doing DMA
> 
>  2) If the bridge driver uses MMIO, is it tolerant to hostile
>     userspace also touching the same MMIO registers via P2P DMA
>     attacks?
> 
> Conservatively if the driver maps an MMIO region at all, we can say that
> it fails the test.

IIUC, there's a chance we're going to break user configurations if
they're assigning devices from a group containing a bridge that uses a
driver other than pcieport.  The recommendation to such an affected user
would be that the previously allowed host bridge driver was unsafe for
this use case and to continue to enable assignment of devices within
that group, the driver should be unbound from the bridge device or
replaced with the pci-stub driver.  Is that right?

Unfortunately I also think a bisect of such a breakage wouldn't land
here, I think it was actually broken in "vfio: Set DMA ownership for
VFIO" since that's where vfio starts to make use of
iommu_group_claim_dma_owner() which should fail due to
pci_dma_configure() calling iommu_device_use_default_domain() for
any driver not identifying itself as driver_managed_dma.

If that's correct, can we leave a breadcrumb in the correct commit log
indicating why this potential breakage is intentional and how the
bridge driver might be reconfigured to continue to allow assignment from
within the group more safely?  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
