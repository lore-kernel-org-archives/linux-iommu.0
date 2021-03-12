Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9C8C433E0
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 13:29:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 740F764FB8
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 13:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740F764FB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3348360698;
	Fri, 12 Mar 2021 13:29:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XjrJigMTu0TW; Fri, 12 Mar 2021 13:29:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 752EF60679;
	Fri, 12 Mar 2021 13:29:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D4A0C000A;
	Fri, 12 Mar 2021 13:29:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D45EC0001;
 Fri, 12 Mar 2021 13:29:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B3568446C;
 Fri, 12 Mar 2021 13:29:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com
 header.b="2ExbksIu"; dkim=pass (1024-bit key)
 header.d=armh.onmicrosoft.com header.b="2ExbksIu"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NrIIR9AhVu9Q; Fri, 12 Mar 2021 13:29:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03on060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0a::60d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9BA678446A;
 Fri, 12 Mar 2021 13:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDN2coQxa2EDzsv4hYz4WoYc4mtgKCmMW2uFeGGKhi0=;
 b=2ExbksIuiRVSAmeTi3pyLeEdwUHqp8UdDivFcd5+S1alwYLdOCUi0JgmL1zxxLgEKnispCBQbufZuAv6E9zUg4Oo5xEBTJLkPPnfTFyqal/rzgXMG9iQNRbe1r3GeFYbsU1UEa3DUFtE9z5lJmt6tTjpfzdLaYcaRsN1ApFbXLM=
