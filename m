Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8149C433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 11:00:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 205A660AF8;
	Wed, 22 Jun 2022 11:00:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 205A660AF8
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uQhqTVix
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WkEmWou9eQMQ; Wed, 22 Jun 2022 11:00:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 02F6B61060;
	Wed, 22 Jun 2022 11:00:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 02F6B61060
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF1D1C0039;
	Wed, 22 Jun 2022 11:00:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 485CDC002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 11:00:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B2FAC61295
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 11:00:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B2FAC61295
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fIY6CEL2WlbS for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 11:00:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A18C561060
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A18C561060
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 11:00:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5e67Z264XYdLGd8DmZgc48hqwliFE9EJqSs59GMOoUrzFRI95qLbpnzgka2e4E4ATaZFHYh5F5ao9cJTJEWNxwiy9ydgLD1iLPph0xcQjSkbcDVpf5gwXyWv48inO3kJhFjztHRxP1oppH1+1nLhcVTB9TrHbVxBu6Wd/9pFxGNSZUDV53ZGRq2yKNsLAzfTJi/HMGnwsyM5XPPYFkr1KPrBThM8Sp/mFaE8wwZOzd0BOLCTesQA2/iag1h9DZe+8Nb/La1sKPnx1OWmzA5a2A91paj07SXtPLXNbPAaVTP1V9fhYvpWSWmlkdlsPvt/bRP5hnU9sxlBmxcJ0VBiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PFARsZNj7vIpwwe+bWVyS1fMZKL6WTWolaPoWtPwQA=;
 b=dxlIIubVH3aYAxDDerCq709nIMrrmvVOExnbD1ZmIgd42JFCjJy5MNhFl0MWHrJTdAim65eVb5wIjPj1z+SnIwuDDnC1pTdkZqMnkw2OjxflBjnzzgzXrOh5fP2Bz7fov3HSZ66rDL6/sjiIYdgdBXdyGYBsNuuHczcGNK6Ub38sFCNz/FipqA9BuLUxkmsskVXZbbKSzoyMC7b8bzr4KfI46/1D6wA0VNmpoT3z7ga0aFdQB5CgiUH4lr2CSqhKHqFaeyQWnYjkfmX7pMnMv2TU48eX9xwrlxbaA4qAQcGku1i5nPAStOGP0Y72R5KgEdN4ITu/w/greqvzSXOU2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PFARsZNj7vIpwwe+bWVyS1fMZKL6WTWolaPoWtPwQA=;
 b=uQhqTVixry+x00k1h4Sum9W5IIwJGuVEava9DSuUssSOowUiCiZ/+suUdnlfzqn6xLma9Ki8A9KYTCxSSWA3xlugz6NKJ7yoBaFCHdgyQb1QFzX3J4qivvEzfaLWz+x8cOWCvsGh4SG8ExZIhVNlYvN+yiBxlhK3XgmW5+HJsKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 PH0PR12MB5632.namprd12.prod.outlook.com (2603:10b6:510:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 11:00:40 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::14b:372d:338c:a594]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::14b:372d:338c:a594%9]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 11:00:40 +0000
Message-ID: <c420dcee-d136-a81f-1c29-aea3f64a6eb9@amd.com>
Date: Wed, 22 Jun 2022 18:00:32 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 4/7] iommu/amd: Introduce function to check and enable
 SNP
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org
References: <20220616015541.11207-1-suravee.suthikulpanit@amd.com>
 <20220616015541.11207-5-suravee.suthikulpanit@amd.com>
 <4ec10456-777c-f26a-cfb2-c968a9bb3a4b@arm.com>
