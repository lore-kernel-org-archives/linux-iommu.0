Return-Path: <SRS0=vV0e=JS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F6AC433B4
	for <iommu@archiver.kernel.org>; Wed, 21 Apr 2021 11:29:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 921C66143C
	for <iommu@archiver.kernel.org>; Wed, 21 Apr 2021 11:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921C66143C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 293FB60B72;
	Wed, 21 Apr 2021 11:29:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fSX-AoJAQ5Zh; Wed, 21 Apr 2021 11:29:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id E651860B6B;
	Wed, 21 Apr 2021 11:29:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB397C000F;
	Wed, 21 Apr 2021 11:29:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7D04C000B
 for <iommu@lists.linux-foundation.org>; Wed, 21 Apr 2021 11:29:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B9C978343E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Apr 2021 11:29:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com
 header.b="gQISjukU"; dkim=pass (1024-bit key)
 header.d=armh.onmicrosoft.com header.b="gQISjukU"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oSFOx6jQAdkq for <iommu@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 11:29:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 62184830C2
 for <iommu@lists.linux-foundation.org>; Wed, 21 Apr 2021 11:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JkPs7n3ANCVaro2zObfywa+L35m8Vvz4fCFOZs+aN8=;
 b=gQISjukU+7w6nNXeku77Lr1oVVuPnhCR9hQQIWSglefTX6f56H+D1s1rl2hW5LhhQ5BAj1st/+xImeQphFKAW3syF3LhyuwM3KN1Xe2WmO0z6fcsfZLlQhgwHPTpIRYmzc9NFQNZ0w2+s5P3Rqhm4sBNhqP137387j9MDZQzkgQ=
Received: from AM6PR0202CA0067.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::44) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Wed, 21 Apr
 2021 11:29:14 +0000
