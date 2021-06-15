Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6466FC48BDF
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 18:12:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02FB5611CE
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 18:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02FB5611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 943F440665;
	Tue, 15 Jun 2021 18:12:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j0sRhEe_KqlI; Tue, 15 Jun 2021 18:12:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4534C4065E;
	Tue, 15 Jun 2021 18:12:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19CD9C000D;
	Tue, 15 Jun 2021 18:12:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79228C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 18:12:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5A33940225
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 18:12:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xbV1Kody5y8E for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 18:12:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::615])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 51F1E400F3
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 18:12:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4tLZ8y25EClsNTjZ5eENHDv8WU9cmYVyjeu+j5Ag9zM931OVWIK0XWQHO7pgD7VKkAHOvx5dzMScv2tZ3es/JvoDLVNrT15lB14sli1sHMDSqfbAv8dGE2TErgqg3+o/ROGy/ESyZuWFF8mFATwibfddTtxTuya/M7TddHZdRMjyyrdf4ADtkd0fRBNglfB1Jahlfift7nGjqmgt7lJEg21aklpzzZFJBz5ts3JeBtqeIVLXhOg1t/ZSneulFUDU7A16P4YB7wLJzJTwmxOkPI6CjSbPiVKT+4owGT0doT6xKvHictJyLXr/g6U1ch8oJ5zKmUAi46vyw+2YEd2AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54isVuDyEYLjrNxhUHip47hLoSl2JOhuiLBoZftqRP8=;
 b=LvWdmcp7xZ6eHL64TX9YrWkMuAwhsOSlATYys7EEPN91hoCnxdf62X/RRDZiGCzSdVZNsWgw8x+H8B33/Mf7eeEvcvd/CvVVgnE17BLDl1rhZrPjKBCIba4T/4h8d+ast/uqIm8sE0YJ4eS1z3OGubTJ5Kq/HbKV8j7BeAuJAEtQeHZji4UEsNbBtxNOBxD4533qE3ss0ZsQ4Sw6nGXmL12Ns9L7uC4uCKKNCYFkUCw9X++LJIZjydJSG3kF5GyqdHBF/o78j1O+js8NAItiW3BXStT7VmjvG0wv61mefk2ntm0BZ8rIqL3c5Mur+8n0iIHW5AJQ9y3O0GKjqcYoCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54isVuDyEYLjrNxhUHip47hLoSl2JOhuiLBoZftqRP8=;
 b=H88Bb1Bh6eb9jGznqNRZEwY21nr1goEhgKp/TVlbcsgCTfy8/DL0vX3ZXRFH4RUTTml7KWgLWSFODCah2KpauwmxSfStZYXb1vFei0EUyfxon0enpjO4jo7EVudbfLmigE8wyGLUjLkqAf+XmPPGp11DnGAe9d+INUR5biiZyCYW9eCspVxPfipbgaPEwEM11TMBvx5eVLbwwl/xQ0lUhx3f2OBVKSCvlWvUaxjfftYAx6kkZMTmQEpJcUFygg1POssjuhJ95qCpVXUVMdS+XivS+UdmNv+0KOd9nttCnEI1uNhPX1sFiipaGdGk4z+ezAfNbRGKytaNVWmecaz8nA==
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BYAPR12MB3079.namprd12.prod.outlook.com (2603:10b6:a03:a9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 18:12:13 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::d05:4bca:ea51:15af]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::d05:4bca:ea51:15af%6]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 18:12:13 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Thierry Reding
 <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH v3 3/9] iommu/arm-smmu: Implement ->probe_finalize()
Thread-Topic: [PATCH v3 3/9] iommu/arm-smmu: Implement ->probe_finalize()
Thread-Index: AQHXWJfPf2pGDQJQNES1qS9f/cO5dKsVb8IAgAAB5HA=
Date: Tue, 15 Jun 2021 18:12:13 +0000
Message-ID: <BY5PR12MB376468558EB3330D64758210B3309@BY5PR12MB3764.namprd12.prod.outlook.com>
References: <20210603164632.1000458-1-thierry.reding@gmail.com>
 <20210603164632.1000458-4-thierry.reding@gmail.com>
 <CGME20210615180133eucas1p2563c2a173eca1fb5a1c5ccf654c23778@eucas1p2.samsung.com>
 <46e65ade-49cb-5437-5863-1f11ccc2205e@samsung.com>
