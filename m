Return-Path: <SRS0=p9ZB=5X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80632C2BB85
	for <iommu@archiver.kernel.org>; Tue,  7 Apr 2020 15:58:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B97D2072A
	for <iommu@archiver.kernel.org>; Tue,  7 Apr 2020 15:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWgvSDk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B97D2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 10A2181F72;
	Tue,  7 Apr 2020 15:58:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NNLvyyhoZW6J; Tue,  7 Apr 2020 15:58:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4F11E81EE4;
	Tue,  7 Apr 2020 15:58:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3465EC1D7E;
	Tue,  7 Apr 2020 15:58:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42949C0177
 for <iommu@lists.linux-foundation.org>; Tue,  7 Apr 2020 15:58:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3964820025
 for <iommu@lists.linux-foundation.org>; Tue,  7 Apr 2020 15:58:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nLV3nrKWIL4B for <iommu@lists.linux-foundation.org>;
 Tue,  7 Apr 2020 15:58:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by silver.osuosl.org (Postfix) with ESMTPS id BA2DE20020
 for <iommu@lists.linux-foundation.org>; Tue,  7 Apr 2020 15:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586275097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yUYJ5bzo+BJgODaE1JfQ2ZwXtILNlfRLeWjodd722hM=;
 b=PWgvSDk9ZXCdS3Hbat9XLgBKjYM8+Pb6ZDRYMUsXnUj0MeyTsEQRv7PN7NcBovu96pTlZN
 OP241h5EgWR2tI3VlUarX9hopys0jRJ04ntTcHYtUGlC7bDpD7QbrD0HLid7GVveCtEB47
 qo4+kGchFNqV1hqFaGbK4liw+Ng3rHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-dKrGDez7O2ilzpapPbNMew-1; Tue, 07 Apr 2020 11:58:12 -0400
X-MC-Unique: dKrGDez7O2ilzpapPbNMew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9A78DB61;
 Tue,  7 Apr 2020 15:58:10 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EC4560BEC;
 Tue,  7 Apr 2020 15:58:02 +0000 (UTC)
Date: Tue, 7 Apr 2020 09:58:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v1 2/2] vfio/pci: Emulate PASID/PRI capability for VFs
Message-ID: <20200407095801.648b1371@w520.home>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D80E13D@SHSMSX104.ccr.corp.intel.com>
References: <1584880394-11184-1-git-send-email-yi.l.liu@intel.com>
 <1584880394-11184-3-git-send-email-yi.l.liu@intel.com>
 <20200402165954.48d941ee@w520.home>
 <A2975661238FB949B60364EF0F2C25743A2204FE@SHSMSX104.ccr.corp.intel.com>
 <20200403112545.6c115ba3@w520.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D80E13D@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun, 
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

On Tue, 7 Apr 2020 04:26:23 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Saturday, April 4, 2020 1:26 AM  
> [...]
> > > > > +	if (!pasid_cap.control_reg.paside) {
> > > > > +		pr_debug("%s: its PF's PASID capability is not enabled\n",
> > > > > +			dev_name(&vdev->pdev->dev));
> > > > > +		ret = 0;
> > > > > +		goto out;
> > > > > +	}  
> > > >
> > > > What happens if the PF's PASID gets disabled while we're using it??  
> > >
> > > This is actually the open I highlighted in cover letter. Per the reply
> > > from Baolu, this seems to be an open for bare-metal all the same.
> > > https://lkml.org/lkml/2020/3/31/95  
> > 
> > Seems that needs to get sorted out before we can expose this.  Maybe
> > some sort of registration with the PF driver that PASID is being used
> > by a VF so it cannot be disabled?  
> 
> I guess we may do vSVA for PF first, and then adding VF vSVA later
> given above additional need. It's not necessarily to enable both
> in one step.
> 
> [...]
> > > > > @@ -1604,6 +1901,18 @@ static int vfio_ecap_init(struct  
> > vfio_pci_device *vdev)  
> > > > >  	if (!ecaps)
> > > > >  		*(u32 *)&vdev->vconfig[PCI_CFG_SPACE_SIZE] = 0;
> > > > >
> > > > > +#ifdef CONFIG_PCI_ATS
> > > > > +	if (pdev->is_virtfn) {
> > > > > +		struct pci_dev *physfn = pdev->physfn;
> > > > > +
> > > > > +		ret = vfio_pci_add_emulated_cap_for_vf(vdev,
> > > > > +					physfn, epos_max, prev);
> > > > > +		if (ret)
> > > > > +			pr_info("%s, failed to add special caps for VF %s\n",
> > > > > +				__func__, dev_name(&vdev->pdev->dev));
> > > > > +	}
> > > > > +#endif  
> > > >
> > > > I can only imagine that we should place the caps at the same location
> > > > they exist on the PF, we don't know what hidden registers might be
> > > > hiding in config space.  
> 
> Is there vendor guarantee that hidden registers will locate at the
> same offset between PF and VF config space? 

