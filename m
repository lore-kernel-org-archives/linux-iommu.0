Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B421EC433DB
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 12:58:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 584DC64FC3
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 12:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584DC64FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2484F43279;
	Fri, 12 Mar 2021 12:58:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wfMxWS2JEWcm; Fri, 12 Mar 2021 12:58:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id D06C743027;
	Fri, 12 Mar 2021 12:58:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B65C6C000B;
	Fri, 12 Mar 2021 12:58:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C43EFC0001;
 Fri, 12 Mar 2021 12:58:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A320C43271;
 Fri, 12 Mar 2021 12:58:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sUH9fbQRKyan; Fri, 12 Mar 2021 12:58:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20065.outbound.protection.outlook.com [40.107.2.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5651B43027;
 Fri, 12 Mar 2021 12:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvSyFiTxPCaW+AdTlZiRnk2jN7Y9bp9igHLsRfxi3hA=;
 b=El5TTsMoosvEcqKym4LphMM+RwDOOSLk7B9vwl0inSiN2bnM6HJkjdm3eJgcJZSU9qlyuY51dUUxBNMmDl6brjPk4SlKB7f1xkshuPLagv4p2tnlDObS3LQKjiXqXGt6sd82aZeRYJYluQsZdFLNy0H2hJUUSrHgmseuv4vtRk8=
Received: from AM6PR10CA0009.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:89::22)
 by AM6PR08MB5206.eurprd08.prod.outlook.com (2603:10a6:20b:e9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.30; Fri, 12 Mar
 2021 12:58:49 +0000
Received: from VE1EUR03FT047.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:89:cafe::aa) by AM6PR10CA0009.outlook.office365.com
 (2603:10a6:209:89::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 12 Mar 2021 12:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.linux-foundation.org; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.linux-foundation.org;
 dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT047.mail.protection.outlook.com (10.152.19.218) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31 via Frontend Transport; Fri, 12 Mar 2021 12:58:47 +0000
Received: ("Tessian outbound bbad306dbec1:v71");
 Fri, 12 Mar 2021 12:58:46 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e4e40f918792f211
X-CR-MTA-TID: 64aa7808
Received: from 96f317dd2b15.3
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 AB2F56B4-431A-4E9A-AA35-F1D4F15612F8.1; 
 Fri, 12 Mar 2021 12:58:41 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 96f317dd2b15.3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Fri, 12 Mar 2021 12:58:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mr8uVq5ETgqrZy1Qo0T2YB2i2safQHPhHWDzwsx3c2MZ4SrWPF/F4RuVdXoxmUtEI7LDDmoLZajUS5cZS5ZmZizqzu7G1ysENdTgVngcVwjvfiiRNZU0JXxl6vVeEM12UwnEjZZEA8aIk80K99xQVpJGgFj8f0XwdMTEHkdBL2df9kuAIP4O0VE0UZCvosy0TlPTI+w/fPLqwzuEorYV67ovvSVxCmoPjG90lC0F5g2avgIOcTRVymmdO4sLNStWJN1idGmqF7njyPQabh4MyoXvrvVEJK2oer/dvtgGR9217+4ZJ3i2W26rDMk7BhbCJ2FRa5nE8nOmqtc+uLQq5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvSyFiTxPCaW+AdTlZiRnk2jN7Y9bp9igHLsRfxi3hA=;
 b=R7Akvf87izNZbaDhVwlV4Fl8q55nI5tR4DUqqilfNT1L9d57Lap8nKkwzT5dPHS3uvVzsrtEO2iL653OqOH0kbOs1zMoEh7iBRcSOw9ryDq9/nuKe8Z0I1g7s4RUrUhQQJHj+lwbcgLQyjqjTKW7LPCf2ZX4jeN9v64RK/+ulk+4kFRHh2gMkAEWASIqvn5F3Fz+u421o1roueLwlM/LnuYmDwb9QGGIbcNUe62C9xa48PCXfWSLGWkZZERen6OVzC1epgawU7xJZ7pEIEf3YPQn3bn4+bM6gMF8JT+be2pclUA97Sgb9mAgoyXs/0Uk55Te+YnySUOZ6BbRHUJ7Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvSyFiTxPCaW+AdTlZiRnk2jN7Y9bp9igHLsRfxi3hA=;
 b=El5TTsMoosvEcqKym4LphMM+RwDOOSLk7B9vwl0inSiN2bnM6HJkjdm3eJgcJZSU9qlyuY51dUUxBNMmDl6brjPk4SlKB7f1xkshuPLagv4p2tnlDObS3LQKjiXqXGt6sd82aZeRYJYluQsZdFLNy0H2hJUUSrHgmseuv4vtRk8=
Authentication-Results-Original: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com (2603:10a6:208:65::26)
 by AM9PR08MB6897.eurprd08.prod.outlook.com (2603:10a6:20b:304::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 12:58:39 +0000
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685]) by AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685%6]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 12:58:39 +0000
Subject: Re: [PATCH RFC v1 09/15] iommu/virtio: Update table format probing
 header
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-10-vivek.gautam@arm.com> <YD/Fiuxd9/kThGxt@myrica>
From: Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <84bd0439-9517-37b7-8827-08c6effdadd6@arm.com>
Date: Fri, 12 Mar 2021 18:28:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YD/Fiuxd9/kThGxt@myrica>
Content-Language: en-US
X-Originating-IP: [217.140.105.56]
X-ClientProxiedBy: PN1PR01CA0115.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::31)
 To AM0PR08MB3268.eurprd08.prod.outlook.com
 (2603:10a6:208:65::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.162.16.71] (217.140.105.56) by
 PN1PR01CA0115.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 12:58:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 16b94e4f-a302-4ebe-fdc6-08d8e5569372
