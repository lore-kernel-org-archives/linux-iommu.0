Return-Path: <SRS0=8SnF=MO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F280C4338F
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 19:26:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D25A460E74
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 19:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D25A460E74
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97E01405D0;
	Thu, 22 Jul 2021 19:26:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LXrTNM4cBvlS; Thu, 22 Jul 2021 19:26:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1415D405C7;
	Thu, 22 Jul 2021 19:26:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8F48C0010;
	Thu, 22 Jul 2021 19:26:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46D1CC000E
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 19:26:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 39F4183578
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 19:26:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i8PoGVm9NeEY for <iommu@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 19:26:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E3580834D5
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 19:26:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/LXoiCJw4cNfX4tXBBXMQT3Wt5ITPj/PZ0qn388c9Q1L7eTIK3oDuQsCxqjrIWR5EtDreHtnr2EhicJenIiBKrwB6pekllZfrTHG1gD/E8yVCCusKDNJDpEPBJ7aTbJdfXrGVLAOfflfyiNixjeJ1ZPfhYOGpSz+j+Y1wnL86/pZPH0neFBrJwGJZX2CzJEgMtmoFCBmY2GmM2ZQjfBOE+2xBfv5yi/v7iaWru8ZBuuDehxAHkz8IYF9zfxjHnuVWbdh4YBzT1JBUVwytD5/JEjdtUuyi56V7UfRxcFlV4eBEH7zSyPtA35AiMI8ycNIY+sRYSe7sLBAIQ/86+WkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrejlFa0wF8GE1gNz5iL6G08U0tbAt/PZ+5+duezIts=;
 b=lhnkBH+owdzc1KSD3z4EseJLHp3z9MumZv9MTJDb8rQuR7209/Lbh7md/Ou9rYuS6faG+u7El9XMKINqAHTOluluEaA/l2B7zOxFL5ZEj3RiqSRlrJ4ouO8z83m9Ko8/exE9MQYDjWDlqWDdpMdAzDdLwgxN4dVt2HyhYAV/tKy0Kri6YdCi4DzsuF8hcQM7zN+PuoWyfLdKbFET84iG+smWKPs4N+pNYgk9m4MKm7Laku7pcj4af/MQnXu0H6hd6CTf2peJ3f7fz9DI6ErvoofNTTxMAsphO1DBMGiLmF2Xep4QfWnQNB4hDF5cms1LyGlQ1hAeovC10gnYsHKHNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrejlFa0wF8GE1gNz5iL6G08U0tbAt/PZ+5+duezIts=;
 b=gh3eAx+zhir+fc+8Wf/7K1VABmxrTj5e07cwmxIaqoUWNvVR9SiGt1CCS6I8+Hz5vaaCyDib+UkBlo2T6DJSSV4cLVU6zXaXKvHehv+rOWOrC1Cxj+C/7B+nYn489hiVlshuIxx3NEz2Dn1tqg02eKbuGmmr8wCnZhx+mLB3wjU=
Authentication-Results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.26; Thu, 22 Jul 2021 19:26:10 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b098:ccab:f79:9461]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b098:ccab:f79:9461%5]) with mapi id 15.20.4352.025; Thu, 22 Jul 2021
 19:26:10 +0000
Subject: Re: [PATCH,RFC] iommu/amd: Use report_iommu_fault()
To: Lennert Buytenhek <buytenh@wantstofly.org>,
 iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>
