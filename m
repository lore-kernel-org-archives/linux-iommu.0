Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A449FC433FE
	for <iommu@archiver.kernel.org>; Tue, 19 Apr 2022 14:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 393ED60B27;
	Tue, 19 Apr 2022 14:50:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yf2VQKcsM2vx; Tue, 19 Apr 2022 14:50:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DFBE260A9C;
	Tue, 19 Apr 2022 14:50:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8686C002F;
	Tue, 19 Apr 2022 14:50:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDBC7C002C
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 14:50:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9503960AC1
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 14:50:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qhd2zchF_1Jl for <iommu@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 14:50:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02on0610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe07::610])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5475060A9C
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 14:50:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CH5++Js03d0pPcjrSQSCXmkYwe5jP7fsnn+C16QHE5WmoZctrOUzrT2oJHVh7PH4XCDdz16Ssvh+DxQcaP2Gl/mws0vd6U1gz6DjbwuIz+K3eIwi+aabBiS642b1L67c7P9WvN9o+nZvlQimLU71tZgrijJsBNKmxnjOmxhZDII+2FPCLKS+UYt0NgJT5fz5g/O2WJ4sfCiYzOxdzQTam5BuXzSBsBuiW4EfoshgocmQBhh12OaKwayGF4RSIDhEYS8AFGDTl7DCEhSyp+Qmvwh1FeL4ONYOQwgFwvViN+v9eNEBR+jSM5duJbJPV07B0Hx7xr/mN7MX3Ez1gus0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOVdFqhb1TSaP98xnC2Ll9u+C7/D7kJX+oOl21Uo+Fc=;
 b=AZbwVWBWQW5/4U0owmC7D32ZzYrFo/a+uoF3Wci77FUOiEuISrRhXeymBUsXiXEa3n5KtOPsZm03qhms3MCb8LSVzuKEh8UTpIhUCMeyg778/YDHOXWdqNDKi0G0P26mSYlT2A7sJu4+zbFogKD9a2wQQD09rBydBpbOzWxdWSounvOS8HvsRWXibZuBe/lsaxiRhejMID/WjRN9Ji1twEnbf2gIWmWwloqH1QGzNnnRFhFGjI3DXoNYn8IB+M5OGb5RpIPtp1cU3qlPTJ6TWHQHiA0z2CN0pAS7+/NQoxXy+MCEyHDMR/JNec9+1yCjUNbr6ru4OJAy9yjk9UUCLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOVdFqhb1TSaP98xnC2Ll9u+C7/D7kJX+oOl21Uo+Fc=;
 b=AD/BzTH9IRKPI2wsXIBjyoHLx30c/vG4bdkuLY/uL+SI0qWxKTRAk+ru3wKYVCQhQnYRX2Tdsh20Ug2dYOEgRZs/R9hJCibXvSV2RKQIkyWOsRdXwYaYUBy590cGNfyXOq0o2TK6ePTEAzMpHahmB3z9evIC55DSWpt764SMLZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by DB6PR0401MB2584.eurprd04.prod.outlook.com (2603:10a6:4:38::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 19 Apr
 2022 14:50:51 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::8ce8:25aa:6242:b565]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::8ce8:25aa:6242:b565%7]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 14:50:51 +0000
