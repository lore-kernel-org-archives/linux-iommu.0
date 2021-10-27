Return-Path: <SRS0=XM0R=PP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58B1C433F5
	for <iommu@archiver.kernel.org>; Wed, 27 Oct 2021 06:19:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B3C560FBF
	for <iommu@archiver.kernel.org>; Wed, 27 Oct 2021 06:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3B3C560FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0609E40262;
	Wed, 27 Oct 2021 06:19:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DCUBfSQV-PrZ; Wed, 27 Oct 2021 06:19:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BFE38401FE;
	Wed, 27 Oct 2021 06:19:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A32CC0019;
	Wed, 27 Oct 2021 06:19:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B77CFC000E
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 06:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 989A04013F
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 06:19:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JpElYvXxEA0L for <iommu@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 06:19:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1524F40109
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 06:19:01 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="229942303"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; d="scan'208";a="229942303"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2021 23:18:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; d="scan'208";a="447413126"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga003.jf.intel.com with ESMTP; 26 Oct 2021 23:18:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 26 Oct 2021 23:18:58 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 26 Oct 2021 23:18:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 26 Oct 2021 23:18:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 26 Oct 2021 23:18:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzRO1YwF5hA97GPdhAdj52JnlcN+oN76CIfEtLwpfTVU6vUl9UlyFE/DLDmmuAyC4zRCHzGDSy7bfpyxGrRKNK9ykxAYXQvFJUrsWWGLNFEehhARGZr0hP7xPmt+a1gPiey25Slov7EyoYlxflfOXRimaVPn7drsp/bJCquc4q01vVmyClAYRdrYnGv+dI+JyEw/UsI5K2/+95wkJRsDsHerQW7tuU2BDazL8CkLpqY1QG+1HEi/xmwvuCIBMiC/c0WwiBogbxeA3e12IsSg6d1K6+ckRBk9EcAKt11uuy+dUIKDANm/nqe8fmHi9Azpv/TGxG5kYxRnEJuzjMw1rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvJSwuVqeBmoqCB0y+AdMYZIhgVLpFIZE44E2ihZOBk=;
 b=kTREqFSfQtD39U1mFmXj690VmdUuivP66UaquccacRscQ1QMihU2EpUglxVhb23bvl17I1Cgw+dXR67TLr7CAnSux/9rlIaG03ZeLcrJVj7DvYuugyYLiJBxHNwhcImjVE25Ke7V0/83Sh8Xblby/VJs+3KTZ4E9gf/0L6uYWbo+lNPUdilAQg9jtkqHW2Ior3LPmOTTqtBCPxs0EJ6Vc/9bfDHrNPgzdHa8zs2e71+6fy5J9pOP+M4o0IuN85zQ+/Nmu4R2r4GsZZrtQZTUAgot9YZE+bL0+CSAhICSSTDMx7iXffFynsuMe8PGKtMVp5EMB20WtoOiiBDVQF1trA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvJSwuVqeBmoqCB0y+AdMYZIhgVLpFIZE44E2ihZOBk=;
 b=LeqbEHgksy8CCZWkG4V7Yra608kka/7nG1isB/lFi3dqDO6kxP7tspzhKbAMmwkzG7AOPqPpUqtwSffqU1OxR/dxuQA43b9oUSPkvXMmFkDNJKO1WmD925koNOdzoRRG3S45VF+p/XGcd8wLz+9lV+DAqUZuKjvQ2XczT/rTe10=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB1617.namprd11.prod.outlook.com (2603:10b6:405:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 06:18:55 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ecad:62e1:bab9:ac81]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ecad:62e1:bab9:ac81%7]) with mapi id 15.20.4649.014; Wed, 27 Oct 2021
 06:18:55 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [RFC] /dev/ioasid uAPI proposal
Thread-Topic: [RFC] /dev/ioasid uAPI proposal
Thread-Index: AddSzQ97/vJYfIW8Gke3qF5WyXyLcQBL2ymAAKTbxpAAKSt7gAAHpf9wAB1YcAAAAm5sgAAA1YgAAADonIAAAEmcgAABzCaAAAHbfwAAAYTsAAAEeLUAAAiRJwAAFF14gAAPozMAAABMSwAAA0bJgAAVeTBAAAlp0QAABjX0AAAAf0IAAABWuQAAAD8IgAAAOC4AAABA0oAAAn0sgAAbQLqAAHzsuQAAHTjUgAALKb+AAAEAJgAACpEpAAAAd4EAAB0JvoAAAK4MgAAFtYKAAAV6DAAAAHyTAAABOkSAG2x1K8A=
Date: Wed, 27 Oct 2021 06:18:55 +0000
Message-ID: <BN9PR11MB5433B2E25895D240BA3B182B8C859@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210607175926.GJ1002214@nvidia.com>
 <fdb2f38c-da1f-9c12-af44-22df039fcfea@redhat.com>
 <20210608131547.GE1002214@nvidia.com>
 <89d30977-119c-49f3-3bf6-d3f7104e07d8@redhat.com>
 <20210608124700.7b9aa5a6.alex.williamson@redhat.com>
 <20210608190022.GM1002214@nvidia.com>
 <ec0b1ef9-ae2f-d6c7-99b7-4699ced146e4@metux.net>
 <671efe89-2430-04fa-5f31-f52589276f01@redhat.com>
 <20210609115445.GX1002214@nvidia.com>
 <20210609083134.396055e3.alex.williamson@redhat.com>
 <20210609144530.GD1002214@nvidia.com>
 <b9df3330-3f27-7421-d5fc-3124c61bacf3@redhat.com>
