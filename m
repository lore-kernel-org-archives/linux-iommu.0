Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BCEC433F5
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 14:39:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 509CD4040D;
	Fri, 29 Apr 2022 14:39:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id luqjNVZdO5XL; Fri, 29 Apr 2022 14:39:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1C1484000B;
	Fri, 29 Apr 2022 14:39:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6D05C0039;
	Fri, 29 Apr 2022 14:39:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9522EC002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 14:39:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8370560E2C
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 14:39:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0WwTcSQ1pRJy for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 14:39:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::604])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A7EC9605B2
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 14:39:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxX2p/ba5HHRdJ+dZc+Vqd1Bb3n511sl+eCwyWOfu3YoE5hH0sMotWd9o0dR14KsxRbtqjRocV9CTP/emZaxcpdjKSB2Xl//5J/QCmreKs7LlFgy+Q0FtQv6yFlENQ+eoKe7MokPrK9HaRq4O6mh6J2ZI7LUrbPOjrT7VT0+KcwB+yPNJZNCgYNvVzZ1Wzh40kNI/izYH1IlpZ5WtIh6sp7GvE//95Rni0FQQw+JYBgPFppkAnDGaH+rsLKqY9/+RUOsP31d0TkMwA/Gtwie+39OSrVHSx0UkQHqBRTodV7j+lvf6J2QSWVJ8nyPk68HQ8rI9bA2dEOoalXn4atG0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8CH+g+UBUNlCV3hsf8C0pkY+z8ubpnabvBJrQJ0VXI=;
 b=PgzeW3fOpdXkFJPnmC5bdE6Zi0oz6NWYv/AJTjzlHOSxaNjI0Q1iZWBq5+GlUCK/pXM3zueQcIQLNk2qmpi+679j9cms5emTH6sLhAbeKDAN4B6RVI+m5nhgHFzBVgCFuDU3J2Lgam4ST5bRAzzOjK2NR9DFNuaw3pz4levMcwh/xpIfwBA2IHrbyWiFjtAWAAx2HsmzTaYlnzbpfG+SrxzMd0KicD23kwUaoIs80Q+VevB1zdiSovJFY/nyFryMHD3Da9kmNhRogbHQ98siEzrP6bAy6vqFwrD1nwYpsvPuJkYfa4jfQrPNt1L3DdWnDDI9Z/Bz5zxQzLonuv7NzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8CH+g+UBUNlCV3hsf8C0pkY+z8ubpnabvBJrQJ0VXI=;
 b=AWpApuyGQOjotDDLIyy+4NRQj08HIj1vkamMpl3yVUMDdD76QhBbHOuNcVrX0l5nsm6QwzmmW+Gq0e0B1M4PfrMhxYcksmzyBw2fB6Q6sCGxdVho+fGXIKy6Jihnx/AUw5m0lb/yQ5d1MEwpNQ9wYXtKH9csNCfDiLVpIArmiyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BYAPR12MB2728.namprd12.prod.outlook.com (2603:10b6:a03:61::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.17; Fri, 29 Apr 2022 14:39:47 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::309b:a704:5e87:8ce1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::309b:a704:5e87:8ce1%4]) with mapi id 15.20.5186.026; Fri, 29 Apr 2022
 14:39:47 +0000
Message-ID: <e26f0659-cb89-8742-404a-c3f2a586d6d8@amd.com>
Date: Fri, 29 Apr 2022 20:09:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 27/37] iommu/amd: Remove global amd_iommu_dev_table
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
 <20220425113415.24087-28-vasant.hegde@amd.com> <YmppXJOLePBTKbCX@8bytes.org>
