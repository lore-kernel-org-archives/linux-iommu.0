Return-Path: <SRS0=DEPd=UE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F3AC28CC5
	for <iommu@archiver.kernel.org>; Wed,  5 Jun 2019 17:34:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E184C20872
	for <iommu@archiver.kernel.org>; Wed,  5 Jun 2019 17:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E184C20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 90732DA1;
	Wed,  5 Jun 2019 17:34:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 78D5AD9B
	for <iommu@lists.linux-foundation.org>;
	Wed,  5 Jun 2019 17:34:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 044DA854
	for <iommu@lists.linux-foundation.org>;
	Wed,  5 Jun 2019 17:34:50 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	05 Jun 2019 10:34:50 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by orsmga001.jf.intel.com with ESMTP; 05 Jun 2019 10:34:49 -0700
Date: Wed, 5 Jun 2019 10:37:54 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v2 2/4] iommu: Introduce device fault data
Message-ID: <20190605103754.6d8830d7@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19CA6A9EE@SHSMSX104.ccr.corp.intel.com>
References: <20190603145749.46347-1-jean-philippe.brucker@arm.com>
	<20190603145749.46347-3-jean-philippe.brucker@arm.com>
	<20190603150842.11070cfd@jacob-builder>
	<AADFC41AFE54684AB9EE6CBC0274A5D19CA6A9EE@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

On Wed, 5 Jun 2019 08:51:45 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan
> > Sent: Tuesday, June 4, 2019 6:09 AM
> > 
> > On Mon,  3 Jun 2019 15:57:47 +0100
> > Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> >   
> > > +/**
> > > + * struct iommu_fault_page_request - Page Request data
> > > + * @flags: encodes whether the corresponding fields are valid and
> > > whether this
> > > + *         is the last page in group (IOMMU_FAULT_PAGE_REQUEST_*
> > > values)
> > > + * @pasid: Process Address Space ID
> > > + * @grpid: Page Request Group Index
> > > + * @perm: requested page permissions (IOMMU_FAULT_PERM_* values)
> > > + * @addr: page address
> > > + * @private_data: device-specific private information
> > > + */
> > > +struct iommu_fault_page_request {
> > > +#define IOMMU_FAULT_PAGE_REQUEST_PASID_VALID	(1 << 0)
> > > +#define IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE	(1 << 1)
> > > +#define IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA	(1 << 2)
> > > +	__u32	flags;
> > > +	__u32	pasid;
> > > +	__u32	grpid;
> > > +	__u32	perm;
> > > +	__u64	addr;
> > > +	__u64	private_data[2];
> > > +};
> > > +  
> > 
> > Just a thought, for non-identity G-H PASID management. We could
> > pass on guest PASID in PRQ to save a lookup in QEMU. In this case,
> > QEMU allocate a GPASID for vIOMMU then a host PASID for pIOMMU.
> > QEMU has a G->H lookup. When PRQ comes in to the pIOMMU with
> > HPASID, IOMMU driver
> > can retrieve GPASID from the bind data then report to the guest via
> > VFIO. In this case QEMU does not need to do a H->G PASID lookup.
> > 
> > Should we add a gpasid field here? or we can add a flag and field
> > later, up to you.
> >   
> 
> Can private_data serve this purpose? It's better not introducing
> gpasid awareness within host IOMMU driver. It is just a user-level
> data associated with a PASID when binding happens. Kernel doesn't
> care the actual meaning, simply record it and then return back to
> user space later upon device fault. Qemu interprets the meaning as
> gpasid in its own context. otherwise usages may use it for other
> purpose.
> 
private_data was intended for device PRQ with private data, part of the
VT-d PRQ descriptor. For vSVA, we can withhold private_data in the host
then respond back when page response from the guest matches pending PRQ
with the data withheld. But for in-kernel PRQ reporting, private data
still might be passed on to any driver who wants to process the PRQ. So
we can't re-purpose it.

But for in-kernel VDCM driver, it needs a lookup from guest PASID to
host PASID. I thought you wanted to have IOMMU driver provide such
service since the knowledge of H-G pasid can be established during
bind_gpasid time. In that sense, we _do_ have gpasid awareness.
 
> Thanks
> Kevin

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