In-Reply-To: <b9df3330-3f27-7421-d5fc-3124c61bacf3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a75f544-b581-48e6-c772-08d99911a7d3
x-ms-traffictypediagnostic: BN6PR11MB1617:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB1617ECDCA256193034C7C5808C859@BN6PR11MB1617.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aWAx1TuDVFO94HtMlgyUi+fZrAZdzr3Arj3OGALuudp6+Qjy0L0h1+Wx1p51qSzBkWlOk+ssUliTV2SUvlLmzSNI8Sa3Fwk8ZU2f72oZNtNIL3OmAXEKmgMFenPvOxL31Thps2got5hhlG4d06RwJ/tgynVs9NSk5MNBtGv20lQ9pyu0kCqJniRS4fCsqOV28uhiT9jrnHdy+RjjNWy4D6Kx1P1OBb27ZWkXzLCWsCJb7Kx5AMMJi2014tjwZW7WlDw9QY9Jtr+t1u3Vw9F+An7DWEKL0QoaTCm+9caNZ1KM069eKReG87AObqwZkrgUu7kQtIN++oWS0POq/q3xhxhCpTM74nT6NoMcx7KYfGo/zFSAR7l0oFanLgqN8eVH9nYB3iNDtYzMNV5mq7j6O23oP6e8X+HbGjdp/u8WerAwA8gY/1vLzjhjMKNqUGzba6U05tHfAQhTVAkwIxL1AMW4AlAURTowGYLjS1nAnoes3nBw/Ne0ltPFVyKCwV8ur5UamFCv1gPVl5ki0ATNrrE9IeA8KZRBiYUOXrNVtE8D4pwdaZDf0lmhAZ4yHqBRyiSFNOs4Pxkbfjv5Vfjx2/oxptAsVOmFWwuPyHo3nWGIvxgL5DD14M1SdKVySwG3t5NiJvHDWSTaOYhxPQuvf9bIapmvUQNiiigyoUz/w1WgqLciuU/lmofPpzb+AmrFOCQba1CL7IgS1F0Jxsv1znBMe1I0ddoLyYE/qpWVK5r/It/2lmXH7FHruc2nKILx2Yc2Kir/AhrGWkbjj3w7jVGAojkVjhUUiFP/gtI9NRo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(38070700005)(186003)(7696005)(54906003)(4326008)(110136005)(66946007)(83380400001)(9686003)(38100700002)(66446008)(55016002)(66476007)(66556008)(86362001)(76116006)(2906002)(966005)(71200400001)(64756008)(122000001)(5660300002)(82960400001)(508600001)(53546011)(26005)(33656002)(7416002)(8676002)(6506007)(316002)(8936002)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTh3dnlBMlU0WkhMWmk1ZVpNb3oxLzFNbXorejJlbXJLWGVTTVVZekp5YVk2?=
 =?utf-8?B?bzdaeGRHZ2VLTUpsNVFRWHBUaStKZjNtV3lqZ1R6RXBKQnZUckwxd2JWM1ov?=
 =?utf-8?B?MExaWjQ5VDZ4c1JMUlZ2blVNWHNZUWRGZTB1VU9XeVlLcFBLUjI4OEtMUC9y?=
 =?utf-8?B?KzlhK0hIbEhxM0dxMTJGamVoSnVpdjVFR1p3YXN1VHVybWpNaUR0QnB3bGFo?=
 =?utf-8?B?NWFIeEdMQkRySHJaeUUvR0hLQm9nK1Zucy9lNm14WFZNeWY5NDVIN0ZTd2FG?=
 =?utf-8?B?Q29vQTQ0UmhwaGlmemtRWElvcXJPSUZ1OWQ1dk84QU1uZGtaT3RJV21BRVd2?=
 =?utf-8?B?cFB0OXN1dEFpak1WOXkrSlUxSnNKMWNTZGZRcDBJU2pZODExUVEydmhmM1B5?=
 =?utf-8?B?T24xY2hta2xmaGtWM2l3ZFNPTTBVelBndjZZeVhFcFVDT3BCcU5HR1o5M1hY?=
 =?utf-8?B?cHRQZjZEOXAyblkybVBWMGRUNlpYeUttcWNTWVRkN3ZtR0lTUTBlaWcvY0Vz?=
 =?utf-8?B?b2J3V1pvdHVpbFBlenFBaXgzSUl2RkFyRk5wbzhGRGNHTko3TUkrT1RGNUsz?=
 =?utf-8?B?Y1MwRGYrQmY1Zzd5MzVxSEE1bnNNdjJ2NEpIU3R3UXhxQnU5M2x5enNtTmxn?=
 =?utf-8?B?ekJVb3g1NHhObTJyWE8xdWRaNW9Cenpwa1FTTlM5cEhxeSt2TldPdjZOQmE3?=
 =?utf-8?B?NGlURkVudUpHZjZ5K3NYcHdQLzVNeGRkUW1vN2JKbXRJNDZwR216QldDdzhT?=
 =?utf-8?B?NzBYMG5zOWZ2cmhmcGlpQkZENks1aUQ2ZHZTZ0FBTzVlZGltVC9GWXg2TnEw?=
 =?utf-8?B?UDRUK1hzQ05Td0lNdHVxSTUyNENZRUJnT3NEeDFUbmtZV28yMjhNSzd6d0Y0?=
 =?utf-8?B?cTZ5bklvV0ZpMmE1RkFTMU50eSs3UUc0S084bWdwaUUwOWg0cWVvMjA2YVdC?=
 =?utf-8?B?b1RkR1VrTEhzL3JPZUlZYkhQTUxBV2pxYlRxZWdRYk02Y1VncUxNOXNPb1g5?=
 =?utf-8?B?dXdGQ0NJR3F0akVZam9LMFI0ZGxBRVlXaXp1UkU1Qk1INm5KSGN3cjF1WlY2?=
 =?utf-8?B?Yk1IcVVnR3paNVF6bEhnWlkwN0JpcEJ5N29xM3hOeTBobDFCVHVJYlZMQlk4?=
 =?utf-8?B?dzRtQlZleGVpSjZLYVdKangrSUIxaDBtZ0hRWG5aaDJ0UUk5Vmp0dWVnYnpp?=
 =?utf-8?B?NC93ZDI1Q3JlRVJoSUlCLzd4SlpLTFZWWVp3RUYzRTBJa3ZtR1FWWXNJaitT?=
 =?utf-8?B?T2RtalZNdW9zKzdaanhnVFgyZHdadk8yQzJkYW1TNUhGUkpLQnZoN2xGNGdQ?=
 =?utf-8?B?MkNrZlRvZU1iUjQ5aXpSWEJpUkpya3o1TUR6b0VPRWZRMjdqS2FiS3FESTYy?=
 =?utf-8?B?cmVBZmVGb3NKYy9EQUttU3ZYdXNGenZSUmQyTFh5NFFsSTZjLytDc3kwU3hB?=
 =?utf-8?B?ZzNMREFqVUVQQkR0VVJwQXZvalFENnNhK01EMmd3cGxlbjFNeTFMZDlqWGUy?=
 =?utf-8?B?RjRXTEZWdGh0Qk5qWDlQVm84Y0wwTmhWR3BVMityRHpTSXoxcXlGMk1sK1A1?=
 =?utf-8?B?ZFRlY0hGTjYvQnJiSCtBVWRjSmtCUkxkTkZvOXR2b1oxbGM0dW1KeGJaY3A2?=
 =?utf-8?B?NGloUU5ZQkgzYmg5aHpUVjlhQkhSVVd0cVpua21RZ1dEem9kWHVyWUIzRUha?=
 =?utf-8?B?emJvWnp4cXlUSnZENXBRbUg1VzFpa2gxOVRtWTZrZjJ4cHp5N3lVYU9TVmwx?=
 =?utf-8?B?bldEVFhmY3VZS1JDcTVHK3M2UjJzM2RIclpnMlE1ckZYYUZkZVFNMW5oRmpv?=
 =?utf-8?B?QzZUV2pFWVFEQVNScW5yTmtNUGl0SnNzb2pxTmFjNDBMTzNIenRCVWpLVDVw?=
 =?utf-8?B?cWJ2MFhpaXI0bnk4am5hOG5sM2s1Z2tXY2tsRFJtcmFEZ1J4R3FEOEVyeGx6?=
 =?utf-8?B?dDhzZmNSclhMMWFXWUh0SVRoZGplRVdSc3ZtaVRDeWtpMDZnaS9LaVZ1dGlz?=
 =?utf-8?B?SVRRZy9rYmUzSS9ycmtFVTlhcWtZYkZLcnhxcDJNcWJGNUNZMzhnNkE3STJE?=
 =?utf-8?B?TnJpQk44bzhFVWtGR0hDWU5HTFYwdXpydEE3M3R1d2t5cldkS2tHemRPa1pZ?=
 =?utf-8?B?R2p5aUNrUkhIUFVheXBLUVlzckVwSTN0cU1aMmQ3UXI3MDJnbkZPTzhtYThF?=
 =?utf-8?Q?hlf4BKptbfmlvbu1WeomeMU=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a75f544-b581-48e6-c772-08d99911a7d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 06:18:55.8096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7NtYZ7S33UDesttglSU6wcMTHbLWdi4+TCnBBQde+6R5YEyKhTlaWxPXHjR+nlXL/Xfdgiu4dZuhWjglL0QO+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1617
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, 
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David
 Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 Robin Murphy <robin.murphy@arm.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

