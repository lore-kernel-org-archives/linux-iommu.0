Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC6AC433F5
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 12:42:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 733E6401C0;
	Fri, 13 May 2022 12:42:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jtScBllyB8b5; Fri, 13 May 2022 12:42:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2B74E401B8;
	Fri, 13 May 2022 12:42:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1A51C0039;
	Fri, 13 May 2022 12:41:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20EA8C002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 07:54:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 08DAA41739
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 07:54:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P0MRrugAUNDY for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 07:54:11 +0000 (UTC)
X-Greylist: delayed 00:07:07 by SQLgrey-1.8.0
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 337DC41713
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 07:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1652428451; x=1683964451;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Ha+S6QZVIMC4KSypJ/PoMugEFPcY4uAaecmyl3QehRE=;
 b=IreNctG2szErLrBj9BItpMFNCMSjQM0l4POc/COyxVREUFYEBGf35GTy
 oKBnoYqcepyxB3x8efENUTGiGroET9/6XiQ3g9xX22wxXRCxDZAXOaNh7
 I90d8loNuLS5lA6ISEPkP90kiq0uJAlh7/4kDjFBRS4hmnwkFyq+ZlLIM
 i1JjwMPgnDAAa4sJntHIWoc+bcRn2aodEJH/1Wz2dAku2Y0f6e3IzByQ8
 57jCXTMW1tqlMpm4giIX8ntEOrM5Cri+X2wmkpqMjoG23Mr9iR7GLjPaG
 tuiYsZPXl3gMTtYl3n8wa2QOVb8alNEjhraZNOCBw69zlnlXPmLp0CHVu Q==;
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; d="scan'208";a="163534454"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256;
 13 May 2022 00:47:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 13 May 2022 00:47:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 13 May 2022 00:47:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCSjzpcS7HAsXPeUb9rGftPkxaxgATsJTcdPytMHEwDvJV+p8FgApLw7dvx6mHcznm63jaEyGbebgfj53NtI8lUPuhewxHPrs7206PXcS+Lrab6Ev/Z6MjAxORfjMFBA3ZycEfAd086Q19Mv8HZrYKyppycdmIx5roTjDsA2HK54TGX3HSM3chtGp9Xq3qgqdoDLrVDTd9nAnEGgZHNlsreaJSBFADKS3izSHS/8UOy+CWTNaAIOK9vy4Qb8bq430kBlOgqpzit/Shxv1SuIqRXorydl0PX9tzX2vOAScWE4sz/C1xqqFpvVX+9+gffPkk9huuy22KTmw/6GsgGszg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha+S6QZVIMC4KSypJ/PoMugEFPcY4uAaecmyl3QehRE=;
 b=dihUw7QjXxmKxTt3HaIElDL9gmtBA60lo5HGdMv2eGOrw51mIEzZRMiMSmaX/AHK5YabqPUOnuu8vJEDOW/cDu4RTZo00HUmOQp/5zkaaJ99EZUMz/qPT8UGlKY523u8wFx6HoErR4BrkOVO7qhtnAPQWfT4sAVAWL8IdfeKzZChsnigaDs+lS1qYFn9q4ZrsQw75opf5yNPrExDiZAS0Ia6ylvsS+h21l2z617PMM4syhmH57zBgl/XPTeq1sWnbYw9oSJAfhMSIvajjayyGh7w0RGoUPIbfK09//xAR4jqsiTzgPqWAdbtnmHS/8rvtlyIdtG9E1Dc2iFSnchsWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha+S6QZVIMC4KSypJ/PoMugEFPcY4uAaecmyl3QehRE=;
 b=n2ip1RhKOgPZlSSfev4XQh2g97AdywLdzsxr0lJ2xpdoXRO4p1Bs0ZKSMjs3kg+hmrtr3xh84eMJ2sYx/DMvJOMgZ0+3nLO1UBL8I06RHOc5O04WI/uJF6Q8/b6iL4ZRlwSSMaNyyb4uO/oLpAMQaehU065CYYAAVPP+DwDsC2E=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by MWHPR11MB1504.namprd11.prod.outlook.com (2603:10b6:301:c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Fri, 13 May
 2022 07:47:01 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::d10f:cc33:cfd8:365e]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::d10f:cc33:cfd8:365e%8]) with mapi id 15.20.5250.014; Fri, 13 May 2022
 07:47:01 +0000
