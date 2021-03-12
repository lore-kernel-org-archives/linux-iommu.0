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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC2DC433DB
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 12:32:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E2E64F6C
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 12:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E2E64F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 92E5A43271;
	Fri, 12 Mar 2021 12:32:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 19GdVaiuXdA6; Fri, 12 Mar 2021 12:32:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4609E43269;
	Fri, 12 Mar 2021 12:32:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F507C000B;
	Fri, 12 Mar 2021 12:32:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68238C0001;
 Fri, 12 Mar 2021 12:32:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4DA3384557;
 Fri, 12 Mar 2021 12:32:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com
 header.b="i9M8F6Z0"; dkim=pass (1024-bit key)
 header.d=armh.onmicrosoft.com header.b="i9M8F6Z0"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7NcB4iy91Dss; Fri, 12 Mar 2021 12:32:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20042.outbound.protection.outlook.com [40.107.2.42])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AC1F084543;
 Fri, 12 Mar 2021 12:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXcmaIpHqTYnp4M6RtMIZ8y0yWOskuo5zjjFO0WTFFg=;
 b=i9M8F6Z0kcB5cHbVsaInmpSjQozjkuVeT+AzbiF3j63umkBWToMNY4W1rXU4En5Sf+t4K+C0fgJNTDqynpeSQ5lItTLdQx2J+oAPylLpLxXd1/CVCw+uZZaCCXbu7Cf8hKmUnGrnL71TWHV+YUnx/WB5HYBP5YtCN1Ws2mwYW7c=
Received: from AM5PR0101CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::39) by PA4PR08MB5950.eurprd08.prod.outlook.com
 (2603:10a6:102:e0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 12 Mar
 2021 12:31:57 +0000
Received: from AM5EUR03FT039.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:16:cafe::dc) by AM5PR0101CA0026.outlook.office365.com
 (2603:10a6:206:16::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 12 Mar 2021 12:31:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.linux-foundation.org; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.linux-foundation.org;
 dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT039.mail.protection.outlook.com (10.152.17.185) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 12:31:56 +0000
Received: ("Tessian outbound 57597fd826fb:v71");
 Fri, 12 Mar 2021 12:31:55 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ff58077003184085
X-CR-MTA-TID: 64aa7808
Received: from fc7bb07e11a8.3
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 3FE52631-A575-4662-9524-5F0977D0D59E.1; 
 Fri, 12 Mar 2021 12:31:50 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fc7bb07e11a8.3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Fri, 12 Mar 2021 12:31:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8JSD+pgjldybjrZPezgm0eoAxadyRA6O4Zculqm5LbBv7rsdbqYFaW49U//He/5NoRIVtu5g+8DIOhoAXDvKcH0MpVuZlXjRMsZnxi2P9RF6DedYGb2gJz8+nS6JQbA6QBOIDcgFD3itXTVGP/ohqZMYg4GCIH6m+hUagMP2GAaOHvvLMtnyEd23F0MEEFTji/9CBkjE+laHCcRx2LUbMO33L0FVJLzfm3UwkpBuzHMvQDhgDiv+F0WVxc6M4bpOpTJH/oP4jSOiMBh5Fl43Q8iYC7N/Fd65e5OdwfzoPqNI3kWNpQXDoOf1SfAM4sS06kA5OsCD2FOH55z7b0TPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXcmaIpHqTYnp4M6RtMIZ8y0yWOskuo5zjjFO0WTFFg=;
 b=MizLEkaJZduoZmgpMiLkCIdKZyaIWyhxAehVCAXWeIgtJLtDgF8Ujy7vsG829Zr0tpeiuXqIRlHbN/JEQLXeX7XuHlNaQ7rKlXf+APILZhF0ZzHxhghh1lpKo8wSPZCZTWUBkmN7lri2CNgZ5cJYg43QhfHnUkGDSJ0ODbpRuHPXHShObUc8N9uqNXAx/7KGJNVkrU0xmgHTMmXJj2YeNEcxNNGBiiyd5fsMmEuHXR3+AOdyEzvPIvGlrK1hfhvXCv3o0eULr9/R6EVNxWrMXK924zbCDiO/QTdqw08aR+EfNPdB+QcuVvmM+BcnvIiMYcTyqmG0Z0p74fs3tueyLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXcmaIpHqTYnp4M6RtMIZ8y0yWOskuo5zjjFO0WTFFg=;
 b=i9M8F6Z0kcB5cHbVsaInmpSjQozjkuVeT+AzbiF3j63umkBWToMNY4W1rXU4En5Sf+t4K+C0fgJNTDqynpeSQ5lItTLdQx2J+oAPylLpLxXd1/CVCw+uZZaCCXbu7Cf8hKmUnGrnL71TWHV+YUnx/WB5HYBP5YtCN1Ws2mwYW7c=
Authentication-Results-Original: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com (2603:10a6:208:65::26)
 by AM0PR08MB3075.eurprd08.prod.outlook.com (2603:10a6:208:5a::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Fri, 12 Mar
 2021 12:31:38 +0000
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685]) by AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685%6]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 12:31:37 +0000
Subject: Re: [PATCH RFC v1 04/15] iommu/arm-smmu-v3: Update CD base address
 info for user-space
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-5-vivek.gautam@arm.com> <YD/D9HJxH9L503an@myrica>
From: Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <51280327-e1a1-f3fc-a2dd-2d3bd740aa9f@arm.com>
Date: Fri, 12 Mar 2021 18:01:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YD/D9HJxH9L503an@myrica>
Content-Language: en-US
X-Originating-IP: [217.140.105.56]
X-ClientProxiedBy: PN1PR0101CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::22) To AM0PR08MB3268.eurprd08.prod.outlook.com
 (2603:10a6:208:65::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.162.16.71] (217.140.105.56) by
 PN1PR0101CA0036.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 12 Mar 2021 12:31:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 32872f30-6135-46c8-dcf5-08d8e552d306