References: <YPVL41ZO8Ih8WrKa@wantstofly.org>
Message-ID: <b6550702-3926-c12b-bbbe-8d96cd677dcc@amd.com>
Date: Thu, 22 Jul 2021 14:26:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <YPVL41ZO8Ih8WrKa@wantstofly.org>
Content-Language: en-US
X-ClientProxiedBy: SN4PR0501CA0141.namprd05.prod.outlook.com
 (2603:10b6:803:2c::19) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.117] (165.204.77.1) by
 SN4PR0501CA0141.namprd05.prod.outlook.com (2603:10b6:803:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.7 via Frontend
 Transport; Thu, 22 Jul 2021 19:26:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 410335e2-840e-448c-bd48-08d94d468f71
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5311076F7CBD5AD798EA003BF3E49@DM4PR12MB5311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9sXtYCvTFhzMXRsTx8YAtQJRwgabjk9QHdi+hUJhcS0tjufdUgx532W+Zapxztxn9wESo7EnerQuvX4KUElZTJ8o0CAqpbS32MY+fkE88lycMJ+ADyJoGovtw9NK4rXZ3L9gHXUe/skMDcFc/mgCiLgztIIWEwANy3nBEu6ajX/xFE7RcdXZSRQIzwUUOvpZAs/WG0vLSOKnvKiUJtvpI75Q99q4JBkavGJSv88gx4Y3di8cIw1HgO+hUQZiuRAuqxvZ1BdroasB1cMBAOW/wdH1yYe2CApR4zzALi2/gPq/NQP2nLeeRxS6uda+1ndzA4NcodHvsABu182cNSwJWlCfC6s4ALJrksjXyB0zraLeiDVczVB+jOgfVbkAnQ8hE5MNA37JU39nojWY9/mpd/27O8XP/VQmxnyTCgF59uq6CtyyVDJynd7qSEyQrGM4pX3mNMYmvT7aHUFSXFOQaR9ehre7i7P5HVVhg6ouADXeFc10U1NeR/j3FiVtEede6S/WzftzIIA4Ya9Ku7jiVrXLaYYt6igioXcdvqXiIHjQUk3rMsBZ3WE5B+b4Fhla+93aHs9blwDuw+6wFQDCsEpsFiOSLdj53GWXKIMtRtCqjFbllRAOooWpHoFA2NQ3pz4isACupCNRvj9PFjdnSaYjCYmVfx+AfQD8jrfkhYcyF7fh4E5GBlMPMPtLkfh45XfwLS2Wzwu8NBk2UcdByXmaG05E3tJta3HEepWTKUVX4WREPGKm8b4NL8t/gqCnyPvuf65CrcQw15mfVMYRyNQpmj7awRK9wQYMg8Qgdc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(16576012)(316002)(36756003)(6486002)(186003)(86362001)(110136005)(83380400001)(956004)(66476007)(66556008)(31686004)(2906002)(508600001)(66946007)(38350700002)(26005)(52116002)(2616005)(31696002)(38100700002)(8936002)(53546011)(8676002)(21314003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVRTem1UbUpHc21taWp5NXNiOEJaeUpkTFhabWNVRGNDYi9mcktVUDEzVWRS?=
 =?utf-8?B?ZFkvRTJrbUY4SGRGcUxYUmlXeFRLN2M5R2gzNFVTT1BKYzcyRlFLRnY0ZjF3?=
 =?utf-8?B?TWN5eHRhdU51TTRzd3lSSGw1eXllM05zRGZWTTBhOU0wdHRBNVVkSW5ja0tV?=
 =?utf-8?B?NVdYWnlMYTFSVnh6aHZXSjU3UTA2RnhoOUF3MnVoS2YwenZtMUtwVWtiSWdz?=
 =?utf-8?B?YnZuTWNWSFFHbjMzQ2NQUVh3VnAxMndGM0xFTkFtWTJKYnl3WFEvWnp5ZXVP?=
 =?utf-8?B?MS8ya0M2UUpFRVU1ME43emtZc0p4ZlRxNEdmd0tFd1Y5ZmMzRzY3UXVOUHlq?=
 =?utf-8?B?QkFkd1c3TzZTaksxUkdGdXFCelBDUHN5MHJITHNLSm5JVVg1cjhxTjF5aWox?=
 =?utf-8?B?UzBwSUFXcVJnWDhpam9LK0pKSjNEY3BQR2VhMzB6SmprV3pFQW0rcytVVDBv?=
 =?utf-8?B?Y3ZlL0MzVXAzVmlqZjJ3MStIVEl0ZFYvMlVKQmRqZEJSbW9PM3lFaWFSd0pH?=
 =?utf-8?B?WTJ1cVI3aGt6VTNLTHhhaG55ZzFCZXlJZG5sM3pzem91RTNOWFlhVWtyaGMx?=
 =?utf-8?B?U0lnYmsvSEZkT0RHU3dwTkpCdU9jUUJDYjEwNE4xb0IzZDcxMkJ5c0t6TS9O?=
 =?utf-8?B?WENPQnlPbnZ5ejBUM3R3Q0R1c0FNM1JrZDJSWEdYY0pzbjI2a210TEVIWUdj?=
 =?utf-8?B?T3E5RW5BN2JmV0xqSWpINVB2eGFXaDZacGFrTWJRczlUWENzTVBQU0RYWks3?=
 =?utf-8?B?RjJSbWk5YTllWGIyeFRnUng4amIrU3cvL0FWamUxcXN2OVF4eGhzVjhpOURx?=
 =?utf-8?B?UExHdC9CS0V1TjZGTUtUNC9nc0I0ZWk5YURCaG9CSEpxWmFUMDBtUFhNbDdW?=
 =?utf-8?B?SmpTeUpUR3JGY1pHS3J6UzZmVnhTRkxnQkJxczhuOHdrMzhaRnFJZjV1UmFG?=
 =?utf-8?B?R3RwWHhrTmZaUHBML1hHczRsWG1PejR1UnNOTWNQUmVLTG1qYkNjbFBxV2Zj?=
 =?utf-8?B?ajB3VWx4Vmw4eXp0MzhRV2xlNko5bDM1Tm9RTGZYNldsM0J2RTFLbGxNaEU2?=
 =?utf-8?B?M0swSi9uZkNuOG12Zis1MGR5azhmekwvaG1aRmxhYkhubFpmanpHTjE5Y21s?=
 =?utf-8?B?Ty9neXhBOTlxVlZaVWpGbmpOTklDLzc1bmRQV2M4Slp3a3ZUVGp1b2J0aHpr?=
 =?utf-8?B?TW1GczUyZ2dRdGhKOTFaU0JZUmJXY1VuUHhZeG44U0R1YmNXaGpqSzNpaWJ5?=
 =?utf-8?B?UWdxZkFnUTQ1VitXV3I0cG1EYy80OWxOVlF4K1huWFh5MEJjUG44bnBXNDZm?=
 =?utf-8?B?c1hJYnd6OHl5ZzRaM1BOSUJJQlQ4cVlBalpuMGNQV2RGM2NmNjdBaVdidnB5?=
 =?utf-8?B?V0N0K1BJOXZGeko0NzFHQlIyNWtmdEdjdjFpemN3aG5JRXpmV0dMUzRiYUVM?=
 =?utf-8?B?QzVlS21xbXBIUE02a21wRXN2aTZKY2pnU0xycDlWeVhBc3dkVTR5YkdHbnF1?=
 =?utf-8?B?VHlpdXVrdnVRM2JHcUthK1EvbytHdmttNDlIemJDOVAyS3g1Y1IwZGhXMkFp?=
 =?utf-8?B?SXQvMjc5YTVsNXR0WGVGOE9qUDhNRHBtWjF6enAvZFlSVGZQK2gwVTJTWllj?=
 =?utf-8?B?R3IxNjdMQkU1aVZjbXZKd2lnbFNCV283YlNNbXBicnJ6NUZ5enhzTHI4V2Ry?=
 =?utf-8?B?dmJuTUI0aWZiUXFOK3p4VFpOanJrS3UwaTFzamtXN1poZ2svQ2RtNFg1OEpx?=
 =?utf-8?Q?JAc/7EeRVd02B0fhgjhBnRjScGNymYBQs103gI/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 410335e2-840e-448c-bd48-08d94d468f71
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 19:26:10.0864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hdAOufmPZ+u5ZYxv96vCVgf9d4S1nfcSNhUDqZ3puYUsrpi/r9LFxhtRvlCNVw5awKYRIPi1OdA4+hfAbxuhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5311
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Lennert,

On 7/19/2021 4:54 AM, Lennert Buytenhek wrote:
> This patch makes iommu/amd call report_iommu_fault() when an I/O page
> fault occurs, which has two effects:
> 
> 1) It allows device drivers to register a callback to be notified of
>     I/O page faults, via the iommu_set_fault_handler() API.
> 
> 2) It triggers the io_page_fault tracepoint in report_iommu_fault()
>     when an I/O page fault occurs.
> 
> I'm mainly interested in (2).  We have a daemon with some rasdaemon-like
> functionality for handling platform errors, and being able to be notified
> of I/O page faults for initiating corrective action is very useful -- and
> receiving such events via event tracing is a lot nicer than having to
> scrape them from kmsg.

