Return-Path: <SRS0=ynGH=LB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC55C47082
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 18:59:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800DC610C8
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 18:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800DC610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4D75D40146;
	Mon,  7 Jun 2021 18:59:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IiKJ43gpc3zV; Mon,  7 Jun 2021 18:59:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 22BDC402BA;
	Mon,  7 Jun 2021 18:59:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1C6BC000D;
	Mon,  7 Jun 2021 18:59:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 840A4C0001
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 18:59:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6503F60720
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 18:59:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xtWgw9a12NBa for <iommu@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 18:59:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F44F6066D
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 18:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623092390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ife/jm9NgTe8HtyBunu2/HSrkqZCWtIQ558to+xkpk=;
 b=YZhb6RnRuFifZFYneebaKg1ILMD1SGiR2eG768tXFI2CxbzC/IZwbDKGwZy7/yQccbIm7H
 M56voKaX4CmrO7YUeW+MEssWjMPkH7TYVhHAyVCYTa41/ce8UH+hP4Yvr4W5MFgoHh1Gso
 o+nfZzcfnNRfBYWxzgoyT5w5FTsKCl8=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-mtrhJ_eSNfuCBn1S3npjkA-1; Mon, 07 Jun 2021 14:59:49 -0400
X-MC-Unique: mtrhJ_eSNfuCBn1S3npjkA-1
Received: by mail-oo1-f72.google.com with SMTP id
 t19-20020a4ae4130000b029023950cb8d35so11628233oov.6
 for <iommu@lists.linux-foundation.org>; Mon, 07 Jun 2021 11:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0ife/jm9NgTe8HtyBunu2/HSrkqZCWtIQ558to+xkpk=;
 b=CJI/buYE75Qy3jZS5xvmJ9zyXtcu38YdKddNjW+eaB1WQPs1jzepyDZ9UiU2K8it0O
 eiorKz4lMincWsNIMmHZJa0UFrRiz3T8zz6NZO/CEDzlMEiO2gIOHDNcp8mMKDiZqMVI
 d6k7Y77wXeQUQTriE1LWasKE6/9QsJYmDwq431pI7XjBZQwyxAi9ZCtIrtk9CauJE+KJ
 RyF/c+UeTsL4ylrhTHgj47WWnOT6kg24UsRKSZfn+sjuBRtXRRcCoSOvdTrRAf93Gqm8
 bdtp6M+bhnuFaZckEv73fZieevJofyJLcB7ONr+hBtYHDKQmDBWueXqxFb4RJNtoWrFd
 jVLg==
X-Gm-Message-State: AOAM5300mi3jyYZF01cLiIvf5DVgtRmTA7ArRwlPzGbogLjK756Eia7w
 YMZYH+ri9RdjkV7UQhKuWZd0fL3+BewJX0VevuBUg+qH+jROj7YAXyYpOh+aZTLxV2io0jUZOb7
 O8tc+5ZPv9vdvIxFKHRjbQlxsCYU/Dg==
X-Received: by 2002:a4a:b98e:: with SMTP id e14mr14415949oop.82.1623092388653; 
 Mon, 07 Jun 2021 11:59:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhoXmKMGHpe3MLRxm5Hs89CDspIbwCeiZmAq0yRDSAs5fLzu0UTQgxwdz09tDxbh6R4mj+Yw==
X-Received: by 2002:a4a:b98e:: with SMTP id e14mr14415930oop.82.1623092388374; 
 Mon, 07 Jun 2021 11:59:48 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id b26sm2221621otf.69.2021.06.07.11.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jun 2021 11:59:47 -0700 (PDT)
Date: Mon, 7 Jun 2021 12:59:46 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210607125946.056aafa2.alex.williamson@redhat.com>
In-Reply-To: <20210607181858.GM1002214@nvidia.com>
References: <20210604092620.16aaf5db.alex.williamson@redhat.com>
 <815fd392-0870-f410-cbac-859070df1b83@redhat.com>
 <20210604155016.GR1002214@nvidia.com>
 <30e5c597-b31c-56de-c75e-950c91947d8f@redhat.com>
 <20210604160336.GA414156@nvidia.com>
 <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
 <20210604172207.GT1002214@nvidia.com>
 <20210604152918.57d0d369.alex.williamson@redhat.com>
 <20210604230108.GB1002214@nvidia.com>
 <20210607094148.7e2341fc.alex.williamson@redhat.com>
 <20210607181858.GM1002214@nvidia.com>
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
 Paolo Bonzini <pbonzini@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
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

