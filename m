Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B297C43334
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 01:26:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9B6BF403F9;
	Wed, 15 Jun 2022 01:26:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vDfC9_bvewkX; Wed, 15 Jun 2022 01:26:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 48F114002B;
	Wed, 15 Jun 2022 01:26:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27C45C0032;
	Wed, 15 Jun 2022 01:26:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A27FC002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 01:26:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3A5504184E
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 01:26:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TUOGpkr0RFZl for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 01:26:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::618])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4EA98416F7
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 01:26:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAUgsEnh6gzrb/O4K5DVQYAtfZvF0Ier0UxibDj1HbjXOueaI3WUbv+h0i2F0pO/HwnzgZRARu2DSU7nolMiJP0be9iGeEGG2Ov9P5MSzGtBxTjSvqvhsGN+i0sik2tp/iUxNByFJCu1+Erm3Gfa+MAdMu59yF5eUqiGDMvXPkFY9rtAFThlPc8kdg/4edKnwdi2hnNlWFRxtZd1t0TFQjUi8NfKaQR076zukVyD7+FuI9cbD3Gr9xMGH/Y8X/0Q5Q2yJyfL+jCCR0BKWc54xk2FOCjkjaIcSuedleYJS/+8HNetV1SkHKzuX+cSamyvai4T03cvHa6bnCzNNJWUMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcz/zrSe9Hx3ILkM/NKZNmvWkvfPwJpW9QRoIgF7bDw=;
 b=QjV1AVeTz2dQ8NyOINSspB6RSQfj8wZEEsc8JkKD68UMFtotuJQeh93uEaSNpEdGM9bYTn47eYLoNEvza5z7e/nCcwXbdUE955iO2nkl0JLj/6kDXmvoMYRlCk73haHscW/ZSYabCiU8R/DCIwcc9TBCBqNsSOss5Qi+8t7tftvEeN87IFKegJfDRRzJtA/C5sGOxPBxEPX9t69WQNoxfWxhAEiCAdWo8Qw0Rfifzoz32f4LC4OozGGv08QE5nJn+KBC943/rXdArRr3AZeibs7uXJDS99wBP32lZsrl1WH/CXoGPJsMAZPbkN3GmLt+SHGpXgYYk55c2zwkrOeuqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcz/zrSe9Hx3ILkM/NKZNmvWkvfPwJpW9QRoIgF7bDw=;
 b=dIMQsfm931w6jKGRr4JhTrvIOVhLCQaXrKOpm+fLbL2ZLcCP2sQQs/pLQ75/u7HUV9q2ncdJjkslH3PacfLVr1zidm4yfnN8LYDcJFA76eY6MPHu/TRlol9KjErQRvXxBGRAVuueqWYBTTqx2hupj1D3eZmEcXQ6MaCjUazgw+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM4PR12MB5183.namprd12.prod.outlook.com (2603:10b6:5:396::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Wed, 15 Jun 2022 01:26:06 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::14b:372d:338c:a594]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::14b:372d:338c:a594%7]) with mapi id 15.20.5332.020; Wed, 15 Jun 2022
 01:26:06 +0000
Message-ID: <f5b6b25a-9153-4bcd-a150-d3339ed5831f@amd.com>
Date: Wed, 15 Jun 2022 08:25:57 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/7] iommu: Add domain_type_supported() callback in
 iommu_ops
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org
References: <20220613012502.109918-1-suravee.suthikulpanit@amd.com>
 <20220613012502.109918-6-suravee.suthikulpanit@amd.com>
 <371cacea-368b-d722-8360-13c229b3112b@arm.com>
 <b6d64153-9dc4-372f-8c2b-a844199d3cb6@amd.com>
 <9a984e22-6624-e4ea-689b-7e37094c5b87@arm.com>
In-Reply-To: <9a984e22-6624-e4ea-689b-7e37094c5b87@arm.com>
X-ClientProxiedBy: SG2PR02CA0062.apcprd02.prod.outlook.com
 (2603:1096:4:54::26) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c369636-2a12-4353-f2de-08da4e6e0490
