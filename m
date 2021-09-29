Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F82C433FE
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 00:38:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0287613A8
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 00:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B0287613A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F33782C75;
	Wed, 29 Sep 2021 00:38:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C8h8Drax8_cu; Wed, 29 Sep 2021 00:38:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5E0A682A4E;
	Wed, 29 Sep 2021 00:38:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25CE7C0011;
	Wed, 29 Sep 2021 00:38:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B3FDC000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 00:38:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 264DD60BB6
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 00:38:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CIn3pXEimn54 for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 00:38:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D019160BB5
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 00:38:45 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="204320799"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; d="scan'208";a="204320799"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 17:38:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; d="scan'208";a="538617274"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by fmsmga004.fm.intel.com with ESMTP; 28 Sep 2021 17:38:44 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 17:38:43 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 17:38:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 28 Sep 2021 17:38:43 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 28 Sep 2021 17:38:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+nYMY0TYHa8ltDg5ExYpA/3/WuDLKA7uKQpxPyBO4iOdseaoYS2LYDtYhv5JXLQerwJ+S65ID/tvgIhSsRxVA0IWvB0h7kOSo2BdeF18PapZWzimMZ1SGKpjQ/oHyWIo10ABgtzJGh2s9NLeqBbWKfOp8OLgughvjZaZPu1t0VyvgH0c/c5Di6v4ASKH4ZY1BPTFTA9+UeHl/j76ueD0hbmJ56Ma3/c7sFGJriH0MKq0gxvsafwesrzmPkjNNYN/2hFOdCHcocytS5ml404YsnFI1gmywKO2DtAi2E/LxzBOUfAyrTeLik1YzXGnpKDpYaISvGqOSrny7zXG8mcxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=t5u7AcW9Kj32PMhTXU0S6Ttqd7oR0Rm2tSnkE2vpRDQ=;
 b=TxfusKluRjKa9NOB1L3LAmPKWvJ1Lq8UDxFoTwL7STgg5GmyupuoBU5e1qg+oVHd2aKtv/dsUWw61Eg3kq6Tk3OlBOWum4enm1I7L6s2S/QleZ0zHDSiLRGfd6CUZ5TLO2u2hlRDib66G84eZR1RyMu3k4K0f4fvvbpzqFqH+CTfp8bBvhaLevyHyxRitmwqLqQPR+BiEe4HLQXV+dtWfoWpC123uMLQPVwHv+w1IgESZry+EG3aIC++sDVRb+DBUo8KvQFY42BBz+aOMHYLAVwGoYDCoMQHCV4gufln8fcKY6b8DFT/SSXv2A3nawqtaqsjEOEAk55p/aXyVBhL0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5u7AcW9Kj32PMhTXU0S6Ttqd7oR0Rm2tSnkE2vpRDQ=;
 b=wPoPfrEApTuK3e44fhNchazINBYuxwpEqAxtmLDti6eX2LHHiIY0rbFxbwBMC8YLrO8GRN0Db1WjeYvObppHaynhkK1k0YOpo8vL/kn7V59N5hK1/RM60YIHjUehWxqS025ReC7Wde30II7pezflYscCNqp8cT7pVdeKipu5Ul4=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN9PR11MB5434.namprd11.prod.outlook.com (2603:10b6:408:11f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 29 Sep
 2021 00:38:35 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 00:38:35 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>
Subject: RE: [RFC 06/20] iommu: Add iommu_device_init[exit]_user_dma interfaces
Thread-Topic: [RFC 06/20] iommu: Add iommu_device_init[exit]_user_dma
 interfaces
Thread-Index: AQHXrSF9WDj+Z+DU+UqMJ7tQK2EdmauuvK2AgACKnbCAALw6gIAHYVYAgACkNwCAAQ1OQIAAT36AgAAbKoCAAAj5AIAAq5rg
Date: Wed, 29 Sep 2021 00:38:35 +0000
Message-ID: <BN9PR11MB5433B8CB2F1EA1A2D06586588CA99@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-7-yi.l.liu@intel.com>
 <20210921170943.GS327412@nvidia.com>
 <BN9PR11MB5433DA330D4583387B59AA7F8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922123931.GI327412@nvidia.com>
 <BN9PR11MB5433CE19425E85E7F52093278CA79@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210927150928.GA1517957@nvidia.com>
 <BN9PR11MB54337B7F65B98C2335B806938CA89@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210928115751.GK964074@nvidia.com>
 <9a314095-3db9-30fc-2ed9-4e46d385036d@linux.intel.com>
 <20210928140712.GL964074@nvidia.com>
In-Reply-To: <20210928140712.GL964074@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8be6209a-eb75-46e9-994a-08d982e178e5
x-ms-traffictypediagnostic: BN9PR11MB5434:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR11MB5434D9474F8486F988756E468CA99@BN9PR11MB5434.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y0Tw931BVPcHuOQKizvvqoocISH7JzUePK9vfX3aTVarMXc6Cv++hAUSmZVCkMcbzn3/LUK8lLynfJCX6vZZpPO6i+dijTDTeAI6cWFvbifxuSt3jezMRb+GFIBu+ETNFbg4Sr0ABxI8slBgNf//1EzUJYL+P0bvhYOytNng4pfZW7sNTJiWyinaIb90fpw7gOVsT+ty32ZbO99dXw54PYPdCcFZF2Vc28TLh3sCxt/BTgPOLV9XwFegL7AqWJY+FRfSilJDYDgHSCDtuMFg9m73F0b419EEjOWwb7BrmlPlqcSaaCP82nLuYleayTKQDwyvpIxvHxxSzkbAnMND+anth/3BcfKgSjLhpGpb0VGC1QpPCggpibUxlDFdPZH9tyVFAx7edVLElRq8Ao/VE57WTrP8T8pCBpKslzigc7u5WDBF1lOGYbQNG3RUF6my+W8WqMH7IgNXBrTn3hRDAopJCP7gR7B+X1yc9lfLcA8DAr6WiZ4+h4hA0gGGVDk0AST3br4g3IN0WJAgOQCpDQkxcR7YjYwJHhWn9QXdFEsAWw/FhCK0TyDNRzWdOaEZqKiJETbS+S6Yax1cP7XCgR0i5CtvyQZz8jJwBQSQLP0Zsm7IkTbVGT0TLmkufsn81nBwlSm2t0G5ExllisHbUEUFQL5ETz5bT0jgJ4X2ZYx+dyMxyzTG6VGb2avT9OpbfwyyiKs9K6Tl4TVP9lPMO8eGYjpccx7U8fP5b7pJnpf8RL9DI+KySGtmtfzuJjdsgxh4wWmJm+xUgfB2mPlDDw3p3Kp1xqnq/Du0U1fANEM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(508600001)(64756008)(52536014)(83380400001)(7696005)(966005)(66446008)(71200400001)(26005)(38070700005)(186003)(66946007)(8936002)(4326008)(54906003)(122000001)(38100700002)(316002)(5660300002)(33656002)(66476007)(8676002)(110136005)(2906002)(6506007)(55016002)(76116006)(66556008)(86362001)(7416002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hNPLYmX8pc2maH5J8/GDcXypaBAR1RyCCpGCxp94kDnQjF7Tc9eD3QFVmgWd?=
 =?us-ascii?Q?tP+uxs0V4wbAKv/v+UTtLyPp8lZ3QHVTQbjkEfkNlEyqRsJRbBRdaC/Uhak8?=
 =?us-ascii?Q?Md2YNlXbG9kGi4caGGNsYR6xJb1VfDkLev960Wmi4iG5UzXHiNIOIkm+E/rJ?=
 =?us-ascii?Q?QZROcf/Rfw3+n0RoI/ef0M0uiJfoFuy2Y4pU0TSARb+auc5XMCVEpRSG3Mmw?=
 =?us-ascii?Q?Mmc17qA7WzY+QWsGpXqH9jV5R9fiaNdU5K5vZdweFAc78jNNOxKBRs5gndo3?=
 =?us-ascii?Q?crGyecKx7tUdHRWzGNwY2yynfXPEGHPTgPtBQSeXxzBJ/2g0pKGAXyKQVF1o?=
 =?us-ascii?Q?Lqq7WT9YyRVIsYrg6PhJZSysC5F3e5hJcx3Goq3S1AanpBC1yqvaraV/O59Q?=
 =?us-ascii?Q?FjNSFFD6qLJu4P1Ahm8Q26ol69KEULnXegUXfhtpLeqzVuC2gPsVqHyItBbF?=
 =?us-ascii?Q?8IMjrTAzWVg1mMW5XlkJrBIJDeohCQO41RZsdMXauVcUR88OHeQsoPFq03v/?=
 =?us-ascii?Q?LtaLSX7uStzoPFS0Mjetylig2VgKStvs+DwkUlLuUruX+UwF72UFESVkCac+?=
 =?us-ascii?Q?RhmMgzo6xgK2oOzaC3yUt6KdcaMpwZEbvGlfNED095+iqPHixC5vxyS8C30f?=
 =?us-ascii?Q?SEWJJNQsaoHBVYCRqbt0/hvvFapImFLBNn6FUMsEtfM+4xDaiAN+5yCgA65k?=
 =?us-ascii?Q?hSWfm/DtK61GBrvrq+JAE9gkd44vaUZuakkPA6Szk1Dv5JUrKJruOzX55wUC?=
 =?us-ascii?Q?uMT0H/uiMGqVaEqJjmfbz+VD73gGuEkpA54BlP1Or/oI1cDP7gRPIUZrIJ/M?=
 =?us-ascii?Q?IaMHst7opwPyJ0SFfL1e4B2ccBAODC4kc+E9nKnIPeQGPkFLIPyehe6t+UfV?=
 =?us-ascii?Q?3Nj1IKMciUrYQr4z4UNlIVluL0SKBZi5KfSnP1C/V4HdjvJrMxCkWgRC1VNo?=
 =?us-ascii?Q?sE9dGIgxFsoU4MZKPYgVJJhwAlPnlInWGEm46yk5Ks6o+oUZ9H1jBufufD0g?=
 =?us-ascii?Q?ikjVCPcNf1soEamb3cSsHo/0uQv2d9qF47TTdVKPmnNU9eMKhgIEbLUSD5uH?=
 =?us-ascii?Q?oR1j5zp2YvjD4jOGcRTMsvKq3Up+POVvLxsU3u68jEjO56OthKrWPfhz0Sig?=
 =?us-ascii?Q?4A6NSEyYAwQM8rzH3DQ2PZoQcC+QeExX93mbf7uQY3egg0a2j+KmYe6dD+m/?=
 =?us-ascii?Q?wnBlKwNCcHmVGurD/Lux/xtXTyoIuHVc+BR3c4VIp6vmBhI+h95GqFNesgg1?=
 =?us-ascii?Q?Wc8KEJ4kWE5Jm1RZJ/kAWmtuktG5eYonqiCcmdFadGUP6nO1d30pebCPrJY8?=
 =?us-ascii?Q?Nw8=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be6209a-eb75-46e9-994a-08d982e178e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 00:38:35.4971 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NK8UXPO3bGuUCUPH8IZxRd2GveczNXFrmGcYyv9KRkGv3FwMU5T7AbJUhnHv88T0ZlLSwvvEPXW+5r0zzoHk9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5434
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, September 28, 2021 10:07 PM
> 
> On Tue, Sep 28, 2021 at 09:35:05PM +0800, Lu Baolu wrote:
> > Another issue is, when putting a device into user-dma mode, all devices
> > belonging to the same iommu group shouldn't be bound with a kernel-dma
> > driver. Kevin's prototype checks this by READ_ONCE(dev->driver). This is
> > not lock safe as discussed below,
> >
> > https://lore.kernel.org/linux-
> iommu/20210927130935.GZ964074@nvidia.com/
> >
> > Any guidance on this?
> 
> Something like this?
> 
> 

yes, with this group level atomics we don't need loop every dev->driver
respectively.

> int iommu_set_device_dma_owner(struct device *dev, enum
> device_dma_owner mode,
> 			       struct file *user_owner)
> {
> 	struct iommu_group *group = group_from_dev(dev);
> 
> 	spin_lock(&iommu_group->dma_owner_lock);
> 	switch (mode) {
> 		case DMA_OWNER_KERNEL:
> 			if (iommu_group-
> >dma_users[DMA_OWNER_USERSPACE])
> 				return -EBUSY;
> 			break;
> 		case DMA_OWNER_SHARED:
> 			break;
> 		case DMA_OWNER_USERSPACE:
> 			if (iommu_group-
> >dma_users[DMA_OWNER_KERNEL])
> 				return -EBUSY;
> 			if (iommu_group->dma_owner_file != user_owner) {
> 				if (iommu_group-
> >dma_users[DMA_OWNER_USERSPACE])
> 					return -EPERM;
> 				get_file(user_owner);
> 				iommu_group->dma_owner_file =
> user_owner;
> 			}
> 			break;
> 		default:
> 			spin_unlock(&iommu_group->dma_owner_lock);
> 			return -EINVAL;
> 	}
> 	iommu_group->dma_users[mode]++;
> 	spin_unlock(&iommu_group->dma_owner_lock);
> 	return 0;
> }
> 
> int iommu_release_device_dma_owner(struct device *dev,
> 				   enum device_dma_owner mode)
> {
> 	struct iommu_group *group = group_from_dev(dev);
> 
> 	spin_lock(&iommu_group->dma_owner_lock);
> 	if (WARN_ON(!iommu_group->dma_users[mode]))
> 		goto err_unlock;
> 	if (!iommu_group->dma_users[mode]--) {
> 		if (mode == DMA_OWNER_USERSPACE) {
> 			fput(iommu_group->dma_owner_file);
> 			iommu_group->dma_owner_file = NULL;
> 		}
> 	}
> err_unlock:
> 	spin_unlock(&iommu_group->dma_owner_lock);
> }
> 
> 
> Where, the driver core does before probe:
> 
>    iommu_set_device_dma_owner(dev, DMA_OWNER_KERNEL, NULL)
> 
> pci_stub/etc does in their probe func:
> 
>    iommu_set_device_dma_owner(dev, DMA_OWNER_SHARED, NULL)
> 
> And vfio/iommfd does when a struct vfio_device FD is attached:
> 
>    iommu_set_device_dma_owner(dev, DMA_OWNER_USERSPACE,
> group_file/iommu_file)
> 

Just a nit. Per your comment in previous mail:

/* If set the driver must call iommu_XX as the first action in probe() */
 bool suppress_dma_owner:1;

Following above logic userspace drivers won't call iommu_XX in probe().
Just want to double confirm whether you see any issue here with this
relaxed behavior. If no problem:

/* If set the driver must call iommu_XX as the first action in probe() or
  * before it attempts to do DMA
  */
 bool suppress_dma_owner:1;

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
