Return-Path: <SRS0=iLkC=PQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773F9C433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Oct 2021 01:50:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2226B6112E
	for <iommu@archiver.kernel.org>; Thu, 28 Oct 2021 01:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2226B6112E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2F5980DD2;
	Thu, 28 Oct 2021 01:50:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0LiNOHYEL-Dh; Thu, 28 Oct 2021 01:50:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9D27680A93;
	Thu, 28 Oct 2021 01:50:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7315FC0012;
	Thu, 28 Oct 2021 01:50:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8E03C000E
 for <iommu@lists.linux-foundation.org>; Thu, 28 Oct 2021 01:50:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ADF946066A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Oct 2021 01:50:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jAsgUFW38IJu for <iommu@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 01:50:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 58A3C60646
 for <iommu@lists.linux-foundation.org>; Thu, 28 Oct 2021 01:50:19 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="229055639"
X-IronPort-AV: E=Sophos;i="5.87,188,1631602800"; d="scan'208";a="229055639"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2021 18:50:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,188,1631602800"; d="scan'208";a="597601921"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga004.jf.intel.com with ESMTP; 27 Oct 2021 18:50:18 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 27 Oct 2021 18:50:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 27 Oct 2021 18:50:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 27 Oct 2021 18:50:17 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 27 Oct 2021 18:50:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lU/E0bIzGQMQINmi0nk42Rr+ET/xfGo0yp2c4iB2iBcceaivQPMFx/qgMTaq2TgxufwRLs0vBSi/sHxlfeDSt5ep6BAx02yn5/6uXDHcs/gDjjoOw9xSacuRgwWNbEvYNCE2FuvYT6f43AVvKWV/ZQ7ytkPSArLHvCaNc4es7gdiO3ufVv8DVh9TwFBuGdf1p8/ohiz+kVX3ejt5tDlqc4oI0TTydUQbdJIypbprS8R6qK/1L6XRCk53BhO0fdj2eGa3iJT716/anmM/HZsIPMMYQ+91MjEZFpWck0iGBhDM1Wm1dlpZSa/g1hnDQesTfmkcMv2GchKpXqOB5eDE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Xb6N1V3XpJezre9cLrTlwUKTRO6B/aNxTOpxu4Bof8=;
 b=gQWhILjJFy4Qm1nwOD/zbNlTJlXNTLoZnKIy6oCiaF4nTQPznRidgm//hBGMRxQiOPapkhQ+8w6t3tcFSFl9OIld+BfG8622C30+pUpL1gxZfxd5b7nqzXr5fctU3Ro3FecYEFBQWW6FsCppeFK/qs+UcU5KPGQgFWpfAK+kqOpBL6HvoUITk2nW0lSOOmdS4WcLHsEnOn8vdeBoZKMxKGgLke8mi1qstuX3ZX7nOzUBNTBKw5qtcs1puyt0h5kh0aB3LKEMO/XcYY0zIyfl1ogk2ZCcI6JvlKeDHItrSfHxi9XWHzvsTqVNq+OthNn6gmLtMtfJDZJe4hMEjaB3dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Xb6N1V3XpJezre9cLrTlwUKTRO6B/aNxTOpxu4Bof8=;
 b=Gp1fFSta3HDVJQEItKOAZGE6vev6NsvYhy6FsFi2iTtDrtPNX/eqbQyww54bL7YfbFSTvj5+aOoT7bd5omMuNLqjBFEKWRCorccvBPCs5iJMRqPBgRSl/ZpVFqgQtevZ9MFtnXwzmm/dhPap3OXkMjdUu/vwambkp4O1UrVCqdU=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN9PR11MB5417.namprd11.prod.outlook.com (2603:10b6:408:11e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 28 Oct
 2021 01:50:16 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ecad:62e1:bab9:ac81]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ecad:62e1:bab9:ac81%7]) with mapi id 15.20.4649.014; Thu, 28 Oct 2021
 01:50:16 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [RFC] /dev/ioasid uAPI proposal