In-Reply-To: <YmppXJOLePBTKbCX@8bytes.org>
X-ClientProxiedBy: PN3PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::21) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d808fb2b-9557-4141-4c7e-08da29ee1bee
X-MS-TrafficTypeDiagnostic: BYAPR12MB2728:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB272814581FFD5421DD0165F687FC9@BYAPR12MB2728.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9iSOICeIfJP34XrDw63mtgRu1Z1NiLRSH+kpxV163JP44LF67D1xCTRFUfmR8ZzJwjAe3HilJdUhk75F29aeLNCVXjoQDzUTJRuGqVMqXhjn4z101cH9tD5wNKHf9DciIPB7LjILAbL6gdLCpQeEbBsOfL5P3rr+sednhPgvhIKz0PemG76OEDM65Ns25tG0vDwaP4NXrMvLeFHg8IPWgMFa4iLIdsKmQgxQe3pbgLx99zuKuqe1T+XtgVhwJIlpxMLM4eDW50MVgMJRoZML9H2fNr1AyLN+MmbtIHDg4i/UReEs6z7QRXcE6W5cyuDoNI6pTXBHk2SVtbbMAbX22JbJ5e9GyBbGgiX6c6mlNDLEfcMwA0WhD9RmruqCKK5OVRJXxb8R/6AxFaiRM6gST12JggqW4hbfNWG2YrquTMxwmXYjhpcbBGn8fyHt6nPywp23942RbKld0HfXcdTBXEUkFH3lSWC56jR2beB/3MfTaZQr3fUTAN76oXU+b0+hd2btMZEDm9tU3sUWUZy3JNYE3sCeHdqkuzS2j3+EZzz3l6A3PwUP5HAzNIXPBGOnDeXHf+F3Z8J5XuKu0PMVrk5hmbvNn2q9fJQIAN4a1/T7cgaVd2v6cGfReUtZb6HmbNIMJO26NKKO7T7zov7v0n8nex0tKI9xEPwkH5vTAYYXlo7Abybg1EdnCGkHTO/zO+fUedeo/y0ajWS6rCcC5zwxv9Sox1gRbw1JF7vNK8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(508600001)(26005)(6916009)(31696002)(66476007)(6666004)(6512007)(86362001)(316002)(66946007)(66556008)(53546011)(38100700002)(8676002)(4326008)(6486002)(5660300002)(4744005)(44832011)(36756003)(2616005)(2906002)(8936002)(186003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDMzaklVWk1QZHJKRzdwUi9wM09jUGVFdE9OMnRzeU1WSFhDNGFTTzdBa01L?=
 =?utf-8?B?N2U4OTB2c09LOHJwZER1aUxoVGpxWklvazA2TXlwNEIxeURuUDRtY2N4UlRU?=
 =?utf-8?B?OTdkcGZCU2FSbGxVRGYvR0c3TXd3OHQ0ekNmb0g3NnhWRjFUc1pqaFdEZGpY?=
 =?utf-8?B?QzgrQnY5M0FxbHoyNlZqZDZXakNqcTE4Myt0VkVZQmVkWU5rR2kwd0ZrWHZD?=
 =?utf-8?B?bEs4dnFxS3JSSHovYjUvVkxBQm10cmJ5ejgzSzBjdTFkdll4T0ZUNmZOUVZ3?=
 =?utf-8?B?WHd0TWJNQTkyN0YxK0Q5cE02TlJQdXhkYzBZeitGbGM0SE5WeDU3cVdSYUh3?=
 =?utf-8?B?S0lUSlBBUEhrcWxPMEorUFhGNlQvZ1pabnZHdmk5SjJhcFgyb1Fuc2w3N0J1?=
 =?utf-8?B?WVRpS1hpbjNaNEt2dExhekMrUkcvb3pKdDcwYk1GTldzNFcvZzdGZTdtb2Yv?=
 =?utf-8?B?RHhTUDZ3VWJldFJrczVuUmd3a1BWRUUxekpIeFlBMmF4T0E3TGpjelNPcHZV?=
 =?utf-8?B?M0dRYllpN0pMWXd1Skc4QTNKeEd2R011WjJqVE1aZElJaEtVUW92RzBMNnQv?=
 =?utf-8?B?V1J1V1NyZEMvKzhTUlBtU0Y3eVdTQm4xekgwcmN4NFJZWi9jRDN3WUNhQmY5?=
 =?utf-8?B?cXNBbG1SVWd6ckdEMWhqKzJ2d0N6UVNUZXNwTlZGZXBEZ1k4WEpkNm1aVmhJ?=
 =?utf-8?B?UFZLVFJ5VFgwdXdISU1PZEZONExUVk5WVzNEWEhiZWdoOXA5eWx4MWFnSWND?=
 =?utf-8?B?UlBVSmx3YU4xNTA1WnRJcFU3cTdTR2JRRzNYbW9uVitBRUxwMzZEVlYvUXVJ?=
 =?utf-8?B?QWFXM3lGOVp2TEtIajdSdGpiQWJMT1ZPQ29BeWZYUEZLVlBXRW1vZ0hBUjVm?=
 =?utf-8?B?L0N4SWhEL0JPNTk4b0gvQThnTWFaNU9Nd2VEUkduVW1GeGxFMEZtQ0hQblhQ?=
 =?utf-8?B?RSs3R2EzR3pXSUtaZnJoN1NJaTg3S3UrWFM4aTBkWDFnUTNQdXZsd1dVbjAx?=
 =?utf-8?B?OHdhWHFIL05oVVppT1BmSW1zallTUm1mano1OWgvNGRzUENGK1BhYm9CQXhO?=
 =?utf-8?B?Um9zMzA0UTJ3b1F5c0d3ejVoVVRiYTB5TWJPeHZ0TC96LzQ1aDlZQmR1azdt?=
 =?utf-8?B?Q1htTkpTeXc0d3d4dGR6RVZmaFFUbFhaUVhNalMzWkg0SWJ2R3QyczJ6V2ZL?=
 =?utf-8?B?NzRlZnJySms1QUNrUWpXSnRIV3dJdk00enEzYWFvTTd2ZlVQQ1FCNlkwczRG?=
 =?utf-8?B?N2lhL1RBSit1ZXhuM3oxR3JGMkdhL20zZ1BqRURhd2R2Z0lMMGUxYmZQaEpC?=
 =?utf-8?B?T3RKYnVTTGtCOGpaWnNFU0Z5cmVSM3lTazJ1bTB5ZTN2VUNwcmFXaHB6RlQz?=
 =?utf-8?B?Nk1iWVhuTmlJSldoRzNKUlVneTJ6TzlZV2xTcFA4cklFeVIxTmhaS1lMaW95?=
 =?utf-8?B?YjE5ODJsZng4N04wWkxBZis4bzR6N0JtaDRrTjZOYkcwMWJlRy9ZMnRINTdQ?=
 =?utf-8?B?RmdwTWErNGkvb3l6WU9yT2ZSSXpaa25ROGV0Z3lNNlBuck43UXhNRE1MRGRW?=
 =?utf-8?B?Yk9xd3QxaEttblNja1RrSXB0bWxWeGo0Q1hOdmUrc1VBWkFmYndLTGdFRkFt?=
 =?utf-8?B?QlNQZVFLdGphM3Q3LytGMnBuQVpEWDlwSE0rc0d4SU5LRDlnV0diUmduc1dt?=
 =?utf-8?B?bFFoV0lIWldFWThjOHlkeEd2WHYvVVBCV05tK0tCdmVJajY1bzBRTFlGWWpM?=
 =?utf-8?B?eEo4TTkzWmkwRENOQ0hzMzNWS0J2WVRJQ2EveTZ1NW5ZRkRXMjVMVG1PK0dE?=
 =?utf-8?B?U0pQOW5VcUJ0cDgxdmQ2Nm1pUlRzb2FLcGF0QnFvR2xXaXlhQS9COWFvbHNE?=
 =?utf-8?B?djQ0eExTS3ZKMERyRmZLaXUwcVlrZ3RNOUtpeFhINm5jMCs0V2pMZHk2dDJ0?=
 =?utf-8?B?NDg1ZkJnVGx6WDRURmNWM3RscEVQS1U2L0luN1dCSHBLMm1GQXBYZktXOEVV?=
 =?utf-8?B?ckJlSmU2T2YxbzBtWGw2Zk1OQnUzY296SGtidDdrOFRhWFhvdkV5dFA3Zmd2?=
 =?utf-8?B?S1Nid1REckZUemFIT09MTGRGNXJTbCtGcytVRm0wU0Q0Z0gxWWVOb1Q2MDFq?=
 =?utf-8?B?OGl5MUljYmlMK2ExbWtJYndVV2JVSUM4SWxGWDA2dWRpZEdnb3ZHMG9qLy9Q?=
 =?utf-8?B?NktnUVN5QmNiMktlZWhic0ppY28vamdlMnBMbVZhTUVtYks1Nk1MRFFLNFh5?=
 =?utf-8?B?amVDY3NTQ2FIWWNDVTcxQ01QN3dNcUR0bm1taVZZSE1zd2dPQ2RFNzFJQjdF?=
 =?utf-8?B?LzV5T3A2ZW01Q0NZemMxZ2VQNklnK0ZaMWw4SWZwWWprcTVtamM1QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d808fb2b-9557-4141-4c7e-08da29ee1bee
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 14:39:47.7430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVdNblJXjNNk5mz4vSToUEy9YhHTyu0BbPljATmhHK5EZgcCfTbCgYqF/hRlunPvz+HHPrMHl6uB5Bu7ddMgzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2728
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



On 4/28/2022 3:45 PM, Joerg Roedel wrote:
> On Mon, Apr 25, 2022 at 05:04:05PM +0530, Vasant Hegde wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> Replace global amd_iommu_dev_table with per PCI segment device table.
>> Also remove "dev_table_size".
>>
>> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Patches 27-29 can be merged into one.
> 

Yeah. We can merge them into one. It will become slightly bigger change in one
patch. But these are related changes. So I guess that's fine.

-Vasant

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
