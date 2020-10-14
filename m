Return-Path: <SRS0=zShu=DV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA18CC433DF
	for <iommu@archiver.kernel.org>; Wed, 14 Oct 2020 03:16:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC1420723
	for <iommu@archiver.kernel.org>; Wed, 14 Oct 2020 03:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="KP/OdPTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC1420723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1D4548795B;
	Wed, 14 Oct 2020 03:16:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rp51z5zbY95e; Wed, 14 Oct 2020 03:16:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 46ABB87650;
	Wed, 14 Oct 2020 03:16:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 289DBC0052;
	Wed, 14 Oct 2020 03:16:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02C2EC0051
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 03:16:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DFD3E2E207
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 03:16:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JjJLcFClhLA4 for <iommu@lists.linux-foundation.org>;
 Wed, 14 Oct 2020 03:16:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by silver.osuosl.org (Postfix) with ESMTPS id D9E892E203
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 03:16:28 +0000 (UTC)
IronPort-SDR: hc0LKGC6w0A0pOpZDpHOX3HzpLESm/XS/flKcRQFbkFuO7tAKyBkHdIZpJjt1/ZbYBRZfOl3qY
 p/rFxzuv3RlQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="145886595"
X-IronPort-AV: E=Sophos;i="5.77,373,1596524400"; d="scan'208";a="145886595"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2020 20:16:28 -0700
IronPort-SDR: 6QCFfIZ128vB61U1C+aj3TZPFYr7NkXBD2B4QKX5OJQAL5CB348XvFnzNsyPopLzJs+klu2Dmr
 EwgP23Oq6ekA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,373,1596524400"; d="scan'208";a="299813896"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by fmsmga007.fm.intel.com with ESMTP; 13 Oct 2020 20:16:28 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 13 Oct 2020 20:16:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 13 Oct 2020 20:16:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 13 Oct 2020 20:16:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 13 Oct 2020 20:16:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiuOUieHfdHKZJwIpIBUURu+NZPzy0Vnvt0JFKad8pgBamNYlybBATXSHA7nn8Ew2BfBnt4+UfdO0b7KgkkDdwkHZyf/s19gvw/9KDiXwSTtvkF8T0SgKxugn8++bsRCCkjZuL/ghIepIQoDRDFoIj0yPXP/pZhi8Fcj8fTrKvNhT/rkcTs1IGXDfoIftMj0i905NwDr1I/IK1iZRG/GuOpiyeUL0fJTH2L4FyEyaAMqQ3tQyIeYG8PvWlGF5bknwud4CYhX67Oj/FfQiJT/1kfbZEvc2AkbVnJK+PUNN11uFO5Vu7mk66daFyYI7iGCzQnNmyaka28QUu3GXFKjYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyP74VFb83xsN+co1DLSiZl3jyOmtX15n15xQPVZHpY=;
 b=NuIsfK/7SVC/Ii6joQgSorCTgB0b98pMKxZaJq4w8sN+gifTagO2tWmgwYNHHIp9rYcTaiOpt8WmS9TU/L3Nkf0eq1pZnKQO5EzA0fPnL0ZZu2YTzMNiCQeBWSpUeV8pSJt2PAQZQH/S60AF2N0gIemqFb+KLo1LT/Q+rlcCoXw2KC1UFvwbu5bxItm0XtreXJ2E2qoVwHNMNYtp/Fz6ajxxs6wjOcoHJTR79TyTEne4A+ItzrxlcPNPYcDzsM91i8B9HMgw7lDpeiRY+QciMe8a+3gqqjJ7Y/fAx5Vu235ptVDnz8AscCUqMPNHZwLNxOeVyRg0rac/HJJ5PY3RdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyP74VFb83xsN+co1DLSiZl3jyOmtX15n15xQPVZHpY=;
 b=KP/OdPTsNoGbS6iioZeimHhLB0X/s5StnCCte7tOfPT30OqejIdWCkJa9Owz9f5qrpYjJONKgyJchVTehdbehktgs5sanM8JsAxFq+iYctbESeVvLPqLhTDJxWHym/+EQcemwlP+8AZQ484EhUcMzjdo4Rgb8GE+zM37AdPYol0=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MW3PR11MB4603.namprd11.prod.outlook.com (2603:10b6:303:5e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Wed, 14 Oct
 2020 03:16:22 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::c88f:585f:f117:930b]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::c88f:585f:f117:930b%8]) with mapi id 15.20.3455.032; Wed, 14 Oct 2020
 03:16:22 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Wang <jasowang@redhat.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Thread-Topic: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Thread-Index: AdagceQQLvqwjRCrQOaq1hZ7MgDUUABZWmqg
