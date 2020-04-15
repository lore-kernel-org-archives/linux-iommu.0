Return-Path: <SRS0=YkH/=57=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6337C352BE
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 01:01:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75A1A2072D
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 01:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A1A2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3387121FF6;
	Wed, 15 Apr 2020 01:01:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aHXGb0e-e7F6; Wed, 15 Apr 2020 01:01:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8087620503;
	Wed, 15 Apr 2020 01:01:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77F11C089E;
	Wed, 15 Apr 2020 01:01:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84FFBC0172
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 01:01:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7B1158598A
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 01:01:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RkshfG1l1Sv8 for <iommu@lists.linux-foundation.org>;
 Wed, 15 Apr 2020 01:01:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3B8058592F
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 01:01:53 +0000 (UTC)
IronPort-SDR: H+pp6q1UP8CmUydyGTD0KHRevIofvjKrU+Tpgpm4sgpcpTPFS6xUFseMQ0CrPsmH1iOC97fU13
 Bd2sZzkv+I9g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2020 18:01:52 -0700
IronPort-SDR: /+xvEisTyLnHW4UMqHi/fNFqhKmCQ1uPOPrlC75ROdYMwn1HbDuxjs5Y3ahzdAYV1BMGl1DMWH
 cOP1BECRvj7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,385,1580803200"; d="scan'208";a="454746459"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga006.fm.intel.com with ESMTP; 14 Apr 2020 18:01:52 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Apr 2020 18:01:52 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Apr 2020 18:01:52 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.209]) with mapi id 14.03.0439.000;
 Wed, 15 Apr 2020 09:01:48 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v1 2/2] vfio/pci: Emulate PASID/PRI capability for VFs
Thread-Topic: [PATCH v1 2/2] vfio/pci: Emulate PASID/PRI capability for VFs
Thread-Index: AQHWAEVGCz5QQWvL/U+nYnlD7MiZ7Khl/jEAgACVNICAAJ/EgIAF8c6ggAA/A4CAAMnRgIAAzpAAgAb/OoCAAMrPQIAAC1kAgAA5CgCAAPxYkP//i8oAgACGwnCAAEEggIABEuCg//+HXACAAIqw4A==
Date: Wed, 15 Apr 2020 01:01:48 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D81FB7D@SHSMSX104.ccr.corp.intel.com>
References: <1584880394-11184-1-git-send-email-yi.l.liu@intel.com>
 <1584880394-11184-3-git-send-email-yi.l.liu@intel.com>
 <20200402165954.48d941ee@w520.home>
 <A2975661238FB949B60364EF0F2C25743A2204FE@SHSMSX104.ccr.corp.intel.com>
 <20200403112545.6c115ba3@w520.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D80E13D@SHSMSX104.ccr.corp.intel.com>
 <20200407095801.648b1371@w520.home>	<20200408040021.GS67127@otc-nc-03>
 <20200408101940.3459943d@w520.home>
 <20200413031043.GA18183@araj-mobl1.jf.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D81A31F@SHSMSX104.ccr.corp.intel.com>
 <20200413132122.46825849@w520.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D81D376@SHSMSX104.ccr.corp.intel.com>
 <20200413212836.117b4c86@x1.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D81D456@SHSMSX104.ccr.corp.intel.com>
 <20200414092401.039edef6@w520.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D81F946@SHSMSX104.ccr.corp.intel.com>
 <20200414183602.7de084b0@x1.home>
