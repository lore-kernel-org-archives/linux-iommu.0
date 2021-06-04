Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BAAC07E94
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 15:26:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2421961402
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 15:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2421961402
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ED8B24063D;
	Fri,  4 Jun 2021 15:26:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zDzEddOhMnF0; Fri,  4 Jun 2021 15:26:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id BA2AF400E4;
	Fri,  4 Jun 2021 15:26:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E410C000D;
	Fri,  4 Jun 2021 15:26:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BAE65C0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 15:26:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9D43383E16
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 15:26:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3BlmXf_BKalu for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 15:26:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A33A983B4D
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 15:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622820386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cnlp4NT59C1lbKlOOtPNARWk0nt3/Bc4USIsMgJ3F/s=;
 b=aInug5u6nhkSpzZqW9bKHepY9Tifq9dL1vBUN3bN8sTQcW8OnB1hJIL4EVyQFi0Um712AV
 enzZviDrt4dA2HBqR2SP78ZHbZUfjn3kVPpNtsZwP+CI+5Kqjn9MT75joogn3VJNx2p+IR
 ipnzV8GRcRhiGgHi516Ynf/hG+WewA8=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-DSHopP7bO_eD4OVt2C0RyA-1; Fri, 04 Jun 2021 11:26:22 -0400
X-MC-Unique: DSHopP7bO_eD4OVt2C0RyA-1
Received: by mail-il1-f200.google.com with SMTP id
 d3-20020a056e021383b02901dea3332ce6so6714101ilo.17
 for <iommu@lists.linux-foundation.org>; Fri, 04 Jun 2021 08:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=Cnlp4NT59C1lbKlOOtPNARWk0nt3/Bc4USIsMgJ3F/s=;
 b=SsKBgCFIUnj8J5I03PrrcIviPx1EPCCrKLmTGBMkMEn/IdCjgWnSA/O3OJoQ2MZ4iH
 NI83nvZQkN/ESIuUaeFeCy6GSjw53sEmoiTlpyYDQ8ROocOYgzTpBjVI98Y934P/yxwG
 8NsU8nLJtEhXrJkoixBW5om4MUOW8gmc7KPVWuDtCkMDlmwsFQxDvGVknFgsEr9u9849
 9kceQE8bATVRmJYkRNZc/Mp13dig/5ttcB05hmJZVxXh/m/THPOgeju86kBTt+xjbbOF
 NwjeU7u4mjz8UqxjPcZBLhDnExuPwc/HMztWbvtTjEwQnPI7mXLTIiljxc5LyCSfS0ov
 TE9A==
X-Gm-Message-State: AOAM530O7s+rT1S/CFGwBQAtWhEem43JUhdqgsWpB3PTl56WOp9tOZlM
 XwMQ/X9pdqtM/B4H31PT4PjBicmOeqOvj5THZAgqLZt9CmJAULRiwOT98yF1mVdD7E2GyBF48to
 UyJBzW63Jm+S9iE0PNUpd0Jn6Y5GN0w==
X-Received: by 2002:a92:1901:: with SMTP id 1mr4431835ilz.237.1622820382123;
 Fri, 04 Jun 2021 08:26:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytV7IHrrQ9TrO5WGLSgtz4HPoOXVeF1qXN+c3eDfItb7Gtmxe5A63obJpbAcW06e9tden5Rg==
X-Received: by 2002:a92:1901:: with SMTP id 1mr4431821ilz.237.1622820381869;
 Fri, 04 Jun 2021 08:26:21 -0700 (PDT)
Received: from redhat.com (c-73-14-100-188.hsd1.co.comcast.net.
 [73.14.100.188])
 by smtp.gmail.com with ESMTPSA id l13sm59605ilc.53.2021.06.04.08.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jun 2021 08:26:21 -0700 (PDT)
Date: Fri, 4 Jun 2021 09:26:20 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210604092620.16aaf5db.alex.williamson@redhat.com>
In-Reply-To: <20210604122830.GK1002214@nvidia.com>
References: <20210602130053.615db578.alex.williamson@redhat.com>
 <20210602195404.GI1002214@nvidia.com>
 <20210602143734.72fb4fa4.alex.williamson@redhat.com>
 <20210602224536.GJ1002214@nvidia.com>
 <20210602205054.3505c9c3.alex.williamson@redhat.com>
 <20210603123401.GT1002214@nvidia.com>
 <20210603140146.5ce4f08a.alex.williamson@redhat.com>
 <20210603201018.GF1002214@nvidia.com>
 <20210603154407.6fe33880.alex.williamson@redhat.com>
 <MWHPR11MB1886469C0136C6523AB158B68C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210604122830.GK1002214@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
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
 "Bonzini, Paolo" <pbonzini@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
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