Date: Wed, 14 Oct 2020 03:16:22 +0000
Message-ID: <MWHPR11MB1645AE971BD8DAF72CE3E1198C050@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <MWHPR11MB1645CFB0C594933E92A844AC8C070@MWHPR11MB1645.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB1645CFB0C594933E92A844AC8C070@MWHPR11MB1645.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c738281-2b06-4952-544c-08d86fef8726
x-ms-traffictypediagnostic: MW3PR11MB4603:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB460339A11309AD66746F1D868C050@MW3PR11MB4603.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Id3HbMu/SuNBhG1EnSJ9qyya97VYQQYsgdXeJonVgmo8TmaBqLobfN3md/aq99KE2Kvu2fbqCtckyLgl9Fi+mDof2rysNfK61sYfrYoUlqtAU2KKsXkL2Hf18BybXFIsXrQXEcGvkfIVQAincMg3gK1xKJXHSomxxlD5G6Y67mUH7eWYR+6vILqcVn+v5y3DGuIlPcG3gUKXQPX48gx2UQcdFDy8dI1nvVlpybdjdxzWjhFKaT0uxYf2R7k4hOQ4mEsMa1eu0bze/Y5zzDdKU0NL3WTmWUef+4ECv2jzk8c14QpcKoQ2g5A2v1iNw9Z0OQ0tsBJ/FFzUTgHb3CpDIA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(7696005)(83380400001)(55016002)(71200400001)(8676002)(8936002)(86362001)(478600001)(6506007)(9686003)(7416002)(186003)(26005)(33656002)(2906002)(54906003)(110136005)(66476007)(316002)(4326008)(76116006)(66946007)(52536014)(64756008)(66446008)(5660300002)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: MN9Ec4pZ0mNKgmyoedTd+EvBtiLNhLSjZrgBdTy+spGmxKuCZay4ncwLpYcjazLGZCb17Gvdnqh8xmjnm2UiWl3C8XzXTBazWZBbvnsP/hYDbL+OS6jrUl+yZL2Vn0QA9Qk98+l2vCXsrX671gswJK4SGMkosgFRAwCliNRZJYb2egGwSGfedK0Vc26WAL4KQxMzONhKroUkPOSzO6zbnQVsHIzs+YWBd1Jt1DqIugq9naedfBUsT92UhESHa9do2hkvfZfnR+ShDyEOgl5yiqyav5YSRIbuYscoZ8OJ5HT+CIbcoDUP/PtzSSpojW+Mkd95RqkldkYVUGU6I8esQWuQdsNkhc72vEIxoEfdZcNyqHcqoh1GcV0E0HCGTRQr/WGpWHt6ZNVQO0vw4axfL/3Y8Gx0C3/+l9CQm+4wx0JZaG2J124mKt4qoQjtyF3m/jOQrKicm/R9IlofZYFczcIrfBYqkdoKzIunBLkSmO8zA62ilH6XjWeNiIei60dsvG5IqWz+mOAgwwiGv6VFe72PZbE9VG31P2l9ApWgiG37fu1PMAImmsrjBNiffQ/E6me/rZm8LntnX9hHz8fagM6EXhszQTnDDwkPZefDQ7DxK1Eq3OA82i0OqgLJLwkKnOqqzbx7RbhVKwYFuJr9lg==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c738281-2b06-4952-544c-08d86fef8726
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 03:16:22.5679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Me+X5cVm6eETQQW/Fger3Ew2U6Kh61t85SsXth2c4umIJXoMmeFq8aajFp1HmH+VbGUtqm+/gsCN8xHQbMHoxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4603
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, "Wu,
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

Hi, Alex and Jason (G),

How about your opinion for this new proposal? For now looks both
Jason (W) and Jean are OK with this direction and more discussions
are possibly required for the new /dev/ioasid interface. Internally 
we're doing a quick prototype to see any unforeseen issue with this
separation. 

Please let us know your thoughts.

Thanks
Kevin

