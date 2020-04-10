Return-Path: <SRS0=Ithz=52=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C58C2BB85
	for <iommu@archiver.kernel.org>; Fri, 10 Apr 2020 03:49:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3C0921655
	for <iommu@archiver.kernel.org>; Fri, 10 Apr 2020 03:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C0921655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A123D20109;
	Fri, 10 Apr 2020 03:49:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R4edNv+8dT60; Fri, 10 Apr 2020 03:49:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9E0282011A;
	Fri, 10 Apr 2020 03:49:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 830FDC1D7E;
	Fri, 10 Apr 2020 03:49:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1398C0177
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 03:49:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9FA7484806
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 03:49:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HpK0UR7kdAAj for <iommu@lists.linux-foundation.org>;
 Fri, 10 Apr 2020 03:48:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AF566847C4
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 03:48:58 +0000 (UTC)
IronPort-SDR: zIs8pKgVm9Q3ffrR5Jm6D09iSm4b723A5F7ehg4bGmOtMK6xwlEETt8q+yfPX1Npssr4JKadir
 i7rZ2MTaZa2g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2020 20:48:58 -0700
IronPort-SDR: PMJlktvkLL+qA2z9GAk5PCuStScGWDR9cIT7sYx6Dmxj1zZGJjhOW3OqpZuvIpOJFcUpN9/ede
 FtRAMdL+l5rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,364,1580803200"; d="scan'208";a="331068532"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga001.jf.intel.com with ESMTP; 09 Apr 2020 20:48:57 -0700
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Apr 2020 20:48:57 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Apr 2020 20:48:57 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.22]) with mapi id 14.03.0439.000;
 Fri, 10 Apr 2020 11:48:53 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, "jacob.jun.pan@linux.intel.com"
 <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v1 5/8] vfio/type1: Report 1st-level/stage-1 format to
 userspace
Thread-Topic: [PATCH v1 5/8] vfio/type1: Report 1st-level/stage-1 format to
 userspace
Thread-Index: AQHWAEUcqZEEdiOKbEGofjWp2Yic+6hjfq+AgAC/vLD//4YrAIAC1vWAgAbjh1CAARsGAIABbRkAgADQzoCAAHFwgIAAhnyw
Date: Fri, 10 Apr 2020 03:48:52 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A229ABC@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-6-git-send-email-yi.l.liu@intel.com>
 <cb68e9ab-77b0-7e97-a661-4836962041d9@redhat.com>
 <A2975661238FB949B60364EF0F2C25743A21DB4E@SHSMSX104.ccr.corp.intel.com>
 <b47891b1-ece6-c263-9c07-07c09c7d3752@redhat.com>
 <20200403082305.GA1269501@myrica>
 <A2975661238FB949B60364EF0F2C25743A2249DF@SHSMSX104.ccr.corp.intel.com>
 <acf8c809-8d29-92d6-2445-3a94fc8b82fd@redhat.com>
 <20200409081442.GD2435@myrica>
 <A2975661238FB949B60364EF0F2C25743A229013@SHSMSX104.ccr.corp.intel.com>
 <194923cd-666c-2244-bfc6-95a1c61d4d99@redhat.com>
In-Reply-To: <194923cd-666c-2244-bfc6-95a1c61d4d99@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Wu,
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

Hi Eric,

