Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22718C433F5
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 09:55:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3EF8605A5;
	Mon,  6 Dec 2021 09:55:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gSQDMOVTD7ES; Mon,  6 Dec 2021 09:55:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6D8CC605D2;
	Mon,  6 Dec 2021 09:55:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD6CFC002F;
	Mon,  6 Dec 2021 09:55:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E440AC0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 09:55:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C5288605C4
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 09:55:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QgQIwayUgmtF for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 09:55:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2080.outbound.protection.outlook.com [40.107.100.80])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1E3BC605A5
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 09:55:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBkYViaiGnbDzfoTvkz7SrsvEsiPoXjYqNkVqLkOdf18b/rYFPzDs8WlQXYj7SrErRpi8OlaYilCPZjrvgnCgK/OdpRBTQA8/KVFqkfrBJBGsO9ceeQgYYEBitHlVzERSxbU6uzlfCZnzjL5uH0WJEifBgn9OVqW7PUIl+b2ABFHocME7Wu/bskR6i0waxW79fgnYVu6FYEnnyDq3LcI7egMxo+mmnDvxkDx9lODq0JlRvtqLlNyDGvoO4pZv9TQq6j2vTvr7TDmZFOFR07mBhipt8NLJC4YcpHbZ0liNZ+WBMzA64vHx9gCLv5nLa3u/OYHWxNFdE8j63qoiuNozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QTjCuoHORsIaYoDA38EAYujltYQA5bCxi4W2CzFP50=;
 b=gM6MCu7eplmoNDBHzJQU9YB7JmFd89URusbcDPqxusDFzNlIIBIurAtE2++Kl5iwprPdtYxC6SqKnYdQ2Ey+k6hAKdWL2ppON+XoaOf//F+yP2Um9NI/1o/giKx+UWXuLy/qxnGVkwPM7N17y5po+kEKad3xSQ3d0QwGJUaMjBAsaw1ePQIQs94PJNQulduYKoddsVAPfwv2KpdJk3uTQJbD7tdyzhPMqproKO1mbtNXRdZwaBIhzwyRxo/ExRtg8rl0CtjKRE08P41sEjh1apTrnxbwuSjRVAviLyrvOBifFym/u1i2MGledAAhkR5UUHkh8Ue0K8wGU9j4tv+Uwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QTjCuoHORsIaYoDA38EAYujltYQA5bCxi4W2CzFP50=;
 b=kNps0xHo7R2Nd4LFsEgK08J0qS+VhJ3lCoCgzgTr/V4gG81Pe198IbRRxtRcKAp9o34pYnSgq5xZ63TsLGLgxZ2+cLPIAa6lQdBx7Ex4hzprJl+kz12D9tUIy0L1CeXW/jqrqnUzJ8xZAPPYOZEkxlk4t53w0ctRU8TWDiBaNa1BQtxgsjEaaniiTcRFRrNR+O63wqXpQ9e0yhmSyK51EmLoP7045Bt1QV5sH2WdT74LNPLInZbPMJp05Tr9YRsEvM1Xx/xsd6DugX58RKf2igq4jQ4GkCLvNG8zCuSTymB9LZ4FkMZjkjvPNEOf1JN/D5iCXZJS280Hi5HQGF2Dvw==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CO6PR12MB5457.namprd12.prod.outlook.com (2603:10b6:5:355::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Mon, 6 Dec 2021 09:55:19 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ecac:528f:e36c:39d0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ecac:528f:e36c:39d0%5]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 09:55:19 +0000
Subject: Re: [PATCH v2 0/8] Host1x context isolation support
To: joro@8bytes.org, will@kernel.org, robh+dt@kernel.org, robin.murphy@arm.com
References: <20210916143302.2024933-1-mperttunen@nvidia.com>
 <10de82cf-27a5-8890-93a5-0e58c74e5bcc@kapsi.fi>
Message-ID: <c382fb0e-6b73-5ca0-7f63-d2843351325e@nvidia.com>
Date: Mon, 6 Dec 2021 09:55:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <10de82cf-27a5-8890-93a5-0e58c74e5bcc@kapsi.fi>
Content-Language: en-US
X-ClientProxiedBy: VI1PR07CA0283.eurprd07.prod.outlook.com
 (2603:10a6:800:130::11) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
