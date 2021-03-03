Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B3EC433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 18:31:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 831E164ED4
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 18:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831E164ED4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37B6C6F992;
	Wed,  3 Mar 2021 18:31:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2dTDV9uv9PQO; Wed,  3 Mar 2021 18:31:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B984605AD;
	Wed,  3 Mar 2021 18:31:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6546C000B;
	Wed,  3 Mar 2021 18:31:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8A78C0001;
 Wed,  3 Mar 2021 18:31:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C9CDC83A59;
 Wed,  3 Mar 2021 18:31:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com
 header.b="AZuqGDu0"; dkim=pass (1024-bit key)
 header.d=armh.onmicrosoft.com header.b="AZuqGDu0"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QaqPI8oZ2tqt; Wed,  3 Mar 2021 18:31:34 +0000 (UTC)
X-Greylist: delayed 08:19:14 by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EEDAB83A4D;
 Wed,  3 Mar 2021 18:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrCVV5Y4m/oZrzfMcdebX4sKQ34TRWj91wPgcodTVF4=;
 b=AZuqGDu08PYti/ZnJPYieCpLI/0HeIBdvROQc4JbAwmEL9T3XKuK2xgNHGiB/uQXd9eoM4mLBBTvs1EjvmY8E1/bfjofi4huy4xM8ISZcyMwnF4lWLQm6sL3Hr45QBnRMp+ZVbHQUCzjhzrW5fK8PtDiAggf7OsR2NuP/1/rh04=
Received: from AS8PR04CA0119.eurprd04.prod.outlook.com (2603:10a6:20b:31e::34)
 by DB6PR0801MB1767.eurprd08.prod.outlook.com (2603:10a6:4:2e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 3 Mar
 2021 09:57:27 +0000
Received: from VE1EUR03FT018.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:31e:cafe::d1) by AS8PR04CA0119.outlook.office365.com
 (2603:10a6:20b:31e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Wed, 3 Mar 2021 09:57:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.linux-foundation.org; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.linux-foundation.org;
 dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT018.mail.protection.outlook.com (10.152.18.135) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19 via Frontend Transport; Wed, 3 Mar 2021 09:57:26 +0000
Received: ("Tessian outbound 9c515f919342:v71");
 Wed, 03 Mar 2021 09:57:26 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: db6c284ec824a095
X-CR-MTA-TID: 64aa7808
Received: from 4c71afc1869c.3
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 4639332F-DFE3-4254-BE93-BACA2B340DA5.1; 
 Wed, 03 Mar 2021 09:57:20 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4c71afc1869c.3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Wed, 03 Mar 2021 09:57:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cklIPq0kL/lFh/xdAjpoQ0cLoozV/WN/gTOhx6yVyqV1+0SQD5BI+G7TcUbzHkyp/4l2e50yIboZT/sDIHGdEcRLyaj/Y0a/7WruyQnBS5/fCjO4QBoXahK4C2vFNLJB8H1I2aNFil6sJE1NC34B8+MesjPdAAG2RZ44nVcL9OCHZr7TGLEbNQN7DlU9u5lM4CwdYcmHs2CGx3bv2+UfMlY1euu9RBiqpFr+wMT7/iI+C0mk0AffUCPbsBqp/Zt0GFyjue4RI1qulaGvCfro25fEgQa/w/jlctXp+EPHy0OixjXjSjSZHBhM4a9o4BWXwoZHT0KhpPIjksZ9Fhlq5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrCVV5Y4m/oZrzfMcdebX4sKQ34TRWj91wPgcodTVF4=;
 b=H/qN7TrraulUZPBOWydTAE4Qe6J7YFOiFCR2arSKn/JUbMWhs/eZRIuKnCffvGnPvCMf1+RAlWD0SiwvhQw+VfjBXc1IAZKLKcE5vy7biDrn/E6KuSeDPiHG1lbqnK4uZLdCPUK93MSnv9Jb7ibnYpTB3s5tPWuFpqgxgCjfDsbdcOS1vqSX4xYRP4KVFgsH2bjSGdXfcqIfTZRs1EhLg4NixKoOjz3JRdW4GQDo1mTDxqwWFmn93N85pZCJU1kwJrmpKrtgNlAV44rLBnIxO5oTpfVGhHw6VL0zyLMEVVze/Oda5iNsF082kxmoMHWGanRWdRYns+mz1++ILRw21w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrCVV5Y4m/oZrzfMcdebX4sKQ34TRWj91wPgcodTVF4=;
 b=AZuqGDu08PYti/ZnJPYieCpLI/0HeIBdvROQc4JbAwmEL9T3XKuK2xgNHGiB/uQXd9eoM4mLBBTvs1EjvmY8E1/bfjofi4huy4xM8ISZcyMwnF4lWLQm6sL3Hr45QBnRMp+ZVbHQUCzjhzrW5fK8PtDiAggf7OsR2NuP/1/rh04=
Authentication-Results-Original: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com (2603:10a6:208:65::26)
 by AM8PR08MB6481.eurprd08.prod.outlook.com (2603:10a6:20b:364::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 09:57:18 +0000
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685]) by AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685%6]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 09:57:18 +0000
Subject: Re: [PATCH 2/2] iommu: arm-smmu-v3: Report domain nesting info
 reuqired for stage1
