Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED98C433DB
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 08:16:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EA3D22C9F
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 08:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA3D22C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D264886CAC;
	Mon, 25 Jan 2021 08:16:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ouU2IwoS7XED; Mon, 25 Jan 2021 08:16:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E60F486361;
	Mon, 25 Jan 2021 08:16:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9D13C0FA7;
	Mon, 25 Jan 2021 08:16:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69AA7C013A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 08:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 56F8686673
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 08:16:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NpOU2sjAGywP for <iommu@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 08:16:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0C40F86661
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 08:16:35 +0000 (UTC)
IronPort-SDR: M8lUGJAOSxBZsdNsKCTWuCBd2SR9dT7fwExjVKdRKavxX6roymUSjrGSyVAxbNZYQI6YkZQSoM
 v7WNisldqgjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="176171161"
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; d="scan'208";a="176171161"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2021 00:16:35 -0800
IronPort-SDR: Zx/WsmSCKRNX8UpX7hlS15J+q7TlwoztNb2q79VrDv6JTZZHYFvzgb742wJJjGjUJMmuIiRrAJ
 cIGtwshWmcAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; d="scan'208";a="409542259"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by FMSMGA003.fm.intel.com with ESMTP; 25 Jan 2021 00:16:35 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 25 Jan 2021 00:16:34 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 25 Jan 2021 00:16:34 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 25 Jan 2021 00:16:34 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 25 Jan 2021 00:16:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGrEzGySNkCZmOjbg4THZZ1/NDY0pAfGmiIVVKh/5C8FVTgB4ydh2kaS+Y5SpBumwAaSRr9WOaIVBONEAWSp2gOLpMZ4KA1rGBxfkjJlK8F2t2Udgx7lDFLTG7wnZ1LTidwV6rTWFQFvd1fsnQRKB+fhJ78tmg0YuEv53I/Akx9VQbgF0ld6+Vp2W/naKRw9EtECMEhFedBqcdfkGqIqoHGnE7UVLn7qvNrDGCJv/KZw4E0cbmWnjSt5veFXIFmUmD7kUhmFNHjkZ4pB7VlD5AV4L1QfwhDY7VeTcpZEui4IJeYWQ8vqFtmP01DuqyA0DenBjV2zg3CMMlRuICPvOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl1qFoLa4YShH7i6cQw0uzE7TjgsNnocpcQRvPEVUm8=;
 b=Pbj1gBSEn8NHyVblYar1NGs7ZKHezqSvbtJ7TziLQIEv+47ifWxPW8a+iVtHy+wGENpv02MR97VPv74pVqVLPd3rRmoQyvB3yI6scuJjv74+RkguIXKWQqOlk/dOhNv5cja5WZiYPAooomKEn9eihiMJhvuqdPxWJpaQUKJaMGCmW0JJfoZQruoexVlfYaDcVT9sMA/qUut+0ZeAI9pqBkPNOJRbzwmEJZbt/RIdVX/tylfS26/yA/RNS9SMAYErMoLB6mXt6/6RzzWOJe42eF49zINpzAdOC3FCWFC7TfqS5oxYKsuatCI07OwFQLkQ/8fJNTPtiANHaLDzJHkcxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl1qFoLa4YShH7i6cQw0uzE7TjgsNnocpcQRvPEVUm8=;
 b=bO0A7Z1V5Q1czKV5P8OjzjzPQ1neMm6IRjQE4yL+OLjQdqJ9A+AKaiSrIZwYPCmdsVxWY3ghjb4inquSWUGJ8FwXe/M23XgEyVCPYETXQzIrFhdujLBw76Hd3fEk1r+nHA9lgStAd3gwqMIP2z7LJYqc6QFegwaUrDS2aByeQIk=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR11MB1615.namprd11.prod.outlook.com (2603:10b6:301:c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Mon, 25 Jan
 2021 08:16:32 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::f1b4:bace:1e44:4a46]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::f1b4:bace:1e44:4a46%6]) with mapi id 15.20.3784.019; Mon, 25 Jan 2021
 08:16:32 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>