Thread-Topic: [RFC] /dev/ioasid uAPI proposal
Thread-Index: AddSzQ97/vJYfIW8Gke3qF5WyXyLcQBL2ymAAKTbxpAAKSt7gAAHpf9wAB1YcAAAAm5sgAAA1YgAAADonIAAAEmcgAABzCaAAAHbfwAAAYTsAAAEeLUAAAiRJwAAFF14gAAPozMAAABMSwAAA0bJgAAVeTBAAAlp0QAABjX0AAAAf0IAAABWuQAAAD8IgAAAOC4AAABA0oAAAn0sgAAbQLqAAHzsuQAAHTjUgAALKb+AAAEAJgAACpEpAAAAd4EAAB0JvoAAAK4MgAAFtYKAAAV6DAAAAHyTAAABOkSAG2x1K8AACkXWAAAf+/xw
Date: Thu, 28 Oct 2021 01:50:15 +0000
Message-ID: <BN9PR11MB5433E055932A5C41463ED5E38C869@BN9PR11MB5433.namprd11.prod.outlook.com>
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
 <BN9PR11MB5433B2E25895D240BA3B182B8C859@BN9PR11MB5433.namprd11.prod.outlook.com>
 <861c6a1f-a68d-85fc-e6d2-1cd90f32f86a@redhat.com>
