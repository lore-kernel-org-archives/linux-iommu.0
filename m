Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97852C47082
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 18:47:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42CF961936
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 18:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42CF961936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 08C8D4017C;
	Tue,  8 Jun 2021 18:47:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WVGP926kfTZR; Tue,  8 Jun 2021 18:47:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id C9E0D404D0;
	Tue,  8 Jun 2021 18:47:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93685C000B;
	Tue,  8 Jun 2021 18:47:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FFDDC0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 18:47:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1656183C03
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 18:47:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xB8aOUKbAMsi for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 18:47:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0156083653
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 18:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623178024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pggYjn7HE949Eh1AF224q4uHAjKMVRVQ+Yp3GK12w3I=;
 b=edKWUDwWFj2YSp0aVES1AheyWNX3eft6ZQjAIsMhYFbJEPoB0fAdRL2Rjuzh30XSfPzG8S
 ZkmaJOwjTFkpv48oLm4x2s3QmS+BMyRBRtp1JCJcOjid3dYCsQ2y1t3SJBzZG9ZSdDS8MH
 xJXZzNWa7J2BlRcp951lZAzLKxfWje8=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-9fpymfKzPWmezXjB80hzbw-1; Tue, 08 Jun 2021 14:47:03 -0400
X-MC-Unique: 9fpymfKzPWmezXjB80hzbw-1
Received: by mail-ot1-f69.google.com with SMTP id
 v16-20020a0568300910b029032e3cb976e3so14561040ott.14
 for <iommu@lists.linux-foundation.org>; Tue, 08 Jun 2021 11:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=pggYjn7HE949Eh1AF224q4uHAjKMVRVQ+Yp3GK12w3I=;
 b=VdLzBpTtnaGDuZgO/Z2ZOYdZVm0czaknhqVEDo7miAQMOdJubNJ/rbWuSMCvUceEwT
 IxDBkLeEzYitMtaAFsXIosyKgqPZdiRs3Sr+c1+ImPYQun9YO0fHTlwhKsZrAwqxxWfx
 GbMFBzhmqxGi3EVcauBV59p2n/ZllehEQHvRmq30zugr5k+tCcKK9AqnJH4SAQZbHWHl
 ZIGZpERl51G6pjrAzKUYl4DmSWTcO52escFtV/LlPgPEnO3NzPt2vNHrbvfMdZ6EPvCC
 XEjotNBnsdmC0WWuNi5pZPP9S8UPklnzgFENNo3NiCBOVnsHXPT/a8Lwgsrt5ogjXwHd
 mKgw==
X-Gm-Message-State: AOAM533q1miu/5eFqFm8KmAnViU5oAwZJPUb8I6Q1L26dEES3phiJ39W
 qQ5T8NY6kvMJd+TJWDtbEoYgfQpl/OdtKSZvD47zkGYKrfIhbjLZ8+6zjpd7oBFRduzUlp6hTEf
 G6YzSDcUtdpAkvN9fsWw4QytzeCAedg==
X-Received: by 2002:aca:4cc3:: with SMTP id z186mr3803991oia.73.1623178022611; 
 Tue, 08 Jun 2021 11:47:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZf1O0f0pw+40XtUuaOyogPurrGiPr1ylVHW3rYzYXfGQXFHlVRWz1CKnFUzJnCqpweUhXgA==
X-Received: by 2002:aca:4cc3:: with SMTP id z186mr3803972oia.73.1623178022326; 
 Tue, 08 Jun 2021 11:47:02 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id 3sm336679oob.1.2021.06.08.11.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jun 2021 11:47:02 -0700 (PDT)
Date: Tue, 8 Jun 2021 12:47:00 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210608124700.7b9aa5a6.alex.williamson@redhat.com>
In-Reply-To: <89d30977-119c-49f3-3bf6-d3f7104e07d8@redhat.com>
References: <20210604092620.16aaf5db.alex.williamson@redhat.com>
 <815fd392-0870-f410-cbac-859070df1b83@redhat.com>
 <20210604155016.GR1002214@nvidia.com>
 <30e5c597-b31c-56de-c75e-950c91947d8f@redhat.com>
 <20210604160336.GA414156@nvidia.com>
 <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
 <20210604172207.GT1002214@nvidia.com>
 <2d1ad075-bec6-bfb9-ce71-ed873795e973@redhat.com>
 <20210607175926.GJ1002214@nvidia.com>
 <fdb2f38c-da1f-9c12-af44-22df039fcfea@redhat.com>
 <20210608131547.GE1002214@nvidia.com>
 <89d30977-119c-49f3-3bf6-d3f7104e07d8@redhat.com>
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
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
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

