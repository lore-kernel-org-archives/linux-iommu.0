Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F695C47082
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 21:44:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2961D613F8
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 21:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2961D613F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC8DE83F02;
	Thu,  3 Jun 2021 21:44:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 39nyjrCNUbK6; Thu,  3 Jun 2021 21:44:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 297EA83EF7;
	Thu,  3 Jun 2021 21:44:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E091AC000E;
	Thu,  3 Jun 2021 21:44:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 719A7C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 21:44:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 492E083F06
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 21:44:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bzjHYEa577nA for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 21:44:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 61F3483EF7
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 21:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622756653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eB4AhoVRrohLIXm7A6phxopY9UW47sYoDfPiWiAbtu4=;
 b=fyXzTFkWd0ZQBT5s4z/WkfmOgUktKi/nlnQwCFFxBu1UNqMr7dRu399KbsE9LfmI2eGE0N
 N3Kjok3AJopcWDJOYrq5x26/8ycepKHGPFthQvBxaH1YPmROg8FISxbo9wF9lxm1Kw+oxf
 hk0yCiUiuLug+8Optmw48MC1T4Q81Ak=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-7oXBi8h7Pv2Df4wvJY9yXg-1; Thu, 03 Jun 2021 17:44:09 -0400
X-MC-Unique: 7oXBi8h7Pv2Df4wvJY9yXg-1
Received: by mail-oo1-f69.google.com with SMTP id
 c25-20020a4ad7990000b029020e67cc1879so4265609oou.18
 for <iommu@lists.linux-foundation.org>; Thu, 03 Jun 2021 14:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eB4AhoVRrohLIXm7A6phxopY9UW47sYoDfPiWiAbtu4=;
 b=uP3rTV0C0U292FIM2A9Ro67pFiMi1a3ron4SQF8vfWagxbtgX1t0hZGgNQt8YNr/6h
 F/yp3sTth1vZhOY05Xvk3QuM/YX6PhHjdYLh5Ge055RnbbStgMScNPWXK2nNdirgmxEG
 WVE+CS+lWdHK1KvkuI9RolfPl0JyZeXdrsAYNG5z521CPiByn8q5YaGr8ox8O1ntDBfZ
 Epo/tRRvy2K5ADyJxYS0Q+yYhoyBx/FJW6e/baAnxz3fwzg9X+W/Dr7xFOuDGYVRUGCh
 cW9Xuw4k4ICCUjAqYFF/3vnldSX6Tr4wRJ09UbwW4CNBBBj5yMYlYnyIAyjmqD+G7x3x
 wzZw==
X-Gm-Message-State: AOAM531MnY6EjqE2QGHIX3qILAGdyLsbvYSC590/Rd2Tce3J4gfc1pQF
 DNSQM1krl0Y6hmP5N8qppdgpPJB2S5ZAXB6tJiJ+80y94cpqs4tbgfaqo0aIrkQqhNJl3aNHIKw
 tKQI3GkKcX8wWnEvtX3cJfZ0SqS5YaQ==
X-Received: by 2002:aca:4a82:: with SMTP id x124mr278767oia.43.1622756649104; 
 Thu, 03 Jun 2021 14:44:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyi8xD8sEnXgrgCImoMdW6AHQMJ9dR5bHs140AA+++p7Oa6zepOjpqKOgFamMGN+pn0ef/UTg==
X-Received: by 2002:aca:4a82:: with SMTP id x124mr278745oia.43.1622756648859; 
 Thu, 03 Jun 2021 14:44:08 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id v20sm25134ooe.47.2021.06.03.14.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jun 2021 14:44:08 -0700 (PDT)
Date: Thu, 3 Jun 2021 15:44:07 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210603154407.6fe33880.alex.williamson@redhat.com>
In-Reply-To: <20210603201018.GF1002214@nvidia.com>
References: <20210602173510.GE1002214@nvidia.com>
 <20210602120111.5e5bcf93.alex.williamson@redhat.com>
 <20210602180925.GH1002214@nvidia.com>
 <20210602130053.615db578.alex.williamson@redhat.com>
 <20210602195404.GI1002214@nvidia.com>
 <20210602143734.72fb4fa4.alex.williamson@redhat.com>
 <20210602224536.GJ1002214@nvidia.com>
 <20210602205054.3505c9c3.alex.williamson@redhat.com>
 <20210603123401.GT1002214@nvidia.com>
 <20210603140146.5ce4f08a.alex.williamson@redhat.com>
 <20210603201018.GF1002214@nvidia.com>
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

