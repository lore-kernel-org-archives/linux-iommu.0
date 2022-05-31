Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E6CC433F5
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 15:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CFF083FF6;
	Tue, 31 May 2022 15:59:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PilHFBsY8vqY; Tue, 31 May 2022 15:59:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A725083FF3;
	Tue, 31 May 2022 15:59:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DF86C0032;
	Tue, 31 May 2022 15:59:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96291C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 15:59:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7E9A9417E7
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 15:59:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AIMp0aJobmUk for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 15:59:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::631])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 97F0C417E4
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 15:59:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hB6bMUtfEHGYrdQvfmONJ5u01h5OKKkU3XgQ/L2HUEdN4c9PsShRmrbX8CNK+Qjg0tcUrI5qjBiZvvYevciNKi15kuAaksGSmNo4aZtxOymVdEq6phhhKXaWyrQloa5vp0e656gdJyeqZ4kvVN7OVdU+HrDTQh2h7BzJ6SRa8/HrVa1De6Q37tv6UCDZ1hhJpAbxFcdgK4FeK6XmB3FEB8LBGIHW8NDP1dnuEwqSDUnjoUnLebBxmyH1eXk+t+miLNuSkiIIvbqFS/eO0imr9+Au8z7+NqEXrCXoCL4dhE8RYBnmhuL7Wpe4Oe1ltFiP6h3zuXKZcO58FqGDqIo1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7CeqyMG66SAGO16LSNszkZXO4j3V6e7XBzodLqnIwE=;
 b=hxAzlSXX0I+NNntloefk7EN+RM0xmmKfKyry+JXSXJLY74BbKqO5u9Azi1GjXT//qOFh15ye+yYidXBENebaRvQiB4r+WX3JO4w12DaaU/jXdLgAHKLjHIUwb3/DGqXfeKLhSd5Z9LsnmRzNDTyqQokWJJoeyz88V7kVQ/XhtziUchRaNTy94SAdhd53DF3yGILSP73ocbStjFgB2nEeLZLDW+W1z1Yz88PrOrHXAk5xJHy59V1rRNKs8zFHg0thBHBMbWWxgbqv9W4k4ijCPBtrjXFqXWCqGrSTUrouAc/olGZF4WILOlM+mrJW5RhJt4wuOyhtLKfrEcvbgA6wLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7CeqyMG66SAGO16LSNszkZXO4j3V6e7XBzodLqnIwE=;
 b=NfTTZyqroxWgT5YgOJRd2bHQ+bLM2g7POj9ULhhlLagouE8DG9BwSGy3UswYUyyboOJz/ZbuRiuMPtioNSqJuMSJ1VIjSvtF+hCfhZPCdVrgaiN1alTMPvQV+/QzHRD/9QhhhtiLmV8SO/WRvERU1gc3wBTScHlrz0tDJ+r1qGHm2fC7A1skab5KWnoJWT2B/ubgvWUB73XVCbf8b5Gj/blqvjW6496/QxufnVdZuEjbw5ZYVP0qmfAG/vP4h+iO+7UTsxspdDm3poD/Lsc8jcVQpWz7RCZph9rn9SB+cuHODrXnd3QByd8IAvwguSgmnMlIO//o9gmgGLgU5m1+mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1534.namprd12.prod.outlook.com (2603:10b6:301:10::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Tue, 31 May
 2022 15:59:06 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%9]) with mapi id 15.20.5314.012; Tue, 31 May 2022
 15:59:06 +0000
Date: Tue, 31 May 2022 12:59:04 -0300
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Message-ID: <20220531155904.GA3726345@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-2-baolu.lu@linux.intel.com>
 <20220527145910.GQ1343366@nvidia.com>
 <eda4d688-257b-d12a-56c0-0f9d3a10ef8c@linux.intel.com>
 <20220530121412.GX1343366@nvidia.com>
 <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
 <0b7bd793-a3c7-e7e7-8ef0-214dd5b98f05@arm.com>
