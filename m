Return-Path: <SRS0=1Id5=UF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADFCC04AB5
	for <iommu@archiver.kernel.org>; Thu,  6 Jun 2019 06:55:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576F4207E0
	for <iommu@archiver.kernel.org>; Thu,  6 Jun 2019 06:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576F4207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D61BFC7C;
	Thu,  6 Jun 2019 06:54:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DCB6FC5D
	for <iommu@lists.linux-foundation.org>;
	Thu,  6 Jun 2019 06:54:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 506BEA8
	for <iommu@lists.linux-foundation.org>;
	Thu,  6 Jun 2019 06:54:50 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	05 Jun 2019 23:54:49 -0700
X-ExtLoop1: 1
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
	by fmsmga007.fm.intel.com with ESMTP; 05 Jun 2019 23:54:49 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
	fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Wed, 5 Jun 2019 23:54:49 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
	FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Wed, 5 Jun 2019 23:54:48 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.137]) by
	SHSMSX153.ccr.corp.intel.com ([169.254.12.192]) with mapi id
	14.03.0415.000; Thu, 6 Jun 2019 14:54:46 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v2 2/4] iommu: Introduce device fault data
Thread-Topic: [PATCH v2 2/4] iommu: Introduce device fault data
Thread-Index: AQHVGhzpdp8RFw2/OU64MEW+KDLfp6aJ93gAgALLAvCAAA3/AIABY4qw
Date: Thu, 6 Jun 2019 06:54:46 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19CA6C529@SHSMSX104.ccr.corp.intel.com>
References: <20190603145749.46347-1-jean-philippe.brucker@arm.com>
	<20190603145749.46347-3-jean-philippe.brucker@arm.com>
	<20190603150842.11070cfd@jacob-builder>
	<AADFC41AFE54684AB9EE6CBC0274A5D19CA6A9EE@SHSMSX104.ccr.corp.intel.com>
	<20190605103754.6d8830d7@jacob-builder>
In-Reply-To: <20190605103754.6d8830d7@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2NhYzQ0YmUtNjAzMC00OTBmLTg1NTgtZWMzMDM2YWVhYjQ0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRG5NZm1PSmJMUlIyalpCdWFITlVkb3o2ejdOUWp5Z0d5RXBoMVVtV0tjc1lFV21RU00wMXNmajFxZFJ6MkhSRSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
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

> From: Jacob Pan [mailto:jacob.jun.pan@linux.intel.com]
> Sent: Thursday, June 6, 2019 1:38 AM
> 
> On Wed, 5 Jun 2019 08:51:45 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> > > From: Jacob Pan
> > > Sent: Tuesday, June 4, 2019 6:09 AM
> > >
> > > On Mon,  3 Jun 2019 15:57:47 +0100
> > > Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> > >
> > > > +/**
> > > > + * struct iommu_fault_page_request - Page Request data
> > > > + * @flags: encodes whether the corresponding fields are valid and
> > > > whether this
> > > > + *         is the last page in group (IOMMU_FAULT_PAGE_REQUEST_*
> > > > values)
> > > > + * @pasid: Process Address Space ID
> > > > + * @grpid: Page Request Group Index
> > > > + * @perm: requested page permissions (IOMMU_FAULT_PERM_*
> values)
> > > > + * @addr: page address
> > > > + * @private_data: device-specific private information
> > > > + */
> > > > +struct iommu_fault_page_request {
> > > > +#define IOMMU_FAULT_PAGE_REQUEST_PASID_VALID	(1 << 0)
> > > > +#define IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE	(1 << 1)
> > > > +#define IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA	(1 << 2)
> > > > +	__u32	flags;
> > > > +	__u32	pasid;
> > > > +	__u32	grpid;
> > > > +	__u32	perm;
> > > > +	__u64	addr;
> > > > +	__u64	private_data[2];
> > > > +};
> > > > +
> > >
> > > Just a thought, for non-identity G-H PASID management. We could
> > > pass on guest PASID in PRQ to save a lookup in QEMU. In this case,
> > > QEMU allocate a GPASID for vIOMMU then a host PASID for pIOMMU.
> > > QEMU has a G->H lookup. When PRQ comes in to the pIOMMU with
> > > HPASID, IOMMU driver
> > > can retrieve GPASID from the bind data then report to the guest via
> > > VFIO. In this case QEMU does not need to do a H->G PASID lookup.
> > >
> > > Should we add a gpasid field here? or we can add a flag and field
> > > later, up to you.
> > >
> >
> > Can private_data serve this purpose? It's better not introducing
> > gpasid awareness within host IOMMU driver. It is just a user-level
> > data associated with a PASID when binding happens. Kernel doesn't
> > care the actual meaning, simply record it and then return back to
> > user space later upon device fault. Qemu interprets the meaning as
> > gpasid in its own context. otherwise usages may use it for other
> > purpose.
> >
> private_data was intended for device PRQ with private data, part of the
> VT-d PRQ descriptor. For vSVA, we can withhold private_data in the host
> then respond back when page response from the guest matches pending PRQ
> with the data withheld. But for in-kernel PRQ reporting, private data
> still might be passed on to any driver who wants to process the PRQ. So
> we can't re-purpose it.

sure. I just use it as one example to extend.

> 
> But for in-kernel VDCM driver, it needs a lookup from guest PASID to
> host PASID. I thought you wanted to have IOMMU driver provide such
> service since the knowledge of H-G pasid can be established during
> bind_gpasid time. In that sense, we _do_ have gpasid awareness.
> 

yes, it makes sense. My original point is that IOMMU driver itself 
doesn't need to know the actual meaning of this field (then it may
be reused for different purpose from gpasid), but you are right that
mdev driver in kernel anyway needs to do G-H translation then 
explicitly defining it looks reasonable.

Thanks
Kevin 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
