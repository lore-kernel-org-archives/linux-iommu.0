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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19CAC433E0
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 12:57:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A92864E21
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 12:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A92864E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 113B54ED3C;
	Fri, 12 Mar 2021 12:57:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XF1ci0tbxnpw; Fri, 12 Mar 2021 12:57:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9726C4ED2C;
	Fri, 12 Mar 2021 12:57:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57016C000B;
	Fri, 12 Mar 2021 12:57:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF9BCC0001;
 Fri, 12 Mar 2021 12:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CD98F4ED3C;
 Fri, 12 Mar 2021 12:57:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lkk66v6F0D6A; Fri, 12 Mar 2021 12:57:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80073.outbound.protection.outlook.com [40.107.8.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 55CCF4ED2C;
 Fri, 12 Mar 2021 12:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEBOozT9D8Lw2SL0A/GVO3ZCqfukBVgJwvItoNA0TnI=;
 b=67IVoF3o37UyDOYlX7KidyB17jB0Fes98HVRHixXeFN88qmZi5Tw2ZAgNtR3RNzLmaMGSJ8b2KHr5plzLnJ2dAsp52k5egtShBHVcv0nf+Kx2UI1DjRHJG29N/Nc1Zb5bkgpuTIm5sho4iSNK57uuC6oGR6+yk3IyLMFYGFDEyE=
Received: from AM6P194CA0029.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::42)
 by VI1PR0802MB2144.eurprd08.prod.outlook.com (2603:10a6:800:a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 12 Mar
 2021 12:57:42 +0000
Received: from AM5EUR03FT016.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:90:cafe::a1) by AM6P194CA0029.outlook.office365.com
 (2603:10a6:209:90::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 12 Mar 2021 12:57:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.linux-foundation.org; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.linux-foundation.org;
 dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT016.mail.protection.outlook.com (10.152.16.142) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31 via Frontend Transport; Fri, 12 Mar 2021 12:57:40 +0000
Received: ("Tessian outbound 67e186bef91c:v71");
 Fri, 12 Mar 2021 12:57:39 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 83cde20c6e9dae1d
X-CR-MTA-TID: 64aa7808
Received: from 19c0e8a0316b.3
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 49FE4716-C237-4233-BA33-B817CF759387.1; 
 Fri, 12 Mar 2021 12:57:28 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 19c0e8a0316b.3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Fri, 12 Mar 2021 12:57:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIXYgVWftb9yU5hUd7QA+7kOAOuvKr707tn79IE0Jvs9SPxIGz9iniH2O5YAx1ly7N9ZMyBJEkMrEb3Wkeb2Nne5DfLj5018NNfKvBksBYTwR6dH39BEktj55v0ObXJks20D60X9Dyy/nhOz33bH9jDZWkIn/cmB/IW4bx8u1Pn+3mNWNZu8RvOxb6G6+d6uPBLUeeDu3wvuw408lF2zi6edUKCyHF0B+LN93LxhwqlnShCcesmcuh0i/dtFhz4N5WblXrwmHquzog96J6b/NrzgXuiyj+1xreL2TO68cOl5z62OvwLA1j96NSEQGb4xZNWRXVoISyTslmY5kkRAlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEBOozT9D8Lw2SL0A/GVO3ZCqfukBVgJwvItoNA0TnI=;
 b=cPnNTJe1mivVp8/82zYUljsNHZttgr2PIm0dGvBK5Fz77CM4Vx+v68c+yHRmgH9djb4T8UoFhUZMTIXnX7pqkhSA1sPQ/zr+YLGqt4o52Ub/FQ0GT9U7dwrs7362aPijWINX7etVEKj53blES5LtjU9VtoBVtpoxGfBk/P+geN9EwwV1bFPCEp955zU3LinNpkVCWxpJtLQPrOY1FqN+db1v1EjDjYAcYAdPJrUpos/mtdAr4ycydj7Ixh3LuxyAjrDkEMXiepHKhgo/4IpRfsP8YrUqY+CXoWtkYFkR0Ghhk5dHZYxS9zSw7ReWKbu5JWpeAc1nh11LLj5MQH7ynA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEBOozT9D8Lw2SL0A/GVO3ZCqfukBVgJwvItoNA0TnI=;
 b=67IVoF3o37UyDOYlX7KidyB17jB0Fes98HVRHixXeFN88qmZi5Tw2ZAgNtR3RNzLmaMGSJ8b2KHr5plzLnJ2dAsp52k5egtShBHVcv0nf+Kx2UI1DjRHJG29N/Nc1Zb5bkgpuTIm5sho4iSNK57uuC6oGR6+yk3IyLMFYGFDEyE=
Authentication-Results-Original: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com (2603:10a6:208:65::26)
 by AM9PR08MB6130.eurprd08.prod.outlook.com (2603:10a6:20b:2d8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 12:57:26 +0000
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685]) by AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685%6]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 12:57:26 +0000
Subject: Re: [PATCH RFC v1 08/15] iommu: Add asid_bits to arm smmu-v3 stage1
 table info
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-9-vivek.gautam@arm.com> <YD/E+XASgn9PL9HM@myrica>
From: Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <c705cf54-39ed-0b66-e02c-32969d061b16@arm.com>
Date: Fri, 12 Mar 2021 18:27:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YD/E+XASgn9PL9HM@myrica>
Content-Language: en-US
X-Originating-IP: [217.140.105.56]
X-ClientProxiedBy: BMXPR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::11) To AM0PR08MB3268.eurprd08.prod.outlook.com
 (2603:10a6:208:65::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.162.16.71] (217.140.105.56) by
 BMXPR01CA0001.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 12:57:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cdc203d4-8f85-4e9a-4278-08d8e5566b4d