In-Reply-To: <20200414183602.7de084b0@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
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

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Wednesday, April 15, 2020 8:36 AM
> 
> On Tue, 14 Apr 2020 23:57:33 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Tuesday, April 14, 2020 11:24 PM
> > >
> > > On Tue, 14 Apr 2020 03:42:42 +0000
> > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > >
> > > > > From: Alex Williamson <alex.williamson@redhat.com>
> > > > > Sent: Tuesday, April 14, 2020 11:29 AM
> > > > >
> > > > > On Tue, 14 Apr 2020 02:40:58 +0000
> > > > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > > > >
> > > > > > > From: Alex Williamson <alex.williamson@redhat.com>
> > > > > > > Sent: Tuesday, April 14, 2020 3:21 AM
> > > > > > >
> > > > > > > On Mon, 13 Apr 2020 08:05:33 +0000
> > > > > > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > > > > > >
> > > > > > > > > From: Tian, Kevin
> > > > > > > > > Sent: Monday, April 13, 2020 3:55 PM
> > > > > > > > >
> > > > > > > > > > From: Raj, Ashok <ashok.raj@linux.intel.com>
> > > > > > > > > > Sent: Monday, April 13, 2020 11:11 AM
> > > > > > > > > >
> > > > > > > > > > On Wed, Apr 08, 2020 at 10:19:40AM -0600, Alex Williamson
> > > wrote:
> > > > > > > > > > > On Tue, 7 Apr 2020 21:00:21 -0700
> > > > > > > > > > > "Raj, Ashok" <ashok.raj@intel.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > > Hi Alex
> > > > > > > > > > > >
> > > > > > > > > > > > + Bjorn
> > > > > > > > > > >
> > > > > > > > > > >  + Don
> > > > > > > > > > >
> > > > > > > > > > > > FWIW I can't understand why PCI SIG went different ways
> > > with
> > > > > ATS,
> > > > > > > > > > > > where its enumerated on PF and VF. But for PASID and
> PRI its
> > > > > only
> > > > > > > > > > > > in PF.
> > > > > > > > > > > >
> > > > > > > > > > > > I'm checking with our internal SIG reps to followup on
> that.
> > > > > > > > > > > >
> > > > > > > > > > > > On Tue, Apr 07, 2020 at 09:58:01AM -0600, Alex
> Williamson
> > > > > wrote:
> > > > > > > > > > > > > > Is there vendor guarantee that hidden registers will
> locate
> > > at
> > > > > the
> > > > > > > > > > > > > > same offset between PF and VF config space?
> > > > > > > > > > > > >
> > > > > > > > > > > > > I'm not sure if the spec really precludes hidden registers,
> > > but
> > > > > the
> > > > > > > > > > > > > fact that these registers are explicitly outside of the
> > > capability
> > > > > > > > > > > > > chain implies they're only intended for device specific
> use,
> > > so
> > > > > I'd
> > > > > > > say
> > > > > > > > > > > > > there are no guarantees about anything related to these
> > > > > registers.
> > > > > > > > > > > >
> > > > > > > > > > > > As you had suggested in the other thread, we could
> consider
> > > > > > > > > > > > using the same offset as in PF, but even that's a better
> guess
> > > > > > > > > > > > still not reliable.
> > > > > > > > > > > >
> > > > > > > > > > > > The other option is to maybe extend driver ops in the PF
> to
> > > > > expose
> > > > > > > > > > > > where the offsets should be. Sort of adding the quirk in
> the
> > > > > > > > > > > > implementation.
> > > > > > > > > > > >
> > > > > > > > > > > > I'm not sure how prevalent are PASID and PRI in VF
> devices. If
> > > > > SIG is
> > > > > > > > > > resisting
> > > > > > > > > > > > making VF's first class citizen, we might ask them to add
> > > some
> > > > > > > verbiage
> > > > > > > > > > > > to suggest leave the same offsets as PF open to help
> > > emulation
> > > > > > > software.
> > > > > > > > > > >
> > > > > > > > > > > Even if we know where to expose these capabilities on the
> VF,
> > > it's
> > > > > not
> > > > > > > > > > > clear to me how we can actually virtualize the capability
> itself.
> > > If
> > > > > > > > > > > the spec defines, for example, an enable bit as r/w then
> > > software
> > > > > that
> > > > > > > > > > > interacts with that register expects the bit is settable.
> There's
> > > no
> > > > > > > > > > > protocol for "try to set the bit and re-read it to see if the
> > > hardware
> > > > > > > > > > > accepted it".  Therefore a capability with a fixed enable bit
> > > > > > > > > > > representing the state of the PF, not settable by the VF, is
> > > > > > > > > > > disingenuous to the spec.
> > > > > > > > > >
> > > > > > > > > > I think we are all in violent agreement. A lot of times the pci
> spec
> > > > > gets
> > > > > > > > > > defined several years ahead of real products and no one
> > > > > remembers
> > > > > > > > > > the justification on why they restricted things the way they
> did.
> > > > > > > > > >
> > > > > > > > > > Maybe someone early product wasn't quite exposing these
> > > features
> > > > > to
> > > > > > > the
> > > > > > > > > > VF
> > > > > > > > > > and hence the spec is bug compatible :-)
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > If what we're trying to do is expose that PASID and PRI are
> > > enabled
> > > > > on
> > > > > > > > > > > the PF to a VF driver, maybe duplicating the PF capabilities
> on
> > > the
> > > > > VF
> > > > > > > > > > > without the ability to control it is not the right approach.
> > > Maybe
> > > > > we
> > > > > > > > > >
> > > > > > > > > > As long as the capability enable is only provided when the PF
> has
> > > > > > > enabled
> > > > > > > > > > the feature. Then it seems the hardware seems to do the
> right
> > > thing.
> > > > > > > > > >
> > > > > > > > > > Assume we expose PASID/PRI only when PF has enabled it. It
> will
> > > be
> > > > > the
> > > > > > > > > > case since the PF driver needs to exist, and IOMMU would
> have
> > > set
> > > > > the
> > > > > > > > > > PASID/PRI/ATS on PF.
> > > > > > > > > >
> > > > > > > > > > If the emulation is purely spoofing the capability. Once
> vIOMMU
> > > > > driver
> > > > > > > > > > enables PASID, the context entries for the VF are completely
> > > > > > > independent
> > > > > > > > > > from the PF context entries.
> > > > > > > > > >
> > > > > > > > > > vIOMMU would enable PASID, and we just spoof the PASID
> > > > > capability.
> > > > > > > > > >
> > > > > > > > > > If vIOMMU or guest for some reason does disable_pasid(),
> then
> > > the
> > > > > > > > > > vIOMMU driver can disaable PASID on the VF context entries.
> So
> > > the
> > > > > VF
> > > > > > > > > > although the capability is blanket enabled on PF, IOMMU
> > > gaurantees
> > > > > > > the
> > > > > > > > > > transactions are blocked.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > In the interim, it seems like the intent of the virtual capability
> > > > > > > > > > can be honored via help from the IOMMU for the controlling
> > > aspect..
> > > > > > > > > >
> > > > > > > > > > Did i miss anything?
> > > > > > > > >
> > > > > > > > > Above works for emulating the enable bit (under the
> assumption
> > > that
> > > > > > > > > PF driver won't disable pasid when vf is assigned). However,
> there
> > > are
> > > > > > > > > also "Execute permission enable" and "Privileged mode
> enable"
> > > bits in
> > > > > > > > > PASID control registers. I don't know how those bits could be
> > > cleanly
> > > > > > > > > emulated when the guest writes a value different from PF's...
> > > > > > > >
> > > > > > > > sent too quick. the IOMMU also includes control bits for
> allowing/
> > > > > > > > blocking execute requests and supervisor requests. We can rely
> on
> > > > > > > > IOMMU to block those requests to emulate the disabled cases of
> > > > > > > > all three control bits in the pasid cap.
> > > > > > >
> > > > > > >
> > > > > > > So if the emulation of the PASID capability takes into account the
> > > > > > > IOMMU configuration to back that emulation, shouldn't we do
> that
> > > > > > > emulation in the hypervisor, ie. QEMU, rather than the kernel vfio
> > > > > > > layer?  Thanks,
> > > > > > >
> > > > > > > Alex
> > > > > >
> > > > > > We need enforce it in physical IOMMU, to ensure that even the
> > > > > > VF may send requests which violate the guest expectation those
> > > > > > requests are always blocked by IOMMU. Kernel vfio identifies
> > > > > > such need when emulating the pasid cap and then forward the
> > > > > > request to host iommu driver.
> > > > >
> > > > > Implementing this in the kernel would be necessary if we needed to
> > > > > protect from the guest device doing something bad to the host or
> > > > > other devices.  Making sure the physical IOMMU is configured to meet
> > > > > guest expectations doesn't sound like it necessarily falls into that
> > > > > category.  We do that on a regular basis to program the DMA
> mappings.
> > > > > Tell me more about why the hypervisor can't handle this piece of
> > > > > guest/host synchronization on top of all the other things it
> > > > > synchronizes to make a VM.  Thanks,
> > > > >
> > > >
> > > > I care more about "execution permission" and "privileged mode".
> > > > It might be dangerous when the guest disallows the VF from sending
> > >
> > > "Dangerous" how?  We're generally ok with the user managing their own
> > > consistency, it's when the user can affect other users/devices that we
> > > require vfio in the kernel to actively manage something.  There's a very
> > > different scope to the vfio-pci kernel module implementing a fake
> > > capability and trying to make it behave indistinguishably from the real
> > > capability versus a userspace driver piecing together an emulation
> > > that's good enough for their purposes.  Thanks,
> > >
> >
> > How could emulation fix this gap when the VF DMAs don't go through
> > the vIOMMU? What you explained all makes sense before talking about
> > the emulation of PASID capability, i.e. vfio only cares about isolation
> > between assigned devices. However now vfio exposes a capability
> > which is shared by PF/VF while pure software emulation may break
> > the guest expectation, and now the only viable mitigation is to get
> > the help from physical IOMMU. then why cannot vfio include such
> > mitigation in its emulation of the PASID capability?
> 
> DMA never actually goes "through" the vIOMMU.  I'm not suggesting that
> vfio doesn't participate some how, but I don't know that emulating a
> capability that doesn't exist and involves policy should be done in the
> kernel, versus providing userspace with an interface to control what
> they need to implement that emulation.  Thanks,
> 

OK, I see your point. We'll think about the latter option (e.g. through 
DEVICE_FEATURE) and put a proposal for further discussion.

btw as I commented earlier, let's focus on PF first to enable vSVA 
given that there are already many flying bits. After that we can then
extend the vSVA support to VF based on discussions in this thread.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