In-Reply-To: <4ec10456-777c-f26a-cfb2-c968a9bb3a4b@arm.com>
X-ClientProxiedBy: SG2PR01CA0186.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::14) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d4a8624-17e2-4602-51d8-08da543e71f0
X-MS-TrafficTypeDiagnostic: PH0PR12MB5632:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB563224B2F6758273D853FF6BF3B29@PH0PR12MB5632.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w/SkGWT1ScODzY/8kw8vYgHEZ0ELnlUX0SCVRbDPwruDz1aepm1dynHHjrQEu/kyC+H3bKi7/nKI2/GS6uQncpK+dIm9IywmsZQuQRLf3QsnJbXw3+JDQRU2o6AcnabEHZxsOtIWThqAFnk4ZSIcXYuY966FohomeDAuBd0kkV979WNlTPHuKNAWaUzB3T5KF5axHNHsbgRjjleqhjMnTFoB1Qsgwu9iQTPGDh/ERbkLrQ31pzF1VIsufTmE/XbqtZAYene9b1ZRyH7BFZ0XBKBFYFsIHoqZA4pDDKatT4HMeMCaxjhDjvlVW+31/SRfEEc7Z4l9yyhW4bEJL7rhQpEB/3AEDtgZijsrPOZYcgyQq5Z9ZuttoiI1Npce+cQ745AL4TZbFw5P7+2Z6nippEaj4rVYO1KR64OLQsi1UAIdpGK2P+dL33GUxmwSzU2syNt/CNkAD3bvLg1E/nRleL6Cn5I6UGVJp4hYDxsTQI9S7yuTiQY0CW3FbmScR2YohoKa6cPuvZMVBcRXXuF+F+10wO71B4bEIg0f+xuLZiIYsvW2nvxYAIaKaxhJwyp04C8lVQRYExXghc+6ecWj+qxeShCQCo8gAhmgWgQb0+N2xt3qArHQUZqJIxGUwAmmmPHSs7ZbblTm25k1h/VgMTb0G5DH7qlUa4WP9e2yYbCcbrzDA31C71rYgrL64pZQcHRw1iR4ww0Asb68RHWQpQ6dW/+RMfNxPL0f1YTmXqwck+Eg/Shve9vg+Eb1czIMybqUrYk60075kLY1nAgxwvPoizuuMuiKyH19XatOKc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(38100700002)(86362001)(66476007)(4744005)(2616005)(316002)(66556008)(8676002)(4326008)(6486002)(478600001)(36756003)(8936002)(66946007)(31686004)(5660300002)(53546011)(2906002)(31696002)(6506007)(41300700001)(6666004)(26005)(186003)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE9BdGQzdHl3R2lSdDJaL2VxeWhWYUMvdnVscE9SOSs2aUdVZkV5U1E1aUZM?=
 =?utf-8?B?YWYrS3VDTGNtN3hxdW02Uld4bjk2WVF2M3l1Z0lWRkhKd3FZWXlQNlQrMytj?=
 =?utf-8?B?SUNsUWdpdExka0JGdVVTRGNCa0FpcWZuMm9zdkVFRVRVaVJSNEgwYmIzby9J?=
 =?utf-8?B?bjhhNmorUTNNeWdmV1YwQlVZUXpPWVczQ0ZIY0ZCKzRwTGJsQTNQR0RNS2pk?=
 =?utf-8?B?OWw4SFg4TmlXYlhJdDZJQldrUDN4ZVdlV2lNaTZHaEc5ZEtIbTgvRTlpazFh?=
 =?utf-8?B?L3N4SlJCZlNNR3g0cUQ4MjJFRFNidDJOQUJZNWJIMnVMbjEvVmxlTWVXbk1F?=
 =?utf-8?B?MzZiL3M0RDc0VmFXbFA1TjBFU28xQVE1alo0MkFGUXRiSkdRY0p5bXVieVl4?=
 =?utf-8?B?c2E4ZkJtOXl5ajViOHZCbEZ2a0R5VGsxOFVtZWZEeVRLaVRqZXF1MEVESkIr?=
 =?utf-8?B?Sm95di9vQ0krL2lZaktmZ25wNzdDbThrQWhieTlGamN2YW4wRzZTWEg3YlBr?=
 =?utf-8?B?VWR3c2xvMUU0M3doKzBoVEtlcVZqU2VCQnlReXZUMzVRczZ5Q3NYRnY4RFBz?=
 =?utf-8?B?L3hrVHBXdmxPUHE2clVuNlBFUkhLL1hDY3hZb3JxTTcrL0hUMXNzVlAxd1o5?=
 =?utf-8?B?QzljaDRJbGZEK29IQjhLc3pkR0x5RjFxZ0FGOGtGZHpSRytwMFh2NlFQeWIr?=
 =?utf-8?B?dFNDSHFPS0VuSThQcmNuS0dXdjkxMEVER0grendiUHd0YnI1ZWNjSW9wSUEx?=
 =?utf-8?B?RFVyZFp5WXhNOGtlZ0lqVHNjVGRmUmxOOEdoZTF0dXVsT2UyZG5zak90a0cy?=
 =?utf-8?B?QWpmSVFFeTlYL3BMM24wYzZuTE1YZldGTEdNbTR5cnF4anh0My9tWnMzZzRt?=
 =?utf-8?B?dEQ5NTRtSFpxUE1LcFAwMk1ZTUIrR2cxRkV1aHRHWVRrN0E1YTMzNVJpWXIr?=
 =?utf-8?B?MmdTbk9nRG1YOGgvbzcvcTMzOVRVQWo5eUFpRC9mQVNDM3BoQlREa1NNdnFl?=
 =?utf-8?B?eHdrUEh1bXRZWEl4VlRzS0hLeXR1SFRjOXEwVnlnUjcrdXB3M0I2TXNncUFi?=
 =?utf-8?B?TVpsVXVWem91ZU5UdmNFcWJMeCt1ZFBRVTlQNVBoa3VxRnN4V0RRVmhrdUNl?=
 =?utf-8?B?L2d4aUVGWnd0d1E4dHJNb2IxRnoxSVZZQUliVEJGSnBobzBaSi9MWlNSZ0Fh?=
 =?utf-8?B?TmZnVU9WWFJyTEVKaFVFdVI1REltYUJCa1lObTJraENRaFJHSGNmTXVkV1JY?=
 =?utf-8?B?ZUJxbjZGUllncW84eHlLS2VyWGN2WmwyeTRyN2lqUmNpMjJuZXRCRW95RFZw?=
 =?utf-8?B?Uy9UYkp0U3Q0U2lpTUl4Mm5kSm45TXB6VXNsOFd0VkwyeE80STJoS2MzNTFH?=
 =?utf-8?B?VjBlR05rdjlaNG5YTGtGRXh5RGNOWk1TMUNqNkFtWUdTZTBMNGxMMGNUSXZK?=
 =?utf-8?B?NGh0T2NKQmlvY0Z4MkkxK3hUQ3NBUUtDRXVaWnBjcEIvV0w1QmFKOVh0UHYr?=
 =?utf-8?B?dXp3YTJTRHk0eGpwQTNLVVYrSFBhUHh1aytybVUyNi91Skd2bGlFeWdRYmNy?=
 =?utf-8?B?WjhzaWlTbHdaSHdYYVpmaEVCWWtXdGVsT25nMnBtQkl3NW5Qc1FzSDNrMjB4?=
 =?utf-8?B?OTBSTDFCM2I0VUd6cW1DWmUyQWVaekxVU2k4alBoVFU5N1VrenJ5YXFHa0FJ?=
 =?utf-8?B?Z3VuSHA5RFF2UVJpTDU5cEkxdkh5N0pCQUFkcjBmNk1NclVuL1FKbDVxamZ2?=
 =?utf-8?B?dXZJWVdkM2pGSXQveEpSTmxpcmZ6SzQxR2FUUEJNeXFqTTRJWHRveUhJeXN6?=
 =?utf-8?B?Y1B6ZkJFZkxyMWVPYmNXNU9KZVRzT2VkeGdrZExmYno3T2tZa2p5SGJHeVgx?=
 =?utf-8?B?WjFhMDFmbis3aWpvUzRZUmVzSldyL2I5R2NiNkgrV2NSdml6elQ0NWwrYUd3?=
 =?utf-8?B?QkJ5N2xFVW9VcGZtUUdlMlFLcXhzWnR6QXVpeUdmR2F0M3p6QzRzbVZxR2hp?=
 =?utf-8?B?RWRqUEpZZ2F6YkNMd0dXdERhMGF2Z056bFJ1aHptVWdsV3VURGsyekVTZDZV?=
 =?utf-8?B?RDQ3MEpNcURZZzZzdXdZeVNKbWg3WDdhZlo3SHhIbDU5MEU1UFZVSmVZYVpE?=
 =?utf-8?B?VWFzVjA1SklySjNPMTluMTBIbGlpcGU3VWY3Smp0NXJUVUJNNXFtNzRmN3ds?=
 =?utf-8?B?Sm9wMUJhaU95V1ZWbG1iV0ZFY0pXa2cwQmRsUkRlbWdqa3FYT0tFMVhhTkRB?=
 =?utf-8?B?ajJYL1FrWm9BWGxRQlNSbFhPdngxK1kzWlMyQnNncEdlUjdxTjhPV0g3RnNL?=
 =?utf-8?B?dTNiRUxjN1FDZm1iZFZkQys4Rkh5WmtsZjRoTmJJNExBUFVwaVpqUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4a8624-17e2-4602-51d8-08da543e71f0
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 11:00:40.7157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4rQzGel9bbc2VavXc2sOrMkupVwN8ZZMuSuAMglGiG68fENw/QL2AhWsSUI4MlMUqo5N1iDGh4LitYYcY4eAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5632
Cc: thomas.lendacky@amd.com, Brijesh Singh <brijesh.singh@amd.com>,
 ashish.kalra@amd.com, vasant.hegde@amd.com
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

CgpPbiA2LzIyLzIwMjIgMzozNSBQTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IAo+IE92ZXJhbGwg
dGhvdWdoLCB0aGlzIGlzIHdheSBuaWNlciB0aGFuIHYxLCBhbmQgaXQncyBkZWZpbml0ZWx5IHRo
ZSByaWdodCBuYW1lIGluIHRoZSByaWdodCBwbGFjZSBub3csIHRoYW5rcyEgRldJVywgd2l0aCB0
aG9zZSBuaXRzIHBpY2tlZCBvbmUgd2F5wqBvcsKgYW5vdGhlcjoKPiAKPiBSZXZpZXdlZC1ieTrC
oFJvYmluwqBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPgo+IAo+IENoZWVycywKPiBSb2Jp
bi4KClRoYW5rcyBmb3IgeW91ciByZXZpZXcuIEknbGwgc2VuZCBvdXQgdjMgdy8geW91ciBzdWdn
ZXN0aW9ucyBhbmQgcmV2aWV3ZWQtYnkgdGFnLgoKU3VyYXZlZQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