X-MS-TrafficTypeDiagnostic: AM0PR08MB3075:|PA4PR08MB5950:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PA4PR08MB59500ACF0FA4FA037B6036A1896F9@PA4PR08MB5950.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: SokZYv1GmHpjfdptX7Mf6Vspmb5wBdJ6f5rWJ2eX2joakNfCIiFD2XizyNmGp3F8Hq+imFbQM/FdncyEpa5deymJVtZ/8BZJNr68DJFKQc/GdMsapgtCVEWQ2N43ET6lP5UYXXNnntE7TZZ7X5UqkDrPA/ktYMRs8oX4hVbqgMPiu2Z2bE6A709xKvRxEgPaeQb+FlSdWQGm5RO7MJmgridRcri85vLtFLIUuS0YrjVnT+l1vwMpLflkLA+AFdwR5yXnZ31yEhJrJstVq95ZFRRCZRu5jfW2P7LM/SzYESfAFtj+v6VYmFbUS0P0Qhhtrmx8QTkFFmp5iGyrHmZnNfdbjLlRsn1t5e26EuQClO//cdCDp7gaN1/8fGbTqsTIjxqgGKi6cB/elAawzqAJueG1pLWj/kwPj3H7DJdLf5ONqVMRciwRAvtCFD6vN2I2q08bYy4m5FzIWwO+0U672uCKoQIxVXOWkwuPXKJgQ6Qoi0dTT3dWP0tnAGWI2eZW8n6uBRXPLkqpm6KbrLgYcmWMUN7aWNYyd60DlbqjciEpzlB+cy4qHJbLFCthflbHT61OX+ey+StXnsGwQytTizEZbs+E45hVWTnLMD7kYZzT6f6T5TjJtVKYOKEoCi26tsoy8CqjmDg9ACLS/S3b9g/aVcwlZcKtgUh1lwN2kOY=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB3268.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(316002)(52116002)(83380400001)(8676002)(36756003)(86362001)(6916009)(8936002)(2616005)(5660300002)(478600001)(16526019)(26005)(4326008)(7416002)(6486002)(186003)(16576012)(53546011)(31686004)(31696002)(66556008)(66476007)(66946007)(6666004)(2906002)(15650500001)(956004)(43740500002)(45980500001)(414714003)(473944003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z25Wbk5OSWtZZ0phU1AzNDB5WUNFeFdjTGlsaGhEbEFWSEc1cFAyZTZMNHUr?=
 =?utf-8?B?UzN4d0ZFYmRyTDFYWjREVWo4RmU4Rm5YbEJvbHpYaWpmR1ZVc1lCdnI1WlJz?=
 =?utf-8?B?VDNicjQxekZ5Njk2UVFQK2RERDMzK3VZRndVN3d3RjBPc2o4UU9VZ1VzY2Rr?=
 =?utf-8?B?dnU5TnlHbm4wT3J3bmdiNERZNjVoQml3YjhkMW50KzEwUjZYaEM3bmRXdVJ4?=
 =?utf-8?B?R3pJV3lMa1p0UjBUVzdTakdRNlV6KzdML09wNDBzQ1FWMi9KcHI2eWVDd2sw?=
 =?utf-8?B?QVhINzB4TDBYTS9FYk9WQ09BOWdoRFdIQU5MTEQ1V2l3RUkxR3lBOWw1V0NX?=
 =?utf-8?B?eHpJV3NhMXhBQW0yS0psbzJXazNHQmttczFHbHNYQlNOZ1JmYlBRYS9saC91?=
 =?utf-8?B?U3pOUEF0K0ptd21UOEF3SStQanoxMTA0TjRxcEJLell4TlhpYnQ4QnBFQlBy?=
 =?utf-8?B?d2pCcDAzcmVKSy9xdFYrNWZ2S0FicjVpLzNMMHpuN1JDS1ArV3U4UWUrNEkz?=
 =?utf-8?B?RXNHczJJMVFwdHQ1VHZONEVsQU1OYWRFMlRRQ3h6czJwUnNaTTJVMS9mMnE5?=
 =?utf-8?B?cjc0RkUvNnE2Qm9vUVg3Uy9QS2FDYzJ0M2VBdlRZRHp6WFZ1dmc4RE5ZMjdh?=
 =?utf-8?B?ZU1icENEckRHVnZaZm1YT0txZllKREltKzNoK1c0NElNNndPcWFSRldOYVZ0?=
 =?utf-8?B?eEdvVmZJRFJrbHBRWjZvVzdRd3ZiaCtuK05TNDVPL0xDYnRzQ0d1UWZBeHVq?=
 =?utf-8?B?VFdjSytFSTdGNWRNM3U0UWhRNmZ3VWM3ZGRsUDV3TFkwZ3hTSW0vOXo3c1A2?=
 =?utf-8?B?YW9xWWN0cWErYkhGTWNqcVZTaUgxNVlTRWcyQzVYWGpCQkFVZHcybUpmL1Fs?=
 =?utf-8?B?YUhtQ1c3MkU2Y0M2WVRyWUh1K0d2NW9hUTh3d3VsdzJqSGZWeTJxNC9tajNJ?=
 =?utf-8?B?cFpyRWU3T0Y4bHVQSzlVMWNDTFBiRXdyQWhTNmRWT0NvRGZ0c3hmZEpXa3Zv?=
 =?utf-8?B?QWI5WjFBL0lqWWZhdmEyRGU4TjNKZUVabm50cFl2enZ0Rklnd0xmenJCLzNm?=
 =?utf-8?B?ZUUrK2Y4RFdLL3V5Z0wwTUtYS3VUUjUva2l5aHJsQ2pvaU1NWEVaN3NTNmJF?=
 =?utf-8?B?UmR0U0JJYTdqdUJJQjUyb0Rsc2dzem9ZcWVRclMwbnVwYWNuMjdtVTQ5Q2g5?=
 =?utf-8?B?ZGFWZ0xyVitEbVVqQ3kvTTQyd0UvT0I1bzhrUlhEVmNuUWJxeHdnTGhkNklO?=
 =?utf-8?B?ampFZ0hTWm9RSFRYMHhOVHdTeXptckVXY0ViQlhKUzEyZUJSQVUvbXFtU2ZV?=
 =?utf-8?B?T2xHR2k3Uk82NWZJajlMaTZ6ajFKamdVREEyUzY3dUgxajgyMFJsU1dmNnlp?=
 =?utf-8?B?S0JQMS9rYWlyak0wS3JNNE5ZRE84V1JVNVlLMUp2SlVFUVBRT0VMS2ZIVUlY?=
 =?utf-8?B?bTB4Y0g0VHFPYU93ekM3UHVJK00yQ0VYblNCVFFlOU5KeHR4bDc4VlIvUW9E?=
 =?utf-8?B?NXFZOWtHTjFKU0xLVmE1Q1F5ODRKQkl6TW9BYnVDNTNuQWlYdjBmSWxrZ1pR?=
 =?utf-8?B?eE5ES2lOSjNiOWdqRlBzeVBSQ3BEaXF4NGJFNmlIOGZnTnh2SExhcjdZT1lG?=
 =?utf-8?B?Z3Q4My9mL0tnbUl3TEcrd0tGenZqVHpzRFh6Snl1QVkyWXNxcnYvT214SUpx?=
 =?utf-8?B?cGhGN2s2ZWt0T0ZsREdqdGs2RmlzOFpqUjRFQS9sRmU2ZU1LbTFUVk1kMDFj?=
 =?utf-8?Q?Mm6DyuwpX8RV6iqpIKz/HJpN/i6Km9MFGeEaqeY?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3075