On Thu, 3 Jun 2021 17:10:18 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Jun 03, 2021 at 02:01:46PM -0600, Alex Williamson wrote:
> 
> > > > > 1) Mixing IOMMU_CAP_CACHE_COHERENCY and !IOMMU_CAP_CACHE_COHERENCY
> > > > >    domains.
> > > > > 
> > > > >    This doesn't actually matter. If you mix them together then kvm
> > > > >    will turn on wbinvd anyhow, so we don't need to use the DMA_PTE_SNP
> > > > >    anywhere in this VM.
> > > > > 
> > > > >    This if two IOMMU's are joined together into a single /dev/ioasid
> > > > >    then we can just make them both pretend to be
> > > > >    !IOMMU_CAP_CACHE_COHERENCY and both not set IOMMU_CACHE.    
> > > > 
> > > > Yes and no.  Yes, if any domain is !IOMMU_CAP_CACHE_COHERENCY then we
> > > > need to emulate wbinvd, but no we'll use IOMMU_CACHE any time it's
> > > > available based on the per domain support available.  That gives us the
> > > > most consistent behavior, ie. we don't have VMs emulating wbinvd
> > > > because they used to have a device attached where the domain required
> > > > it and we can't atomically remap with new flags to perform the same as
> > > > a VM that never had that device attached in the first place.    
> > > 
> > > I think we are saying the same thing..  
> > 
> > Hrm?  I think I'm saying the opposite of your "both not set
> > IOMMU_CACHE".  IOMMU_CACHE is the mapping flag that enables
> > DMA_PTE_SNP.  Maybe you're using IOMMU_CACHE as the state reported to
> > KVM?  
> 
> I'm saying if we enable wbinvd in the guest then no IOASIDs used by
> that guest need to set DMA_PTE_SNP.

Yes

> If we disable wbinvd in the guest
> then all IOASIDs must enforce DMA_PTE_SNP (or we otherwise guarentee
> no-snoop is not possible).

Yes, but we can't get from one of these to the other atomically wrt to
the device DMA.

> This is not what VFIO does today, but it is a reasonable choice.
> 
> Based on that observation we can say as soon as the user wants to use
> an IOMMU that does not support DMA_PTE_SNP in the guest we can still
> share the IO page table with IOMMUs that do support DMA_PTE_SNP.

If your goal is to prioritize IO page table sharing, sure.  But because
we cannot atomically transition from one to the other, each device is
stuck with the pages tables it has, so the history of the VM becomes a
factor in the performance characteristics.

For example if device {A} is backed by an IOMMU capable of blocking
no-snoop and device {B} is backed by an IOMMU which cannot block
no-snoop, then booting VM1 with {A,B} and later removing device {B}
would result in ongoing wbinvd emulation versus a VM2 only booted with
{A}.

Type1 would use separate IO page tables (domains/ioasids) for these such
that VM1 and VM2 have the same characteristics at the end.

Does this become user defined policy in the IOASID model?  There's
quite a mess of exposing sufficient GET_INFO for an IOASID for the user
to know such properties of the IOMMU, plus maybe we need mapping flags
equivalent to IOMMU_CACHE exposed to the user, preventing sharing an
IOASID that could generate IOMMU faults, etc.

> > > It doesn't solve the problem to connect kvm to AP and kvmgt though  
> > 
> > It does not, we'll probably need a vfio ioctl to gratuitously announce
> > the KVM fd to each device.  I think some devices might currently fail
> > their open callback if that linkage isn't already available though, so
> > it's not clear when that should happen, ie. it can't currently be a
> > VFIO_DEVICE ioctl as getting the device fd requires an open, but this
> > proposal requires some availability of the vfio device fd without any
> > setup, so presumably that won't yet call the driver open callback.
> > Maybe that's part of the attach phase now... I'm not sure, it's not
> > clear when the vfio device uAPI starts being available in the process
> > of setting up the ioasid.  Thanks,  
> 
> At a certain point we maybe just have to stick to backward compat, I
> think. Though it is useful to think about green field alternates to
> try to guide the backward compat design..

I think more to drive the replacement design; if we can't figure out
how to do something other than backwards compatibility trickery in the
kernel, it's probably going to bite us.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
