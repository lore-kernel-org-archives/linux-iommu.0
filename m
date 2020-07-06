Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3EAC433E0
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 12:21:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF98206E6
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 12:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="u0QNXF3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF98206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 74C0E88182;
	Mon,  6 Jul 2020 12:21:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bOLgpraZW+kK; Mon,  6 Jul 2020 12:21:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 993C68806D;
	Mon,  6 Jul 2020 12:21:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78371C0891;
	Mon,  6 Jul 2020 12:21:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CC58C016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 12:21:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 14814875B6
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 12:21:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id re3jAgq63fIE for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 12:21:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C445187474
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 12:21:27 +0000 (UTC)
IronPort-SDR: r/8LkzRdBZKgmNTqP2+1GxtFSEN0tcSRyI5/1UeeaiMfWuiC9p9fItlWm4jgNdohlDrhaWEpz1
 w+LwjmeEBoVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="165467751"
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; d="scan'208";a="165467751"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 05:21:27 -0700
IronPort-SDR: fmipxoNdk+Xq8a1Kf8k8iLHO5fbzIUfIGz36fTc6c6KU8cqhj5WnyJNY67YSaXc3J/mf8YF9WE
 6XM9jZIWsuCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; d="scan'208";a="296992510"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga002.jf.intel.com with ESMTP; 06 Jul 2020 05:21:26 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jul 2020 05:21:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 6 Jul 2020 05:21:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Spj8j5QHw1JLmElSoP29h6ktP8m7jGWAxI0KL7f08eXs4NmQ0gPUJH2Fwi0L2Ox6Q3aKc2O8759OllLLKRfGjsN8o1f2g+TALammOPeDPjzsw8WCPBcBbhuzo1XWo5RtvUjIuMfyhHkzk6rxeRloMIZB2Zt3QO6sQ0wBHF7yJ/xbDcQ45J5dnXs49HORDW3sGoW39xdr3mRqtXaOvSMNFmmfdmNs3OYss2KR9Mom5V6k5iz6tekke+jqhz1aJNZ1yBpqqDnD0ozLD7c3Z9cgCesoYiMFzLKEF7amagWBmJ6+xrAnm4Y183AZotTFBwY8pfbMfozaG6q+Gt3hmgpp7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJeFqEUawpf62hVaj65b3Giw5ag2dvR2lOGJotoO0/Q=;
 b=EBQ8lArzyJOUNoH1DLYPl1M/95Nnv8wK+yzOcrg/fUjLxvC0MDg1dVSmpBkr2+EELxRlRgruCAnjM0H/rd6qx9Su0DPHhb2tj5NEWFPAb9xi2CzrF9AOcBuNRc3M8BLTbLnR2cAOxH9GpvZJRB3CGNSng02XLKVb+jiOFo0Gw95m+EcaITAjB+4XunJHrx0IAocfCbXW9Tt9A9gqJ0SXx0ZvmeEc0z8dl5fZkgaU6KuCH2jpWyk+8ziJICwI9A+tZlZj1FKZuLHa8HYH7sxwy0PU8LICzzLY1/sG100JVn5oqCQOMYByJ+Hw2UOX0G0qGNSL6TcHnrGdyO1FJ7ialA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJeFqEUawpf62hVaj65b3Giw5ag2dvR2lOGJotoO0/Q=;
 b=u0QNXF3sr+77vMFIfeaxyvarotOh4ugOdGNL9tbqyJ3SnHfxL9Wky6IfShMjg0gguYQw3mfCQw5gzfYv7I5XaQZa3us41ot2I59WJOua++ZLI/hcG2d6gS2831PnkUvamicr6RTjNI1DFZCmaoow3dn/sfs+NeiVTuqyUigYYkI=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR11MB2009.namprd11.prod.outlook.com (2603:10b6:3:15::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.27; Mon, 6 Jul 2020 12:20:26 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 12:20:26 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v4 02/15] iommu: Report domain nesting info
Thread-Topic: [PATCH v4 02/15] iommu: Report domain nesting info
Thread-Index: AQHWUfUZPmXy4q2mvk6wmPCF23Zkz6j6TVgAgAArcYA=
Date: Mon, 6 Jul 2020 12:20:26 +0000
Message-ID: <DM5PR11MB14352CBCB1966C0B9E418C7CC3690@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1593861989-35920-1-git-send-email-yi.l.liu@intel.com>
 <1593861989-35920-3-git-send-email-yi.l.liu@intel.com>
 <b9479f61-7f9e-e0ae-5125-ab15f59b1ece@redhat.com>
