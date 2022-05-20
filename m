Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EC0C433F5
	for <iommu@archiver.kernel.org>; Fri, 20 May 2022 12:13:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C9F34174D;
	Fri, 20 May 2022 12:13:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aUtwUQcqDCKh; Fri, 20 May 2022 12:13:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CBE04424BA;
	Fri, 20 May 2022 12:13:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99EE5C0032;
	Fri, 20 May 2022 12:13:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40F5AC002D
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 12:13:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 296096135F
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 12:13:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MzfV7TVSbsip for <iommu@lists.linux-foundation.org>;
 Fri, 20 May 2022 12:12:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BBA1661354
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 12:12:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqGETRnPlDs/82u5lkxqNZhHOT4T1B01ZbvGZRIAlNs8ETeKNE1jyYv78LEVlcsgzkPeaDorIwpF6hrcAuUFhou4wrkYY+tjdSgqTYlEZDjHQaAd2Fflddc4kUWsTUMBHBFLifkXGQUBM8+Urv4SGR1PM7cbyOmAMJxo3LRRevUtKUamhjLG0AdvDUwG/ltjHZ9Xbinz7KVMUHxBOHJ2jj+FgMj/EtBeVqubvGY8h47DAGy2PSSu51rfB/xBwFGYiyx35KPIlxYHhQPz69t13urKwZodLaYKrJx7fxnhxXTbIn1+5MZ9843sWIISAwFVIs1cToBrjwLhQBYwxCkm3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vg+e0fO3BQHrILXamGz7U5KsWIWIKATklT/R9sdEpgA=;
 b=MOSERELmz1cQ4V0oP3V1b7fqWvTTYw3rs6G29NwRaLzbg6lfHKg0HSgQnRhwd/11tonGWFVuXQi+t+Oe+UJLIhSzQYR63EDx7w47/xROXImirAlDtLN8PV+iXHzA5UbZONEXlQ68v7DknIQ+cieFgpV+wea3AeQWx/8eCyTJgu/eJBaJf0ApzpjWjbTsEdcMgRWL76X/YPrxlKvqTLf3ayZjsDG/9Nwn8fN/HEfY1Ow9AiaNbQrF4pDlppsCA52m3RWoApXDUVJWJLnA94L/16cMauj3hCbyU7QeUbHvJ7Tov+M8/US4xlAHQahoaZBRkiX83+WrnrlTREs90BC9sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vg+e0fO3BQHrILXamGz7U5KsWIWIKATklT/R9sdEpgA=;
 b=RC1AQJY3X7v1O4s+//LX/adieQL4hse3FV063yLIiqZ5BiQaNE/it77zOjP94g2+S2OYYZbUS33+eBs3nfkNEY4f91fZIpsJz/l76SWBc9zAkigvSWDrhiuGvsMjyqGtafbbX4RZIE2Dn0XTbo5ItR25yGnepwo12D+J8+vZaTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY5PR12MB6384.namprd12.prod.outlook.com (2603:10b6:930:3c::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Fri, 20 May 2022 12:12:57 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::84a6:480c:5f19:fc10]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::84a6:480c:5f19:fc10%6]) with mapi id 15.20.5250.018; Fri, 20 May 2022
 12:12:57 +0000
Message-ID: <b4fc189c-f5f6-b1c3-4ad8-5cd07b4a34b8@amd.com>
Date: Fri, 20 May 2022 17:42:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 00/35] iommu/amd: Add multiple PCI segments support
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
 <3b3b668f-64e1-1713-9126-59c7313bd894@amd.com> <YodnVsHH8B6ypep0@8bytes.org>
