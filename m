Return-Path: <SRS0=DEPd=UE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E4DC28CC6
	for <iommu@archiver.kernel.org>; Wed,  5 Jun 2019 21:55:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 461D2206BB
	for <iommu@archiver.kernel.org>; Wed,  5 Jun 2019 21:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461D2206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1695CDD1;
	Wed,  5 Jun 2019 21:55:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6DE61DC2
	for <iommu@lists.linux-foundation.org>;
	Wed,  5 Jun 2019 21:55:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C55854C3
	for <iommu@lists.linux-foundation.org>;
	Wed,  5 Jun 2019 21:55:36 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	05 Jun 2019 14:55:36 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by orsmga001.jf.intel.com with ESMTP; 05 Jun 2019 14:55:36 -0700
Date: Wed, 5 Jun 2019 14:58:41 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v2 2/4] iommu: Introduce device fault data
Message-ID: <20190605145841.55cf9667@jacob-builder>
In-Reply-To: <50dc3cc5-6019-ad42-6aba-d84fab4020f9@arm.com>
References: <20190603145749.46347-1-jean-philippe.brucker@arm.com>
	<20190603145749.46347-3-jean-philippe.brucker@arm.com>
	<20190603150842.11070cfd@jacob-builder>
	<AADFC41AFE54684AB9EE6CBC0274A5D19CA6A9EE@SHSMSX104.ccr.corp.intel.com>
	<50dc3cc5-6019-ad42-6aba-d84fab4020f9@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Wed, 5 Jun 2019 12:24:09 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> On 05/06/2019 09:51, Tian, Kevin wrote:
> >> From: Jacob Pan
> >> Sent: Tuesday, June 4, 2019 6:09 AM
> >>
> >> On Mon,  3 Jun 2019 15:57:47 +0100
> >> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> >>  
> >>> +/**
> >>> + * struct iommu_fault_page_request - Page Request data
> >>> + * @flags: encodes whether the corresponding fields are valid and
> >>> whether this
> >>> + *         is the last page in group (IOMMU_FAULT_PAGE_REQUEST_*
> >>> values)
> >>> + * @pasid: Process Address Space ID
> >>> + * @grpid: Page Request Group Index
> >>> + * @perm: requested page permissions (IOMMU_FAULT_PERM_* values)
> >>> + * @addr: page address
> >>> + * @private_data: device-specific private information
> >>> + */
> >>> +struct iommu_fault_page_request {
> >>> +#define IOMMU_FAULT_PAGE_REQUEST_PASID_VALID	(1 << 0)
> >>> +#define IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE	(1 << 1)
> >>> +#define IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA	(1 << 2)
> >>> +	__u32	flags;
> >>> +	__u32	pasid;
> >>> +	__u32	grpid;
> >>> +	__u32	perm;
> >>> +	__u64	addr;
> >>> +	__u64	private_data[2];
> >>> +};
> >>> +  
> >>
> >> Just a thought, for non-identity G-H PASID management. We could
> >> pass on guest PASID in PRQ to save a lookup in QEMU. In this case,
> >> QEMU allocate a GPASID for vIOMMU then a host PASID for pIOMMU.
> >> QEMU has a G->H lookup. When PRQ comes in to the pIOMMU with
> >> HPASID, IOMMU driver
> >> can retrieve GPASID from the bind data then report to the guest via
> >> VFIO. In this case QEMU does not need to do a H->G PASID lookup.
> >>
> >> Should we add a gpasid field here? or we can add a flag and field
> >> later, up to you.
> >>  
> > 
> > Can private_data serve this purpose?  
> 
> Isn't private_data already used for VT-d's Private Data field?
> 
yes, as part of the PRQ. please see my explanation in the previous
email.
> > It's better not introducing
> > gpasid awareness within host IOMMU driver. It is just a user-level
> > data associated with a PASID when binding happens. Kernel doesn't
> > care the actual meaning, simply record it and then return back to
> > user space later upon device fault. Qemu interprets the meaning as
> > gpasid in its own context. otherwise usages may use it for other
> > purpose.  
> 
> Regarding a gpasid field I don't mind either way, but extending the
> iommu_fault structure later won't be completely straightforward so we
> could add some padding now.
> 
> Userspace negotiate the iommu_fault struct format with VFIO, before
> allocating a circular buffer of N fault structures
> ().
> So adding new fields requires introducing a new ABI version and a
> struct iommu_fault_v2. That may be OK for disruptive changes, but
> just adding a new field indicated by a flag shouldn't have to be that
> complicated.
> 
> How about setting the iommu_fault structure to 128 bytes?
> 
> struct iommu_fault {
> 	__u32   type;
> 	__u32   padding;
> 	union {
> 		struct iommu_fault_unrecoverable event;
> 		struct iommu_fault_page_request prm;
> 		__u8 padding2[120];
> 	};
> };
> 
> Given that @prm is currently 40 bytes and @event 32 bytes, the padding
> allows either of them to grow 10 new 64-bit fields (or 20 new 32-bit
> fields, which is still representable with new flags) before we have to
> upgrade the ABI version.
> 
> A 4kB and a 64kB queue can hold respectively:
> 
> * 85 and 1365 records when iommu_fault is 48 bytes (current format).
> * 64 and 1024 records when iommu_fault is 64 bytes (but allows to grow
> only 2 new 64-bit fields).
> * 32 and 512 records when iommu_fault is 128 bytes.
> 
> In comparison,
> * the SMMU even queue can hold 128 and 2048 events respectively at
> those sizes (and is allowed to grow up to 524k entries)
> * the SMMU PRI queue can hold 256 and 4096 PR.
> 
> But the SMMU queues have to be physically contiguous, whereas our
> fault queues are in userspace memory which is less expensive. So
> 128-byte records might be reasonable. What do you think?
> 
I think though 128-byte is large enough for any future extension but
64B might be good enough and it is a cache line. PCI page request msg
is only 16B :)

VT-d currently uses one 4K page for PRQ, holds 128 records of PRQ
descriptors. This can grow to 16K entries per spec. That is per IOMMU.
The user fault queue here is per device. So we do have to be frugal
about it since it will support mdev at per PASID level at some point?

I have to look into Eric's patchset on how he handles queue full in the
producer. If we go with 128B size in iommu_fault and 4KB size queue
(32 entries as in your table), VT-d PRQ size of 128 entries can
potentially cause queue full. We have to handle this VFIO queue full
differently than the IOMMU queue full in that we only need to discard
PRQ for one device. (Whereas IOMMU queue full has to clear out all).

Anyway, I think 64B should be enough but 128B is fine too. We have to
deal with queue full anyway. But queue full is expensive so we should
try to avoid.

> 
> The iommu_fault_response (patch 4/4) is a bit easier to extend because
> it's userspace->kernel and userspace can just declare the size it's
> using. I did add a version field in case we run out of flags or want
> to change the whole thing, but I think I was being overly cautious
> and it might just be a waste of space.
> 
> Thanks,
> Jean

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