In-Reply-To: <b9479f61-7f9e-e0ae-5125-ab15f59b1ece@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f54fc402-e0a8-476e-c389-08d821a6f733
x-ms-traffictypediagnostic: DM5PR11MB2009:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB2009E71816A010378C908AE0C3690@DM5PR11MB2009.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xn/I0IrawQEYPv2g/8z4nxiV2CERDn7r9cb36/0iFqmBg3ckdjT4uarVyoT7fmULkq9E/YyCVzy2MVMWAOwzhMyrKk6odWOWnnM5Utyw0oSVYAr5Ots4Xo+tTj9jdyCP0rN51mLWiBYcFfUGbiaGQEUEJ3ekke/C2pkajK50d5r2bCvwXatfuQyhIeKy3y3TKA0jLlEZOiAmVWakogJWRIQSFRrAgHLuRo8Rd/9MRsdbMlajMuZ82houPIv7z0gb8XyHw7jHiHUdXjg37v9lg7SZVpKM6kyMRYKOB871wg3ZPb3qgt2OkoDVkX5Y4EFkf6UcgXNNQesSmQ0Xtu4sHg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(54906003)(33656002)(5660300002)(86362001)(52536014)(76116006)(478600001)(83380400001)(110136005)(7416002)(316002)(4326008)(186003)(7696005)(8936002)(71200400001)(8676002)(66476007)(66946007)(66556008)(64756008)(66446008)(26005)(55016002)(9686003)(2906002)(6506007)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Ix293tchpAxIBm8yt7PJtbBdr2a5btxivflIsFjYlhSJRgky/T1PjntIyggT8gCwNlCNbdJcX2i1YUYbNPbGIahQyq3uaTnOrostbDlcG37pTpm2gJ4VLsbaefNVP7Dmy+FcVwxqGSLJ2Tg0jWOyqzvMAgZkWSH8ZIF6ddYZf4UynzKS4vEvtVJShEgxLeT4P+rjlz27rf/obu8mxypfX1CKhKdqiqnuBlO8mghtVimgildRRfzs5wS/w/Jbmv1yCZjO4fAC2CZjdo05m6fuwQ9rfE69ar2wjfEiT+CkDgZXPCTq4FU4UdZ5dyRUGUtOajtrAt047hRZit1Nszqdk8noewvJeDc3UwRp2i1dFtktCEkc/qRkHbiIv5zQyRv8JzVhdi18VflK2nz7W5zaXt6K6hO3qAW9wKQEzqCQF+KeNWpBdYSGo2WPxqJ3o8eEbdd5Tcuf7lKKul880NMWCSPZoHzXfa4oZzBhU1vGClq8tyB+X80LCE0eM6zF94NL
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54fc402-e0a8-476e-c389-08d821a6f733
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 12:20:26.7658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GMFu4wmdq5pchzoiLkxIsLVbm3kPZPGKkTxyqeOZlJwVjLfa80bE0/oeapxd/qsOwLhRMOn6n902/cWP1QT7uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB2009
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Tian, 
 Jun J" <jun.j.tian@intel.com>,
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

Hi Eric,

