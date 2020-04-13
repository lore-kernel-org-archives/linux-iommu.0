Return-Path: <SRS0=l6pd=55=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB174C2BB1D
	for <iommu@archiver.kernel.org>; Mon, 13 Apr 2020 19:21:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8823720692
	for <iommu@archiver.kernel.org>; Mon, 13 Apr 2020 19:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClOx7UaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8823720692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 33D1D859C0;
	Mon, 13 Apr 2020 19:21:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MfQLe+eVcQyN; Mon, 13 Apr 2020 19:21:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4567A87001;
	Mon, 13 Apr 2020 19:21:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C80CC1797;
	Mon, 13 Apr 2020 19:21:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 612F9C0172
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 19:21:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4906087111
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 19:21:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xOmqb7b4QChg for <iommu@lists.linux-foundation.org>;
 Mon, 13 Apr 2020 19:21:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 06F4987001
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 19:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586805690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0H8keLbK3mVuVJkIOBQFVsta0mAjsJgEGaVcL/0Dlk=;
 b=ClOx7UaXyVV9+GzOv4fXPpkTlesMDwf+ZsGl5L75yJ6OjiOy5zMzKGOW8QQrQ6bxzVVYtH
 KEiBxrBKsZCCgvh5LgArw7zI1i8zPOyHX3QdLQBqQV2ul7xlRpwubrd+eukxCIHqipNKjp
 vvLK2gdlOGwxWLzyLS8pdx/r4eB8nSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-X1wh1-omOiexprTuWWlTEQ-1; Mon, 13 Apr 2020 15:21:25 -0400
X-MC-Unique: X1wh1-omOiexprTuWWlTEQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F3951937FC1;
 Mon, 13 Apr 2020 19:21:24 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 151345C64F;
 Mon, 13 Apr 2020 19:21:23 +0000 (UTC)
Date: Mon, 13 Apr 2020 13:21:22 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v1 2/2] vfio/pci: Emulate PASID/PRI capability for VFs
Message-ID: <20200413132122.46825849@w520.home>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D81A31F@SHSMSX104.ccr.corp.intel.com>
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
 <AADFC41AFE54684AB9EE6CBC0274A5D19D81A31F@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Bjorn
 Helgaas <bhelgaas@google.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Wu,
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