X-MS-TrafficTypeDiagnostic: AM9PR08MB6130:|VI1PR0802MB2144:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB214480A989EE98292F10F73E896F9@VI1PR0802MB2144.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: EiIiW1OpcPur6xQKCM20VQy0+nAosangeilNUNfhDxpV7YPyuKpTesLQKM2g0A4LzhIWiRRPUmO2R2l+o7q3oSF9ol+A6aRpclY5Nwlvl4EKCkm9MruuC6BSpfLoD0hulQVcEerpZv3I4sClERgDXp9hV+o/XKk/CfJWOla7rTisw6asEWyw6vmdjy2NNsNZgigUvEaidl0gFmSW8DLvi3Za/XWoZmDd9SMD19+HrTAj5EIJR4YH+LCDQ1DJ3LQb9BpfGVDwxo3rmFfsENJRacAD8liZmyMKa4ElOsKe0SAc2E27TRH6KU4tkAD2lur6d5hPu2vujyf4i1NfmqMOy9chZBlcKXlPD1qymHETVnF0TcwlRrIc3Yalmm3MZD+WPwUp9cr3JhxfJjGamlOvV+gk/C3nhtAfD4hCUGEEIiQX9xd/IdxzjhUcgKs0XMEo2pabaSZiNDiNjilRb17RSwMmrmn/y3tylDv9DhVgCN5M1SLVGRJKoZeSRxf/JbqBxaAI3whxLbPC5065ouBYVBMTV1535qp1cdgq4xUTexDyH1pEpvnCIZdJfDGsDOiccF2yUIygQQSamprk/BugveyWY00RanNvOX/Mo9tgFGa+px4Zjpa6ZPcfWdK8Vwe8orMP2ptF0VGoyuPzD6BlWl1wQ58zbllKpHIG8tmOd7We1Klmfv+vflOrg8kvKusuL6m6u1ODrdh3XySuGDtx6w==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB3268.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(52116002)(83380400001)(6486002)(31696002)(53546011)(31686004)(186003)(66476007)(6916009)(26005)(5660300002)(6666004)(2906002)(86362001)(478600001)(956004)(66946007)(2616005)(7416002)(36756003)(8676002)(66556008)(16526019)(4326008)(316002)(8936002)(16576012)(45980500001)(43740500002)(473944003)(414714003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SkJYNWNuMHo5YzkxTE1GbjFVb01hejM4RENqSk5VeWo2QzFIek1JU2ozR0cv?=
 =?utf-8?B?SHlkUnRWSjBUN1ZOeTd4ZUpFSmppR2FqQ3ltOGhObVZaUlAxdDd3NnZDcllL?=
 =?utf-8?B?OHZFSWVTeTI5Uk9md1dYNE81WmZTQzJsMEpSdFpFRTZQUEtkRFlNM1MydzBQ?=
 =?utf-8?B?MEtJbmx4WFFpK05UWTlXMXNvaXdXUjZSQkxaK0RPODVJNlBtek4vRUFrbCtj?=
 =?utf-8?B?SDBZUjZlTGxhSlRaTzV4WHpQRFZrSXNPU1FzY29xa2dGdzkxNjJRR0EvOVo2?=
 =?utf-8?B?STQzeHA0ODliR0dVSmVTN1lvKzQ0dlpsZXNZL01qVDl3Tzl2dVhIUkY4MGE4?=
 =?utf-8?B?L0w0WTVCMjhTV2lvN0MxRGR0YzdrbFNFaCtSc0wwM0NFeXl4bE1IRERLL1Ar?=
 =?utf-8?B?R3ZXZ3JObks2dGhnM0tjbFFKLzNVNUFEOHhXbmR0RTQvM1JJenp4Tms1Z1Rm?=
 =?utf-8?B?K2htSmlDSWZydkswd0FoQjN0Q0JNc0FQdTdKY2E1clVPWG9HZjYyOGJXS0FF?=
 =?utf-8?B?cFVvSThoT01EOG5uSW02V0xvVS95dEUxU3pCcHhpUW1iN3BqL3M1RVJFNWU5?=
 =?utf-8?B?YjF1YVR5K2JYT2tuMzc1MFhLcWYzT01EL2xCaTJIZmJ3bzVUcGM0VW9KeHlm?=
 =?utf-8?B?Ri9mMXJGYTJzOTh0dUhFTFJMRy9oengzZm9yZklLOTc2RjNGUDlXREl1ZmpK?=
 =?utf-8?B?N1JGYWR3STlKYkFXcXNmYWhSYXYrTk9RZ3QrYVI3VnRGc3RSRU9nL0dTZDJ4?=
 =?utf-8?B?cmlsMG50QnJYSVBDOFNQVEpsRXJtd3UrcUFjTDlzekJ0ZDY0bEpwM2NVOHJJ?=
 =?utf-8?B?ZHVwUWRSM3pXaXgyekJyWVo0bjRmemFjK2svcXV1ZDl0ZnlXcUc5QmNHSDVT?=
 =?utf-8?B?L3pMcmE0bUlIYm9VenpCbDNoL3Y4U3RXMkRpMjBLUGtiYmxlUE9NWi9wajdY?=
 =?utf-8?B?d3dvRWpKS1BKUWdIZVdGYmcyMTg4VWN5S1BEY05RUWc1NEFjY2xZQXhndXVl?=
 =?utf-8?B?WXArV05sdGh1dDVwRnVRdVVuSFcwZG1UdDNiR3BaNDcxakw3OXNSbG5RZlVS?=
 =?utf-8?B?Ui9zUHlBTGZOQ2YzVEZiSVVCeFY0RWxJOUE1TDcrNHNHRVZUWm15QnJvQWhl?=
 =?utf-8?B?aWlYYm5uc1RQdHdaNGYrZEliMjBZOVJPVGlEMXcyVXFQcmg2SGNJNGtOSWtW?=
 =?utf-8?B?alZ3a2NyQzd0SGtFSmROcytteFZ2VzhYcUNDeldIYkxyWndyak9uaGV2RXZ2?=
 =?utf-8?B?d3FuZ1B2V0h0a1F5QlZuZkJEajFZOGhySFVPYXBTYXQ1RlpLUGNrbGRsT2p0?=
 =?utf-8?B?bVBaNWhYRmlYeU1Ec0l4Q1Vra0pLV01uOEkvZ3V4Vk42YWhhUWtnTEVyL3dP?=
 =?utf-8?B?YXpIdFdMdEJ4cG5pcThzZWFFNHhjeW5reVBjRDRsNVQxcVg1VmxmcTV2M0lt?=
 =?utf-8?B?RGxVQ0F4L1B0dUlmeGYwaGs4MzFpaHBsdW1Bamt0REFIT1NoMzVUdkVDYnNY?=
 =?utf-8?B?L1VQeVdIeDdsaWVpY0hmU0VobnhKRHpqY04xR2FNRTk2WVR2OFkrdEVFNkoy?=
 =?utf-8?B?WXZrUmg5a0VGN3JDUnR1VFF5bVFJTFFCQXR3YmtqYm9Nd05kR2luVFp4Y01x?=
 =?utf-8?B?dk82TWNKeW5yVzBEbmlRNEw0Z2U2QUZrZTZnNlBNcXVGV1RVaTlQL0c5N3VP?=
 =?utf-8?B?SXJRSmlzaytpYlgxTzdlTDNVWXlmMTF6K3prcjY4aUcxdkZWb20wOE1LM3Zh?=
 =?utf-8?Q?mEqyFEqnldCE2TsZRoTT5A6QPewTW3G5uKspw1V?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6130
Original-Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT016.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: df9537e5-f5f1-4943-f924-08d8e5566282
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xFtWHycrDFaYlOzKi+IvEPNTcvS/HcuQyZF3dzMWQOrAfKR87gUdLGjQpd49R3BUTN+0Tg5LIPf1trrYcFAs58piZM2wDP9DSpSV/sdgY8pr3f6k7YZM0neD+wpN0FGO8+W6iHbeBJmNu7dLfHzcjcYnptQd6ZvfyfxgqIzXlKee7fKpz7TXl83b0i4gXOqTxpldh4Hv/HpFZpGKp2WtKuvQXMXCe0io+0q6MpQaFTwg/rPCyjUJKiea/178rJG+hu3CMmD3p/lTLRQ40I0nWqeDQw/1vyeNrjOXYbwTF+7cQryS1M7D7bNy2DHh7ircgz7LnHRhtCZXKX5L3A7HsinXXVt43LGTXeoc4yZanPxiUHRkFHzQfsOeh1FQanEVEXCAmbzhIUwvbxLcSbdldK4J2YpEVpF+eL8MuUWs/tww248zBR0X55oIJXx55ORdmbfnKASHagDmZS6NKfduhPkrB1EjKj3m8rL7KzyGpf2GY7RjTXB7arzkfmhWC8/3G08shlu0j9iTLRpFeu8/QChza7LianPB/DSx1wO4wSkwjeQdgf4XWx12XGRiIHZjWcQsXRmaEbs2QZ+vpCYEr5IZhHho22SNe9RDb05B5i8sijJWWk5LtT6EMNkWwawidI1wuo6sBecGjvb86JoOw/YTr79+vd8WQRCCicuUsiEsOrV3EB8+Dg4cAWZW3KRePqRNoTsgm//vB3Qd05XUS58rNkGhiuGT1l22Z7cCzY5jrJPG4qH5zOvS/n4aOnfd
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(46966006)(36840700001)(81166007)(8936002)(6666004)(86362001)(956004)(70206006)(82310400003)(450100002)(6862004)(82740400003)(36756003)(2616005)(70586007)(4326008)(26005)(356005)(31696002)(47076005)(6486002)(53546011)(83380400001)(336012)(316002)(36860700001)(107886003)(16526019)(31686004)(2906002)(186003)(478600001)(5660300002)(16576012)(8676002)(43740500002)(414714003)(473944003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 12:57:40.2279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc203d4-8f85-4e9a-4278-08d8e5566b4d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT016.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2144
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



On 3/3/21 10:48 PM, Jean-Philippe Brucker wrote:
> On Fri, Jan 15, 2021 at 05:43:35PM +0530, Vivek Gautam wrote:
>> aisd_bits data is required to prepare stage-1 tables for arm-smmu-v3.
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
>>   include/uapi/linux/iommu.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
>> index 082d758dd016..96abbfc7c643 100644
>> --- a/include/uapi/linux/iommu.h
>> +++ b/include/uapi/linux/iommu.h
>> @@ -357,7 +357,7 @@ struct iommu_pasid_smmuv3 {
>>   	__u32	version;
>>   	__u8	s1fmt;
>>   	__u8	s1dss;
>> -	__u8	padding[2];
>> +	__u16	asid_bits;
> 
> Is this used anywhere?  This struct is passed from host userspace to host
> kernel to attach the PASID table, so I don't think it needs an asid_bits
> field.

Yea, must have missed removing it from the WIP work. Will remove it.

Thanks
Vivek
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