On Tue, 8 Jun 2021 15:44:26 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 08/06/21 15:15, Jason Gunthorpe wrote:
> > On Tue, Jun 08, 2021 at 09:56:09AM +0200, Paolo Bonzini wrote:
> >   
> >>>> Alternatively you can add a KVM_DEV_IOASID_{ADD,DEL} pair of ioctls. But it
> >>>> seems useless complication compared to just using what we have now, at least
> >>>> while VMs only use IOASIDs via VFIO.  
> >>>
> >>> The simplest is KVM_ENABLE_WBINVD(<fd security proof>) and be done
> >>> with it.  

Even if we were to relax wbinvd access to any device (capable of
no-snoop or not) in any IOMMU configuration (blocking no-snoop or not),
I think as soon as we say "proof" is required to gain this access then
that proof should be ongoing for the life of the access.

That alone makes this more than a "I want this feature, here's my
proof", one-shot ioctl.  Like the groupfd enabling a path for KVM to
ask if that group is non-coherent and holding a group reference to
prevent the group from being used to authorize multiple KVM instances,
the ioasidfd proof would need to minimally validate that devices are
present and provide some reference to enforce that model as ongoing, or
notifier to indicate an end of that authorization.  I don't think we
can simplify that out of the equation or we've essentially invalidated
that the proof is really required.

> >>
> >> The simplest one is KVM_DEV_VFIO_GROUP_ADD/DEL, that already exists and also
> >> covers hot-unplug.  The second simplest one is KVM_DEV_IOASID_ADD/DEL.  
> > 
> > This isn't the same thing, this is back to trying to have the kernel
> > set policy for userspace.  
> 
> If you want a userspace policy then there would be three states:
> 
> * WBINVD enabled because a WBINVD-enabled VFIO device is attached.
> 
> * WBINVD potentially enabled but no WBINVD-enabled VFIO device attached
> 
> * WBINVD forcefully disabled
> 
> KVM_DEV_VFIO_GROUP_ADD/DEL can still be used to distinguish the first 
> two.  Due to backwards compatibility, those two describe the default 
> behavior; disabling wbinvd can be done easily with a new sub-ioctl of 
> KVM_ENABLE_CAP and doesn't require any security proof.

That seems like a good model, use the kvm-vfio device for the default
behavior and extend an existing KVM ioctl if QEMU still needs a way to
tell KVM to assume all DMA is coherent, regardless of what the kvm-vfio
device reports.

If feels like we should be able to support a backwards compatibility
mode using the vfio group, but I expect long term we'll want to
transition the kvm-vfio device from a groupfd to an ioasidfd.

> The meaning of WBINVD-enabled is "won't return -ENXIO for the wbinvd 
> ioctl", nothing more nothing less.  If all VFIO devices are going to be 
> WBINVD-enabled, then that will reflect on KVM as well, and I won't have 
> anything to object if there's consensus on the device assignment side of 
> things that the wbinvd ioctl won't ever fail.

If we create the IOMMU vs device coherency matrix:

            \ Device supports
IOMMU blocks \   no-snoop
  no-snoop    \  yes | no  |
---------------+-----+-----+
           yes |  1  |  2  |
---------------+-----+-----+
           no  |  3  |  4  |
---------------+-----+-----+

DMA is always coherent in boxes {1,2,4} (wbinvd emulation is not
needed).  VFIO will currently always configure the IOMMU for {1,2} when
the feature is supported.  Boxes {3,4} are where we'll currently
emulate wbinvd.  The best we could do, not knowing the guest or
insights into the guest driver would be to only emulate wbinvd for {3}.

The majority of devices appear to report no-snoop support {1,3}, but
the claim is that it's mostly unused outside of GPUs, effectively {2,4}.
I'll speculate that most IOMMUs support enforcing coherency (amd, arm,
fsl unconditionally, intel conditionally) {1,2}.

I think that means we're currently operating primarily in Box {1},
which does not seem to lean towards unconditional wbinvd access with
device ownership.

I think we have a desire with IOASID to allow user policy to operate
certain devices in {3} and I think the argument there is that a
specific software enforced coherence sync is more efficient on the bus
than the constant coherence enforcement by the IOMMU.

I think that the disable mode Jason proposed is essentially just a way
to move a device from {3} to {4}, ie. the IOASID support or
configuration does not block no-snoop and the device claims to support
no-snoop, but doesn't use it.  How we'd determine this to be true for
a device without a crystal ball of driver development or hardware
errata that no-snoop transactions are not possible regardless of the
behavior of the enable bit, I'm not sure.  If we're operating a device
in {3}, but the device does not generate no-snoop transactions, then
presumably the guest driver isn't generating wbinvd instructions for us
to emulate, so where are the wbinvd instructions that this feature
would prevent being emulated coming from?  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