Interesting. Just curious what types of error handling are done here?

> A number of other IOMMU drivers already use report_iommu_fault(), and
> I/O page faults on those IOMMUs therefore already seem to trigger this
> tracepoint -- but this isn't (yet) the case for AMD-Vi and Intel DMAR.
> 
> I copied the logic from the other callers of report_iommu_fault(), where
> if that function returns zero, the driver will have handled the fault,
> in which case we avoid logging information about the fault to the printk
> buffer from the IOMMU driver.
> 
> With this patch I see io_page_fault event tracing entries as expected:
> 
>     irq/24-AMD-Vi-48    [002] ....   978.554289: io_page_fault: IOMMU:[drvname] 0000:05:00.0 iova=0x0000000091482640 flags=0x0000
>     irq/24-AMD-Vi-48    [002] ....   978.554294: io_page_fault: IOMMU:[drvname] 0000:05:00.0 iova=0x0000000091482650 flags=0x0000
>     irq/24-AMD-Vi-48    [002] ....   978.554299: io_page_fault: IOMMU:[drvname] 0000:05:00.0 iova=0x0000000091482660 flags=0x0000
>     irq/24-AMD-Vi-48    [002] ....   978.554305: io_page_fault: IOMMU:[drvname] 0000:05:00.0 iova=0x0000000091482670 flags=0x0000
>     irq/24-AMD-Vi-48    [002] ....   978.554310: io_page_fault: IOMMU:[drvname] 0000:05:00.0 iova=0x0000000091482680 flags=0x0000
>     irq/24-AMD-Vi-48    [002] ....   978.554315: io_page_fault: IOMMU:[drvname] 0000:05:00.0 iova=0x00000000914826a0 flags=0x0000
> 
> For determining IOMMU_FAULT_{READ,WRITE}, I followed the AMD IOMMU
> spec, but I haven't tested that bit of the code, as the page faults I
> encounter are all to non-present (!EVENT_FLAG_PR) mappings, in which
> case EVENT_FLAG_RW doesn't make sense.

