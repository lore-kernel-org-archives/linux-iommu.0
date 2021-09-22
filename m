Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B274EC433F5
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 22:45:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CB136112F
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 22:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6CB136112F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 244CE81D5A;
	Wed, 22 Sep 2021 22:45:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gDi7XJFggdUX; Wed, 22 Sep 2021 22:45:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ECF3B80CB9;
	Wed, 22 Sep 2021 22:45:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE833C0011;
	Wed, 22 Sep 2021 22:45:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B6C4C000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 22:45:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 66F1660785
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 22:45:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xl4NRvVWyUpX for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 22:45:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 018D860647
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 22:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632350713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E6zD8kdwatd21Yh5voYOyt3V4ervr93MOQFFBWnGbwo=;
 b=LQ9lzQeMQtGKwd94SxKyCExyax3nGmvhHva1eCY7l62IPzThk3yXk8AZozukmcDPtkV9tX
 LfhhjpX5BJRhfZw8WOajNfCuOFcb32l6s8/d5lkfh39mPb+656cCwChPTzj+3/F7OIn+T5
 hyXmvdbEoDmHYaQIUw268eoCum+zbfs=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-nY-e7sX3P2SNhRqTgFeDAw-1; Wed, 22 Sep 2021 18:45:10 -0400
X-MC-Unique: nY-e7sX3P2SNhRqTgFeDAw-1
Received: by mail-oo1-f72.google.com with SMTP id
 x23-20020a4a3957000000b0029aff3ae536so2660767oog.0
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 15:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=E6zD8kdwatd21Yh5voYOyt3V4ervr93MOQFFBWnGbwo=;
 b=juMaYOd8M1ORda6oCQe0hkHUwjE6muMkSsU+encnPQ08uqVdOlIbk3EhHP+RhzCxZQ
 9A2zUNfSt/4BtBu3XjUY7HO9Z79/67a73E7EknZpX1cpO1s7h6ivRpyCA3VCKYjeToTx
 LELxq37wRDzl2wbgGqN5TbaO173Z66jr1KPAzjMsLHyG8UzCzhTWwLO2r+B66tcqZRzm
 t0Ztl5OTUESo2FX1y9kXk/U6S27heqtLJOzAmM1XEmIrWFHuJWEQtevUgyysG3BH2+yR
 SpmS8OLIChiuETjCMMj032LbHQA+YCN19A7R/iwebJLjMqtCu90c2TSowPBJ/6V+XgtV
 SG8w==
X-Gm-Message-State: AOAM532z2DsZPbk6z9upWZSTJvURfgfxiX2+tK2r2vXxhnkWj6Sl8MiR
 YoN0gtGOrhQhh1E499GpOnkKJ+4oSZcoO4RQCMYrRFggBeDyDPZKvt0oadw0BfZ4kPeWibMvEWn
 jvSz1Es8KrkYwGrZRJ1UNwwf1dT5UwQ==
X-Received: by 2002:a9d:705e:: with SMTP id x30mr1392968otj.221.1632350709665; 
 Wed, 22 Sep 2021 15:45:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxauNjEloOgS43KwaOum7NgsKLZs/SbMjhtO3+rybjyroY+pJjDvh7BSn/x0DQg1xt7M+tqTw==
X-Received: by 2002:a9d:705e:: with SMTP id x30mr1392942otj.221.1632350709347; 
 Wed, 22 Sep 2021 15:45:09 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id u27sm899416otj.6.2021.09.22.15.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Sep 2021 15:45:08 -0700 (PDT)
Date: Wed, 22 Sep 2021 16:45:06 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 03/20] vfio: Add vfio_[un]register_device()
Message-ID: <20210922164506.66976218.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB543366158EA87572902EFF5E8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-4-yi.l.liu@intel.com>
 <20210921160108.GO327412@nvidia.com>
 <BN9PR11MB5433D4590BA725C79196E0248CA19@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922005337.GC327412@nvidia.com>
 <BN9PR11MB54338D108AF5A87614717EF98CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922122252.GG327412@nvidia.com>
 <20210922141036.5cd46b2b.alex.williamson@redhat.com>
 <BN9PR11MB543366158EA87572902EFF5E8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
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

On Wed, 22 Sep 2021 22:34:42 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Thursday, September 23, 2021 4:11 AM
> > 
> > On Wed, 22 Sep 2021 09:22:52 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Wed, Sep 22, 2021 at 09:23:34AM +0000, Tian, Kevin wrote:
> > >  
> > > > > Providing an ioctl to bind to a normal VFIO container or group might
> > > > > allow a reasonable fallback in userspace..  
> > > >
> > > > I didn't get this point though. An error in binding already allows the
> > > > user to fall back to the group path. Why do we need introduce another
> > > > ioctl to explicitly bind to container via the nongroup interface?  
> > >
> > > New userspace still needs a fallback path if it hits the 'try and
> > > fail'. Keeping the device FD open and just using a different ioctl to
> > > bind to a container/group FD, which new userspace can then obtain as a
> > > fallback, might be OK.
> > >
> > > Hard to see without going through the qemu parts, so maybe just keep
> > > it in mind  
> > 
> > If we assume that the container/group/device interface is essentially
> > deprecated once we have iommufd, it doesn't make a lot of sense to me
> > to tack on a container/device interface just so userspace can avoid
> > reverting to the fully legacy interface.
> > 
> > But why would we create vfio device interface files at all if they
> > can't work?  I'm not really on board with creating a try-and-fail
> > interface for a mechanism that cannot work for a given device.  The
> > existence of the device interface should indicate that it's supported.
> > Thanks,
> >   
> 
> Now it's a try-and-fail model even for devices which support iommufd.
> Per Jason's suggestion, a device is always opened with a parked fops
> which supports only bind. Binding serves as the contract for handling
> exclusive ownership on a device and switching to normal fops if
> succeed. So the user has to try-and-fail in case multiple threads attempt 
> to open a same device. Device which doesn't support iommufd is not
> different, except binding request 100% fails (due to missing .bind_iommufd
> in kernel driver).

That's a rather important difference.  I don't really see how that's
comparable to the mutually exclusive nature of the legacy vs device
interface.  We're not going to present a vfio device interface for SW
mdevs that can't participate in iommufd, right?  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
