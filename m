Return-Path: <SRS0=1MD/=LF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6072C48BD1
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 19:39:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E017613D2
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 19:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E017613D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1738A83EF8;
	Fri, 11 Jun 2021 19:39:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gYz0YSokkYyI; Fri, 11 Jun 2021 19:39:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E535A83EF7;
	Fri, 11 Jun 2021 19:39:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC3EFC000E;
	Fri, 11 Jun 2021 19:39:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 593E8C000E
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 19:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D0F741A21
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 19:38:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4v8OvgJZdxx6 for <iommu@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 19:38:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1D95A41A25
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 19:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623440314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MOwRQa2gLwRFHwfCcTkT0bHUAUhdYFDJPEsH9OOUliM=;
 b=ftapSuNvRfzp5cFlIJQP3LwiVDLltIPk4QVx80aEQHTg3uCR9IvTSp6qBwqc94e+ql2dcz
 vzb/EvMLOlQwliStZR5yrOIsY4u6LWPHhHu8RxRLmBKL0GohjgY7llGLgb4KVawDn8u5H/
 h8iogmuHHuRwegLALbS1ytCm5aapvao=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-xh6vhp7FNO6iBw67638J1Q-1; Fri, 11 Jun 2021 15:38:31 -0400
X-MC-Unique: xh6vhp7FNO6iBw67638J1Q-1
Received: by mail-oi1-f199.google.com with SMTP id
 y137-20020aca4b8f0000b02901f1fb748c74so3366201oia.21
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 12:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MOwRQa2gLwRFHwfCcTkT0bHUAUhdYFDJPEsH9OOUliM=;
 b=Kx6VZgOUNiyqZTnESsDlVRT8dpUjcDfaWYRuJaxP53enuzQJt9igb5COJA4+pPMjTc
 PwBbIEJnBJMXR7K17sVooPAjdPM5CV9XELyadlIBnLTi8f2A88olHsOnssJL/w2HQgie
 i+3J1ymqM675DXHqMxLE9m/shry9yJu1LweIgllwyG2NmBvZ9oK+f7e4OYZ0G+ZnLauu
 BgWI4Qwg4mP7gcTJNUMYfX6PMBAihRhMsT6rDEJ8p6Ia0W4ZOKHB50b1R7oe0PZIRYB3
 nHIcMEKCHfcb+6JlaiKCBKv/m7OwZThfLZuxle5K9rFH8y+DFijRXN+vfwpMNxI9TfT/
 1EQQ==
X-Gm-Message-State: AOAM533G2ntO8bml+m3TfYUUrDIrOHAzoR8zzLA6UOPDCQ+985t6O2hh
 /oilQpRvtXFWVXVchKgXHxLQ3rEygonlD0TRzGgRCwFDEnha5J/pzGh6ukigv+kb18aMSDj3wTt
 zR2fpDiT8JpQ6k5Drybjdw6ZM+JOk7Q==
X-Received: by 2002:a05:6808:916:: with SMTP id
 w22mr3512236oih.138.1623440311014; 
 Fri, 11 Jun 2021 12:38:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+/X+ZxRSrudtHIp7gCblUCXIcvq0N/FGf1Kdsk6TrIngH5RlTuM3lhTNw24Xdq56CnKmKCQ==
X-Received: by 2002:a05:6808:916:: with SMTP id
 w22mr3512212oih.138.1623440310783; 
 Fri, 11 Jun 2021 12:38:30 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id l25sm1191473oie.57.2021.06.11.12.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jun 2021 12:38:30 -0700 (PDT)
Date: Fri, 11 Jun 2021 13:38:28 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: Plan for /dev/ioasid RFC v2
Message-ID: <20210611133828.6c6e8b29.alex.williamson@redhat.com>
In-Reply-To: <20210611164529.GR1002214@nvidia.com>
References: <MWHPR11MB188699D0B9C10EB51686C4138C389@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YMCy48Xnt/aphfh3@8bytes.org> <20210609123919.GA1002214@nvidia.com>
 <YMDC8tOMvw4FtSek@8bytes.org> <20210609150009.GE1002214@nvidia.com>
 <YMDjfmJKUDSrbZbo@8bytes.org>
 <20210609101532.452851eb.alex.williamson@redhat.com>
 <20210609102722.5abf62e1.alex.williamson@redhat.com>
 <20210609184940.GH1002214@nvidia.com>
 <20210610093842.6b9a4e5b.alex.williamson@redhat.com>
 <20210611164529.GR1002214@nvidia.com>
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
 "parav@mellanox.com" <parav@mellanox.com>, "Enrico Weigelt, metux IT
 consult" <lkml@metux.net>, David Gibson <david@gibson.dropbear.id.au>,
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