> From: Auger Eric <eric.auger@redhat.com>
> Sent: Friday, April 10, 2020 11:28 AM
> To: Liu, Yi L <yi.l.liu@intel.com>; Jean-Philippe Brucker <jean-
> Subject: Re: [PATCH v1 5/8] vfio/type1: Report 1st-level/stage-1 format to
> userspace
> 
> Hi Yi,
> 
> On 4/9/20 2:47 PM, Liu, Yi L wrote:
> > Hi Jean,
> >
> >> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >> Sent: Thursday, April 9, 2020 4:15 PM
> >> Subject: Re: [PATCH v1 5/8] vfio/type1: Report 1st-level/stage-1
> >> format to userspace
> >>
> >> On Wed, Apr 08, 2020 at 12:27:58PM +0200, Auger Eric wrote:
> >>> Hi Yi,
> >>>
> >>> On 4/7/20 11:43 AM, Liu, Yi L wrote:
> >>>> Hi Jean,
> >>>>
> >>>>> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >>>>> Sent: Friday, April 3, 2020 4:23 PM
> >>>>> To: Auger Eric <eric.auger@redhat.com> userspace
> >>>>>
> >>>>> On Wed, Apr 01, 2020 at 03:01:12PM +0200, Auger Eric wrote:
> >>>>>>>>>  	header = vfio_info_cap_add(caps, sizeof(*nesting_cap),
> >>>>>>>>>
> >> VFIO_IOMMU_TYPE1_INFO_CAP_NESTING, 1);
> >>>>> @@ -2254,6 +2309,7
> >>>>>>>>> @@ static int vfio_iommu_info_add_nesting_cap(struct
> >>>>>>>> vfio_iommu *iommu,
> >>>>>>>>>  		/* nesting iommu type supports PASID requests
> (alloc/free)
> >> */
> >>>>>>>>>  		nesting_cap->nesting_capabilities |=
> >> VFIO_IOMMU_PASID_REQS;
> >>>>>>>> What is the meaning for ARM?
> >>>>>>>
> >>>>>>> I think it's just a software capability exposed to userspace, on
> >>>>>>> userspace side, it has a choice to use it or not. :-) The reason
> >>>>>>> define it and report it in cap nesting is that I'd like to make
> >>>>>>> the pasid alloc/free be available just for IOMMU with type
> >>>>>>> VFIO_IOMMU_TYPE1_NESTING. Please feel free tell me if it is not
> >>>>>>> good for ARM. We can find a proper way to report the availability.
> >>>>>>
> >>>>>> Well it is more a question for jean-Philippe. Do we have a system
> >>>>>> wide PASID allocation on ARM?
> >>>>>
> >>>>> We don't, the PASID spaces are per-VM on Arm, so this function
> >>>>> should consult
> >> the
> >>>>> IOMMU driver before setting flags. As you said on patch 3, nested
> >>>>> doesn't necessarily imply PASID support. The SMMUv2 does not
> >>>>> support PASID but does support nesting stages 1 and 2 for the IOVA space.
> >>>>> SMMUv3 support of PASID depends on HW capabilities. So I think
> >>>>> this needs to
> >> be
> >>>>> finer grained:
> >>>>>
> >>>>> Does the container support:
> >>>>> * VFIO_IOMMU_PASID_REQUEST?
> >>>>>   -> Yes for VT-d 3
> >>>>>   -> No for Arm SMMU
> >>>>> * VFIO_IOMMU_{,UN}BIND_GUEST_PGTBL?
> >>>>>   -> Yes for VT-d 3
> >>>>>   -> Sometimes for SMMUv2
> >>>>>   -> No for SMMUv3 (if we go with BIND_PASID_TABLE, which is simpler
> due to
> >>>>>      PASID tables being in GPA space.)
> >>>>> * VFIO_IOMMU_BIND_PASID_TABLE?
> >>>>>   -> No for VT-d
> >>>>>   -> Sometimes for SMMUv3
> >>>>>
> >>>>> Any bind support implies VFIO_IOMMU_CACHE_INVALIDATE support.
> >>>>
> >>>> good summary. do you expect to see any
> >>>>
> >>>>>
> >>>>>>>>> +	nesting_cap->stage1_formats = formats;
> >>>>>>>> as spotted by Kevin, since a single format is supported, rename
> >>>>>>>
> >>>>>>> ok, I was believing it may be possible on ARM or so. :-) will
> >>>>>>> rename it.
> >>>>>
> >>>>> Yes I don't think an u32 is going to cut it for Arm :( We need to
> >>>>> describe all sorts
> >> of
> >>>>> capabilities for page and PASID tables (granules, GPA size,
> >>>>> ASID/PASID size, HW access/dirty, etc etc.) Just saying "Arm
> >>>>> stage-1 format" wouldn't mean much. I guess we could have a secondary
> vendor capability for these?
> >>>>
> >>>> Actually, I'm wondering if we can define some formats to stands for
> >>>> a set of capabilities. e.g. VTD_STAGE1_FORMAT_V1 which may
> >>>> indicates the 1st level page table related caps (aw, a/d, SRE, EA
> >>>> and etc.). And vIOMMU can parse the capabilities.
> >>>
> >>> But eventually do we really need all those capability getters? I
> >>> mean can't we simply rely on the actual call to
> >>> VFIO_IOMMU_BIND_GUEST_PGTBL() to detect any mismatch? Definitively
> >>> the error handling may be heavier on userspace but can't we manage.
> >>
> >> I think we need to present these capabilities at boot time, long
> >> before the guest triggers a bind(). For example if the host SMMU
> >> doesn't support 16-bit ASID, we need to communicate that to the guest
> >> using vSMMU ID registers or PROBE properties. Otherwise a bind() will
> >> succeed, but if the guest uses 16-bit ASIDs in its CD, DMA will
> >> result in C_BAD_CD events which we'll inject into the guest, for no
> >> apparent reason from their perspective.
> >>
> >> In addition some VMMs may have fallbacks if shared page tables are
> >> not available. They could fall back to a MAP/UNMAP interface, or
> >> simply not present a vIOMMU to the guest.
> >>
> >
> > Based on the comments, I think it would be a need to report iommu caps
> > in detail. So I guess iommu uapi needs to provide something alike vfio
> > cap chain in iommu uapi. Please feel free let me know your thoughts.
> > :-)
> 
> Yes to me it sounds sensible.
> >
> > In vfio, we can define a cap as below:
> >
> > struct vfio_iommu_type1_info_cap_nesting {
> > 	struct  vfio_info_cap_header header;
> > 	__u64	iommu_model;
> > #define VFIO_IOMMU_PASID_REQS		(1 << 0)
> I still think the name shall be changed

yes, I'll rename it per your suggestion.:-)

> > #define VFIO_IOMMU_BIND_GPASID		(1 << 1)
> > #define VFIO_IOMMU_CACHE_INV		(1 << 2)
> this operation seems mandated as soon as we have a nested paging based
> implementation?

oh, yes, should be. will remove it and comment in the code.

Regards,
Yi Liu

> > 	__u32	nesting_capabilities;
> > 	__u32	pasid_bits;
> > #define VFIO_IOMMU_VENDOR_SUB_CAP	(1 << 3)
> > 	__u32	flags;
> > 	__u32	data_size;
> > 	__u8	data[];  /*iommu info caps defined by iommu uapi */
> > };
> >
> > VFIO needs new iommu APIs to ask iommu driver whether
> > PASID/bind_gpasid/ cache_inv/bind_gpasid_table is available or not and
> > also the pasid bits. After that VFIO will ask iommu driver about the
> > iommu_cap_info and fill in the @data[] field.
> >
> > iommu uapi:
> > struct iommu_info_cap_header {
> > 	__u16	id;		/* Identifies capability */
> > 	__u16	version;		/* Version specific to the capability ID */
> > 	__u32	next;		/* Offset of next capability */
> > };
> >
> > #define IOMMU_INFO_CAP_INTEL_VTD 1
> > struct iommu_info_cap_intel_vtd {
> > 	struct	iommu_info_cap_header header;
> > 	__u32   vaddr_width;   /* VA addr_width*/
> > 	__u32   ipaddr_width; /* IPA addr_width, input of SL page table */
> > 	/* same definition with @flags instruct iommu_gpasid_bind_data_vtd */
> > 	__u64	flags;
> > };
> >
> > #define IOMMU_INFO_CAP_ARM_SMMUv3 2
> > struct iommu_info_cap_arm_smmuv3 {
> > 	struct	iommu_info_cap_header header;
> > 	...
> > };
> 
> Thanks
> 
> Eric
> >
> > Regards,
> > Yi Liu
> >

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