To: Auger Eric <eric.auger@redhat.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org
References: <20210212105859.8445-1-vivek.gautam@arm.com>
 <20210212105859.8445-3-vivek.gautam@arm.com>
 <0708b0b2-78f7-e55c-21a7-3c49eb5141df@redhat.com>
From: Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <2050ee9b-527c-f8c6-445a-4786d144496a@arm.com>
Date: Wed, 3 Mar 2021 15:27:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <0708b0b2-78f7-e55c-21a7-3c49eb5141df@redhat.com>
Content-Language: en-US
X-Originating-IP: [217.140.105.56]
X-ClientProxiedBy: PN2PR01CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::15) To AM0PR08MB3268.eurprd08.prod.outlook.com
 (2603:10a6:208:65::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.162.16.71] (217.140.105.56) by
 PN2PR01CA0070.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:23::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 09:57:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b691b5d8-6a3f-41a0-2ae7-08d8de2ac053
X-MS-TrafficTypeDiagnostic: AM8PR08MB6481:|DB6PR0801MB1767:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1767B057F474060E3DB463FB89989@DB6PR0801MB1767.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:747;OLM:747;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: NOQW77ov/uSefPO4uf/CNKVo93eoTAyh0qPZWSW9Ws/2UfX6NiCnx5q5HFeyzQ0WTY5FUH2Bq8V7BLRSFSssv7pNyCz5deOs4tudl1EHlSSDAub/y6oRto1yQSJchjK6Lnjjl+5qvbeIZwrh+qlvcu3KP4ym8Yf2Sw6Go7q2Lcqq6xEk8T1CMmInGRhudXCaR0lg78TsePSHnisRIatJm9t+nrwiKQcM8KaEgXr6Tx5hvB0bDQKyhhgow1A1HcjR08z/dasAlCukSbRZY3eomy53cI83ax13+4wzX9uLWGUKt/seH87fL1NAzFy5PQvspVjaeONeiJb03tCddM7PdmjLVb7Y777UAc1Aya1Gr1upula6aUuAgaCCqOIrno1Ntpo4W+Pldy/u7Y3RZTaZgbHTGobf8zgS8y9aYDe1UgsT7vo4ig/8X85yvizh9qrmJOg3/PnlBgyXdmPELOfKCX0Y3Ri3441VUnVNhl1Ri0tflF28ChPGrkWXBdBGj2ZxHEftHg37LSQ+wOV+aw6nWY6UF6sZdaBhLTyCeVqn8N1vTmY55kKTDkQksI2Re5cZhPIipgKa3WxDtPR1wfnkqIsLer5LtsKYuAdmLjFfvvA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB3268.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(52116002)(956004)(8936002)(2616005)(8676002)(478600001)(7416002)(31696002)(6486002)(186003)(5660300002)(26005)(16576012)(6666004)(316002)(31686004)(53546011)(66476007)(16526019)(4326008)(66946007)(86362001)(2906002)(83380400001)(36756003)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RGo0MkNsUjlZOGhwV1k4TmJtamZNVzZzNmc5eG5PaUhIQ0pIWGdVRWhtWHQx?=
 =?utf-8?B?RTcyVzQ1QkxlK216VldWTGdXUUpYcUJ2NnJTZVlXUDhrZXU1Qi9qY2R2Nm1G?=
 =?utf-8?B?SW11WlFhK2lzdllMUUdsR0Y0cm5GTHFaLzdtNWtHTG5iay9lTkJ6MnE5ajJw?=
 =?utf-8?B?ZmZ3dzBvQ3gzd3pMUW1oSGFOTVlxMi81akVscHdsZFpBcnhSK0ZwdWcxdEJC?=
 =?utf-8?B?NFRDSlU1Tnhtb0kyUklTMDdlNDRJVGNPMG9TK0dDOFphMDRiQ2g3YmsrRUZ5?=
 =?utf-8?B?ejRTNkd0cC8wUjdac3c5UU10elJ4d05XeUJNQTczZmtTYWFDNE02cmtyYm1z?=
 =?utf-8?B?SDl2YjU4NlQ5WGk2Z044SytBYnB4MStENDdNK0ZrNGRqNitGa05Sb2k0WFZE?=
 =?utf-8?B?R3U4VEEvNzl6YmtzQU1zWFF2MktCR05kWnhPNDJub3VhMm1oNnBzNzNRWUFr?=
 =?utf-8?B?bVVPb0NFT1cyMzliUEN2ODUya0hnN2xwK2hncmh5LzdNY01FVFp0VG9wSGlR?=
 =?utf-8?B?ZllVMzROSS9Da0M0STB6cE80TTlwM0g0NWdlb05GMmdJcmQrSk9TVHpwbGky?=
 =?utf-8?B?YnpaOFBTSEs2OXVQTU8yRHJ6Sm5YbFNFL0dtZ1gycUFPYmpkZ2tUcGxnK3JM?=
 =?utf-8?B?bENYVVBySlI0VVB1Ui9XQlIrcG5nVndmYThpNU1NL2hjU2hieUNyMzliNWJq?=
 =?utf-8?B?KzdkcWMxaWVrZ0MxZ2Q0Z2oyVVpPc3Q3dWxHQXdvZFZWbDdwQWlGVXB4VjNk?=
 =?utf-8?B?NUZCSXQySXUxSWluSk51NjdoNmhLNlVCMExDeVVmMERadXJ4WjBMak8rUTRz?=
 =?utf-8?B?TU1GTkJCWHRPL3BIbkc5OFYwM1MzZVJtdzJkYVdQTEVPUThsS1pyZXVYQVJR?=
 =?utf-8?B?eVNYQjlKaWJwUmZqdXpzdHdmejlqbHpCRVhRNFI4Q3NDbFlPNm1USmZZeTNG?=
 =?utf-8?B?Y08vR2djcXlDZXhYekxWNGpBaFBLa0RRMW44TnErZUtMN3JkZmFPYWNQT3U1?=
 =?utf-8?B?U25JVUo4cVFKVEFjK1RSVkhnNUgyWktxL3RGWXlPMFNGT3ZtZGlJL0h0T0lk?=
 =?utf-8?B?aWU1RWg3b3E5eVg2UTFaeDl2eWJ3VGowMnloOURHZG93VjZ3SEZHMDM0cGVC?=
 =?utf-8?B?Y2RpQ0lEc3k4NTJuVWFPV2V6ME40YVM3dUdBNXF5VmdGMGpGbGI3eVBTQUFM?=
 =?utf-8?B?WC9VS2pWb05DSDV6Wm5jWXZ3QVZhZ1ZuaVNzY3ZsQzVta2ZJTGpPdW9qRWlh?=
 =?utf-8?B?TlBtcWlCTk8zT0drd0dSN1RUb2dBdzRRVXpZM1FBdnk1c3RzQ3FUQ1o2aTIz?=
 =?utf-8?B?RGI1eklKYmVrYjFHQ05ITXpPWGI1ZUNLQXlwNDNTZHVrUUxPbXlDeDc5ZFU3?=
 =?utf-8?B?ZHlOTjg5TXIvNHRmd2Q5bW9UT3VaeG1ORDVDWkF5ZmFGTUJuMWQyUlgrRGhT?=
 =?utf-8?B?QnZMWmZ5WUlIS0ZKVkd5RDN0dmxiaGtGZ080dTkxYXpUdG03MjhLT0pOdXVl?=
 =?utf-8?B?b3lvazNrYjFCRGRuZmhYS3BPaGJxZThTSXlPSm1JMS9INWdPaE5hOSsxS2Rx?=
 =?utf-8?B?UlhucTczN2xjRDNTYVZJTzdnV05MQkxlUlZ4NGNWeDdPZFkzVHAwQ0xrbllt?=
 =?utf-8?B?Nko1WjRxS2ZkV3A2SnUvcndVaXJTN2Fqd0RJbFdqaU5EV0Y4TkF0ZGcxNW5u?=
 =?utf-8?B?U3pYaGpJTkpnNTZDTS82b0FmZnZ5MVdrVFhwZzZWNlFLbndJWGlPNWY3cWE4?=
 =?utf-8?Q?yrVV3p27oBYGfZ0NU8l8+E/P4v2MET1L87MRdOE?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6481