Received: from AM6P195CA0021.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::34)
 by AM6PR08MB4086.eurprd08.prod.outlook.com (2603:10a6:20b:a8::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 13:29:38 +0000
Received: from VE1EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:81:cafe::84) by AM6P195CA0021.outlook.office365.com
 (2603:10a6:209:81::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 12 Mar 2021 13:29:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.linux-foundation.org; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.linux-foundation.org;
 dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT033.mail.protection.outlook.com (10.152.18.147) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31 via Frontend Transport; Fri, 12 Mar 2021 13:29:37 +0000
Received: ("Tessian outbound e7a0046930fb:v71");
 Fri, 12 Mar 2021 13:29:36 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c6349ac8dc51ba66
X-CR-MTA-TID: 64aa7808
Received: from 3580490e2820.2
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 C5B03C1B-B052-4C52-9A18-8DCD848AFB29.1; 
 Fri, 12 Mar 2021 13:29:31 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3580490e2820.2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Fri, 12 Mar 2021 13:29:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COEXIcFawtmznwskPVfGPgDYhnJ6DbG/S+Hw4edc2/zbW2yZu3tH3wQn+A2WJdo2ca/1AjmtyailS1RHTHGY84b6MzQD8oR+dmPe12jyLRuHCLTdcLANMvWBTgcgMBZKeTK6FuRcuM+Tu2WS0jx4ANHSQpFKDew/6b27rhx5YPc0L3V1YRMgWYOVXbm9dN5Xdv1aD/LYK3CIdm7NJa0kTskbQIsGnacTujIRYBBkqslxIt43ogxii2P1N4vRFbH24aPsAlCDPWOcIhwryIdwCgMJXZ93nbq/01IUeqpbWOykNCJWcxzw/00CUXdMU1/ToohYbZg1MNuKEY65YcVUeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDN2coQxa2EDzsv4hYz4WoYc4mtgKCmMW2uFeGGKhi0=;
 b=fQSv6y4CYGj8CgMiuNLoPk92EtQio+7YRKfY1+e6Fa3+F+8bxiMicHS+WjaYRnDh0rG+Hxf1WUF52ZzoewS8fydzjdQ5k5t3HYHt8Hj8OZIOVGvYENE1Svo1c1w7q/ToefWlOCIrPW7xjh96p47Lgo1VACU11clGoMXY7O6dPBdbtXQ8rgBCIyTksn7gjN5+KGp96fsOEgr8Ee+8IguqZNq1DO9d3OX+7ImvlHEBdbTEQwuzIvO7nJkO8jOVHqYbBY+I2ulwNTtAgcfmqsiOIISh3g3LfCWY+Hotd6TZWtmVCDcydg7BRTllBXMbtJ9Kjkq5XlzRqqb+wwTQvaPqCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDN2coQxa2EDzsv4hYz4WoYc4mtgKCmMW2uFeGGKhi0=;
 b=2ExbksIuiRVSAmeTi3pyLeEdwUHqp8UdDivFcd5+S1alwYLdOCUi0JgmL1zxxLgEKnispCBQbufZuAv6E9zUg4Oo5xEBTJLkPPnfTFyqal/rzgXMG9iQNRbe1r3GeFYbsU1UEa3DUFtE9z5lJmt6tTjpfzdLaYcaRsN1ApFbXLM=
Authentication-Results-Original: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com (2603:10a6:208:65::26)
 by AM0PR08MB4996.eurprd08.prod.outlook.com (2603:10a6:208:15a::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Fri, 12 Mar
 2021 13:29:28 +0000
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685]) by AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685%6]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 13:29:28 +0000
Subject: Re: [PATCH RFC v1 13/15] iommu/virtio: Attach Arm PASID tables when
 available
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-14-vivek.gautam@arm.com> <YD/GeIJA/ARevO7X@myrica>
From: Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <ee88590b-513e-7821-ab52-18d496ad90dc@arm.com>
Date: Fri, 12 Mar 2021 18:59:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YD/GeIJA/ARevO7X@myrica>
Content-Language: en-US
X-Originating-IP: [217.140.105.56]
X-ClientProxiedBy: MN2PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:208:23d::15) To AM0PR08MB3268.eurprd08.prod.outlook.com
 (2603:10a6:208:65::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.162.16.71] (217.140.105.56) by
 MN2PR06CA0010.namprd06.prod.outlook.com (2603:10b6:208:23d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 12 Mar 2021 13:29:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6ed7106f-9807-475c-27c6-08d8e55ae200
X-MS-TrafficTypeDiagnostic: AM0PR08MB4996:|AM6PR08MB4086:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB408658E002DB8DA8D5128D30896F9@AM6PR08MB4086.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: VE/9wLz6fdvWvRnAoKRcrN//Y+xPRzvpgPJPvQYVbG5K8wDNVXY+s12qLtwUPB5323dNZbtmDMB1b+ahmJmR8/IlMFqmxMS2GqbNq/XoJpphzVukeEFoH/tO01s+bZWi82sCdxO6m/voHyQVYUKTRial2r3Q+8zG5mviM7wRti1gsl1m9r1lVLo9zDpeP9Eok5SMYSDjV4SFoaG021J8QHEuH/Oilnd2i1TPKyJZcFxT8nIfaYGcAP64Pv0zmJnD+IVnNM1KrRAiC9+yOKIkMTqMp2KWtudAGu9A65X66GsTkrQfyhHe11ptLoFHEyhelRwAOThV1LOdLQcAgtJRfOG8oz0J4n1fOX65WUg/RBazeDj82hFHc89C5c+g/nCRs0AIJhpWLEEIs4qifnYNvtrqZNCSy46RVTZDCjMbxsEv5tz55Zcsat04iHHz4js9gRIfAM5wIemmy7QFEAPsiZx65nwkSGCI1MKpWIBeSuJVc8yLDy1HCDx8eaK0x71QnQN9EAxsV6MMofMo3CbZ6cojS3YEluG4xyGOSuKE1+KUtzQj2uozQG2PiR/aOBEFf5IEQo6cANJdkcG27JsFJH0xNy1r7YxR6QoEwb0R/LflxREHi/ClHiS8pefHevIhY2NpUFFU7UcVcksVoDlgZljhmAtg5j/TO8MBYH7zlGk=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB3268.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(956004)(52116002)(8676002)(53546011)(8936002)(478600001)(6486002)(2906002)(66946007)(31696002)(66556008)(5660300002)(86362001)(66476007)(30864003)(16526019)(2616005)(6666004)(6916009)(31686004)(83380400001)(26005)(7416002)(36756003)(316002)(16576012)(4326008)(186003)(21314003)(43740500002)(45980500001)(473944003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SE14eXAydnBSdGpKTnFjTzE3TkpCZnZqOExYMk5yL1ozejRDb1NSTmdSN3Vp?=
 =?utf-8?B?VGMvKysyS05tQzhwenRlVDJ2SWcvckVJc2RrSHZ6UWFyWWR3d3Jpd0wyWjRK?=
 =?utf-8?B?dVlWbWZERnFDc3YwT0s5Um9zSGZWUUVkUmp3cHJOVzc1TnFXZ2NmZVBmT202?=
 =?utf-8?B?bHhLQTFNaHRDdHk5cHdjTlVWSmNNblJDdElhSFNWN1Yva1hOSHRTL25UbWxQ?=
 =?utf-8?B?Z3ZtdFp6ZkZXK0ZRcUdDYk9vU3ZTMWJzRUZWL2N2SFAxcWkwTW5NbDVYaU03?=
 =?utf-8?B?MnRmN1JzR1JIbnBLYzBKS0lFMFVmZUk4RGlpU1liNDExQlQ5RllrWlpxUkhX?=
 =?utf-8?B?QVEzb2RyaVZsUzdTSTcrWGZnYVg3ck0wOFhoTEtZYk1tVGdYRWlFRVp0d0NO?=
 =?utf-8?B?K0M1N1N3a1VsWktZdzVma1AxM2laOVFKWjhaMVZBNW16WEhaM3RqZEJSNTBL?=
 =?utf-8?B?bDAwd2xwdUZBUGJlaUdDU0FITzUxczBPZ3BVRnFaYWYxUVBEbmp6NmZVTERm?=
 =?utf-8?B?dS84NzFpWDhydDlmaEhPYzRINmJWaXZGSndBa210MVBKRm1GTytRZC8ycit2?=
 =?utf-8?B?ODEzK1pRcXd5bTFTV2ZPcjhZdmlFQ3d2cTRPTlFjVnlMLytGYVY2NXFjWGxl?=
 =?utf-8?B?L1I2cFEreFZVVXpmSnZrSE1DYkFkVVBpYktmcWtIMGpoVkVrTTJKc0RoT3c4?=
 =?utf-8?B?VkQxMEY5V2MvTWQ3M3ZQeG5jMWZsa0gvOHRTV0NOYytlcTMvenpkNllJNWkv?=
 =?utf-8?B?TEcyOWZ0R1lsMDE5TUZwak9mVHZUREJLcWNZa2RIVlRFUndqeHRDVkVQbEMz?=
 =?utf-8?B?a2lSVmxlaDE0SzhXUE92WTBlbXpocUU3bElJcVhJZXZqRWRmMTRDanlyOGFE?=
 =?utf-8?B?aDNnWlVvWnFGQjRPT0REdkxTYVJWOUthY1F5R0VxVmxwcy9QWElRaENSaFNL?=
 =?utf-8?B?eHd4dTJVcHZLYUVqZVNnUDlIVUJDQjJNT3ZRWDNmOXJ1MG11dlBUTGthelVY?=
 =?utf-8?B?ZFJKRkl5Qkk0UnZSRzBTSWdYY0ljVVdpZFl5NkNHOFFsdWhGQWMxWEEyUkxN?=
 =?utf-8?B?UE0zUmppQ0FIS3JJcVBkclp3c2M5L2FNc0ttUS9tMm4zdkhncG85V0thNnNH?=
 =?utf-8?B?TytUejhDQitrVWZscHRkNEZDWUNDeHNyUDMyYU1heW43MkNDeTEwTnRmU0U5?=
 =?utf-8?B?R3RHSkthdHFTcThOT245SnNBdnZ6NHVyNWZNb3VtOFhYQ0RINEgySXdHbDd5?=
 =?utf-8?B?S2JnYmJQUFhCVmhqU2svSWg1Uk9nOERRdzFCd0ZBbjRCZWdEWE10amdPZTZY?=
 =?utf-8?B?MXlRL1hOczNHRFdZVmxqWGc3eUJWQ09sTnM3OUZrZklDRlNidjkvdWFZeGxI?=
 =?utf-8?B?VGdadndLRzZTMm1BODQ5dXNWQzFkUW85bUU1RW9SaUd5OGFHVHpzRmtFcTg0?=
 =?utf-8?B?cldVejFIdGhFZW8xRnBGS1MxV3NlTHNGRXlHblArSGExRDdaV2NxajFFMVN2?=
 =?utf-8?B?SUZGZkhENTZuSThIVFBTRHBVeWpsR0Y1V2xLYy92NXovKzZIOHlnRmNGMzNv?=
 =?utf-8?B?QUNZdmNOcndueENiaDE5TUQ3OXpRUHdqeUs5VkVTVHQ3Qk45c0NDMGJhUzU4?=
 =?utf-8?B?NWxqZG5PN3MrUzNMTGQ5bjZPYWNwQThaV0RxS1ZlVFk5T1ZQeG50WVRIMjJH?=
 =?utf-8?B?NUx3Qk1CWXFMR3hFK1BPK2JhMDZnMnFoZ1I1ZE1EY0w0UEdRR3ZzbXhBSUN6?=
 =?utf-8?Q?biJ5bgIeuFJjNyzMlejZ7yVljO25ZIwGWSVrLSY?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4996
Original-Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: d29f01c1-a5c8-41c6-2541-08d8e55adc05
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EqnAqqeHFSHYd6wPIfg/5YKk+nlCQrsVXab5arB1fwOZzbFHzQ+cpbn+98Q9dm0//WXYsG0ST/mTP7XWRGOPN0gzAp9BnKN+1lDLJfM44qfv9udLkmwAWJO6nPtUF4LxtD92V5djSH/kYZSljJ78Cqr1ZMkIJ8FrSt48z9jP1WCQInJjixl+SnFySwZQuFwgsYMiskA2Lc4eTwZdMuK6ouA6LmvntX86LdS5+HbpJbZ4XVUAUthMRhpXiW3rvaCDHXlFyJ/u6K9K7m1cAeL3S5D6HMW1ummNQdYW4otTqs6H6pO46wFnYj4ogb5Wzf/iaCgA4pqnbQQxag5vBJWRHZ7O0HZOpy5p5tnIig88oCUA3napjIwzyxfWh0Xj0PHg7DylvQHx91p97Cx2Znz+dQcf4mS2uB1Mwj1UBHXWfY0HVmhb/wgozr5biYGcGhBY6mmrEqWSXLvK7InRH+Sue9E0THKaRlNpEb+y59pNyS2Hf/FSEhB/YXtysmdz3xd7SkJlIXrXAjuhYHy+dFdJC1nRPT8iTBK5uJWcJcAC6TWcxr2CibgTeYsePj6FqKxVxlUJhteodi7pVblQaFVFjBbQspDgaGlS2VT/PTHfeuWb8HIlm3UIL/I2uYW7ePbLJbQsKwk/PYdYswfsNRmP1XzOZRyaBvUsbeQtNmspRJf8vabF8GGvLJqR2xKjVjX/3c/W2ReSpWOFq7IYgfr89FVhVvC8lNEhLNJP0+rAa90=
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(36840700001)(46966006)(8676002)(6486002)(6666004)(316002)(5660300002)(107886003)(2906002)(53546011)(16576012)(478600001)(450100002)(336012)(4326008)(16526019)(186003)(26005)(6862004)(956004)(2616005)(8936002)(30864003)(36860700001)(70206006)(70586007)(47076005)(81166007)(82740400003)(356005)(82310400003)(36756003)(86362001)(31696002)(31686004)(83380400001)(21314003)(43740500002)(473944003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 13:29:37.2214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed7106f-9807-475c-27c6-08d8e55ae200
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4086
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



On 3/3/21 10:55 PM, Jean-Philippe Brucker wrote:
> On Fri, Jan 15, 2021 at 05:43:40PM +0530, Vivek Gautam wrote:
> [...]
>> +static int viommu_setup_pgtable(struct viommu_endpoint *vdev,
>> +				struct viommu_domain *vdomain)
>> +{
>> +	int ret, id;
>> +	u32 asid;
>> +	enum io_pgtable_fmt fmt;
>> +	struct io_pgtable_ops *ops = NULL;
>> +	struct viommu_dev *viommu = vdev->viommu;
>> +	struct virtio_iommu_probe_table_format *desc = vdev->pgtf;
>> +	struct iommu_pasid_table *tbl = vdomain->pasid_tbl;
>> +	struct iommu_vendor_psdtable_cfg *pst_cfg;
>> +	struct arm_smmu_cfg_info *cfgi;
>> +	struct io_pgtable_cfg cfg = {
>> +		.iommu_dev	= viommu->dev->parent,
>> +		.tlb		= &viommu_flush_ops,
>> +		.pgsize_bitmap	= vdev->pgsize_mask ? vdev->pgsize_mask :
>> +				  vdomain->domain.pgsize_bitmap,
>> +		.ias		= (vdev->input_end ? ilog2(vdev->input_end) :
>> +				   ilog2(vdomain->domain.geometry.aperture_end)) + 1,
>> +		.oas		= vdev->output_bits,
>> +	};
>> +
>> +	if (!desc)
>> +		return -EINVAL;
>> +
>> +	if (!vdev->output_bits)
>> +		return -ENODEV;
>> +
>> +	switch (le16_to_cpu(desc->format)) {
>> +	case VIRTIO_IOMMU_FOMRAT_PGTF_ARM_LPAE:
>> +		fmt = ARM_64_LPAE_S1;
>> +		break;
>> +	default:
>> +		dev_err(vdev->dev, "unsupported page table format 0x%x\n",
>> +			le16_to_cpu(desc->format));
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (vdomain->mm.ops) {
>> +		/*
>> +		 * TODO: attach additional endpoint to the domain. Check that
>> +		 * the config is sane.
>> +		 */
>> +		return -EEXIST;
>> +	}
>> +
>> +	vdomain->mm.domain = vdomain;
>> +	ops = alloc_io_pgtable_ops(fmt, &cfg, &vdomain->mm);
>> +	if (!ops)
>> +		return -ENOMEM;
>> +
>> +	pst_cfg = &tbl->cfg;
>> +	cfgi = &pst_cfg->vendor.cfg;
>> +	id = ida_simple_get(&asid_ida, 1, 1 << desc->asid_bits, GFP_KERNEL);
>> +	if (id < 0) {
>> +		ret = id;
>> +		goto err_free_pgtable;
>> +	}
>> +
>> +	asid = id;
>> +	ret = iommu_psdtable_prepare(tbl, pst_cfg, &cfg, asid);
>> +	if (ret)
>> +		goto err_free_asid;
>> +
>> +	/*
>> +	 * Strange to setup an op here?
>> +	 * cd-lib is the actual user of sync op, and therefore the platform
>> +	 * drivers should assign this sync/maintenance ops as per need.
>> +	 */
>> +	tbl->ops->sync = viommu_flush_pasid;
> 
> But this function deals with page tables, not pasid tables. As said on an
> earlier patch, the TLB flush ops should probably be passed during table
> registration - those ops are global so should really be const.

Right, will amend it.

> 
>> +
>> +	/* Right now only PASID 0 supported ?? */
>> +	ret = iommu_psdtable_write(tbl, pst_cfg, 0, &cfgi->s1_cfg->cd);
>> +	if (ret)
>> +		goto err_free_asid;
>> +
>> +	vdomain->mm.ops = ops;
>> +	dev_dbg(vdev->dev, "using page table format 0x%x\n", fmt);
>> +
>> +	return 0;
>> +
>> +err_free_asid:
>> +	ida_simple_remove(&asid_ida, asid);
>> +err_free_pgtable:
>> +	free_io_pgtable_ops(ops);
>> +	return ret;
>> +}
>> +
>> +static int viommu_config_arm_pst(struct iommu_vendor_psdtable_cfg *pst_cfg,
>> +				 struct virtio_iommu_req_attach_pst_arm *req)
>> +{
>> +	struct arm_smmu_s1_cfg *s1_cfg = pst_cfg->vendor.cfg.s1_cfg;
>> +
>> +	if (!s1_cfg)
>> +		return -ENODEV;
>> +
>> +	req->format	= cpu_to_le16(VIRTIO_IOMMU_FORMAT_PSTF_ARM_SMMU_V3);
>> +	req->s1fmt	= s1_cfg->s1fmt;
>> +	req->s1dss	= VIRTIO_IOMMU_PSTF_ARM_SMMU_V3_DSS_0;
>> +	req->s1contextptr = cpu_to_le64(pst_cfg->base);
>> +	req->s1cdmax	= cpu_to_le32(s1_cfg->s1cdmax);
>> +
>> +	return 0;
>> +}
>> +
>> +static int viommu_config_pst(struct iommu_vendor_psdtable_cfg *pst_cfg,
>> +			     void *req, enum pasid_table_fmt fmt)
>> +{
>> +	int ret;
>> +
>> +	switch (fmt) {
>> +	case PASID_TABLE_ARM_SMMU_V3:
>> +		ret = viommu_config_arm_pst(pst_cfg, req);
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +		WARN_ON(1);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int viommu_prepare_arm_pst(struct viommu_endpoint *vdev,
>> +				  struct iommu_vendor_psdtable_cfg *pst_cfg)
>> +{
>> +	struct virtio_iommu_probe_table_format *pgtf = vdev->pgtf;
>> +	struct arm_smmu_cfg_info *cfgi = &pst_cfg->vendor.cfg;
>> +	struct arm_smmu_s1_cfg *cfg;
>> +
>> +	/* Some sanity checks */
>> +	if (pgtf->asid_bits != 8 && pgtf->asid_bits != 16)
>> +		return -EINVAL;
> 
> No need for this, next patch cheks asid size in viommu_config_arm_pgt()

Right, thanks for catching.

> 
>> +
>> +	cfg = devm_kzalloc(pst_cfg->iommu_dev, sizeof(cfg), GFP_KERNEL);
>> +	if (!cfg)
>> +		return -ENOMEM;
>> +
>> +	cfgi->s1_cfg = cfg;
>> +	cfg->s1cdmax = vdev->pasid_bits;
>> +	cfg->cd.asid = pgtf->asid_bits;
> 
> That doesn't look right, cfg->cd.asid takes the ASID value of context 0
> but here we're writing a limit. viommu_setup_pgtable() probably needs to
> set this field to the allocated ASID, since viommu_teardown_pgtable() uses
> it.

Yea, this isn't right. The asid should be assigned to the one that we 
are allocating. I think this is getting over-written when 
iommu_psdtable_prepare() calls into arm_smmu_prepare_cd() where the 
correct asid value is assigned. I will remove this.

> 
>> +
>> +	pst_cfg->fmt = PASID_TABLE_ARM_SMMU_V3;
> 
> Parent function can set this

Sure.

> 
>> +	/* XXX HACK: set feature bit ARM_SMMU_FEAT_2_LVL_CDTAB */
>> +	pst_cfg->vendor.cfg.feat_flag |= (1 << 1);
> 
> Oh right, this flag is missing. I'll add
> 
>    #define VIRTIO_IOMMU_PST_ARM_SMMU3_F_CD2L (1ULL << 1)
> 
> to the spec.

Regarding this Eric pointed out [1] in my other patch about the 
scalability of the approach where we keep adding flags in 
'iommu_nesting_info' corresponding to the arm-smmu-v3 capabilities. I 
guess the same goes to these flags in virtio.
May be the 'iommu_nesting_info' can have a bitmap with the caps for 
vendor specific features, and here we can add the related flags?

> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int viommu_prepare_pst(struct viommu_endpoint *vdev,
>> +			      struct iommu_vendor_psdtable_cfg *pst_cfg,
>> +			      enum pasid_table_fmt fmt)
>> +{
>> +	int ret;
>> +
>> +	switch (fmt) {
>> +	case PASID_TABLE_ARM_SMMU_V3:
>> +		ret = viommu_prepare_arm_pst(vdev, pst_cfg);
>> +		break;
>> +	default:
>> +		dev_err(vdev->dev, "unsupported PASID table format 0x%x\n", fmt);
>> +		ret = -EINVAL;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int viommu_attach_pasid_table(struct viommu_endpoint *vdev,
>> +				     struct viommu_domain *vdomain)
>> +{
>> +	int ret;
>> +	int i, eid;
>> +	enum pasid_table_fmt fmt = -1;
>> +	struct virtio_iommu_probe_table_format *desc = vdev->pstf;
>> +	struct virtio_iommu_req_attach_table req = {
>> +		.head.type	= VIRTIO_IOMMU_T_ATTACH_TABLE,
>> +		.domain		= cpu_to_le32(vdomain->id),
>> +	};
>> +	struct viommu_dev *viommu = vdev->viommu;
>> +	struct iommu_pasid_table *tbl;
>> +	struct iommu_vendor_psdtable_cfg *pst_cfg;
>> +
>> +	if (!viommu->has_table)
>> +		return 0;
>> +
>> +	if (!desc)
>> +		return -ENODEV;
>> +
>> +	/* Prepare PASID tables configuration */
>> +	switch (le16_to_cpu(desc->format)) {
>> +	case VIRTIO_IOMMU_FORMAT_PSTF_ARM_SMMU_V3:
>> +		fmt = PASID_TABLE_ARM_SMMU_V3;
>> +		break;
>> +	default:
>> +		dev_err(vdev->dev, "unsupported PASID table format 0x%x\n",
>> +			le16_to_cpu(desc->format));
>> +		return 0;
>> +	}
>> +
>> +	if (!tbl) {
>> +		tbl = iommu_register_pasid_table(fmt, viommu->dev->parent, vdomain);
>> +		if (!tbl)
>> +			return -ENOMEM;
>> +
>> +		vdomain->pasid_tbl = tbl;
>> +		pst_cfg = &tbl->cfg;
>> +
>> +		pst_cfg->iommu_dev = viommu->dev->parent;
>> +
>> +		/* Prepare PASID tables info to allocate a new table */
>> +		ret = viommu_prepare_pst(vdev, pst_cfg, fmt);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = iommu_psdtable_alloc(tbl, pst_cfg);
>> +		if (ret)
>> +			return ret;
>> +
>> +		pst_cfg->iommu_dev = viommu->dev->parent;
> 
> Already set by iommu_register_pasid_table() (and needed for DMA
> allocations in iommu_psdtable_alloc())

Right.

> 
>> +		pst_cfg->fmt = PASID_TABLE_ARM_SMMU_V3;
> 
> Already set above

Right.

> 
>> +
>> +		ret = viommu_setup_pgtable(vdev, vdomain);
>> +		if (ret) {
>> +			dev_err(vdev->dev, "could not install page tables\n");
>> +			goto err_free_psdtable;
>> +		}
>> +
>> +		/* Add arch-specific configuration */
>> +		ret = viommu_config_pst(pst_cfg, (void *)&req, fmt);
>> +		if (ret)
>> +			goto err_free_ops;
>> +
>> +		vdev_for_each_id(i, eid, vdev) {
>> +			req.endpoint = cpu_to_le32(eid);
>> +			ret = viommu_send_req_sync(viommu, &req, sizeof(req));
>> +			if (ret)
>> +				goto err_free_ops;
>> +		}
>> +	} else {
>> +		/* TODO: otherwise, check for compatibility with vdev. */
>> +		return -ENOSYS;
>> +	}
>> +
>> +	dev_dbg(vdev->dev, "uses PASID table format 0x%x\n", fmt);
>> +
>> +	return 0;
>> +
>> +err_free_ops:
>> +	if (vdomain->mm.ops)
>> +		viommu_teardown_pgtable(vdomain);
>> +err_free_psdtable:
>> +	iommu_psdtable_free(tbl, &tbl->cfg);
>> +
>> +	return ret;
>> +}
>> +
>>   static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>>   {
>>   	int ret = 0;
>> @@ -928,6 +1213,17 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>>   	if (vdev->vdomain)
>>   		vdev->vdomain->nr_endpoints--;
>>   
>> +	ret = viommu_attach_pasid_table(vdev, vdomain);
>> +	if (ret) {
>> +		/*
>> +		 * No PASID support, too bad. Perhaps we can bind a single set
>> +		 * of page tables?
>> +		 */
>> +		ret = viommu_setup_pgtable(vdev, vdomain);
> 
> This cannot work at the moment because viommu_setup_pgtable() writes to
> the non-existing pasid table. Probably best to leave this call for next
> patch.

Yea, will move it to the next patch.

Thanks & regards
Vivek

> 
> Thanks,
> Jean
> 
>> +		if (ret)
>> +			dev_err(vdev->dev, "could not install tables\n");
>> +	}
>> +
>>   	if (!vdomain->mm.ops) {
>>   		/* If we couldn't bind any table, use the mapping tree */
>>   		ret = viommu_simple_attach(vdomain, vdev);
>> @@ -948,6 +1244,10 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
>>   	u32 flags;
>>   	struct virtio_iommu_req_map map;
>>   	struct viommu_domain *vdomain = to_viommu_domain(domain);
>> +	struct io_pgtable_ops *ops = vdomain->mm.ops;
>> +
>> +	if (ops)
>> +		return ops->map(ops, iova, paddr, size, prot, gfp);
>>   
>>   	flags = (prot & IOMMU_READ ? VIRTIO_IOMMU_MAP_F_READ : 0) |
>>   		(prot & IOMMU_WRITE ? VIRTIO_IOMMU_MAP_F_WRITE : 0) |
>> @@ -986,6 +1286,10 @@ static size_t viommu_unmap(struct iommu_domain *domain, unsigned long iova,
>>   	size_t unmapped;
>>   	struct virtio_iommu_req_unmap unmap;
>>   	struct viommu_domain *vdomain = to_viommu_domain(domain);
>> +	struct io_pgtable_ops *ops = vdomain->mm.ops;
>> +
>> +	if (ops)
>> +		return ops->unmap(ops, iova, size, gather);
>>   
>>   	unmapped = viommu_del_mappings(vdomain, iova, size);
>>   	if (unmapped < size)
>> @@ -1014,6 +1318,10 @@ static phys_addr_t viommu_iova_to_phys(struct iommu_domain *domain,
>>   	struct viommu_mapping *mapping;
>>   	struct interval_tree_node *node;
>>   	struct viommu_domain *vdomain = to_viommu_domain(domain);
>> +	struct io_pgtable_ops *ops = vdomain->mm.ops;
>> +
>> +	if (ops)
>> +		return ops->iova_to_phys(ops, iova);
>>   
>>   	spin_lock_irqsave(&vdomain->mappings_lock, flags);
>>   	node = interval_tree_iter_first(&vdomain->mappings, iova, iova);
>> @@ -1264,7 +1572,12 @@ static int viommu_probe(struct virtio_device *vdev)
>>   				struct virtio_iommu_config, probe_size,
>>   				&viommu->probe_size);
>>   
>> +	viommu->has_table = virtio_has_feature(vdev, VIRTIO_IOMMU_F_ATTACH_TABLE);
>>   	viommu->has_map = virtio_has_feature(vdev, VIRTIO_IOMMU_F_MAP_UNMAP);
>> +	if (!viommu->has_table && !viommu->has_map) {
>> +		ret = -EINVAL;
>> +		goto err_free_vqs;
>> +	}
>>   
>>   	viommu->geometry = (struct iommu_domain_geometry) {
>>   		.aperture_start	= input_start,
>> @@ -1356,6 +1669,7 @@ static unsigned int features[] = {
>>   	VIRTIO_IOMMU_F_DOMAIN_RANGE,
>>   	VIRTIO_IOMMU_F_PROBE,
>>   	VIRTIO_IOMMU_F_MMIO,
>> +	VIRTIO_IOMMU_F_ATTACH_TABLE,
>>   };
>>   
>>   static struct virtio_device_id id_table[] = {
>> -- 
>> 2.17.1
>>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
