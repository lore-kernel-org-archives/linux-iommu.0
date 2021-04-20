Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD0BC433B4
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 08:39:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A584B61104
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 08:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A584B61104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47FFB6063F;
	Tue, 20 Apr 2021 08:39:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ml7pPKYZYZzZ; Tue, 20 Apr 2021 08:39:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92B85605A1;
	Tue, 20 Apr 2021 08:39:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 710B3C000F;
	Tue, 20 Apr 2021 08:39:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC34AC000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 08:39:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9BFA1827B1
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 08:39:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d8PWelt_9tEi for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 08:39:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::61a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 774518367B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 08:39:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOLaZ/pynw7Y5aCasGwQkaZzIMJH9DfzJm6krphpMKSki61Fx/uwZEC9bM4ErCupYtz6W0Tm4gFmo6MMy+soBpzfedgYy+K3Gbr3o2mBZerEbXi68hQ0iR8806NdAJ87jZunEdD3R5CoeDlkk2hAmdSUk1UyGF6CGM3/4AxvkSQssPTCnHnV/is4/3CHKoQ1UcV3fvTYmUiTdcPvffz+iTk0N5R4pldOjdsMgv+7toeRypwnyuhNyk/Z4Qop1njssaXkvcCZii4Fe03gfqpw14YG14ccQLv1WUnrCkLM39ft0eNjylYK9k2c8iBfqPM5JgZF6PqsUTcu8H4o/mMj2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqLKDXwbbIK71cyAcY+6gcgEavl/QMix/ulMYFIZCeI=;
 b=hrE939yjHFaKYk5rXOOKX/N4V+e8qAtTMkicfrzWdMkQqZmpNgxKeUefTZ3ZiWeT/U/PE6Ssa4KrPVtvffbe4igbJbm7t29Byw6jQjFHy4TTyv+0dkRSCTAWWFVLirqBNWrjYK3cRhDxQczJTpP83xxf2zR260tE834xkpAifXYtNgwqw46rAnOPQbZIb6RYY7UHrv9uXvt/gL9OAX7NXkzx7W4jfu0HrDfoyO4j2C/GYeCHjktOAVOyLoQRtv8qEWkcBpfMEopEDTOmU/QOu/8KP9oy3Jt0Bp2Slk6Lt2kaaUpq9XyCgbFFeZY6EwSfMYR2tXTEVMU+B07ZWwciSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqLKDXwbbIK71cyAcY+6gcgEavl/QMix/ulMYFIZCeI=;
 b=XYrGR8YGnz9sTSn5IWvLeqdoRAQrAAXnyjzcGyc8SrcSX1xsJkfnfecYynIlPJyDcqynwnqh1kJ9QD2TSiNIlG5i6MfP5XNL16n3yS34VgBLkjoWV/Qch9WaNbmEscMndgLcWMYiB3Wo2qvtUqrLSBM79hua5ZqNXkQ5LOZaX+c=
Authentication-Results: bugs.launchpad.net; dkim=none (message not signed)
 header.d=none; bugs.launchpad.net; dmarc=none action=none header.from=amd.com; 
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB2981.namprd12.prod.outlook.com (2603:10b6:a03:de::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Tue, 20 Apr
 2021 08:39:06 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109%5]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 08:39:06 +0000
Subject: Re: [PATCH 2/2] iommu/amd: Remove performance counter
 pre-initialization test
To: David Coe <david.coe@live.co.uk>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
 <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
 <VI1PR09MB26380EED406F2F08ACB6B5BBC7729@VI1PR09MB2638.eurprd09.prod.outlook.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Message-ID: <9d5fa4ff-9666-6475-7f61-2b45cbd83456@amd.com>