To: <hch@lst.de>, <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH 1/3] swiotlb: don't panic when the swiotlb buffer can't be
 allocated
Thread-Topic: [PATCH 1/3] swiotlb: don't panic when the swiotlb buffer can't
 be allocated
Thread-Index: AQHYZTbP/7RHBCbSm02P2TeeL38cb60ccGmA
Date: Fri, 13 May 2022 07:47:01 +0000
Message-ID: <9ca9706e-7781-12a1-c4c7-ce3d27902ce2@microchip.com>
References: <20220511125805.1377025-1-hch@lst.de>
 <20220511125805.1377025-2-hch@lst.de>
In-Reply-To: <20220511125805.1377025-2-hch@lst.de>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13c3d6a7-e62a-4867-068d-08da34b4c3eb
x-ms-traffictypediagnostic: MWHPR11MB1504:EE_
x-microsoft-antispam-prvs: <MWHPR11MB150428956027E4B66106C7ED98CA9@MWHPR11MB1504.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LecszsyFTaId80FXtvUrykf6w9quKIjHzgsTVYOGvbfUpER40hQb9KlEpb0J3qv4fZgfBIDEn7iP82TnXv09Ayk82r9Cbp8eedTkIM/FpquneGJiFROquTRK0A70bbeCRyaRR++4SE36SXVxUxDn+jEhMTIdqo1pYn4cdGbAuELGskl1Ex2Rd6t9rHF+MgrAN76RbYmEUYVZWlws9RQKZzPBTo02MX3ZlEKUUXJykPT0/r07StdOiMkEqTzfykit85dpo5qs/HGBI460/v+dEgpAnJbvoIw18XqJoRILUzpWTBbOpzqOR9k7MXAl0BnosVdQqEWaQPRm6sijLQhaJIT1NGcS35B8xsCjyjkNk1FHav7v+KamRp7KPIVYCiUnZtaNg6ulv/ytAHL6YaxgnZ+6UrFgHLQguAkZ6APQDq48jmLscVQ50iR8ZwYZKjOZtDv2s3CiAHX1ZnoQQ1MxBEnDmvUKVmSBiRXKbx9VRwtDV75wC91YcnG/07Q0z0c394dCq0W0nYBfGxfuDg+sAzN4zM1fKQj9wjm+Tc8tWWYkH6QIV4k6fT4bj05Efsw8I3iF0xRXL0U2ywKii5AB4SZPjUvlSRaParVL1VJhAcuh6AYExQZL/f/pmmpzlBAkjOl1MPv+THYV+hRJVY7VElrrVkpFHIEGzNijGophuXWUPra6S2peejIMzqMXwuhVFT8JoYcg48duRV5Py24Ry0mEqtJMuczEmXO9s9j6b0ii9yfho/1+wlesm5HdFoIVbL5FRaUrkz0ZP9QYdAaDYg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5160.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(91956017)(54906003)(2616005)(71200400001)(36756003)(110136005)(6506007)(6486002)(316002)(26005)(6512007)(76116006)(83380400001)(8676002)(4326008)(66946007)(64756008)(31686004)(66556008)(186003)(66476007)(66446008)(508600001)(53546011)(86362001)(2906002)(122000001)(31696002)(38070700005)(5660300002)(8936002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nm9xdm15UTQrU3ZLcFhkVkUrOVM0Sko0MG5EVEtGMlRJbHNhRXVWcWRud3FR?=
 =?utf-8?B?Mm9qcExHNTIyQjM3YVZqb0tvck9BNEpJMkpYUGtFMUI1K1RTcG5WMGZWSEwx?=
 =?utf-8?B?UTlkNm1iK1pKdnpubnpDdytNTFBvRVF1VGRNSmxLYlJWb0pKNmFSV1FxbjBl?=
 =?utf-8?B?bEhMQ25qOVN3QnpnNnNXN2E3RUUzdFFnZEpNR0lvWUhHKzRSWUhERTlZcHVq?=
 =?utf-8?B?dzNJMFcvMEFMSm5tWXhqVHR0bkhkWGp3N3Y1MkdESVZudkREeEVyOXMvT2pl?=
 =?utf-8?B?OHNQai9sT0dqMDFxdHgwMGhwT2RXR3JBNGV5UDluaWgycVlwNkt3NkVySEtk?=
 =?utf-8?B?aU9UbEFXbU9PcDJnUjgwek5ZVUxFQkNybXo1Zm8rajRCR28zYzVzNVV6UStP?=
 =?utf-8?B?L21mdS9ITHZUa2hXYVBiOHczN0kyUFNUVUVnRzB0MnVYQ2htTHE2cUlQdk1U?=
 =?utf-8?B?ZGpsaEgzSDFwVG92M1B5REF3dVhCZER1SitUakZHYmU2YXgzVThQWEtQOUlj?=
 =?utf-8?B?QW4rY1dVa0NMWUlZZ3N5SW5kU2Z2MjBZOTFnQnU0cHMydW9jWjYzVEFsSXZK?=
 =?utf-8?B?T2laamROL3VqandHa0U2VFR2WmxweHk2ZmNnQUVoelhoTy80VXE1RGJ3c2hX?=
 =?utf-8?B?Znd4SllYc1QvZTgvZEVZWXRjN0UyQkpabzFPTlpHaE81MlhpYkV2dklaTlZy?=
 =?utf-8?B?bmd0NktIWTdyZlpIU2ZuZGZLQmR6WkRTMGN5NEoyS2dOZWxJTXZBekNhK1dY?=
 =?utf-8?B?cjR0OFVsSkRCTCtnZGVSUU9zdWUza1c4a3hSeU5VVjJrSVdETnBsclBWeUFP?=
 =?utf-8?B?Rnl0SFRoaUNPZWZ4VW5lTENSeU1QQm9QR25hTmJKSjdLNVoxZGdoNitubVZ2?=
 =?utf-8?B?eDV2eHpPZnRSaWwrS3ZNRDJ4cHRWZUlTdUNCeThOWHBONUtyb0VpTE1iczFQ?=
 =?utf-8?B?WURXSGVBa3F0dlpaekd1d1JxSkwrYzVKWUhSUGY4Q2tCT3VxNkZySlp2dmta?=
 =?utf-8?B?RDNzYzBwZ1JDQWVXWmhNeGpWc21pNjVrN01oNSsyQzN2YW91Q0ViVjRmL3ZU?=
 =?utf-8?B?TUMwcmx6d2I5NFhudkxrWGZiUHRqZDQ5S1dLQU40Zi8zUmJaczNPck02aDhz?=
 =?utf-8?B?RFIzcG5GV0kyQW9mN3pieUE2R1JZb2pGOFlRSEh4RnY0OWVkcVZjU2xzTlNr?=
 =?utf-8?B?UGhhV2wvdkRtbGdVZzdxSjlwK3ZoaHRKbDg3UWV1OXkxemgySkZyb3VHUm9m?=
 =?utf-8?B?VEJsemNMZ05TUHVQSHpKTysxeTJkaVVwMTNkSTJQNWVEdmV5ZUE1NHNqMFQy?=
 =?utf-8?B?WkdxY2p0SVJtNmFzT3V3cGZ3bkNNZXJuRUR0SlBxc24yREVKYlBHRTJ3c0Rz?=
 =?utf-8?B?SDcxWWdaQ1FvUERIU2xZM2dGb25zaFRjMTdHMDMrcVYwcEI4R0RkY0x2anNh?=
 =?utf-8?B?R1NyQmJRVFpKL1FrOEQ4aTRDOVJwUXdqYjV4UDlwbnBiYmlHcE14Ym9vRmU3?=
 =?utf-8?B?NGNHSjFQR3pLdnZiWjJRMTdSeURQU21TUDMwV0JnNHVzclB2Z2JRemUxRnl4?=
 =?utf-8?B?RHdIbWI0N3dZQ3VBVlFNUkZDaS9oZWlVV21NWTJ2Z2JWWk83OTRaMjFYQUps?=
 =?utf-8?B?SDFhRURhdmZjeDdkU1lwTFFSZ0pPZGtEWCtZZHNYRGhFZG02ZjFCREZMQ1BF?=
 =?utf-8?B?VmJNdmowc0gyR1lTbkJXSkcrbXArbHh0Yks3QzExZGt4d3paQlArZnBqMWNV?=
 =?utf-8?B?TXBNTjk0MVg2Q0ZaMFB2cnVBNWhRWUh2WW1nMkI3YWcyZ3pDL3FYb01rb2lG?=
 =?utf-8?B?RTZLS0lLcHNBdVlnYUV6dGJKbTBmOGFmNUFmWkFzblE1ZGVlTHRqQWwrVmwz?=
 =?utf-8?B?NWN0Zm8xek9McXFQdmhQZlhhVlllaHNjeVJ6U0xNY0FOYVM0aXEvOFByK0py?=
 =?utf-8?B?T29pNmI4aHcrUGhNTEtERWltQjZoMzFRNW4wWFQvWi9hQTRhaVlLamd4c1c5?=
 =?utf-8?B?Tnl2b1FCcXRaV25jMkpDNm1iMGVZWHlJZEo4bmhQZ2pVdEpmQlVmNlV4b3Ev?=
 =?utf-8?B?RjFnUjZjQ2dMV0FDSWxjRi9kcFJULzY4SWhxbCtJcXAyZk1XSDl2SGxQMDZT?=
 =?utf-8?B?VWszQ3dXRGpPdnQ4dzBGc2ZiZmw5NUNoaWtydGYyazErYmtXZzdnSlpVOC8r?=
 =?utf-8?B?ekMwK3lSU3dUMEZiVm4zazcvNVZBajFIUHVBNDl3NE0rMi9ZU3ZKYnZUMUZF?=
 =?utf-8?B?Vk9pQWxkcTg1WDlCNzFJV1VaMkVFdWFOZWgxaVFCN2d3Z1hiS3Brbjd5K3Nw?=
 =?utf-8?B?bys3aFFNV1Z1OC83QjFRS2w4ZWlzc0VXZVVXaCs3VU5CTUZ2TkFYQT09?=
Content-ID: <21FF77F77B084A45A1819E282C33BEC5@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c3d6a7-e62a-4867-068d-08da34b4c3eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 07:47:01.1751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7vMn8YS+NLYs6oJ34VwGCw9qth3U92k/zhjr/iNCedbz5AyxGJs3Rdxw9xfxUbvaL4YD+3gh7zXsxpXZKRO+uZK6gcxMZe/10tXZgbHNYJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1504
X-Mailman-Approved-At: Fri, 13 May 2022 12:41:58 +0000
Cc: xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
 sstabellini@kernel.org
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
From: "Conor.Dooley--- via iommu" <iommu@lists.linux-foundation.org>
Reply-To: Conor.Dooley@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 11/05/2022 13:58, Christoph Hellwig wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> For historical reasons the switlb code paniced when the metadata could
> not be allocated, but just printed a warning when the actual main
> swiotlb buffer could not be allocated.  Restore this somewhat unexpected
> behavior as changing it caused a boot failure on the Microchip RISC-V
> PolarFire SoC Icicle kit.
> 
> Fixes: 6424e31b1c05 ("swiotlb: remove swiotlb_init_with_tbl and swiotlb_init_late_with_tbl")
> Reported-by: Conor Dooley <Conor.Dooley@microchip.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Conor Dooley <Conor.Dooley@microchip.com>

FWIW:
Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>   kernel/dma/swiotlb.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index e2ef0864eb1e5..3e992a308c8a1 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -254,8 +254,10 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>                  tlb = memblock_alloc(bytes, PAGE_SIZE);
>          else
>                  tlb = memblock_alloc_low(bytes, PAGE_SIZE);
> -       if (!tlb)
> -               panic("%s: failed to allocate tlb structure\n", __func__);
> +       if (!tlb) {
> +               pr_warn("%s: failed to allocate tlb structure\n", __func__);
> +               return;
> +       }
> 
>          if (remap && remap(tlb, nslabs) < 0) {
>                  memblock_free(tlb, PAGE_ALIGN(bytes));
> --
> 2.30.2
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