On Mon, 13 Apr 2020 08:05:33 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Tian, Kevin
> > Sent: Monday, April 13, 2020 3:55 PM
> >   
> > > From: Raj, Ashok <ashok.raj@linux.intel.com>
> > > Sent: Monday, April 13, 2020 11:11 AM
> > >
> > > On Wed, Apr 08, 2020 at 10:19:40AM -0600, Alex Williamson wrote:  
> > > > On Tue, 7 Apr 2020 21:00:21 -0700
> > > > "Raj, Ashok" <ashok.raj@intel.com> wrote:
> > > >  
> > > > > Hi Alex
> > > > >
> > > > > + Bjorn  
> > > >
> > > >  + Don
> > > >  
> > > > > FWIW I can't understand why PCI SIG went different ways with ATS,
> > > > > where its enumerated on PF and VF. But for PASID and PRI its only
> > > > > in PF.
> > > > >
> > > > > I'm checking with our internal SIG reps to followup on that.
> > > > >
> > > > > On Tue, Apr 07, 2020 at 09:58:01AM -0600, Alex Williamson wrote:  
> > > > > > > Is there vendor guarantee that hidden registers will locate at the
> > > > > > > same offset between PF and VF config space?  
> > > > > >
> > > > > > I'm not sure if the spec really precludes hidden registers, but the
> > > > > > fact that these registers are explicitly outside of the capability
> > > > > > chain implies they're only intended for device specific use, so I'd say
> > > > > > there are no guarantees about anything related to these registers.  
> > > > >
> > > > > As you had suggested in the other thread, we could consider
> > > > > using the same offset as in PF, but even that's a better guess
> > > > > still not reliable.
> > > > >
> > > > > The other option is to maybe extend driver ops in the PF to expose
> > > > > where the offsets should be. Sort of adding the quirk in the
> > > > > implementation.
> > > > >
> > > > > I'm not sure how prevalent are PASID and PRI in VF devices. If SIG is  
> > > resisting  
> > > > > making VF's first class citizen, we might ask them to add some verbiage
> > > > > to suggest leave the same offsets as PF open to help emulation software.  
> > > >
> > > > Even if we know where to expose these capabilities on the VF, it's not
> > > > clear to me how we can actually virtualize the capability itself.  If
> > > > the spec defines, for example, an enable bit as r/w then software that
> > > > interacts with that register expects the bit is settable.  There's no
> > > > protocol for "try to set the bit and re-read it to see if the hardware
> > > > accepted it".  Therefore a capability with a fixed enable bit
> > > > representing the state of the PF, not settable by the VF, is
> > > > disingenuous to the spec.  
> > >
> > > I think we are all in violent agreement. A lot of times the pci spec gets
> > > defined several years ahead of real products and no one remembers
> > > the justification on why they restricted things the way they did.
> > >
> > > Maybe someone early product wasn't quite exposing these features to the
> > > VF
> > > and hence the spec is bug compatible :-)
> > >  
> > > >
> > > > If what we're trying to do is expose that PASID and PRI are enabled on
> > > > the PF to a VF driver, maybe duplicating the PF capabilities on the VF
> > > > without the ability to control it is not the right approach.  Maybe we  
> > >
> > > As long as the capability enable is only provided when the PF has enabled
> > > the feature. Then it seems the hardware seems to do the right thing.
> > >
> > > Assume we expose PASID/PRI only when PF has enabled it. It will be the
> > > case since the PF driver needs to exist, and IOMMU would have set the
> > > PASID/PRI/ATS on PF.
> > >
> > > If the emulation is purely spoofing the capability. Once vIOMMU driver
> > > enables PASID, the context entries for the VF are completely independent
> > > from the PF context entries.
> > >
> > > vIOMMU would enable PASID, and we just spoof the PASID capability.
> > >
> > > If vIOMMU or guest for some reason does disable_pasid(), then the
> > > vIOMMU driver can disaable PASID on the VF context entries. So the VF
> > > although the capability is blanket enabled on PF, IOMMU gaurantees the
> > > transactions are blocked.
> > >
> > >
> > > In the interim, it seems like the intent of the virtual capability
> > > can be honored via help from the IOMMU for the controlling aspect..
> > >
> > > Did i miss anything?  
> > 
> > Above works for emulating the enable bit (under the assumption that
> > PF driver won't disable pasid when vf is assigned). However, there are
> > also "Execute permission enable" and "Privileged mode enable" bits in
> > PASID control registers. I don't know how those bits could be cleanly
> > emulated when the guest writes a value different from PF's...  
> 
> sent too quick. the IOMMU also includes control bits for allowing/
> blocking execute requests and supervisor requests. We can rely on 
> IOMMU to block those requests to emulate the disabled cases of
> all three control bits in the pasid cap.


So if the emulation of the PASID capability takes into account the
IOMMU configuration to back that emulation, shouldn't we do that
emulation in the hypervisor, ie. QEMU, rather than the kernel vfio
layer?  Thanks,

Alex 

> > Similar problem also exists when talking about PRI emulation, e.g.
> > to enable PRI the software usually waits until the 'stopped' bit
> > is set (indicating all previously issued requests have completed). How
> > to emulate this bit accurately when one guest toggles the enable bit
> > while the PF and other VFs are actively issuing page requests through
> > the shared page request interface? from pcie spec I didn't find a way
> > to catch when all previously-issued requests from a specific VF have
> > completed. Can a conservative big-enough timeout value help here?
> > I don't know... similar puzzle also exists for emulating the 'reset'
> > control bit which is supposed to clear the pending request state for
> > the whole page request interface.
> > 
> > I feel the main problem in pcie spec is that, while they invent SR-IOV
> > to address I/O virtualization requirement (where strict isolation is
> > required), they blurred the boundary by leaving some shared resource
> > cross PF and VFs which imply sort of cooperation between PF and VF
> > drivers. On bare metal such cooperation is easy to build, by enabling/
> > disabling a capability en mass, by using the same set of setting, etc.
> > However it doesn't consider the virtualization case where a VF is
> > assigned to the guest which considers the VF as a standard PCI/PCIe
> > endpoint thus such cooperation is missing. A vendor capability could
> > help fix the gap here but making it adopted by major guest OSes will
> > take time. But honestly speaking I don't know other good alternative
> > now... :/
> >   
> > >  
> > > > need new capabilities exposing these as slave features that cannot be
> > > > controlled?  We could define our own vendor capability for this, but of
> > > > course we have both the where to put it in config space issue, as well
> > > > as the issue of trying to push an ad-hoc standard.  vfio could expose
> > > > these as device features rather than emulating capabilities, but that
> > > > still leaves a big gap between vfio in the hypervisor and the driver in
> > > > the guest VM.  That might still help push the responsibility and policy
> > > > for how to expose it to the VM as a userspace problem though.  
> > >
> > > I think this is a good long term solution, but if the vIOMMU implenentations
> > > can carry us for the time being, we can probably defer them unless
> > > we are stuck.
> > >  
> > > >
> > > > I agree though, I don't know why the SIG would preclude implementing
> > > > per VF control of these features.  Thanks,
> > > >  
> > >
> > > Cheers,
> > > Ashok  
> > 
> > Thanks
> > Kevin  
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