On Mon, 7 Jun 2021 15:18:58 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Jun 07, 2021 at 09:41:48AM -0600, Alex Williamson wrote:
> > You're calling this an admin knob, which to me suggests a global module
> > option, so are you trying to implement both an administrator and a user
> > policy?  ie. the user can create scenarios where access to wbinvd might
> > be justified by hardware/IOMMU configuration, but can be limited by the
> > admin?  
> 
> Could be a per-device sysfs too. I'm not really sure what is useful
> here.
> 
> > For example I proposed that the ioasidfd would bear the responsibility
> > of a wbinvd ioctl and therefore validate the user's access to enable
> > wbinvd emulation w/ KVM, so I'm assuming this module option lives
> > there.    
> 
> Right, this is what I was thinking
> 
> > What then is "automatic" mode?  The user cannot create a non-coherent
> > IOASID with a non-coherent device if the IOMMU supports no-snoop
> > blocking?  Do they get a failure?  Does it get silently promoted to
> > coherent?  
> 
> "automatic" was just a way to keep the API the same as today. Today if
> the IOMMU can block no-snoop then vfio disables wbinvd. To get the
> same level of security automatic mode would detect that vfio would
> have blocked wbinvd because the IOMMU can do it, and then always block
> it.
> 
> It makes sense if there is an admin knob, as the admin could then move
> to an explict enable/disable to get functionality they can't get
> today.
> 
> > In "disable" mode, I think we're just narrowing the restriction
> > further, a non-coherent capable device cannot be used except in a
> > forced coherent IOASID.  
> 
> I wouldn't say "cannot be used" - just you can't get access to
> wbinvd. 
> 
> It is up to qemu if it wants to proceed or not. There is no issue with
> allowing the use of no-snoop and blocking wbinvd, other than some
> drivers may malfunction. If the user is certain they don't have
> malfunctioning drivers then no issue to go ahead.

A driver that knows how to use the device in a coherent way can
certainly proceed, but I suspect that's not something we can ask of
QEMU.  QEMU has no visibility to the in-use driver and sketchy ability
to virtualize the no-snoop enable bit to prevent non-coherent DMA from
the device.  There might be an experimental ("x-" prefixed) QEMU device
option to allow user override, but QEMU should disallow the possibility
of malfunctioning drivers by default.  If we have devices that probe as
supporting no-snoop, but actually can't generate such traffic, we might
need a quirk list somewhere.

> The current vfio arrangement (automatic) maximized compatability. The
> enable/disable options provide for max performance and max security as
> alternative targets.
> 
> > > It is the strenth of Paolo's model that KVM should not be able to do
> > > optionally less, not more than the process itself can do.  
> > 
> > I think my previous reply was working towards those guidelines.  I feel
> > like we're mostly in agreement, but perhaps reading past each other.  
> 
> Yes, I think I said we were agreeing :)
> 
> > Nothing here convinced me against my previous proposal that the
> > ioasidfd bears responsibility for managing access to a wbinvd ioctl,
> > and therefore the equivalent KVM access.  Whether wbinvd is allowed or
> > no-op'd when the use has access to a non-coherent device in a
> > configuration where the IOMMU prevents non-coherent DMA is maybe still
> > a matter of personal preference.  
> 
> I think it makes the software design much simpler if the security
> check is very simple. Possessing a suitable device in an ioasid fd
> container is enough to flip on the feature and we don't need to track
> changes from that point on. We don't need to revoke wbinvd if the
> ioasid fd changes, for instance. Better to keep the kernel very simple
> in this regard.

You're suggesting that a user isn't forced to give up wbinvd emulation
if they lose access to their device?  I suspect that like we do today,
we'll want to re-evaluate the need for wbinvd on most device changes.
I think this is why the kvm-vfio device holds a vfio group reference;
to make sure a given group can't elevate privileges for multiple
processes.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