Original-Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8d34a82e-2942-41ad-1401-08d8de2ababb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Al5q/9FoW6ztZz+3OAu0UB1m7X8EkFrDfAaA2r8cR9E7aRrdocqx8YBFfKEC71YT6Z9nqwJiWJyvTFGWlV1qUuerdusf2z5ApXpbD2yin2s4nax4OaVKMFIOz4fvL7Miy9PBSShozeyAe1a+jNwh6BJtzHaQwSASrJOHp3KLYgY7ON5JQuzyXtsCQgVPvKMUsidvvRyYUcrJQfJ3AmbtAOpIujp6vEk1gsOwMx1mD/EzIvMRTm9vJsfZpv6vl4qvSoNV2PWBHOIVjYE7RWLmfaNmZDEIqIm4eqFzEEVfRFbU/9xHk8+K3QHG2VD6a0lKHixQiDMoRYeELvKf6ctLdVaFnyBVyK7SDdlSG2qeuU30d2k6MlR8toPbeOvpcEpSTKcCK9EvUQmQfUOGXe2ZKMx7QrvVk261jyx9biXUEgRPNYnW3RiiwDQFBA9Ov4sX4OgosVbaWepfztpTsKNInWn1U6481/80swqA19ADbSBuKEpVfEpAH+RoZPD48/zcxu4mZRqp2Ry6gArXxOBUVJoHvPejSdwq5nVP2Hl0yVZ7ycPHmyvo6bXnXikOntCcdrxMFaU04RIVggA/f9Crx9fOiMcY0b4oTwYVUwiyStPGZBB/s9S7L67lA81s0+qe7gGwBLnExZj0lsOwXJOu/YVeEnN0zTa1RBvDeqqQKCfQcrW3D8xNa1PzdMpVc8WB
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(46966006)(36840700001)(16576012)(450100002)(478600001)(53546011)(6486002)(47076005)(81166007)(2906002)(70586007)(316002)(4326008)(356005)(107886003)(31686004)(86362001)(31696002)(70206006)(2616005)(36756003)(82310400003)(186003)(336012)(8676002)(16526019)(8936002)(6666004)(82740400003)(5660300002)(36860700001)(26005)(956004)(83380400001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 09:57:26.7864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b691b5d8-6a3f-41a0-2ae7-08d8de2ac053
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1767
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 will.deacon@arm.com, alex.williamson@redhat.com, robin.murphy@arm.com
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


On 2/12/21 11:43 PM, Auger Eric wrote:
> Hi Vivek,
> 
> On 2/12/21 11:58 AM, Vivek Gautam wrote:
>> Update nested domain information required for stage1 page table.
> 
> s/reuqired/required in the commit title

My bad! Will correct it.

>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index c11dd3940583..728018921fae 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -2555,6 +2555,7 @@ static int arm_smmu_domain_nesting_info(struct arm_smmu_domain *smmu_domain,
>>   					void *data)
>>   {
>>   	struct iommu_nesting_info *info = (struct iommu_nesting_info *)data;
>> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
>>   	unsigned int size;
>>   
>>   	if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
>> @@ -2571,9 +2572,20 @@ static int arm_smmu_domain_nesting_info(struct arm_smmu_domain *smmu_domain,
>>   		return 0;
>>   	}
>>   
>> -	/* report an empty iommu_nesting_info for now */
>> -	memset(info, 0x0, size);
>> +	/* Update the nesting info as required for stage1 page tables */
>> +	info->addr_width = smmu->ias;
>> +	info->format = IOMMU_PASID_FORMAT_ARM_SMMU_V3;
>> +	info->features = IOMMU_NESTING_FEAT_BIND_PGTBL |
> I understood IOMMU_NESTING_FEAT_BIND_PGTBL advertises the requirement to
> bind tables per PASID, ie. passing iommu_gpasid_bind_data.
> In ARM case I guess you plan to use attach/detach_pasid_table API with
> iommu_pasid_table_config struct. So I understood we should add a new
> feature here.

Right, the idea is to let vfio know that we support pasid table binding, and
  I thought we could use the same flag. But clearly that's not the case.
  I will add a new feature.

>> +			 IOMMU_NESTING_FEAT_PAGE_RESP |
>> +			 IOMMU_NESTING_FEAT_CACHE_INVLD;
>> +	info->pasid_bits = smmu->ssid_bits;
>> +	info->vendor.smmuv3.asid_bits = smmu->asid_bits;
>> +	info->vendor.smmuv3.pgtbl_fmt = ARM_64_LPAE_S1;
>> +	memset(&info->padding, 0x0, 12);
>> +	memset(&info->vendor.smmuv3.padding, 0x0, 9);
>> +
>>   	info->argsz = size;
>> +
> spurious new line

Sure, will correct this.

>>   	return 0;
>>   }
>>   
>>
> 

Thanks
Vivek
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