X-MS-TrafficTypeDiagnostic: DM4PR12MB5183:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB51834CEFA57CCCFE9425D801F3AD9@DM4PR12MB5183.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ar2ySbpiQ3DBa5rsnUn6MdMoosTGllgJ30d/KXRKjsOn+KM0J68XAb4iCtOzgIl4D+TR3skf7Es+apIh0Z42H8d7XrGY4VORBCI9+BunroqpDb6G6KSC6s0MxxeXTf30sqRCToElPDWXIgtZbz5Q6+mKWaT57UZoau6lA29wP3AyDZ2KClJqd4r7ZwNbH0/9V1e2iZIhia6YQRjGt0zf5/Crwr8qNfoPPak5Vdk3IhUMwssYh1C6dxvup0MR0hNJwaDhnGpKXJQE/68opyiVjyG84up/DKbNNdb/3bdwwsncM6chQ7EGZISaWe3XltbkPT+Q6drjLiNP7GyQoBujiPKq99zdNJHhE2FbsmPIUOUlf3MXZ60VsdeUCUPLz4QfMDdw0/sXp1pSMuw2FGBMMkKlXmsBsov73gcrQKEkEFJfwGod1RN1Sk6XsHjn23K1Nt0eccsWRafWkSNy/iTriLhVz7lvBccdiC8G7iaerB+4K4DNSIERODyR18mNDkvQ8NDCXfkRZHh35l/ICWyuKuJHli5+F2t4DiUhyfrdn2A/otoTEE41g3MT/+ZP0fV9DzjXH8qNvScTjDuwTjLil7FmPMLFVt9/MGSain9V9LSCfyT3L5RdMcv0/EOpMDxyy5Xw3jfar8TMoDlzLU7+iKb+LadCPLzJ6quRQE+YT3feDfVrCFcQW4p9ETUcNsJVLXvRmvmJuufp6qrwU+rvN351Xbg9iU43pRl/PylOEvdLuVRaKvandfLZZLoRc5Zc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(186003)(5660300002)(2906002)(38100700002)(31696002)(2616005)(6512007)(6666004)(26005)(53546011)(86362001)(66946007)(66556008)(31686004)(8936002)(66476007)(8676002)(36756003)(83380400001)(508600001)(4326008)(6506007)(316002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UExnVEQ4Kzc0QndKMlZjWWdHWFJRVzFCQ1BEbXZhY2JxQUJHeGIveGk2NTJh?=
 =?utf-8?B?blNyZk5ibk9meDE4b3hsNHJnVkJHVFcya0ZMaGozb0tZWWhmRUNyVndvQ3Rk?=
 =?utf-8?B?Z090TkxhSVQwKzRSSGc0R2Y0MEYwd1Q3N3V2clpQZkQ5OHB0Wno5bktUOTdU?=
 =?utf-8?B?bTVqVnZua2hGMlg2dTNUdlM5MG9mRkhPSEJ0YnhPMG8rMFNWc1l5REl3QlNE?=
 =?utf-8?B?MFlnbGM3MytwY0xnUTY2UEJYaFEzU3Z5YkEvdnRGbGQyWXRmYU5SUHhlekd5?=
 =?utf-8?B?Y2hDOEdOUkdxTms5TmlxVTYxdUlQUGNSVWlXaDE1TzRQRFg5SzZqcDVjWXZa?=
 =?utf-8?B?R0wzelFZN245LzYxTGU3Y09qdVNMZGdJaWRtQUxWNnpNeFB4Y1A2bmVOTXQ5?=
 =?utf-8?B?Ny9tZ0JvamNNQkErN3hWK0VZVHlSVTJEdzZmTHlmS3VTRkNwK3h1eEhNV0Zn?=
 =?utf-8?B?aUxOZVZJZU5STUh4YXhwWm84ZHRuUHlicmlhZkRDTFRBdzJWbDFNUHFuaWdH?=
 =?utf-8?B?dGJKdndXNVdlYUI1aWhzZkxwN2IvWk1MQ1psUm1HcDdjYVc0RkFWb0ZoRTd6?=
 =?utf-8?B?Ry9vdTN4RUtKVU5KYS9OM2lGcFBDaGw5U0ppa2cwcXdqR3BUeDUvQWVGTVRL?=
 =?utf-8?B?VENkVDhWMlJjMDFZb2NiNitSaGF5c21rNmNxT3hSNXl2ZFY3RnlXR1U1eEgw?=
 =?utf-8?B?S2JCN0p0QjZlNWxYVVVWclZrbjJVU09pRlZNM0JYY1NoMTVCOElsWU9GOWIz?=
 =?utf-8?B?V0lrZVpIdWYyT29PVTBHbHh2a2kva3R5T2hLT0Jkb0hTb25wMGQwdytWS3Uw?=
 =?utf-8?B?c2FZTjZodWZaZmowWWRMbVhSaTNwQ0ZURUMwRXRGRlhSZVd5Z1FsTTd6Uk1C?=
 =?utf-8?B?VU5FbHJaNk04aEVxUWdtdVhCMXgxUzUyUmRMeHhLdy9pS2FEM3FvUjEwTUhu?=
 =?utf-8?B?N0lEK3B0bzdQR0lmeXoyVkxKMm5YR0hqeUZ4Z3NOL0lwQTVXQVprNmlQamdL?=
 =?utf-8?B?dSt3ajg4R0I3VTNKUnp5b3NSZUxPbE8vZklLUTFWSWxGUmpwOTM5Um9iVVkw?=
 =?utf-8?B?UXlYLzhLQm4wOTRaRmxsdmxVeVFISHFENUlYb3NHNGk4UGtINjBvUFpIcFRu?=
 =?utf-8?B?bDNaeU1NYjZ1ZlUrSGliVmxvWC84WkUwclB5Q2lzTjM3UlFPaEVLdUpxdXhw?=
 =?utf-8?B?dE9yVnpNdnFjdWtMbjl6VE5DV1dyS3dzdVFINlJXeEZWYzVUZFV5VFpLaHUz?=
 =?utf-8?B?MW4ySHMwTjhpVEU3Q2ZxT0d0UDg0NGRNZW9NZ2xKZ0NNVkd5T3ZDZEpCRjZG?=
 =?utf-8?B?aVVCRWRBRERIZmF1VWJ0bUFwUW81YjhKYnA0N0QrTG0rQ3RpVXBNYXNNY1dN?=
 =?utf-8?B?OWhYS1FudmNuNzhwN2x2VUluV3pNMGFJZlFOeXo4b3ljSmM3ZmExS0EwTnZm?=
 =?utf-8?B?OTl6SUtqZ1VsSTdHVHR0NGZBMjVraWp2bnQzQUt3OFVCTG9yMkZIWnpqYVBM?=
 =?utf-8?B?UXRWbk5vYUdqcXZsRm5vU2tzNk9VTGtZOUlKTk5yd05Kbm9OSGV6aXg4QzNt?=
 =?utf-8?B?ZGEzQm5KaHVGTlBINEVrc3dQY2N1VFdEMkhnYnQveFU4R0J2QURwTDVhaXAz?=
 =?utf-8?B?N3UyWi9iSFdtM05LOHhFTWV3dDVaMDZIUnEveDFVOE0zaVZDZDFTY2NsUmpF?=
 =?utf-8?B?cXBKZjd4ekp4eTREcG94NzY1ZG5DbnNtVEF0NjNFWHJkQnN0dExHTk4zVUFh?=
 =?utf-8?B?amcyZkRYcmJLd015VmlXR1p4a0k4ZklNZ0doQXdhOWErZTlQaFNUQTBFNmlQ?=
 =?utf-8?B?OGZGTDZHbmtMTXY4SzF3cFgvQk82bE9NVmpQelI1ZHliQXRTenU3RnNhdkRC?=
 =?utf-8?B?cDZqd1J2WEpNTEN6bDdxbUdrTkkzSDN5a0lkUmNkUUhFbCtoemlQTE9TNDZM?=
 =?utf-8?B?YzJQZCtpaHV3eldVWnA4NjdPU21yTTdYS003akFSN3d5ajREU0ozRzd3M1pB?=
 =?utf-8?B?cmJiVXllY3VYWnVERDhDSm9kVllvUDlvd2cwM0lGdWVPMVhidlZqT3M0aW1X?=
 =?utf-8?B?YTJQVTBlVE9DdHFjWWNibFlhRDdvZS9GN0gwUFY2dGpKejQ5V1pzNU9Dalo4?=
 =?utf-8?B?T0p5enJ5Rm1wRUNac3Vja1NSeTUybTJwS1RYTTZZMlB6dUlpeTRiSk5GQWEy?=
 =?utf-8?B?U3BaUHQ3U0FITSttRWdJNk54WmFQWVIxaGhmSWN5Tk1uY2VhaEoybVhyZElF?=
 =?utf-8?B?Q1VkNnYrVUF6MmJYRnlzc2VwYStBdHdzbTZXdGtMZ0N5djlqM2w1MTBJTW9m?=
 =?utf-8?B?VlVidkw5dXVTVmgwdmFwZWs2RUZKR29TT0t5MnVrRC9zUjBJZ0N0dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c369636-2a12-4353-f2de-08da4e6e0490
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 01:26:05.9604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6mSgtGD0FZ67ztIygEAXpfkfdaQojllaOEoO3Ev/8R3U+kvsobcxXGiEfXuck+T4cJ0jh7+F1cl8alfKshp2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5183
Cc: ashish.kalra@amd.com, vasant.hegde@amd.com
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
From: "Suthikulpanit, Suravee via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Um9iaW4sCgpPbiA2LzE0LzIwMjIgNDo1MSBQTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIw
MjItMDYtMTMgMTU6MzgsIFN1dGhpa3VscGFuaXQsIFN1cmF2ZWUgd3JvdGU6Cj4+IFJvYmluLAo+
Pgo+PiBPbiA2LzEzLzIwMjIgNDozMSBQTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+Pj4KPj4+PiBJ
bnRyb2R1Y2luZ8KgY2hlY2tfZG9tYWluX3R5cGVfc3VwcG9ydGVkKCnCoGNhbGxiYWNrwqBpbsKg
aW9tbXVfb3BzLAo+Pj4+IHdoaWNowqBhbGxvd3PCoElPTU1VwqBnZW5lcmljwqBsYXllcsKgdG/C
oGNoZWNrwqB3aXRowqB2ZW5kb3Itc3BlY2lmaWPCoElPTU1VwqBkcml2ZXIKPj4+PiB3aGV0aGVy
wqB0aGXCoHJlcXVlc3RlZMKgdHlwZcKgaXPCoHN1cHBvcnRlZC7CoFRoaXPCoGFsbG93c8KgdXNl
csKgdG/CoHJlcXVlc3QKPj4+PiB0eXBlc8Kgb3RoZXLCoHRoYW7CoHRoZcKgZGVmYXVsdMKgdHlw
ZS4KPj4+Cj4+PiBOb3RlIGFsc28gdGhhdCB5b3UncmUgb25seSBhZGRpbmcgdGhpcyBpbiB0aGUg
c3lzZnMgcGF0aCAtIHdoYXQgYWJvdXQgdGhlwqAiaW9tbXUucGFzc3Rocm91Z2g9IsKgcGFyYW1l
dGVywqBvcsKgQ09ORklHX0lPTU1VX0RFRkFVTFRfUEFTU1RIUk9VR0g/Cj4+Cj4+IEZvciBTTlAg
Y2FzZSwgd2UgY2Fubm90IGVuYWJsZSBTTlAgaWYgaW9tbXU9b2ZmIG9yIGlvbW11PXB0IG9yIGlv
bW11LnBhc3N0aHJvdWdoPTEgb3IgQ09ORklHX0lPTU1VX0RFRkFVTFRfUEFTU1RIUk9VR0g9eS4K
Pj4gU28sIHdoZW4gYW5vdGhlciBkcml2ZXIgdHJpZXMgdG8gZW5hYmxlIFNOUCwgdGhlIElPTU1V
IGRyaXZlciBwcmV2ZW50cyBpdCAoc2VlIGlvbW11X3Nldl9zbnBfc3VwcG9ydGVkKCkgaW4gcGF0
Y2ggMykuCj4gCj4gVWdoLCBJIGhhZG4ndCBsb29rZWQgdG9vIGNsb3NlbHkgYXQgdGhlIG90aGVy
IHBhdGNoZXMsIGJ1dCBhbiBpbnRlcmZhY2UgdGhhdCBsb29rcyBsaWtlIGEgc2ltcGxlICJpcyB0
aGlzIGZlYXR1cmUgc3VwcG9ydGVkPyIgY2hlY2sgd2l0aCBhIHNlY3JldCBzaWRlLWVmZmVjdCBv
ZiBjaGFuZ2luZyBnbG9iYWwgYmVoYXZpb3VyIGFzIHdlbGw/IFl1Y2sgOigKPiAKPiBXaGF0IGV4
dGVybmFsIGRyaXZlcnMgYXJlIGV4cGVjdGVkIHRvIGhhdmUgdGhlIGF1dGhvcml0eSB0byBhZmZl
Y3QgdGhlIGVudGlyZSBzeXN0ZW0gYW5kIGNhbGwgdGhhdD8gVGhlIGZhY3QgdGhhdCB5b3UncmUg
ZXhwb3J0aW5nIGl0IHN1Z2dlc3RzIHRoZXkgY291bGQgYmUgbG9hZGVkIGZyb20gbW9kdWxlcyAq
YWZ0ZXIqIHYyIGZlYXR1cmVzIGhhdmUgYmVlbiBlbmFibGVkIGFuZC9vciB0aGUgdXNlciBoYXMg
Y29uZmlndXJlZCBhIG5vbi1kZWZhdWx0IGlkZW50aXR5IGRvbWFpbiBmb3IgYSBncm91cCB2aWEg
c3lzZnMuLi4gRnVuIQoKSSBzZWUgeW91ciBwb2ludC4KCkN1cnJlbnRseSwgdGhlIGZ1bmN0aW9u
IHRvIGVuYWJsZSBTTlAgd2lsbCBiZSBjYWxsZWQgZnJvbSBTRVYgZHJpdmVyIHdoZW4gaXQgdHJp
ZXMgdG8gZW5hYmxlIFNOUCBzdXBwb3J0IGdsb2JhbGx5IG9uIHRoZSBzeXN0ZW0uClRoaXMgaXMg
ZG9uZSBkdXJpbmcgZnNfaW5pdGNhbGwoKSwgd2hpY2ggaXMgZWFybHkgaW4gdGhlIGJvb3QgcHJv
Y2Vzcy4gSSBjYW4gYWxzbyBhZGQgYSBndWFyZCBjb2RlIHRvIG1ha2Ugc3VyZSB0aGF0IHRoaXMg
d29uJ3QKYmUgZG9uZSBhZnRlciBhIGNlcnRhaW4gcGhhc2UuCgo+PiBJbnN0ZWFkLCBpZiB3ZSBi
b290IHdpdGggaW9tbXUucGFzc2h0aHJvdWdoPTAsIHdoZW4gYW5vdGhlciBkcml2ZXIgdHJpZXMg
dG8gZW5hYmxlIFNOUCwgdGhlIElPTU1VIGRyaXZlciBhbGxvd3MgdGhpcyBhbmQgc3dpdGNoIHRv
IFNOUCBlbmFibGUgbW9kZS4KPj4gU3Vic2VxdWVudGx5LCBpZiB1c2VyIHRyaWVzIHRvIHN3aXRj
aCBhIGRvbWFpbiAodmlhIHN5c2ZzKSB0byBJT01NVV9ET01BSU5fSURFTlRJVFksIHRoZSBJT01N
VSBuZWVkcyB0byBwcmV2ZW50IHRoaXMgYmVjYXVzZSBpdCBoYXMgYWxyZWFkeSBzd2l0Y2gKPj4g
dG8gU05QLWVuYWJsZWQgbW9kZS4KPj4KPj4+IEFGQUlDUyB0aGVyZSBzaG91bGRuJ3QgbmVlZCB0
byBiZSBhbnkgY29yZS1sZXZlbCBjaGFuZ2VzIHRvIHN1cHBvcnQgdGhpcy4gV2UgYWxyZWFkeSBo
YXZlIGRyaXZlcnMgd2hpY2ggZG9uJ3Qgc3VwcG9ydCBwYXNzdGhyb3VnaCBhdCBhbGwsIHNvIGNv
bmRpdGlvbmFsbHkgbm90IHN1cHBvcnRpbmcgaXQgc2hvdWxkIGJlIG5vIGJpZyBkZWFsLiBXaGF0
IHNob3VsZCBoYXBwZW4gY3VycmVudGx5IGlzIHRoYXQgZGVmX2RvbWFpbl90eXBlIHJldHVybnMg
MCBmb3IgImRvbid0IGNhcmUiLCB0aGVuIGRvbWFpbl9hbGxvYyByZWplY3RzIElPTU1VX0RPTUFJ
Tl9JREVOVElUWSBhbmQgYW5kIHJldHVybnMgTlVMTCwgc28gaW9tbXVfZ3JvdXBfYWxsb2NfZGVm
YXVsdF9kb21haW4oKcKgZmFsbHPCoGJhY2vCoHRvwqBJT01NVV9ET01BSU5fRE1BLgo+Pgo+PiBU
ZWNobmljYWxseSwgd2UgY2FuIGRvIGl0IHRoZSB3YXkgeW91IHN1Z2dlc3QuIEJ1dCBpc24ndCB0
aGlzIGNvbmZ1c2luZz8gQXQgZmlyc3QsIGRlZl9kb21haW5fdHlwZSgpIHJldHVybnMgMCBmb3Ig
ImRvbid0IGNhcmUiLAo+PiBidXQgdGhlbiBpdCByZWplY3RzIHRoZSByZXF1ZXN0IHRvIGNoYW5n
ZSB0byBJT01NVV9ET01BSU5fSURFTlRJVFkgd2hlbiB0cnlpbmcgdG8gY2FsbCBkb21haW5fYWxs
b2MoKS4KPiAKPiBZZXMsIHRoYXQncyBob3cgaXQgd29ya3M7IGRlZl9kb21haW5fdHlwZSBpcyBy
ZXNwb25zaWJsZSBmb3IgcXVpcmtpbmcgaW5kaXZpZHVhbCAqZGV2aWNlcyogdGhhdCBuZWVkIHRv
IGhhdmUgYSBzcGVjaWZpYyBkb21haW4gdHlwZSAoaW4gcHJhY3RpY2UsIGRldmljZXMgd2hpY2gg
bmVlZCBpZGVudGl0eSBtYXBwaW5nKSwgd2hpbGUgZG9tYWluX2FsbG9jIGlzIHJlc3BvbnNpYmxl
IGZvciBzYXlpbmcgd2hpY2ggZG9tYWluIHR5cGVzIHRoZSBkcml2ZXIgc3VwcG9ydHMgYXMgYSB3
aG9sZSwgYnkgYWxsb2NhdGluZyB0aGVtIG9yIG5vdCBhcyBhcHByb3ByaWF0ZS4KPiAKPiBXZSBk
b24ndCBoYXZlIGEgcGFydGljdWxhcmx5IG5lYXQgd2F5IHRvIGFjaGlldmUgdGhlIG5lZ2F0aXZl
IG9mIGRlZl9kb21haW5fdHlwZSAtIGkuZS4gc2F5aW5nIHRoYXQgYSBzcGVjaWZpYyBkZXZpY2Ug
KmNhbid0KiB1c2UgYSBzcGVjaWZpYyBvdGhlcndpc2Utc3VwcG9ydGVkIGRvbWFpbiB0eXBlIC0g
b3RoZXIgdGhhbiBzdWJzZXF1ZW50bHkgZmFpbGluZyBpbiBhdHRhY2hfZGV2LCBidXQgc28gZmFy
IHdlJ3ZlIG5vdCBuZWVkZWQgc3VjaCBhIHRoaW5nLiBBbmQgaWYgU05QIGlzIGV4cGVjdGVkIHRv
IGJlIG11dHVhbGx5IGV4Y2x1c2l2ZSB3aXRoIGlkZW50aXR5IGRvbWFpbiBzdXBwb3J0IGdsb2Jh
bGx5LCB0aGVuIHdlIHN0aWxsIHNob3VsZG4ndCBuZWVkIGl0LgoKVGhhbmtzIGZvciB5b3VyIGZl
ZWRiYWNrLgoKU3VyYXZlZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9t
bXU=