> From: Auger Eric <eric.auger@redhat.com>
> Sent: Monday, July 6, 2020 5:34 PM
> 
> On 7/4/20 1:26 PM, Liu Yi L wrote:
> > IOMMUs that support nesting translation needs report the capability info
> need to report
> > to userspace, e.g. the format of first level/stage paging structures.
> >
> > This patch reports nesting info by DOMAIN_ATTR_NESTING. Caller can get
> > nesting info after setting DOMAIN_ATTR_NESTING.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> > v3 -> v4:
> > *) split the SMMU driver changes to be a separate patch
> > *) move the @addr_width and @pasid_bits from vendor specific
> >    part to generic part.
> > *) tweak the description for the @features field of struct
> >    iommu_nesting_info.
> > *) add description on the @data[] field of struct iommu_nesting_info
> >
> > v2 -> v3:
> > *) remvoe cap/ecap_mask in iommu_nesting_info.
> > *) reuse DOMAIN_ATTR_NESTING to get nesting info.
> > *) return an empty iommu_nesting_info for SMMU drivers per Jean'
> >    suggestion.
> > ---
> >  include/uapi/linux/iommu.h | 78
> ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 78 insertions(+)
> >
> > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > index 1afc661..1bfc032 100644
> > --- a/include/uapi/linux/iommu.h
> > +++ b/include/uapi/linux/iommu.h
> > @@ -332,4 +332,82 @@ struct iommu_gpasid_bind_data {
> >  	} vendor;
> >  };
> >
> > +/*
> > + * struct iommu_nesting_info - Information for nesting-capable IOMMU.
> > + *				user space should check it before using
> > + *				nesting capability.
> alignment?

oh, yes, will do it.

> > + *
> > + * @size:	size of the whole structure
> > + * @format:	PASID table entry format, the same definition with
> > + *		@format of struct iommu_gpasid_bind_data.
> the same definition as struct iommu_gpasid_bind_data @format?

right. yours is much better.

> > + * @features:	supported nesting features.
> > + * @flags:	currently reserved for future extension.
> > + * @addr_width:	The output addr width of first level/stage translation
> > + * @pasid_bits:	Maximum supported PASID bits, 0 represents no PASID
> > + *		support.
> > + * @data:	vendor specific cap info. data[] structure type can be deduced
> > + *		from @format field.
> > + *
> > + *
> +===============+===================================================
> ===+
> > + * | feature       |  Notes                                               |
> > + *
> +===============+===================================================
> ===+
> > + * | SYSWIDE_PASID |  PASIDs are managed in system-wide, instead of per   |
> > + * |               |  device. When a device is assigned to userspace or   |
> > + * |               |  VM, proper uAPI (userspace driver framework uAPI,   |
> > + * |               |  e.g. VFIO) must be used to allocate/free PASIDs for |
> > + * |               |  the assigned device.                                |
> > + * +---------------+------------------------------------------------------+
> > + * | BIND_PGTBL    |  The owner of the first level/stage page table must  |
> > + * |               |  explicitly bind the page table to associated PASID  |
> > + * |               |  (either the one specified in bind request or the    |
> > + * |               |  default PASID of iommu domain), through userspace   |
> > + * |               |  driver framework uAPI (e.g. VFIO_IOMMU_NESTING_OP). |
> > + * +---------------+------------------------------------------------------+
> > + * | CACHE_INVLD   |  The owner of the first level/stage page table must  |
> > + * |               |  explicitly invalidate the IOMMU cache through uAPI  |
> > + * |               |  provided by userspace driver framework (e.g. VFIO)  |
> > + * |               |  according to vendor-specific requirement when       |
> > + * |               |  changing the page table.                            |
> > + * +---------------+------------------------------------------------------+
> Do you foresee cases where BIND_PGTBL and CACHE_INVLD shouldn't be
> exposed as features?

sorry, I didn't quite get it. could you explain a little bit more. :-)

> > + *
> > + * @data[] types defined for @format:
> > + *
> +================================+==================================
> ===+
> > + * | @format                        | @data[]                             |
> > + *
> +================================+==================================
> ===+
> > + * | IOMMU_PASID_FORMAT_INTEL_VTD   | struct iommu_nesting_info_vtd       |
> > + * +--------------------------------+-------------------------------------+
> > + *
> > + */
> > +struct iommu_nesting_info {
> > +	__u32	size;
> > +	__u32	format;
> > +	__u32	features;
> > +#define IOMMU_NESTING_FEAT_SYSWIDE_PASID	(1 << 0)
> > +#define IOMMU_NESTING_FEAT_BIND_PGTBL		(1 << 1)
> > +#define IOMMU_NESTING_FEAT_CACHE_INVLD		(1 << 2)
> In other structs the values seem to be defined before the field

not sure. :-) I mimics the below struct from uapi/vfio.h

struct vfio_iommu_type1_dma_map {
        __u32   argsz;
        __u32   flags;
#define VFIO_DMA_MAP_FLAG_READ (1 << 0)         /* readable from device */
#define VFIO_DMA_MAP_FLAG_WRITE (1 << 1)        /* writable from device */
        __u64   vaddr;                          /* Process virtual address */
        __u64   iova;                           /* IO virtual address */
        __u64   size;                           /* Size of mapping (bytes) */
};

> > +	__u32	flags;
> > +	__u16	addr_width;
> > +	__u16	pasid_bits;
> > +	__u32	padding;
> > +	__u8	data[];
> > +};
> > +
> > +/*
> > + * struct iommu_nesting_info_vtd - Intel VT-d specific nesting info
> > + *
> spurious line

yes, will remove this line.

Regards,
Yi Liu

> > + *
> > + * @flags:	VT-d specific flags. Currently reserved for future
> > + *		extension.
> > + * @cap_reg:	Describe basic capabilities as defined in VT-d capability
> > + *		register.
> > + * @ecap_reg:	Describe the extended capabilities as defined in VT-d
> > + *		extended capability register.
> > + */
> > +struct iommu_nesting_info_vtd {
> > +	__u32	flags;
> > +	__u32	padding;
> > +	__u64	cap_reg;
> > +	__u64	ecap_reg;
> > +};
> > +
> >  #endif /* _UAPI_IOMMU_H */
> >
> Thanks
> 
> Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
