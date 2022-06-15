Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5AFC433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 06:22:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A537140A93;
	Wed, 15 Jun 2022 06:22:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MBb7XqCTdTi1; Wed, 15 Jun 2022 06:22:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8801040253;
	Wed, 15 Jun 2022 06:22:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F676C0039;
	Wed, 15 Jun 2022 06:22:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3A91C002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 06:22:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DAF4460DF9
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 06:22:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BWpaFLQROn89 for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 06:22:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 310A960BC2
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 06:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655274172; x=1686810172;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HLdXOMTp0vq56VpcD/aW6lBbaqpzWWWIrE6ZnRiak/A=;
 b=MY4CrZxD4cmWEthlSEc1sfFuRx0TTeMXhTe0DdArGb5VXt8nf41PvYUx
 TSD/29jaRS405YJ2H1XVXRcZgroh+CcbR1C70ZKc/2TEYnKua3O8bFLZh
 rAEUOlJ+T/0dPoGKw5MEPqPsMDUTipYTMtIj+rU9uTH+RScXvgZgmt5EB
 rsa9EQdz2SbK9eoaCascvkqYP3IRUSp2u1OxmAu1bvZVkqVR+WhPmwGSk
 Id5I7wa3DN1QpoTyCsKaqDK7fqCwfWHUD1CXqMxj9JvhPWigXgveskK2e
 x7eRFdjJWGFqsUxEE8pkukbaUtoyTclhtKhH0cJf6md+8SV4c05etRJTl A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="365201440"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; d="scan'208";a="365201440"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2022 23:22:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; d="scan'208";a="583051425"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga007.jf.intel.com with ESMTP; 14 Jun 2022 23:22:51 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 14 Jun 2022 23:22:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 14 Jun 2022 23:22:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 14 Jun 2022 23:22:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LchZvgi7puA8A7aDQR4++Vp7x7Vwwt10VqSf3ihK6cR9msr3hh58i6x7cWCiBdlFZNKV9xJ3rXTiYMlIu1C98f3/k9uxKpOAlPxczpkU17z3hghqhHkOzzfB0ecZkkWIz5X5qwThpRsP9ndd67fb8ZBPZPa/TxMHlePDmAVZ3uA8yJ6JHYfQUZjURFBhtLTw+Yj4Et6I56otsQmkXnefiF2z8ip6a5AuSvU+VR6t8C3Z7PfONidVFfsKrISeQjLmfjKY57YuuIBC9iVmXnearkUv5u0vHAhrBDQuteanvEf1P+38q8nJoKqiHPc6JJaq23WTLA+kFMC6nVJL63nt7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLdXOMTp0vq56VpcD/aW6lBbaqpzWWWIrE6ZnRiak/A=;
 b=keJqO2BgTuwzWgtUk5e7UW6S0OcHiO/6mjLV+LKytuuhOaXwqg4lRX/W9WgCIR9R8ZvXBf/uC/hfpHWK/jkDRXOTYW5CtUGB9FOLiZMcoiqvqnocgmm1caprYyBJsCrN8UgaW1ZeIhSrwhubSUHV0kcTQqlzEuNa/d8TwbDTyqF1BIBw5yQODNz9OEq1AglNaUATMMq/TuFrfPUkaoxhepx+AEdl+lxH1daYPduZlY3Dy+5VXh9/YM1ANAneN8JTO+5rRva+YLSIOFZbIlhVbm2X2ZgAwyMOjLBufMjaX1GwYpNlG2nvhUlz5Hoc+/guAucXzGHp+1oC7lnypLHfhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY4PR11MB1944.namprd11.prod.outlook.com (2603:10b6:903:121::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Wed, 15 Jun
 2022 06:22:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8%4]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 06:22:47 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Raj, 
 Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: RE: [PATCH v2 03/12] iommu/vt-d: Remove clearing translation data in
 disable_dmar_iommu()
