Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B2FC43334
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 07:49:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2A3B607FF;
	Tue, 28 Jun 2022 07:49:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F2A3B607FF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3K9M1rJC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vWj8blu9B9Wl; Tue, 28 Jun 2022 07:49:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A8E5260595;
	Tue, 28 Jun 2022 07:49:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A8E5260595
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75E83C0032;
	Tue, 28 Jun 2022 07:49:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0447CC002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D0E644049E
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:49:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D0E644049E
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=3K9M1rJC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8CGIvxvENLr4 for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 07:49:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 21A774049A
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 21A774049A
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:49:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfqjCUNsmYojZpoCEdfmN2LVthtAJhgHaON7tuKK6A898C/NbYFrVqTRXsIDJUndIBQrOCcQm2tU1JN5x4iAvS1FOvRY8vTJGgzRvEZcLMCE01+hv9VFHGWeLhVtqK2YkR2O6kUcR3IWr/p/7Nq/7lng/K6J1wl5/dp+I5fRXSYB3KEe2+7s/b2lTR+1hl6OtWJKkF77Gscja0/JdiGbutSDwQOWTHgJS6smeT8G3S628ZI3UA+192J65La4vRgITBwQMeMUSCJDNnas4WLg7Ul3rqMBzj+zwN5UdHzCWwAjToBUPQNKU3nGzRFSuJMzTtSwNATMO6zvgWFHn8rNpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kVc/Gfb3tGNXmN7HUI+byzPhm5BvfnmSwkLaSGl0kA=;
 b=m4uE1Dy7WNmmSw1KimYbmztQ8jExRtO4XPzY4RUdEkScjyLGj4gDqnjNbhqQh7jZtN4z0WPbn2VSuM5eawUNzuf9Xi8WM58hNLH/8cV7Se1dTNXpwvB0gesqSLJz/ygM0ml3Lzdun4CnsKg9qp8cpCYLXDH+Mllhdb24G/EBkmlAtZ0GSSnFEm+QNTXJSSq/pvOlGf3OL2vw8EPRB46EK9rSqzojycmcNj/o3LVEFxIjjbHmfObg6QDYEx66ZJLDYA55BY5sEt3VxqumfIMgSSX1R8JrW0N9hEIxD+qqriOmAYBQ6FBtDtnZ4xYhFZlWUHI+PnfGChv5mQDnMHD29w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kVc/Gfb3tGNXmN7HUI+byzPhm5BvfnmSwkLaSGl0kA=;
 b=3K9M1rJCgP+LKi8MkfddbTWqHuPW3geotQCiL7WoPuXB0Thj/1wdOo96IlJiz2oqNlFY1wRjfOzRS5i/AzuzJWCB24+INsclQ9IYSd/XElLAvvdkMBDvIaxwh5SeS04kxGR99R8f7t0LF/Mxu1ZhQs+InYJC2loBWUdlpHQKQ8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM6PR12MB3035.namprd12.prod.outlook.com (2603:10b6:5:3a::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.18; Tue, 28 Jun 2022 07:49:34 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::447f:59a0:eb30:ec26]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::447f:59a0:eb30:ec26%9]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 07:49:34 +0000
Message-ID: <2b13444e-f141-8fb1-5aa0-4ba11eb23e21@amd.com>
Date: Tue, 28 Jun 2022 13:19:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 00/35] iommu/amd: Add multiple PCI segments support
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
 <YrQcTUuGtav+ueTe@8bytes.org>