Subject: RE: [PATCH 1/3] iommu/vt-d: Add rate limited information when PRQ
 overflows
Thread-Topic: [PATCH 1/3] iommu/vt-d: Add rate limited information when PRQ
 overflows
Thread-Index: AQHW75g+RLZFpZHZgU2TQsFksxSAmqozMHIAgAS3EgCAABh4oA==
Date: Mon, 25 Jan 2021 08:16:32 +0000
Message-ID: <MWHPR11MB188688A4C436B318AB0CDCB98CBD9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210121014505.1659166-1-baolu.lu@linux.intel.com>
 <20210121014505.1659166-2-baolu.lu@linux.intel.com>
 <MWHPR11MB18862D2EA5BD432BF22D99A48CA09@MWHPR11MB1886.namprd11.prod.outlook.com>
 <da341e11-0923-9127-3385-c2eab9e0db2b@linux.intel.com>
In-Reply-To: <da341e11-0923-9127-3385-c2eab9e0db2b@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4697f7c7-bdb7-47cf-efba-08d8c109864b
x-ms-traffictypediagnostic: MWHPR11MB1615:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB16154CA07E4BBCD7AE0673C18CBD9@MWHPR11MB1615.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4p6vPmQYSaaLwFEEjFyS5oDMfLubbtBGOHVL9h9lovvn9asQxg8J3ulhm7DVenbU3Mp8DsrYdZf1BI85rAzRZrFOBqXDUfHtux0vTLdqO2iS7+LGo4h0PYcGsf1JIC7q8akdoAam6g8igRjqJKy9WIBW11tTZKP5JFeNocDS3pGyrPksosOI7CafDrtcQlznh1vaaSGdN+Pj+BsFQLGsQi0AbEXBLhtO0lBghOlxxGLI7OPBIRTg9pdDaUALcdY0EKptZUusf9Rm7icRrlbn2ztcYxZImK9CTOo8BhgrkfkyPra8XzrN5oRyuO8W5AgfBJ4k+adMeszc2inttZhXxXppuZtE55uYxoyLCk3VU9EsufnBTn2XxB+GvuuKjq72tOAoIP2S7ipSHCpAJMsi7U8E6reXWBnOVV+SDUxcYxIPiON5kD6HhLSb8jqaNOKazSdPPwy6G6Bz1nmWG9CIrZ0fWWa9sT9IJmRKlEht7BwqetUDsDBxD0nPTOhEenMBpsgYHmtmN3wh7bWKG/66GGupDoA/VvuD7PEog4/zAujabeaKr4IY3TApnf/SQiqG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(83380400001)(186003)(86362001)(33656002)(26005)(76116006)(64756008)(55016002)(66476007)(66446008)(9686003)(52536014)(66556008)(4326008)(5660300002)(2906002)(6506007)(7696005)(53546011)(8676002)(478600001)(316002)(54906003)(110136005)(8936002)(71200400001)(66946007)(20673002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?bGlOWHpRMjFsMkkrUmZWWFpueVM3cDhHakp3dEhJdTRXSUlyTXJJR2NobGJz?=
 =?utf-8?B?cXFReTJob3V1K2pnV2lvUkdGM2hxNXZiRzdyUUNQaUsxZVh6WDFnMWQ0MVpL?=
 =?utf-8?B?S1ZTdldBWTZydG53WVBXbzhvaVVCWVVsQVpOcmk0OTdlZVFPd1lydlZZVzlp?=
 =?utf-8?B?VDdsZUFPcVA5enVua201MlNiYzEvZzJjR2VudkdLY2M1a1BZUnZlclROcWlR?=
 =?utf-8?B?K09vZzREaFNrSzNZZE1EUXV5QXBtTWNWRE5aTDJnWVVlSEw3MHRpeThidkhh?=
 =?utf-8?B?SC9vakZmMG9TMEtJTGhRVFN3d1ZSL05FclFWVzVEMjlQUmR5eHpHSGo0YlEr?=
 =?utf-8?B?WnphT0YwQmZ6TzVUVXIxanNYNkRoRFNxSER3b2lHOTRmektnRkF5SnlhWEU5?=
 =?utf-8?B?TTVxdTBvcGRVK2hKdW1hOUVTTTBXNXA2bnUrM2FIMWR3a3VNcHo2b3Ryczlw?=
 =?utf-8?B?UEJWNXZDRnVtR2hvbjdKdTFpcHBQbjhSMUQ0ejlHMDhVS2JaSVUyUWpDcFd1?=
 =?utf-8?B?dXcxcVZxL290U1VUZUtFY0FQRWxVZ2FnTjc0d3JyWWZGUW1CUk0vU2ltUzdu?=
 =?utf-8?B?ZTNhWnRxL28rZWVZZHhsK1VOK0VNTVhUSVNDSlpiSDlma0h0bVA0Y0NLNEhL?=
 =?utf-8?B?RmhDS29mRVZIQzRJM1NSY3BCQ0p3WjVrdlFLQnYvSHlpWnRJTjNqNTFVTDBp?=
 =?utf-8?B?TnQzdFh6amFxbFRhRmtmb2pRMVRwOFJmdUljT2lEdWVKZndmVXBTOXlwMi9j?=
 =?utf-8?B?SGlPN1FaQ0tUOVBhRjZlWDNIRUR5NldOOEt2amwvR0FzWlRsc251eXJzSkpk?=
 =?utf-8?B?cWx2eHVBVEs0MHlRVkJBNmdVcTRiZlIzRXBsbmM2VDZKQVRWNXMveVdjWnNL?=
 =?utf-8?B?UDFYc2J4MjVZVU4wZktwWThkSUFHaXFidytEb3dLWjFSbWR2RDBVbEJKRzNH?=
 =?utf-8?B?ZFJtRTFtMUdiOFcvalVnb0E0TTljWTFUNHN6bU4rUHJBMnhYOFdPM0szbWlo?=
 =?utf-8?B?c2V6MFd1WG5LcjlYLzU0UUdHWnUwdDM1UWxKK2tTWVNCWkN1QUlHMElGQmxv?=
 =?utf-8?B?VDUwZjdRNWtleDY5Uy9zYUZZSjdTbzBqQml1YWxPT3duOFpkNXI3SnI3RmQ5?=
 =?utf-8?B?S2RHY3ZaemplYTZhQ1ZrQStZYjZWbDVCcGp0cDZzOWNOckpWUmdVK1BmYVJD?=
 =?utf-8?B?S2VNb0tJaWVZYTlKQ0FUOTYwd2pMWlViaGpMZTgxbmlhb0liNVNndk5MT1l5?=
 =?utf-8?B?QzVhQ0o5NkZKMXZPRGZWc3h0VkNRWE14UlpFQVZqLzFHMUhBSnhsYzVlc3hk?=
 =?utf-8?B?UkRLWVdIQWFhTXlGaU01dEZINGdvRGtZbGIybDhsQ0JGZGx3QzZ4bGRHa1dk?=
 =?utf-8?B?UUNKR0xXaklLQU5rTW80cTNVYUxVZWZpbzNlMTliQ1VFZTRjSnUyVm5XcEVR?=
 =?utf-8?Q?EcjJHsjJ?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4697f7c7-bdb7-47cf-efba-08d8c109864b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 08:16:32.1086 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S1dNbiy14GL730UROucd1NmofsL4Uc2nUn6bMDKokbca+XlSuH6A/M62vLQAjzwHUMnoZMXpX+gg/7HnFobW+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1615
X-OriginatorOrg: intel.com
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Raj,
 Ashok" <ashok.raj@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, January 25, 2021 2:29 PM
> 
> Hi Kevin,
> 
> On 2021/1/22 14:38, Tian, Kevin wrote:
> >> From: Lu Baolu <baolu.lu@linux.intel.com>
> >> Sent: Thursday, January 21, 2021 9:45 AM
> >>
> >> So that the uses could get chances to know what happened.
> >>
> >> Suggested-by: Ashok Raj <ashok.raj@intel.com>
> >> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> >> ---
> >>   drivers/iommu/intel/svm.c | 10 ++++++++--
> >>   1 file changed, 8 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> >> index 033b25886e57..f49fe715477b 100644
> >> --- a/drivers/iommu/intel/svm.c
> >> +++ b/drivers/iommu/intel/svm.c
> >> @@ -895,6 +895,7 @@ static irqreturn_t prq_event_thread(int irq, void
> *d)
> >>   	struct intel_iommu *iommu = d;
> >>   	struct intel_svm *svm = NULL;
> >>   	int head, tail, handled = 0;
> >> +	struct page_req_dsc *req;
> >>
> >>   	/* Clear PPR bit before reading head/tail registers, to
> >>   	 * ensure that we get a new interrupt if needed. */
> >> @@ -904,7 +905,6 @@ static irqreturn_t prq_event_thread(int irq, void
> *d)
> >>   	head = dmar_readq(iommu->reg + DMAR_PQH_REG) &
> >> PRQ_RING_MASK;
> >>   	while (head != tail) {
> >>   		struct vm_area_struct *vma;
> >> -		struct page_req_dsc *req;
> >>   		struct qi_desc resp;
> >>   		int result;
> >>   		vm_fault_t ret;
> >> @@ -1042,8 +1042,14 @@ static irqreturn_t prq_event_thread(int irq,
> void
> >> *d)
> >>   	 * Clear the page request overflow bit and wake up all threads that
> >>   	 * are waiting for the completion of this handling.
> >>   	 */
> >> -	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO)
> >> +	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO) {
> >> +		head = dmar_readq(iommu->reg + DMAR_PQH_REG) &
> >> PRQ_RING_MASK;
> >> +		req = &iommu->prq[head / sizeof(*req)];
> >> +		pr_warn_ratelimited("IOMMU: %s: Page request overflow:
> >> HEAD: %08llx %08llx",
> >> +				    iommu->name, ((unsigned long long
> >> *)req)[0],
> >> +				    ((unsigned long long *)req)[1]);
> >>   		writel(DMA_PRS_PRO, iommu->reg + DMAR_PRS_REG);
> >> +	}
> >>
> >
> > Not about rate limiting but I think we may have a problem in above
> > logic. It is incorrect to always clear PRO when it's set w/o first checking
> > whether the overflow condition has been cleared. This code assumes
> > that if an overflow condition occurs it must have been cleared by earlier
> > loop when hitting this check. However since this code runs in a threaded
> > context, the overflow condition could occur even after you reset the head
> > to the tail (under some extreme condition). To be sane I think we'd better
> > read both head/tail again after seeing a pending PRO here and only clear
> > PRO when it becomes a false indicator based on latest head/tail.
> >
> 
> Yes, agreed. We can check the head and tail and clear the overflow bit
> until the queue is empty. The finial code looks like:
> 
>          /*
>           * Clear the page request overflow bit and wake up all threads that
>           * are waiting for the completion of this handling.
>           */
>          if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO) {
>                  head = dmar_readq(iommu->reg + DMAR_PQH_REG) &
> PRQ_RING_MASK;
>                  tail = dmar_readq(iommu->reg + DMAR_PQT_REG) &
> PRQ_RING_MASK;
>                  if (head == tail) {
>                          req = &iommu->prq[head / sizeof(*req)];
>                          pr_warn_ratelimited("IOMMU: %s: Page request
> overflow cleared: HEAD: %08llx %08llx",
>                                              iommu->name, ((unsigned
> long long *)req)[0],
>                                              ((unsigned long long
> *)req)[1]);
>                          writel(DMA_PRS_PRO, iommu->reg + DMAR_PRS_REG);
>                  }
>          }
> 
> Thought?
> 

Just a small comment. Is it useful to also print a warning in the true
overflow condition which has to wait for next interrupt to be cleared?

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
