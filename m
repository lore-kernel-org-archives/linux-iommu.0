Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6488FC433F5
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 18:27:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03B37813C3;
	Tue, 10 May 2022 18:27:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dc_SrBAyZfft; Tue, 10 May 2022 18:27:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A80AF81393;
	Tue, 10 May 2022 18:27:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FE94C0032;
	Tue, 10 May 2022 18:27:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CFB9C002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 18:27:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D8AD64012D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 18:27:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=microsoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 12CE70XX7klP for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 18:27:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E062C400A4
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 18:27:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgSDOmfypBQYCJpRnOQNq/y55TqPHIfYht/ctECjUECDnQcGYZouZN0nGhrVWxv65xjlMDj6puo4s5B936lEmoQQNRF/Nf4iMfJr6EJIyEMe0PiPLeQGeVhD/0eGhvcFxvEM3ec6/eJmJJFd89lZYoDlvRt/WuR5kuNdzVcFiJSymuaSyPEaQ80LMmC+TKm7AWFiWQb49NtHcLbdeh1mIbAuzvGZddGT9MH3BQ8PGUH28lQsx7GEcxXb7L3HYgeUQpwxE9tREwAcEvbm1mJu3QDdVA+kaZyBzqhpxqib/oKiaAeKyOF9roVcz9PAQ8c3yut/uEBx26dqtJMpUxu2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtNq7ZKtBQ2nTqGkM5H7flWseKzCEAe0LfAXnQM97gM=;
 b=L94Br1xZmJL1eJDd3iy+Lak9lSSOPstOwMI0p9vBBt1SY/kjTBGHwwE6N2CZ8Ts3xv1utwhZESJ1fvtdDUjpPEeknMmGrAGLshqLFs4zKnp6dYxVJcrFr++cj1FO4Cj52Lzmxz41trkxFevcNBi3RULfpDFKxEJxYKPSi+H/P9yyZqI3TMoWPfHDpGpVACGHaCMytLH5SFCvXzRs2/kctS7ZoU3ymcRFj6Rzs9jenKZQgAOxHI3nhjjCpdWwyAVmPDJcP7CPq5jwBR3d7RUhj0VQ3YhQ6DTi64r3rS8NArDV+svpf1gpM5uUucFoTq0ZR43r1DOpDPl7sjQbkYCVQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtNq7ZKtBQ2nTqGkM5H7flWseKzCEAe0LfAXnQM97gM=;
 b=DgymNlJgSGohlb9gBL9+bbZk75dJWrVSisXo07F7oQ6rmaIU6ahVKn1akEufTaV8QQ1JczmhFgxOsUv5OxDX7YNas5/cAamUPg8oGbhtenXGq+1jx0yKNZ5ScihIUB5xHqU7Cq6tbJ7+6R3QGjMSnrjUS9Qge7XcGxtjxn5u3wY=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by MW2PR2101MB1050.namprd21.prod.outlook.com (2603:10b6:302:4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.10; Tue, 10 May
 2022 18:26:55 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::dd77:2d4d:329e:87df]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::dd77:2d4d:329e:87df%7]) with mapi id 15.20.5273.004; Tue, 10 May 2022
 18:26:55 +0000
To: Robin Murphy <robin.murphy@arm.com>, Tianyu Lan <ltykernel@gmail.com>, KY
 Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, "wei.liu@kernel.org"
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "jejb@linux.ibm.com"
 <jejb@linux.ibm.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "hch@infradead.org" <hch@infradead.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Subject: RE: [PATCH] swiotlb: Max mapping size takes min align mask into
 account
Thread-Topic: [PATCH] swiotlb: Max mapping size takes min align mask into
 account
Thread-Index: AQHYZHk5Q8VaDdWQFku6DdhrqUjTsa0YTo2AgAAb8uA=
Date: Tue, 10 May 2022 18:26:55 +0000
Message-ID: <PH0PR21MB302530B081D6CE6470D5F9A4D7C99@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220510142109.777738-1-ltykernel@gmail.com>
 <cd64adcd-26fc-0452-754d-7ab0f5536142@arm.com>
