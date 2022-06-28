Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E369C433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 09:06:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A3D060D9C;
	Tue, 28 Jun 2022 09:06:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A3D060D9C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LMXP0NG2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BNuqQUiWKKVS; Tue, 28 Jun 2022 09:06:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 499C660D76;
	Tue, 28 Jun 2022 09:06:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 499C660D76
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26AE3C0039;
	Tue, 28 Jun 2022 09:06:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B973C002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 09:06:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 12776414C8
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 09:06:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12776414C8
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=LMXP0NG2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pDNJmcSzuQCj for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 09:06:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C0DB410A0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C0DB410A0
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 09:06:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhtqJ5UIgxGk3RZE2wLcGtjFBp75QS975UswioaPUpCWWdjAl0lGvlAO6gkx7TkYxnwoHMyUEUeNjK8lQ0hlTdI7SCWyGJnClBpGcJSn0Vi4gBXveUXN4MDwtYPghyb9W3uMBizJfwWbhxveScbUCHr7C3ID3plmfyWwg3wSNnxpc8NG3b+YWkYEXOwhYZqamoiy7cNL4+kOuRZmXi1LdDHRvp56YBs6BHx9kyiA89a/LeDbuT/PXmSi6gtcXEJyUwHYOcTAy8baxIgEZlFFUeKBU9LOk5s21Q7aH+uVG9pJfKfqC5yu6LhWMuaNnCyx+16Rm3OSpyhx34lR2aLgUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ln1dBo32pdvlp/6KRKQusZpm+CE1EpgT4HnRpXWvy0w=;
 b=mpkuXbz6+If9VmtFPxysUKkA+wRrM6xzJegl/xbHQpkqPr5MQhEDWMi6LAlXNsUwaWoJf1cgNUmgnuRgHuJl5Usq176vAcrTmrYYP5usgrce5/YV/5MbJXjQHrI1VCYSelmiQEyRkca173yCig7f6YfDuD/7Twhi9ic3wNHSgaauDC9ntiyldpEZnYrcOnFmFY3cSq0/D4P3gcTAePConqEykc6WrnMXbXtHy8FhpyMInHhfeL9GoQRoHiKWbyPQ2Qgt5AFeJo3LE+miWyiBqV7W6oS9ifdQFH0vtpoAH3CFYQ2wAhYl5KtMoana7Hafmwq7CPraHA2f1TYIJMomRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ln1dBo32pdvlp/6KRKQusZpm+CE1EpgT4HnRpXWvy0w=;
 b=LMXP0NG2A1CSLONjCX5wlgofCpw4TVqyezvK+2A5t0DBU+OyBOEMNId0aImhsNNUTXPyv42ZChsKaE9i4ae/TiVsOtb9Xesjm4rT+uQXvKCUSFESP+cz2QOyP3+Kl2Isr4m1Geolo9pmukRBJ/nDsF5to08MtnaJcjyOSptfXNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MW2PR12MB2411.namprd12.prod.outlook.com (2603:10b6:907:10::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.18; Tue, 28 Jun 2022 09:06:01 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::447f:59a0:eb30:ec26]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::447f:59a0:eb30:ec26%9]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 09:06:01 +0000
Message-ID: <5ad3770b-16a5-9148-54dc-5dcb93efcc81@amd.com>
Date: Tue, 28 Jun 2022 14:35:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 0/7] iommu/amd: Add Generic IO Page Table Framework
 Support for v2 Page Table
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20220603112107.8603-1-vasant.hegde@amd.com>
 <YrQhGYBVhsaNOgCH@8bytes.org>
