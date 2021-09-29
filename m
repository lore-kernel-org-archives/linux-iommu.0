Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591D8C433F5
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 10:47:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B8E6141B
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 10:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 10B8E6141B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF96C60AE6;
	Wed, 29 Sep 2021 10:47:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TIB0S4WZo168; Wed, 29 Sep 2021 10:47:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9B9F0606A7;
	Wed, 29 Sep 2021 10:47:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69118C000F;
	Wed, 29 Sep 2021 10:47:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C87BC000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 10:47:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E3DC1606A7
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 10:47:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wfzy3q7aARmB for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 10:47:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1EDE260650
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 10:47:13 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="285928629"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; d="scan'208";a="285928629"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 03:47:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; d="scan'208";a="519731014"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by fmsmga008.fm.intel.com with ESMTP; 29 Sep 2021 03:47:10 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 29 Sep 2021 03:47:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 29 Sep 2021 03:47:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 29 Sep 2021 03:47:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBjruPZ4R8CFh92XG/v8d1mJbgSk++QRzSHr+uHtxj4ElrP3u1n/YlCHrDghzSAxqxMgDd1SDNnRhEgHV0LXwbeKO3iBLsxejEBq5B/W4tV/WRkwL9pKa7gqhbHcVmJYVHTr3BMEGQ+Euafb52CQArL51+jD9zbLBhx8jpk7Aqe60gJf4MWeFwcY2oAdtTIHaFtlBgQaFzSmslCpPDIFgbro+035dxE+KXz8i0l/NdqAUJKgem0xmBluIirCDjJ0DOvOFyDkB7TPNWKSY+Er9kQvNWqX29uruEUXyzPWwnovfEjLviYABjS+4oQrQao5Fy8OT/4OeMfjz7Yp2QZuyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=5OIw/5kaQyKNrFN6mRw2PD4Vlqv5Prg4H4M6bUpOw3A=;
 b=IpCgTgEQgdETE0bDEe+JO8s9j3UwyNJqueLOaoCmWbVjs1Pk8/lZfXZLnyKSPctJGxisjLHhg/QWYEjrs9af6qNgWLRVa65jI0/h7Vf4sI1Zab0wKar/1c0VU7rgzbECsddmztajKEgHCDnNixGgDs9KVVFeANsoO15BX8qbo+wdhHgQ77XnE+1Tjx4bubLluuJiPTF0lYUSDUlw0GmeH4IEQotnSLglWOOFyMID6U2PWQghGpWXdzbTUzw+0xPVAL4COmMfGhQm/i7ttSwWO5j1mtS3SF0VJsOKLdIosoNJfoMRZ/VcFZKIC0NOA3f5e9RARPTFy3vT4vfUqJuHsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OIw/5kaQyKNrFN6mRw2PD4Vlqv5Prg4H4M6bUpOw3A=;
 b=DicURSF0m0AAEYNBVG6C6ttkkye9097/6/hjdrh8jX5cJhvV/s+WWSrakuNLVgeKj9tjM22bgTNK/YbZRIVJdG9VOG8myIFlD7W3b7kT7E0OCGBecuGpN3tvgvlXns90C90fbVSvpSFK6rorAl9xF4EHBoTkjNlmwErZtS0/0lg=