Received: from AM5EUR03FT054.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:3a:cafe::e5) by AM6PR0202CA0067.outlook.office365.com
 (2603:10a6:20b:3a::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Wed, 21 Apr 2021 11:29:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.linux-foundation.org; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.linux-foundation.org;
 dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT054.mail.protection.outlook.com (10.152.16.212) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16 via Frontend Transport; Wed, 21 Apr 2021 11:29:13 +0000
Received: ("Tessian outbound 47ca92dabae7:v90");
 Wed, 21 Apr 2021 11:29:12 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 73a7eb35e3f44aed
X-CR-MTA-TID: 64aa7808
Received: from 774844412faa.2
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 D972EEA4-5C2B-467C-B0E0-6CB2E512D171.1; 
 Wed, 21 Apr 2021 11:29:04 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 774844412faa.2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Wed, 21 Apr 2021 11:29:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ci3yIpCB6rIg6mUO6Oq79Hp5wcffIHobHxFaHf6ilbSx9e0a9WnyAhtlVBg9m5d5RihjsgTg9zfhBetagwHt2D2HCj3JU1rS4uhEPRSU5yBY09ykyDcyQw5wpmiQDc2yz0bWU2mVSRKtvdpOwJd3MGtCAJ8V2R+fjhXPHuNzhY48A06lp5vTMzCbhtHXJYqI7PUKE5weqm0UOUf4IuyCRkRo/SQE/QpU+I5arNPf6DKE1GVjBixoPfWMsloftYtf5KrxLizMNVlhBkGmVNp1HJEW101aaDOP5S1kgHIJKrnaQbRBwdXdefKWrqer2XFIbsCCs17/MBkxcDaspc76lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JkPs7n3ANCVaro2zObfywa+L35m8Vvz4fCFOZs+aN8=;
 b=Yn4UyRimtBWfZk4bzUm7gkmucCWxLa/hzNYyAK9K5On//3Ax6zWuLGw5LM4zhU5OUzQQE4/wm+fotSaaN7+NAnqrblkSlWa8ec5RfOu9yA3us/nR0PMDDFofBQ6GVl9KnPrGsgd9kcbsLtSJ0YRrbYDNWNZrcWQ/wmd6pVCPQq7XCkdFXRxWZeiIcsFamWH/jIFN1bBlmMpxtrMHNJByDkZuGBISl1gPd9wApuC5RaTx2Pas2xufLeB7by+F/eXaFxJ7S35Di48mEvRUTbTfWsl/wAExCy78mJNXxXYkHXE4IWdluMBu+e48WBPBZPR8M+bZWXzymtDuqPiGeWLe0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JkPs7n3ANCVaro2zObfywa+L35m8Vvz4fCFOZs+aN8=;
 b=gQISjukU+7w6nNXeku77Lr1oVVuPnhCR9hQQIWSglefTX6f56H+D1s1rl2hW5LhhQ5BAj1st/+xImeQphFKAW3syF3LhyuwM3KN1Xe2WmO0z6fcsfZLlQhgwHPTpIRYmzc9NFQNZ0w2+s5P3Rqhm4sBNhqP137387j9MDZQzkgQ=
Authentication-Results-Original: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
Received: from DB6PR08MB2645.eurprd08.prod.outlook.com (2603:10a6:6:24::25) by
 DB8PR08MB5242.eurprd08.prod.outlook.com (2603:10a6:10:e8::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.20; Wed, 21 Apr 2021 11:28:59 +0000
Received: from DB6PR08MB2645.eurprd08.prod.outlook.com
 ([fe80::c0b9:9af:f4ab:768c]) by DB6PR08MB2645.eurprd08.prod.outlook.com
 ([fe80::c0b9:9af:f4ab:768c%6]) with mapi id 15.20.4065.021; Wed, 21 Apr 2021
 11:28:59 +0000
Subject: Re: [PATCH v15 00/12] SMMUv3 Nested Stage Setup (IOMMU part)
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, will@kernel.org,
 maz@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 alex.williamson@redhat.com, tn@semihalf.com, zhukeqian1@huawei.com
References: <20210411111228.14386-1-eric.auger@redhat.com>
From: Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <1d5d1c0e-9b2f-cf47-96df-9970aa3ec58c@arm.com>
Date: Wed, 21 Apr 2021 16:58:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210411111228.14386-1-eric.auger@redhat.com>
Content-Language: en-US
X-Originating-IP: [217.140.105.56]
X-ClientProxiedBy: PN1PR0101CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::30) To DB6PR08MB2645.eurprd08.prod.outlook.com
 (2603:10a6:6:24::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.162.16.71] (217.140.105.56) by
 PN1PR0101CA0044.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:c::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Wed, 21 Apr 2021 11:28:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1816bf6-1087-44dd-a57b-08d904b8b07f
X-MS-TrafficTypeDiagnostic: DB8PR08MB5242:|HE1PR0802MB2507:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2507467BA6E28FFA976449AA89479@HE1PR0802MB2507.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: buZjrO4Qcn4/wCul0HHuODFGQunDZWAIggVyX0HdpI0V7b+yvFFXVFHCUU7fGQwL6tJ+DOhipr6TYp0nSRQi6ngee9FuKsvXqWgVuHfoGCuqO39qBA1iJzH+KQ0DyuU8ylC1yoBgjsr7NESOKVCAW5jFC3+HHtRpbElrNJ8inONqvzad4v1x128yIz1aeS7WWvB5r9EXJuOQSqJCe08Y7p/6pcyPQNz0wnH5eD048bXmYHHxcHDZm2MnqweU3BBo9jNx3HSvG16Sa37uxiwpOBSBjGn87nCc3Yuhw73G9V9nv9GSqU9M+8i7JOadgirZeVVx3SpgTft+cmYvdleKI26BH69RqbhzSygYLdDEHuhnHHVcr2wb3PF3rj4igdDFEzdCUVuLdsjVp2yNze18eyRRr9sNiE9tFPnNXd2yGWVQ/XQDKX4FhE+jcTF4OKd8JnxjNZVzrs5oQh5UW9BzMhWUOfw+D+SPo7/qtRr4esU1OTqQfp4wC7cimEDzOobsq4gyiIrOooFiNz0wYriIirxs367fu9YagUTgzUzKVxpaeQp4mHMhkU0QB7FNTXX/m8mKEwjAIcKty7Hff8pMrFIrpc8jM5rxTY38sR2Pnw5wM82xN1BJ2anBtRVphBNdhzYe8Ty75LzjEAjCzmOwm7avgy1MdT4ojPfhPqmmkUKpKRv49prEIR5UpNv+RgQkZVyPqboyGnPwsCXebZkU3DUAaNFEt0td9HC9qlSIdB/6XfkEo5wl7m5E0NR20abKwXmliAu/ro4b7BeVNnJ4TmCXoYkFXJumT7GbzGfDzPhbJvSr6Eo2040K/gcabChm
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB6PR08MB2645.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39850400004)(396003)(136003)(376002)(346002)(26005)(52116002)(316002)(53546011)(36756003)(4326008)(16526019)(6486002)(8676002)(7416002)(921005)(478600001)(86362001)(38350700002)(6666004)(2616005)(16576012)(8936002)(2906002)(956004)(31686004)(31696002)(186003)(66556008)(66476007)(5660300002)(966005)(83380400001)(66946007)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U3ZTbnlwZ3lhYm8rM2czeXBoSTFCNGh2eUY0K1V4aDFpYk93cEVzZnRGTkxz?=
 =?utf-8?B?eVpwZlRhU3l6N3p5b2NwZVJXa1RDbDh2VE5tYU5GajVXN0xjRTMxaDdlc09w?=
 =?utf-8?B?dVFRQVZYeTV3NEdJMnY5YkdhTXFDcWd1MVl6cmVodTVvcXRNUmhnY1htVkpW?=
 =?utf-8?B?V0d4cWdFRGkranNTM2ZkNndKMVBZTU8xQmkrYnBqc3pJNjh5dGhGZHVDYlBP?=
 =?utf-8?B?Q0ZjNExlUUQyRkNNMm5mWUphamRsdU1HY3ExRFF0bVhzUkJnekFwQmtQZVI2?=
 =?utf-8?B?cE1maGZ4cnpzNmZuM05Pd0s4NXJZQ2xUZHpkWEl6cDNEd1pLRy85SGlPQTRz?=
 =?utf-8?B?QVpOeXR6MmFwQ1FKRGl0VEVrQS8vU1BRZFJCNUtkYzRqVjJ0QjRxQWxrNEFa?=
 =?utf-8?B?MGtmYmVtVjVDc2VncXdiYzZ0Rk10N1E4Zy90VHBkTUQwR1hpU1hEWEp6cmJ6?=
 =?utf-8?B?UUdRYWhkQ2Ftc29zY0VCNFQzRzBGRzZsR2hPaWJ3WDRwQzdRVGVrZVpzdWxW?=
 =?utf-8?B?b2ZCSnNaeXVwNXlrNSsvV05ndHJoZTRjb3hPZFVGWVMySkZaQTlTOWZxL2F2?=
 =?utf-8?B?bGlhbWRXVDFlUUREaVZQMkp2dmt0VGoyQWlpSWFlY1NJaUo3UGxOUzhEbkNo?=
 =?utf-8?B?K2NhcXAxNGc3VlRvckIxRGgwazFjMDFpRFZ4bU5BNDkvSEtKZHJPOGhnMlhu?=
 =?utf-8?B?RFJ6SnAxZlJpcjR3aHZXZGt4RkJaZStTQ2l1ZEwrc3dUMFFWL0NOMEczUUxh?=
 =?utf-8?B?d2hYYWRpcGM2V3dMekZ5UVlpWm00WmVuazBFNUhxZmhQbXRVckVmVks1dE55?=
 =?utf-8?B?anZVbzZmYlNrNnF6UERZVXphSGNKcnNoeVNjU0p0VC96WUdFelRybWpRbDRq?=
 =?utf-8?B?NGpWZGhqZEg4KzcrY0pOTm5SUlZNdDczSTJjdDR0b09aY1daZXp1ZVJiTlgw?=
 =?utf-8?B?WlljUTkzMlZmMmZoc2xXV0ZtZm9JS2NHN2tGcXJ2M3I5OFBNRStqOEFlNnkr?=
 =?utf-8?B?a2g5cHVwbzB5d0p3T0ZDMW1PQmQxaTVwdXY5bUlEZ2Z2OGdGZWU0cDZJVFV1?=
 =?utf-8?B?WFJpVlBxZTc3d2dmcUUxYStiT3MyTGNwMlNXc1dlTXA0NS9ob3pPVmRpR1da?=
 =?utf-8?B?WnJzTEVQNWN0UDEvdHhVMmNwdmFUY2MzTmFMdVh1K2RzNHlPMW1OY3ZKeFVI?=
 =?utf-8?B?M1UwTVYyZVpFNHhuR1dTRHMyakRWZk9tRTFRazJ5UWxKSktteDJ2SWlZcDRz?=
 =?utf-8?B?SzFRWWw2ZXV4NlVrWThoa01HWUFSL1ZYeHMyM3pERG5aZlpwUUtKMU9URmR0?=
 =?utf-8?B?eGRFUFNOK1RHalFBNDArK1V6UmtabWVrSEw3dU92Q2JFak5NWmdVTkgyeEhm?=
 =?utf-8?B?dnN5aFRrTEdQZGpDb2ltVzFRS05tYy9XV0pIcHAvUU1uYUVwVmwzT1pmMTZi?=
 =?utf-8?B?RVBSOFB0RTdPazNRcHRTY2l0SE01RGttdExMZ1dRbjMyN2hhM29yYlhsemRr?=
 =?utf-8?B?WEpuK1RkNDhDbnUxaFRDaVZqSTF0T1VYYUVIQ0VvVEFuZzdFSXAvTXR0YnMy?=
 =?utf-8?B?Z2FiQmN1cFZrNHdpKzZpK0l3VVJycXh4WmZ4MXV0STExVnZwVlUyNEdUeG9v?=
 =?utf-8?B?M0ViVDRFdEcxSEFSN2RaRENEdXoxcG5MUkIxVTFjWSs3VTVQSkgwNDhNdjV3?=
 =?utf-8?B?WStSR1dob2w5Y3lCM2Y2N2dmUkQ3U1dHSDI1TkVLanpTeHY0WWtSa2s1NWta?=
 =?utf-8?Q?4EbMecTHCe+IDYKJJrrbwUwxVGNpJ2rWtFRLj8X?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5242
