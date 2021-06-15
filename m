Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD8DC2B9F4
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 02:31:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B91C613F9
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 02:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B91C613F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 429D6404C0;
	Tue, 15 Jun 2021 02:31:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DfNsyoSCk1c0; Tue, 15 Jun 2021 02:31:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C8F97404BF;
	Tue, 15 Jun 2021 02:31:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1ADDC000E;
	Tue, 15 Jun 2021 02:31:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF170C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 02:31:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E1E50402CC
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 02:31:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gqUMjzWEHT11 for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 02:31:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 500F240164
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 02:31:46 +0000 (UTC)
IronPort-SDR: 1k6zA7FMyv3rMDudiCdLJaVJj+eQZTqRIoRLLAUHkS2vnuRBjTkCJkR9oRly/GBD9vmt6vhzmL
 uLxwi2OPDtJQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="202886639"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; d="scan'208";a="202886639"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2021 19:31:44 -0700
IronPort-SDR: 0tyHDmzZcuHLidvMviFsCYJxTxzUKJuxGQt/wVeMtzl5gveCtG7ZILk28yInME8j6CLMmXdmr0
 +HxdcuqIMKAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; d="scan'208";a="478567979"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by FMSMGA003.fm.intel.com with ESMTP; 14 Jun 2021 19:31:44 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 14 Jun 2021 19:31:43 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 14 Jun 2021 19:31:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Mon, 14 Jun 2021 19:31:43 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Mon, 14 Jun 2021 19:31:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1+wITW5N6YEvLRxkL3vS8r8MlSHrbjmEN0/hk5LqpetXHd5LaNVY/qwArKzdM6txas6Nms48vh1yfCrST4Qmm2cye9fClbzG7Z5Vpe+Q9fSvMtWDHggU6OIjjfA2EaUrRdCVaEmooxSSHv250fI+hf9IBwhYFGDHVHBDSqwuq3kFzZAKRi82IfBSBmhx20g9K2oM60V3xKTgugOGeNt6F/3ln4AExmNZEY1JDceWJBhEfJJAusb22IrK5tzIQuP56AXNlU+CJa1f+tqnSA/iNTMurZ0xNWYMBKbQ22iADwcY1LxSumq304DUW70ePfuwfS3w+jbAJ0Pt58tw+soMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+X4OO+eN9CxK8eV/CeQTyjIi6UyXo9edHwyrC1x3Ad0=;
 b=Q70KCF3eEQAJr4GgXWuhuT5zgtTXZKHzFt2BXTLujbn223ZH1nu5QXNvyKaU+9Y2darkilt+ViT2niKNWLiqBFulaowmvqh80XKq6cxiOo1CZrNjyjmpU6hQnytkZOivkCPqOWx5t/JrYYg842fpdC2ND9rN7e6Z6FQOaZHoLfbgYfY2Aj2hgqwQ8yHbARaZnY45EcaDxxUPixmByZlzouXzyMeKiIj8TV+YbtCg2bX0qfsnM6e2tH2VGSSgV66tWm/1gaIetaqOXcfPXXMpuQ5FlprehA/9GrmJgJ8zt18nk598ZrF9PjP4BHRiDpXGwJe8AZqghyHrIoXHMxTVDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+X4OO+eN9CxK8eV/CeQTyjIi6UyXo9edHwyrC1x3Ad0=;
 b=T0+UXvgqhlLlZ4wDXYzeP+ZBEG0mIsxMRJDVdEHbrW5CW4epwh6DHPzuqTo4jRhtFb5ws5lv0T25UfG9qBgzyLTLWDdOQXCCsgdS3a3DMhSnUWrnWfkS5Xci/gohOHVvNMEcR8lhfBD7yZlLbcterj9a5jvBZnQq4oW1kA24MrY=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR11MB1838.namprd11.prod.outlook.com (2603:10b6:300:10c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Tue, 15 Jun
 2021 02:31:39 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4219.025; Tue, 15 Jun
 2021 02:31:39 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>
Subject: RE: Plan for /dev/ioasid RFC v2
Thread-Topic: Plan for /dev/ioasid RFC v2
Thread-Index: AddbO/WEUAFl3MPnRsG8exiH8bwEagB7l+uAAACIfoAAAdwYAAADDw6AAAHKgwAAANd4AAAAacwAAAT4QwAAK587AAA0n7GAAAYKlwAADDvuAAAgbLGAAF6lSYAABO0WAAATSRtQ
Date: Tue, 15 Jun 2021 02:31:39 +0000
Message-ID: <MWHPR11MB1886239C82D6B66A732830B88C309@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210609150009.GE1002214@nvidia.com> <YMDjfmJKUDSrbZbo@8bytes.org>
 <20210609101532.452851eb.alex.williamson@redhat.com>
 <20210609102722.5abf62e1.alex.williamson@redhat.com>
 <20210609184940.GH1002214@nvidia.com>
 <20210610093842.6b9a4e5b.alex.williamson@redhat.com>
 <20210611164529.GR1002214@nvidia.com>
 <20210611133828.6c6e8b29.alex.williamson@redhat.com>
 <20210612012846.GC1002214@nvidia.com>
 <20210612105711.7ac68c83.alex.williamson@redhat.com>
 <20210614140711.GI1002214@nvidia.com>
 <20210614102814.43ada8df.alex.williamson@redhat.com>
In-Reply-To: <20210614102814.43ada8df.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.143.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c8e89a2-723d-421f-2003-08d92fa5b4b0
x-ms-traffictypediagnostic: MWHPR11MB1838:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB18381AEA0295EF5FBFE9DFF08C309@MWHPR11MB1838.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pq6OyJBPj7fGeizWCWEH2lhwHWC2B+CtUMkbfuxzXu2pNJXwt8ymWGQNrGPDqQH93sJ6cAKBdeMg5i6unaRTQ3MG82oPCPtMFEW1E7WrKuFV4je9Emnd3pMooeJwTnzfV9EZzhLmARC5Qq5GdxVBQNzsfB4Ujm74s1q4rHYAsxrQjzs3DJf+5h3agorXukCczodsrVCQVcN0NPpB19YF67ggIj9+HcfyGKhFMZFRzOx23jEtpN5x9SuWOKK5AmDyPfs3CYXxrllk4rZ3OYNo7Le7Dr2VzaubGfR1XJy9yHy6ZR0qbW47KF42+REBHtwAW8NEGBSYdX2CuiHuQENCN0B6Zmkfxu+tyRhFZwdCNQoGYRs38i5+KSVL3SpTq1RvH2TRjIjU27DINJLqOM4opt/z3y3Oq2c9p93ub1FueetvgmCIo9URIfUOWwBA9Vxmy8NW91zQgleaDAjOuTzZReYLZXrEK4rRuD2ndBmfar1f485uT4DjRwJVMHNCRhsAC1kDZj5Y9zzbhkc1HCQ/V5btwlfog4Y+RNr+WX7Zs9t7zClFg8cMV52g5GQzWCzN5+fiQAxd92GMMZDEzNmg4EYDitAstW+r3fPmfKR8WxE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(39860400002)(346002)(396003)(136003)(366004)(71200400001)(110136005)(316002)(86362001)(6506007)(7696005)(52536014)(54906003)(26005)(76116006)(66446008)(66476007)(64756008)(186003)(33656002)(5660300002)(66556008)(38100700002)(66946007)(122000001)(55016002)(9686003)(4326008)(478600001)(7416002)(83380400001)(2906002)(8936002)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TjjgrrVHuEW+gGRi+SI9F5lxO0UWHkvzvegQkVVlbJhqnTom6V6WsnPXepQ3?=
 =?us-ascii?Q?7Zgc+QVBiA1UL7ZabluWuTlFXk18Lqt/6/jM2ScAr3dZU6d/22c3qnK1VkDs?=
 =?us-ascii?Q?UUQQT4Au+Qg+4cenrhiHtoBQOF2Gahv1RCLMlJwH0BsMKM3GeuLz/hyPxaaX?=
 =?us-ascii?Q?yQqKXtkhCU4ubDS/VaS0RI0vPrrJRDhl5VajvNcBiETfyWJYoYnHfWWTdTSN?=
 =?us-ascii?Q?j24gr0u0h7JGQL9htUWIBj7HJqYLuR+O0W4WPq/qIVtT16slS37wsioQqJX+?=
 =?us-ascii?Q?VhicNCWziWfwn6OM2w1uOiTpfbuOK7yoH+1GrQ2KagoYFmOGkylNZUm2zRRQ?=
 =?us-ascii?Q?52TbjzoQLZAhVlDFRVuK+UWWTTJXVoS3L1fnrIdF/vO/J96zMrg3z5PvhcyF?=
 =?us-ascii?Q?PSpJHC69tK3mvKaxOJ/aXUAzhNaUG+a/FUop9fhM9EMB1EaYpaH3g+sXcgzS?=
 =?us-ascii?Q?emH25JAat7gfniFnlJFbnHBzcpuIoSTP+/i3JQZ1dsWzez2KIiGGoyCeYEhB?=
 =?us-ascii?Q?TrNIEYKawE5DSP8EDUwUqA4cUqO0g3MSPPL7O2DlgV+IyExQX/x49utJ8zG3?=
 =?us-ascii?Q?QOTWyug/dXG/aZ1Gch4GGpZqSrpV6yayX/HuOd8aVgpGOWpL0omRsOtV/i/N?=
 =?us-ascii?Q?xP2+7b9vV22r4PIaEBS12FpZ4/nJgO8tORWWn+6PZ+IDDEizcnmo/3xlLZJW?=
 =?us-ascii?Q?cjZPmqChoGX98K18fF0xFobgoKiw9XWfJOzm5OHUwKrg/LATfhVlx4Z6E5hH?=
 =?us-ascii?Q?hWCakRpd2xV0crwK6TrroLHSMhS1fHCdtfIyt6nl0rNJyFGPJ7FuKpxGVpWe?=
 =?us-ascii?Q?Sw0REZjp0NsLmzck4QuTJJWts8gCGGZpdA56PaeRMRsB/VHMqRcdWm5Yh4Ix?=
 =?us-ascii?Q?G/v+qgokE5q91X37xJfX0v0z3NA5x+cEsJFApJX+XFBktkHQA40dfDB3pBQv?=
 =?us-ascii?Q?2Q4/zu7gLKM11SSoPsM7VfGxi85r1/ZLrNZoGl/tvEUgCTQx5dFi17ovb2ME?=
 =?us-ascii?Q?/OXUCLV5TbjJtCjxABgiHkDprGQGx6Tn8zYzSgbYp8ICo5fpP9EUh0FEJ5HL?=
 =?us-ascii?Q?AJeHu+pt6GbC3V+LosTH4A3SYcMmBNFyU6kI/9LHP5KPBVZ0rS9f1DzjegaE?=
 =?us-ascii?Q?Jqu2TbKaDPvuEGxWbh815OsxQu6aXFnEUiXdkTbPTEzB+O4pgYlT5FZAL+1+?=
 =?us-ascii?Q?riQehmjl3sEG4IG3XTo5gLh2M6/N8GwXYMNaZkb6Xnr1vKyO5yuW7qdqtnj5?=
 =?us-ascii?Q?S9+qOYIhwItDV1+SenlNSwWIWlUn4P/OOdfInvaW1wGuSVTTBPxNtgj+ynxz?=
 =?us-ascii?Q?SVWHPkfjlGY1C/wAhcn0Oa/r?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8e89a2-723d-421f-2003-08d92fa5b4b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 02:31:39.4887 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dDsu29zAcB4D9C8Jqbh1u3z4QzzWs4N5RIj61b5fb2izhma/H0ZwZF3UCDwc/fIM+oulUwBUFbohPxDDuIHc4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1838
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, 
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 "parav@mellanox.com" <parav@mellanox.com>, "Enrico Weigelt,
 metux IT consult" <lkml@metux.net>, David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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
> Sent: Tuesday, June 15, 2021 12:28 AM
> 
[...]
> > IOASID. Today the group fd requires an IOASID before it hands out a
> > device_fd. With iommu_fd the device_fd will not allow IOCTLs until it
> > has a blocked DMA IOASID and is successefully joined to an iommu_fd.
> 
> Which is the root of my concern.  Who owns ioctls to the device fd?
> It's my understanding this is a vfio provided file descriptor and it's
> therefore vfio's responsibility.  A device-level IOASID interface
> therefore requires that vfio manage the group aspect of device access.
> AFAICT, that means that device access can therefore only begin when all
> devices for a given group are attached to the IOASID and must halt for
> all devices in the group if any device is ever detached from an IOASID,
> even temporarily.  That suggests a lot more oversight of the IOASIDs by
> vfio than I'd prefer.
> 

This is possibly the point that is worthy of more clarification and
alignment, as it sounds like the root of controversy here.

I feel the goal of vfio group management is more about ownership, i.e. 
all devices within a group must be assigned to a single user. Following
the three rules defined by Jason, what we really care is whether a group
of devices can be isolated from the rest of the world, i.e. no access to
memory/device outside of its security context and no access to its 
security context from devices outside of this group. This can be achieved
as long as every device in the group is either in block-DMA state when 
it's not attached to any security context or attached to an IOASID context 
in IOMMU fd.

As long as group-level isolation is satisfied, how devices within a group 
are further managed is decided by the user (unattached, all attached to 
same IOASID, attached to different IOASIDs) as long as the user 
understands the implication of lacking of isolation within the group. This 
is what a device-centric model comes to play. Misconfiguration just hurts 
the user itself.

If this rationale can be agreed, then I didn't see the point of having VFIO
to mandate all devices in the group must be attached/detached in
lockstep. 

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