In-Reply-To: <YrQcTUuGtav+ueTe@8bytes.org>
X-ClientProxiedBy: PN3PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::15) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 416a0bbb-22cb-414c-f288-08da58dabe1d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3035:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aPmwvS1QQqEr5WL0f8GBobYfyC4vLymcU2M4H93SI5Wn9CO5Z5efsy9SiG10ByCkFtArYMJgKzenR582oE8M4lVFhcD/Cx7/pv7Xx5yYhhP/f/JErLoN8DbfHq6UU01hg42Pj55p8NyOBC4/9ULGhsim+Zum2/w3eOTvcfnsj+UWRYf4qZxfSwOl79Lvo9VFKBnnWJ7H4P1L+J6GbyBn10G7yJgUd8kuOi6ud+Ezr5dOYtL79/ydvFErrJUAyEHo19RAetj8n/oIBR8QjpejEs3F04gLHHJp1k/Ak5NpSeNleq6ejbig+svtExBhbeT9FS0O37krhU+7VnO9lh2nrXdIJOf+pyuczODYmO/TNdrgzzB5liT1dLXNHYohvEp+M8NZGJ2BoDPR+hT2MIjkSKIH0772WH2IhvthR1rJXrc+cHp0NSH7j5i/N+J4CG2gJInsx1o163WPFRs4iCIYsKoCEL/QVNkk58iegdjYWKD5tEOACzMUYzmudWAbkKr3t0q16s68o9VCrZu2upRrZKYWtkCpSpFN05xQawZ6Ojn4X6SSikSq3V7E5KVa/4a50bI0jJBGgRH3q9I9BfBWnUMUulWID2OcEEp4fHPxybNx9zm6VqieC70kuQl5+N6BcC1wC4GX6jQIAncg0I8WgYmbl0D66i3wbZlNkg+nwW4uGKYzgKgBrweKLRFSo7AE6JozhULUnHQ5MmNUnVnji27A43owi9ivS4TylTCGY9asfbX3X5yrvTGw88piK04lWUEBtylw/KQ6W6afH2eu1IgyeaBj9cQgjvRJO6jkV/YRUhtsb+hjrtyrmv9e1cD6JurjclQuFXMH5CaPlG1d+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(38100700002)(8936002)(6916009)(186003)(36756003)(316002)(31686004)(83380400001)(2616005)(5660300002)(478600001)(31696002)(66476007)(86362001)(26005)(66556008)(6486002)(66946007)(8676002)(4326008)(44832011)(6512007)(53546011)(2906002)(41300700001)(6506007)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFNXSEUvbjF1bDM5cGViMFd1TTJyaFVjWE9XK2s4WXNzUEhucWJjT0dUY0Ey?=
 =?utf-8?B?dDdoRHhWd004WCtTcUlZd2hScjdiTFFrZGJQRVRaVE83aEJMSS8yamlTTko3?=
 =?utf-8?B?dCtJSkpUd2MwU0lPOVdQSVVMSGFSV2c4Z29MVjRIRXZjcy9sTXNOVG9wU3pF?=
 =?utf-8?B?eUdrcVFwWTZYNXdNcjJUTFptVGZQSlp4TFFxTmdOWlV6c3hrSzVuUjdPKzl0?=
 =?utf-8?B?Sk5sWUNQeU5aaFQwOUpuSXdobWIvbXM1d2JKajJxZ0dxOFZxbHRxMVBTaTZ4?=
 =?utf-8?B?VWZjWWpIdHNvSEpFaGFZK1ZrZGg3ck9kdURpTWRFV0VZUkN5RXhkRzJ4NTdQ?=
 =?utf-8?B?OWxXam8yMlB5MWoxZ25jazVzUU5oM0t2NmYwM2E2MklGeHFnRnBlQ25PV1po?=
 =?utf-8?B?clRYSGI2OHpmb1hPMU0veGlJTE8reE9XanF0TkYzbXphbStJc0RiUGhhanc3?=
 =?utf-8?B?d2MwSlZNQ2RaVWRkaktzWFJnTitubkNRTldQR3c3WkR6WUluTUNyQ1EzaUxk?=
 =?utf-8?B?ZTJndkZvaWVTbFdHQzhBUzZWZ2tmeEt1bHNKWmFtbHhKWmlaeEtCY2FhOHZp?=
 =?utf-8?B?dUw0Z3dVL21pOUlvaGRHZ3FrcTBCek5Kckh5LzBCRm1QL0MwSHdKVUdZNU1O?=
 =?utf-8?B?VmdGeDVwV25SbFpiSUN2dTB2OFhXT2VYbDVIY3pWT0M3Q3FBb2hMTURQSUxu?=
 =?utf-8?B?NmczS0tqUzQ1QWdMcjlZSTcwOGhJb1N4ZzdvSys5ME1QcDdXWFZWdXg5eTFl?=
 =?utf-8?B?ZmhvQm1SelcrWWlwbmdXQUZuUERkYm1hTTZ3cGx3MHp5Z3dRdCthZm4wQ0dS?=
 =?utf-8?B?RmxvSmVDUWp3VHNIS2FSeHBzNU5YdHhoa2pxdHE4MjZ5T04wOFdsTlUwK1pj?=
 =?utf-8?B?U3pMMzlrOXJsYWR1bW90SytEM1hLMC9pSlhuMW1rdDJzb2JtOGhWL1lBdmhK?=
 =?utf-8?B?Y0h4NFIrQzNPZFBGblluTDRuZ0t1Rk5Zd2IrMEZCcmkrVmoxaHlWcnpTbjB0?=
 =?utf-8?B?TGpwc2txOHp4THp1QUhjWGFQbWhSZFAyaDg5WWNQUlRUTUJmWUVadkVKREt5?=
 =?utf-8?B?aWxlZzkzbElxRXpvbEZsVjMzbkp6TzFJeWE5OStUQWF0L3Q3VmdFUUo4SWlJ?=
 =?utf-8?B?b3ZVbkRLU0s0NitpM0xxZFhnVHo1NW1jVkFEWXJ1WWlpdVRhdGdpT0VlSkVi?=
 =?utf-8?B?OHJuVXBaTTg3TkJFYWpSZy9weXcxdER0a2JkaCtId3JBSVBrMlozaWg1TTFx?=
 =?utf-8?B?NU1oNnpmckNWdUlmaWRkeHluMTFYM0QydWdpTGlEZ0tHLzFHMy9yUDRETTBy?=
 =?utf-8?B?VW1qZUVhZEZzb00xbmhLUDlVa3BaajdSR284b3lQVDc5ZXQvQnJLNEs3c3dN?=
 =?utf-8?B?ZEt5R0FHM1NKRDVtWTY3ai9tZDJKZnBtZERwYUNmL2hFbmF2OVRNR3RuTnQy?=
 =?utf-8?B?QmJrbUs0M2tFU092a0xsczNyK2hxYTczbWpOd3pXWmNHNmtPbHZHSDh2WFhu?=
 =?utf-8?B?RFRXVHdmMUtLMXlHcjF3UWdtSHdYbm82bkJrdnZJU2pyYTNqOHdxdHlkblhO?=
 =?utf-8?B?VUtJZ25tTW5yTnUrdjRjQmFiVzVXNkhNTkRFOENRd2VLb0x6QW4zdVRabUhk?=
 =?utf-8?B?d2FrRXRjQnFyS05admhjay9PTXRUVklocks4NTZ5Zm53dWFaWmxzT1BkWlpZ?=
 =?utf-8?B?c1Brb1l0MmtJNXVCdzdBamMyMGRWUXFzK1FCbjJ5UUd0WlFGeDNyTktMeGps?=
 =?utf-8?B?WFBRUjU5Qm92TG5tbWZpR1dUQkxhMTlLOEpyYy8wVGw3bmpuSXlaa3dXQmJ4?=
 =?utf-8?B?dlpjT2g1a0Y4a01EY0t2ZlFjSXFkaDM0NmF5TzIyd01GRVBpRmY1N05rSUFv?=
 =?utf-8?B?RVhVUUIyMGNrM21lVTg3R3hkU3hiKzIyV1lZY2I5VVprdW12enpWaEcwamxt?=
 =?utf-8?B?YXB4RTd0bHROSU9UYkE3a1VMcVlRdUJHK2V1NkxGTFpzRGM5YW0zNEhXTXhZ?=
 =?utf-8?B?QjJML2FSUXExZTRXQi9FOFVzNEVYd3dFaGNlUDlSQjJacHFkbEJZZU9aUUJx?=
 =?utf-8?B?dG1jZ3ZwVUR0aUJidUdxaGJVaGRuUDFJVjR1ZDFYL0loTzlJRWxleWFoMDZP?=
 =?utf-8?Q?PwQzBuSnf8aU+vVB5zqBV701y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416a0bbb-22cb-414c-f288-08da58dabe1d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 07:49:34.5232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/r4PoHsrGctQ64Rr8Dg/TkQe0P8fHtn7KYd9VpdByChVHUdzY1CswJ6iV+Ba3QMWoiHFZe58F1TEQNiOV/Inw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3035
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

