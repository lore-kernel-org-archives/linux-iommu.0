Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D01C47083
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 17:11:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C28961CA2
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 17:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C28961CA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5980E4051B;
	Wed,  2 Jun 2021 17:11:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LIU8yBMm3MPL; Wed,  2 Jun 2021 17:11:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5CE54051A;
	Wed,  2 Jun 2021 17:11:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9771BC000D;
	Wed,  2 Jun 2021 17:11:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7695FC0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 17:11:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 53AD54051B
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 17:11:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id phCiL-Nyu6WP for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 17:11:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E74464051A
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 17:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622653882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rQnb3uVEkzGJfWKHipZhsatLwyXBgLRi/IklHpC5SOg=;
 b=AhACmH6Ycv5pl6RiGgGwG5qy1g+jWyiDlXFPMAd07EGfZMoo/MaE8K6QQHYfSLQkSMV9NN
 b3kC6dneOXpnNj7P4WazTaipQ8F/kl6c8ncslHpupOFBvuI6pUS9Z6eH6SHcYoUyNUWfsV
 VLeoI0f0V8rzSeZMC72ElXXzPj+ukKg=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-KOKFSqo3Mc-9XlUWbjElNg-1; Wed, 02 Jun 2021 13:11:20 -0400
X-MC-Unique: KOKFSqo3Mc-9XlUWbjElNg-1
Received: by mail-oi1-f199.google.com with SMTP id
 s3-20020a0568080083b02901eee88a8f42so1491106oic.11
 for <iommu@lists.linux-foundation.org>; Wed, 02 Jun 2021 10:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rQnb3uVEkzGJfWKHipZhsatLwyXBgLRi/IklHpC5SOg=;
 b=PupiDvT7tBlFaURAIgWeAsNilu5JxsuCAWtHKWDohFPQs9toXJ3AKAkedgLF+oZHcx
 q31VK2l4XIQ/2dRpS9DpWahC4hVurBz4AiXgUlKWtB/KBjG3azrqaoG/8Mfpo11Vy6S3
 incrzbkkjKNQS3x2wzFU3Z7SbTDX7SfwsZLIJImDyOfKrKTrq0hNQ5F3PUqOlkdedgqn
 4Vu9taEpwm1k0G6MtdhyzWHUXJTEGwVyBq0oSHFOhf7PLEGB3WKWlRDlby/KRbjIneH6
 q/OsJE1/eDwmtcxaYz83itpKG+fVU+1F2vm715CR9scsidBu5gBW7ejUe65M/1WdsMzf
 KziQ==
X-Gm-Message-State: AOAM5337m5i8Z/YpEPPObuFD/5J3Yl7WDq14VD7PybZVQTsZCo5w0ITN
 AbruhkBYsgSCkiQmLjrRgoGPFMt/dmNPjjny+L9e0rvV6GPhSLB9VVbPc+yk+DR8Be2FiLeeafP
 e+iLnuSje9Braxzu1hKKUi1PbG6mUEQ==
X-Received: by 2002:a05:6808:5cf:: with SMTP id
 d15mr1617212oij.15.1622653879853; 
 Wed, 02 Jun 2021 10:11:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiquf9XvQwTSgxCIyQwkKRXmIc+IfSqYwX9h2rpwZV2d2yRmfp0luOh6jW5cB/WpGo7V6a2A==
X-Received: by 2002:a05:6808:5cf:: with SMTP id
 d15mr1617181oij.15.1622653879635; 
 Wed, 02 Jun 2021 10:11:19 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id x187sm106687oia.17.2021.06.02.10.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jun 2021 10:11:18 -0700 (PDT)
Date: Wed, 2 Jun 2021 11:11:17 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210602111117.026d4a26.alex.williamson@redhat.com>
In-Reply-To: <20210602160140.GV1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528200311.GP1002214@nvidia.com>
 <MWHPR11MB188685D57653827B566BF9B38C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601162225.259923bc.alex.williamson@redhat.com>
 <MWHPR11MB1886E8454A58661DC2CDBA678C3D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210602160140.GV1002214@nvidia.com>
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
 Robin Murphy <robin.murphy@arm.com>,
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

On Wed, 2 Jun 2021 13:01:40 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Jun 02, 2021 at 02:20:15AM +0000, Tian, Kevin wrote:
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Wednesday, June 2, 2021 6:22 AM
> > > 
> > > On Tue, 1 Jun 2021 07:01:57 +0000
> > > "Tian, Kevin" <kevin.tian@intel.com> wrote:  
> > > >
> > > > I summarized five opens here, about:
> > > >
> > > > 1)  Finalizing the name to replace /dev/ioasid;
> > > > 2)  Whether one device is allowed to bind to multiple IOASID fd's;
> > > > 3)  Carry device information in invalidation/fault reporting uAPI;
> > > > 4)  What should/could be specified when allocating an IOASID;
> > > > 5)  The protocol between vfio group and kvm;
> > > >  
> > > ...  
> > > >
> > > > For 5), I'd expect Alex to chime in. Per my understanding looks the
> > > > original purpose of this protocol is not about I/O address space. It's
> > > > for KVM to know whether any device is assigned to this VM and then
> > > > do something special (e.g. posted interrupt, EPT cache attribute, etc.).  
> > > 
> > > Right, the original use case was for KVM to determine whether it needs
> > > to emulate invlpg, so it needs to be aware when an assigned device is  
> > 
> > invlpg -> wbinvd :)

Oops, of course.
   
> > > present and be able to test if DMA for that device is cache
> > > coherent.  
> 
> Why is this such a strong linkage to VFIO and not just a 'hey kvm
> emulate wbinvd' flag from qemu?

IIRC, wbinvd has host implications, a malicious user could tell KVM to
emulate wbinvd then run the op in a loop and induce a disproportionate
load on the system.  We therefore wanted a way that it would only be
enabled when required.

> I briefly didn't see any obvios linkage in the arch code, just some
> dead code:
> 
> $ git grep iommu_noncoherent
> arch/x86/include/asm/kvm_host.h:	bool iommu_noncoherent;
> $ git grep iommu_domain arch/x86
> arch/x86/include/asm/kvm_host.h:        struct iommu_domain *iommu_domain;
> 
> Huh?

Cruft from legacy KVM device assignment, I assume.  What you're looking
for is:

kvm_vfio_update_coherency
 kvm_arch_register_noncoherent_dma
  atomic_inc(&kvm->arch.noncoherent_dma_count);

need_emulate_wbinvd
 kvm_arch_has_noncoherent_dma
  atomic_read(&kvm->arch.noncoherent_dma_count);

There are a couple other callers that I'm not as familiar with.

> It kind of looks like the other main point is to generate the
> VFIO_GROUP_NOTIFY_SET_KVM which is being used by two VFIO drivers to
> connect back to the kvm data
> 
> But that seems like it would have been better handled with some IOCTL
> on the vfio_device fd to import the KVM to the driver not this
> roundabout way?

Then QEMU would need to know which drivers require KVM knowledge?  This
allowed transparent backwards compatibility with userspace.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
