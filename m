Return-Path: <SRS0=p9ZB=5X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3151BC2BB85
	for <iommu@archiver.kernel.org>; Tue,  7 Apr 2020 09:43:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE8E220731
	for <iommu@archiver.kernel.org>; Tue,  7 Apr 2020 09:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8E220731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B3C7A885E7;
	Tue,  7 Apr 2020 09:43:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6SjvPq51Nsyo; Tue,  7 Apr 2020 09:43:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AB96082441;
	Tue,  7 Apr 2020 09:43:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90031C1D7E;
	Tue,  7 Apr 2020 09:43:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9FC3C0177
 for <iommu@lists.linux-foundation.org>; Tue,  7 Apr 2020 09:43:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9B3D788287
 for <iommu@lists.linux-foundation.org>; Tue,  7 Apr 2020 09:43:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pZ+4tU0dhqQD for <iommu@lists.linux-foundation.org>;
 Tue,  7 Apr 2020 09:43:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7DC7982441
 for <iommu@lists.linux-foundation.org>; Tue,  7 Apr 2020 09:43:28 +0000 (UTC)
IronPort-SDR: NKJbmvLG2wlAaCl9naRM71H00v/tmVscKu/59288rDVWFwp8WLBjYoI5RpRJSH+zruWDqQJjqk
 EeVDGncOg9ww==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2020 02:43:27 -0700
IronPort-SDR: ADIj2PgCc549wdNYUg0B2hduccfdQAeDAlMT8s+6H2FSVKNI7E7kVIrh8I1malMuHVE0dlhJV0
 +pqscB6WzwhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,353,1580803200"; d="scan'208";a="361487857"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga001.fm.intel.com with ESMTP; 07 Apr 2020 02:43:27 -0700
Received: from fmsmsx125.amr.corp.intel.com (10.18.125.40) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 7 Apr 2020 02:43:27 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX125.amr.corp.intel.com (10.18.125.40) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 7 Apr 2020 02:43:27 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.22]) with mapi id 14.03.0439.000;
 Tue, 7 Apr 2020 17:43:23 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, Auger Eric
 <eric.auger@redhat.com>
Subject: RE: [PATCH v1 5/8] vfio/type1: Report 1st-level/stage-1 format to
 userspace
Thread-Topic: [PATCH v1 5/8] vfio/type1: Report 1st-level/stage-1 format to
 userspace
Thread-Index: AQHWAEUcqZEEdiOKbEGofjWp2Yic+6hjfq+AgAC/vLD//4YrAIAC1vWAgAbjh1A=
Date: Tue, 7 Apr 2020 09:43:23 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A2249DF@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-6-git-send-email-yi.l.liu@intel.com>
 <cb68e9ab-77b0-7e97-a661-4836962041d9@redhat.com>
 <A2975661238FB949B60364EF0F2C25743A21DB4E@SHSMSX104.ccr.corp.intel.com>
 <b47891b1-ece6-c263-9c07-07c09c7d3752@redhat.com>
 <20200403082305.GA1269501@myrica>
In-Reply-To: <20200403082305.GA1269501@myrica>
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

Hi Jean,

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Sent: Friday, April 3, 2020 4:23 PM
> To: Auger Eric <eric.auger@redhat.com>
> userspace
> 
> On Wed, Apr 01, 2020 at 03:01:12PM +0200, Auger Eric wrote:
> > >>>  	header = vfio_info_cap_add(caps, sizeof(*nesting_cap),
> > >>>  				   VFIO_IOMMU_TYPE1_INFO_CAP_NESTING, 1);
> @@ -2254,6 +2309,7
> > >>> @@ static int vfio_iommu_info_add_nesting_cap(struct
> > >> vfio_iommu *iommu,
> > >>>  		/* nesting iommu type supports PASID requests (alloc/free) */
> > >>>  		nesting_cap->nesting_capabilities |= VFIO_IOMMU_PASID_REQS;
> > >> What is the meaning for ARM?
> > >
> > > I think it's just a software capability exposed to userspace, on
> > > userspace side, it has a choice to use it or not. :-) The reason
> > > define it and report it in cap nesting is that I'd like to make the
> > > pasid alloc/free be available just for IOMMU with type
> > > VFIO_IOMMU_TYPE1_NESTING. Please feel free tell me if it is not good
> > > for ARM. We can find a proper way to report the availability.
> >
> > Well it is more a question for jean-Philippe. Do we have a system wide
> > PASID allocation on ARM?
> 
> We don't, the PASID spaces are per-VM on Arm, so this function should consult the
> IOMMU driver before setting flags. As you said on patch 3, nested doesn't
> necessarily imply PASID support. The SMMUv2 does not support PASID but does
> support nesting stages 1 and 2 for the IOVA space.
> SMMUv3 support of PASID depends on HW capabilities. So I think this needs to be
> finer grained:
> 
> Does the container support:
> * VFIO_IOMMU_PASID_REQUEST?
>   -> Yes for VT-d 3
>   -> No for Arm SMMU
> * VFIO_IOMMU_{,UN}BIND_GUEST_PGTBL?
>   -> Yes for VT-d 3
>   -> Sometimes for SMMUv2
>   -> No for SMMUv3 (if we go with BIND_PASID_TABLE, which is simpler due to
>      PASID tables being in GPA space.)
> * VFIO_IOMMU_BIND_PASID_TABLE?
>   -> No for VT-d
>   -> Sometimes for SMMUv3
> 
> Any bind support implies VFIO_IOMMU_CACHE_INVALIDATE support.

good summary. do you expect to see any 

> 
> > >>> +	nesting_cap->stage1_formats = formats;
> > >> as spotted by Kevin, since a single format is supported, rename
> > >
> > > ok, I was believing it may be possible on ARM or so. :-) will rename
> > > it.
> 
> Yes I don't think an u32 is going to cut it for Arm :( We need to describe all sorts of
> capabilities for page and PASID tables (granules, GPA size, ASID/PASID size, HW
> access/dirty, etc etc.) Just saying "Arm stage-1 format" wouldn't mean much. I
> guess we could have a secondary vendor capability for these?

Actually, I'm wondering if we can define some formats to stands for a set of
capabilities. e.g. VTD_STAGE1_FORMAT_V1 which may indicates the 1st level
page table related caps (aw, a/d, SRE, EA and etc.). And vIOMMU can parse
the capabilities.

Regards,
Yi Liu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
