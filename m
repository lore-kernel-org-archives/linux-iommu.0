Return-Path: <SRS0=7VEr=CT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0837AC43461
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 15:53:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B102076C
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 15:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B102076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 070C087615;
	Thu, 10 Sep 2020 15:53:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ygTfSH0hlYx3; Thu, 10 Sep 2020 15:53:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6AF338754B;
	Thu, 10 Sep 2020 15:53:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 412F1C0052;
	Thu, 10 Sep 2020 15:53:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54558C0051
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 15:53:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 369A487615
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 15:53:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6NeLrka6MqxX for <iommu@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 15:53:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 406028754B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 15:53:05 +0000 (UTC)
IronPort-SDR: roBSo3XKzlf+YoiuJN4PtBU1NiqkcYDKWagXN2hPtv3ri8p16cjoxpAlFOl4i81FYdbCsPNE/O
 el5g9vGAYn4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="146286679"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; d="scan'208";a="146286679"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 08:53:04 -0700
IronPort-SDR: xtD70zt3jj3J40CjfgKgw4AOPLqxEy+7BCfDhnZz+vEn9TcS1JKPHO2scZ0IyjSC1rpIchesDb
 oVAb5F+TJL8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; d="scan'208";a="407796959"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by fmsmga001.fm.intel.com with ESMTP; 10 Sep 2020 08:53:03 -0700
Date: Thu, 10 Sep 2020 08:53:03 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] intel-iommu: don't disable ATS for device without page
 aligned request
Message-ID: <20200910155303.GC97190@otc-nc-03>
References: <20200909083432.9464-1-jasowang@redhat.com>
 <20200909171056.GF104641@otc-nc-03>
 <491540137.16465450.1599704255365.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <491540137.16465450.1599704255365.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Ashok Raj <ashok.raj@intel.com>, mst@redhat.com,
 linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
 eperezma@redhat.com, iommu@lists.linux-foundation.org, stable@vger.kernel.org,
 dwmw2@infradead.org
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

On Wed, Sep 09, 2020 at 10:17:35PM -0400, Jason Wang wrote:
> 
> 
> ----- Original Message -----
> > Hi Jason
> > 
> > On Wed, Sep 09, 2020 at 04:34:32PM +0800, Jason Wang wrote:
> > > Commit 61363c1474b1 ("iommu/vt-d: Enable ATS only if the device uses
> > > page aligned address.") disables ATS for device that can do unaligned
> > > page request.
> > 
> > Did you take a look at the PCI specification?
> > Page Aligned Request is in the ATS capability Register.
> > 
> > ATS Capability Register (Offset 0x04h)
> > 
> > bit (5):
> > Page Aligned Request - If Set, indicates the Untranslated address is always
> > aligned to 4096 byte boundary. Setting this field is recommended. This
> > field permits software to distinguish between implemntations compatible
> > with this specification and those compatible with an earlier version of
> > this specification in which a Requester was permitted to supply anything in
> > bits [11:2].
> 
> Yes, my understanding is that this is optional not mandatory.

Correct, but optional on the device side. An IOMMU might *require* this for
proper normal operation. Our IOMMU's do not get the low 12 bits. Which is
why the spec gives SW a way to detect if the device is compatible for this
IOMMU implementation.

> 
> > 
> > > 
> > > This looks wrong, since the commit log said it's because the page
> > > request descriptor doesn't support reporting unaligned request.
> > 
> > I don't think you can change the definition from ATS to PRI. Both are
> > orthogonal feature.
> 
> I may miss something, here's my understanding is that:
> 
> - page request descriptor will only be used when PRS is enabled
> - ATS spec allows unaligned request
> 
> So any reason for disabling ATS for unaligned request even if PRS is
> not enabled?

I think you are getting confused between the 2 different PCIe features.

ATS - Address Translation Services. Used by device to simply request the
Host Physical Address for some DMA operation. 

When ATS response indicates failed, then the device can request a
page-request (PRS this is like a device page-fault), and then IOMMU driver
would work with the kernel to fault a page then respond with
(Page-response) success/failure. Then the device will send a new ATS 
to get the new translation. 


> 
> > 
> > > 
> > > A victim is Qemu's virtio-pci which doesn't advertise the page aligned
> > > address. Fixing by disable PRI instead of ATS if device doesn't have
> > > page aligned request.
> > 
> > This is a requirement for the Intel IOMMU's.
> > 
> > You say virtio, so is it all emulated device or you talking about some
> > hardware that implemented virtio-pci compliant hw? If you are sure the
> > device actually does comply with the requirement, but just not enumerating
> > the capability, you can maybe work a quirk to overcome that?
> 
> So far only emulated devices. But we are helping some vendor to
> implement virtio hardware so  we need to understand the connection
> between ATS alignment and page request descriptor.

ATS and PRS are 2 separate orthogonal features. 
PRS requires ATS, but not the other way around. 

> 
> > 
> > Now PRI also has an alignment requirement, and Intel IOMMU's requires that
> > as well. If your device supports SRIOV as well, PASID and PRI are
> > enumerated just on the PF and not the VF. You might want to pay attension
> > to that. We are still working on a solution for that problem.
> 
> Thanks for the reminding, but it looks to me according to the ATS
> spec, all PRI message is 4096 byte aligned? E.g lower bites were used
> for group index etc.

Right, I should have been clear. The issue with PRI is we require responses
to have PASID field set. There is another capability on the device that
exposes that. pci_prg_resp_pasid_required(). This is required to enable PRI
for a device.

Cheers,
Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
