Return-Path: <SRS0=l6pd=55=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0D2C2BB1D
	for <iommu@archiver.kernel.org>; Mon, 13 Apr 2020 19:10:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A1AF20732
	for <iommu@archiver.kernel.org>; Mon, 13 Apr 2020 19:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWIU3ZFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1AF20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4EDF120338;
	Mon, 13 Apr 2020 19:10:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4kx7WQoTIgV3; Mon, 13 Apr 2020 19:10:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E14F220013;
	Mon, 13 Apr 2020 19:10:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF46BC1D7D;
	Mon, 13 Apr 2020 19:10:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B72F9C0172
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 19:10:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A624486DF0
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 19:10:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W9Mkv0pTiwMZ for <iommu@lists.linux-foundation.org>;
 Mon, 13 Apr 2020 19:10:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0337A86DDC
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 19:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586805013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D2w0zTL2S2HNCke1rO2a892We/kRrnfinWwPLR7p/D8=;
 b=LWIU3ZFcxbfVQdR1fhJHUd+6ECoqeCY+4dRObHFLNetbyGRGOIkpto1nzE+ccIHlh6cg/R
 YEWLX7HE2zSW2aV0iiX86upobyDQZd0JOi7pcks0lVyvGklUF6th+9imGWGOqqax67K+MK
 KmoA+ooPITRhFTCyr8aOrFTy88U0gQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-LRRuLY3rMi27XnVi9zMzzg-1; Mon, 13 Apr 2020 15:10:11 -0400
X-MC-Unique: LRRuLY3rMi27XnVi9zMzzg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E339107ACC4;
 Mon, 13 Apr 2020 19:10:09 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 973D799DEE;
 Mon, 13 Apr 2020 19:10:08 +0000 (UTC)
Date: Mon, 13 Apr 2020 13:10:08 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH v1 2/2] vfio/pci: Emulate PASID/PRI capability for VFs
Message-ID: <20200413131008.2ae53cc3@w520.home>
In-Reply-To: <20200413032930.GB18479@araj-mobl1.jf.intel.com>
References: <1584880394-11184-1-git-send-email-yi.l.liu@intel.com>
 <1584880394-11184-3-git-send-email-yi.l.liu@intel.com>
 <20200402165954.48d941ee@w520.home>
 <A2975661238FB949B60364EF0F2C25743A2204FE@SHSMSX104.ccr.corp.intel.com>
 <20200403112545.6c115ba3@w520.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D80E13D@SHSMSX104.ccr.corp.intel.com>
 <20200407095801.648b1371@w520.home>
 <20200408040021.GS67127@otc-nc-03>
 <20200408101940.3459943d@w520.home>
 <20200413031043.GA18183@araj-mobl1.jf.intel.com>
 <20200413032930.GB18479@araj-mobl1.jf.intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Wu,
 Hao" <hao.wu@intel.com>
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

On Sun, 12 Apr 2020 20:29:31 -0700
"Raj, Ashok" <ashok.raj@intel.com> wrote:

> Hi Alex
> 
> Going through the PCIe Spec, there seems a lot of such capabilities
> that are different between PF and VF. Some that make sense
> and some don't.
> 
> 
> On Sun, Apr 12, 2020 at 08:10:43PM -0700, Raj, Ashok wrote:
> >   
> > > 
> > > I agree though, I don't know why the SIG would preclude implementing
> > > per VF control of these features.  Thanks,
> > >   
> 
> For e.g. 
> 
> VF doesn't have I/O and Mem space enables, but has BME

VFs don't have I/O, so I/O enable is irrelevant.  The memory enable bit
is emulated, so it doesn't really do anything from the VM perspective.
The hypervisor could provide more emulation around this, but it hasn't
proven necessary.

> Interrupt Status

VFs don't have INTx, so this is irrelevant.

> Correctable Error Reporting
> Almost all of Device Control Register.

Are we doing anything to virtualize these for VFs?  I think we've
addressed access control to these for PFs, but I don't see that we try
to virtualize them for the VF.

> So it seems like there is a ton of them we have to deal with today for 
> VF's. How do we manage to emulate them without any support for them 
> in VF's? 

The memory enable bit is just access to the MMIO space of the device,
the hypervisor could choose to do more, but currently emulating the bit
itself is sufficient.  This doesn't really affect the device, just
access to the device.  The device control registers, I don't think
we've had a need to virtualize them yet and I think we'd run into many
of the same questions.  If your point is that there exists gaps in the
spec that make things difficult to virtualize, I won't argue with you
there.  MPS is a nearby one that's difficult to virtualize on the PF
since its setting needs to take entire communication channels into
account.

So far though we aren't inventing new capabilities to add to VF config
space and pretending they work, we're just stumbling on what the VF
exposes whether on bare metal or in a VM.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
