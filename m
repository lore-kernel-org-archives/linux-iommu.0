Return-Path: <SRS0=ynGH=LB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB76C47094
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 19:41:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7542861008
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 19:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7542861008
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F30E402E9;
	Mon,  7 Jun 2021 19:41:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7lEK3flr183z; Mon,  7 Jun 2021 19:41:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7B2F402EA;
	Mon,  7 Jun 2021 19:41:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F535C000E;
	Mon,  7 Jun 2021 19:41:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BC2AC0001
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 19:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0D94783083
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 19:41:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ol6bM3xQ2m8p for <iommu@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 19:41:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A8B283077
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 19:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623094892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ktL5nWqTPLu4372fp6dA+Wp9VnIRyo2M4rsP7gUhK4E=;
 b=Lh2IycNwMqSAgwbuTF16WDt0FOMEsvcjDCslH07JHCbTYzYTpY+qs/g9bMTLNLuv+w2e0x
 Ssgi+Ty1r+FaQ9sPuXqQFCgbycF4h1cimNkTKDo8784pwIUwryKV4S4AiP4j2Th39V12ja
 EN/t0ZvmrGmKbh5Lu+B8QoidQwdit38=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-6-fCEebUN7ST6FiRoFpxQw-1; Mon, 07 Jun 2021 15:41:30 -0400
X-MC-Unique: 6-fCEebUN7ST6FiRoFpxQw-1
Received: by mail-oi1-f199.google.com with SMTP id
 a29-20020a544e1d0000b02901eef9e4a58cso7582158oiy.3
 for <iommu@lists.linux-foundation.org>; Mon, 07 Jun 2021 12:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ktL5nWqTPLu4372fp6dA+Wp9VnIRyo2M4rsP7gUhK4E=;
 b=LsUWFpuez5TWb8ymb7BY1Q1qGGwnOb9UkeNEp1A6BxIHhmq+yyjDxbKGdg8Nlnv58Y
 Q4Et1H5Vxd/EbEfi++rKkDmXqnKAOusXhuqEkayDH+oJFRUQsDCkArcpND9JDVxzQOJl
 bY/OL6fI2I2xi6kubV+FQymffPh8KBt0dz+a36r/DzredNVz3QUwZNAjandVZIBKm7ei
 4e8stMxhdpwtdqsWYhKga9aJNQ9i8CCtxJq+GAG3j+iGoVwusgPcb0x4MvLJYU5vT1R7
 D3LPJHR1aYtQNMLhwpd5ct6qwx8Z6LRl9QiqnejXP5FAeAfwauhkPzfipsSsqP9UnNZ6
 5oVQ==
X-Gm-Message-State: AOAM531HeZzFEg+RwKV/gBMhabEB+W6/YC3rycEBQPV35MSUUsrYTQb0
 e4U+qiH3fnZT0tlHirMvm0xLMZ4/hWZvf0IZKEmacBIRp2YpLQT5OA91bzvkc/oT2Jv8FQjxC8N
 meZ3O6j+a/Om0+uWKWveJbY5QC4869Q==
X-Received: by 2002:aca:3102:: with SMTP id x2mr537464oix.1.1623094890137;
 Mon, 07 Jun 2021 12:41:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFosBz4IUOZGFguQH5//THCuRP/IrBVZiu1yVwVFAaZQAbRyF2bu+8LlE0J5GnSsN+9iyoow==
X-Received: by 2002:aca:3102:: with SMTP id x2mr537457oix.1.1623094889890;
 Mon, 07 Jun 2021 12:41:29 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id r83sm2421065oih.48.2021.06.07.12.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jun 2021 12:41:29 -0700 (PDT)
Date: Mon, 7 Jun 2021 13:41:28 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210607134128.58c2ea31.alex.williamson@redhat.com>
In-Reply-To: <20210607190802.GO1002214@nvidia.com>
References: <20210604155016.GR1002214@nvidia.com>
 <30e5c597-b31c-56de-c75e-950c91947d8f@redhat.com>
 <20210604160336.GA414156@nvidia.com>
 <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
 <20210604172207.GT1002214@nvidia.com>
 <20210604152918.57d0d369.alex.williamson@redhat.com>
 <20210604230108.GB1002214@nvidia.com>
 <20210607094148.7e2341fc.alex.williamson@redhat.com>
 <20210607181858.GM1002214@nvidia.com>
 <20210607125946.056aafa2.alex.williamson@redhat.com>
 <20210607190802.GO1002214@nvidia.com>
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

On Mon, 7 Jun 2021 16:08:02 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Jun 07, 2021 at 12:59:46PM -0600, Alex Williamson wrote:
> 
> > > It is up to qemu if it wants to proceed or not. There is no issue with
> > > allowing the use of no-snoop and blocking wbinvd, other than some
> > > drivers may malfunction. If the user is certain they don't have
> > > malfunctioning drivers then no issue to go ahead.  
> > 
> > A driver that knows how to use the device in a coherent way can
> > certainly proceed, but I suspect that's not something we can ask of
> > QEMU.  QEMU has no visibility to the in-use driver and sketchy ability
> > to virtualize the no-snoop enable bit to prevent non-coherent DMA from
> > the device.  There might be an experimental ("x-" prefixed) QEMU device
> > option to allow user override, but QEMU should disallow the possibility
> > of malfunctioning drivers by default.  If we have devices that probe as
> > supporting no-snoop, but actually can't generate such traffic, we might
> > need a quirk list somewhere.  
> 
> Compatibility is important, but when I look in the kernel code I see
> very few places that call wbinvd(). Basically all DRM for something
> relavent to qemu.
> 
> That tells me that the vast majority of PCI devices do not generate
> no-snoop traffic.

Unfortunately, even just looking at devices across a couple laptops
most devices do support and have NoSnoop+ set by default.  I don't
notice anything in the kernel that actually tries to set this enable (a
handful that actively disable), so I assume it's done by the firmware.
It's not safe for QEMU to make an assumption that only GPUs will
actually make use of it.

> > > I think it makes the software design much simpler if the security
> > > check is very simple. Possessing a suitable device in an ioasid fd
> > > container is enough to flip on the feature and we don't need to track
> > > changes from that point on. We don't need to revoke wbinvd if the
> > > ioasid fd changes, for instance. Better to keep the kernel very simple
> > > in this regard.  
> > 
> > You're suggesting that a user isn't forced to give up wbinvd emulation
> > if they lose access to their device?    
> 
> Sure, why do we need to be stricter? It is the same logic I gave
> earlier, once an attacker process has access to wbinvd an attacker can
> just keep its access indefinitely.
> 
> The main use case for revokation assumes that qemu would be
> compromised after a device is hot-unplugged and you want to block off
> wbinvd. But I have a hard time seeing that as useful enough to justify
> all the complicated code to do it...

It's currently just a matter of the kvm-vfio device holding a reference
to the group so that it cannot be used elsewhere so long as it's being
used to elevate privileges on a given KVM instance.  If we conclude that
access to a device with the right capability is required to gain a
privilege, I don't really see how we can wave aside that the privilege
isn't lost with the device.

> For KVM qemu can turn on/off on hot plug events as it requires to give
> VM security. It doesn't need to rely on the kernel to control this.

Yes, QEMU can reject a hot-unplug event, but then QEMU retains the
privilege that the device grants it.  Releasing the device and
retaining the privileged gained by it seems wrong.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
