Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458D2C433F5
	for <iommu@archiver.kernel.org>; Wed,  5 Jan 2022 14:06:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD16260BA9;
	Wed,  5 Jan 2022 14:06:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cZhxw2NdnXuK; Wed,  5 Jan 2022 14:06:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8CE85600B4;
	Wed,  5 Jan 2022 14:06:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61D0EC0030;
	Wed,  5 Jan 2022 14:06:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C34F4C001E
 for <iommu@lists.linux-foundation.org>; Wed,  5 Jan 2022 14:06:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A97758197D
 for <iommu@lists.linux-foundation.org>; Wed,  5 Jan 2022 14:06:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D7yP8RNYnAEl for <iommu@lists.linux-foundation.org>;
 Wed,  5 Jan 2022 14:06:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8996381919
 for <iommu@lists.linux-foundation.org>; Wed,  5 Jan 2022 14:06:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3A/5yEV18vP9qFXD39vfgHT7hYdphN1QtWFzCKT8ebzZ47VMDzX+bhH2P3M5d5AztyKcieBMFHDr3CPSUTL11gMkkpLfAL7Rbxh5QeyQoQ7i5qacwps8x76dM6s/2Hbu03HkmfkR/GTkUZcR+aaoACuimw55NIX42EGrj+C4rj2+pNZ9Gn05o8OTcCs7Q/widf31kq9EPVUonTc6Ke5IiBbFyDcvaksDun73+TLiH3TGo4kTcp15T8LPrA5ghLW/WGhnwEKA2HeXFhmI6WTtltzq9ixnCL9Wpy9r7X85eiy+oIoLaFqXebcC0iTAMGb0Ki89dgP3VgSfv7B/JUnHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8GiX1j1wqHVyZmVwXdC7Hf9ks5OW+yxzJqapOUp3bo=;
 b=cKshSqt8NLNycdxsnfJ6dw8LH4u9rqmcMq9MXZwG+54inA3CBWdlyhve1grqYqfYlZzRUgioKYm9fcvaB6p7Emf2jaQ5ujGgB8ScuYpSkv8N1OQXeJGTZyAdmrOhxCI/BRFRj5VCD1wewIyit9S8p+ILEHiV0LL/Rsm9CvpWG0yztqw+HyT3rPAMgem95MCI2O7kH9OTB5SwWsp8253+WbMysr9UwDdyzmmOddnw6gxb7vraOwkndb+ob1MpLW+3vJsRHuCVTf/MZtGDjgg3q9M2nNPIaiMc18Tt3WQu5qWdaTSgu0qH0qaiMNyHgUJ5l6LLR7rKG50JrYYt+DzLdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8GiX1j1wqHVyZmVwXdC7Hf9ks5OW+yxzJqapOUp3bo=;
 b=B9uXwkMrTduIaRnltwl68nadc2PaNrLFqeL7/jP74yJX2OpDeJkke704vV72TYjjZ4oRwO91gc4GAa84uktKe6XZNN6Oum7eehKQ8U5CO9fd8O89eFL8itb17p1IesfIt3HCz1/pDdche0lkHSafSCYy3VypC9xPF17vM30dN5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM8PR12MB5493.namprd12.prod.outlook.com (2603:10b6:8:3d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 14:06:13 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2429:24de:1fd2:12c5]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2429:24de:1fd2:12c5%7]) with mapi id 15.20.4823.023; Wed, 5 Jan 2022
 14:06:13 +0000
Subject: Re: Memory clearing in swiotlb_update_mem_attributes()
To: "Kirill A. Shutemov" <kirill@shutemov.name>
References: <20220104224939.yhpceiuzqqhb72ql@box.shutemov.name>
Message-ID: <d16046ad-7828-a015-b6a3-3ed01ed15bac@amd.com>
Date: Wed, 5 Jan 2022 08:06:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220104224939.yhpceiuzqqhb72ql@box.shutemov.name>
Content-Language: en-US
X-ClientProxiedBy: CH2PR17CA0016.namprd17.prod.outlook.com
 (2603:10b6:610:53::26) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b5833f7-12f5-4840-5817-08d9d05487d3
