Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA16C48BDF
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 16:56:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0F666157E
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 16:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F666157E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A369540398;
	Tue, 15 Jun 2021 16:56:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mgydBfJ0muPJ; Tue, 15 Jun 2021 16:56:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 622EA400C9;
	Tue, 15 Jun 2021 16:56:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 349E2C000D;
	Tue, 15 Jun 2021 16:56:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20EB1C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 16:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F25354013D
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 16:56:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mfSXQ7_fxEql for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 16:56:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C994B400C9
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 16:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623776166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tZvxaMeoVcMZyEFg7QVxXPrZUcScONdAV0vv4yiFQ3I=;
 b=QhSUVWA3Ao/GrAvtECBpz/ze/pVeI7s51bRVJ4DyXwEqMw8X2QlqWzOqCpmlEGqnsUghvu
 cxvdmXNAQJUhEZ5tDUk90jwqttR1wphiALJ+sdJZHxBq0sla99qjNdZhlA1Mi+Sjr9g8YX
 zJr1hBSSYK7hWk0siWUwad7/Oe3svoI=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-qkPX7ovZPU6KkxB2Oeplew-1; Tue, 15 Jun 2021 12:56:05 -0400
X-MC-Unique: qkPX7ovZPU6KkxB2Oeplew-1
Received: by mail-ot1-f69.google.com with SMTP id
 o26-20020a9d6d1a0000b02903e61e3de711so9810735otp.12
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 09:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=tZvxaMeoVcMZyEFg7QVxXPrZUcScONdAV0vv4yiFQ3I=;
 b=dRdcIByOVsWMw3P2BBP49kKkY3HOIwK4NnypFdULWvmkw813PEQVtRCCOWeKy3UJR3
 ILfe7qfRGofUD0vtuEWGPU6K9JDa5GqG2lqEg1XWUMG2/9hr/YR5yjn1sDbXlxO+gtyb
 RFbAKnYJCYrZYZfJM/S2ZQWtjdpFq36dXRzxWeQWOXR6ovsoYq6XqOdGRuGlg2EOUX3q
 hsNPCeHUQW4DWqtb2ZU8Sg8O2j8adqeID1kYRbPAhXPzomWa35hk+sOrLh0czaC0F6gb
 1nhFjvAPzDt+KyMj8UdNJnVsqYtiJZSA/fWS2EZEGWqSZ6FYhpRHehxFz0G7n/sxHy33
 fJcw==
X-Gm-Message-State: AOAM532dcUFJ4OyR4380cBOQ4Juc66WTgTWL2YSXFFnzyHha32YYL917
 +qdfTd0tlWZ9YnglBBJ29O4LbOzL5jjVGuI15td3mB917hC/N1pPqLl3/0Ut6kGMJWwRbGbSx6g
 a7mpYUoGStzTy8Xy6BcrlKeDaUuIzKw==
X-Received: by 2002:a05:6830:1643:: with SMTP id
 h3mr226897otr.76.1623776164388; 
 Tue, 15 Jun 2021 09:56:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySTCQEIkpHgxR7ihbT8TXIfNDOtXfaAzp/M9djykvPAQhJp1svTbBP66qBFBmasifCO52RQA==
X-Received: by 2002:a05:6830:1643:: with SMTP id
 h3mr226864otr.76.1623776164075; 
 Tue, 15 Jun 2021 09:56:04 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id n21sm1462475oig.18.2021.06.15.09.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jun 2021 09:56:03 -0700 (PDT)