Message-ID: <4086c5a8-f4a7-e477-e0eb-c304645a4144@nxp.com>
Date: Tue, 19 Apr 2022 17:50:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v9 00/11] ACPI/IORT: Support for IORT RMR node
Content-Language: en-CA
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
In-Reply-To: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
X-ClientProxiedBy: AM0PR02CA0212.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::19) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d19a9a8-98ef-4de3-22f7-08da2213ff28
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2584:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2584FC37910E34F6EA1819BBECF29@DB6PR0401MB2584.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: En8rN4BkfpBySBJpPW0IaTjVezwV3R9biH2XBmNpb34c5/dJnD1PmKA27qCo0Hi4SxamBMgOTtgFLYxlKRRlAitKC5qr0BIhnpf26V2U3gpbtkg8xjN3obSu54C43m0clrkYuKeDIyCqnJZHxrWBc8SbNpVV5uSl0JHzI9z+E7YDivtZEBnoCvDxgi+LCtSzpa+i0Cn8AZLKDWzeqpyw0c81Yz+5O3C+f/XK37C6XiZizp3VdsmvQtpZsnvF4t7Ii3uU5QaO92SD35hY5F3PbRpL9GPXuhARGQPaugUgKAiEjRHpqzis2gVAamo0fz1RTK92dw9WIl5i+0I+2jEwrfnPd+fvbZQHmedr5CxNgEDGdcsjw8k1nmPQsyTpbJ8gecZY/FwKvaVMqyPGBnGzY/1uL+PivWFDaYLLlVtg6DIJF0YDEEi399JGHQVa2MqYdTMBblaIBI/lDKPQcdJFI57QPIqiXyJ/rxT6O3AA60gk1KzJlD1yQ23KZhEo/nzOn1D6aHlQyXaQB5YTqqnMahbaHx0kqkZlqGYLc+3+cYHMmJwU3KFtpU0H7z8Gvx+WUx9vP+JiHgKQ7hKgJ+4AdtHsTERQJ20wCe0JMI2/ZhEKfkuaQlrXq/GDGzuTbnXYLe61L1HwsCBUBD5svQeRytrLstJeQIr18dn883wXm7M1zQK7lAV6SZ9ktgwhOgXqggRVC/ptPphivRLzJOcedBQhTEMgJcCKj88Z0HqPFd63AsgwC4VZGQ1OPjDXIdNdxkgEhFapGx1y+r+9t+g+UctB+VWOw+QcK5KG+W8nJM6KLuneQf91FCLDiLBRECfX1hygU0OjBDZQ+eRoNrwNwlEetcfgJemuOhU540D1niVp4W/4wBX10WgEnTb+tJqPhAwmWLa6ChS1Fde/1H6LDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR0402MB3405.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(186003)(6512007)(6486002)(966005)(86362001)(508600001)(8936002)(2616005)(44832011)(45080400002)(83380400001)(52116002)(2906002)(6666004)(55236004)(5660300002)(53546011)(6506007)(7416002)(31696002)(36756003)(66476007)(66946007)(31686004)(4326008)(8676002)(66556008)(38100700002)(316002)(38350700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmlaNzA3UEE1Y2xYTWxDcFFUVDNiRVZLTERTVGdmL1pLYUZXbjk4L0RrMHJD?=
 =?utf-8?B?bTlNamloSG54UUJzdWNwVDJUVERLUGNpZERNMmZpNmw2eFhaYmdYeDRjKzR5?=
 =?utf-8?B?Tnh5dVJPSWZPckNObnU0ejBsbDc0VzQwTHZhSmNjdndNeWpzd3BkeW1qYy8r?=
 =?utf-8?B?amlaUy9BWm5nbzlwZW9VM1NMcjBZNEVieGs0eThwWVNxWDdPaDcwTW5uNGdq?=
 =?utf-8?B?QlhTV0lpTTlnbWNTU21MV3FFWnBKdlo5TThtZUltc1Q1eGM1cXhXQ1RvMmta?=
 =?utf-8?B?NXlEVGNadWQxVk81UVN4WGVGQ0FIb013blpCRUZiWEI4RHUzQVl4MmVvMU9v?=
 =?utf-8?B?RDNxekp2d1JUU2FUNXVSQ0Y4SFpTSVZzU3pYSFJrWlBBd3JVUVFKTXdnVWUw?=
 =?utf-8?B?ckFrbDVqTFNSMHo3d2pqaVp6OGp0QWVPU3JGRmVrT0o4UFdUa3ArR29oWjFG?=
 =?utf-8?B?ZVU0SHNwQWVJUWxhVitRWERzL3dpbFBFUkZqcUt1MGZFbG1md2R0RkRSdUZy?=
 =?utf-8?B?Ui92djVMVHBKTUVvdWY2TWhta0IwY1JXejR1bUZQdVpGWEFFM1VMdHFuWlRr?=
 =?utf-8?B?MVd3MHNPY2R6c21BQnFpaEVnRk4vTnVRZUlMdXpHZWc5dWN0N1FZRUJBTnBQ?=
 =?utf-8?B?VlFmeXlhcEJ4MmM2ZUhGa0NFT2xZMjFMMDArRDVCNUFoc0c3WnUveXMzbUVo?=
 =?utf-8?B?Y2JuOC8va3ptOTZ6TWViVTQxS0JrVVVMcW05MG1GdnVIV1dIdy9HU1Bxc0N6?=
 =?utf-8?B?d1ZOV3NibWgrejhuTFlYY1g2UHNHbUk1N0d5UFVZZzVGa3JNaHgxK21PTDcz?=
 =?utf-8?B?N0c5R1A1dzJCZHNMSDBicVhQL0dlemZ5NDhXNExGbFgvSlRmanpyOGJDVHpW?=
 =?utf-8?B?M01VQzQ0ZWxwNXFhVkpkVjlManhRMjdQRStHSTNHNGVJcVU0dFZPU2h1WE1P?=
 =?utf-8?B?Tm9MdDRPSUdkWVhFM1NwS2ZYVng2b1pNeFBTdU1EZmRSQk9LaDIvSmtFL2pB?=
 =?utf-8?B?OG53dTlTY1JtQmFFOVo0dzVHVWphKzZOclhhWTZHWUZzTXYwVTFwend3azhB?=
 =?utf-8?B?QTgrL2F5eUJXZWdicVhPR2lGZWxyWTZHN0JKSlY5RjZ4dHZlazNuU0QyVitP?=
 =?utf-8?B?bGpzYkk2N1JhbkR6a1VvemFWaTNKLzYrdUxGWm1UR3N3T1hURktKdFlYZUNi?=
 =?utf-8?B?NFMyVHJoSkJ6V1FpK05uZFlJOG9VTG1lcDJWNkREdXBtMThWQVRiMHVmMmNp?=
 =?utf-8?B?blRRakpWbHpGbGFrYUlJOGNSSGtNRzZaZ2N1MkxYdlo0YXpJYjF6eklUenVM?=
 =?utf-8?B?dUN3V0M1ZXBUTzV4c0hLZ29ELytra2crSzZkNXpwbUVKckJNNXJvZENkREJV?=
 =?utf-8?B?WGtsUHRkUEZSOUFQZldhWUNxaERrZWlLNk11Rm9VRk1USlZWRWZqc0phN1ln?=
 =?utf-8?B?WDRNRUxkejdUSkMzZ3A3Q0I4blJEaFJROXlUU05tRzhQM2dxRDYyeitCd1JB?=
 =?utf-8?B?Q0xMMlZ0a1JPZVlvamxpRmJWeGd2Qmp0QXExbXJxMjRpVzRTQk1Wa3d2blRZ?=
 =?utf-8?B?RVVwd0JmZjZQL2JxbU1FWkgvZ0dMNFd3bWtEZ1ZRMzgxQUgraXEwMGt5ZEpn?=
 =?utf-8?B?dStwcEF5TUJaU0pqV2Y0T1ZVK2d0MzJWa3dndlkvVWxaTjRkSkdSMkJGSSs0?=
 =?utf-8?B?S1hMZVl1VndOUzdaV3NwNm4zWHpaMUNRVHV1YkdaYUhPWTUyTkJreUdqMFc3?=
 =?utf-8?B?K1NCaCtPWnF3YmFEbE1hbWUrWXZ1d3d4TnA3ZlF0T0p3WW1xL0NxT2J6Tlht?=
 =?utf-8?B?SmYwYmVRM0dSbC9ibkwvRDdJc2pmMkZjRk5reGN6Wmw3YkMyWHZNbGtsbEVq?=
 =?utf-8?B?TTZ6M1FraHEvOEZNU0ltTkdVRXo2bms3WisrVEpVRE1wSzJXaytXQlhPYitR?=
 =?utf-8?B?RWRsZktVanZ5VmJVWXNOcVhZY2NTcS82cUsvdGoyd2VPOU93VW50cjFjU09k?=
 =?utf-8?B?Ry9rL0ZNdzVwQm84YWlVbVlCbWcvU29DTXhRUUZ3RXZkNGxRNmhCQktNZG8x?=
 =?utf-8?B?SUkrbU5lalYzWGhMVk1WMThaZHFueVE0Q3JSOTZmQ0hZSnpVVUY1bDNwU29I?=
 =?utf-8?B?MjZPZlZTV214eUlWYmpkdm52QlFtekR5b2QwTm5Kdk1qYTRhaTZoeHRrZmRL?=
 =?utf-8?B?bVBYYmpkN2NjSjZPd2VKTm5ic2FxWGRWYUZRSVFDSmw2UDNSMGRJdDZpeFdK?=
 =?utf-8?B?N0NBaFE2S05IOENWWnN5ZUhidGdYay82UTdOVmdYSG4zV3pBRmxOdDVBVktt?=
 =?utf-8?B?OFppS3ZkWS81NC9vUVZhNkFjYmUreU9ic25aWjJtZVJkUUtpVEMrK0ljRDV0?=
 =?utf-8?Q?QX0CyNci7hTWlzaY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d19a9a8-98ef-4de3-22f7-08da2213ff28
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 14:50:50.9233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XN22h3IzUJyp5hL2mVOevlZKQNNJYMeI8lWrRhqCtVsfA1MoIR4h0vYQYvEkmNL3We+b/azPJQ0IUxqZ630NuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2584
Cc: robin.murphy@arm.com, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, guohanjun@huawei.com, yangyicong@huawei.com,
 Sami.Mujawar@arm.com, will@kernel.org, wanghuiqiang@huawei.com
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

SGkgU2hhbWVlciwKCk9uIDQvNC8yMDIyIDM6NDEgUE0sIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6
Cj4gSGkKPiAKPiB2OCAtLT4gdjkKPiAgwqAtIEFkcmVzc2VkIGNvbW1lbnRzIGZyb20gUm9iaW4g
b24gaW50ZXJmYWNlcyBhcyBkaXNjdXNzZWQgaGVyZVswXS4KPiAgwqAtIEFkZHJlc3NlZCBjb21t
ZW50cyBmcm9tIExvcmVuem8uCj4gICAKPiBUaG91Z2ggZnVuY3Rpb25hbGx5IHRoZXJlIGFyZW4n
dCBhbnkgbWFqb3IgY2hhbmdlcywgdGhlIGludGVyZmFjZXMgaGF2ZQo+IGNoYW5nZWQgZnJvbSB2
OCBhbmQgZm9yIHRoYXQgcmVhc29uIG5vdCBpbmNsdWRlZCB0aGUgVC1ieSB0YWdzIGZyb20KPiBT
dGV2ZSBhbmQgRXJpYyB5ZXQoTWFueSB0aGFua3MgZm9yIHRoYXQpLiBBcHByZWNpYXRlIGl0IGlm
IHlvdSBjb3VsZAo+IGdpdmUgdGhpcyBhIHNwaW4gYW5kIGxldMKgbWUga25vdy4KPiAKPiAoVGhl
IHJldmlzZWQgQUNQSUNBIHB1bGwgcmVxdWVzdCBmb3IgSU9SVCBFLmQgcmVsYXRlZCBjaGFuZ2Vz
IGlzCj4gaGVyZVsxXSBhbmQgdGhpcyBpcyBub3cgbWVyZ2VkIHRvIGFjcGljYTptYXN0ZXIuKQo+
IAo+IFBsZWFzZSB0YWtlIGEgbG9vayBhbmQgbGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cy4KPiAK
PiBUaGFua3MsCj4gU2hhbWVlcgo+IFswXSBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0
aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsb3JlLmtlcm5lbC5vcmclMkZsaW51
eC1hcm0ta2VybmVsJTJGYzk4MmYxZDctYzU2NS03NjlhLWFiYWUtNzljOTYyOTY5ZDg4JTQwYXJt
LmNvbSUyRiZhbXA7ZGF0YT0wNCU3QzAxJTdDbGF1cmVudGl1LnR1ZG9yJTQwbnhwLmNvbSU3QzJj
MTgwNTUxM2UwYzQ1MDkxOTQ2MDhkYTE2MzhhMzA2JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTlj
NWMzMDE2MzUlN0MwJTdDMCU3QzYzNzg0NjcyOTc1NDA1Njg4OCU3Q1Vua25vd24lN0NUV0ZwYkda
c2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dp
TENKWFZDSTZNbjAlM0QlN0MzMDAwJmFtcDtzZGF0YT1SMlJ3NEpLMXVnVE4xUUE0dW16TXVMVmVt
Mm9TOUJadWNidk5vWnFTSjNJJTNEJmFtcDtyZXNlcnZlZD0wCj4gWzFdIGh0dHBzOi8vZXVyMDEu
c2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpdGh1
Yi5jb20lMkZhY3BpY2ElMkZhY3BpY2ElMkZwdWxsJTJGNzY1JmFtcDtkYXRhPTA0JTdDMDElN0Ns
YXVyZW50aXUudHVkb3IlNDBueHAuY29tJTdDMmMxODA1NTEzZTBjNDUwOTE5NDYwOGRhMTYzOGEz
MDYlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3ODQ2NzI5
NzU0MDU2ODg4JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENK
UUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAmYW1wO3Nk
YXRhPTBhQyUyQndaWFBMNGIwWldJWHczVEd3RkUzTnFQVU1WSjNJYnBzeGVRRjh6dyUzRCZhbXA7
cmVzZXJ2ZWQ9MAo+IAo+ICBGcm9tIG9sZDoKPiBXZSBoYXZlIGZhY2VkIGlzc3VlcyB3aXRoIDM0
MDhpTVIgUkFJRCBjb250cm9sbGVyIGNhcmRzIHdoaWNoCj4gZmFpbCB0byBib290IHdoZW4gU01N
VSBpcyBlbmFibGVkLiBUaGlzIGlzIGJlY2F1c2UgdGhlc2UKPiBjb250cm9sbGVycyBtYWtlIHVz
ZSBvZiBob3N0IG1lbW9yeSBmb3IgdmFyaW91cyBjYWNoaW5nIHJlbGF0ZWQKPiBwdXJwb3NlcyBh
bmQgd2hlbiBTTU1VIGlzIGVuYWJsZWQgdGhlIGlNUiBmaXJtd2FyZSBmYWlscyB0bwo+IGFjY2Vz
cyB0aGVzZSBtZW1vcnkgcmVnaW9ucyBhcyB0aGVyZSBpcyBubyBtYXBwaW5nIGZvciB0aGVtLgo+
IElPUlQgUk1SIHByb3ZpZGVzIGEgd2F5IGZvciBVRUZJIHRvIGRlc2NyaWJlIGFuZCByZXBvcnQg
dGhlc2UKPiBtZW1vcnkgcmVnaW9ucyBzbyB0aGF0IHRoZSBrZXJuZWwgY2FuIG1ha2UgYSB1bml0
eSBtYXBwaW5nIGZvcgo+IHRoZXNlIGluIFNNTVUuCj4gCj4gQ2hhbmdlIEhpc3Rvcnk6Cj4gCj4g
djcgLS0+IHY4Cj4gICAgLSBQYXRjaCAjMSBoYXMgdGVtcCBkZWZpbml0aW9ucyBmb3IgUk1SIHJl
bGF0ZWQgY2hhbmdlcyB0aWxsCj4gICAgICB0aGUgQUNQSUNBIGhlYWRlciBjaGFuZ2VzIGFyZSBw
YXJ0IG9mIGtlcm5lbC4KPiAgICAtIE5vIGVhcmx5IHBhcnNpbmcgb2YgUk1SIG5vZGUgaW5mbyBh
bmQgaXMgb25seSBwYXJzZWQgYXQgdGhlCj4gICAgICB0aW1lIG9mIHVzZS4KPiAgICAtIENoYW5n
ZXMgdG8gdGhlIFJNUiBnZXQvcHV0IEFQSSBmb3JtYXQgY29tcGFyZWQgdG8gdGhlCj4gICAgICBw
cmV2aW91cyB2ZXJzaW9uLgo+ICAgIC0gU3VwcG9ydCBmb3IgUk1SIGRlc2NyaXB0b3Igc2hhcmVk
IGJ5IG11bHRpcGxlIHN0cmVhbSBJRHMuCj4gCj4gdjYgLS0+IHY3Cj4gICAtZml4IHBvaW50ZWQg
b3V0IGJ5IFN0ZXZlIHRvIHRoZSBTTU1VdjIgU01SIGJ5cGFzcyBpbnN0YWxsIGluIHBhdGNoICM4
Lgo+IAo+IHY1IC0tPiB2Ngo+IC0gQWRkcmVzc2VkIGNvbW1lbnRzIGZyb20gUm9iaW4gJiBMb3Jl
bnpvLgo+ICAgIDogTW92ZWQgaW9ydF9wYXJzZV9ybXIoKSB0byBhY3BpX2lvcnRfaW5pdCgpIGZy
b20KPiAgICAgIGlvcnRfaW5pdF9wbGF0Zm9ybV9kZXZpY2VzKCkuCj4gICAgOiBSZW1vdmVkIHVz
ZSBvZiBzdHJ1Y3QgaW9ydF9ybXJfZW50cnkgZHVyaW5nIHRoZSBpbml0aWFsCj4gICAgICBwYXJz
ZS4gVXNpbmcgc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9uIGluc3RlYWQuCj4gICAgOiBSZXBvcnQg
Uk1SIGFkZHJlc3MgYWxpZ25tZW50IGFuZCBvdmVybGFwIGVycm9ycywgYnV0IGNvbnRpbnVlLgo+
ICAgIDogUmV3b3JrZWQgYXJtX3NtbXVfaW5pdF9ieXBhc3Nfc3RlcygpIChwYXRjaCAjIDYpLgo+
IC0gVXBkYXRlZCBTTU1VdjIgYnlwYXNzIFNNUiBjb2RlLiBUaGFua3MgdG8gSm9uIE4gKHBhdGNo
ICM4KS4KPiAtIFNldCBJT01NVSBwcm90ZWN0aW9uIGZsYWdzKElPTU1VX0NBQ0hFLCBJT01NVV9N
TUlPKSBiYXNlZAo+ICAgIG9uIFR5cGUgb2YgUk1SIHJlZ2lvbi4gU3VnZ2VzdGVkIGJ5IEpvbiBO
Lgo+IAo+IHY0IC0tPiB2NQo+ICAgLUFkZGVkIGEgZndfZGF0YSB1bmlvbiB0byBzdHJ1Y3QgaW9t
bXVfcmVzdl9yZWdpb24gYW5kIHJlbW92ZWQKPiAgICBzdHJ1Y3QgaW9tbXVfcm1yIChCYXNlZCBv
biBjb21tZW50cyBmcm9tIEpvZXJnL1JvYmluKS4KPiAgIC1BZGRlZCBpb21tdV9wdXRfcm1ycygp
IHRvIHJlbGVhc2UgbWVtLgo+ICAgLVRoYW5rcyB0byBTdGV2ZSBmb3IgdmVyaWZ5aW5nIG9uIFNN
TVV2MiwgYnV0IG5vdCBhZGRlZCB0aGUgVGVzdGVkLWJ5Cj4gICAgeWV0IGJlY2F1c2Ugb2YgdGhl
IGFib3ZlIGNoYW5nZXMuCj4gCj4gdjMgLS0+djQKPiAtSW5jbHVkZWQgdGhlIFNNTVV2MiBTTVIg
YnlwYXNzIGluc3RhbGwgY2hhbmdlcyBzdWdnZXN0ZWQgYnkKPiAgIFN0ZXZlKHBhdGNoICM3KQo+
IC1BcyBwZXIgUm9iaW4ncyBjb21tZW50cywgUk1SIHJlc2VydmUgaW1wbGVtZW50YXRpb24gaXMg
bm93Cj4gICBtb3JlIGdlbmVyaWMgIChwYXRjaCAjOCkgYW5kIGRyb3BwZWQgdjMgcGF0Y2hlcyA4
IGFuZCAxMC4KPiAtUmViYXNlIHRvIDUuMTMtcmMxCj4gCj4gUkZDIHYyIC0tPiB2Mwo+ICAgLURy
b3BwZWQgUkZDIHRhZyBhcyB0aGUgQUNQSUNBIGhlYWRlciBjaGFuZ2VzIGFyZSBub3cgcmVhZHkg
dG8gYmUKPiAgICBwYXJ0IG9mIDUuMTNbMF0uIEJ1dCB0aGlzIHNlcmllcyBzdGlsbCBoYXMgYSBk
ZXBlbmRlbmN5IG9uIHRoYXQgcGF0Y2guCj4gICAtQWRkZWQgSU9SVCBFLmIgcmVsYXRlZCBjaGFu
Z2VzKG5vZGUgZmxhZ3MsIF9EU00gZnVuY3Rpb24gNSBjaGVja3MgZm9yCj4gICAgUENJZSkuCj4g
ICAtQ2hhbmdlZCBSTVIgdG8gc3RyZWFtIGlkIG1hcHBpbmcgZnJvbSBNOk4gdG8gTToxIGFzIHBl
ciB0aGUgc3BlYyBhbmQKPiAgICBkaXNjdXNzaW9uIGhlcmVbMV0uCj4gICAtTGFzdCB0d28gcGF0
Y2hlcyBhZGQgc3VwcG9ydCBmb3IgU01NVXYyKFRoYW5rcyB0byBKb24gTmV0dGxldG9uISkKPiAK
PiBKb24gTmV0dGxldG9uICgxKToKPiAgICBpb21tdS9hcm0tc21tdTogR2V0IGFzc29jaWF0ZWQg
Uk1SIGluZm8gYW5kIGluc3RhbGwgYnlwYXNzIFNNUgo+IAo+IFNoYW1lZXIgS29sb3RodW0gKDEw
KToKPiAgICBBQ1BJL0lPUlQ6IEFkZCB0ZW1wb3JhcnkgUk1SIG5vZGUgZmxhZyBkZWZpbml0aW9u
cwo+ICAgIGlvbW11OiBJbnRyb2R1Y2UgYSB1bmlvbiB0byBzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdp
b24KPiAgICBBQ1BJL0lPUlQ6IE1ha2UgaW9ydF9pb21tdV9tc2lfZ2V0X3Jlc3ZfcmVnaW9ucygp
IHJldHVybiB2b2lkCj4gICAgQUNQSS9JT1JUOiBQcm92aWRlIGEgZ2VuZXJpYyBoZWxwZXIgdG8g
cmV0cmlldmUgcmVzZXJ2ZSByZWdpb25zCj4gICAgaW9tbXUvZG1hOiBJbnRyb2R1Y2UgYSBoZWxw
ZXIgdG8gcmVtb3ZlIHJlc2VydmVkIHJlZ2lvbnMKPiAgICBBQ1BJL0lPUlQ6IEFkZCBzdXBwb3J0
IHRvIHJldHJpZXZlIElPUlQgUk1SIHJlc2VydmVkIHJlZ2lvbnMKPiAgICBBQ1BJL0lPUlQ6IEFk
ZCBhIGhlbHBlciB0byByZXRyaWV2ZSBSTVIgaW5mbyBkaXJlY3RseQo+ICAgIGlvbW11L2FybS1z
bW11LXYzOiBJbnRyb2R1Y2Ugc3RydGFiIGluaXQgaGVscGVyCj4gICAgaW9tbXUvYXJtLXNtbXUt
djM6IFJlZmFjdG9yIGFybV9zbW11X2luaXRfYnlwYXNzX3N0ZXMoKSB0byBmb3JjZQo+ICAgICAg
YnlwYXNzCj4gICAgaW9tbXUvYXJtLXNtbXUtdjM6IEdldCBhc3NvY2lhdGVkIFJNUiBpbmZvIGFu
ZCBpbnN0YWxsIGJ5cGFzcyBTVEUKPiAKPiAgIGRyaXZlcnMvYWNwaS9hcm02NC9pb3J0LmMgICAg
ICAgICAgICAgICAgICAgfCAzNjkgKysrKysrKysrKysrKysrKysrLS0KPiAgIGRyaXZlcnMvaW9t
bXUvYXBwbGUtZGFydC5jICAgICAgICAgICAgICAgICAgfCAgIDIgKy0KPiAgIGRyaXZlcnMvaW9t
bXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMgfCAgODAgKysrKy0KPiAgIGRyaXZlcnMv
aW9tbXUvYXJtL2FybS1zbW11L2FybS1zbW11LmMgICAgICAgfCAgNTQgKystCj4gICBkcml2ZXJz
L2lvbW11L2RtYS1pb21tdS5jICAgICAgICAgICAgICAgICAgIHwgIDExICstCj4gICBkcml2ZXJz
L2lvbW11L3ZpcnRpby1pb21tdS5jICAgICAgICAgICAgICAgIHwgICAyICstCj4gICBpbmNsdWRl
L2xpbnV4L2FjcGlfaW9ydC5oICAgICAgICAgICAgICAgICAgIHwgIDE4ICstCj4gICBpbmNsdWRl
L2xpbnV4L2RtYS1pb21tdS5oICAgICAgICAgICAgICAgICAgIHwgICA1ICsKPiAgIGluY2x1ZGUv
bGludXgvaW9tbXUuaCAgICAgICAgICAgICAgICAgICAgICAgfCAgIDkgKwo+ICAgOSBmaWxlcyBj
aGFuZ2VkLCA1MDUgaW5zZXJ0aW9ucygrKSwgNDUgZGVsZXRpb25zKC0pCj4gCgpJJ3ZlIHRlc3Rl
ZCB0aGUgcGF0Y2hlcyBvbiBhIE5YUCBMWDIxNjBBIHdpdGggU01NVXYyIGFuZCB0aGluZ3MgbG9v
ayAKZmluZS4gVGhhbmtzIQoKVGVzdGVkLWJ5OiBMYXVyZW50aXUgVHVkb3IgPGxhdXJlbnRpdS50
dWRvckBueHAuY29tPgoKLS0tCkJlc3QgUmVnYXJkcywgTGF1cmVudGl1Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
