Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C658CC47096
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 20:55:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CEB2613F1
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 20:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CEB2613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0839840584;
	Thu,  3 Jun 2021 20:55:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Sci0oAVfTko; Thu,  3 Jun 2021 20:55:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id D3CA1400DE;
	Thu,  3 Jun 2021 20:55:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B62B0C000D;
	Thu,  3 Jun 2021 20:55:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CF94C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 20:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A83F834F4
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 20:55:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ya7OX8kXTt4Y for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 20:55:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B66F7834B9
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 20:55:37 +0000 (UTC)
IronPort-SDR: hfGL5IgVVj41PZ+KfTlNGbFkUXlaL3euKsiJU8JnxHeyGfVkWS/s6LrB+BUemEhnvM23tf7sXn
 xcN4OGkiKOQA==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="202292556"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; d="scan'208";a="202292556"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2021 13:55:32 -0700
IronPort-SDR: MjfM7yT9NG79x395JzZW/keo/oszVCbdecgt/yty7PosWCm9vajnPWokqPWAK11mHE//JujYHK
 b3hP56vtGhcA==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; d="scan'208";a="550306458"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2021 13:55:30 -0700
Date: Thu, 3 Jun 2021 13:58:07 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210603135807.40684468@jacob-builder>
In-Reply-To: <PH0PR12MB54811863B392C644E5365446DC3E9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <PH0PR12MB54811863B392C644E5365446DC3E9@PH0PR12MB5481.namprd12.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>, Jason Gunthorpe <jgg@nvidia.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>
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

Hi Parav,

On Tue, 1 Jun 2021 17:30:51 +0000, Parav Pandit <parav@nvidia.com> wrote:

> > From: Tian, Kevin <kevin.tian@intel.com>
> > Sent: Thursday, May 27, 2021 1:28 PM  
> 
> > 5.6. I/O page fault
> > +++++++++++++++
> > 
> > (uAPI is TBD. Here is just about the high-level flow from host IOMMU
> > driver to guest IOMMU driver and backwards).
> > 
> > -   Host IOMMU driver receives a page request with raw fault_data {rid,
> >     pasid, addr};
> > 
> > -   Host IOMMU driver identifies the faulting I/O page table according
> > to information registered by IOASID fault handler;
> > 
> > -   IOASID fault handler is called with raw fault_data (rid, pasid,
> > addr), which is saved in ioasid_data->fault_data (used for response);
> > 
> > -   IOASID fault handler generates an user fault_data (ioasid, addr),
> > links it to the shared ring buffer and triggers eventfd to userspace;
> > 
> > -   Upon received event, Qemu needs to find the virtual routing
> > information (v_rid + v_pasid) of the device attached to the faulting
> > ioasid. If there are multiple, pick a random one. This should be fine
> > since the purpose is to fix the I/O page table on the guest;
> > 
> > -   Qemu generates a virtual I/O page fault through vIOMMU into guest,
> >     carrying the virtual fault data (v_rid, v_pasid, addr);
> >   
> Why does it have to be through vIOMMU?
I think this flow is for fully emulated IOMMU, the same IOMMU and device
drivers run in the host and guest. Page request interrupt is reported by
the IOMMU, thus reporting to vIOMMU in the guest.

> For a VFIO PCI device, have you considered to reuse the same PRI
> interface to inject page fault in the guest? This eliminates any new
> v_rid. It will also route the page fault request and response through the
> right vfio device.
> 
I am curious how would PCI PRI can be used to inject fault. Are you talking
about PCI config PRI extended capability structure? The control is very
limited, only enable and reset. Can you explain how would page fault
handled in generic PCI cap?
Some devices may have device specific way to handle page faults, but I
guess this is not the PCI PRI method you are referring to?

> > -   Guest IOMMU driver fixes up the fault, updates the I/O page table,
> > and then sends a page response with virtual completion data (v_rid,
> > v_pasid, response_code) to vIOMMU;
> >   
> What about fixing up the fault for mmu page table as well in guest?
> Or you meant both when above you said "updates the I/O page table"?
> 
> It is unclear to me that if there is single nested page table maintained
> or two (one for cr3 references and other for iommu). Can you please
> clarify?
> 
I think it is just one, at least for VT-d, guest cr3 in GPA is stored
in the host iommu. Guest iommu driver calls handle_mm_fault to fix the mmu
page tables which is shared by the iommu.

> > -   Qemu finds the pending fault event, converts virtual completion data
> >     into (ioasid, response_code), and then calls a /dev/ioasid ioctl to
> >     complete the pending fault;
> >   
> For VFIO PCI device a virtual PRI request response interface is done, it
> can be generic interface among multiple vIOMMUs.
> 
same question above, not sure how this works in terms of interrupts and
response queuing etc.

> > -   /dev/ioasid finds out the pending fault data {rid, pasid, addr}
> > saved in ioasid_data->fault_data, and then calls iommu api to complete
> > it with {rid, pasid, response_code};
> >  


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