Date: Tue, 15 Jun 2021 10:56:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: Plan for /dev/ioasid RFC v2
Message-ID: <20210615105601.4d7b8906.alex.williamson@redhat.com>
In-Reply-To: <MWHPR11MB1886A6B3AC4AD249405E5B178C309@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <YMDC8tOMvw4FtSek@8bytes.org> <20210609150009.GE1002214@nvidia.com>
 <YMDjfmJKUDSrbZbo@8bytes.org>
 <20210609101532.452851eb.alex.williamson@redhat.com>
 <20210609102722.5abf62e1.alex.williamson@redhat.com>
 <20210609184940.GH1002214@nvidia.com>
 <20210610093842.6b9a4e5b.alex.williamson@redhat.com>
 <BN6PR11MB187579A2F88C77ED2131CEF08C349@BN6PR11MB1875.namprd11.prod.outlook.com>
 <20210611153850.7c402f0b.alex.williamson@redhat.com>
 <MWHPR11MB1886C2A0A8AA3000EBD5F8E18C319@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210614133819.GH1002214@nvidia.com>
 <MWHPR11MB1886A6B3AC4AD249405E5B178C309@MWHPR11MB1886.namprd11.prod.outlook.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Shenming Lu <lushenming@huawei.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 Jason Gunthorpe <jgg@nvidia.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, "parav@mellanox.com" <parav@mellanox.com>
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

On Tue, 15 Jun 2021 01:21:35 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Monday, June 14, 2021 9:38 PM
> > 
> > On Mon, Jun 14, 2021 at 03:09:31AM +0000, Tian, Kevin wrote:
> >   
> > > If a device can be always blocked from accessing memory in the IOMMU
> > > before it's bound to a driver or more specifically before the driver
> > > moves it to a new security context, then there is no need for VFIO
> > > to track whether IOASIDfd has taken over ownership of the DMA
> > > context for all devices within a group.  
> > 
> > I've been assuming we'd do something like this, where when a device is
> > first turned into a VFIO it tells the IOMMU layer that this device
> > should be DMA blocked unless an IOASID is attached to
> > it. Disconnecting an IOASID returns it to blocked.  
> 
> Or just make sure a device is in block-DMA when it's unbound from a
> driver or a security context. Then no need to explicitly tell IOMMU layer 
> to do so when it's bound to a new driver.
> 
> Currently the default domain type applies even when a device is not
> bound. This implies that if iommu=passthrough a device is always 
> allowed to access arbitrary system memory with or without a driver.
> I feel the current domain type (identity, dma, unmanged) should apply
> only when a driver is loaded...

Note that vfio does not currently require all devices in the group to
be bound to drivers.  Other devices within the group, those bound to
vfio drivers, can be used in this configuration.  This is not
necessarily recommended though as a non-vfio, non-stub driver binding
to one of those devices can trigger a BUG_ON.

> > > If this works I didn't see the need for vfio to keep the sequence.
> > > VFIO still keeps group fd to claim ownership of all devices in a
> > > group.  
> > 
> > As Alex says you still have to deal with the problem that device A in
> > a group can gain control of device B in the same group.  
> 
> There is no isolation in the group then how could vfio prevent device
> A from gaining control of device B? for example when both are attached
> to the same GPA address space with device MMIO bar included, devA
> can do p2p to devB. It's all user's policy how to deal with devices within
> the group. 

The latter is user policy, yes, but it's a system security issue that
the user cannot use device A to control device B if the user doesn't
have access to both devices, ie. doesn't own the group.  vfio would
prevent this by not allowing access to device A while device B is
insecure and would require that all devices within the group remain in
a secure, user owned state for the extent of access to device A.

> > This means device A and B can not be used from to two different
> > security contexts.  
> 
> It depends on how the security context is defined. From iommu layer
> p.o.v, an IOASID is a security context which isolates a device from
> the rest of the system (but not the sibling in the same group). As you
> suggested earlier, it's completely sane if an user wants to attach
> devices in a group to different IOASIDs. Here I just talk about this fact.

This is sane, yes, but that doesn't give us license to allow the user
to access device A regardless of the state of device B.

> > 
> > If the /dev/iommu FD is the security context then the tracking is
> > needed there.
> >   
> 
> As I replied to Alex, my point is that VFIO doesn't need to know the
> attaching status of each device in a group before it can allow user to
> access a device. As long as a device in a group either in block DMA
> or switch to a new address space created via /dev/iommu FD, there's
> no problem to allow user accessing it. User cannot do harm to the
> world outside of the group. User knows there is no isolation within
> the group. that is it.

This is self contradictory, "vfio doesn't need to know the attachment
status"... "[a]s long as a device in a group either in block DMA or
switch to a new address space".  So vfio does need to know the latter.
How does it know that?  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