> From: Tian, Kevin <kevin.tian@intel.com>
> Sent: Monday, October 12, 2020 4:39 PM
> 
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Monday, September 14, 2020 12:20 PM
> >
> [...]
>  > If it's possible, I would suggest a generic uAPI instead of a VFIO
> > specific one.
> >
> > Jason suggest something like /dev/sva. There will be a lot of other
> > subsystems that could benefit from this (e.g vDPA).
> >
> > Have you ever considered this approach?
> >
> 
> Hi, Jason,
> 
> We did some study on this approach and below is the output. It's a
> long writing but I didn't find a way to further abstract w/o losing
> necessary context. Sorry about that.
> 
> Overall the real purpose of this series is to enable IOMMU nested
> translation capability with vSVA as one major usage, through
> below new uAPIs:
> 	1) Report/enable IOMMU nested translation capability;
> 	2) Allocate/free PASID;
> 	3) Bind/unbind guest page table;
> 	4) Invalidate IOMMU cache;
> 	5) Handle IOMMU page request/response (not in this series);
> 1/3/4) is the minimal set for using IOMMU nested translation, with
> the other two optional. For example, the guest may enable vSVA on
> a device without using PASID. Or, it may bind its gIOVA page table
> which doesn't require page fault support. Finally, all operations can
> be applied to either physical device or subdevice.
> 
> Then we evaluated each uAPI whether generalizing it is a good thing
> both in concept and regarding to complexity.
> 
> First, unlike other uAPIs which are all backed by iommu_ops, PASID
> allocation/free is through the IOASID sub-system. From this angle
> we feel generalizing PASID management does make some sense.
> First, PASID is just a number and not related to any device before
> it's bound to a page table and IOMMU domain. Second, PASID is a
> global resource (at least on Intel VT-d), while having separate VFIO/
> VDPA allocation interfaces may easily cause confusion in userspace,
> e.g. which interface to be used if both VFIO/VDPA devices exist.
> Moreover, an unified interface allows centralized control over how
> many PASIDs are allowed per process.
> 
> One unclear part with this generalization is about the permission.
> Do we open this interface to any process or only to those which
> have assigned devices? If the latter, what would be the mechanism
> to coordinate between this new interface and specific passthrough
> frameworks? A more tricky case, vSVA support on ARM (Eric/Jean
> please correct me) plans to do per-device PASID namespace which
> is built on a bind_pasid_table iommu callback to allow guest fully
> manage its PASIDs on a given passthrough device. I'm not sure
> how such requirement can be unified w/o involving passthrough
> frameworks, or whether ARM could also switch to global PASID
> style...
> 
> Second, IOMMU nested translation is a per IOMMU domain
> capability. Since IOMMU domains are managed by VFIO/VDPA
>  (alloc/free domain, attach/detach device, set/get domain attribute,
> etc.), reporting/enabling the nesting capability is an natural
> extension to the domain uAPI of existing passthrough frameworks.
> Actually, VFIO already includes a nesting enable interface even
> before this series. So it doesn't make sense to generalize this uAPI
> out.
> 
> Then the tricky part comes with the remaining operations (3/4/5),
> which are all backed by iommu_ops thus effective only within an
> IOMMU domain. To generalize them, the first thing is to find a way
> to associate the sva_FD (opened through generic /dev/sva) with an
> IOMMU domain that is created by VFIO/VDPA. The second thing is
> to replicate {domain<->device/subdevice} association in /dev/sva
> path because some operations (e.g. page fault) is triggered/handled
> per device/subdevice. Therefore, /dev/sva must provide both per-
> domain and per-device uAPIs similar to what VFIO/VDPA already
> does. Moreover, mapping page fault to subdevice requires pre-
> registering subdevice fault data to IOMMU layer when binding
> guest page table, while such fault data can be only retrieved from
> parent driver through VFIO/VDPA.
> 
> However, we failed to find a good way even at the 1st step about
> domain association. The iommu domains are not exposed to the
> userspace, and there is no 1:1 mapping between domain and device.
> In VFIO, all devices within the same VFIO container share the address
> space but they may be organized in multiple IOMMU domains based
> on their bus type. How (should we let) the userspace know the
> domain information and open an sva_FD for each domain is the main
> problem here.
> 
> In the end we just realized that doing such generalization doesn't
> really lead to a clear design and instead requires tight coordination
> between /dev/sva and VFIO/VDPA for almost every new uAPI
> (especially about synchronization when the domain/device
> association is changed or when the device/subdevice is being reset/
> drained). Finally it may become a usability burden to the userspace
> on proper use of the two interfaces on the assigned device.
> 
> Based on above analysis we feel that just generalizing PASID mgmt.
> might be a good thing to look at while the remaining operations are
> better being VFIO/VDPA specific uAPIs. anyway in concept those are
> just a subset of the page table management capabilities that an
> IOMMU domain affords. Since all other aspects of the IOMMU domain
> is managed by VFIO/VDPA already, continuing this path for new nesting
> capability sounds natural. There is another option by generalizing the
> entire IOMMU domain management (sort of the entire vfio_iommu_
> type1), but it's unclear whether such intrusive change is worthwhile
> (especially when VFIO/VDPA already goes different route even in legacy
> mapping uAPI: map/unmap vs. IOTLB).
> 
> Thoughts?
> 
> Thanks
> Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