On 6/23/2022 1:24 PM, Joerg Roedel wrote:
> Hi Vasant,
> 
> On Wed, May 11, 2022 at 12:51:06PM +0530, Vasant Hegde wrote:
>>  .../admin-guide/kernel-parameters.txt         |  34 +-
>>  drivers/iommu/amd/amd_iommu.h                 |  13 +-
>>  drivers/iommu/amd/amd_iommu_types.h           | 133 +++-
>>  drivers/iommu/amd/init.c                      | 687 +++++++++++-------
>>  drivers/iommu/amd/iommu.c                     | 563 ++++++++------
>>  drivers/iommu/amd/iommu_v2.c                  |  67 +-
>>  drivers/iommu/amd/quirks.c                    |   4 +-
>>  7 files changed, 904 insertions(+), 597 deletions(-)
> 
> So this is applied now to the IOMMU tree, thanks for the work. Something
> that bothered me while looking at this was the almost complete lack of
> locking while accessing the global data structures. Some of them are
> lock-less, so it is partially fine, and most of them are used read-only
> during system runtime. But I would appreciate if you and/or Suravee
> could look over that again and check again if there needs to be more
> locking.

Thanks. We did look into the code and we think it should be fine for now.

> 
> The current situation will fire back at the point where you want to
> implement IOMMU hotplug. Note that device hotplug is already possible
> today, either with real devices or SR-IOV.

You are right. We think IOMMU hotplug support needs lot more changes
including locking existing global structures. We will look into it
whenever we support IOMMU hotplug.

-Vasant

> 
> Regards,
> 
> 	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
