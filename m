Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398ECC433F5
	for <iommu@archiver.kernel.org>; Tue, 24 May 2022 09:44:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDFBC82EB4;
	Tue, 24 May 2022 09:44:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YdjfNbA8iI2P; Tue, 24 May 2022 09:44:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A42A682ADD;
	Tue, 24 May 2022 09:44:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 713A0C0039;
	Tue, 24 May 2022 09:44:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03BABC002D
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 09:44:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E592B405EB
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 09:44:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xUJ35SOKbJLj for <iommu@lists.linux-foundation.org>;
 Tue, 24 May 2022 09:44:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F2E6A40012
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 09:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653385452; x=1684921452;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QW5M2Q9yY3Wth/aRLjaboMVvDU1OeuVsIcK6MN2NGBg=;
 b=Rc6yze7takPlGvAH6mB1aYCEz8M/hoC2mq0WlKpBDrnjXXsplQB7L+ko
 BQ9/5f6DoUFZAkxqz/1/8dhe8Z2X2abIYOjGgeaAIjRuwkHVj+93QdayB
 NblvkExL/Ku400BJpwu4WIArP3h1tSlwS4lEKFMszrSeAFFW4EGK7NO9s
 fDWB4ga/Cze5N9NuOxV3Tc1lRuh7mxOdt4nwqY8wSE7CLZaG4bjlsS9pu
 SP4YQiai9Bys6bky6Re0Xf3Ciad6ivuJMYDsSfK8mtbrppaQIrnBKl4X+
 s/XqzUglAfYwiStFqv46qVdymqLOqsO9W0MVmYFkLP1z5ZezwFerOapk6 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="255547773"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; d="scan'208";a="255547773"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 02:44:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; d="scan'208";a="629809951"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga008.fm.intel.com with ESMTP; 24 May 2022 02:44:11 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 02:44:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 24 May 2022 02:44:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 24 May 2022 02:44:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jg4JZxCUkibsB4ShGpIX8+PH6V+FLpxdQqNUhlo8J9gcFocYSvQabC2IK7B6BUWPAP6nWP2KP88EJJ0GIVoow5jsRZqIYA+17J6u5IFmsG42AFgHaAMJnNL/ymBUjDhvcnIX7MER7j8iSsgGmFF+/umpqSRdQ5LkmgRgwH/mFQfhDmFV1XXzwiYSSoN5gmybCNso76HEjfPzrkAKMPe88ZusO5op9xNHHC6v8n+PGBMGdfoV5f93MuBpy2pzHDePAfxnUE7eEi5g8HQUuLX9RIY0GoyknDiokLuom1aUPQlWrqK4Jf30X9kgp0niVG/Zrk3UUaDBnGRZkQnIJ/jdgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QW5M2Q9yY3Wth/aRLjaboMVvDU1OeuVsIcK6MN2NGBg=;
 b=D6nWXe4bIqjEWYDLgl++T8cBsZqG5K17vo2aEOGfMs+csh+WfBb/QjIsJ+a1jwpUdNNSz8M3VRqIwsd2dQpbjgVkZMYNaicnPppncfO3N6YyCqmeuW9rkenR3UelFedHIQMi2/Buh4PHv6an9LA/Qg8MrPtwQJ5WKF7liaBaGJcR/xzu3YUw8Ha0TTFe6OnA6bwte7g/KoHj65HIgB0Q9hX0XdlqnmX1peoFAlrX02pnP7LedZ3EpIFqqpK/rbfcvLKWJLptPqkGPnslTwepfKpc5mLFGeh2zDpUpszHeyalId/vU1Ng8o5HKQFCvQBY4bKQHUKEBeyNP0AOO+rndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB2555.namprd11.prod.outlook.com (2603:10b6:5:c5::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Tue, 24 May
 2022 09:44:09 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 09:44:08 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Jason
 Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>, "Robin Murphy"
 <robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Subject: RE: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Thread-Topic: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Thread-Index: AQHYa1GAWzo4qdZhTU6Id4ueE7eQ+K0sEmaAgAG7rbA=
Date: Tue, 24 May 2022 09:44:08 +0000
Message-ID: <BN9PR11MB5276D2DFFBFB4C57FA3854798CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
 <316981d6-6b40-9e2a-09d3-b0d6f8687247@linux.intel.com>
In-Reply-To: <316981d6-6b40-9e2a-09d3-b0d6f8687247@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8568b34-309f-4aa8-9964-08da3d69f351
x-ms-traffictypediagnostic: DM6PR11MB2555:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB25554B31292F3454C28704118CD79@DM6PR11MB2555.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /K39QcdHmWiobHJCNw7qHIlEmXob6torMjQivUHZxtg1yIm8A/M880cKa6Ojv9jdTRSCsuDqA9mjCaqEadx9ii9dDbdKkO7JEn/oKNJQoBUXybjf9oSUf7Z2REB4vSNbtjwt/DujqhKq0onY5SbzroUE1Iu6F1r/4FEjNKGm0skdxL05stMOTxZSIAY8Toa0pkqdCcFzJHYG5tPScX+wXAhk6CFPAp/NQO+tO/UR8wYm55jjEsBlotC7KmqXhojIC2ZSZYh0fjjG8pKoJJpzJvPzi08KbljUm4S/wiRh9sJ+pLd5LuCq2BOl76NBB47+5B9LYdgb/+LzylLD3Zd3mVinEm7RvKw+CChxOIo4B3ihG/H5EXDbliPO3s0KrqluoW5vveBTkWw8Tsq/xEDcugSB84e+u46LOVkxyW2VaPCQFPagbR777KiJzMDtl3X4+gzkwmY8xXAySl26pmXaKr6d3Dv6xEYDaJG6X5ZRoEKSJbRrs/6b2c8vthYwIcAIcv1oJhtpPIISBNS9vA+PdzJ408TO5dDnoyQnz39RPZ7ACpi8ylzrBl/qrg8RTrZj3LqiXGMDF+4zn9HIgrI25YQYayoE/0v52pgCZfJFHUD+wxP7sO9gA1nqKEsSjwKSEWw0Tzwjb6frb9WaAVWj6nA/Ei2PnvINN5RAcrgnB96iVZGUAbr6o94aLp8qumYFRJhFxsiev8Ul9+M+yb0n5BO5qloVIJqfuqPFzb+JwB7SMo7qytIwKWtg7+l0BUOL/UDvXT8AcVbwPMEmbsChYlA1h7sFHtM+NOSFGymYqUUYSsD9Go1p+r3ivHSvcXMe
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(508600001)(52536014)(64756008)(66446008)(8676002)(4326008)(66476007)(66946007)(66556008)(86362001)(4744005)(2906002)(33656002)(7416002)(71200400001)(9686003)(966005)(5660300002)(186003)(8936002)(26005)(76116006)(54906003)(55016003)(38070700005)(82960400001)(122000001)(921005)(38100700002)(110136005)(7696005)(316002)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekpURVIxQVBrRVh3US94RGRobDlWenU5dld4MWxhOU5EU09ObU5kSU1jdVZY?=
 =?utf-8?B?MWxpQk5MZnNtcXhWOTZ2b21hTit1NlhRby9mQUhRRkJHdUQrRmZSVVpOREpY?=
 =?utf-8?B?RmNIWE1Yck0yM1BHTWJ6V3JLaGZDQ1dOQld6aFE2T3RXa1g4bFVabkFhdms2?=
 =?utf-8?B?MURVSWg2L3liTlVMYTR0MUNUOWxKVnluZHgzMFRmczNVZUxUa1loQStEdGNt?=
 =?utf-8?B?cEl4dkRqNldxQlJCVHZXNWZrRzhqbVNqell5emphd3ZwUXB0dUpUVnE0NDFn?=
 =?utf-8?B?L0FZVy9OdVptMndGRDZDbDNUaHBDSnZJajRCNlZZTGRSb1BOcTROUlU4dG03?=
 =?utf-8?B?TFlpanczWC9tQjllSWtxR0hyQytUV3FualZDZ3duaWdyRVdIM0FGblAxalpr?=
 =?utf-8?B?UXIrWW1UUlpZT2J6TVMrMGdFWEFiUC85NkxvUGwycU1JN3lYMGo3c3I0ckc4?=
 =?utf-8?B?K3hsZ21QYnBZVXBZV0FJRnNJanpzTjVuZ3lORzZUekl3RzVPUGo3d3Rjd254?=
 =?utf-8?B?bzZSeEZTaUxKR1V0YWhCaU9vMzRYaUhlK1JicG0vOGpDNGF1emNJVC94dHNj?=
 =?utf-8?B?bzM4cFZuMkZ4cGJsME9TdHNPVHhMZE5VVXBiaXhpTFFXSVBDejdPcmdPcXJY?=
 =?utf-8?B?VW8zWXl5Wm5hVk51UXFxcDkybHBuTDVpSlI4YWNFUUxuUlVxWnN0elhDR0lD?=
 =?utf-8?B?REJlR3JaL21SMVJFWE1qQlpzbnZ1QTdUalhSbDFTWHg5QW05a2pCSmFTS0Z3?=
 =?utf-8?B?SVNxQ0F1MUpHOTg3RkdsN0RRT3NaYzRPN0Z6OGl1WDdyc0cvVmZ6Ulo3YklH?=
 =?utf-8?B?amExekVEZzBnTGdYN1FvOFVMT3ROOUhrTjJqMkdWbmx1RndmaWFBM3daVFlk?=
 =?utf-8?B?WUhoWVpwUUd3ZklXL0dYWW4rMXZPUnlNNE4zakVrU1k0R1llSkxBTDFmY0Vs?=
 =?utf-8?B?Y2xIZzMvTUIwK0UzaUE0cG9PSGJnMm5pU043TW5zZ3ExTDlwM25nTk0vb0tB?=
 =?utf-8?B?WFpVai9BVkxnRTdZYjZKNHJUeHN0Qjkxd2pjbjRrUGM3VWwxSzJkVk1xczNC?=
 =?utf-8?B?dms4TmZpRkRBTzVjdmtwM1dLTGE2Zk5ENVVTekM2TmgvM21KTXRpYkVKQnNa?=
 =?utf-8?B?cExyVWFlMFQ3R25ZTlowSEoyRnBkZnVWMlBENlR2QXNDYzBHdElZWkNBL2lh?=
 =?utf-8?B?QWVPYzQ2dEJOV3JBbmQ5RFI1Qnp6aVRXemtQS2NIWVpaV2h3TmFkWERPNm5u?=
 =?utf-8?B?NklBOVVUQS9vVTBOQ3hUS0RpUHVxV1RRNllDc2xhNUJGV3h3QlFlbms1SnlB?=
 =?utf-8?B?ek5RS2h4Nno0MzhrN0MyelMyYUtiV0l5TUVSbTRIaUkzdUpzZjFNT1NxMVM3?=
 =?utf-8?B?TTNHWjhGVzFESnVGZis4QzgyUzJKUlNwRG81d1ZNWStwRXJnUnNvMi9uQWFK?=
 =?utf-8?B?Y3lmcmhIaWl5bnpsczFzK29DVHNsR2FjbzZlaXcvaytSUUJLZ2lFNzg3amhl?=
 =?utf-8?B?clJqd2taRjBhSnlxc1dlMjZQdURmek9HcFdQZUtuN2RKd09IUlN1VXFLVER5?=
 =?utf-8?B?MVVnRGhPcSttV2g4WFNLVFA5TFBJSzVSb2ZCZjFlZUxjLzdNL0RLOHdlVXNS?=
 =?utf-8?B?M1ROZC9mdlYyUmpjYitEdGhNODZwd3lYRDNjRk55QlNEV05JczJPZm1jbXBq?=
 =?utf-8?B?QitJeForcmNDMkEyMStyK3hySG1pV1pla3lLS0YyRmhKRjZwOHNMenlVLzFt?=
 =?utf-8?B?czVaQlhtNStUaGsyOUtqU2I4NnNsQlZyVEVRUWw4TGVURS9qSzhVVWsweU9P?=
 =?utf-8?B?Q3cyZWQxb0dDOFN0ejc1T2dOTWdQRWJhRHd2Q21HNW05d3hkdENYWkszQzd4?=
 =?utf-8?B?VUR0WEFEOXdtVEdUQlIxNmUxZUJjWDlDOU56R3VXNjFDeVJjTEJWWkZyWVV3?=
 =?utf-8?B?dXhSWUsyU3NnckVLb1dJeTlpVzY5anpiSzN5Z21BdlgrWlpXelJWUHdwUEly?=
 =?utf-8?B?NElaYm0zaTNReWN1SGRZNEJ0N3o1NkljM2pjckUweGhuOVdBL1BzT2QraHZj?=
 =?utf-8?B?SlduOFh0NHpRUFR3Ni9wWU9BQnRTUG9RRFo0RTFTa28yRG0yVWF4eG5qY0VI?=
 =?utf-8?B?QlR2QURDeHFXcEhVcDdDTkVXWVRnOHoyODNYeW51bkdJNll5NE9Sczk3bWxO?=
 =?utf-8?B?RUEzNmRNVGZ0Mk15dC9oWEVySHN3QU4zbjNMNyt1ZzBEWGZIZTNkZ3hsZ0Nr?=
 =?utf-8?B?SlAwVEZ6Zmt1aTB3OEp2VjNXUWxwTUNJTTc1YVBQNExCNjZhaVpSTTh5byt0?=
 =?utf-8?B?cGNhNmh2TGlTSjBFZ2hGN2p0Q1NoR0RuaS9RdWF4eDBlT3M3SitIUT09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8568b34-309f-4aa8-9964-08da3d69f351
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 09:44:08.8949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BD4P7Ad1ezAolyi2H+Pe95TD3/jyXmhW+AmAfM6CSTpJkLPh0An1fRkwnHl77kST+RiR6n+12b17LfhVgV9LPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2555
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>
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

> From: Baolu Lu <baolu.lu@linux.intel.com>
> Sent: Monday, May 23, 2022 3:13 PM
> > @@ -254,6 +259,7 @@ struct iommu_ops {
> >   	int (*def_domain_type)(struct device *dev);
> >
> >   	const struct iommu_domain_ops *default_domain_ops;
> > +	const struct iommu_domain_ops *sva_domain_ops;
> 
> Per Joerg's comment in anther thread,
> 
> https://lore.kernel.org/linux-iommu/YodVJ7ervpIdWfg+@8bytes.org/
> 
> adding a sva_domain_ops here is not the right way to go.
> 
> If no objection, I will make the sva domain go through the
> generic domain_alloc/free() callbacks in the next version.
> 

suppose it's just back to what v1-v6 did which all registered the ops
in domain_alloc() callback?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