In-Reply-To: <YodnVsHH8B6ypep0@8bytes.org>
X-ClientProxiedBy: BMXPR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::33) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f6bd706-2ccf-4b8c-595e-08da3a5a1339
X-MS-TrafficTypeDiagnostic: CY5PR12MB6384:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB63842F656F964D978A4D796587D39@CY5PR12MB6384.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eT4GgsSG8lRjSxAPfBBkiGUO1xAZQIeHGteyfxkCwPwEchTa4vwgnpMqmH9CIXZbETZ0oNSxWatH6hG+c5Bm45chy+/ZdoC9LE+y+hpSp8Sjm0kqRStOFX7aGYGXoBybBJXewRcbOgbPFy+XLYc8U453TovbP69IIPRiN3ien9Fa0ZHCHgsL/SiD6IoZJbWwLmBVnXiEl3vinRzFjpLHCTgqJYiMkGjDkFSlwHamj6gotST86YTMD99T9gEGdy8BKX0q5s3mA8fowqeJCin1r27N8j6CCtANs3fkqMI3lEIHib9XOs9SZm9evqTwoxmu/RMtOrE2IZqnQLfTx1IeaCMDXvH3p3J4OiGz+6+JM1cWJ+iPSeAVwUVhiBnNfZbYc1DZnJQ6NyDvQilqsVUeFP/DJQGoCGjs9iYlJbMI6gzzfR0pZ94CfMF/rhuhPDzKvqsnxwfqb77u5fCZ1GBW50Bi/VBr0sI+k3fKaLYAlHRzeGKbj2i5AlBheUkgLN/hu+U7xHWbjZc/XXYnP6h82h3Nc8AYg3NyxJvsddmW/wqfmDrM7lOeRAb7coTgyhzqzgvDnLgTWRMe8v9vQbZiAFbOwD1MAqPqOobaB6XQSdQJ/+fC0SDCZfL/qXhC18kXjGW9VuY60bItpmtwPJBOedz82dOcKvUnRRcyxBFFmH5dva8NqvgAdUdAOp+QAYG3+A1nYqje4bEjcVtcZOqoM5bf8tm5AyzTbJ6knpaqWpI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(44832011)(26005)(8936002)(2616005)(508600001)(2906002)(53546011)(6506007)(6666004)(6486002)(4744005)(86362001)(5660300002)(38100700002)(6512007)(83380400001)(66946007)(66476007)(8676002)(6916009)(66556008)(31696002)(31686004)(186003)(316002)(36756003)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWx6R2MySXd0dk8vdStSd1J4TG9ZWkthcFVyRDEybi9aZUJlNm9jelc5dlR6?=
 =?utf-8?B?Qk1SVlB1STNiNThLdUFoQWd6V1N2eWJlRGxDWjlLS3g5Rmd5ZWFVa2IzT24w?=
 =?utf-8?B?OU5BMW8vU2RXRkxGbkE4TmhrVnZQUTR6Y3prTWYyR0JMdE53ZXF6NEVWUXY4?=
 =?utf-8?B?M3NyMFI0OTRLeHduSFlCcnNPMU9CaTJ3NzJDeHJObTROVDYyR2VFcDZJMEM4?=
 =?utf-8?B?QzNnNzBzQ1RUemYreTRicm04dXdHdzZqV0FVREVLY0hSVlY5V0FhMVoyT2JN?=
 =?utf-8?B?VER5VnFpWFVBNUZkdzJRVUVkeERsdG1GT3hHZUNvdHdsRDNNN05FSkRndWx2?=
 =?utf-8?B?L0NtaDczbzVMU0dYUyt3SXVBbnVXL0hxM1NIbmZhU2h6cVUvc3pCdUFqWnNL?=
 =?utf-8?B?eVBDOW1qT1pBTnlXaUc3SmNFWWhDVjFUTXZXdWwwYWd3MFBFaDNub2Q1UCtB?=
 =?utf-8?B?UDd5bTB6NkRsaGdiQTBQNWVUd2Q2dERPb2xNQ3V4eU45NitFdVJrQTNsbEhm?=
 =?utf-8?B?QkRtWmVCeXZqck1nbVlhMTNEbmg5bVliMzIyY1E5OGxlMTlGdmNFbDAwS09s?=
 =?utf-8?B?T3EvL1puMEhmbXhIM0J0ZWprZHdrZ3U3VldnSU5KQ21Mc2VoSjB5ZVU5TnpS?=
 =?utf-8?B?dHRzY1FNV0RVZ1lXWWEyYnFPdkhOMnV5ZmVBY1lvV0RkOVcrS1RhK3h2d1JH?=
 =?utf-8?B?TjBMMkZBWXRRV1I3RHhJZVhNb0tFTVAveFJ3RFJjYWdBeEg0TWlpVjVSdWJq?=
 =?utf-8?B?ZXZ3RzVmcjNjcmQydlB1S1R6OUlnVk5EU3pmUWYyMHJPdU9MY2YyRW9YNWh1?=
 =?utf-8?B?Q0NTVEhIeC9xRm95TmVBOWdabDM3R1Q3cnFsUEkvLzJFQW44NWtSS1RTUGtQ?=
 =?utf-8?B?UUJlWitCbGx2TTV1T1pHY09pd1BDQ0huZkN0clpvcWg3M0M5ZDV5dGtZZ0xO?=
 =?utf-8?B?MmNVZUhGVlV3Y3drRnA1aTQwMy9xaGxPS283RGRSc0hnN0RaTGZxeTNONjU4?=
 =?utf-8?B?RE5LRFlkc2tWWTF3dVJrc0NHNDlnZlVDTjVXSHFHd1QzcjFNNktyR1pQQVds?=
 =?utf-8?B?K09GUHpwT29rZjlFaEw0SDhoSVdrcE05VXo4R2tJWExqNVRLK2ExclYrSm5r?=
 =?utf-8?B?eE0zd09BL1p3UEdYWXhJdnJnRTk1WU5qRGtuaERDRVBOREthQzVJQTFuWmkz?=
 =?utf-8?B?cTkxcE9LdzRabC8wb2RxaGRCUFY3eHFrSUI2YmJrd3pDaFpsdjBDajlhbDlL?=
 =?utf-8?B?VmxDVlNUVHdsSmsyVU4xUzdlN3JXYmQ0VzlrTEtXR1V4WkRlUTRydFo0ZWlO?=
 =?utf-8?B?OUVyWDdNUFRKSVVVR2FQL0ErTTVHenBzNGJJei9ZR2ZGZmFpcVEvMjhqaVZO?=
 =?utf-8?B?WWFtdHhvVy9oSGdhR2RObEU0dzV2MmZnc3M4V254emkyTUc5cUdxNFY4SHpz?=
 =?utf-8?B?djc2QkVwY2ZPaWJKRXdLalh4ZUZGc3FqZC8wUTdmVHZmY3ZkWUkxSWFVVTVm?=
 =?utf-8?B?dGtSWGV6MUthVXFDcTQvYStDY05pZ1ZQVDJTcVN4N0RxZERjdzRzT0FlSjJL?=
 =?utf-8?B?VENmOHczREZkWFRyYzJhcmszeTBhQmdSN2pRVTRJOGF5ZEJCY1d3RXYrWmR1?=
 =?utf-8?B?cUlPUUo5NS92TFU2dmFBbU1qTXZGb3VFVFBFVzdWZ0VZejBxZXpCUlJGRmN5?=
 =?utf-8?B?WnhSQTg5QWtWVmczV3UwdDNjTmo5NU42NUwwMEpOVjRWdVV6ekt5OG5wd2d6?=
 =?utf-8?B?SEtCS0I0SjRuTlN6dEQ4VTFtQjZlRmk1d2lpTGI1MlJ0Ty8wTHFabVlQTU1C?=
 =?utf-8?B?amt4OHhGNXlMZjk1MmZSVlpuenI2STExclRFTXZGUFZsZzQvY29DSFNhaVo5?=
 =?utf-8?B?eUU1NDVRRG9KWTEzdjdvV3gzcGNENGVqNTNNR1RJRE1WWHNsSG9lOFpFaHdp?=
 =?utf-8?B?dU5QalB3MGJKcU8wamhzc0kyVk0zbHlIcG9KUi9zOWE2a2l3eWp1NEIxTHlZ?=
 =?utf-8?B?VzUySHQrSTB0Z2lEVDVua2YwMEM1WkVSWUx2cnRwOHdUdEtQK2tIeTRIczJJ?=
 =?utf-8?B?Q2laeVJHWlIvTCtXa293VWp2OS95d2thZzg3L3p1YVFIRmJ6TTlNQ2RFekVE?=
 =?utf-8?B?SXQ5YzdsY3B6ZDIvaitLYkR1Z3VCNTV2cjM4TXd0NVVWei9ZTkU4a09FTU4r?=
 =?utf-8?B?dnU0MDZQekE2YWxRUmRYUE5UKzRWQklyZEU3M1hxSWhFN09mUDlQOWhyeTJN?=
 =?utf-8?B?NmszeHFPRVdQVEZpYzNaMkx3WVlSZnc5T1BycWo0WmIwdmd0NzNUdDFWTlpD?=
 =?utf-8?B?dDVRS0R3S2lLMlBzNmlvakQySmpZeGFIKzBtZnhzam5VdEQ5d1JsZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6bd706-2ccf-4b8c-595e-08da3a5a1339
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 12:12:57.4245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgpR5ZeFaD+9KF3yl02EiGy/JUqkalTD0Y2ZyPzt8wFg+PsLdGQEtppBP3WYRAmG3KtEyI/NgjQOmwJrmkk0CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6384
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

Joerg,


On 5/20/2022 3:33 PM, Joerg Roedel wrote:
> Hi Vasant,
> 
> On Fri, May 20, 2022 at 03:25:38PM +0530, Vasant Hegde wrote:
>> Ping. Did you get a chance to look into this series?
> 
> Sorry, too late for this round. The changes are pretty invasive and
> merging them at -rc7 stage would not give them enough testing before
> being merged. Please send me a reminder after the next merge window.

Sure. I will remind you after v5.19 merge window closes.

-Vasant

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