Hi, Paolo,

> From: Paolo Bonzini <pbonzini@redhat.com>
> Sent: Wednesday, June 9, 2021 11:21 PM
> 
> On 09/06/21 16:45, Jason Gunthorpe wrote:
> > On Wed, Jun 09, 2021 at 08:31:34AM -0600, Alex Williamson wrote:
> >
> >> If we go back to the wbinvd ioctl mechanism, if I call that ioctl with
> >> an ioasidfd that contains no devices, then I shouldn't be able to
> >> generate a wbinvd on the processor, right?  If I add a device,
> >> especially in a configuration that can generate non-coherent DMA, now
> >> that ioctl should work.  If I then remove all devices from that ioasid,
> >> what then is the difference from the initial state.  Should the ioctl
> >> now work because it worked once in the past?
> >
> > The ioctl is fine, but telling KVM to enable WBINVD is very similar to
> > open and then reconfiguring the ioasid_fd is very similar to
> > chmod. From a security perspective revoke is not strictly required,
> > IMHO.
> 
> I absolutely do *not* want an API that tells KVM to enable WBINVD.  This
> is not up for discussion.
> 
> But really, let's stop calling the file descriptor a security proof or a
> capability.  It's overkill; all that we are doing here is kernel
> acceleration of the WBINVD ioctl.
> 
> As a thought experiment, let's consider what would happen if wbinvd
> caused an unconditional exit from guest to userspace.  Userspace would
> react by invoking the ioctl on the ioasid.  The proposed functionality
> is just an acceleration of this same thing, avoiding the
> guest->KVM->userspace->IOASID->wbinvd trip.