X-MS-TrafficTypeDiagnostic: AM9PR08MB6897:|AM6PR08MB5206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB52066F92C658E8D95C51B4C2896F9@AM6PR08MB5206.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: sCq1ZdYqC2ZP1vkNAbKgywR4XROgOyLpqA20YcxPAT8f10SldRwbJpXde5F/Syb13vWRDThYLNvC3jgU3NJcFeXvM0Ljni1yMJS0uD4D/mZUrl8tlhF7v7hXilP9OW0yInvVNQwicgGitiPaQRnMDz9fdKCwDeujMPU8JvLs9U1V4tXtlQlOfys5bFE+MjW2wBMMyAoct9i8evsRQQlP1jjq8HQ/dtoAnwcHFeMYrhg63tDKoMdQQ4Fzpo2pwC43dk0+k3PzXC1meUmPjpQF0XWs0dYl5CySlBbScb++FWXnDok3MYfUSyxUErkTwKTFvMWmqU5VoY+2W6fBbNAZNUCnujL7wJ3QjQB7CTtWn+uQipTbM+E+B0bMo0YrKo5UuiP5mOXBUHvelF9TMChwx4TYFlYEkUy3isolwBn8XrbU7NG0Xi8Sk4VVVfMqiJRlfRTA5C0EYoGxOTZX+ClBTQDHUn8NG+k/z6tBWlGcRxBPEgbn5dTCRoXDi+HZmqf5CmpmDUdaDta7sl7Ent5rPNWnoQQQEFxttq3n+xbrb+ltedU9mxOF/NlxXyF1kJgv0hdTZL5XxvY6rget/Yft1t+LjxrcXMuXRJixEFQXIequHi4LZGyi/MdqSI/d+IRA5f+8vNaIi2t+EaswuDDxKg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB3268.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(478600001)(8936002)(16526019)(36756003)(31686004)(8676002)(53546011)(4326008)(83380400001)(31696002)(86362001)(6666004)(52116002)(5660300002)(186003)(6486002)(66476007)(6916009)(316002)(26005)(2906002)(7416002)(16576012)(956004)(2616005)(66556008)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YVVja2laOFBNSURMZmp4cU5UR2FybnRxVFhKTlVBb0VyTmluODFlTWFSWG1X?=
 =?utf-8?B?TFZ2dmxnMzJxUnFzamdoZzRUb3lCMjQ2WmlDYnJJbFRINEFCUkJQclo3YzVH?=
 =?utf-8?B?TlR2cklwT3FoOXUwM3NINUdwcTI1QmlsZXU1ZlliMGQxTGllellyeWprUnhT?=
 =?utf-8?B?N3QvUkk4VEJwZEFZUTdKTU56WHUydDNkOVNoek9KSTUzcTI5eFJmcXRrUW5C?=
 =?utf-8?B?ZTM5U01QRnBtY2RWZURaV1k0VEF2ZGthSlNVQ2ZIS1hDczBQUitpN0RxeW5V?=
 =?utf-8?B?YzVjbGRxM2lEcTFnditLNWRRZDIzNEhlVlBNRUowUitrQ0JpL1NaWTB0Ri9a?=
 =?utf-8?B?ZmJQSmNIakoxb2thVmI3K2ZqOExZblF1TWN4c1FVUXhUUlhxYkRINExZcEti?=
 =?utf-8?B?VGVyUmlqYm5HdW1Ub2h4ekd5MEtkaXhma1h1L1JmUmk1TFhWczBodWYvd3dJ?=
 =?utf-8?B?NHF0L1RPT1V5c01BTVRhWERiNUNTTjlHV2tyM2ppeFlwZUpIY2hYeVVLMUpG?=
 =?utf-8?B?ZDE2YmlUNm1CQkMvcG5PY21jS1I2K21Kby9mazFGN2o3K2NyNzYxNU5aYmhU?=
 =?utf-8?B?d3RaQUtaMEh6QU1sMnFWWFBrMFk2bE1DbVQyOGhXYitMMk5tdnhvL1ZKdkJM?=
 =?utf-8?B?cnM3STM5akFJdUU0SjQwaDRGSGtvbVdTUFNpYTRnbjRRckJUZ2lJT3ZmUTFs?=
 =?utf-8?B?Vkl6dzM2TGFLVWU0UEkwbDhGN2dSTkFWNDRrOG1CV3AzRkt5R0MxNTB2ZnNG?=
 =?utf-8?B?VFB6YXhuOU93V0gxL21wbStic3JZbG1leTlCNHZJYVpzalRaQ3pZbHJZTHlT?=
 =?utf-8?B?ZHFsUnVtbkJKSEdPQXdCb2JKenpQdk50dk9HY2lkVzFraVg1LzNoRkZzSmk4?=
 =?utf-8?B?RlJxM3VSL0tVMFdvQ0tJb0NLcWNvOW5hNFNoUkRBZE4yMjFwbnJCbFl3VlZL?=
 =?utf-8?B?N1QydUg1d21JZWFIMFIxdEN4NW1aWkNsTFlYREttRGtVWUZnUjhoL1ZmQjJB?=
 =?utf-8?B?TEJ6Wm1jUjRsajAwQ1hCdG1lU1k1ZUdiRVp2T0RFTkJVaXBneHJNc3J3em92?=
 =?utf-8?B?K05rTGsxRXMyWWtPUk5sUUJwbkR4RkYrckJaaVVDa1lRSnZrb1FiLzh5RmZs?=
 =?utf-8?B?SkYrL3VIdHRsTU1KbzZJTUdHdmJyRmlCM3MrRmQ3a0llV3owWU1rUlBvdXRI?=
 =?utf-8?B?dW9SdEprQ3U4U0R2T0tGVnBlbUNwang5ZGZvaVJ2Z0ZxK3dUREsrL0hjV0xO?=
 =?utf-8?B?UjZNR1pDWE8weVJMM0RsUnFWL2xpbmNPTVJqRVhBeHR1Q2s3aE9YRERxMFB6?=
 =?utf-8?B?TFFSckhFNUJQRnFpcFdFMFR6UEpvQVdmczJPSDVOZEZ6Nm1zUkh6WmlZcTBG?=
 =?utf-8?B?OTBvYnJuT3IyWEx5TFEvZmJKaXo2MTI0OVZITnIvcVk3SUFHbVNjdTI2eThM?=
 =?utf-8?B?Q0NpK0JYdWJZN2FjLzBwU2EyeGJaMHBDQ1NXOU5LdndRY0hxVjhFWDl3RktD?=
 =?utf-8?B?eStxdDd0WnJHZUtkL2w0c0xXOEtIVTVxYmNVU0k3RExYblpDOHNxSDgwd2Uz?=
 =?utf-8?B?MlpPN1BZSnUxcllyU3ZsaGZ6UWJPYkdJV1hrMkUvb1ZKeHJ2dFlpZ1lQMDgw?=
 =?utf-8?B?a016OHR4WFdBdkgvcVdkZnpOMGhxRzMvbmFIRCtBanE2WGZ6WkhxM3pFeTlk?=
 =?utf-8?B?SkpPbWVUNTJPalp2czY2MW94S2lmbnRaOXZaRy9CZmtkc0NjR3p4OVFCVGlK?=
 =?utf-8?Q?9zkSWIzJbw7Jev0zfmxQ1aEFTnd+eOy4N7RadN0?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6897