In-Reply-To: <YrQhGYBVhsaNOgCH@8bytes.org>
X-ClientProxiedBy: PN3PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::21) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92f5936d-388e-4e3c-0fbf-08da58e56c47
X-MS-TrafficTypeDiagnostic: MW2PR12MB2411:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Lhf9QxZVJz7rGRrweDKvzYHJUwmj3Z7T1QDQd8TPcHHMUrwnQliFWYhY5EX1doh4cDjm85hL4RyyYKk8fkkIa/UYGDNBI4BvzLzFPYUb0J4MQUTmA52G+52jPPnzs07fizozIhqli6i76MRp4/TXa/iEiw3elTURVOvJjGZGVWkMcJVj28gJc87l8WjxYMxTYDLiNNLTJefF13Ar29/f76//8FHuTcKC7fpyg7C8IR15wIxIc2R4o/nzF0mGRytql9c6ZH/rnQp8XG56uSLprF2EY7stEbv4MTkN87AqnB73oUm/GyQtuwS0+NvqIb1veqlqHKFjdN+QgQbwbytkxL9/3rJdNpn6pIInFHoLQteWoQZD8Qs2lIfokR2CThB7ty5tiBd3iqMJTzyxHBuUQkvCwCpOLtVPwsz2WuPxSeRHx2qb2CtUuE3QxBgpCVDFfkCJ9ze76W2ipr2j6DcSa6A1CkM9gHfV9q6DPd7cncvxmndZ1xFq+WmM1YqwJpcPus+1xjymY7rUbQP6BrkSXOSGbcj5F/JxdFiD2YjnVVv1d+5vfb2RGN+G4QYDno8J9szQtRMMNj99aE940NStkeatW7lo0975OZ437npAGxl/BxhObiKpXXm1zdfRRqTxmh6jY1/EyFyXRD7ppIxcKFE6+jYQhsBS381AYhFRQoBq/4O1dBJHNPVbJalGvvgkjwAP8TtNalHB9ePbMlu8b5UO1GI1oSoNxuEfFMXH9oL+5LZKsLzI3ugoAO0q9gYjodMuwFkcSVwkkFJEfbO2y04c4gjpoQGlblFii7Z65KzTg1ZaHTCG95wq8zojLf2WrmD6NGpOJsH+xrR92I1+JdZ3jiWvcASYP/NCPji+e4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(36756003)(44832011)(4326008)(31686004)(38100700002)(6486002)(6506007)(5660300002)(4744005)(8936002)(66946007)(66556008)(2906002)(66476007)(8676002)(83380400001)(41300700001)(86362001)(478600001)(316002)(6916009)(53546011)(26005)(6666004)(31696002)(2616005)(6512007)(186003)(41533002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGdFbjBMTDZmMlJVY1RpTVJ6bGlPcWUxNWpxc3YvODZRQytYZ05vdmxyMEI5?=
 =?utf-8?B?dldQY0JiWW9oUWFOOTlCV0o3QU81M2wxU1JtdzAzaXZZMUwvRHA3UjNiRE1K?=
 =?utf-8?B?dTRxYm5JM1hoVnVPZUlzZy85VklkVHZwaHZVMHJuMTd3ZlNkQjNyMDdyTlBC?=
 =?utf-8?B?cjFvVjJ4aTVQRUlyMmhmSUo0Sy8vb1Y4UXJiTk9mTFBkNWFaQ0JqL1FLMTNR?=
 =?utf-8?B?dTEwdCs5NTI4YXpQdEFKY3NmNUdzQ2t3SFZ2ajFLbnAxck1hL3VncDM3RjZk?=
 =?utf-8?B?ODhWdHRNQ0pMbzZTZTN0ZHNTaSt3eVUyNjdXbXBia29leEkrT3lIVnRKM0lP?=
 =?utf-8?B?M3BEaUJjK1BFR1RDYjdVU291OTZHTXJEV2grQ1JqQXVUNDRJWnBlN3BKYnZR?=
 =?utf-8?B?aW0rSDZhZ2pwS0NKTzdYbXFkbXJGY1lQOUFYRUYxaFB6Z3hWTE5MVnlqWGx4?=
 =?utf-8?B?OXIyUm1hWUlleFJPakdzS3RlaUtBUDVJcitLNC9MZUtuUHM0RGN1Q1NHQmlN?=
 =?utf-8?B?WHFpMFZvNWJZWmZGVW5wYk5FSEdRb0RIRHEzc3pWQzZLN0N3TThlSWZuYWM3?=
 =?utf-8?B?SUFzdHRVYlpIUkdMV2FQaE0raWRSZkg5eFdpK3hxYnhjUUd3ZEFvZDNFdHZj?=
 =?utf-8?B?UTY3S1JsSWdRQnlsbE9HcHhSdzNIMkhkMjB1aldabVBURFJLU2w1ZXRIQnN4?=
 =?utf-8?B?OTZmNCt2T3lOb09TNlZsbXhUd0dveEpKQitxOGExVWNBRU1EZG1KaWNScTBK?=
 =?utf-8?B?VjBwemVpcWVuS2dqU08rM3ZXbEFiUFM2cmJBQlNYMHlIZ2ljVnpJRUlOdG11?=
 =?utf-8?B?cjEzTTZ2UGpldng4NzFwRkVzK1ZMa2l3ekNXWEJyZjB0TUp1OFd3dXI1R0M0?=
 =?utf-8?B?c0ovdEJSQTMwWXM0YXEwVkNlNENkVGNOMlROVWVkd0hIVmRjSDMrSWhOTEdY?=
 =?utf-8?B?NFpBOVNqbUFRTVJpMHh3aEdxd0twQ0V2K0ZFaFZNbldhZ1lGdkEvWlRyMHZE?=
 =?utf-8?B?Q0d1YWU2aU1RMW5EV2tjUXZoMHlMbkpPRXNib0tXMmxJRUFDYlZuRjRGZUEw?=
 =?utf-8?B?MVFHS3RlRGw1MHFBaGhQWU9lcmVCS1psS2JBb1Z6REVIcUtLWVNIemlmTVJh?=
 =?utf-8?B?TWEzNURUZjBMTnEwNWR1akJkMVZrUThXQWdRNWNKbndjQnRNU1gxTmJXTmYv?=
 =?utf-8?B?b0dEVlFJbDRYSTh3UmlpdVlCWTRCT1JNOTVDNnJ4SGtYYU5BdGxENXhNZlU2?=
 =?utf-8?B?azZXK3AwMFJoajJFMW1nSFdpNkNFbmxja3Z6bFhwTnpxWmxLSDRaUlVDNjQ5?=
 =?utf-8?B?TzA2N3VGU0ViMFpEa1hsYUNCM2U3bENCa2hqaHNDU1dRb3ZTN0lYTytkVlRV?=
 =?utf-8?B?REJyb0RCRkVMM2oyT3UyczlaVnF3WjI0eGNEMVFuMElqcEJPNGVzRmVueURv?=
 =?utf-8?B?UTR2Y2tDTFhMU0tPUzYxMnlJMDRIb3NrV1ZucTRnMitQVU5pTDljd0F0ZGJT?=
 =?utf-8?B?L3dNNmhyS2Q2MTBuSHJCSDJFR2Z5RkhrMFNMYmF3TzVtOTJQNVM3ZzRhRkFn?=
 =?utf-8?B?YytoK2NhVHZ0NW44VXZ2WWtSRm5ZSXVvTUVwUFV1QjltZEFpQXFxVG40TWFu?=
 =?utf-8?B?UDRrQVdUSDhEdFV5ZGZ5Q0ZIRXJGaVhwSGdsMFdtSGpmREhqSVFUMFNVS2c1?=
 =?utf-8?B?NHlzSGcycWd6bmtNREdCUXovOHdPbU5Tc20wVEdBU0hFdjZxenlaRjViK0xx?=
 =?utf-8?B?L3ByV0w0TVBSZkJZanQ2VnkySjVMQnQxRG9LbmhmR28xZUxiRnBuMmgzZ3JV?=
 =?utf-8?B?cGRta2R1M2hXK1pNeHVDY1pLWUVUQUNYRDJFZnl1eWg4WkN4L0w0akRBQzFW?=
 =?utf-8?B?MVlacFlWMXE4WTJvMGVZVDRGQU81WFQrZi9zbExNNWcwU0diSnBHZW52TDU5?=
 =?utf-8?B?d0puWTlvT1hXc3MzWnNULzJqQnZwbFk4TnoyODhCc2EzQmVuU3pSR1g0RStQ?=
 =?utf-8?B?VVJsMjFDWWNRaVBwN0NvVUtxc2ExU09Fb0lnaHFmT3RLME1IdStPWWtRcElN?=
 =?utf-8?B?ZlpOVkFQWEM2UVNZV0JOK2padUcydDVOckNhUElKUjBLakpYem9yaURGcVZC?=
 =?utf-8?Q?Vpf3XrVJtWsrofxfkKIt17qMd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f5936d-388e-4e3c-0fbf-08da58e56c47
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 09:06:01.7135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOoX4Yf02L1prPO9Tm/5jYz+/+DNgJzwKbgv7ccHp/82WMvU9d9HZ2mItKF3OHGlT0PZThtAltPpdrcsEnn0lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2411
Cc: iommu@lists.linux-foundation.org
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
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Joerg,

On 6/23/2022 1:45 PM, Joerg Roedel wrote:
> On Fri, Jun 03, 2022 at 04:51:00PM +0530, Vasant Hegde wrote:
>> - Part 1 (patch 1-4 and 6)
>>   Refactor the current IOMMU page table code to adopt the generic IO page
>>   table framework, and add AMD IOMMU Guest (v2) page table management code.
>>
>> - Part 2 (patch 5)
>>   Add support for the AMD IOMMU Guest IO Protection feature (GIOV)
>>   where requests from the I/O device without a PASID are treated as
>>   if they have PASID of 0.
>>
>> - Part 3 (patch 7)
>>   Introduce new "amd_iommu_pgtable" command-line to allow users
>>   to select the mode of operation (v1 or v2).
> 
> Something I didn't get entirely from the review is support level of the
> amd_iommu_v2 driver. I think it will continue to work and the
> requirement that the device identity maps DMA requests without PASID is
> removed, right?

Sorry. I didn't get last statement ("device identity maps DMA requests without PASID").
Can you please elaborate?

-Vasant

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