Thread-Topic: [PATCH v2 03/12] iommu/vt-d: Remove clearing translation data in
 disable_dmar_iommu()
Thread-Index: AQHYf5pCZKyuaZgwUEG5kY3NWG6Wj61OdPXggAAKioCAAX90EA==
Date: Wed, 15 Jun 2022 06:22:47 +0000
Message-ID: <BN9PR11MB5276A9FB934BC5F6FA55D4958CAD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
 <20220614025137.1632762-4-baolu.lu@linux.intel.com>
 <BN9PR11MB52762E7602FFF7EE4B52AC888CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <28161d94-6f2d-700f-853d-53b42f4d00d0@linux.intel.com>
In-Reply-To: <28161d94-6f2d-700f-853d-53b42f4d00d0@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92ec12bc-93bc-43d7-99a0-08da4e977771
x-ms-traffictypediagnostic: CY4PR11MB1944:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR11MB1944470958F05C7EBC3AE7198CAD9@CY4PR11MB1944.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2a8IJIHfQURRGqfYswOHwEQteSxFVfwRKyeZWpbaIviT7Eqw5uHTchMkD9V/zEu3e0UjshS2v6V9rRcKezbws2DQIG1/8YjckeHKG+4L9xfmRj6tFRXQZH/nVnF42BaZQgKnErYAWl0Kly+VMIfaI9tgHLkjUdTCGMOT2Z76EuZQjCf8U9+QiiXzbkLf9buzjRiooLgHcq6Mug59tiKmmEdc0e/QSZC09hTsQ3O4GdfDozsXetDqQVDr/nRL204jsvSxtl1FPFGQrHHSzeECGhAnMw38yubpQckaQCRqWB71g2qqvZCk1SXByL6nPqV6VPfGXoFYtJ9h4LB6d14dNXJ2XBRqeNkrN1cZouWmaiBEVMn/BVaeYkEmV+UQic68LyB3E4fe63/aM77FqNRMv23tT6BBGooeftrAPUDME30ZWcy0Z8Qx/uYN9Qf79I7FXZpr/YAI3tehSfTXmD0ruof0sf5etBDxFouijqUuDQ5Awz6jFcY+Wj5KJOo0h13cGChfeiiiXzLNwobhQI2Qa5j5d8wvA09PAL0SLRe+M5q09IkL91fDFFuXJHn16Q8wHGIOGCd+ltEQcuurX/kQGjkyRXRdKxxU7GfSZoCt9M02x2klVZ1YzGbIWWD0wIS235wWp9NaUfuXnwS8e5UWSD8un01Li8hwRoOfXkKxJ+azTSCodNj7JzLNUjZgWtc53g1ZZhtD7IaXLEBoCDzY+g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(86362001)(33656002)(66556008)(66476007)(9686003)(66446008)(55016003)(83380400001)(71200400001)(64756008)(76116006)(54906003)(38070700005)(4326008)(110136005)(316002)(8676002)(8936002)(82960400001)(2906002)(508600001)(52536014)(6506007)(7696005)(66946007)(38100700002)(186003)(26005)(122000001)(53546011)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1YxbTdicWFnS1VqYzFKRnhSVzN5UXNaSkxJMXBRY1puZFVLK3Q5d1RBSnRK?=
 =?utf-8?B?MGE0K3dzVHZvbCtVYTBQWWhhdHJOUW1rejR2cGRSMnI1b1NHOWF5T0ptVnlv?=
 =?utf-8?B?L1AyUk9xY3YwUXBRSU5ST1VYenBJUjJpeE5MWXM0eEVpZ1NOODNDOHgvZ0Zr?=
 =?utf-8?B?MmRIa0NnZXRFc0VBRmdNNXNUV0x3Z2FlN0ZBVWhoOXJMWW82QmdhL1BabThD?=
 =?utf-8?B?R3VKQVdlUzliQ3NPUjZIb1BSdmc1WTJxMTIyUVczekU4MzFMR0poOHc3eU1Q?=
 =?utf-8?B?ckRaKzh6S3hLSTYrYVJDRmlpSVVITDZ0T3Zlc1VsVkc4cGJiM2tvOU9FeHly?=
 =?utf-8?B?SnhJaU5WRmxobXNMQUtCc2NEd0JONkpvTGlqOHhPS1pSNmZOd1orWE1Od0xP?=
 =?utf-8?B?SEFUWHJRN0hiUzJCdXdWMEFVT1AvTkxDQmJON1lneFlOc1FvR3hhbWZJWmhh?=
 =?utf-8?B?NjdyS2hRSjdOa3RTTUZiajJzb3FtU1ZFbzlaK1ROOXYzOW1XMzlyR0Z2Q2hq?=
 =?utf-8?B?SmkyQ3RTa3FCSFVPcURJTmNZMlF0Wk5ZVEhvc0w5a3JEa0FDTnFtbWJvOWlp?=
 =?utf-8?B?T0orSzArc1JqYndXcCtvZ2l2eCs0RXFjN0F1bHVxRmdtQzVmaTdrK2dydDlX?=
 =?utf-8?B?TkJmRUhWZW5qdUM3b1orNFBCNjJDSzhRQWJKYStiYXlnL2tMSXpIellUMUtL?=
 =?utf-8?B?N2pZZ1loN0REdWlHZEJwME15WStZZXd5UEkraDQ1VlhOYXNUYkRKaHNlMVFv?=
 =?utf-8?B?SWdEM3llU3JyUDFWT2FtRDd2ZzVETVVWWjQ1cGpRT2szcDdDbFlxU0ovN0VZ?=
 =?utf-8?B?VWdNZzJlS0E4cFhPMWtqRTV0di9vaXpQREpGbE1nc0ZPMU9VdWwvbWV4Ymp2?=
 =?utf-8?B?cnd6eDVzT3A5Q2hhb3BVSVJYWXczS2RhWkd5cStzZ3g0OFBLWGYwZ1FTS1lB?=
 =?utf-8?B?ZWZwdnkvWENOajIzN0g1bkFpN0x3MUROTXFmKzR1dTF6Nm84Q2lHY2crQTlq?=
 =?utf-8?B?a0RzTEhnVnJuenFDZ3hMQTlUdktRVTNjTHFUL1BYK09jT1NtTXJIaVg2czll?=
 =?utf-8?B?elFBMTN2UTlmZFlWS3JDMFhrV1lsM3JtdTB6ZC9NWis4Q0tFUW5FLytIcGwr?=
 =?utf-8?B?b2VoQlYxTy84RWIrZW1TS3hNUkxQT3VhRWQrUmdvMTdTR0hVM01wVktHeXNp?=
 =?utf-8?B?YlczSXhLOVBVaUZkN29nbmo0VTJ2bWg2QXpaSXJtS0RxcFlyMU8zV01zRUJp?=
 =?utf-8?B?ODI0UXNobjZ6eHlIVFh0aGUxSWg0S25qT0NtSFFuV1dOb24xMWlJeFIyY0hR?=
 =?utf-8?B?MG1tM0VYZENoNzNhSWoyb2o4ZEUxREhPUlJIZFR3aHh3NkRrRFBDcTVEd1pJ?=
 =?utf-8?B?R3A4NURPSE5ZaGIzNVVUdEpkZGIwVDM1TU9YQXR1VWVnNElsem1FWkRIUCtt?=
 =?utf-8?B?eHV4SFFiYStOVnRNVjJEcUNEWlh2Tmd1TmpDeUNWUkN1d1lhM0FQWVcrWWRp?=
 =?utf-8?B?dDZvYVlSeE9zZHMxc29LZmZzMExiZUZkUk5NZUV4NithTTcyRitnYXdHMWNO?=
 =?utf-8?B?U091TDFGS2xjei9KdmhEeWZxMVI1V0JCakRxZzhnY2ZwWmp4SFRjTkJONHMv?=
 =?utf-8?B?N28yaGdSQ0hyK0R3NVRsYVJIYzhYcGIwL2QvNG1yejJ1cWF1cDhNNUliVTVE?=
 =?utf-8?B?REZ0Tld6YW56NlNBWlYxTnRhT0hPZW42TDFyMWE2Z00wQVhNWWtmcUZVZEhG?=
 =?utf-8?B?V2NNUjVJUDJ0UW4zNEVzWGl5YzViVUxmTlNiZUthbkdEZ0o1TE9VU0pBQWVy?=
 =?utf-8?B?VXdzVndUOEJocVlFVDVWVm5UeXBlY3oyVldlQnYxb3pleTlwMXlueDQrNUgy?=
 =?utf-8?B?UlJJb3Q5bDZLa0dndWJITkxhdTRoSU5JNnJSUGZEN2dObHg0amxsQXBHdk8w?=
 =?utf-8?B?aDJCZ0VqK2drQVhJYzY0R3FocHNrQnphNk9uaFA4a0V6TGhWd1dYazc3UVRl?=
 =?utf-8?B?L2J1N0RPUUtTTThmWDZwOVRrQlFLUzk0NngvRDBPWEN5ZlhCSEZaKzlxb1Ux?=
 =?utf-8?B?b04zTFJOVHI3Z0NjV3l3cGV0ZUJKczdGMXNVc3Q3NXNGSFRMcDJhTzlzUFR5?=
 =?utf-8?B?RDVoamYyRW1HUmtWelBXQStuOElISk0xS2NYLzIxL2E2RlZpVGRYcXpBM25q?=
 =?utf-8?B?dVdaWE9SQ0tVQlRWVWJzZFNHeTZLN3k2TUVFUklodEhtckNsT2dWWFQrelll?=
 =?utf-8?B?N3lkWWVuOXBLbUNnMTIrVy9tKzB1Yld5Sk5Rem1vNmkyak1oTUk3YkdyenAv?=
 =?utf-8?B?ZExaZHF2UDNEOEhmTzhFUEdsK05HVFAyOW1oSk1DeTZ6SHhiUTdIUT09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ec12bc-93bc-43d7-99a0-08da4e977771
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 06:22:47.7152 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pA4NEoOyWOP8i1mfHxqq5dIf/k+rw3W+Y9zxZu3XdZcQM5nfCjTV9UU40Y16rylxtXddlkIoW4s9+1bQxoxjrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1944
X-OriginatorOrg: intel.com
Cc: Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Robin Murphy <robin.murphy@arm.com>
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
> Sent: Tuesday, June 14, 2022 3:21 PM
> 
> On 2022/6/14 14:49, Tian, Kevin wrote:
> >> From: Lu Baolu<baolu.lu@linux.intel.com>
> >> Sent: Tuesday, June 14, 2022 10:51 AM
> >>
> >> The disable_dmar_iommu() is called when IOMMU initialization fails or
> >> the IOMMU is hot-removed from the system. In both cases, there is no
> >> need to clear the IOMMU translation data structures for devices.
> >>
> >> On the initialization path, the device probing only happens after the
> >> IOMMU is initialized successfully, hence there're no translation data
> >> structures.
> > Out of curiosity. With kexec the IOMMU may contain stale mappings
> > from the old kernel. Then is it meaningful to disable IOMMU after the
> > new kernel fails to initialize it properly?
> 
> For kexec kernel, if the IOMMU is detected to be pre-enabled, the IOMMU
> driver will try to copy tables from the old kernel. If copying table
> fails, the IOMMU driver will disable IOMMU and do the normal
> initialization.
>

What about an error occurred after copying table in the initialization
path? The new kernel will be in a state assuming iommu is disabled
but it is still enabled using an old mapping for certain devices...
 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