Original-Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT047.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: cd491e29-8b33-4d77-c529-08d8e5568e46
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fih+0P8h2zvGZwsV3EZp95+bvJGah7hkxqnwOAebpWvFRSGi4acSuZ+9FDvPNQ+i6dT9c1w6uNgqnqviX5rTSghuercyZMcjDivjX99G0BLVonSToiu8hC/jaCDKO9kq+B4aYsnW1onPHS+xODCnKmFDo8B+E4MGdr3vz2dGD72aXolHV+yAoAuh6VRP/QW3wFCxnSk0ElGO6ltidt9K6AJXQbOgmzWUqgnYKSFg4y3Lb5iO7FG2dawQzXSlrTQYRg2uSMCN9SJverT5biMDo8QJ/vunY4UadSv+Iht5rtkkk42mtPoQUzQJ16E5gvJHE1jqvtGbvAjM1s5Cfm46r5xkX8sIszaJm+C0RQFSGK1ZHyLMiaRF4KMmpPm/s2ucI/zAB0R1P8mUdGPpsPPg2e5fsLoJm4h6M7C5IywOKm6/suNiIbVWQuzODN0ip6emvRC3UFM1dJIosagmeqLOoVpLGkeKzDOE1uSvbKW8i+JwKKWANN37age+B9Q81wzv1cA9cgyhZ+gUFTUrPWFKv0csnlGBo7bbHFu8vns2Oy5JcObGsY67OabTljIuPwFGDIOGKy2HiqYB3PHHBdhpuYrBvPZ+bGTTGZeLcZHedFu5O5EW6WDsZsSj8kux8qz4bHRW9qps6qeaAUe6KOHgj949h5o6Rp3DIvpPA27JoZM0noHbY+pTEe5RCLo4vAw8
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(36840700001)(46966006)(81166007)(70206006)(70586007)(336012)(82310400003)(26005)(8936002)(2906002)(450100002)(5660300002)(6486002)(31686004)(4326008)(16526019)(2616005)(6666004)(31696002)(82740400003)(478600001)(316002)(8676002)(53546011)(6862004)(186003)(86362001)(83380400001)(47076005)(36756003)(107886003)(356005)(36860700001)(956004)(16576012)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 12:58:47.4931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b94e4f-a302-4ebe-fdc6-08d8e5569372
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT047.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5206
Cc: kevin.tian@intel.com, alex.williamson@redhat.com, mst@redhat.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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