X-MS-TrafficTypeDiagnostic: DM8PR12MB5493:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB5493400EB0A96D4E89E914E5EC4B9@DM8PR12MB5493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1nNx5bH+R+I74pR98A/O9RCd1jVQTaCfFuc7uTIYbtqytwquFDsjMowMMyO3e4afxB2PhxCGO62EKAuPlydloYD5HqD2AIg4Y9A4/3PstjXuSTaLGm3Ly4VYfetl2onELnnn4wMLEnIqp8PTWkJO9Z1P9llQczRhkqqflB8F+57BQ3nFdV62RQ7bZ4GLVUbArNDMPh6OUHtFJ+gwmPw4PLKYXz8lPnk9P7Yv2Nh1F6W2NB+4P70+JjgZXigP7fSIul5uDX+zK5lODe5bkreopPz3b07Miljy7YXUTatIQIV0ahabFHHoBAI7O+cQtq2FzRnK2AjfHaME5WdLzJY3Tv402QqVw4GS+5H+8SqeS5LgwXKmZTrVxGnC6PQ801HwJPYyl5bqWXzxmb3lpMP4K6srKR2QfKtT5xbUCwHzue1ZJXV9HtsweeQJbEcM+7qQ+uvEvqS+e7AXz2H5BFA135/TIXmM9CV8AeS+ztSGs6QgaDxO5R+ZVbQwrPBp9bBxLbPxij5aS/GRYIaxI6qt5YDLz3q0vVTu4henOIjIcTxtpXyzACDiI5falupuxJLJ1XtWMjn0K9BAdr2oPwUF9ZCqIB/e35RIOaV26Ugamc3rzlnQc5sGjxm4CGv33OaCvPguhggrQ/sr182u9hlm9AGN/3y/FZFtlM2DUT8Rlc150I1YxwJTCVvp4SLjz1m91WxM+Wos6Q2aOz2ldgqqPyI2AgnfDKH0uKuEpMrJHTo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5229.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(38100700002)(36756003)(8676002)(31686004)(83380400001)(4326008)(31696002)(6512007)(316002)(5660300002)(6506007)(2616005)(53546011)(6916009)(6486002)(4744005)(66946007)(66556008)(26005)(66476007)(2906002)(8936002)(86362001)(186003)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anowbVpxdXhHalQ1VVdmSXFEc0FvU25wUVpZczVmM1IzM01zMmZwaTYrRG5x?=
 =?utf-8?B?MHVycjJaNHFWd3dJM2xUQXBJQVJ3a0ZyYXB5ajEzS3hCV1A5MVF4M2l2WDFn?=
 =?utf-8?B?Nkg5dFVDeC92TnNyRWZoZUxKb2lJWFJJTzh3YUtITDVNVzFGeUY5NVRWK1VV?=
 =?utf-8?B?T0NGNWJDSW1idzQ1UE56YU9XbytZNXFnNDdkS2phK3l6LzU0RXJXSTVYdkdI?=
 =?utf-8?B?N0RXSDNmQmtPTmdTQTk3b0xaclMxcGRrRk9oZ2kzRkp2R1JkekhBU0VJSFBZ?=
 =?utf-8?B?ZGtid3BrN1U5YlB0R1VLRFlkZ2VPc1krVENUTkoyaUdjZ2dkR01za3BISnRi?=
 =?utf-8?B?M1VvYkp1WkxrN1JJVVFGVkFUMU0wVC9yRnB4RU1vK1kyYVhaTDJ3dEtENmpl?=
 =?utf-8?B?MWVOeWlVcUxib3c3M1NGalpjam1jYUVnQXFxZWllU2ZpanRaKzJnSmRPcFZz?=
 =?utf-8?B?SmxtVUxWejNkK21jZlU2Vjgwc09RdncyM2ZTSVZQL1JMTnNJalZwd1JtL2hj?=
 =?utf-8?B?d1VySzYzbWl4L2pHVjM0YysvN28vY0RIOHV4K2RlYytNcG10aVRjSDR2Ynda?=
 =?utf-8?B?cVdETHh2ZU4wdVBBekRrMEZnZ1dvTmx4WGs0RTIzYVQ4Qi9reWsyY1loWUFq?=
 =?utf-8?B?RkRDelRHUlBoczVVYll3WlhKalJsTUNqdUpkc3dmWXFpT3lTTmIrakp1Tllk?=
 =?utf-8?B?M1FVZThaTTBDV0tVelpEVUlDMi9uaXVTZSt2NlRROHA1TE1TVEhERGIvaEtI?=
 =?utf-8?B?blRRWlRDb3cxcVg3cFY4dkxoTmQ5bm5QRU5TaTIrSzdCK2EyMnFraER0NVFy?=
 =?utf-8?B?Qnk1TCtMeUR2TXVBMHRzQWk0VitMMU5WN05EVG1mVFhnaENaak1iOEJtTE8w?=
 =?utf-8?B?YXdaWkJVWENQMS9Pa1FyZUdqb1RGNXhpQlhaSXMrZTdodkFXNEtGRGtxSnhQ?=
 =?utf-8?B?dFgxUFBFRWhSNGJVTnQwQzVsRjliSEVydllhd3VpbXdmOUFiS0Z2b2Q3Tzdr?=
 =?utf-8?B?S3BDR3ZlMVBWRkZad29BOUt1MmtFbWRGVEU2cW9HbnNnSTY3MnhGYkgyeUxM?=
 =?utf-8?B?OUhyNGk1SzRrRXdHdG1aT1RxNXRUb01nNFFtUHB2VkR2aTVnZjhkcTMzU3F2?=
 =?utf-8?B?dEV3dVpQQ3B1RDR4UXdPTVpwSG9WUDBqcnhaV0RKVklDV3BlQmloK0VvQkZN?=
 =?utf-8?B?d045dkNMU1huMjVtVGN1ZHp4SDR0UUx5RzNBM3hSazZFNi9TVllkRGZpcHds?=
 =?utf-8?B?R2lvMnpWSG4vZmRyOU1kUWZKdmRUQTNnMll0Y252WDdaamlQbFplRnNFQlpo?=
 =?utf-8?B?eVM1NTJPQ1JUSGZjMlgzcTZCbTJpZnNhMks4dVdZT3dSaWlhTXZwbTRTeTlr?=
 =?utf-8?B?cWVkNk1OalBNbldWcHNSWTNOV3Z0UFdwYjlyVDJnOHU3OFZDZ0ZTek41R3V0?=
 =?utf-8?B?ZE03TFRoSjdoZGZJdGtkc0Z0ZzJaMXRoWTNHU2NTMmJsQVkwWGR6QXJrM3NT?=
 =?utf-8?B?UWIwV3JSMHVKOUZJTVpZSkcyMGJOWnpKM21oR2xpNHhpeDdReG9tRmJUVUJo?=
 =?utf-8?B?TXZTdFQwNmNxM21oZVpEUmFqMnFjc0lOOWJBTm1ybXluVGZEZ2pSbjcwT1Bx?=
 =?utf-8?B?OVdBZVNYWHVlbW1mZlBiOU5vRDN5emJZbkg5M3dIZkVJYUgvdlJreGhKcXRZ?=
 =?utf-8?B?TU5TamxYQ1JOSW9VWFdBb29SS0ovWENUdGsrVzNsSnJrd2xKK0hIMXUxaEo3?=
 =?utf-8?B?YVR3bm5tR3hYYjBObkNFM1Q3ck4rUEtrVSsyOFdzMlhrZlE5ZXRwZVNHN2xU?=
 =?utf-8?B?YVFOK3NDbnpNQzVkMnQwQ1A5cjB2dkErdytSb1FzeXJQRktGditxaXV4SzRa?=
 =?utf-8?B?d24zbEJjalZLVHhGVjczYk5YbjdaS01LVndyVHZQVmtEU3VPUC9ZQndWVjNW?=
 =?utf-8?B?V0xSMXpKd0NTZ09idnJYa2RQNHo2MDRWL0NiSTVhRHQxWU1DS0FxdjJDb09N?=
 =?utf-8?B?b0hTZS96amR6YndsSzZSdmpNbjAwKy8xOFFBRWloa2JKa0RsNGl6MlQ2UFps?=
 =?utf-8?B?UzZqdm1hdU93Mm0zNnF1UGp5Y2lNUndVdENRRlc4Y2ljaFd6cjd3akhxMnNz?=
 =?utf-8?B?TVpML1RPWUFpbERIQnIvWVl1TjA5RU14THFTaUxMR3puNy85SUExVGQyVlNj?=
 =?utf-8?Q?X597lvJ0udlG4z9l6ZO2ekc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5833f7-12f5-4840-5817-08d9d05487d3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 14:06:13.0802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RR3wPbAHInv2X+4FqkI9gGMERqHJoFBp7hbOJtA34+F4Mr+rOSokn3ovC3H2DJOP2VSVt1kkPDNxpenGUCjzyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5493
Cc: Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org
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
From: Tom Lendacky via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Lendacky <thomas.lendacky@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 1/4/22 4:49 PM, Kirill A. Shutemov wrote:
> Hi Tom,
> 
> For larger TDX VM, memset() after set_memory_decrypted() in
> swiotlb_update_mem_attributes() takes substantial portion of boot time.
> 
> It makes me wounder why do we need it there? Malicious VMM can mess with
> decrypted/shared buffer at any point and for normal use it will be
> populated with real data anyway.
> 
> Can we drop it?

Probably more a question for Christoph. Does SWIOTLB need to be 
initialized to zeroes? If it does, then the memset after the 
set_memory_decrypted() is required, otherwise it will appear as ciphertext 
to SWIOTLB.

If I get some time over the next couple of days, I can also try and test 
to see what happens.

Thanks,
Tom

> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