[Cc +Paolo]

On Fri, 4 Jun 2021 09:28:30 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Jun 04, 2021 at 08:38:26AM +0000, Tian, Kevin wrote:
> > > I think more to drive the replacement design; if we can't figure out
> > > how to do something other than backwards compatibility trickery in the
> > > kernel, it's probably going to bite us.  Thanks,  
> > 
> > I'm a bit lost on the desired flow in your minds. Here is one flow based
> > on my understanding of this discussion. Please comment whether it
> > matches your thinking:
> > 
> > 0) ioasid_fd is created and registered to KVM via KVM_ADD_IOASID_FD;
> > 
> > 1) Qemu binds dev1 to ioasid_fd;
> > 
> > 2) Qemu calls IOASID_GET_DEV_INFO for dev1. This will carry IOMMU_
> >      CACHE info i.e. whether underlying IOMMU can enforce snoop;
> > 
> > 3) Qemu plans to create a gpa_ioasid, and attach dev1 to it. Here Qemu
> >     needs to figure out whether dev1 wants to do no-snoop. This might
> >     be based a fixed vendor/class list or specified by user;
> > 
> > 4) gpa_ioasid = ioctl(ioasid_fd, IOASID_ALLOC); At this point a 'snoop'
> >      flag is specified to decide the page table format, which is supposed
> >      to match dev1;  
> 
> > 5) Qemu attaches dev1 to gpa_ioasid via VFIO_ATTACH_IOASID. At this 
> >      point, specify snoop/no-snoop again. If not supported by related 
> >      iommu or different from what gpa_ioasid has, attach fails.  
> 
> Why do we need to specify it again?

My thought as well.

> If the IOASID was created with the "block no-snoop" flag then it is
> blocked in that IOASID, and that blocking sets the page table format.
> 
> The only question is if we can successfully attach a device to the
> page table, or not.
> 
> The KVM interface is a bit tricky because Alex said this is partially
> security, wbinvd is only enabled if someone has a FD to a device that
> can support no-snoop. 
> 
> Personally I think this got way too complicated, the KVM interface
> should simply be
> 
> ioctl(KVM_ALLOW_INCOHERENT_DMA, ioasidfd, device_label)
> ioctl(KVM_DISALLOW_INCOHERENT_DMA, ioasidfd, device_label)
> 
> and let qemu sort it out based on command flags, detection, whatever.
> 
> 'ioasidfd, device_label' is the security proof that Alex asked
> for. This needs to be some device in the ioasidfd that declares it is
> capabale of no-snoop. Eg vfio_pci would always declare it is capable
> of no-snoop.
> 
> No kernel call backs, no kernel auto-sync/etc. If qemu mismatches the
> IOASID block no-snoop flag with the KVM_x_INCOHERENT_DMA state then it
> is just a kernel-harmless uerspace bug.
> 
> Then user space can decide which of the various axis's it wants to
> optimize for.

Let's make sure the KVM folks are part of this decision; a re-cap for
them, KVM currently automatically enables wbinvd emulation when
potentially non-coherent devices are present which is determined solely
based on the IOMMU's (or platform's, as exposed via the IOMMU) ability
to essentially force no-snoop transactions from a device to be cache
coherent.  This synchronization is triggered via the kvm-vfio device,
where QEMU creates the device and adds/removes vfio group fd
descriptors as an additionally layer to prevent the user from enabling
wbinvd emulation on a whim.

IIRC, this latter association was considered a security/DoS issue to
prevent a malicious guest/userspace from creating a disproportionate
system load.

Where would KVM stand on allowing more direct userspace control of
wbinvd behavior?  Would arbitrary control be acceptable or should we
continue to require it only in association to a device requiring it for
correct operation.

A wrinkle in "correct operation" is that while the IOMMU may be able to
force no-snoop transactions to be coherent, in the scenario described
in the previous reply, the user may intend to use non-coherent DMA
regardless of the IOMMU capabilities due to their own optimization
policy.  There's a whole spectrum here, including aspects we can't
determine around the device driver's intentions to use non-coherent
transactions, the user's policy in trading hypervisor overhead for
cache coherence overhead, etc.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
