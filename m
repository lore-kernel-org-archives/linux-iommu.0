Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC76C433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 14:19:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06277611EE
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 14:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 06277611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D26E040585;
	Wed, 22 Sep 2021 14:19:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A4WL033HITzw; Wed, 22 Sep 2021 14:19:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6C05D401E9;
	Wed, 22 Sep 2021 14:19:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46C9AC0011;
	Wed, 22 Sep 2021 14:19:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86BDEC000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 14:19:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 742ED81919
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 14:19:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w0SLWScBIMMs for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 14:19:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4971D818D0
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 14:19:31 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="210840409"
X-IronPort-AV: E=Sophos;i="5.85,314,1624345200"; d="scan'208";a="210840409"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2021 07:19:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,314,1624345200"; d="scan'208";a="704037584"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by fmsmga005.fm.intel.com with ESMTP; 22 Sep 2021 07:19:29 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 22 Sep 2021 07:19:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 22 Sep 2021 07:19:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 22 Sep 2021 07:19:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgdjQAXtmDkF2aBTyDjkPF4LE7yiJNvIYSGBCSo+F0YOKxF4hvStt5RtQlxBTzuifkeAdouW8b06ZGeDY6uArpm8uzKMXI7ayE3e9MS374FMnJMVNu7Wg4De16NTKXj6dlHaVDlt5bfxdImUvb/8KYKCZDqcuB/vPR0o5T6H7t/J8OJ/feexmn4R3yQGmjn/5GXnzTChLXZFWfcXsq570JURmYdEgXzj82dItpZ62WyK6HqVgK7CzRzvL/rft7Sdl+cDpTVcRkl9MuO+BCzIy1eSz50oBXP6FXWsgT6uzxPghPx+xQU83/v5mHl/QKSO0OJ8Hw0pRDrf4Zjb+zFBlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Xs4+swah/TZCb8HpXn0pepAvTQc1UQHR6J1l7LNusGo=;
 b=bSoGkZPnyI17I3WNpTAOlAopXe6mOy9URqM4S1oy75JNsiXBj9rGP22wAtRhVHBTeKKhu1n2Bop/gDZHSxSStg8vgUfi/0ed3CvO3QU1PNNcDviNPrGWG2qjh5XoJRGj1zQVuXOXmyQzPIQV1emQHHuYkLWrsZeXsq2Tiupe6HaTHoL0u6FGLCV0vWsMbl5NJ1DkMmeyu0vtC33f27VgKeT1MblRfnqMhMdJrTxt4ulDO6sfOGy7lENnpaQg0K3e+3+oOuJsfXLmQYj5MqE6g/dAAsIti0COkU7aRaCUe8ycJHNoZk6OnDAp4jknXdvCdNd93Bs6UQmNJZuBgAHaOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs4+swah/TZCb8HpXn0pepAvTQc1UQHR6J1l7LNusGo=;
 b=C6b9DdJdDtzNYILWpv+0gwOf6PDTTU5HtEm/VloaaV9efWr7f1BbStSEOu0YyOD1tDo2QWDHfOEqYplnf5/d0Ew5mqcvhLx2jHLzxoNkviRrwdzOII7+/qA+8IZhkjgWoo/I8CJC3zA1vkdoo3cpKml4myuCUDuYfOfBI2+BJgc=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN9PR11MB5466.namprd11.prod.outlook.com (2603:10b6:408:11f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 14:19:15 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.014; Wed, 22 Sep 2021
 14:19:15 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "hch@lst.de"
 <hch@lst.de>, "jasowang@redhat.com" <jasowang@redhat.com>, "joro@8bytes.org"
 <joro@8bytes.org>
Subject: RE: [RFC 09/20] iommu: Add page size and address width attributes
Thread-Topic: [RFC 09/20] iommu: Add page size and address width attributes
Thread-Index: AQHXrSGKjhCHWEBJVkuehiEMDf/SwKuwFTuAgAAJ5EA=
Date: Wed, 22 Sep 2021 14:19:14 +0000
Message-ID: <BN9PR11MB5433D82D6630A87E8BD464AB8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-10-yi.l.liu@intel.com>
 <e158380d-cb13-c1aa-6dd6-77032fe72106@redhat.com>
In-Reply-To: <e158380d-cb13-c1aa-6dd6-77032fe72106@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5b212ec-3e86-4205-81ce-08d97dd3f4f5
x-ms-traffictypediagnostic: BN9PR11MB5466:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR11MB546654FA92687830350BD5608CA29@BN9PR11MB5466.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6PUQmUy9C9hSCMPLxoXN53OQMyJdmJNdP27Xeb3jVZA/hIHgjYV20Cba4Mxssr/AFXpfmKRIisHw2B7HwG9v+6VDSMN31m+bIo2drqRHGdziey2OV894fxR+z/w22ymE9345lRJ28a8ISbZzctAsBgKsgqrZoRdlDXzq+Pi9jKTBjjfeqDOyHcrH31YQVexbZHlUobIXg8nv9SIeK0GUgcRdU/0NY0ppIEcOpQe/SYheDp6PFZfpRKW5Dqvpq4wBKCtxmA6IjzDOpZab9297mJYzKOBHM3NUwFKfQTBrQ1ur2+AjvcFsmHr6dRuVzqqpw4FPsFMTBZ3Dej8d4tJ0AdvT6NacSEo4fq0AqKrUkfOyxWM7P0XJVvbuudsQcPr+DoM9eFZUIUhPo2GmjmczOIjdSVBtJ8GEbK9LSsR/p7iCamO2Q1PbhpsFvD0yIavwW+vfrQxc1NAQgNQM5/ctuCj82zx7uT0VR4i9R3TL0c6D077bPl+t0Dd1MzF7ps0c8LmdUFXifTfCXIcttA1He5fc18tW1YZPoyhvPteoVtYHhuFquW0buDm5J7w6L8mklY1LZRuC6dpX9B9/daw6vLQaR84SNyn3IXneIH5Z8cJnMQpPgcCIrZIdfwxxYDLdmkv6zhJRpq0Uj2lt9lID8+/KKAmLcbCsyROdUmE6o3B5ph4Gkuo1pJww066I+LSM7yQVd38SQP1lDLKNyei2DA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(55016002)(6506007)(508600001)(316002)(4326008)(2906002)(8676002)(53546011)(38100700002)(52536014)(9686003)(38070700005)(64756008)(66446008)(66556008)(5660300002)(7416002)(66946007)(66476007)(186003)(122000001)(33656002)(7696005)(71200400001)(110136005)(54906003)(8936002)(26005)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVFqeDhOT3ZqRmhzdHpRZXptQlEzWGVvTDNKc2QvajFFT0FmN25JMHdLcTUw?=
 =?utf-8?B?ZmVoN3ViWlo2dktEcmV3dnJmb0dQYXhrOVpKOGJnaXNPWEFVMEQweDNGQitE?=
 =?utf-8?B?SjNNZENWSHV5N1FNUXNZM3JEYTNJcGttaUt4MjJVMjVxMENyZFd3UHp5TjNw?=
 =?utf-8?B?cVVLd2N0anhISnVxeHlkaEZUdEZPRm9vNHhoalphR2F2QjBDV2FmQVNjejFJ?=
 =?utf-8?B?UlVLRmVJdGJVTGdtaWE0bVpqd1B1Wkg2cEFYemxScFoxeStBZndQU3F2NENx?=
 =?utf-8?B?VjZrelhtK09yaFBkZTBlYnBlWVNuSEhURlV6VmJ5MDNrR3dHYngrczNPQUoy?=
 =?utf-8?B?cngyUzZKQTk1alpqSW84YThDbkpoSHJrakgvZmNiMlRxRjUzQTlJbjVTdGdC?=
 =?utf-8?B?M2M5L2wvbkh6U2FOb0k3cldld3k3MVZ0N1lMM1N4SVQ1c3hNMWFZQTRjeUM0?=
 =?utf-8?B?ZXZGODl2ZlpnZTVkZnhKaFQ5N0dlcmkvQllJMFZ5dTdJRnZzbFkwZ2U1VkZY?=
 =?utf-8?B?ZDhuUzY5SnJNcldFc1p0cXV6YVZvQ0FLcGhjNGVqVERQSkI1b3N1RmpMVU9R?=
 =?utf-8?B?THNVeklMVEExeXZQYWtUUjRPd0gxU2dFaGxMc0FRQVIyN0szeVJ4dHlBdVh3?=
 =?utf-8?B?SXlQdzYyNE1ITXdtY0tEMlNsbjFQdGlXK0Q5N25uK3cwRERlWkpWTC9WcDN3?=
 =?utf-8?B?OUJudHdzL2g0ZGlNMmt0NCtvZThOUUxyNk4vN0s0V0lZQ3pxZkpmVWROWFA3?=
 =?utf-8?B?UlI2b2NuQmZNOG9HcmJEWmx3THRwV25Ebnd5NWc0VStPU1lpNzFnbjZERGFN?=
 =?utf-8?B?dFJkeDFTbjUwaFdscTJabDVuRWZKM21rMURZcWRFalcrS1hsRUxWdU9wR0R6?=
 =?utf-8?B?Y0htTEw3ZVFjR0xPVFU1d0x1anBNbElpcDJVLzRKVXNLYTk4SGhveXVtTE5L?=
 =?utf-8?B?UWwxQ1lsQVZHWUkrMzVmYjhKa2REQVhiZWJMdm5EZW9zK1ZvM0M4TE9SR2VQ?=
 =?utf-8?B?b0tCRjZrbVpPeTZ4d0diTzB5eUZ3RGJsdlZPbXRlby9mV1hJeFR0U1d6Q0Q1?=
 =?utf-8?B?OUVLWDJWMFlKSWd3T3R2amJGWG95cis1MXE0NUlwTDVkMVdhWXR3OXQveisr?=
 =?utf-8?B?OUFUVnZkcWdNZCsvSEhtL25UYU1HeDJRUm9UNjJIMDM3dmIrMXB1akVtQTcz?=
 =?utf-8?B?cHFJUHhnQXBIdThRc3YrSEJqM3BkKzd3RWNiVnpnbFhZUEVPV2hLanRDYllx?=
 =?utf-8?B?ZW5CZ1BnRlFrTms5eFU4VEN0ZktGRUpBSXBRdjIyUjU0a3p2amVuUlZuTTBY?=
 =?utf-8?B?ZDcwQUtsbTgwRlNzNVU3NlNRZzZGSGcvM01OYjk3eDBueWJWU3NXbTdqOTI5?=
 =?utf-8?B?VC9aVjc1UUZnOTBjSDlJYjVxMUpRck9DdlB3bDNTbDg3NGkvS2R6cnFLQkIz?=
 =?utf-8?B?cHZSaTdlNUsyaEI3SGVxTFNBNCtlVkswZURvOVRYdGRQb3JtY2N6d3M4T3dx?=
 =?utf-8?B?QU1hbFp6YkFnVDdNNisvK3VrY2RIVWVYeVVPK04rVHFTd3FsK085OS8wRThm?=
 =?utf-8?B?M1JZM2lKdlVoZFJrbGw2VXBUZ2h2SzFoNjBDREo4dGhXZnl3akl0Y2FTY0x4?=
 =?utf-8?B?cWpPcEtmeFk0Rmg1b0JuMFVhc1FSd1VjRC9FR0xCT21aT1ZWMnpXbHdXMW5k?=
 =?utf-8?B?OGovMmZKaHlZRnVlaXZ4TnRpSm1GTndpRHZSVDc4RkgrQnQvd2pUVE9UQXBH?=
 =?utf-8?Q?zCVL2Elwb3vrNXTMnX1HUAdN9IUjkcvEq+8D/Rb?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b212ec-3e86-4205-81ce-08d97dd3f4f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 14:19:14.9006 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k0W8ahwF0IHZYdhHt+LYkrCPB/X9DK05BB+Cuo0E0C/ZKeyveHqqwch3g6NbOpYDPaN+1ufUaL182lteWWE4KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5466
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "parav@mellanox.com" <parav@mellanox.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "Raj,
 Ashok" <ashok.raj@intel.com>
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

> From: Eric Auger <eric.auger@redhat.com>
> Sent: Wednesday, September 22, 2021 9:43 PM
> 
> Hi,
> 
> On 9/19/21 8:38 AM, Liu Yi L wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> >
> > This exposes PAGE_SIZE and ADDR_WIDTH attributes. The iommufd could
> use
> > them to define the IOAS.
> >
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > ---
> >  include/linux/iommu.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 943de6897f56..86d34e4ce05e 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -153,9 +153,13 @@ enum iommu_dev_features {
> >  /**
> >   * enum iommu_devattr - Per device IOMMU attributes
> >   * @IOMMU_DEV_INFO_FORCE_SNOOP [bool]: IOMMU can force DMA to
> be snooped.
> > + * @IOMMU_DEV_INFO_PAGE_SIZE [u64]: Page sizes that iommu
> supports.
> > + * @IOMMU_DEV_INFO_ADDR_WIDTH [u32]: Address width supported.
> I think this deserves additional info. What address width do we talk
> about, input, output, what stage if the IOMMU does support multiple stages
> 

it describes the address space width, thus is about input.

when multiple stages are supported, each stage is represented by a separate
ioasid, each with its own addr_width
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