Since, IO_PAGE_FAULT event is used to communicate various types of fault events,
why don't we just pass the flags as-is? This way, it can be used to report/trace
various types of IO_PAGE_FAULT events (e.g. for I/O page table, interrupt remapping, and etc).

Interested parties can register domain fault handler, and it can takes care of parsing information
of the flag as needed.

> Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
> ---
>   drivers/iommu/amd/amd_iommu_types.h |    4 ++++
>   drivers/iommu/amd/iommu.c           |   25 +++++++++++++++++++++++++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 94c1a7a9876d..2f2c6630c24c 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -138,6 +138,10 @@
>   #define EVENT_DOMID_MASK_HI	0xf0000
>   #define EVENT_FLAGS_MASK	0xfff
>   #define EVENT_FLAGS_SHIFT	0x10
> +#define EVENT_FLAG_TR		0x100
> +#define EVENT_FLAG_RW		0x020
> +#define EVENT_FLAG_PR		0x010
> +#define EVENT_FLAG_I		0x008
>   
>   /* feature control bits */
>   #define CONTROL_IOMMU_EN        0x00ULL
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 811a49a95d04..a02ace7ee794 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -480,6 +480,30 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
>   	if (pdev)
>   		dev_data = dev_iommu_priv_get(&pdev->dev);
>   
> +	if (dev_data) {
> +		int report_flags;
> +
> +		/*
> +		 * AMD I/O Virtualization Technology (IOMMU) Specification,
> +		 * revision 3.00, section 2.5.3 ("IO_PAGE_FAULT Event") says
> +		 * that the RW ("read-write") bit is only valid if the I/O
> +		 * page fault was caused by a memory transaction request
> +		 * referencing a page that was marked present.
> +		 */
> +		report_flags = 0;
> +		if ((flags & (EVENT_FLAG_TR | EVENT_FLAG_PR | EVENT_FLAG_I)) ==
> +								EVENT_FLAG_PR) {

Let's not do this check ....

> +			if (flags & EVENT_FLAG_RW)
> +				report_flags |= IOMMU_FAULT_WRITE;
> +			else
> +				report_flags |= IOMMU_FAULT_READ;

... and then we don't need to translate the EVENT_FLAG_XX to IOMMU_FAULT_XXX flags.

> +		}
> +
> +		if (!report_iommu_fault(&dev_data->domain->domain,
> +					&pdev->dev, address, report_flags))

Let's just pass the "flags" here.

Thanks,
Suravee

> +			goto out;
> +	}
> +
>   	if (dev_data && __ratelimit(&dev_data->rs)) {
>   		pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
>   			domain_id, address, flags);
> @@ -489,6 +513,7 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
>   			domain_id, address, flags);
>   	}
>   
> +out:
>   	if (pdev)
>   		pci_dev_put(pdev);
>   }
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