Content-Disposition: inline
In-Reply-To: <0b7bd793-a3c7-e7e7-8ef0-214dd5b98f05@arm.com>
X-ClientProxiedBy: BL0PR0102CA0007.prod.exchangelabs.com
 (2603:10b6:207:18::20) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a307f1e8-2323-4d98-833e-08da431e7d7a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1534:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB153464E4E9CAED81922825DBC2DC9@MWHPR12MB1534.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V2DHnXs7kRfOpmgu8rui1Ndu7f9poWXty2Ejo3s5EBYf5zazHL0izzHTYbc1NNixHMfH71fy9dAgNYukUJVsAJ+Le/fnStJziInagESJsQH0VG1ymEhHQxt0rGRjkvw1MHE9bUR/hP5kridWAu9GV5gBKj4tPvgQwEtrLapoDXF+4B7aNAUvQY0zLi1v+9ajIOWKUM2yLsPCNhWlVxb03qVNzyy6qt6EVKJv+a/e80VcMVxusOkUmfEe5Aw8AcGq+E6NLL3G+LCVzzUZC0OJSPtPuv+Sk72JfSImg4QI/ItPxZ7DhW8yxv6oHBDV0fk+IQj8eKr/fK3M/zc6+R+p0mQr4jkzOEfd0w8v3AZ8stUGfY5O8ipT7akq4b8+eHt9Ix8zTUY2NjTwksiIE2BUpPkcUejnPc3GbgLPjADTI7hkdoCjijqHDOs8IlWsLM9VzOk9dA6MRfzT6LgcMIWsW2eUFPyYgn2ebHEkxH7imREG0nRnquF66TIMC+zaTiGefCSW05TZB9meuArWnBVD5Ty+mNKPX6ChT5fZhS8LFMBVVyfuHs54lOgC40yTrWyBY7l01S7kpBPa4fEaOtVqWM0zn5OBil3nsfWp8dnTOmc5Jt3xhEXYsyLfxx+RPNS4nm3pkKPJzFARyhr/5CLaAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(6506007)(66946007)(66476007)(4326008)(66556008)(8676002)(186003)(5660300002)(6486002)(33656002)(508600001)(4744005)(83380400001)(8936002)(2906002)(54906003)(36756003)(316002)(6916009)(38100700002)(1076003)(2616005)(26005)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y24wS3Myc2E1QTRuNERCYjlobTB3U2srTWFwb3Y1dGh4RkpiZ1hXSUpCNWZo?=
 =?utf-8?B?WTZ2dHdMa3J6N21rNkZLbGZ6dHhXczJkNCtDVmE2WVF4b1dqZG02TGNFcWM3?=
 =?utf-8?B?UzQvalZMU1pkMTVibS9Pd0NsTE9KWWp0VEV5N0VJbk9uek9GY1NMNTRjSFVy?=
 =?utf-8?B?aURtQnFWcnE0a0lXdnhXdUROYzlURFhzbDdKZHBGTy81MS91c204SUFVTVVu?=
 =?utf-8?B?dkhicFBXRTlqTVZTeUlycDd4V1d5WnhYdU1PV2R3dU0yVnE3bE1lWVluYTFy?=
 =?utf-8?B?RzRPK0FaTjlFN1o2Rzk4aEJNdTVIcGtwSTNrZzcrNFVMWHdGVlRjT1pXanNl?=
 =?utf-8?B?blkyWTl0dmRaK21jY0hUTmNKYWYwVWFLclVqNVlTUGt5ZUYvMWF6RHBwaW42?=
 =?utf-8?B?aHNuWjB4UjFOOHNhVUtYNGVobGgydzQ5STRJeFhuWHFvTW9UdVY0RHdQa0Ur?=
 =?utf-8?B?aFdXQW1uZ3d6blcwNy8zRHlpRzRIa0FvT1JtYm40QWJIakxoaENiK1d4ZjN0?=
 =?utf-8?B?b24rT0NxZHZ5TEw3Yms4cUhQNnNHTjdiNmhVTDhkN25zVFlhMFNralBZYzZB?=
 =?utf-8?B?MStpaFNMY2hPSzNOb2sySXE4RXYxL1dkOVk0STdmVnlOcnNpNHYwWjk2UW1Y?=
 =?utf-8?B?bmMyc3JzQzUwS0RDYnl2M1pvdzRZRExPeStkbGJlc2p3dGZWbHJxVEw3WlRq?=
 =?utf-8?B?M2FnTHlVbVo2ZnAwblRWWmtVbFNRR0FtNTBTN3owMU9Ud1grZEJlRzY2UFNZ?=
 =?utf-8?B?NWpKdDhvZFdQRE9CcGhTRTJVbm5FcEIxUDY0cFFKYWZ1QUpIVFozc0xkWnZX?=
 =?utf-8?B?Nm5XdXVBVE1jL0NqTkxCbzlmZTA3cHo2dm9pYTFCMzdiSE9aWjFCOUZITHZ1?=
 =?utf-8?B?NTlqSHZGalBjektESFZ6WXJYYzhaYlF6dHp0UEF4T2FoYkkxSmRETkhSeXc4?=
 =?utf-8?B?VGc0bTFqTzRKa083WEZ5eHRpQ3VtVlgrMUdMTHlBU3l2ekJBSFg0VVVvTWJM?=
 =?utf-8?B?aENLamZEdjFiNFNyeDhXdXEwL29XUEtTb01PMWVCZHdjMm80K0NwRGlldXp4?=
 =?utf-8?B?QjV6allVaHRXYkdUOW05VVNnYkIyVlp6bEIrelVxRW4yRlJoVklPeTNqZ0p6?=
 =?utf-8?B?cExmTjhsVitUbldwekdpLzhVME9DZkNuRDZZL1pjLzJHVjFBRTZDcE1hdklx?=
 =?utf-8?B?Q2dPRDhVMC91b2JXM0J4U2lZc2haeXB3UHV6bkZVYTVYb0F0NFJ5bkYyVmJy?=
 =?utf-8?B?dmQ1ZDd2bXRaRll6RE1BUU81M0xTMXFBSlVtZXg0Tm9kN3Jhd0psUzNndC9N?=
 =?utf-8?B?ZlRNT1l6Uk5hQXlpc21ObG4rRXdxdmE5RVhXek1sdm50VGhvTG93VTg5NmlU?=
 =?utf-8?B?bGMyVWdIcWl4U01iNVRqN1AxdVp0dWh1VGZlZ05qR3VTcE16bWdxekx6Sm1I?=
 =?utf-8?B?bkltdlVpaVpLeDlCQVQ0MXZWNkY1N0JoeFA0OU9FdFVCYUdIdzhvOVlIRlJD?=
 =?utf-8?B?bHZYcjZnTDdYUFhpMFFSQS92ODhrQXl4M1phTDJLdWpIQlFBNU41WWdMU2I0?=
 =?utf-8?B?WlNaTGI1Uk1pd2x6bC9RZnlBdTRoM0FoYTB6UC9lZHFxbjU4M0hVSHZaTERV?=
 =?utf-8?B?R0FCTXlxb0VYdnRKWGZLbWJvdTIwWklDOFVPZko4Z25QaU5nejZlcFhoZWtn?=
 =?utf-8?B?QStvMStiU0hVb1d3ZDZpN3pESmZrdEF5Y2ppdVE5bFRYR2pEeUxjbVB1N3pk?=
 =?utf-8?B?TE8zQXdzZ256WjBQL2JiRThjcWJKeHFqVzhvM2xOS0RhNUloVkNSTTVOYkJw?=
 =?utf-8?B?ajJETHNGQUcxd2Qza0JTcWphS0tJMVRKYXVkcUNzbEJ5SCs0ZitkVWNhb3VL?=
 =?utf-8?B?NFQ1TmxCN3pjdEFUV2tiVDFubytYUWJBSkxJNmZmU09MVkZ3TUdwZGYwdHkr?=
 =?utf-8?B?L2ZYS29jVXprSlJFL2FuaGV5dmN6U0hPMEV1bytBcUVCOWh5ZEx0NHlNeE95?=
 =?utf-8?B?N3RjUW5JS3h1dTFRVFE4dUdCcGpwRkNWK0pJa1IzM3VQMHpyYTN4Qm5ESHNl?=
 =?utf-8?B?VDkwYlI2RERSZ05XSjZleTRxS2xFb25jNjFxc1FwenQ3S2VlTmgrOE4vTFpY?=
 =?utf-8?B?K3psN1lVMlgzUmJ4N2c5ZmpYVEhxT3d3dnRld2x3Y2dqV3VXMUhhR0VlZWg5?=
 =?utf-8?B?RzBQOW9WN3NHOWtzTFNDNm1lRWIzckp4UUxwUFNhRnA2aU1HdE9DczFnVFZD?=
 =?utf-8?B?azBRQXhwTVFJQkduTHJ3eWEwZFl0bnRVdjYrV3ljVHY1dXNIRjVINURNTEQ5?=
 =?utf-8?B?YW1FajNDY0RyUmRXeGQzOEZYcDltU0Y5V1FOMjB0ZUJmK3YrcDBSUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a307f1e8-2323-4d98-833e-08da431e7d7a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 15:59:06.0700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jq75xuf991s5r2XM1eajtpQsgXPFNZLvSh1iDRmkEtgdUZ70/HUKFaoCwH7T8w+S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1534
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Will Deacon <will@kernel.org>
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gVHVlLCBNYXkgMzEsIDIwMjIgYXQgMDI6NTI6MjhQTSArMDEwMCwgUm9iaW4gTXVycGh5IHdy
b3RlOgoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBwZ3RhYmxlX3dhbGtfbGV2ZWwobSwgcGh5c190b192aXJ0KHBo
eXNfYWRkciksCj4gCj4gQWxzbywgb2JsaWdhdG9yeSByZW1pbmRlciB0aGF0IHBmbl92YWxpZCgp
IG9ubHkgbWVhbnMgdGhhdCBwZm5fdG9fcGFnZSgpCj4gZ2V0cyB5b3UgYSB2YWxpZCBzdHJ1Y3Qg
cGFnZS4gV2hldGhlciB0aGF0IHBhZ2UgaXMgZGlyZWN0LW1hcHBlZCBrZXJuZWwKPiBtZW1vcnkg
b3Igbm90IGlzIGEgZGlmZmVyZW50IG1hdHRlci4KCkV2ZW4gdGhvdWdoIHRoaXMgaXMgZGVidWdm
cywgaWYgdGhlIG9wZXJhdGlvbiBpcyBza2V0Y2h5IGxpa2UgdGhhdCBhbmQKY2FuIHRoZW9ydGlj
YWxseSBjcmFzaCB0aGUga2VybmVsIHRoZSBkcml2ZXIgc2hvdWxkIHRlc3QgY2FwYWJpbGl0aWVz
LApDQVBfU1lTX1JBV0lPIG9yIHNvbWV0aGluZyBtYXkgYmUgYXBwcm9wcmlhdGUuIEkgZG9uJ3Qg
dGhpbmsgd2UgaGF2ZSBhCmJldHRlciBjYXAgZm9yICd1c2Vyc3BhY2UgbWF5IGNyYXNoIHRoZSBr
ZXJuZWwnCgpKYXNvbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
