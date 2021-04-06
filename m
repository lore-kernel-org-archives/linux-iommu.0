Return-Path: <SRS0=NW7i=JD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81567C433ED
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 06:25:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFC82610CC
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 06:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC82610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78BF040472;
	Tue,  6 Apr 2021 06:25:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xkNQYt-jVSeN; Tue,  6 Apr 2021 06:24:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 121B540457;
	Tue,  6 Apr 2021 06:24:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C57EDC000C;
	Tue,  6 Apr 2021 06:24:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2ED9AC000A;
 Tue,  6 Apr 2021 06:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 103336065A;
 Tue,  6 Apr 2021 06:24:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com
 header.b="BK+nlQr9"; dkim=pass (1024-bit key)
 header.d=armh.onmicrosoft.com header.b="BK+nlQr9"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gOU3pfC57gDq; Tue,  6 Apr 2021 06:24:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr140072.outbound.protection.outlook.com [40.107.14.72])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 869C560634;
 Tue,  6 Apr 2021 06:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvNmeqL0Bq6OSamAyd7ezaVIhzuimC2bKTFp3qxiqx0=;
 b=BK+nlQr9SOmDQ2wwPD3nZCU35vgoujGc//4qDA3VjwhLdGnZYvgdqtMlkrC+WHoXLer9lI4v27mjMfrcekqK8/dcb+9jH1UmIOwWpB3KrA2hISPSK9pZqr/2Dj3FM+we+bfttOUq4T84dRjiIh4IpjLqRj4fiW7KNyPe2ufRRZg=