In-Reply-To: <46e65ade-49cb-5437-5863-1f11ccc2205e@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d3a23ac-10f0-477c-e5e5-08d9302919f9
x-ms-traffictypediagnostic: BYAPR12MB3079:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB307908B562FFD6625C5B17F8B3309@BYAPR12MB3079.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HE2eB5356OcKywEktEgK56LgABqLpVRUdpKx6jt62JWd5yUMOpkamukk2fkIEJN1Uu/fhYawJeQ0Ni4s6IfCwebFczG30NbBnpnymFPTq5cWBUtYBn0JQJqaOsoGNaQuY6eZ2yesMEsMjOSi+J8MbnU5bc4NTwNbcYiCBSG0yd9gX9twf0opza2ZZqPxr0VxdiBo0ZW9oDR4ww02LI+oHtH+sDLOO6YDReD9PH++NSQsc5KjU1UdpWJP0Tj8Fwq66+TJjXbAFgz42MEKXQD0Qvkr3Jfi6kK437HLgvc1syqpZy/eG/1o+k88FzRVgUZ7LtLw5T/NuG6NhwavckcVGpN36OUGhhKLKFthNhM0nD2vVH+SdUU1Y3VZICPcGBG3qUHo+81FkCd/YeTjaZnXnIevlDBdedyt1z8EFXU/cBiKY4kNpdIJNke7E0RmzhUzUu674v7onRuz1TXN8sCrzGfJLkKae/ESHRT89ibvwoG+UNsI+ndpTTvjavPJRbmfer/w0g2fus2B9QGvb73DCOHY/nzt6zZf3ABoeZRhTMtwjAkMX88FKdEMzz5rQw6Hseb9k5r6G/aTyIrMs18tgR05smol+nU4VZ1iCmlmeII=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(83380400001)(316002)(52536014)(38100700002)(26005)(8676002)(66556008)(64756008)(54906003)(66446008)(66946007)(33656002)(8936002)(66476007)(478600001)(7696005)(71200400001)(122000001)(2906002)(558084003)(76116006)(110136005)(86362001)(4326008)(5660300002)(6506007)(9686003)(55016002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFlNc0dnT0hKM1psVE5XRENobVFUVDhQZjJUb2ZTRjVlY2NzLytFb1pNMWM5?=
 =?utf-8?B?ZUd0Y3NiVjg0WUM4Y0RBQmttV2VjTTN5MmxPbnpKU1haQ2FMNlZrWC9DU0s0?=
 =?utf-8?B?eE0wRWdBbmZpVEU2Ry9BekxmSHB5dEREMWdwMjV6QW5idFpyNDVTdGdVNDBF?=
 =?utf-8?B?RURDclZsOGhnV0V5SVBNRzh6RGFaSDNGWEpSVDVzb29sckFmKzFaUXhUWGxn?=
 =?utf-8?B?OEdBYXptZS9TaE8zMSs0RlFkY1FOUmR1TjgvTGdzenBib2tXaUxWNFVzUjNm?=
 =?utf-8?B?REtIYjY1UzQ3TjE2UHNLMDk2eWV3eFA3K3BOZEZET3dPOTdLbTVQU3NGV3hz?=
 =?utf-8?B?WUJzcXpodTREQysvbUZLSW9FNkVNbncyS0FjZG5BK3B2bldBaFZVbHkrdG1z?=
 =?utf-8?B?Um9tR09vS3pmRW1weUZVWGJGL2QwVmluVXlVVUVpa0g5dmxlU1VFV1Z3aTBZ?=
 =?utf-8?B?bmVPdXBzdU9CUUxxZkl2ZVdVdlZWVGRwV3FDZ2gzeUhNVk9hZnN6T3B1TnBE?=
 =?utf-8?B?bVhDanhPWUhkK3FCZFExekV2aGJGdFhNd2pSRm9jNHZvTk1pVCt2TmRmbjdF?=
 =?utf-8?B?SmRqbVZhNndqWkxVemJvSjZuRzhRWUNKVWlISFYzWmF0VnlsQ3IyYyt1b0k2?=
 =?utf-8?B?TVVXcWwvWkJ0NCtscjBxT1NjNDhGMUpqVlE4MElCR3kvNnhtNzlra3ZES3VW?=
 =?utf-8?B?MVZPSzl2ZGtxakxzRkErSG5QZTVqTll1QUhaWThuUENMa2hQSmZiTFFlenVI?=
 =?utf-8?B?bExoUUdMaTZncHFMN2JsVlk2TGtFQjFmRnliVkdRVStzY0hyOHJZQjM4dHUw?=
 =?utf-8?B?SnRVVFFkeDNmZWVPdU1SZ05McDZ4Sld2Qmt1YW10MmR6VGJqTk1CM1NBSUNy?=
 =?utf-8?B?Vmx1aWpKdE0xTlRDVkt4ekNtYlE2WFo1ZndnMXNDOFFUVnFIRUw3dHErZzZH?=
 =?utf-8?B?UkdjcmMxa3ZVWDRrb1UxbGFsUmFSNFEwUmEyQ0lOaWc5ODBLOUZtQTJhQXA2?=
 =?utf-8?B?Zyt6OWI5clZSamRkTHBIVEl0NjhvZGdxdUh2a250bGtQOWc1T3JweFNhRE9C?=
 =?utf-8?B?MDVtbXgvZFg1a3J3SjhqTlpaSmY4UGM2dDhzVitzbHhPY2YrdmUreFJqT1k4?=
 =?utf-8?B?QUZVbGw0NEhHMnZ6MjcrRlZQUlhac204aENGN0h3VUVMTXpiOThZN1VSUG1W?=
 =?utf-8?B?bTJhMnY2TS9vR0l4VEZCSjVmOVVUR3dKVWMrU2RqeXlROURUMGVHQ0dZdVhT?=
 =?utf-8?B?bkJsanZHUnE5WG5zUGJQL1NjVlJqRHpSY2pTcDhxclpKMXI3K09XdjhOMHJi?=
 =?utf-8?B?RVc3Ym5lK1p4RU5tQWptVGVHK0pTMzF6cFRQS0J2OEFlRmNnaXNYdVE1T3Y1?=
 =?utf-8?B?ME0yWlJCZTZCRzZBT3ZMSzZIWTQ2bzgzUzg5U1Q0QS9KbVkya0hJa3BxS2Yz?=
 =?utf-8?B?YkJPemcxRFVCNFNGZnBXOElFdzhFcURvT1hLMHZQd0xCa05DMllWcHNEZCtT?=
 =?utf-8?B?U3UvUTJSUjRkd002OEpwbU9mOWlaR2xwdkhvZGFjZ0MrSDQ2UlVhald6dlN3?=
 =?utf-8?B?aVVscG1QNHAvSW9qVHBoMDlQNmExMFgwWXVTTzd4OUtJMzE0UmIybXhIeG5T?=
 =?utf-8?B?aXJQeEs3bFRZVWdVMFlwRzJlYjM5Zm1RR0pzOUkxWC9Xa21xUjZPdXBVRGdh?=
 =?utf-8?B?dUYvbzgyRG1NS1FmaEdFUHNCejkwcHdNRElxN1VCLyswM3VSWEdCMHNvbGdC?=
 =?utf-8?Q?jJ8X2n1q4CWrlnhkCZXTL7abqiKOQPWnVFYT8mL?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3a23ac-10f0-477c-e5e5-08d9302919f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 18:12:13.5317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mjyB1/pTYvkLQDJm5/qQZ/InbYAuOoonAJWUmcEeXCfESUPHViggUrcr/UYM6z+gBvF7slhKLtSoqr8DXSHlmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3079
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

> if (smmu->impl->probe_finalize)

The above is the issue. It should be updated as below similar to other instances impl callbacks.
if (smmu->impl && smmu->impl->probe_finalize)

-KR

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
