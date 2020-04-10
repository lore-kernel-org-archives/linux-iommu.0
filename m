Return-Path: <SRS0=Ithz=52=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208C2C2BB1D
	for <iommu@archiver.kernel.org>; Fri, 10 Apr 2020 12:30:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E529E20769
	for <iommu@archiver.kernel.org>; Fri, 10 Apr 2020 12:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E529E20769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AC7C32206E;
	Fri, 10 Apr 2020 12:30:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id thscuBJ1s+vQ; Fri, 10 Apr 2020 12:30:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 63879204EB;
	Fri, 10 Apr 2020 12:30:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F62DC1D74;
	Fri, 10 Apr 2020 12:30:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35C62C0177
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 12:30:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1EC878813E
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 12:30:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Upbk8L9oZy1C for <iommu@lists.linux-foundation.org>;
 Fri, 10 Apr 2020 12:30:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BD39487943
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 12:30:49 +0000 (UTC)
IronPort-SDR: 04/jNUE/8pPM4cjC668a8NEooJRL2T/M5zLy1duuZX3mPKanUppLVsJpbUqqFK2FfLnp9VjQi+
 yZGPQ7Wftseg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2020 05:30:49 -0700
IronPort-SDR: 8U5dWyRhJXN/ddnXJrlJSDkrgG/9EZDnjvNxLZPIWnkU2/9zCVu8jUaF1kp0cpml2hzL/651TU
 9ZwqfiRkD8uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,366,1580803200"; d="scan'208";a="276160967"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga004.fm.intel.com with ESMTP; 10 Apr 2020 05:30:49 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 10 Apr 2020 05:30:49 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 10 Apr 2020 05:30:48 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.138]) with mapi id 14.03.0439.000;
 Fri, 10 Apr 2020 20:30:45 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, Auger Eric
 <eric.auger@redhat.com>, "jacob.jun.pan@linux.intel.com"
 <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v1 5/8] vfio/type1: Report 1st-level/stage-1 format to
 userspace
Thread-Topic: [PATCH v1 5/8] vfio/type1: Report 1st-level/stage-1 format to
 userspace
Thread-Index: AQHWAEUcqZEEdiOKbEGofjWp2Yic+6hjfq+AgAC/vLD//4YrAIAC1vWAgAbjh1CAARsGAIABbRkAgADQzoCAAYffoA==
Date: Fri, 10 Apr 2020 12:30:45 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A22A118@SHSMSX104.ccr.corp.intel.com>
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
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A229013@SHSMSX104.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
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

Hi Jean, Eric,

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, April 9, 2020 8:47 PM
> Subject: RE: [PATCH v1 5/8] vfio/type1: Report 1st-level/stage-1 format to
> userspace
> 
[...]
> > > >>
> > > >> Yes I don't think an u32 is going to cut it for Arm :( We need to
> > > >> describe all sorts
> > of
> > > >> capabilities for page and PASID tables (granules, GPA size, ASID/PASID size,
> HW
> > > >> access/dirty, etc etc.) Just saying "Arm stage-1 format" wouldn't mean
> much. I
> > > >> guess we could have a secondary vendor capability for these?
> > > >
> > > > Actually, I'm wondering if we can define some formats to stands for a set of
> > > > capabilities. e.g. VTD_STAGE1_FORMAT_V1 which may indicates the 1st
> level
> > > > page table related caps (aw, a/d, SRE, EA and etc.). And vIOMMU can parse
> > > > the capabilities.
> > >
> > > But eventually do we really need all those capability getters? I mean
> > > can't we simply rely on the actual call to VFIO_IOMMU_BIND_GUEST_PGTBL()
> > > to detect any mismatch? Definitively the error handling may be heavier
> > > on userspace but can't we manage.
> >
> > I think we need to present these capabilities at boot time, long before
> > the guest triggers a bind(). For example if the host SMMU doesn't support
> > 16-bit ASID, we need to communicate that to the guest using vSMMU ID
> > registers or PROBE properties. Otherwise a bind() will succeed, but if the
> > guest uses 16-bit ASIDs in its CD, DMA will result in C_BAD_CD events
> > which we'll inject into the guest, for no apparent reason from their
> > perspective.
> >
> > In addition some VMMs may have fallbacks if shared page tables are not
> > available. They could fall back to a MAP/UNMAP interface, or simply not
> > present a vIOMMU to the guest.
> >
> 
> Based on the comments, I think it would be a need to report iommu caps
> in detail. So I guess iommu uapi needs to provide something alike vfio
> cap chain in iommu uapi. Please feel free let me know your thoughts. :-)

Consider more, I guess it may be better to start simpler. Cap chain suits
the case in which there are multiple caps. e.g. some vendor iommu driver
may want to report iommu capabilities via multiple caps. Actually, in VT-d
side, the host IOMMU capability could be reported in a single cap structure.
I'm not sure about ARM side. Will there be multiple iommu_info_caps for ARM?

> In vfio, we can define a cap as below:
>
> struct vfio_iommu_type1_info_cap_nesting {
> 	struct  vfio_info_cap_header header;
> 	__u64	iommu_model;
> #define VFIO_IOMMU_PASID_REQS		(1 << 0)
> #define VFIO_IOMMU_BIND_GPASID		(1 << 1)
> #define VFIO_IOMMU_CACHE_INV		(1 << 2)
> 	__u32	nesting_capabilities;
> 	__u32	pasid_bits;
> #define VFIO_IOMMU_VENDOR_SUB_CAP	(1 << 3)
> 	__u32	flags;
> 	__u32	data_size;
> 	__u8	data[];  /*iommu info caps defined by iommu uapi */
> };
> 

If iommu vendor driver only needs one cap structure to report hw
capability, then I think we needn't implement cap chain in iommu
uapi. The @data[] field could be determined by the @iommu_model
and @flags fields. This would be easier. thoughts?

> VFIO needs new iommu APIs to ask iommu driver whether PASID/bind_gpasid/
> cache_inv/bind_gpasid_table is available or not and also the pasid
> bits. After that VFIO will ask iommu driver about the iommu_cap_info
> and fill in the @data[] field.
>
> iommu uapi:
> struct iommu_info_cap_header {
> 	__u16	id;		/* Identifies capability */
> 	__u16	version;		/* Version specific to the capability ID */
> 	__u32	next;		/* Offset of next capability */
> };
> 
> #define IOMMU_INFO_CAP_INTEL_VTD 1
> struct iommu_info_cap_intel_vtd {
> 	struct	iommu_info_cap_header header;
> 	__u32   vaddr_width;   /* VA addr_width*/
> 	__u32   ipaddr_width; /* IPA addr_width, input of SL page table */
> 	/* same definition with @flags instruct iommu_gpasid_bind_data_vtd */
> 	__u64	flags;
> };
> 
> #define IOMMU_INFO_CAP_ARM_SMMUv3 2
> struct iommu_info_cap_arm_smmuv3 {
> 	struct	iommu_info_cap_header header;
> 	...
> };

Regards,
Yi Liu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
