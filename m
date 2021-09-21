Return-Path: <SRS0=55Rd=OL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F2BC4332F
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 23:10:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CCA611C9
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 23:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C4CCA611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 88A5940289;
	Tue, 21 Sep 2021 23:10:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5daKm9MnBH5a; Tue, 21 Sep 2021 23:10:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2024740017;
	Tue, 21 Sep 2021 23:10:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2B96C0011;
	Tue, 21 Sep 2021 23:10:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE065C000D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 23:10:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9082E40652
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 23:10:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qL8UW4Kh9Und for <iommu@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 23:10:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 704B140650
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 23:10:23 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="223513068"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; d="scan'208";a="223513068"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2021 16:10:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; d="scan'208";a="703319370"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga005.fm.intel.com with ESMTP; 21 Sep 2021 16:10:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 21 Sep 2021 16:10:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 21 Sep 2021 16:10:17 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 21 Sep 2021 16:10:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKidkQXiPOnCv3AcWDn5rRN7vETUlWtGvfbaK7nqXW6A+iliVMs37AheU42+jpCAkRuireWHAz6YTn5bYy2NcfKftTfCieAOI+gYVHDVg5flkJGJHrIyE5OCEiB9S3F2VH2371tvphL2i+aBVowikpiLyDU9B4rTLs1a5OFCwCSOQkpjWdHd5KBDcalqNKJFf+mXqlPj38KctsgXWxoB3GOByie8suML0hEkhJym5A1rJsoYksBKleG118fLgBUsacuHElOSaiZyAWS+aaglOCyBhy7+Gx09F01OrbkKl13BMpLnj81Cl0OpW9W/4kNcJBKFNjOxB2kk5htBrF5RJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=vdO4t/TxronB4j2c1O7P3L8OgX+i8LgqTN1kBy1p6zs=;
 b=YzocPXnMm0TbjaqXViTwlaABXjBzBAfEjKFifoNCmwQvZwrfN0hDYmbi05ji1rlttce3MwL/xcrALlOCmW0O9DDNEnnAhOcoJBOd1vuft0Zjdp4NqzZtCo8aFB8jqLGW3P/fEUp6uDBwdSBxvqpmdhQeGMo+DyFu6pmSZz+dGQsrwj3UFDtbTuRuRL1TmmSEoHLqgHTdw/WatbuR9ORQU6/WBdu9IJCKVUlr2EkN0W8Y1fPM+efD4BqrxZpJrfYVZp9uHNcWFkt5onsGvYqc1krMNoXPMjXwlGPiqcwj8eZh+AjUEfy3OxR/0D7UkIyaMDCfIth6aWRG8AwqdBW8Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdO4t/TxronB4j2c1O7P3L8OgX+i8LgqTN1kBy1p6zs=;
 b=rjw0svKmCyzwL/1rRqK/AT3VOOHeTAdCUoKtGulmWP3f/a3gmcASA8lZvmx6+EfquegAbpD+awNj3+3cwL/LkVtxnb4yFaMRoLVG0o9nNeLX/ghQVQkZXwpn7HXcDIn9Mzc0QabAIUwZA48h13B6haFKEGP35S+OvdT1a0nT61s=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN9PR11MB5356.namprd11.prod.outlook.com (2603:10b6:408:11d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 23:10:15 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 23:10:15 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [RFC 03/20] vfio: Add vfio_[un]register_device()
Thread-Topic: [RFC 03/20] vfio: Add vfio_[un]register_device()
Thread-Index: AQHXrSFwNP3/pIcrZ0iM9X/cSoy0lKuuqYQAgAB3MFA=
Date: Tue, 21 Sep 2021 23:10:15 +0000
Message-ID: <BN9PR11MB5433D4590BA725C79196E0248CA19@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-4-yi.l.liu@intel.com>
 <20210921160108.GO327412@nvidia.com>
In-Reply-To: <20210921160108.GO327412@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd34bf44-2a73-4bfa-b655-08d97d54f8bc
x-ms-traffictypediagnostic: BN9PR11MB5356:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR11MB535628A7A93BBA7CE4B839318CA19@BN9PR11MB5356.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t9LhI6KEmz47tyNjew53dFQ+9AihvASH4OcGEgjgI403SNh1zcdjRGN5j/tNpCCie2GDGfSsRwnWeWSDo9io5qUIGqBztdwTOx8+T32SoDj0jG3ve+wRrTaGHwlp5BWi+GPWXtUbm4PciWEVnqKLcjGMRixBCrYt/z8ZM7PkN1S1P6pOH5cvpzNeN0utfDxe0FvowHDDa9Tasc6gDOO2C3JdOEMEAea2xqQv4SRUNZuT4avxKZzTy0tW9NkxwcwCYKutC+Kf5kFJvycrSxpPca1Awvg71hFM22Clyo5NccbA73S2KDHtsHL1rIMv/fLcw5KkO9ZPpLa4ur+ky3Uu2q5Up9403SqgVESvx7HRmUmpJD2ou+iM3gAWBEP4WvSiNSL45EzktHjrtvjTzUNZz3ggyq0c58hFRkup+pe/YHtHxKtR1F7s4Ozd0pZGpIr4yO8aGrP60FP2Ctlnq3rbAX+0RkTc41xCP0ibCviCRHeChQjzKgBuvjcYLBfnnTvNa46v5gAZ0bdnZNeNxkm4I2FWskooBDsnRgsJkDcgb3/GmtYR41rndMvMhV9cIx9amkjvgNP9hqTjyzgZYXotsONiCPAkONb7Fla3CLU/QPF/ylFu9YrorgIYHYOxrTgIOiSnL4abvd2aYeETFBZKwexzfpQEsNaY0Pg5fSNMD5k2GJogCwO/kyW7qpoE0nM6XBT5gE7F3tE6eU5glY2YKw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(52536014)(8936002)(4326008)(8676002)(26005)(4744005)(6636002)(2906002)(38070700005)(66946007)(6506007)(55016002)(7416002)(33656002)(9686003)(7696005)(5660300002)(66556008)(66446008)(66476007)(64756008)(316002)(76116006)(38100700002)(122000001)(186003)(71200400001)(508600001)(54906003)(86362001)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HlUJiuMFeQz9Sidd4qZA8z8tY21UZXHPcsVyjPtMR7WbKbWu1KkB79wWgYDE?=
 =?us-ascii?Q?gn6WF4t3DeX6qR6Cm9iAZcE75gdtdBVqGB0y3TOVSmfzu2uPYcvDvxDGDrsO?=
 =?us-ascii?Q?kA9zWXfO1BqY/GZUMrywQO+QKukzyWLNdaSYPG35sQZX8yWpIPzxhCbXsYHL?=
 =?us-ascii?Q?u+7cg9XjIOP+pPVHR8NK3fnQ1gehJaJvlHB8CWEtwGJaqxRLS+EI6n6gJquY?=
 =?us-ascii?Q?/we6LU8H04Cp6VyMG/9+KYRyQ1exZWJQx3ERiQ5YPH94tuDp/41FS75uRAkN?=
 =?us-ascii?Q?Kt4eC3CmMBFp6EgVrVCRSwFyxJQkRpQf9P3RMKIyBLhbZeLBcRkD9RtCOYh9?=
 =?us-ascii?Q?zhMsyMrFoJlViU/3YPnYm7xVY21yNjne8fMp/qMjBVxOFzgrYgdM6xtmseoV?=
 =?us-ascii?Q?nH04Wbff+0ykfOu/c2sJeZFmopjGem8w89cDhjQk3GHbpjUMabUcnAvPSZlv?=
 =?us-ascii?Q?9X/DICMqosN+6IEjwhhsvP3wAo2OMfFbHrT+HfXIvJ9eEnYhq6WeRncwvT2A?=
 =?us-ascii?Q?xhd2KYBXNcCPbuwuvm7dmjgNuZmG6iWP+ecen4NfJKm+boR+DVC8TobhaiMe?=
 =?us-ascii?Q?UA5TH3jZu9moue+mGzPt8BLJvqQhfhLeXtM3mEklN3U8o5ZXpw0AUKWOmfEM?=
 =?us-ascii?Q?ulDoPIK8AEjG8Wzn0B2i2ROMUQvyjNcdw2e/7VhwV3dBn4h4plPX8PtMeVP0?=
 =?us-ascii?Q?WU1fy0/GIf0a3fFH1eMY+PYJZlDayeBZplqHr75rKdiq/jPkrsPOgxX1i4uY?=
 =?us-ascii?Q?WziVaRxeBevtVHFn+HmO92kDz2fmri/kBRM8Txk+YFznOvkA156s9oPyRQfH?=
 =?us-ascii?Q?hrLCxeHgGc2j3wz6noVQYzFtxPvrQ6tg1UQaYYSWK8RvnDQuY3V1Rrn2DAyL?=
 =?us-ascii?Q?Koge5Cwp8wAV/HQT2zWwL0KMYWKHgzz9vfaszqCHmKxJmcwpE2sMoh5eb7sP?=
 =?us-ascii?Q?sNciwO3CfTnK3/tv8opgXNYkT4yDGxR+gECenr3+OMn44LoVt6uAJ1SmqeTF?=
 =?us-ascii?Q?/Z9DQJGPFuDUkbGo6TlsCyQ0GkuVRnUS+ENemYTjAhlYU4ysgulmcYLZGYq8?=
 =?us-ascii?Q?l8ogLnd2vCBDS38WoUf1S+7fpM572p67Ll354F4NtfwPOo6nqcKtPxNF9Etl?=
 =?us-ascii?Q?pOO/6ZA4rhrFsmr/l3hC+b9v70/Gt1LIOQScoqNi5SrTVI4GIJxiYrfeFNMK?=
 =?us-ascii?Q?O8s2Ys568esSGJUazLKbndkDfMDk69zgOY54JnM8wz1icjtBt5OIswRS6Fkq?=
 =?us-ascii?Q?9GCuM+VoO2oMjwLRjsRSpM0MnsgILVy448xsWiSWLBvv5fqBjK1Bh8SPDylT?=
 =?us-ascii?Q?ypA=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd34bf44-2a73-4bfa-b655-08d97d54f8bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 23:10:15.2098 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LnJrThkwHq897h0JBftHYk+p41A/szMZq4pnqBdgwfJE8Sm9g0igxT6FnyYKcebK1UWbk5zlO4eBEGWPfcSpaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5356
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, September 22, 2021 12:01 AM
> 
> On Sun, Sep 19, 2021 at 02:38:31PM +0800, Liu Yi L wrote:
> > With /dev/vfio/devices introduced, now a vfio device driver has three
> > options to expose its device to userspace:
> >
> > a)  only legacy group interface, for devices which haven't been moved to
> >     iommufd (e.g. platform devices, sw mdev, etc.);
> >
> > b)  both legacy group interface and new device-centric interface, for
> >     devices which supports iommufd but also wants to keep backward
> >     compatibility (e.g. pci devices in this RFC);
> >
> > c)  only new device-centric interface, for new devices which don't carry
> >     backward compatibility burden (e.g. hw mdev/subdev with pasid);
> 
> We shouldn't have 'b'? Where does it come from?

a vfio-pci device can be opened via the existing group interface. if no b) it 
means legacy vfio userspace can never use vfio-pci device any more
once the latter is moved to iommufd.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