Received: from PH0PR11MB5658.namprd11.prod.outlook.com (2603:10b6:510:e2::23)
 by PH0PR11MB5579.namprd11.prod.outlook.com (2603:10b6:510:e6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Wed, 29 Sep
 2021 10:47:04 +0000
Received: from PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::5009:9c8c:4cb4:e119]) by PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::5009:9c8c:4cb4:e119%6]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 10:47:04 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: RE: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Thread-Topic: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Thread-Index: AQHXrSGQLQh7Daiwk0GPvXz/w70XfquwFdqAgAEXIGA=
Date: Wed, 29 Sep 2021 10:47:04 +0000
Message-ID: <PH0PR11MB56589A10B7ED54CB59337ED7C3A99@PH0PR11MB5658.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-12-yi.l.liu@intel.com> <YUszZRk1vZOgVvFF@myrica>
In-Reply-To: <YUszZRk1vZOgVvFF@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 433a131d-69ce-4d4c-f571-08d9833679f8
x-ms-traffictypediagnostic: PH0PR11MB5579:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5579CEFA48C9B87FBAD3F462C3A99@PH0PR11MB5579.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8S5/IyOeHxsmTPIKxkw/sRb7h9/YlV/V1tuLrTAMC8S59TKMgmguzRsHXHSd18TQcVZp6q87TSqaPRCKVuy77ZObyvEtFq7JhuW37L29EWKjD8e725ZBhItp4pMC5a1VtHWFnMIWty5hp1YS/GN4w/mwiIvSppZ7nHjAoGVydIs/4tjVNFNmszlJL5guwx/QFQRZK6En5uEugTrwgD5/9/1eU4mlpRFB/316m+DonmNvVEhJuEXIQ181eYLzUh25ptGD8JqJOUv5SoiHpK4g+JSQ6c7ptcvaQmmAA1SQLLDOVuMJInZ90ylgMw0cecSKwcE9FGbPEuMINkxb0ReEUpNmKYwTmuGV2mRA/6BwYxSxnI4zDmdNq1ikiW0jn7wrnB60bnNEsujvZNFv+Q+cKjuGJGElc84yIGtpMarQr2i7D+ZsFuTcMM/Bo3d/2oxyC29ItkBUWaes4QP6PNSiVf2HJpS4xEg7W6HfJq0UmZDGrqzwWhCjiWGV6WgUQcQ9qDSwNYuq1kH4Si3B1ARqJ0FQ30yoKa9DO6xhQCBmeBQ77q8pk/o8urhECsW1fN4L8uH59QotS0iP5Gc1sMTNeFnacOa1M9XCgR9EcIFY0/RH0tY3Cm4FvVabY7Kez29H2NYEhmdZauNCrrfqJs5pbTo3hV60L1KSZm5NuT9lyBKVOCuIfRKArCR0bdAHfoHArukYEOEPi6939BnfXY40040oEyRqgLq9rp+MOO+DPI0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5658.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016002)(7696005)(76116006)(38100700002)(9686003)(86362001)(5660300002)(316002)(122000001)(71200400001)(7416002)(8676002)(4326008)(186003)(52536014)(8936002)(33656002)(2906002)(38070700005)(26005)(6506007)(6916009)(508600001)(64756008)(66446008)(83380400001)(66556008)(66476007)(54906003)(66946007)(84603001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wqMAjr5I8449M4GAiPNYyheopPUHC2L4o0YN7EO0X+TyNy+ILkAY96xsvcCF?=
 =?us-ascii?Q?5w5IwuHdGXrKbv9mCMyAQBTTPO0sM0/LiV4WBu/h/uFSGdHAmiDBT8+2VcSy?=
 =?us-ascii?Q?8VO7YB/C46p/Dci6qVPgVWq6Y+R1kcS3IYcuSmg8OgBv4yzlVSr1Em2l8u9j?=
 =?us-ascii?Q?+9n6hBaey82G8WHPkSMUIwHPRr7Dsz7ZWE9C6bHfnVyU9FuQ/iJhXHp0F/Dp?=
 =?us-ascii?Q?VXRqND+bYIoSzylsXccaPWeMR79yD/s2KRDMkdXpNqFOE2a34VQHk1fx9ehc?=
 =?us-ascii?Q?FrkJjOp9I3g8Fjfe7pxy4GCVaqNfayY/EBqhImJmHsMTqXGYHk+GSxlk5TND?=
 =?us-ascii?Q?CCuQon+qmA3s6CHBXPHfDOTf0O26kO9RX0R2EB3j0umgz5fhD9ZStlrDeKlv?=
 =?us-ascii?Q?Yyafz7PjFwhAEgNMPZeWq3v2WZ8pno+5Z+Q8OVz0GSSTUgxOStAqft4AC5nT?=
 =?us-ascii?Q?EgLph4tcvS5xvFevPwoJE1ztFhzZcfBzejqadqAE8qtRIEioW9puGpTe0rx5?=
 =?us-ascii?Q?FRP5chqH33p9eH+mQrLVLxm/lPWHa+4oSiGRfyBQg8MAz171zY0yZIqarytr?=
 =?us-ascii?Q?M4OyTB3Y+SUQ1eSRKM0v+vHfzsR9cCF02x8VIURsxJUgvE9rbV4KPjsue5GS?=
 =?us-ascii?Q?fa88fu2BsU5jlo3SXkIx3DLHKIMHSOqb8toxGDUdpLZ+jSZj3JYPzqNrg1A/?=
 =?us-ascii?Q?hjCFSQAaHmC++HEMeYh3ukxf2Wwmy8AbYLuCqWj/g5mBFB/gMNFAfOdBI+LW?=
 =?us-ascii?Q?QRyzxuwShR86fEnOeyM/iPGdPtT/C0VO4CPLMvq23BWTMuOXrPDBz+hqJ4Zi?=
 =?us-ascii?Q?oG8PgPxlUj2tTZHA6xkR5ySlTk38eIpbHBQ+1rOA8dBiBuWFp87VRGXn/uSW?=
 =?us-ascii?Q?U6vNUPWSDzIj7R7YVi3AfA6nbu0L1RJb/QUPwwr+NelPHsSzJI8cTw+whLzC?=
 =?us-ascii?Q?Xsg2t0eyGsjzVhUFfigiVXXJpl8qnSPskwnJNem51YqIM1n7LhlQcGpV+mKm?=
 =?us-ascii?Q?RYdAN0D4hT2cwZCMjDl21A8CC5s+piDxS8CnzhHiKYqabxxBdxEkebJ+1BpM?=
 =?us-ascii?Q?AupBoUK2zLbll678fnBvicKFky3zsTuVeuE1OxSHanH+U9i8mvupJgQTaIZI?=
 =?us-ascii?Q?WNqc0JWpBo4OFPtyzwIsCKiVDtkUYFSmJZQKidDIYreV8XtmEfPLiFOehYv7?=
 =?us-ascii?Q?PrgBH76HfCM6Vk6ByT1ncALGgXU5BZ9qGqjfcTAnV1nzxN3jypf8xvtiCK68?=
 =?us-ascii?Q?B7OciJrq+zXEQoG27Nd/nQXHCibX0Kbgpbo/a1YdPglbVn9gEplYMklKKaRX?=
 =?us-ascii?Q?DfNegXePweZrxTctYBXGT0Hj?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5658.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 433a131d-69ce-4d4c-f571-08d9833679f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 10:47:04.4460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KwzzvqfORdMhv87Hqmz2QlfmV/R++YIMvZXoT+/Duf2ImGGBxUxU95+uOFkhLmvGPSLphXOi4pjat8Xri2HeRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5579
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "jgg@nvidia.com" <jgg@nvidia.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Sent: Wednesday, September 22, 2021 9:45 PM
> 
> On Sun, Sep 19, 2021 at 02:38:39PM +0800, Liu Yi L wrote:
> > This patch adds IOASID allocation/free interface per iommufd. When
> > allocating an IOASID, userspace is expected to specify the type and
> > format information for the target I/O page table.
> >
> > This RFC supports only one type
> (IOMMU_IOASID_TYPE_KERNEL_TYPE1V2),
> > implying a kernel-managed I/O page table with vfio type1v2 mapping
> > semantics. For this type the user should specify the addr_width of
> > the I/O address space and whether the I/O page table is created in
> > an iommu enfore_snoop format. enforce_snoop must be true at this
> point,
> > as the false setting requires additional contract with KVM on handling
> > WBINVD emulation, which can be added later.
> >
> > Userspace is expected to call IOMMU_CHECK_EXTENSION (see next patch)
> > for what formats can be specified when allocating an IOASID.
> >
> > Open:
> > - Devices on PPC platform currently use a different iommu driver in vfio.
> >   Per previous discussion they can also use vfio type1v2 as long as there
> >   is a way to claim a specific iova range from a system-wide address space.
> 
> Is this the reason for passing addr_width to IOASID_ALLOC?  I didn't get
> what it's used for or why it's mandatory. But for PPC it sounds like it
> should be an address range instead of an upper limit?

yes, as this open described, it may need to be a range. But not sure
if PPC requires multiple ranges or just one range. Perhaps, David may
guide there.

Regards,
Yi Liu
 
> Thanks,
> Jean
> 
> >   This requirement doesn't sound PPC specific, as addr_width for pci
> devices
> >   can be also represented by a range [0, 2^addr_width-1]. This RFC hasn't
> >   adopted this design yet. We hope to have formal alignment in v1
> discussion
> >   and then decide how to incorporate it in v2.
> >
> > - Currently ioasid term has already been used in the kernel
> (drivers/iommu/
> >   ioasid.c) to represent the hardware I/O address space ID in the wire. It
> >   covers both PCI PASID (Process Address Space ID) and ARM SSID (Sub-
> Stream
> >   ID). We need find a way to resolve the naming conflict between the
> hardware
> >   ID and software handle. One option is to rename the existing ioasid to be
> >   pasid or ssid, given their full names still sound generic. Appreciate more
> >   thoughts on this open!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