In-Reply-To: <861c6a1f-a68d-85fc-e6d2-1cd90f32f86a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 139e7912-3e58-4b3d-fe41-08d999b54a26
x-ms-traffictypediagnostic: BN9PR11MB5417:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN9PR11MB541748DBCBCB621904DA1FAD8C869@BN9PR11MB5417.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CNNNZRpeInYyvIdGj24ingtwfSBIPOJEZWNefMYDTwFcPTBK+8CxqlxfLG8Eqn5cgc0eGFZDrdg6cfiOP+QGVvv1IQQwKfmuhQwB13mjBEtESLSP0SS7K1RpcK+ZlcOnGVKw9vFEYj3N69swtNOU2eXXbl1oEWxqL0GVuwuK2V/bAHTWWuSEUqteuyi+mmCn/7lPOqTgy0BdX6j0Ooi/1lgQ7n4XWBNuL/fdIo/SvxvQSJuJLNxbjLkKgfxP/TeNZmELv6ufUJgjRPN37u+RpHZcbgENTDBkBMlsssC098EAO8/mXCNYIFyzZLSfHjfiieWyAhpUE7jj0rkxMffV3eCim5uEjx30BU/3hHpbgywOYKb0LXZvEbbPtU5UOEob57tvY3RShsd+JAp/GLMJwc0wUqeaYxwlUJM2tcVeT5SXDLdgQlU5+6yd/23dW5VTw2qKceQh7GCDfZI3zPhFclBfQ84bfwCyyeSVygjnohnRglqiDzDhEDFzCJizH9/1YV2V+FzF9sCb6+6bvSh/2cbXCpP9KfD3MORppLadoqxQrcPef3GKwrtBje1hHsSmwrSkKPyWc7strBXst2FaZVtwRkwEtozTQP+Y77pwHU6/bFdhPqOF1vnUUvbap6M+4FjmlT1tSypIf1HM4LE5s+bAs15HJEOWEfF6+lBwhuIgjJTlsYY6RHazxutlAVOa1dNkCwaGPKv+fzv03kJ8sw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(33656002)(83380400001)(7696005)(71200400001)(2906002)(86362001)(6506007)(53546011)(7416002)(26005)(82960400001)(186003)(66476007)(66946007)(55016002)(66556008)(8936002)(122000001)(66446008)(316002)(4326008)(64756008)(38070700005)(76116006)(9686003)(110136005)(52536014)(508600001)(8676002)(54906003)(38100700002)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDJvSy9TUnV3bStQaWR4K2FVT2tBL3BTUlkyeEpLcmV1anhzQ2J3QjlYUXRM?=
 =?utf-8?B?Y0k3ZUs4OGNKamYzdTVPaUl3K0c4cmlIUjRGemxJZFRMY0RUVTVTV1FCTEl2?=
 =?utf-8?B?Q3NrK1VYNlRZWXMxWE1tb2hsanJMWHN3RHJVbkJIQXJiZTBRc0RnSUFRNkh3?=
 =?utf-8?B?NEY4ZHhsSHBtUkFPaEd2T1BobzJ6SkZhQUwwaEVOQ3BJZjd1NW1PSm9xSmU1?=
 =?utf-8?B?M0RYKzRJeHdSdkEvNUhBdTV1YUhQb1dHTzRUMHZ2UjFWa2pJVzVEMzErYUxL?=
 =?utf-8?B?cENNTGNmM1B4VHNENEp0ckN3R2t2QVRoek5jV1h2Q29hWEtiTUdtbmgzeGlJ?=
 =?utf-8?B?Nnc5TWp5TUlzZkNpZVNudnNTUTh1aHQzdEh2UzlnMzdhSlg1YkpOdmVVY2ZK?=
 =?utf-8?B?YmpMcVNqL0ZxYW9KcTFXcW5kd1hKaXd2N3d0U0duVFpITFBBQ0VRSUxCOE1N?=
 =?utf-8?B?WklpdmN5SnF1M1FONU9PTVpzTUxKMzQxb2VuZ0RZRG5QM2w4WVA4YytNNDNu?=
 =?utf-8?B?dlByNG5wNmk5VzJxUHJJaGVKWGd2dSs1M1BnVTlGMUdRRTV1dW5SVE9Ja1F0?=
 =?utf-8?B?R3ZqM3ZabWkyd2Y2WUl0M3NqQ1Zma1g1TlBuNlFoM3p0a2JiNTY2RlZReUlZ?=
 =?utf-8?B?S3NRcTdEYkJ5SC9Xc2tselBGN0pLT3F1U3poRjBMb0o0S3FvQ0VGTW9YVnlx?=
 =?utf-8?B?RE8rNHlGN2pCbDc2YlYvWHptL1BSeTg2bEYwaXlER2lGV1FzeTcxS1NJMW4z?=
 =?utf-8?B?TVBlZ2gzUlJlMGNRWGNUd0R5MHJTeTJ4clVpWTcxZmxaNGsvbHhhVzJySWhM?=
 =?utf-8?B?dHBiS2ZHbmxad1JuTnlCU2FWdGhXdy9jSzk1b1pNVkRwQ1Z2MzZFVmo1K0U0?=
 =?utf-8?B?MlRQbE1IRHlUdHVVZGg2MUE5Q2g5Q3dVYWNaZC9iV0NGa213QWl4eHRVMjFr?=
 =?utf-8?B?RC9VblptQzdsZW9CeTVFQi95Z3daSFpjemRTcHhzZ3JQQWpNY05EaHJna3pM?=
 =?utf-8?B?dllsWVpOWjcvM1BSQTlzVWJYZkxDOGNJM2Nha1RVSzZzQ1ZYMUp3VzZOQTRY?=
 =?utf-8?B?TmhJTXMrTkJuOXFVdGthMC8vVTFVeWtibXVmQlNxd0tRRXIzZ2c4UFhSZ3BF?=
 =?utf-8?B?djNIK1hCVC9Fd2RWeDhXa2tsNmJqMWZhd1p1TSs4Q0V0Tno4WTZTY3RsR0ds?=
 =?utf-8?B?OHZWNm1pZTVseSsrY3crNlpjT0phLytDMkRBY0M1a2Fmc2Z5a1JxQnVwTnZr?=
 =?utf-8?B?c1VEeVpaNEFDY3ZVL0h2bDJxSnFCc05KTFRaL21EYTJwUlVUMk5YcTJseGR1?=
 =?utf-8?B?RmNkSkZya3phMk0rMGFUWUFYVzIvM2RGMjlrNzNMUW5HQWtTTDBCQUdkRytk?=
 =?utf-8?B?RlhROXpKQUF5UktZRmJSQngxbXZRbVF0dXdISlkzWktJbDRwVXdjTWVONDBI?=
 =?utf-8?B?U1Z0QXlVM0Q0dUVncm0rMzJxWUhhTTBJem8yQVBuQ2ZRM3ppSUpDT0JhaWhq?=
 =?utf-8?B?dEVCejVsTWcrZ3RUMTQ1OC83V0pCQk5neUZNNDVubW04dVlYZ2x2OFk0WHdI?=
 =?utf-8?B?T2VMSkF4Q1VrblFDY29Fdy9zRCtKWUdBcE8raFZGUW9RWmlLUnBReFN5cWpw?=
 =?utf-8?B?NG91TXZvK25PMTJSRXBucDNQZC9qSEYyUGV6ZmZPQ3VtR3J6bXk4blV3dGZr?=
 =?utf-8?B?T1liNkxEYlJJWVFSRkZva3d5MFUya3A0WVV1TUxSU0NGK3VqNlZYT3dkZXdj?=
 =?utf-8?B?UGZwOG5KcEFLWG9JOWNEOGlUUWhsV0dZZml1dXF3cDRmRm95MlQ5cFVVN2tW?=
 =?utf-8?B?WFY3OEVjN3ZSdUFyNG1sZjRod1RDS201NXF0YkhzNzFNUG04QmwyU1hLdEd4?=
 =?utf-8?B?aGR0R3VtbWM5SWNMUWQ2aDRiaDdlTFFBOWlwcnRTTUdXckwwWnJKOTg2bStr?=
 =?utf-8?B?dG8relQ5QitWYTZRMGEwcDVUVHR2TmJudDdPdVk5bmlmOTZqMHNqd1pBWXFn?=
 =?utf-8?B?SXE1MFhLS2VRMXNyUHozVlNPc2djUkF0cnZPKzRtS2s3YWlpTFNuZUhxeThE?=
 =?utf-8?B?UmZsclpLc2psa0xpeUE2RXZQbmZjMXBuQ2FpL0RTQm52TnlXbkx6cGNsaVY2?=
 =?utf-8?B?ajNOQkhYYTlwRTRiRkREcDJEVFFyTmlJZW02dndwTmVzeVVJU2twSUhVOWxH?=
 =?utf-8?Q?GDWGLqsbG1GgsFv5AWQX9Cc=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 139e7912-3e58-4b3d-fe41-08d999b54a26
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2021 01:50:16.0153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J+YdJpbKJ0etvltdpg0pIWDcaBqf4DMSL0c3EBnsy43BXgBqBVIRXBNgLXOe+9o69ion1O3alqPFedNQIxCu/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5417
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

