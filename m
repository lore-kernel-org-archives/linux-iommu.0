Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158A0C433F5
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 01:19:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1957611C6
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 01:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B1957611C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8111760832;
	Wed, 22 Sep 2021 01:19:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id URbKaRtUlCox; Wed, 22 Sep 2021 01:19:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5A9FE607D7;
	Wed, 22 Sep 2021 01:19:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23323C0011;
	Wed, 22 Sep 2021 01:19:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFEABC000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 01:19:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 876BF60832
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 01:19:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nnNY6OANc_zf for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 01:19:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AAC3A607D7
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 01:19:13 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="202989292"
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; d="scan'208";a="202989292"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2021 18:19:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; d="scan'208";a="533518961"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by fmsmga004.fm.intel.com with ESMTP; 21 Sep 2021 18:19:10 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 21 Sep 2021 18:19:10 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 21 Sep 2021 18:19:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 21 Sep 2021 18:19:10 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 21 Sep 2021 18:19:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OF5DIvsgafmhk2hYuBo2oSRc/oo1bHaHpaJ6gZTGgRjmU9rdB0e7Cs2cYjKSZ9ISHgZn2TCvlz+JkzjlaGVCNQrTyNQofdbRwW67blzKGzL4yvki4J71RTzywg5w28QAJUUE3AjOTAvuGiRFO/SgwCPvjamJoVQVPgTBJkrykALTy0r+rW+eu6nT6VQxMIILNbmPnXr2Jnd+VO016Wxdm4bua2gmY6u6+9VJJXkvMpSGFeq4dhfAiI6sQ/c/XuDBFL8SKPSKvk28k4bwbPtcsQUkZALjtAogO4leYabV4LimYCIo9wDeah2z//rRucYTbnkcIz0el8gJqwDdGXQRcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=sQ4ZG/amrHNG4QudsOrGUgaXtgBpR8JjwBve7yL5Xl4=;
 b=ZaT189IeHOtf20bV97f3kzBrAgTwBBdczIYccLaVEgK4Os8qDvIwHcS1e/v++fBDI8JLZ7+saaB0I0kRc2IZ8a5O8Lo1gycJkg0VUt0WslXg/lBDuzW7Js5xshgX7dxLQmSNuPfL8o92MCdabHycrTRqxafrD4m+YC48OS1CIrH2qCw/aJyefzBJKwvSreU7drvjfPjT2z5ud2m0Rklgorsvgh+aliTjHYwmZTvH5/PGS056BLy4/fODbUCbfq0YnOgmVWREXenRsihdvAwfbboUuAjBC+fqrbDoPI5Csq+7LgI+7CC3vbBMYd14wJmnNDab2UDUx6QuZ58NKtNQzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQ4ZG/amrHNG4QudsOrGUgaXtgBpR8JjwBve7yL5Xl4=;
 b=yk4WWZ00eKApm8PkpZ8JDuJbQT+jkt3DAoAXzV+U1iHkJ967bMyTCjoV4/A1KJ2rRALnPpvwhjF8rGHEESXx53Q7KMBVpunEmmxlyc1sz9grdifRxgxyP2ThmkEWctcQn1iLVMt2gEDYxd8Pghyqrdb6sCLw67WrUa7PRjMUF90=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR1101MB2339.namprd11.prod.outlook.com (2603:10b6:404:94::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Wed, 22 Sep
 2021 01:19:08 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 01:19:08 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>
Subject: RE: [RFC 05/20] vfio/pci: Register device to /dev/vfio/devices
Thread-Topic: [RFC 05/20] vfio/pci: Register device to /dev/vfio/devices
Thread-Index: AQHXrSF8PdwE3l0WRkaTif5FzzsyqKuutGGAgABLSoCAAENA4A==
Date: Wed, 22 Sep 2021 01:19:08 +0000
Message-ID: <BN9PR11MB5433D909662D484EFE9C82E28CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-6-yi.l.liu@intel.com>
 <20210921164001.GR327412@nvidia.com>
 <20210921150929.5977702c.alex.williamson@redhat.com>
In-Reply-To: <20210921150929.5977702c.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e390139b-0f86-4f16-448f-08d97d66f9fd
x-ms-traffictypediagnostic: BN6PR1101MB2339:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1101MB2339FCA2396C055CD3D714A88CA29@BN6PR1101MB2339.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ObTPsIxaoIJu0DOY9CIJilxhGUEcPZGcua5tdESB/ObFT4AJD7Gkfhrjs7QYFYMw56yPi9FdLnGReFs/HVP+TY2OTzQxbNJMqTnH445tRNhytI9Mh4uZOMnKFk1EH8rixoShu1YNrOQRlwQepFsVWtcHh0W0qF8ZYbk8MliP7ODkl4qWLXdTc8rIdpbCWkvYkF45WzZTlPAjG4zGkFKVnH5CI41MCO86Df285v88adA/+9cEC4wjPAJFg5UfODC9Ii3/lcfp9Bgq0YvxkEJKOdaOO/6FTaskgmTiMGGLykxPz7Omcb6mANc8+ngCgFmvzeDhF7EnhbtCC6K2js6lK/HhFMrmzQ723sUWRzXAuiv1rDxENvFhdNrSu7Obj2Ckv0EkkpNaVs/i69NVlfRkDb0pi4EXtCf5i6rib/emqJZF7RilPZgRPeQSsfbJ9sT3cCixpMWdJYNqccnYTUDn2tKOWXNFxQRUWh5bvcFpVG+BGlIgdIQU3LEIOvqm7yU2nNReC7WubkTG/3Dm1J+3hBJ9tp50UDNesK2uDhdIlUjLWT/dhnBrsXDXegKaeXT7rqajkKwEbf0rAdepMdP5KBpvHfvRy19c+Cpr2HLD2EP64DK/7NY1cWlBcwzcyrCVDgWgwsTWehD7xuSo6RQVpwYwgHHH2VKFUzAeUzlV/ogbI2hLaP4aTg2kR/Fon3aN8svEZicNmP31/YnXO/6Qlw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(66476007)(66446008)(66556008)(38100700002)(4326008)(86362001)(55016002)(64756008)(52536014)(110136005)(5660300002)(2906002)(9686003)(316002)(71200400001)(54906003)(76116006)(38070700005)(8676002)(33656002)(66946007)(122000001)(7696005)(83380400001)(7416002)(186003)(26005)(8936002)(508600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JbSlH8V1xkMnkd2Uh+BLFGaVeGjU3gySoPoRFQsdAlb0e2feDDJYzhxVp9/M?=
 =?us-ascii?Q?ECYNMxFxWHLVLtEVxDGAniVpLZurcd+lAGLXyksIoQmpgVksM++jztysWVvO?=
 =?us-ascii?Q?yxY3HgUhCinrtbed3uECged5IH+SnGG1h8+e3zGbNXLmsSx+wuCOOmpnp+VH?=
 =?us-ascii?Q?BXAQqxqTiKyeZ/2bbjFy7zNRz/hiSJ9fzCZFVb5x4Pq0WkQagGZWV/3XZ1eb?=
 =?us-ascii?Q?aBACppupkxeWr1iPCFlmGPAPTCNtFTT4oa9yqB5O4wb5Cu72IfEWp6gH2liz?=
 =?us-ascii?Q?psafhuP9CqMolBp0BKoJyBHcP1QFzGiuA04RnOLKkyCEpTKa6/+yXEUIL6rK?=
 =?us-ascii?Q?e93Ykj85gdjOCzadj+QQumZnCmWjQKw98eciilx75sUw+s7CG5ndV7bcH3YM?=
 =?us-ascii?Q?ch+AYYCde7ii64UUojqJeZJ6rVHYDSRuR72S25JKkHKNKq4dZMsHYdtiOP/8?=
 =?us-ascii?Q?wfuUs5Pl+SrikaaDD2k7YJs+5yF+vxsDWwGpHHqIS3aY7RAylE1sTysBmJik?=
 =?us-ascii?Q?uJ5EBdfnMCgwJjvYFqJYlDIPRfs/V8Qi4KdLSV4gZwQ48jZY9NML1m4CtXUe?=
 =?us-ascii?Q?a4qi4jRy3VlBUoXwutjLttpe2+trA8dXvtI2a8ASq1d5m4O886hagBeWD9UQ?=
 =?us-ascii?Q?MtejXp4tAYspiApOJPUD4VxrijM9BCJa/dYwpaiATQtvdYIO9l/f6P7ew+5C?=
 =?us-ascii?Q?3vlpuqRmphHEVAPN27MnuDUziKQC20WgfHo3DTTLMRU4PE7+oIaz17nR8Bfv?=
 =?us-ascii?Q?P6CW/PExkbzWgVfJQWNMpPDzodVQ5nY/Ob/ADl73zOmXxovErk6W0tFKCV7Q?=
 =?us-ascii?Q?0LrPYj75Yqa4VXzsbym8EyabjlT2mfyJ2RolqGbtEj2Qa+xo2oePzLNym6LH?=
 =?us-ascii?Q?8lbWtNxK5R6BBcBZ9jBYIaV8JV4aDYqKTuD+x8jTgO4FrVNPPZaWxfPdJgSS?=
 =?us-ascii?Q?4zA+uAWmFOlcU6sByctpN0+J18M0hnLFffOvp/KSyFYjQyV7P4Ma7yBzXSgs?=
 =?us-ascii?Q?2F7sFbpHYdrS0gFctyBfO1fQ7rdel9MFwRCwQGB44rcld+WXi/Pv4e2Fk8Fh?=
 =?us-ascii?Q?rCsphUWcpqIbes9zGkbXq3AXkYGaR4R8wFBPUwAezpZy4XZ1HIQwhuOs187+?=
 =?us-ascii?Q?Yiebx6EqTH6tyU+fXabeZv6NX5VmTQz0zz+uqJclJu5V0bEXhwf+qTlpCPWN?=
 =?us-ascii?Q?2728O3p/ZwVnp2yLuraMsuyhjkj74skuJpu2bJrW0hjo9qg0Jy+JTEo8Iwbs?=
 =?us-ascii?Q?5y6zd7IP85Tz0jalhT3fEXoHJl2niOsgHToPCepRVXpF8tmeEiQ2ZcrcNP7w?=
 =?us-ascii?Q?UhE=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e390139b-0f86-4f16-448f-08d97d66f9fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 01:19:08.1855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J+BIDJH9FQZ+p1VqZw4e9TvnHnfL75/klROHwPkeqgrvZSsJxJuSYnB/zPNwbYC5bTRUETgXhcFRhe2I7ZjSDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2339
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
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

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Wednesday, September 22, 2021 5:09 AM
> 
> On Tue, 21 Sep 2021 13:40:01 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Sun, Sep 19, 2021 at 02:38:33PM +0800, Liu Yi L wrote:
> > > This patch exposes the device-centric interface for vfio-pci devices. To
> > > be compatiable with existing users, vfio-pci exposes both legacy group
> > > interface and device-centric interface.
> > >
> > > As explained in last patch, this change doesn't apply to devices which
> > > cannot be forced to snoop cache by their upstream iommu. Such devices
> > > are still expected to be opened via the legacy group interface.
> 
> This doesn't make much sense to me.  The previous patch indicates
> there's work to be done in updating the kvm-vfio contract to understand
> DMA coherency, so you're trying to limit use cases to those where the
> IOMMU enforces coherency, but there's QEMU work to be done to support
> the iommufd uAPI at all.  Isn't part of that work to understand how KVM
> will be told about non-coherent devices rather than "meh, skip it in the
> kernel"?  Also let's not forget that vfio is not only for KVM.

The policy here is that VFIO will not expose such devices (no enforce-snoop)
in the new device hierarchy at all. In this case QEMU will fall back to the
group interface automatically and then rely on the existing contract to connect 
vfio and QEMU. It doesn't need to care about the whatever new contract
until such devices are exposed in the new interface.

yes, vfio is not only for KVM. But here it's more a task split based on staging
consideration. imo it's not necessary to further split task into supporting
non-snoop device for userspace driver and then for kvm.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