I'm not sure if the spec really precludes hidden registers, but the
fact that these registers are explicitly outside of the capability
chain implies they're only intended for device specific use, so I'd say
there are no guarantees about anything related to these registers.

FWIW, vfio started out being more strict about restricting config space
access to defined capabilities, until...

commit a7d1ea1c11b33bda2691f3294b4d735ed635535a
Author: Alex Williamson <alex.williamson@redhat.com>
Date:   Mon Apr 1 09:04:12 2013 -0600

    vfio-pci: Enable raw access to unassigned config space
    
    Devices like be2net hide registers between the gaps in capabilities
    and architected regions of PCI config space.  Our choices to support
    such devices is to either build an ever growing and unmanageable white
    list or rely on hardware isolation to protect us.  These registers are
    really no different than MMIO or I/O port space registers, which we
    don't attempt to regulate, so treat PCI config space in the same way.

> > > but we are not sure whether the same location is available on VF. In
> > > this patch, it actually places the emulated cap physically behind the
> > > cap which lays farthest (its offset is largest) within VF's config space
> > > as the PCIe caps are linked in a chain.  
> > 
> > But, as we've found on Broadcom NICs (iirc), hardware developers have a
> > nasty habit of hiding random registers in PCI config space, outside of
> > defined capabilities.  I feel like IGD might even do this too, is that
> > true?  So I don't think we can guarantee that just because a section of
> > config space isn't part of a defined capability that its unused.  It
> > only means that it's unused by common code, but it might have device
> > specific purposes.  So of the PCIe spec indicates that VFs cannot
> > include these capabilities and virtialization software needs to
> > emulate them, we need somewhere safe to place them in config space, and
> > simply placing them off the end of known capabilities doesn't give me
> > any confidence.  Also, hardware has no requirement to make compact use
> > of extended config space.  The first capability must be at 0x100, the
> > very next capability could consume all the way to the last byte of the
> > 4K extended range, and the next link in the chain could be somewhere in
> > the middle.  Thanks,
> >   
> 
> Then what would be a viable option? Vendor nasty habit implies
> no standard, thus I don't see how VFIO can find a safe location
> by itself. Also curious how those hidden registers are identified
> by VFIO and employed with proper r/w policy today. If sort of quirks
> are used, then could such quirk way be extended to also carry
> the information about vendor specific safe location? When no
> such quirk info is provided (the majority case), VFIO then finds
> out a free location to carry the new cap.

See above commit, rather than quirks we allow raw access to any config
space outside of the capability chain.  My preference for trying to
place virtual capabilities at the same offset as the capability exists
on the PF is my impression that the PF config space is often a template
for the VF config space.  The PF and VF are clearly not independent
devices, they share design aspects, and sometimes drivers.  Therefore
if I was a lazy engineer trying to find a place to hide a register in
config space (and ignoring vendor capabilities*), I'd probably put it
in the same place on both devices.  Thus if we maintain the same
capability footprint as the PF, we have a better chance of avoiding
them.  It's a gamble and maybe we're overthinking it, but this has
always been a concern when adding virtual capabilities to a physical
device.  We can always fail over to an approach where we simply find
free space.  Thanks,

Alex

* ISTR the Broadcom device implemented the hidden register in standard
  config space, which was otherwise entirely packed, ie. there was no
  room for the register to be implemented as a vendor cap.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
