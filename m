Return-Path: <SRS0=ocWU=2F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A0CC2D0C8
	for <iommu@archiver.kernel.org>; Sun, 15 Dec 2019 09:23:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 714E221D7E
	for <iommu@archiver.kernel.org>; Sun, 15 Dec 2019 09:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714E221D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 413E72037E;
	Sun, 15 Dec 2019 09:23:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zjBF+jS9Gzr0; Sun, 15 Dec 2019 09:23:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8B8B620346;
	Sun, 15 Dec 2019 09:23:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A58BC1D80;
	Sun, 15 Dec 2019 09:23:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4223C077D
 for <iommu@lists.linux-foundation.org>; Sun, 15 Dec 2019 09:23:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9995A860B5
 for <iommu@lists.linux-foundation.org>; Sun, 15 Dec 2019 09:23:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kVcXpeKIBc8D for <iommu@lists.linux-foundation.org>;
 Sun, 15 Dec 2019 09:22:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 725F586092
 for <iommu@lists.linux-foundation.org>; Sun, 15 Dec 2019 09:22:59 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Dec 2019 01:22:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,317,1571727600"; d="scan'208";a="217119280"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by orsmga003.jf.intel.com with ESMTP; 15 Dec 2019 01:22:58 -0800
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 15 Dec 2019 01:22:57 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.90]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.164]) with mapi id 14.03.0439.000;
 Sun, 15 Dec 2019 17:22:55 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 "David Woodhouse" <dwmw2@infradead.org>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH v3 5/6] iommu/vt-d: Flush PASID-based iotlb for iova
 over first level
Thread-Topic: [PATCH v3 5/6] iommu/vt-d: Flush PASID-based iotlb for iova
 over first level
Thread-Index: AQHVr8iiJX/bvAPmK0eIArQDcTD6yKe33K3QgACZjICAAndaMA==
Date: Sun, 15 Dec 2019 09:22:54 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A132C50@SHSMSX104.ccr.corp.intel.com>
References: <20191211021219.8997-1-baolu.lu@linux.intel.com>
 <20191211021219.8997-6-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C25743A130C08@SHSMSX104.ccr.corp.intel.com>
 <f1e5cfea-8b11-6d72-8e57-65daea51c050@linux.intel.com>
In-Reply-To: <f1e5cfea-8b11-6d72-8e57-65daea51c050@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDU3MTUyN2EtZWEzNC00MWYxLThlNjEtYTdjZjkyZmI5YTkxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoib21rQVZoUEpRYTlNa0p4ZnNTdlAxVHFrTmQrSnhyeWsraFBVUHh2ZGNGZ2NFbjRcL2x1a1J0cjNFdEowUDNKNHIifQ==
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun, 
 Yi Y" <yi.y.sun@intel.com>
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

Hi Baolu,

Please check replies below:

> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> Sent: Saturday, December 14, 2019 11:24 AM
> To: Liu, Yi L <yi.l.liu@intel.com>; Joerg Roedel <joro@8bytes.org>; David
> Woodhouse <dwmw2@infradead.org>; Alex Williamson
> <alex.williamson@redhat.com>
> Subject: Re: [PATCH v3 5/6] iommu/vt-d: Flush PASID-based iotlb for iova over first
> level
> 
> Hi Liu Yi,
> 
> On 12/13/19 7:42 PM, Liu, Yi L wrote:
> >> From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org] On
> Behalf
> >> Of Lu Baolu
> >> Sent: Wednesday, December 11, 2019 10:12 AM
> >> To: Joerg Roedel <joro@8bytes.org>; David Woodhouse
> <dwmw2@infradead.org>;
> >> Subject: [PATCH v3 5/6] iommu/vt-d: Flush PASID-based iotlb for iova over first
> level
> >>
> >> When software has changed first-level tables, it should invalidate
> >> the affected IOTLB and the paging-structure-caches using the PASID-
> >> based-IOTLB Invalidate Descriptor defined in spec 6.5.2.4.
> >>
> >> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> >> ---
> >>   drivers/iommu/dmar.c        | 41 ++++++++++++++++++++++++++++++++++
> >>   drivers/iommu/intel-iommu.c | 44 ++++++++++++++++++++++++-------------
> >>   include/linux/intel-iommu.h |  2 ++
> >>   3 files changed, 72 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> >> index 3acfa6a25fa2..fb30d5053664 100644
> >> --- a/drivers/iommu/dmar.c
> >> +++ b/drivers/iommu/dmar.c
> >> @@ -1371,6 +1371,47 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu,
> u16
> >> sid, u16 pfsid,
> >>   	qi_submit_sync(&desc, iommu);
> >>   }
> >>
> >> +/* PASID-based IOTLB invalidation */
> >> +void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
> >> +		     unsigned long npages, bool ih)
> >> +{
> >> +	struct qi_desc desc = {.qw2 = 0, .qw3 = 0};
> >> +
> >> +	/*
> >> +	 * npages == -1 means a PASID-selective invalidation, otherwise,
> >> +	 * a positive value for Page-selective-within-PASID invalidation.
> >> +	 * 0 is not a valid input.
> >> +	 */
> >> +	if (WARN_ON(!npages)) {
> >> +		pr_err("Invalid input npages = %ld\n", npages);
> >> +		return;
> >> +	}
> >> +
> >> +	if (npages == -1) {
> >> +		desc.qw0 = QI_EIOTLB_PASID(pasid) |
> >> +				QI_EIOTLB_DID(did) |
> >> +				QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
> >> +				QI_EIOTLB_TYPE;
> >> +		desc.qw1 = 0;
> >> +	} else {
> >> +		int mask = ilog2(__roundup_pow_of_two(npages));
> >> +		unsigned long align = (1ULL << (VTD_PAGE_SHIFT + mask));
> >> +
> >> +		if (WARN_ON_ONCE(!ALIGN(addr, align)))
> >> +			addr &= ~(align - 1);
> >> +
> >> +		desc.qw0 = QI_EIOTLB_PASID(pasid) |
> >> +				QI_EIOTLB_DID(did) |
> >> +				QI_EIOTLB_GRAN(QI_GRAN_PSI_PASID) |
> >> +				QI_EIOTLB_TYPE;
> >> +		desc.qw1 = QI_EIOTLB_ADDR(addr) |
> >> +				QI_EIOTLB_IH(ih) |
> >> +				QI_EIOTLB_AM(mask);
> >> +	}
> >> +
> >> +	qi_submit_sync(&desc, iommu);
> >> +}
> >> +
> >>   /*
> >>    * Disable Queued Invalidation interface.
> >>    */
> >> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> >> index 83a7abf0c4f0..e47f5fe37b59 100644
> >> --- a/drivers/iommu/intel-iommu.c
> >> +++ b/drivers/iommu/intel-iommu.c
> >> @@ -1520,18 +1520,24 @@ static void iommu_flush_iotlb_psi(struct
> intel_iommu
> >> *iommu,
> >>
> >>   	if (ih)
> >>   		ih = 1 << 6;
> >> -	/*
> >> -	 * Fallback to domain selective flush if no PSI support or the size is
> >> -	 * too big.
> >> -	 * PSI requires page size to be 2 ^ x, and the base address is naturally
> >> -	 * aligned to the size
> >> -	 */
> >> -	if (!cap_pgsel_inv(iommu->cap) || mask > cap_max_amask_val(iommu-
> >>> cap))
> >> -		iommu->flush.flush_iotlb(iommu, did, 0, 0,
> >> -						DMA_TLB_DSI_FLUSH);
> >> -	else
> >> -		iommu->flush.flush_iotlb(iommu, did, addr | ih, mask,
> >> -						DMA_TLB_PSI_FLUSH);
> >> +
> >> +	if (domain_use_first_level(domain)) {
> >> +		qi_flush_piotlb(iommu, did, domain->default_pasid,
> >> +				addr, pages, ih);
> >
> > I'm not sure if my understanding is correct. But let me tell a story.
> > Assuming we assign a mdev and a PF/VF to a single VM, then there
> > will be p_iotlb tagged with PASID_RID2PASID and p_iotlb tagged with
> > default_pasid. We may want to flush both... If this operation is
> 
> I assume that SRIOV and SIOV are exclusive. You can't enable both SRIOV
> and SIOV on a single device.

yes, but I'm not talking use them on a single device...

> So the mdev and PF/VF are from different
> devices, right?

yes, the case I mentioned above is: a mdev from a device (say devA),
and another device (say devB). Create mdev on devA and assign it to
a VM together with devB.

> 
> Or, in SRIOV case, you can wrap a PF or VF as a mediated device. But
> this mdev still be backed with a pasid of RID2PASID.

My comment has no business with wrapping PF/VR as mdev...

> 
> > invoked per-device, then need to pass in a hint to indicate whether
> > to use PASID_RID2PASID or default_pasid, or you may just issue two
> > flush with the two PASID values. Thoughts?
> 
> This is per-domain and each domain has specific domain id and default
> pasid (assume default domain is 0 in RID2PASID case).

Ok, let me explain more... default pasid is meaningful only when
the domain has been attached to a device as an aux-domain. right?
If a domain only has one device, and it is attached to this device as
normal domain (normal domain means non aux-domain here). Then
you should flush cache with domain-id and RID2PASID value.
If a domain has one device, and it is attached to this device as
aux-domain. Then you may want to flush cache with domain-id
and default pasid. right?
Then let's come to the case I mentioned in previous email. a mdev
and another device assigned to a single VM. In host, you will have
a domain which has two devices, one device(deva) is attached as
normal domain, another one (devB) is attached as aux-domain. Then
which pasid should be used when the mapping in IOVA page table is
modified? RID2PASID or default pasid? I think both should be used
since the domain means differently to the two devices. If you just
use default pasid, then deva may still be able to use stale caches.

Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