On 3/3/21 10:51 PM, Jean-Philippe Brucker wrote:
> On Fri, Jan 15, 2021 at 05:43:36PM +0530, Vivek Gautam wrote:
>> Add info about asid_bits and additional flags to table format
>> probing header.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Cc: Eric Auger <eric.auger@redhat.com>
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Liu Yi L <yi.l.liu@intel.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>> ---
>>   include/uapi/linux/virtio_iommu.h | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
>> index 43821e33e7af..8a0624bab4b2 100644
>> --- a/include/uapi/linux/virtio_iommu.h
>> +++ b/include/uapi/linux/virtio_iommu.h
>> @@ -169,7 +169,10 @@ struct virtio_iommu_probe_pasid_size {
>>   struct virtio_iommu_probe_table_format {
>>   	struct virtio_iommu_probe_property	head;
>>   	__le16					format;
>> -	__u8					reserved[2];
>> +	__le16					asid_bits;
>> +
>> +	__le32					flags;
> 
> This struct should only contain the head and format fields. asid and flags
> should go in a specialized structure - virtio_iommu_probe_pgt_arm64 in the
> latest spec draft, where I dropped the asid_bits field in favor of an
> "ASID16" flag.

Right, will take care of this looking at the spec draft.

Best regards
Vivek

> 
> Thanks,
> Jean
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