Original-Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT039.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3182366d-8c37-4b67-eae0-08d8e552c6dd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h8IKLIyLpNdgrBMPDFWFdYqWzzJ7dQGDJoGRhldv4029E8bE2hgNY/77TwYTnE3AvUpB6yo+Wl7n0P30UeL2y1L0fzgKfFTJKCcVdy1ZHMEBlRkRbdBJtwrxeHw21tcecLmuX9tVVX2Slk/HPWGYcDWc5jkc/3ohhCS2X0x+X6992uK7tICNHxPHeJDQqkxMb2uhspTsjyslp6JylDAdWdxi4GlRJmlmHkkmd3ZBuHqSeFFbMmqTiCzxPtp/D+CewewmIQAW8LpblG5/CnwTkYVizYH/+Uj00hGo2m66rCuEeNbCGRMLdVpQOaCnb62YmYYgfIoQyyroLlObevTN0HdNbDZGB1LHjNeWYrBuV1KE45E57zwGuvlLpfp2rc8kYKKVM1dTB/PXBC/lAGpu04C4yfJ1LaYnuFvfGUhQtwGJs4UJJOsfqVFKNSgZjzz36+rCL6VZ62ItHm1whITipVNjYGJ2Ikq9vIt7dOhF+AQyBvKPQ+VvhReu6tQLFvYKDimk5atQ7WtN7lIgH/p3UlH5G6PgCpcrruOY7w1HmtYTGyqYioFM5iIfS0ySs+60qIqH/O5JjWC8hCI4drZCyyPfli0ub4OfnqnPfwyOZGFe58rXs5wR+R0pcBlLi65l/fNqEkj/pVc8hdO1TSaV9v/9vO4FaGdVnySxcP77HEXtd5ShgrdwzIN0jC+uuAsqkuWQWpW1DmDUuJCLds6KddgSUwRxqagahvxnZTAPYKk=
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(36840700001)(46966006)(70586007)(356005)(5660300002)(47076005)(6666004)(16576012)(336012)(31696002)(8676002)(478600001)(86362001)(36860700001)(450100002)(6862004)(81166007)(31686004)(8936002)(4326008)(107886003)(316002)(82740400003)(15650500001)(83380400001)(70206006)(2616005)(36756003)(6486002)(16526019)(26005)(53546011)(2906002)(82310400003)(956004)(186003)(43740500002)(414714003)(473944003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 12:31:56.2766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32872f30-6135-46c8-dcf5-08d8e552d306
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT039.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5950
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

Hi Jean,

On 3/3/21 10:44 PM, Jean-Philippe Brucker wrote:
> On Fri, Jan 15, 2021 at 05:43:31PM +0530, Vivek Gautam wrote:
>> Update base address information in vendor pasid table info to pass that
>> to user-space for stage1 table management.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Will Deacon <will.deacon@arm.com>
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
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
>> index 8a7187534706..ec37476c8d09 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
>> @@ -55,6 +55,9 @@ static __le64 *arm_smmu_get_cd_ptr(struct iommu_vendor_psdtable_cfg *pst_cfg,
>>   		if (arm_smmu_alloc_cd_leaf_table(dev, l1_desc))
>>   			return NULL;
>>   
>> +		if (s1cfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
>> +			pst_cfg->base = l1_desc->l2ptr_dma;
>> +
> 
> This isn't the right place, because this path allocates second-level
> tables for two-level tables. I don't think we need pst_cfg->base at all,
> because for both linear and two-level tables, the base pointer is in
> cdcfg->cdtab_dma, which can be read directly.

Sure, will remove this.

> 
> Thanks,
> Jean
> 
>>   		l1ptr = cdcfg->cdtab + idx * CTXDESC_L1_DESC_DWORDS;
>>   		arm_smmu_write_cd_l1_desc(l1ptr, l1_desc);
>>   		/* An invalid L1CD can be cached */
>> @@ -211,6 +214,9 @@ static int arm_smmu_alloc_cd_tables(struct iommu_vendor_psdtable_cfg *pst_cfg)
>>   		goto err_free_l1;
>>   	}
>>   
>> +	if (s1cfg->s1fmt == STRTAB_STE_0_S1FMT_64K_L2)
>> +		pst_cfg->base = cdcfg->cdtab_dma;
>> +
>>   	return 0;
>>   
>>   err_free_l1:
>> -- 
>> 2.17.1
>>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