In-Reply-To: <cd64adcd-26fc-0452-754d-7ab0f5536142@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ff24acbe-2d27-4e9d-8f5f-85357c5c966c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-10T18:14:00Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f07bf67-e487-42dc-af2d-08da32b2a948
x-ms-traffictypediagnostic: MW2PR2101MB1050:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB10509876C833182F3A268855D7C99@MW2PR2101MB1050.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9KO6x4/a3lk6zCw5Iv7uj6xYlI40lQLsOHU83l+yZWsdJ7sg0HtElU5HwQVxBCyZu3Qld+YljHUNBxiDAfq+oWP8+w1aKRKS0MDAM9+POOKqa0MrqKWaLJLOV6Rm1XtnKoW6FCznoepmP1fLK3l5lyevZpSN1geTCvwCgzBcYs+KPMObQAUUU5PUjr8MmYhmWj47rd0gxhNoiKfdoeCSh/ukiDyPHGT6LaHiPJ2h+HgTXtenzOnZW9V4FBz4Usy1wiKsp8+XrcOif1e1pkiKYW1feyH8mfmAemvuaYYN2FDMJuP+fLFebbDbZu6sfp7urYA/yQaRbPxBAFWwfvzTAdCilatB/wRVOqZVTeTWQthzLM2b6dbbLiM9i5Rz9nuia4aLKxcEAm5eLWoKO2fuDCzlr0EvEBHf2DU8oTeH4BbrAfyOW61hhXjSUfrCCW7IdOXcT0nyotz6eHG0JLk+hjXG0/z5smvFWn2EnupCfv47UzXmnPMaTsofa8y2JrGaL3r/CcS6JwJekQKQ6FbIzJebVbGH0d8n0zrcj5QkFd91WlwygX0j4SCEL8iImA0JLB+1jQMGpU9ctqXcagbXVBzJreVZnCJbhrz+CyA/tTSiFOlBupVVwHx2pA/fpmx57wz/Flu0c5l9cB5Ukx3VdZfV9ujPnimaOKM5zbxf77Mzoss1fYWTqOimHSjefPwNSfD3gFKbrg6SkGRuGWOnsPsFA7T2+OvXO+wcb67reOzfyR511ov8aHQWlJi/sReUREajHSph9xC08K+r/i5LQg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR21MB3025.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(451199009)(38100700002)(38070700005)(54906003)(7416002)(66946007)(9686003)(66446008)(8676002)(53546011)(55016003)(186003)(316002)(2906002)(15650500001)(33656002)(6506007)(5660300002)(508600001)(26005)(86362001)(8990500004)(83380400001)(8936002)(921005)(4326008)(64756008)(66556008)(66476007)(76116006)(7696005)(71200400001)(122000001)(110136005)(52536014)(82960400001)(10290500003)(82950400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1pObklEZ0RtRWxEUDRwai8vWit0RlB5RUFMeTVwMHNwVzZMNlR6dS9waTQ3?=
 =?utf-8?B?ZjFYN3FCdjhEU0xLaVZRalRxQzc4dnVlYzNIQS9IYlNhbktYTzIxcm8xSlhY?=
 =?utf-8?B?aXlpUmFhSGhlaXZHYi9UY1hHWEtLK0RCeE00Z0M2QzhwRjRVcDRodlVORkdP?=
 =?utf-8?B?OUc3VE5KeWRJMVk1dHZTMHFENEd3NnVlSmVJYUJzWVJINkZIQ1ZQdHhRVlQr?=
 =?utf-8?B?YVQwSEpXN2RLam5tSWVGUU5sQnhSRDFINEg4REVOK1Z6VHJ4bHhzbnRoZHF4?=
 =?utf-8?B?R00vSFRFTDBBcjJrMFR1Z1BZTVdUZ3EwdmtuR3p4VkZsSFI0SmZSZFppVU15?=
 =?utf-8?B?cnprQlVXTlRtWjN1NzR2WVp1MmtmU3ZXVEgvRTluTHNtRGd4RjRyZHVGdkdV?=
 =?utf-8?B?OUdxcnpabmV5NnhjQU9tY0RTOEx5aGZJc2NEdG1ncFVMdW5yNkJlUGJ5TmN6?=
 =?utf-8?B?Um1RMEp3eE54alVldS9uN1hFVk1VNGtVOWdOeHNtN3h3b0FjZ0JTMlFJL1Bk?=
 =?utf-8?B?dG5YVUVkL3VQSzdBVDI0b2xqWjluNHI2cmI3bXllbFU5NTNmM2NnbjVLWUJP?=
 =?utf-8?B?K2gxSk5VZFZQMGI1Vjk1RTRWcW9qaDBFdzlKdVlJa0xXSU9KQWk4SkRLY1Rh?=
 =?utf-8?B?VUcvTzBQeDRkdVNKSXBuUUNSeGtBMGk4VU5FM1I2SlFOM0JMKy85dFV6R0Ns?=
 =?utf-8?B?dWl2Ym14T3RDVUhHY2Q3dUtOMXRLSGJNWm5ZbzRhSURTYWpjZ0pIcFBqTktT?=
 =?utf-8?B?S3RrQ1pTQXgrOFFTUk5HeCtXTU1abUVEK25mejFIbUo5Q3IvNG1UdjlvWFBl?=
 =?utf-8?B?bHZyZlFtV2dGUHIvczRZUFIxcU1MUTI5SUtYcVhyTGNQU2E3NjBoSXl6UzZW?=
 =?utf-8?B?YmlVWDFmRWxUTEJ3L25ma0FuMndEYk9UUWczMnJVQmdmRWZETVNLclRsbGFY?=
 =?utf-8?B?cU1ZRXBlMHJTaUM4a1J1YnQzQ2gvdW8yQnZHNUxWYjgrOWpMNndSeUpJaHVv?=
 =?utf-8?B?Rmp2SmlTV0lqeGRFdHVyQ2pyRStYMi8ydHBBSHdseEJSeFBZdnZ1Q3ZCSzFy?=
 =?utf-8?B?WUxobmZyQU1kQVZtMVdMTXhuRSt3aGNHdTFmd3lJUzRiSXdSME5NTVJCL3hV?=
 =?utf-8?B?WXRQREZLRExuaEZMYng5YkJseUF2MDcwalJqMzhDblMxVUphNEZGVEJSU1lR?=
 =?utf-8?B?NVFBaWUzTm5Pci9CbTlFYWNBMUtXL1Zsd2s2a082ZFBmelFxVUJOenc4SHN1?=
 =?utf-8?B?U3dsQXg4b1VIbU0rcGVwZXIvWVc2QWhPT01ZSGNCSGhZRGxXek1xV2U3VDlB?=
 =?utf-8?B?eDY1SkVWK1dtSWgvbUtSQmJ0QjJqUENSMURFYTIwUUxUMzMrQ05YZ0ZNL0FH?=
 =?utf-8?B?ay9QMVNaNXFzUEU0REJCaW1QQlNPZ0RLVU1rRzJWR2xsb2RCVWY5R0FGNnlZ?=
 =?utf-8?B?NlgrYXJ6MGJYMUxtWHNRS1R0YzkycmljV0tQQnBxMStTU3Q2ODJaeGFQMEVm?=
 =?utf-8?B?Z2FsVWJZdkU0NjFMN3hyWFZkZmtLOFI1QW4xbUQ2RW1MU3FlR2Nnb2p6RnA4?=
 =?utf-8?B?ajhxbzdOY0c2emFUZVZPY1F1YXF4MFQzWjhkN3A4Q1NFVWs5RCtxNXplS3VB?=
 =?utf-8?B?Rkl4bU1qeGdsM09lemtRS1RxOWppSFgrMDM4NzdTa2hVZWl0dDludElkalNa?=
 =?utf-8?B?bEowYUgwaWtrbkc5TklYRTdSdk16bmUvL1lpMEJiYjIxYzl6V3dlR1VMVU1F?=
 =?utf-8?B?WDl3Umw4QjNCTlZyOHhYSno4RFhSYnphQWtSbDY1VmJOWVhyRExJOWNEOXFE?=
 =?utf-8?B?U0FHUUhSQlRDNkRmWWkrWXQyZUg1eXFxQUFxbk9CU1c4K01LWnBJdGg0UkJI?=
 =?utf-8?B?MEtGc0lLbkliSXBXVE8wOGdaYmVMWVM5Tzdoei9ueHhsVjZHZHF4ZEpDNm5G?=
 =?utf-8?B?bUVEMVgrNmJZdlYxV3BQbkhibGRDb213Qmw1UlJRNVdNTDFNSzdEOVduMytF?=
 =?utf-8?B?V2NJZlZCakJneWlsbFl0NXZFYzlHa2RUdXllZ3o2TkN2UUVqUjg2dXhnQ2Z6?=
 =?utf-8?B?dU9kNW5ib3JDRXZKQXB5NW90QjhBSGdnK0c3Rjg4MCtieHUwUlQ2bkMrWXh1?=
 =?utf-8?B?bEs0YlVWNXhvQVA0THFYZkU1SHMzdkFHZHRseFJUVm1Pb1U2REFBY0t6TmFO?=
 =?utf-8?B?TStGMklMdFdxUnI0emw0YzhzeUtXV1BaZ3lTWkF5R0Vnd1QwNVJyRWRFREhL?=
 =?utf-8?B?NVF6VmJzajgrbHV3bVphb0thQm9vZGhJM2xsK2dyaWZrNFJsWVVCRS9OdExR?=
 =?utf-8?B?RkFudmhrWCtrN0dtWFB1UnVRT0lIRzlKaW1OQjVWMHlONmJOSllFSzRYS0F4?=
 =?utf-8?Q?WROuqabBbUvErqOg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f07bf67-e487-42dc-af2d-08da32b2a948
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 18:26:55.1076 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JombG1/SuA8q66+qpXVdqSiiUwzaSeWmfbrCaNc5utEoyBqgQ0c4IW0LnjL3D233yLU/i8OILUZNhfQyXSD6kqBAvifMFjBaGnr/kcX35AQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1050
Cc: "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 vkuznets <vkuznets@redhat.com>, "hch@lst.de" <hch@lst.de>
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
From: "Michael Kelley \(LINUX\) via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Michael Kelley \(LINUX\)" <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Robin Murphy <robin.murphy@arm.com> Sent: Tuesday, May 10, 2022 9:34 AM
> 
> On 2022-05-10 15:21, Tianyu Lan wrote:
> > From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> >
> > swiotlb_find_slots() skips slots according to io tlb aligned mask
> > calculated from min aligned mask and original physical address
> > offset. This affects max mapping size. The mapping size can't
> > achieve the IO_TLB_SEGSIZE * IO_TLB_SIZE when original offset is
> > non-zero. This will cause system boot up failure in Hyper-V
> > Isolation VM where swiotlb force is enabled. Scsi layer use return
> > value of dma_max_mapping_size() to set max segment size and it
> > finally calls swiotlb_max_mapping_size(). Hyper-V storage driver
> > sets min align mask to 4k - 1. Scsi layer may pass 256k length of
> > request buffer with 0~4k offset and Hyper-V storage driver can't
> > get swiotlb bounce buffer via DMA API. Swiotlb_find_slots() can't
> > find 256k length bounce buffer with offset. Make swiotlb_max_mapping
> > _size() take min align mask into account.
> 
> Hmm, this seems a bit pessimistic - the offset can vary per mapping, so
> it feels to me like it should really be the caller's responsibility to
> account for it if they're already involved enough to care about both
> constraints. But I'm not sure how practical that would be.

Tianyu and I discussed this prior to his submitting the patch.
Presumably dma_max_mapping_size() exists so that the higher
level blk-mq code can limit the size of I/O requests to something
that will "fit" in the swiotlb when bounce buffering is enabled.
Unfortunately, the current code is just giving the wrong answer
when the offset is non-zero.  The offset would be less than
PAGE_SIZE, so the impact would be dma_max_mapping_size()
returning 252 Kbytes instead of 256 Kbytes, but only for devices
where dma min align mask is set.  And any I/O sizes less than
252 Kbytes are unaffected even when dma min align mask is set. 
Net, the impact would be only in a fairly rare edge case.

Even on ARM64 with a 64K page size, the Hyper-V storage driver
is setting the dma min align mask to only 4K (which is correct because
the Hyper-V host uses a 4K page size even if the guest is using
something larger), so again the limit becomes 252 Kbytes instead
of 256 Kbytes, and any impact is rare.

As you mentioned, how else would a caller handle this situation?

Michael

> 
> Robin.
> 
> > Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> > ---
> >   kernel/dma/swiotlb.c | 13 ++++++++++++-
> >   1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index 73a41cec9e38..0d6684ca7eab 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -743,7 +743,18 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t
> paddr, size_t size,
> >
> >   size_t swiotlb_max_mapping_size(struct device *dev)
> >   {
> > -	return ((size_t)IO_TLB_SIZE) * IO_TLB_SEGSIZE;
> > +	int min_align_mask = dma_get_min_align_mask(dev);
> > +	int min_align = 0;
> > +
> > +	/*
> > +	 * swiotlb_find_slots() skips slots according to
> > +	 * min align mask. This affects max mapping size.
> > +	 * Take it into acount here.
> > +	 */
> > +	if (min_align_mask)
> > +		min_align = roundup(min_align_mask, IO_TLB_SIZE);
> > +
> > +	return ((size_t)IO_TLB_SIZE) * IO_TLB_SEGSIZE - min_align;
> >   }
> >
> >   bool is_swiotlb_active(struct device *dev)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