Original-Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT054.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: e9688cee-98e3-4580-3e76-08d904b8a800
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p+JhVdkREQiXR2Y5VAIzVFAszjg0BsivfAz4/1W7kAs7LwlT3YKP98IY20uz58Y/vNGxNLYetZSSM8Y5snOBl9Urnw777R7Q+XmnF92KU2RXfzGVNx2QTE3Ga167YhyAaYM81f/S5shOUB8wTkPR0iS0YXYWHYTRaJv8/4NgJHmqORclPzUEjo3mYb0tijNtDpr0ZDRjRC8KTZ0jAlecB36nt3xeJAsJUIJO/eXTZHkSokklX0EHg34EhLU+EXMFVyULGBosqxxqHUR9YXgw1SJ9EP4C239uCzYvAYF4/Eh/1GQrreHWSHz3aFGGDG7yvi3vJ7B3uj2O+YhwTLTIacJPkDVN5f/Da2BiynryfeWaNtg2DFs0bAK9752/ED9N+WtuD2EceHV85IN9vyDX8fSv0V+owfVu7nv3lLyybcLbi7XJ4qCcxd/SrIs6ymBoLbDKUawCfnp8ujzjSuowJ6X6FLW/Kmw6E1xRbdey65pWQdQoV4dh1gwOsKCxBFQXC26bb2JG8nSamZ5S9Hv7hgSLF3O64TQJ5gbpPddpWbdqHkDYz7pMpBs0WAPy0wxXWV03IXxhMyr4lycuem/SebLdIRRS1DDEcIomhYNAfcCM29xpXDqRiiseMpfraTncRF3ljkBlKDmn3F8fJuWLBD6fhqlEtEfQWBVnk1sySbu3RPSUp6+H5q/Ypj6lVOQa4l//w8Xr1IP5UXCslePpTBM4jIiC2orwPY2jqkJhL1H0JRLy9W4s+tKUE+v4lZwQ1FQNGMBGGcPcy1oWicpTMg==
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39850400004)(36840700001)(46966006)(82310400003)(36860700001)(107886003)(966005)(82740400003)(47076005)(8936002)(478600001)(26005)(86362001)(6486002)(31686004)(8676002)(356005)(186003)(31696002)(336012)(16526019)(4326008)(6666004)(5660300002)(921005)(16576012)(316002)(81166007)(53546011)(83380400001)(70586007)(70206006)(2616005)(2906002)(36756003)(956004)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 11:29:13.0495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1816bf6-1087-44dd-a57b-08d904b8b07f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT054.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2507
Cc: jean-philippe@linaro.org, wangxingang5@huawei.com, jiangkunkun@huawei.com,
 lushenming@huawei.com, vsethi@nvidia.com, zhangfei.gao@linaro.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Eric,