While the concept here makes sense, in reality implementing a wbinvd
ioctl for userspace requiring iommufd (previous /dev/ioasid is renamed
to /dev/iommu now) to track dirty CPUs that a given process has been 
running since wbinvd only flushes local cache. KVM tracks dirty CPUs by 
registering preempt notifier on the current vCPU. iommufd may do the 
same thing for the thread which opens /dev/iommu, but per below
discussion one open is whether it's worthwhile adding such hassle for
something which no real user is interested in today except kvm:

https://lore.kernel.org/lkml/20211025233459.GM2744544@nvidia.com/

Is it ok to omit the actual wbinvd ioctl here and just leverage vfio-kvm
contract to manage whether guest wbinvd is emulated as no-op? It is 
still iommufd which decides whether wbinvd is allowed (based on IOAS 
and device attach information) but just sort of special casing that the 
operation can only be done via kvm path...

btw does kvm community set a strict criteria that any operation that
the guest can do must be first carried in host uAPI first? In concept
KVM deals with ISA-level to cover both guest kernel and guest user
while host uAPI is only for host user. Introducing new uAPIs to allow
host user doing whatever guest kernel can do sounds ideal, but not
exactly necessary imho.

> 
> This is why the API that I want, and that is already exists for VFIO
> group file descriptors, informs KVM of which "ioctls" the guest should
> be able to do via privileged instructions[1].  Then the kernel works out
> with KVM how to ensure a 1:1 correspondence between the operation of the
> ioctls and the privileged operations.
> 
> One way to do it would be to always trap WBINVD and invoke the same
> kernel function that implements the ioctl.  The function would do either
> a wbinvd or nothing, based on whether the ioasid has any device.  The
> next logical step is a notification mechanism that enables WBINVD (by
> disabling the WBINVD intercept) when there are devices in the ioasidfd,
> and disables WBINVD (by enabling a no-op intercept) when there are none.
> 
> And in fact once all VFIO devices are gone, wbinvd is for all purposes a
> no-op as far as the guest kernel can tell.  So there's no reason to
> treat it as anything but a no-op.
> 
> Thanks,
> 
> Paolo
> 
> [1] As an aside, I must admit I didn't entirely understand the design of
> the KVM-VFIO device back when Alex added it.  But with this model it was
> absolutely the right thing to do, and it remains the right thing to do
> even if VFIO groups are replaced with IOASID file descriptors.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