Date: Tue, 20 Apr 2021 15:38:54 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <VI1PR09MB26380EED406F2F08ACB6B5BBC7729@VI1PR09MB2638.eurprd09.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [165.204.140.250]
X-ClientProxiedBy: SG2PR02CA0112.apcprd02.prod.outlook.com
 (2603:1096:4:92::28) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.132.84] (165.204.140.250) by
 SG2PR02CA0112.apcprd02.prod.outlook.com (2603:1096:4:92::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 08:39:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdeb0d31-b267-4ddd-0bcf-08d903d7c262
X-MS-TrafficTypeDiagnostic: BYAPR12MB2981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2981AB6B61034E4D4854629AF3489@BYAPR12MB2981.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1H0gBpQKj8H6wre1ee+RlgUK/1qO78xfJyA0mB2B/Gn4ZckCoK9sdF0mTkaJAvwLqi8rg2zhGQPyJhsAYpo+4Q2Y9piMglVNDup72DMDHQc5LkzVyeIJPkQl6+EYfKOowkYBATkRNx8TksrkKfCpZVB0xasawab0HsFn37s08BwrkuAe7WsOluy+Zt1CmPaLPVRYRkV5UzQLWXMA9LPgnzRJtgRwJfmEQNvQdCpsFudi24d72Q+M4IhdFjSD7NZuX39mqoQ2+KXJ5RZ9q/FEK7Z6yrl0DsaRypgEGRAI8uhCQE/LXx88RQpwTySy9NZnotaHCKO7eU17nbAdHcaIe/o0XoAqx1tm4jiLDqB0AVjXvMEV727LTMtBvL8TFuokRtCGALmaaScw+2IdyqahpzfOeTxkqvkBGFUKlqH6A7lGbGtsAB511KcP0uhwPVWF2/5UoooobBd73hkHmiYVxyXEetQQxYZlqSr0mXL127/wwynCSdI1ysQo7a+yRNIwd2lDutA06+0We9Dbbq3jfQcqRaL2Ec49i2FgIDxHdM54rMdYhrDUzXI/8X1F4c3dNSDqKtwvECP37kbhjqJhMWdHDfwwettWEP4lRSZdWiqv4rot/zUtirLSsfZmj2WTZ5VuziYNm13UcNu5+0Hprr0YHl4xH2jkSnAIWJ2UxeqQp7GUKgWouUvt3+lmftduwBAKp5IUa7TSlN+I+T5s+6OL4wmgscgVSgM/qiXuKdM+m8uc+lfOdkACdyPFgV9i
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(38100700002)(316002)(5660300002)(38350700002)(16526019)(186003)(34580700001)(2616005)(4326008)(66556008)(66946007)(52116002)(8936002)(31696002)(16576012)(54906003)(66476007)(7416002)(956004)(83380400001)(36756003)(86362001)(31686004)(53546011)(6666004)(478600001)(8676002)(2906002)(26005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y25IbzdpdENlQXhBZGN4UTBwYkU0QVV2Tms1d0d6WWF3R1BBZ2srWTlmSEI3?=
 =?utf-8?B?R1ZSM0tGQlloTjdHV05vUUtkQm1ldDF6RWY0K1Z2TVJ0b1ZiT3ZuUS9KY1No?=
 =?utf-8?B?ZElkOENvODQ3enZ4MW9XYXhiKzdWVlRTQnhIUXFLS0NQRC9tSFE0TnllVzVw?=
 =?utf-8?B?RjhhUUc5OUVpbnBGN2xvTjNQMGVDb29sK1pNcXhNRXRHQ05WVDc0ckZlMjVs?=
 =?utf-8?B?WEJ3cnZNTDJqaUsrMkp2MWJFcGdLTGt6OU8rM0ZWSjEzL2N2Q2RlZnpTQTl5?=
 =?utf-8?B?bG1iWTNRK0s0T2NkTXBwYVpSSEd1VUU2OVhEYmVHK1R5V3dsQVdROFptUmxL?=
 =?utf-8?B?cXhHdVo4UWVFcXBEYlBBdHFBc1VYbEJRS2ZUQlVDdkwxeTFhR2w3REgyeXM4?=
 =?utf-8?B?bnZYRHBwRGN2Lzc3MWJGck9NcmVPSERHZzNMM0RXZklSOTNHWnUvaFhhaUpN?=
 =?utf-8?B?UlV4b0F2VkV0TGhwZXNzckE0cTEzZkRaZysyOU1qN3o1cUZZcThwYjJEalM2?=
 =?utf-8?B?NVVYNUdtdzBBVFB6R29DYVREbVdmSGd2U1dpL29NSWxtMUxQM0JtSER5Unk5?=
 =?utf-8?B?bk4yY3NGVmN1NDNOT1k0S1YyU1FTM25YMUtQQzFscTFkanRtRWUrTVdKMnN5?=
 =?utf-8?B?V29va09Nc3JBZTRkdnBMclJOMURtYWpad2VRN3VNWHY3UVNzK1BxdXBNeHVS?=
 =?utf-8?B?L1I3VTlUamloWk5CMENwUVNIczlzbkU2ZFNIRUdlTldSMXZVazlWYVE2VkZZ?=
 =?utf-8?B?SnJlQzJ3VGorL3FYTnRRUGFkSmlVaHdERGFBaEJQUElUaDByc2dsNTNLU1R0?=
 =?utf-8?B?QlZXOTB0KzV2OVFRM1cwckNKQ3Q2TGJubWlCZjlBa3hmZmdqaVI2a3N0TW9P?=
 =?utf-8?B?MUJCaUxMVU4zcFB4bnc0WmMzZ095M2t1eWFPeFdjWExFRGpFYVo1eUo2QTdx?=
 =?utf-8?B?Sm5iRk5WWEZlTkI5YjlmL1p4YmxVK1VnYWFBbXNWSzZxNkt6bWlBZGJuSmVi?=
 =?utf-8?B?TGtGbDVhWFJNOXVITi8rMUR4UlZNTW1HSndWR0hQT0dhSnNia3FGTUVYRlpT?=
 =?utf-8?B?VTV5ZU42eDE4Nk91RGUyNFhqa2MzYTlINWdFV1dicUxTUXlSQkRoSGRTaUpl?=
 =?utf-8?B?WFJtUnFZK0d0RjJFd1NqS3RIRkFETnZ2cElHdExvd3JYZmZQUzF6aGo4MXVN?=
 =?utf-8?B?NnhsK3FyM0hST1AzMDdUYTU3a0Vic3ZVRDcwZEpBMjllUHRhNHhCUXpTWlo1?=
 =?utf-8?B?L0owbE5XVU84R1ZadmtwM0ZYdXhwemZwSC8zbmJQbEpVck9oV3pzOW9KQ1ds?=
 =?utf-8?B?dzJwd0RjRnI0ZWVNRkNoMVJIbmpQeXR2RUlmeUlGeFlKNVRQM0pJdnUyS1Iz?=
 =?utf-8?B?c2tWM0FldjI1Z3MySU5yN1ZQZWZ5eWhBWTVMbkdUSVE2Qzd1dkYwMlJuM3RO?=
 =?utf-8?B?NnEzZmtRUHBxb1VmOVcvRGk2K1ZRVjBha3hpVFkxN2RiekRUa0NjamExdnRT?=
 =?utf-8?B?UDE5OGI1WjlsMGNTbkcyVWs0dGQxOUVrY2Noc2x0MVBIZTEvYmxIY3YxWnRL?=
 =?utf-8?B?Z1dtQ2lJalpVd2JrbVA3TDJVUzJwY3E0QUlSZmZSNkhSM3B6cVk2KzVjVXp5?=
 =?utf-8?B?MndSRGdNZk1CU0VHY2NwaEthNjI2M3lBa0JaRHViRFRtZlphME1SdlcvamdS?=
 =?utf-8?B?QjFnYk9zWGsxdHpRQjdmY2daQUhMRHpDa2pUUjNhemZwZklYV25ORUlQK2VC?=
 =?utf-8?Q?ViF20vIgy/mvbD1+2jSzXmv0pf58FqPe1udQvBa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdeb0d31-b267-4ddd-0bcf-08d903d7c262
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 08:39:06.8100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHwGnQa/mNEdt0/R061Ul58Z3qETjCXbHQGfbthlEckQxZHSol6v/VftyWo03Jirkt3rLAS2xH3OdrSE5zVXNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2981
Cc: pmenzel@molgen.mpg.de, Alexander Monakov <amonakov@ispras.ru>,
 Alex Hung <1917203@bugs.launchpad.net>, Jon.Grimm@amd.com,
 Shuah Khan <skhan@linuxfoundation.org>, Tj <ml.linux@elloe.vision>,
 will@kernel.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

RGF2aWQgLyBKb2VyZywKCk9uIDQvMTAvMjAyMSA1OjAzIFBNLCBEYXZpZCBDb2Ugd3JvdGU6Cj4g
Cj4gVGhlIGltbWVkaWF0ZWx5IG9idmlvdXMgZGlmZmVyZW5jZSBpcyB0aGUgd2l0aCB0aGUgZW5v
cm1vdXMgY291bnQgc2VlbiBvbiBtZW1fZHRlX21pcyBvbiB0aGUgb2xkZXIgUnl6ZW4gMjQwMEcu
IFdpbGwgZG8gc29tZSBSVEZNIGJ1dCBhbnlvbmUgd2l0aMKgY29tbWVudHPCoGFuZMKgaW5zaWdo
dD8KPiAKPiA4NDEsNjg5LDE1MSwyMDIsOTM5wqDCoMKgwqDCoMKgwqBhbWRfaW9tbXVfMC9tZW1f
ZHRlX21pcy/CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKDMzLjQ0JSkKPiAKPiBPdGhlcndp
c2UsIGFsbCBzZWVtcyB0byBydW5uaW5nIHNtb290aGx5IChlc3BlY2lhbGx5IGZvciBhIGRpc3Ry
aWJ1dGlvbiBzdGlsbMKgaW7CoM6yKS7CoEJyYXZvwqBhbmTCoG1hbnnCoHRoYW5rc8KgYWxsIQoK
VGhlIGluaXRpYWwgaHlwb3RoZXNpcyBpcyB0aGF0IHRoZSBpc3N1ZSBoYXBwZW5zIG9ubHkgd2hl
biB1c2VycyBzcGVjaWZ5IG1vcmUgbnVtYmVyIG9mIGV2ZW50cyB0aGFuCnRoZSBhdmFpbGFibGUg
Y291bnRlcnMsIHdoaWNoIFBlcmYgd2lsbCB0aW1lLW11bHRpcGxleCB0aGUgZXZlbnRzIG9udG8g
dGhlIGNvdW50ZXJzLgoKTG9va2luZyBhdCB0aGUgUGVyZiBhbmQgQU1EIElPTU1VIFBNVSBtdWx0
aXBsZXhpbmcgbG9naWMsIGl0IHJlcXVpcmVzOgogIDEuIFN0b3AgdGhlIGNvdW50ZXIgKGkuZS4g
c2V0IENTT1VSQ0UgdG8gemVybyB0byBzdG9wIGNvdW50aW5nKQogIDIuIFNhdmUgdGhlIGNvdW50
ZXIgdmFsdWUgb2YgdGhlIGN1cnJlbnQgZXZlbnQKICAzLiBSZWxvYWQgdGhlIGNvdW50ZXIgdmFs
dWUgb2YgdGhlIG5ldyBldmVudCAocHJldmlvdXNseSBzYXZlZCkKICA0LiBTdGFydCB0aGUgY291
bnRlciAoaS5lLiBzZXQgQ1NPVVJDRSB0byBjb3VudCBuZXcgZXZlbnRzKQoKVGhlIHByb2JsZW0g
aGVyZSBpcyB0aGF0IHdoZW4gdGhlIGRyaXZlciB3cml0ZXMgemVybyB0byBDU09VUkNFIHJlZ2lz
dGVyIGluIHN0ZXAgMSwgdGhpcyB3b3VsZCBlbmFibGUgcG93ZXItZ2F0aW5nLAp3aGljaCBwcmV2
ZW50cyBhY2Nlc3MgdG8gdGhlIGNvdW50ZXIgYW5kIHJlc3VsdCBpbiB3cml0aW5nL3JlYWRpbmcg
dmFsdWUgaW4gc3RlcCAyIGFuZCAzLgoKSSBoYXZlIGZvdW5kIGEgc3lzdGVtIHRoYXQgcmVwcm9k
dWNlZCB0aGlzIGNhc2UgKHcvIHVudXN1YWxseSBsYXJnZSBudW1iZXIgb2YgY291bnQpLCBhbmQg
ZGVidWcgdGhlIGlzc3VlIGZ1cnRoZXIuCkFzIGEgaGFjaywgSSBoYXZlIHRyaWVkIHNraXBwaW5n
IHN0ZXAgMSwgYW5kIGl0IHNlZW1zIHRvIGVsaW1pbmF0ZSB0aGlzIGlzc3VlLiBIb3dldmVyLCB0
aGlzIGlzIGxvZ2ljYWxseSBpbmNvcnJlY3QsCmFuZCBtaWdodCByZXN1bHQgaW4gaW5hY2N1cmF0
ZSBkYXRhIGRlcGVuZGluZyBvbiB0aGUgZXZlbnRzLgoKSGVyZSBhcmUgdGhlIG9wdGlvbnM6CjEu
IENvbnRpbnVlIHRvIGxvb2sgZm9yIHdvcmthcm91bmQgZm9yIHRoaXMgaXNzdWUuCjIuIEZpbmQg
YSB3YXkgdG8gZGlzYWJsZSBldmVudCB0aW1lLW11bHRpcGxleGluZyAoZS5nLiBvbmx5IGxpbWl0
IHRoZSBudW1iZXIgb2YgY291bnRlcnMgdG8gOCkKICAgIGlmIHBvd2VyIGdhdGluZyBpcyBlbmFi
bGVkIG9uIHRoZSBwbGF0Zm9ybS4KMy4gQmFjayB0byB0aGUgb3JpZ2luYWwgbG9naWMgd2hlcmUg
d2UgaGFkIHRoZSBwcmUtaW5pdCBjaGVjayBvZiB0aGUgY291bnRlciB2bHVlcywgd2hpY2ggaXMg
c3RpbGwgdGhlIHNhZmVzdCBjaG9pY2UKICAgIGF0IHRoZSBtb21lbnQgdW5sZXNzCgpSZWdhcmRz
LApTdXJhdmVlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