> From: Paolo Bonzini <pbonzini@redhat.com>
> Sent: Wednesday, October 27, 2021 6:32 PM
> 
> On 27/10/21 08:18, Tian, Kevin wrote:
> >> I absolutely do *not* want an API that tells KVM to enable WBINVD.  This
> >> is not up for discussion.
> >>
> >> But really, let's stop calling the file descriptor a security proof or a
> >> capability.  It's overkill; all that we are doing here is kernel
> >> acceleration of the WBINVD ioctl.
> >>
> >> As a thought experiment, let's consider what would happen if wbinvd
> >> caused an unconditional exit from guest to userspace.  Userspace would
> >> react by invoking the ioctl on the ioasid.  The proposed functionality
> >> is just an acceleration of this same thing, avoiding the
> >> guest->KVM->userspace->IOASID->wbinvd trip.
> >
> > While the concept here makes sense, in reality implementing a wbinvd
> > ioctl for userspace requiring iommufd (previous /dev/ioasid is renamed
> > to /dev/iommu now) to track dirty CPUs that a given process has been
> > running since wbinvd only flushes local cache.
> >
> > Is it ok to omit the actual wbinvd ioctl here and just leverage vfio-kvm
> > contract to manage whether guest wbinvd is emulated as no-op?
> 
> Yes, it'd be okay for me.  As I wrote in the message, the concept of a
> wbinvd ioctl is mostly important as a thought experiment for what is
> security sensitive and what is not.  If a wbinvd ioctl would not be
> privileged on the iommufd, then WBINVD is not considered privileged in a
> guest either.
> 
> That does not imply a requirement to implement the wbinvd ioctl, though.
> Of course, non-KVM usage of iommufd systems/devices with non-coherent
> DMA would be less useful; but that's already the case for VFIO.

Thanks for confirming it!

> 
> > btw does kvm community set a strict criteria that any operation that
> > the guest can do must be first carried in host uAPI first? In concept
> > KVM deals with ISA-level to cover both guest kernel and guest user
> > while host uAPI is only for host user. Introducing new uAPIs to allow
> > host user doing whatever guest kernel can do sounds ideal, but not
> > exactly necessary imho.
> 
> I agree; however, it's the right mindset in my opinion because
> virtualization (in a perfect world) should not be a way to give
> processes privilege to do something that they cannot do.  If it does,
> it's usually a good idea to ask yourself "should this functionality be
> accessible outside KVM too?".
> 

Agree. It's always good to keep such mindset in thought practice.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
