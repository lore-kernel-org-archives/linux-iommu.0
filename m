Return-Path: <SRS0=l6pd=55=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575AAC2BB85
	for <iommu@archiver.kernel.org>; Mon, 13 Apr 2020 03:10:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 238D620678
	for <iommu@archiver.kernel.org>; Mon, 13 Apr 2020 03:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238D620678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EFE8884FFF;
	Mon, 13 Apr 2020 03:10:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IiTM7WSZ42XS; Mon, 13 Apr 2020 03:10:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 233C584A92;
	Mon, 13 Apr 2020 03:10:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12D87C1D7D;
	Mon, 13 Apr 2020 03:10:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E7A4C0172
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 03:10:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 81F3020010
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 03:10:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r4xIueu+MseE for <iommu@lists.linux-foundation.org>;
 Mon, 13 Apr 2020 03:10:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by silver.osuosl.org (Postfix) with ESMTPS id C97ED1FF98
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 03:10:47 +0000 (UTC)
IronPort-SDR: 4iUG+ecFmCbTwKItR2er9qdelL6EUfQISCsMkTo9ZGom6gcvcBxdXplyCCadbN2i5KQyTlhhrM
 DZ8aIFVem/uQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2020 20:10:46 -0700
IronPort-SDR: X4MPwuF9i86nDYyxkd58AVJS6C0MtVzVwtfwzSZA07B1eyXHmQ/3nWj3eREjzKxRZ0o2YeJ2g5
 uneGmWVHiayA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,377,1580803200"; d="scan'208";a="256053141"
Received: from araj-mobl1.jf.intel.com ([10.255.32.166])
 by orsmga006.jf.intel.com with ESMTP; 12 Apr 2020 20:10:44 -0700
Date: Sun, 12 Apr 2020 20:10:43 -0700
From: "Raj, Ashok" <ashok.raj@linux.intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v1 2/2] vfio/pci: Emulate PASID/PRI capability for VFs
Message-ID: <20200413031043.GA18183@araj-mobl1.jf.intel.com>
References: <1584880394-11184-1-git-send-email-yi.l.liu@intel.com>
 <1584880394-11184-3-git-send-email-yi.l.liu@intel.com>
 <20200402165954.48d941ee@w520.home>
 <A2975661238FB949B60364EF0F2C25743A2204FE@SHSMSX104.ccr.corp.intel.com>
 <20200403112545.6c115ba3@w520.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D80E13D@SHSMSX104.ccr.corp.intel.com>
 <20200407095801.648b1371@w520.home>
 <20200408040021.GS67127@otc-nc-03>
 <20200408101940.3459943d@w520.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200408101940.3459943d@w520.home>
User-Agent: Mutt/1.9.1 (2017-09-22)
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
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

On Wed, Apr 08, 2020 at 10:19:40AM -0600, Alex Williamson wrote:
> On Tue, 7 Apr 2020 21:00:21 -0700
> "Raj, Ashok" <ashok.raj@intel.com> wrote:
> 
> > Hi Alex
> > 
> > + Bjorn
> 
>  + Don
> 
> > FWIW I can't understand why PCI SIG went different ways with ATS, 
> > where its enumerated on PF and VF. But for PASID and PRI its only
> > in PF. 
> > 
> > I'm checking with our internal SIG reps to followup on that.
> > 
> > On Tue, Apr 07, 2020 at 09:58:01AM -0600, Alex Williamson wrote:
> > > > Is there vendor guarantee that hidden registers will locate at the
> > > > same offset between PF and VF config space?   
> > > 
> > > I'm not sure if the spec really precludes hidden registers, but the
> > > fact that these registers are explicitly outside of the capability
> > > chain implies they're only intended for device specific use, so I'd say
> > > there are no guarantees about anything related to these registers.  
> > 
> > As you had suggested in the other thread, we could consider
> > using the same offset as in PF, but even that's a better guess
> > still not reliable.
> > 
> > The other option is to maybe extend driver ops in the PF to expose
> > where the offsets should be. Sort of adding the quirk in the 
> > implementation. 
> > 
> > I'm not sure how prevalent are PASID and PRI in VF devices. If SIG is resisting 
> > making VF's first class citizen, we might ask them to add some verbiage
> > to suggest leave the same offsets as PF open to help emulation software.
> 
> Even if we know where to expose these capabilities on the VF, it's not
> clear to me how we can actually virtualize the capability itself.  If
> the spec defines, for example, an enable bit as r/w then software that
> interacts with that register expects the bit is settable.  There's no
> protocol for "try to set the bit and re-read it to see if the hardware
> accepted it".  Therefore a capability with a fixed enable bit
> representing the state of the PF, not settable by the VF, is
> disingenuous to the spec.

I think we are all in violent agreement. A lot of times the pci spec gets
defined several years ahead of real products and no one remembers
the justification on why they restricted things the way they did.

Maybe someone early product wasn't quite exposing these features to the VF
and hence the spec is bug compatible :-)

> 
> If what we're trying to do is expose that PASID and PRI are enabled on
> the PF to a VF driver, maybe duplicating the PF capabilities on the VF
> without the ability to control it is not the right approach.  Maybe we

As long as the capability enable is only provided when the PF has enabled
the feature. Then it seems the hardware seems to do the right thing.

Assume we expose PASID/PRI only when PF has enabled it. It will be the
case since the PF driver needs to exist, and IOMMU would have set the 
PASID/PRI/ATS on PF.

If the emulation is purely spoofing the capability. Once vIOMMU driver
enables PASID, the context entries for the VF are completely independent
from the PF context entries. 

vIOMMU would enable PASID, and we just spoof the PASID capability.

If vIOMMU or guest for some reason does disable_pasid(), then the 
vIOMMU driver can disaable PASID on the VF context entries. So the VF
although the capability is blanket enabled on PF, IOMMU gaurantees the
transactions are blocked.


In the interim, it seems like the intent of the virtual capability
can be honored via help from the IOMMU for the controlling aspect.. 

Did i miss anything? 

> need new capabilities exposing these as slave features that cannot be
> controlled?  We could define our own vendor capability for this, but of
> course we have both the where to put it in config space issue, as well
> as the issue of trying to push an ad-hoc standard.  vfio could expose
> these as device features rather than emulating capabilities, but that
> still leaves a big gap between vfio in the hypervisor and the driver in
> the guest VM.  That might still help push the responsibility and policy
> for how to expose it to the VM as a userspace problem though.

I think this is a good long term solution, but if the vIOMMU implenentations
can carry us for the time being, we can probably defer them unless
we are stuck.

> 
> I agree though, I don't know why the SIG would preclude implementing
> per VF control of these features.  Thanks,
> 

Cheers,
Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