On Fri, 11 Jun 2021 13:45:29 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Jun 10, 2021 at 09:38:42AM -0600, Alex Williamson wrote:
> 
> > Opening the group is not the extent of the security check currently
> > required, the group must be added to a container and an IOMMU model
> > configured for the container *before* the user can get a devicefd.
> > Each devicefd creates a reference to this security context, therefore
> > access to a device does not exist without such a context.  
> 
> Okay, I missed that detail in the organization..
> 
> So, if we have an independent vfio device fd then it needs to be
> kept disable until the user joins it to an ioasid that provides the
> security proof to allow it to work?

Yes, the user would effectively get a dummy fd with no device access
until not only that device, but every device in the IOMMU group is
attached to a secure context.  Then we get into questions about whether
devices can be moved between contexts/ioasids within the same ioasidfd
and what that implies to both the device and all other devices within
the group as a device is transitioned and the system is potentially
exposed.
 
> > What happens on detach?  As we've discussed elsewhere in this thread,
> > revoking access is more difficult than holding a reference to the
> > secure context, but I'm under the impression that moving a device
> > between IOASIDs could be standard practice in this new model.  A device
> > that's detached from a secure context, even temporarily, is a
> > problem.  
> 
> This is why I think the single iommu FD is critical, it is the FD, not
> the IOASID that has to authorize the security. You shouldn't move
> devices between FDs, but you can move them between IOASIDs inside the
> same FD.

Right, but that doesn't solve the issue.  Removing a device from one
isolated context, even if to move it to another isolated context within
the same ioasidfd exposes the device and has implications for all
devices within the group.

> > How to label a device seems like a relatively mundane issue relative to
> > ownership and isolated contexts of groups and devices.  The label is
> > essentially just creating an identifier to device mapping, where the
> > identifier (label) will be used in the IOASID interface, right?   
> 
> It looks that way
> 
> > As I note above, that makes it difficult for vfio to maintain that a
> > user only accesses a device in a secure context.  This is exactly
> > why vfio has the model of getting a devicefd from a groupfd only
> > when that group is in a secure context and maintaining references to
> > that secure context for each device.  Split ownership of the secure
> > context in IOASID vs device access in vfio and exposing devicefds
> > outside the group is still a big question mark for me.  Thanks,  
> 
> I think the protection model becomes different once we allow
> individual devices inside a group to be attached to different
> IOASID's.
> 
> Now we just want some general authorization that the user is allowed
> to operate the device_fd.

That's fine for a serial port, but not a device that can do DMA.  The
entire point of vfio is to try to provide secure, DMA capable userspace
drivers.  If we relax enforcement of that isolation we've failed.

> To keep a fairly similar model to the way vfio does things today..
> 
>  - The device_fd is single open, so only one fd exists globally
>
>  - Upon first joining the iommu_fd the group is obtained inside
>    the iommu_fd. This is only possible if no other iommu_fd has
>    obtained the group

vfio_groups have an ownership model, iommu_groups do not.
 
>  - If the group can not be obtained then the device_fd is left
>    inoperable and cannot control the device
> 
>  - If multiple devices in the same group are joined then they all
>    refcount the group
> 
> It is simple, and gives semantics similar to VFIO with the notable
> difference that process can obtain a device FD, it is just inoperable
> until the iommu_fd is attached.
> 
> Removal is OK as if you remove the device_fd from the iommu_fd (only
> allowed by closing it) then a newly opened FD is inoperable.

I don't see how this provides isolation.  If a user only needs to
attach their devicefd to an ioasidfd to have full access to their
device, not even bound by attaching to an ioasid context, then we've
failed.  All devices in a group must be bound to a secure context for
the extent of the time that any device in the group is operated by a
user.  That seems non-negotiable to me.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