On 4/11/21 4:42 PM, Eric Auger wrote:
> SMMUv3 Nested Stage Setup (IOMMU part)
>

[snip]

>
> Eric Auger (12):
>    iommu: Introduce attach/detach_pasid_table API
>    iommu: Introduce bind/unbind_guest_msi
>    iommu/smmuv3: Allow s1 and s2 configs to coexist
>    iommu/smmuv3: Get prepared for nested stage support
>    iommu/smmuv3: Implement attach/detach_pasid_table
>    iommu/smmuv3: Allow stage 1 invalidation with unmanaged ASIDs
>    iommu/smmuv3: Implement cache_invalidate
>    dma-iommu: Implement NESTED_MSI cookie
>    iommu/smmuv3: Nested mode single MSI doorbell per domain enforcement
>    iommu/smmuv3: Enforce incompatibility between nested mode and HW MSI
>      regions
>    iommu/smmuv3: Implement bind/unbind_guest_msi
>    iommu/smmuv3: report additional recoverable faults

[snip]

I noticed that the patch[1]:
[PATCH v13 15/15] iommu/smmuv3: Add PASID cache invalidation per PASID
has been dropped in the v14 and v15 of
  this series.

Is this planned to be part of any future series, or did I miss a
discussion about dropping the patch? :-)


[1]
https://patchwork.kernel.org/project/kvm/patch/20201118112151.25412-16-eric.auger@redhat.com/


Best regards
Vivek
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