Received: from DB6PR0301CA0078.eurprd03.prod.outlook.com (2603:10a6:6:30::25)
 by VE1PR08MB4750.eurprd08.prod.outlook.com (2603:10a6:802:a2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 6 Apr
 2021 06:24:49 +0000
Received: from DB5EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:30:cafe::57) by DB6PR0301CA0078.outlook.office365.com
 (2603:10a6:6:30::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend
 Transport; Tue, 6 Apr 2021 06:24:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.linux-foundation.org; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.linux-foundation.org;
 dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT025.mail.protection.outlook.com (10.152.20.104) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.29 via Frontend Transport; Tue, 6 Apr 2021 06:24:49 +0000
Received: ("Tessian outbound 34291f7cb530:v90");
 Tue, 06 Apr 2021 06:24:48 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 22a016380f7dc85a
X-CR-MTA-TID: 64aa7808
Received: from 95b4e39d71a7.3
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 F20BFF28-FA88-4F24-8A6D-7F6E08B88FCA.1; 
 Tue, 06 Apr 2021 06:24:39 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 95b4e39d71a7.3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Tue, 06 Apr 2021 06:24:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4o07OlOfbeuGNiPoOuY/j7ioaWEnQfbUS/tsM6hrSCxxtw8p5Lt+p9BLNeZ4JQJ/O1bYnQgb71seWIbGJwH9rVXjAkVY8Eenf+/gzPLGAeEiwmQi13WFNbB3941667Sp7K2OELs12SJ7UYu0KExEywl34GnM5QMJT5hl8IcrROUdk0WXGEMwPGNQUlSvmY2/iR6YF7h/obhNl9xFNHRkayfvsLCJgzQq4QlhGRaiDfJztwR4GAo9dEeWofuF9Cmczc+i7DQ3ny416ZWbPeKrcZ+qmWSltV6Xi6d01dK+CDkcPUDzsbJ/kvfKx38beZaOhvzJO0YJhGZoJs86sMpkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvNmeqL0Bq6OSamAyd7ezaVIhzuimC2bKTFp3qxiqx0=;
 b=alngMIspZktN/8ibnuiwbBEg7kC0YZFrqyOiv6M/LtrnUVZGTHvqFkZi2XJY1P4EA6dK4Wx7CbAtYsWseu1Nlxa4RCLy3OOUvqngi0GJpXDR3Iiy36sRKI3whuqN1stMm+eHkirHuZWXDDcAg6nzu1UcKNQHCfwZIyC3PGbQl6aZdaE7QsbTilyxsqmW9dsIElqGh9jxxa9WpbMMyydaSRaTHdxBunkmZgzZg6+07v06UDd7Ti8SIionPuDiWaSJjB3kbJa4X+VsR5q3rxXymbtuXW8qSSwxmiqEjb72CpQyaZhhB+2EFz1wxy44kze3BOck6vazlNe+J9kExRsf0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvNmeqL0Bq6OSamAyd7ezaVIhzuimC2bKTFp3qxiqx0=;
 b=BK+nlQr9SOmDQ2wwPD3nZCU35vgoujGc//4qDA3VjwhLdGnZYvgdqtMlkrC+WHoXLer9lI4v27mjMfrcekqK8/dcb+9jH1UmIOwWpB3KrA2hISPSK9pZqr/2Dj3FM+we+bfttOUq4T84dRjiIh4IpjLqRj4fiW7KNyPe2ufRRZg=
Authentication-Results-Original: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
Received: from DB6PR08MB2645.eurprd08.prod.outlook.com (2603:10a6:6:24::25) by
 DB7PR08MB3339.eurprd08.prod.outlook.com (2603:10a6:5:1c::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32; Tue, 6 Apr 2021 06:24:36 +0000
Received: from DB6PR08MB2645.eurprd08.prod.outlook.com
 ([fe80::c0b9:9af:f4ab:768c]) by DB6PR08MB2645.eurprd08.prod.outlook.com
 ([fe80::c0b9:9af:f4ab:768c%6]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 06:24:36 +0000
Subject: Re: [PATCH RFC v1 15/15] iommu/virtio: Update fault type and reason
 info for viommu fault
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-16-vivek.gautam@arm.com> <YD/GjQIKkaJ5+UJM@myrica>
 <d8a81406-12c6-a5e1-7297-49c1a0a800ab@arm.com> <YGH+5pHtR6gWnimB@myrica>
From: Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <248424c9-04ab-18b1-50f7-b995b6d7b1e2@arm.com>
Date: Tue, 6 Apr 2021 11:54:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YGH+5pHtR6gWnimB@myrica>
Content-Language: en-US
X-Originating-IP: [217.140.105.56]
X-ClientProxiedBy: PN2PR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::29) To DB6PR08MB2645.eurprd08.prod.outlook.com
 (2603:10a6:6:24::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.162.16.71] (217.140.105.56) by
 PN2PR01CA0114.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:27::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 06:24:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8812807-6cde-4075-576f-08d8f8c4ae0f
X-MS-TrafficTypeDiagnostic: DB7PR08MB3339:|VE1PR08MB4750:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB4750530C4B7C100B664CCD0A89769@VE1PR08MB4750.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: civFlU/UEJg+51rIMYLYhlT2OEI5wZdqb0gEPVav1fJH6FA3tVxyc3+2AtjLalgza42p/41Hyf5hRLqEsYRx05Zv9rw0anwM81cDVGh23jNqYZO5Z3fjp/5GUyjeCb/dVpDl+xIk2o9HrBgOM0ohmEeJn6g/YXqx42ulOevaMRi9M5Th33qmUD5h8DR41u2EIeX0OwWvplGjdwN5SHTt85MMCOvep6/jtEolqUYBO270tbm3ibRdtqZlJ6MZsInpo9gQ953+8KxGZjm1c2HK2ZdssGejQN+XhKPS2rkJMUFqIQ1LUyWklod+ju2ksqtaYNC0TW70QixcWR31hRmz94/S2FEyk67pn8UgLZ96sJ/0lp5dC/2YyBLqo63fOzwZ6u4FvgyBB4UO4Yb37O/wAEZDiHCAB4bmK6R62MoOY33nSqloekFvFblyKCG1dgMFvMcETdkjohzkxgv9mb3lGsjEJCT7AUHqlgDyUQ/EC2ffsP6QTcuz+cV8vuB7FdsGvtIoB5T8NBFwIDGcD8GFDtTP9XYROzPWX9/SDQN9SZ/8ZT2ucb4dC8qNyaEiC8uCVZa4SDoi85Ea7YnZWy2WF2dM0sqeyT4KOCg8t0QtTbFwh86IWYeZcklXfHhN7JJjqh6gyJ8rclO7iShkReDXUpo48R54lTfJFc2cyLHwAXWEjIyaSweHcw5+LSEdYGZz1lhrzEuMmq4RyzTJjdeVx3PqvBFndygna1vtFr0zAQGWxMbOBAOd6P/wxem8Uc53dJxzIhqX2Yqum+pj7FASpzYZMyM5S3Gg5SNTOY7oLtgxbxbrs6T2Oi2HH645uMOjlu1F/MFhm8HYJ1im22qcgw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB6PR08MB2645.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(8936002)(31686004)(86362001)(956004)(2616005)(83380400001)(66556008)(5660300002)(966005)(478600001)(4326008)(38350700001)(66946007)(53546011)(186003)(6666004)(38100700001)(26005)(16526019)(31696002)(52116002)(8676002)(2906002)(316002)(7416002)(16576012)(66476007)(36756003)(6486002)(6916009)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cGZwSmVUTzBxcDRWeWRxemFzSnBVRXZHQ1c2ejE2WU16OVpLZXdwTEt1aDgv?=
 =?utf-8?B?c2FaUVdEd2NNVnMwOU9HWmhWK0JBcjhQZU1SQUtGemptNCs5K3AxZ2tCT3V5?=
 =?utf-8?B?Nkhhb0lWeGtkVkw0V2dTSU9FTW13eHZBSWJENk5rT3FNWWsyUFNCcW5QZGlI?=
 =?utf-8?B?NXZiUFhrRnEwampCbjJLaGR3V3k3OGI3V1Zib0xnVXFKeWF0d1dzeG0ya1Jp?=
 =?utf-8?B?cE02MU0rVlRiYm1Nb2F4aW9oZ3Q3cHM4eDFKSElFMk5PODNvSWlOU1E3Y1lU?=
 =?utf-8?B?ek5lMEpnTmZ1ejJxZk5oVnhoYXNiODNlL3R0WkpRYTJHdmkzWlRsc0xlVUZX?=
 =?utf-8?B?SkJpY3BXWjRYTWNMWk1KMzdGMDUzZ1A1a2pXMFpMNnhWNlhjUVExVVBTWExU?=
 =?utf-8?B?d2JDTFFjQm1VYkdiM2xtaTVtWnlnUkhBVzI3UERyVnlBQ25HVW9ZTGdDSjlk?=
 =?utf-8?B?alA3K3l1dEdqZkVQdWZqQVVpTzU4OC9IN3NKY25XSnQ2MHpuRDc1WlAzWCtP?=
 =?utf-8?B?cGhBT2QxdS82ZmdRNCtzRVFUcFgzamxrTzRQTEVFbTU0dmdEaDkyVGxhekNN?=
 =?utf-8?B?WlJwQ0N4YmJjODBpempWcnFxSjFzTVpKSllYOUtFd3VlUjNhWVZXc3BnRGZC?=
 =?utf-8?B?eGRHMjExUmdJQTRtdFhaZHZsRHIyQ0hFc2IveENCUmcyaTBzVEE5RTJnUWZ4?=
 =?utf-8?B?R3IySjErdStLVXlZT0VJUTY2T2ZUYzFlRjFOdTdDQUxCaVNVMUhEMDNKR2w3?=
 =?utf-8?B?U0ErMEVScCs1R1JSTlZqbXRMWGYxTHlqNkxNa3RoVGNxbS81UEp3ZC9xVEtY?=
 =?utf-8?B?dGRLZHBQcURXRWZjSmV1VkM4N055V3FsdWQwZENwdDIyd1BkbkNBb2lMUVVl?=
 =?utf-8?B?T2I2UnFGdkpYYWdQeDB6ajQ0a3pveEw1VTFETmNIR054L2FhS3ZzdlUyY3ox?=
 =?utf-8?B?cTh3WTJXSU0vZXhzQml3UjZMWFlFMHFCUzVQWElqODh3LzlLci9qY0Y1dVcw?=
 =?utf-8?B?V2w1anlWLytnVmZvbGhjRHgzRDFHZnAxWGovR3d3Ym1UWCthS2tMTmxjQW51?=
 =?utf-8?B?b2Z0WGpuazhucEFPYWRrSndURGl5V0hSMG5WV214dEZuR1ZheHU5aU5xRTU3?=
 =?utf-8?B?RHJycHVtTnNEREtnVEhhZDU3WEhiQ0dHbm5nWG5PS29KMHJIVCt1Z05KODAv?=
 =?utf-8?B?VzVLL1dNRW11UUdVUXNqd3ZRR055NVlmK0dPbjNIZVNGNzlHWllFeG9WRkV4?=
 =?utf-8?B?cU5JUitmK3YrNjc1NHZjeGUrdCs4Yk9MeWZlaW9hZ2FQZysvd1I5U1FFeDFa?=
 =?utf-8?B?N0lkV0JiZnRKb04wNjZFbjdrSmxNV25qSit6YnR5RXJraHQ5REdzSUpnRUg3?=
 =?utf-8?B?MFNoU3BvekZQY0lha2M3czE0U3o5ZjY3ZmlMZmJpNGJEb3h2TVhLYmQyQXlM?=
 =?utf-8?B?SDBaREI3b3VHYjVHTFJFdWRKSnFGZjFTalllM3oyZkJoQVFKTmZkQjJzZWJQ?=
 =?utf-8?B?UmV2d0xZSTU1cHRqaXNrTlhFTDUwc09ic2pqdzlaaUFKUW9xQnNyb1RwcE53?=
 =?utf-8?B?aStrb2FZNWVCQTgxYWJuUGlnc2NCQWpmR0lHcmtmcExHOGxTZmtub3NMbmZn?=
 =?utf-8?B?MmlWVThuR1c5RHQySmxjYTgraXRJenVYRlJacnVJQ0lTeW1yZnR4UTBiWnpl?=
 =?utf-8?B?K0xDaml3YkJlWFVnaEVJVXNyblc5T3EvVWNnYWtjZGJFWjdtMG9uOGt3d0FM?=
 =?utf-8?Q?xJQ4wyC4kn8xyKn3s5p2a+GuvZjA+9id5l0CsyR?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3339
Original-Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: babf0510-8ae3-47b5-9ed5-08d8f8c4a609
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rzdfIRkZT8cGGlgfIqiXqs6+WXUmVDXAK6TnitPkdsx3IXIIwOcHPrvZlezrNZvi1hms09AJ2BM78O7en/w292Jv6658V51tcS0WfcnOOoILds3xt4zHOeOvJwOdZkyZu62HIBKR2tBr29x44C/AfVEOd7haUa0i9OyRpw4A2+GfOA3zWFXzbxNfQhJ/dyvTX4EPyLyPAIZ5Y/7GtXSkLFXVgKhocn2L89q1Dshc//zM581gh8C4MHW7q5pH9ukJwkjDGDceH6o+v9+NP6slSporMPG6SiDpuc2XE4GXznejcxworyzhy+Rpr7S/zGn1vmk/YQ07IyWbH4qXE2WS9Spm9gjjU+Vy7zLgsUXf/HzkPHcNlg2MD3SrVsRIbwxQYu43UY4KSPaUj1fGiKj/OLt1Xh1PLZK8Ggatx46BsQAwSUsWRBGl4Mz9lMFxWE8NYTU5UX6sMYKaT1/PXjQv1n7e+DSiEHPXenSmExwQU45WdVZEhd81fjq8occ5J+DXr2p0t5UxqmymXcb3BSVenRMxijoWagKRk+T8Z3mPNdnmJ0T+EMns6ODdWuN84ueJnBc41GMnrB1esvPxQ5u8aQNBv93RV+ZeDINfYewLwr3OzRQPUZFzWKx/7yiWLjKDeFdQApgDGO0Kqf+6KYRvY7WasKtm1t7RpGgOxCoxvm4gz036H+iGUp2kSlQBs0eFKJ+fR9Mu6xc+3RD+y5hSngheLOdmabzRqLTccDFgBG2EXAsbpUG5BYOjHL9CREb6YpQXFXJavOC8qLCjobXKHw==
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(36840700001)(46966006)(6486002)(36860700001)(316002)(966005)(82740400003)(336012)(47076005)(86362001)(31696002)(16576012)(16526019)(8936002)(478600001)(83380400001)(8676002)(5660300002)(956004)(6862004)(6666004)(356005)(70586007)(36756003)(81166007)(4326008)(450100002)(53546011)(186003)(31686004)(70206006)(2616005)(82310400003)(107886003)(2906002)(26005)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 06:24:49.0354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8812807-6cde-4075-576f-08d8f8c4ae0f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4750
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



On 3/29/21 9:53 PM, Jean-Philippe Brucker wrote:
> On Fri, Mar 12, 2021 at 06:39:05PM +0530, Vivek Kumar Gautam wrote:
>> To complete the page request we would also need to send the response back to
>> the host from virtio backend when handling page request. So the virtio
>> command should also be accompanied with a vfio api to send the page request
>> response back to the host. Isn't it?
>> This is where the host smmuv3 can send PRI_RESP command to the device to
>> complete the page fault.
> 
> It looks like Eric already has this in the VFIO series:
> https://lore.kernel.org/linux-iommu/20210223210625.604517-14-eric.auger@redhat.com/

Right, I have taken this change to work on getting the vSVA with 
virtio-iommu.
For this I am adding a new request for virtio-iomm - 
VIRTIO_IOMMU_T_PAGE_RESP, and related struct virtio_iommu_req_page_resp 
that would contain information such as, pasid, grpid, response_code, 
flags, and endpoint. This is inline with struct iommu_page_response.
I will post out the patches for this soon.

Thanks & regards
Vivek

> 
> Thanks,
> Jean
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
