Return-Path: <SRS0=kZfo=MF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1127C07E95
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 16:26:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68075611AB
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 16:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68075611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EA86405FB;
	Tue, 13 Jul 2021 16:26:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LzsNmUxSDvIV; Tue, 13 Jul 2021 16:26:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A31EA405AE;
	Tue, 13 Jul 2021 16:26:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74607C0010;
	Tue, 13 Jul 2021 16:26:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 015CAC000E
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 16:26:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F0D18404C6
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 16:26:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x70lLBpydeWR for <iommu@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 16:26:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3AEAC400EB
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 16:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626193574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUNFSZ0FEoShWeStx0gKzE+MBfhHSV0LmcBrnFbHTXY=;
 b=K4ITbhjwYvhPLsjijQcvp03aG8Qaffuk1sVsTyx430V8CMajrBlFnNKqcbPFY0iFOLb1yd
 jQa/lewgDg/RbmUf3dBbCiKV/Ta8HfHN1pTKJC6O4bfNA28wEUxBKTUhAo5JM9dqC/SBjs
 TuvSEA5PumQl3gK7y9HibFSdLbqlKDo=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-sBm5T-NDO5-YuPTDlYn-dA-1; Tue, 13 Jul 2021 12:26:11 -0400
X-MC-Unique: sBm5T-NDO5-YuPTDlYn-dA-1
Received: by mail-oi1-f197.google.com with SMTP id
 m21-20020a0568080f15b029023dd486bf36so15491039oiw.15
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 09:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aUNFSZ0FEoShWeStx0gKzE+MBfhHSV0LmcBrnFbHTXY=;
 b=YV5OcDOgXA2CXOL+5myLMSM8IxDEMH9rnFHORC8+3IaWusKfWwNgZYuX0YTV4tyWDD
 lnWDSZjYK+YP3erxcaAtnHhqFN5J1JELEFDk3uqCgKVLqVc7Xqj4Ol2oh9TG6hP/lOFT
 NoyExXA3KV+HE9i8hCDmk0S9EItkPNTg2R68l+tJvFCOIvBtbLOwt1VUP41NMnD4GgFr
 LzeXulgnaz902BSi7OR3ncBD0CTF6aWX+liweZEhg7Nr2xOet5upbWcoVLWWHMuu+uiG
 XNVGCyjM4EDS9GeKyVkR1OqrTrokpgErG4PHwMmHoDAw/JSzQiSjngup0cTOYM64tSCi
 4JSA==
X-Gm-Message-State: AOAM530+yam66btbJCnf3apHq2a/bBi9qvxoaimrQfl3XKeIqQOssF+H
 kx/KEuSRY9pCOeO/KW+kHkQwkLWNwGA3ehXzs7y3onwne6l5ubSE3XzteL20uxWDlSJ/qCcDZ2J
 DC1sL6uMoKGp+TtP2Ho9LMHl2lvE35g==
X-Received: by 2002:aca:1e04:: with SMTP id m4mr3818772oic.1.1626193570358;
 Tue, 13 Jul 2021 09:26:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzl+u2c3Je1HN3GzIh0wo30xQVXEXR89UpoNOeKThRgzm1AgZvalAzbyfHug11B/NidaNjezQ==
X-Received: by 2002:aca:1e04:: with SMTP id m4mr3818748oic.1.1626193570154;
 Tue, 13 Jul 2021 09:26:10 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id l15sm1047355otk.56.2021.07.13.09.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 09:26:09 -0700 (PDT)
Date: Tue, 13 Jul 2021 10:26:07 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC v2] /dev/iommu uAPI proposal
Message-ID: <20210713102607.3a886fee.alex.williamson@redhat.com>
In-Reply-To: <20210713125503.GC136586@nvidia.com>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210709155052.2881f561.alex.williamson@redhat.com>
 <BN9PR11MB54336FB9845649BB2D53022C8C159@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210712124150.2bf421d1.alex.williamson@redhat.com>
 <BL1PR11MB54299D9554D71F53D74E1E378C159@BL1PR11MB5429.namprd11.prod.outlook.com>
 <20210713125503.GC136586@nvidia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>, "Enrico Weigelt,
 metux IT consult" <lkml@metux.net>, David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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

On Tue, 13 Jul 2021 09:55:03 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Jul 12, 2021 at 11:56:24PM +0000, Tian, Kevin wrote:
> 
> > Maybe I misunderstood your question. Are you specifically worried
> > about establishing the security context for a mdev vs. for its
> > parent?  
> 
> The way to think about the cookie, and the device bind/attach in
> general, is as taking control of a portion of the IOMMU routing:
> 
>  - RID
>  - RID + PASID
>  - "software"
> 
> For the first two there can be only one device attachment per value so
> the cookie is unambiguous.
> 
> For "software" the iommu layer has little to do with this - everything
> is constructed outside by the mdev. If the mdev wishes to communicate
> on /dev/iommu using the cookie then it has to do so using some iommufd
> api and we can convay the proper device at that point.
> 
> Kevin didn't show it, but along side the PCI attaches:
> 
>         struct iommu_attach_data * iommu_pci_device_attach(
>                 struct iommu_dev *dev, struct pci_device *pdev,
>                 u32 ioasid);
> 
> There would also be a software attach for mdev:
> 
>         struct iommu_attach_data * iommu_sw_device_attach(
>                 struct iommu_dev *dev, struct device *pdev, u32 ioasid);
> 
> Which does not connect anything to the iommu layer.
> 
> It would have to return something that allows querying the IO page
> table, and the mdev would use that API instead of vfio_pin_pages().


Quoting this proposal again:

> 1)  A successful binding call for the first device in the group creates 
>     the security context for the entire group, by:
> 
>     * Verifying group viability in a similar way as VFIO does;
> 
>     * Calling IOMMU-API to move the group into a block-dma state,
>       which makes all devices in the group attached to an block-dma
>       domain with an empty I/O page table;
> 
>     VFIO should not allow the user to mmap the MMIO bar of the bound
>     device until the binding call succeeds.

The attach step is irrelevant to my question, the bind step is where
the device/group gets into a secure state for device access.

So for IGD we have two scenarios, direct assignment and software mdevs.

AIUI the operation of VFIO_DEVICE_BIND_IOMMU_FD looks like this:

	iommu_ctx = iommu_ctx_fdget(iommu_fd);

	mdev = mdev_from_dev(vdev->dev);
	dev = mdev ? mdev_parent_dev(mdev) : vdev->dev;

	iommu_dev = iommu_register_device(iommu_ctx, dev, cookie);

In either case, this last line is either registering the IGD itself
(ie. the struct device representing PCI device 0000:00:02.0) or the
parent of the GVT-g mdev (ie. the struct device representing PCI device
0000:00:02.0).  They're the same!  AIUI, the cookie is simply an
arbitrary user generated value which they'll use to refer to this
device via the iommu_fd uAPI.

So what magic is iommu_register_device() doing to infer my intentions
as to whether I'm asking for the IGD RID to be isolated or I'm only
creating a software context for an mdev?  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
