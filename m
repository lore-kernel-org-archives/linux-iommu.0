Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B731C2D0EA
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 16:19:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6D1820784
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 16:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPn1gW1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D1820784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8608122610;
	Wed,  8 Apr 2020 16:19:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id faMLEpxCJp2h; Wed,  8 Apr 2020 16:19:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0493A204E9;
	Wed,  8 Apr 2020 16:19:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E586AC1D7E;
	Wed,  8 Apr 2020 16:19:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14F37C0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 16:19:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0C1AD882AD
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 16:19:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3aItZVdH213m for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 16:19:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EE155882A7
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 16:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586362791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kCxevzibCCjQEpgBkSWFcYxtyHB47IcQu6B4P94oXGg=;
 b=LPn1gW1HjxRwzG5nPOTpBsY6XXNDPo5wTdUu2NUwbBdpCkp25Vfemxq8X4bDltLXruX6Ls
 To/qY0FzhODC4XM7qNq2xmhErc/AGG8KImzx9re8u24EF4/AYfk7q35IUotaYZG4RqOHhK
 XlyLOhKws6FoeF+wx9YyGTsUeUw0QnM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-Fa7EIChmMjmVgdJqDf3j1A-1; Wed, 08 Apr 2020 12:19:49 -0400
X-MC-Unique: Fa7EIChmMjmVgdJqDf3j1A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1246801E53;
 Wed,  8 Apr 2020 16:19:47 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A90B5C1C6;
 Wed,  8 Apr 2020 16:19:41 +0000 (UTC)
Date: Wed, 8 Apr 2020 10:19:40 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH v1 2/2] vfio/pci: Emulate PASID/PRI capability for VFs
Message-ID: <20200408101940.3459943d@w520.home>
In-Reply-To: <20200408040021.GS67127@otc-nc-03>
References: <1584880394-11184-1-git-send-email-yi.l.liu@intel.com>
 <1584880394-11184-3-git-send-email-yi.l.liu@intel.com>
 <20200402165954.48d941ee@w520.home>
 <A2975661238FB949B60364EF0F2C25743A2204FE@SHSMSX104.ccr.corp.intel.com>
 <20200403112545.6c115ba3@w520.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D80E13D@SHSMSX104.ccr.corp.intel.com>
 <20200407095801.648b1371@w520.home>
 <20200408040021.GS67127@otc-nc-03>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Wu,
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

On Tue, 7 Apr 2020 21:00:21 -0700
"Raj, Ashok" <ashok.raj@intel.com> wrote:

> Hi Alex
> 
> + Bjorn

 + Don

> FWIW I can't understand why PCI SIG went different ways with ATS, 
> where its enumerated on PF and VF. But for PASID and PRI its only
> in PF. 
> 
> I'm checking with our internal SIG reps to followup on that.
> 
> On Tue, Apr 07, 2020 at 09:58:01AM -0600, Alex Williamson wrote:
> > > Is there vendor guarantee that hidden registers will locate at the
> > > same offset between PF and VF config space?   
> > 
> > I'm not sure if the spec really precludes hidden registers, but the
> > fact that these registers are explicitly outside of the capability
> > chain implies they're only intended for device specific use, so I'd say
> > there are no guarantees about anything related to these registers.  
> 
> As you had suggested in the other thread, we could consider
> using the same offset as in PF, but even that's a better guess
> still not reliable.
> 
> The other option is to maybe extend driver ops in the PF to expose
> where the offsets should be. Sort of adding the quirk in the 
> implementation. 
> 
> I'm not sure how prevalent are PASID and PRI in VF devices. If SIG is resisting 
> making VF's first class citizen, we might ask them to add some verbiage
> to suggest leave the same offsets as PF open to help emulation software.

Even if we know where to expose these capabilities on the VF, it's not
clear to me how we can actually virtualize the capability itself.  If
the spec defines, for example, an enable bit as r/w then software that
interacts with that register expects the bit is settable.  There's no
protocol for "try to set the bit and re-read it to see if the hardware
accepted it".  Therefore a capability with a fixed enable bit
representing the state of the PF, not settable by the VF, is
disingenuous to the spec.

If what we're trying to do is expose that PASID and PRI are enabled on
the PF to a VF driver, maybe duplicating the PF capabilities on the VF
without the ability to control it is not the right approach.  Maybe we
need new capabilities exposing these as slave features that cannot be
controlled?  We could define our own vendor capability for this, but of
course we have both the where to put it in config space issue, as well
as the issue of trying to push an ad-hoc standard.  vfio could expose
these as device features rather than emulating capabilities, but that
still leaves a big gap between vfio in the hypervisor and the driver in
the guest VM.  That might still help push the responsibility and policy
for how to expose it to the VM as a userspace problem though.

I agree though, I don't know why the SIG would preclude implementing
per VF control of these features.  Thanks,

Alex

> > FWIW, vfio started out being more strict about restricting config space
> > access to defined capabilities, until...
> > 
> > commit a7d1ea1c11b33bda2691f3294b4d735ed635535a
> > Author: Alex Williamson <alex.williamson@redhat.com>
> > Date:   Mon Apr 1 09:04:12 2013 -0600
> >   
> 
> Cheers,
> Ashok
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