Received: from [10.26.49.14] (195.110.77.193) by
 VI1PR07CA0283.eurprd07.prod.outlook.com (2603:10a6:800:130::11) with
 Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Mon, 6 Dec 2021 09:55:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0ed521c-f8a8-4317-5592-08d9b89e82d6
X-MS-TrafficTypeDiagnostic: CO6PR12MB5457:
X-Microsoft-Antispam-PRVS: <CO6PR12MB54574CC72F3FB1535F0CB7BCD96D9@CO6PR12MB5457.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kUdvvjnWnYGJffYlgouwPVkuIeReDOsiQXuDRXHyDW93Idoj5O7JFMW8jZ0Eod23MRcVoD1j1J6K+PZliJHpune8Q6Ihegjcx5GXx9KGW5Sc0h++tbaKLKAUdU21aF4SuevjLEGbZT8/sab/lRvCcndxl6HgUcvEWQiIgZID5Ah1D5AijrViOGUx/hQn2CxEwiP0AOwutxYpMVj74VciW49gx1gTToRvW1ZGGSThnb30PamEuKH9ucsVqYXElZBrhbxLdbOu2Aj8JdtP13zcpYJLFcR25KQbIo4bO0OHL/S4Iqxx8pvSY+6aRvVIyT+erYroCAXRyG7+OqGLemr48ExK3tN9JkNQQNWY0IPVxpPtl+ItRkNXQ9z5SOUTAuCGEHJ/O8VU8Yr61Pf1JqZn/xhpToQy5UIYQo/StibPiKWEAXc9CEFfvL+zaSFzQ0xW0aZj3kD2Y0vsFjv1KFkWh7gzl76ciHfi4YTv9UvW92b70LyprstAOgoRSKTSQzYnXeTe577x7UJUhMiR7zh7cWyzZYhfds4RoAS75g0QtGNTluNmAFM5Lq5yqrVsih2kiBeaw1scWZ0YrfhK7q8Xsc36UzY7v/0q9VfoO746rGZeqXnryfZUz01LL0EL0tC8WeAQDIepMusoEboNmlWjX3ihKV3GeWRChDovOQ64p1oq33+Fobl430I9Ffw4JGSl1QDZ7mTxuKQSPheM9YFYELQzPkkyuA573GUOvgrgGQgBAVNadux8CC6jKXhvgHgxyvwppWFHkC0hzDGdj3/aHhBGXs8nNP7ouurQWGPO69g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5444.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(66946007)(83380400001)(38100700002)(6486002)(956004)(2906002)(36756003)(508600001)(2616005)(31686004)(66556008)(31696002)(8936002)(66476007)(8676002)(55236004)(316002)(4326008)(16576012)(7416002)(54906003)(53546011)(6666004)(26005)(186003)(5660300002)(32563001)(45980500001)(43740500002)(357404004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm9PZ3IvNXBnUVdVcG11NXRZYnFWeXZCT01QSUVadFBlVUZhZ0dEcGJVY3ho?=
 =?utf-8?B?NDJHSURJVzZjKythK04xcVNoNGtHVFdiMUkxTkhWQkFzS1FGOGdRc3BnOFhT?=
 =?utf-8?B?R2xENmVSQURhYm1VVkdqcVFaV2hXMVRMck1xejFCK2FjeXlzQStGdnNPcjIr?=
 =?utf-8?B?V0RlYXMrazVsZ0FnRm9WenA3NkZZKzl2WGVKRFAvZGVQNXVxK2JPVzVVYVlv?=
 =?utf-8?B?TmhaY1dWQXBCNGFtWEZyZk9DUEJSNk04NUJlTGQ0K3FaUUxTWFBWKzQ5N0xj?=
 =?utf-8?B?N21CZ3FmcWxHQWp6Wkw2SkJZUGZzdFMrMWxxamx4VUEwTjcxZWkyV2ZFL1hT?=
 =?utf-8?B?T3dIYkE1YTVDODZiL1pJc2VsYUd5RTc3MkZHdSs3NDRxMVNnazRySnJ2UzN3?=
 =?utf-8?B?bnhwY3I3ZXRkUzhFUi9JQWdxYS8xcCtvL0lxMWxNK0NJdEozS1M4YU9QeGgx?=
 =?utf-8?B?eHJIY2w5SlJUbzM0bE1lOWZKOVBFV0hFN0IwV05tZkZXQkJINlVndW5zeFdr?=
 =?utf-8?B?VmhnbFl2V2lMejVqR2J0aFdkY3ZZL0EwbjVkQ2dtdkROVExJbTM5L3RTSzZL?=
 =?utf-8?B?MExJWUowdmxpeExDd3VnUVY4SXlydlRqREpNdUZrbVg1L05rTUtnRXRONjQz?=
 =?utf-8?B?SnJqMGdsVEFkRTVmVHJSQmpRS1dlMzkxTmF2a0pFVjQ5L3JCU2hNRjZwUEZJ?=
 =?utf-8?B?NFFXT0p5K0RGb08yZmtZeWR5Y0hweW95ZTh4eGFSVkRaVDNPaTR4VnlPd3dW?=
 =?utf-8?B?cGlObjl3U1BCOSs1QUlOZHdBY2NSdlVvbGh6bC9FTFdEYmZDdisyMjlqaXd2?=
 =?utf-8?B?UmdkeTFMSksyYlpkN0J6cG9WVURuK21tNzY5L2FQUWs1am9qTW1EMXVuZnQ3?=
 =?utf-8?B?MEFvUXlwN3pMUWNmZ29Rc2RFaFc0MHF0OVRDN1hGNEpSVU5zaXlxQVZYVXJp?=
 =?utf-8?B?bUtDUWJRSDV6R2ltWVhxK2F2VDdzcjJVQUpnR3RGMm0vOFMxTWJyTmQvRTU1?=
 =?utf-8?B?Wnk3ck9pWEZQTjc4ZUpydGhYVWJLalRGSWRHYzN5OTJrTEd1T0tLUUl3Skpj?=
 =?utf-8?B?akRaQXNZdnQ1MWFWZ2JPUEhHcm5JV3NuL2J2VjMrQStiZ0J2TG5aZFplamFH?=
 =?utf-8?B?M3hMWjl2ZlpKSW10aEZhaG1XZG5jM21mNldscTUvbXNGaldJL3hJVUh1aGJk?=
 =?utf-8?B?UWx5V3VMbzVtVW9CT3BaU0xwbjlxeGYrenBQK0hiV3V0c3dlMU1NbHRWK2VW?=
 =?utf-8?B?UUdJSnBhT01YUzBrM3FoN3RVRThEMFZSeUNJQXFtR0RKbXdRSFNGVDFLQm55?=
 =?utf-8?B?TWVENURLUGVYdkhVOEdXZ1pvdk5HcHJCaWs4c3cxelhmS2duZDM5bG1USVFR?=
 =?utf-8?B?VkVGQWVvYlJreUhlYzNMMUJrNko1dmlxY3A3eGdES3JHbC9zczVZQXkwRDAw?=
 =?utf-8?B?WjlEenoySTN6TzBEcG9KcnhtUXllT3E3WGZ6VXByM1NuT1pUdzVhUGYyZ3lh?=
 =?utf-8?B?VmNVNFF6dGF4UEdhYnhuemNFNVJob0piTVJpOW4waldPaEp4WkNMWVZnQ0pL?=
 =?utf-8?B?Vzk0aFZTNytoOU1tNFpMNjJBOUNNRUw4OVliRHQ3Z1YzK001MUlvMHZ5bU5E?=
 =?utf-8?B?SGxwa21tRDNVcWwxdHc4cWN2U25BcCsyRk1mVkJkeTRyMlg2NXJFcXlQaHpO?=
 =?utf-8?B?dkRPTmhDakFvUStRSHptUnprbXNDNTc3RVVCa1dqVnFPVmxub0h5Qm1Mb1JB?=
 =?utf-8?B?dHlNTFFWTTJIb3JydlJJVnR6L0w1VlJhUDFVbG1nVFovQzY2UU5yUVJJSFhR?=
 =?utf-8?B?ZXpHZ2V1ZFZwRVAvamtLNHhCaFRkMEdlOEhWd1czM1Bkd3FDcFRqZ0hUQ09Y?=
 =?utf-8?B?K1ZqUnJ1M3BTV2UyYnUyUmJ6VFZmY2d3RmN5R0VvRWU3S1YvaEZ6QkVhN2M5?=
 =?utf-8?B?bE5jaVVlZXRWS1JlME1SWXNnMllxdk5NR3ZORHBiWGRYQW5GNGpYOFdkZjEx?=
 =?utf-8?B?VjRDWCtybFBvb0NZd2g1ZUUydVVwSlByNk1wTkIrYitROFYzTzA4RFN0ZXU5?=
 =?utf-8?B?SldPNW5Cb0g0QzBJcm5XcXQxNjlnSzFqY2VtOEtocllaQUgrOVplN2o5UVNJ?=
 =?utf-8?B?S3U3SitLbmhBREZPU2Y3YjJLeTloUHUxYmlpL1FkVFd6NSt2VXpiVFZoZHpm?=
 =?utf-8?Q?1eOwKwSPgfVsGBwiSiVZrUY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ed521c-f8a8-4317-5592-08d9b89e82d6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 09:55:19.3315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtbvDo+wjHKJEbk0XCITUl8jRFiKTRxRc4W2iGvLHnK5ZsJeRkJuZSaDuKNjDN51+Ci8q055zizRrUQIdtuzGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5457
Cc: devicetree@vger.kernel.org, Mikko Perttunen <cyndis@kapsi.fi>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Mikko Perttunen <mperttunen@nvidia.com>, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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
From: Jon Hunter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jon Hunter <jonathanh@nvidia.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

V2lsbCwgSm9lcmcsIFJvYiwKCk9uIDA4LzExLzIwMjEgMTA6MzYsIE1pa2tvIFBlcnR0dW5lbiB3
cm90ZToKPiBPbiA5LzE2LzIxIDU6MzIgUE0sIE1pa2tvIFBlcnR0dW5lbiB3cm90ZToKPj4gSGkg
YWxsLAo+Pgo+PiAqKioKPj4gTmV3IGluIHYyOgo+Pgo+PiBBZGRlZCBzdXBwb3J0IGZvciBUZWdy
YTE5NAo+PiBVc2Ugc3RhbmRhcmQgaW9tbXUtbWFwIHByb3BlcnR5IGluc3RlYWQgb2YgY3VzdG9t
IG1lY2hhbmlzbQo+PiAqKioKPj4KPj4gdGhpcyBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciBIb3N0
MXggJ2NvbnRleHQgaXNvbGF0aW9uJy4gU2luY2UKPj4gd2hlbiBwcm9ncmFtbWluZyBlbmdpbmVz
IHRocm91Z2ggSG9zdDF4LCB1c2Vyc3BhY2UgY2FuIHByb2dyYW0gaW4KPj4gYW55IGFkZHJlc3Nl
cyBpdCB3YW50cywgd2UgbmVlZCBzb21lIHdheSB0byBpc29sYXRlIHRoZSBlbmdpbmVzJwo+PiBt
ZW1vcnkgc3BhY2VzLiBUcmFkaXRpb25hbGx5IHRoaXMgaGFzIGVpdGhlciBiZWVuIGRvbmUgaW1w
ZXJmZWN0bHkKPj4gd2l0aCBhIHNpbmdsZSBzaGFyZWQgSU9NTVUgZG9tYWluLCBvciBieSBjb3B5
aW5nIGFuZCB2ZXJpZnlpbmcgdGhlCj4+IHByb2dyYW1taW5nIGNvbW1hbmQgc3RyZWFtIGF0IHN1
Ym1pdCB0aW1lIChIb3N0MXggZmlyZXdhbGwpLgo+Pgo+PiBTaW5jZSBUZWdyYTE4NiB0aGVyZSBp
cyBhIHByaXZpbGVnZWQgKG9ubHkgdXNhYmxlIGJ5IGtlcm5lbCkKPj4gSG9zdDF4IG9wY29kZSB0
aGF0IGFsbG93cyBzZXR0aW5nIHRoZSBzdHJlYW0gSUQgc2VudCBieSB0aGUgZW5naW5lCj4+IHRv
IHRoZSBTTU1VLiBTbywgYnkgYWxsb2NhdGluZyBhIG51bWJlciBvZiBjb250ZXh0IGJhbmtzIGFu
ZCBzdHJlYW0KPj4gSURzIGZvciB0aGlzIHB1cnBvc2UsIGFuZCB1c2luZyB0aGlzIG9wY29kZSBh
dCB0aGUgYmVnaW5uaW5nIG9mCj4+IGVhY2ggam9iLCB3ZSBjYW4gaW1wbGVtZW50IGlzb2xhdGlv
bi4gRHVlIHRvIHRoZSBsaW1pdGVkIG51bWJlciBvZgo+PiBjb250ZXh0IGJhbmtzIG9ubHkgZWFj
aCBwcm9jZXNzIGdldHMgaXRzIG93biBjb250ZXh0LCBhbmQgbm90Cj4+IGVhY2ggY2hhbm5lbC4K
Pj4KPj4gVGhpcyBmZWF0dXJlIGFsc28gYWxsb3dzIHNoYXJpbmcgZW5naW5lcyBhbW9uZyBtdWx0
aXBsZSBWTXMgd2hlbgo+PiB1c2VkIHdpdGggSG9zdDF4J3MgaGFyZHdhcmUgdmlydHVhbGl6YXRp
b24gc3VwcG9ydCAtIHVwIHRvIDggVk1zCj4+IGNhbiBiZSBjb25maWd1cmVkIHdpdGggYSBzdWJz
ZXQgb2YgYWxsb3dlZCBzdHJlYW0gSURzLCBlbmZvcmNlZAo+PiBhdCBoYXJkd2FyZSBsZXZlbC4K
Pj4KPj4gVG8gaW1wbGVtZW50IHRoaXMsIHRoaXMgc2VyaWVzIGFkZHMgYSBuZXcgaG9zdDF4IGNv
bnRleHQgYnVzLCB3aGljaAo+PiB3aWxsIGNvbnRhaW4gdGhlICdzdHJ1Y3QgZGV2aWNlJ3MgY29y
cmVzcG9uZGluZyB0byBlYWNoIGNvbnRleHQKPj4gYmFuayAvIHN0cmVhbSBJRCwgY2hhbmdlcyB0
byBkZXZpY2UgdHJlZSBhbmQgU01NVSBjb2RlIHRvIGFsbG93Cj4+IHJlZ2lzdGVyaW5nIHRoZSBk
ZXZpY2VzIGFuZCB1c2luZyB0aGUgYnVzLCBhcyB3ZWxsIGFzIHRoZSBIb3N0MXgKPj4gc3RyZWFt
IElEIHByb2dyYW1taW5nIGNvZGUgYW5kIHN1cHBvcnQgaW4gVGVncmFEUk0uCj4+Cj4+IERldmlj
ZSB0cmVlIGJpbmRpbmdzIGFyZSBub3QgdXBkYXRlZCB5ZXQgcGVuZGluZyBjb25zZW5zdXMgdGhh
dCB0aGUKPj4gcHJvcG9zZWQgY2hhbmdlcyBtYWtlIHNlbnNlLgo+Pgo+PiBUaGFua3MsCj4+IE1p
a2tvCj4+Cj4+IE1pa2tvIFBlcnR0dW5lbiAoOCk6Cj4+IMKgwqAgZ3B1OiBob3N0MXg6IEFkZCBj
b250ZXh0IGJ1cwo+PiDCoMKgIGdwdTogaG9zdDF4OiBBZGQgY29udGV4dCBkZXZpY2UgbWFuYWdl
bWVudCBjb2RlCj4+IMKgwqAgZ3B1OiBob3N0MXg6IFByb2dyYW0gY29udGV4dCBzdHJlYW0gSUQg
b24gc3VibWlzc2lvbgo+PiDCoMKgIGlvbW11L2FybS1zbW11OiBBdHRhY2ggdG8gaG9zdDF4IGNv
bnRleHQgZGV2aWNlIGJ1cwo+PiDCoMKgIGFybTY0OiB0ZWdyYTogQWRkIEhvc3QxeCBjb250ZXh0
IHN0cmVhbSBJRHMgb24gVGVncmExODYrCj4+IMKgwqAgZHJtL3RlZ3JhOiBmYWxjb246IFNldCBE
TUFDVFggZmllbGQgb24gRE1BIHRyYW5zYWN0aW9ucwo+PiDCoMKgIGRybS90ZWdyYTogdmljOiBJ
bXBsZW1lbnQgZ2V0X3N0cmVhbWlkX29mZnNldAo+PiDCoMKgIGRybS90ZWdyYTogU3VwcG9ydCBj
b250ZXh0IGlzb2xhdGlvbgo+Pgo+PiDCoCBhcmNoL2FybTY0L2Jvb3QvZHRzL252aWRpYS90ZWdy
YTE4Ni5kdHNpwqAgfMKgIDEyICsrCj4+IMKgIGFyY2gvYXJtNjQvYm9vdC9kdHMvbnZpZGlhL3Rl
Z3JhMTk0LmR0c2nCoCB8wqAgMTIgKysKPj4gwqAgZHJpdmVycy9ncHUvTWFrZWZpbGXCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMyArLQo+PiDCoCBkcml2
ZXJzL2dwdS9kcm0vdGVncmEvZHJtLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKg
IDIgKwo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vdGVncmEvZmFsY29uLmPCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHzCoMKgIDggKwo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vdGVncmEvZmFsY29uLmjCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKwo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vdGVncmEv
c3VibWl0LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxMyArKwo+PiDCoCBkcml2ZXJzL2dw
dS9kcm0vdGVncmEvdWFwaS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDM0ICsrKyst
Cj4+IMKgIGRyaXZlcnMvZ3B1L2RybS90ZWdyYS92aWMuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgIDM4ICsrKysrCj4+IMKgIGRyaXZlcnMvZ3B1L2hvc3QxeC9LY29uZmlnwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDUgKwo+PiDCoCBkcml2ZXJzL2dwdS9ob3N0
MXgvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDIgKwo+PiDCoCBk
cml2ZXJzL2dwdS9ob3N0MXgvY29udGV4dC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAx
NzQgKysrKysrKysrKysrKysrKysrKysrKwo+PiDCoCBkcml2ZXJzL2dwdS9ob3N0MXgvY29udGV4
dC5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDI3ICsrKysKPj4gwqAgZHJpdmVycy9n
cHUvaG9zdDF4L2NvbnRleHRfYnVzLmPCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDMxICsrKysKPj4g
wqAgZHJpdmVycy9ncHUvaG9zdDF4L2Rldi5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqAgMTIgKy0KPj4gwqAgZHJpdmVycy9ncHUvaG9zdDF4L2Rldi5owqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAyICsKPj4gwqAgZHJpdmVycy9ncHUvaG9zdDF4
L2h3L2NoYW5uZWxfaHcuY8KgwqDCoMKgwqDCoMKgIHzCoCA1MiArKysrKystCj4+IMKgIGRyaXZl
cnMvZ3B1L2hvc3QxeC9ody9ob3N0MXgwNl9oYXJkd2FyZS5oIHzCoCAxMCArKwo+PiDCoCBkcml2
ZXJzL2dwdS9ob3N0MXgvaHcvaG9zdDF4MDdfaGFyZHdhcmUuaCB8wqAgMTAgKysKPj4gwqAgZHJp
dmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUuY8KgwqDCoMKgIHzCoCAxMyArKwo+PiDC
oCBpbmNsdWRlL2xpbnV4L2hvc3QxeC5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgIDIxICsrKwo+PiDCoCBpbmNsdWRlL2xpbnV4L2hvc3QxeF9jb250ZXh0X2J1cy5o
wqDCoMKgwqDCoMKgwqAgfMKgIDE1ICsrCj4+IMKgIDIyIGZpbGVzIGNoYW5nZWQsIDQ4OCBpbnNl
cnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+PiDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9ncHUvaG9zdDF4L2NvbnRleHQuYwo+PiDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9n
cHUvaG9zdDF4L2NvbnRleHQuaAo+PiDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUv
aG9zdDF4L2NvbnRleHRfYnVzLmMKPj4gwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGlu
dXgvaG9zdDF4X2NvbnRleHRfYnVzLmgKPj4KPiAKPiBJT01NVS9EVCBmb2xrcywgYW55IHRob3Vn
aHRzIGFib3V0IHRoaXMgYXBwcm9hY2g/IFRoZSBwYXRjaGVzIHRoYXQgYXJlIAo+IG9mIGludGVy
ZXN0IG91dHNpZGUgb2YgSG9zdDF4L1RlZ3JhRFJNIHNwZWNpZmljcyBhcmUgcGF0Y2hlcyAxLCAy
LCA0LCAKPiBhbmQgNS4KCgpBbnkgZmVlZGJhY2sgb24gdGhpcz8KCkpvbgoKLS0gCm52cHVibGlj
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
