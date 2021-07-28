Return-Path: <SRS0=45t2=MU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDD9C4338F
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 21:51:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B2E60FE7
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 21:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D1B2E60FE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F2A160730;
	Wed, 28 Jul 2021 21:51:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7cs92PosVEvg; Wed, 28 Jul 2021 21:51:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3FCD3606EF;
	Wed, 28 Jul 2021 21:51:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16BF1C001A;
	Wed, 28 Jul 2021 21:51:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DE4FC000E
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 21:51:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EB0154062C
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 21:51:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QINbv_NTLt3r for <iommu@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 21:51:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9A61A4062B
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 21:51:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9LuhIQRjGAKRV+u99/yd7Nn71bSIGq43CoC2ob+Cw7b3bLtuQ5qL7Kii1ZTBrbRMTYBSzcvS7q9WQLEz7W93OrVKDu6M2NbZ/j1an1tzCTmbG0/BvHTiwZXxExeOXighRVZfbT3mtEaNLTt16g/Cz+xjoPJbJ1FQjofkbWo5SS9pL4uI/fFrnDkJyq+RqCyPkqWYmG2rq6+7Qhtl+GTBkSvxUa647/voP1GBnT1EN/GYTTlxp6SfmI+kcauPAm0A7LnX4+3RR/TGKvKqYJhWcDTPVujmP0P9tCiYxJzXaQO5SXK4fHa7fc6MNJoZK7IIXuEiTxXsgY3PlnBt2C59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzNPZpdua3KUbCkOet0ATzQWCeSzrMRDTNInIbO/8fc=;
 b=hgA9i0hM4YLz0zPZQVGxRHuTIpZz2O5LnRFmM5u9t1bsUUT9Yy16dS+8OyquYl/r/wwzklY75fxhQt946giz5gEnoqZxSf2kivbALcinlsfbHE3ylkKTKMyXp38yMneog2J+oRaWZKqU+Rt03Jbol2X6khSm2pF/crgIxuXcrdvx2Lkwn307RfF4o3Zy+cyucSS87WInDPFvkzd0gtSpCllOyo++og9Xl72kC9EPQk188opic91PdU7qaGP2Py+H6UFNq/zG+PeVWZb0LerdmegsipjQ4X2Kc21lbOEi3Hwy5nS4tnMTANB3lN9plxh954iOB9rpgixkT+nk1G6idg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzNPZpdua3KUbCkOet0ATzQWCeSzrMRDTNInIbO/8fc=;
 b=zub4ROZrqesuicuTY1Y/2TXIoNme4v0iHlVaM4ygmm1I87+lw6qMjtAOlw0L/uotCST8aL+oL6oJFC2xGmTVmXutMAIpBln3fFwsRpmI638JaFEsyLUoX4BPUNlejAYWUig7M8wW3zgaTuHzr0LaskeDdHTBNf/uX9/lBc4p9hk=
Authentication-Results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM4PR12MB5135.namprd12.prod.outlook.com (2603:10b6:5:392::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Wed, 28 Jul 2021 21:51:29 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b098:ccab:f79:9461]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b098:ccab:f79:9461%6]) with mapi id 15.20.4373.018; Wed, 28 Jul 2021
 21:51:29 +0000
Subject: Re: [PATCH v2] iommu/amd: Use report_iommu_fault()
To: Lennert Buytenhek <buytenh@wantstofly.org>,
 iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>
References: <YP7jbfRFxMeFONKl@wantstofly.org>
Message-ID: <8cc39d3c-6086-cfe3-9743-901c51ad4bab@amd.com>
Date: Wed, 28 Jul 2021 16:51:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <YP7jbfRFxMeFONKl@wantstofly.org>
Content-Language: en-US
X-ClientProxiedBy: SN7PR04CA0168.namprd04.prod.outlook.com
 (2603:10b6:806:125::23) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.65] (165.204.77.1) by
 SN7PR04CA0168.namprd04.prod.outlook.com (2603:10b6:806:125::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend
 Transport; Wed, 28 Jul 2021 21:51:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d38b68aa-2a39-4c84-6050-08d95211db16
X-MS-TrafficTypeDiagnostic: DM4PR12MB5135:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5135CE51C07FE3BBAAAD2C5DF3EA9@DM4PR12MB5135.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7lNTX6RQTtbtKh8CJlDZXer0wPUtUT/CIPg5Av4ya5L7jd06GqNIZqriHFjcIYExfRqdIfprxjoT1AKvCKBufqJo2mvaM3pquJfNnEhbtYZTnrLUc8VSgBF+ZRJqkG8YF99k2JHmEuqpRC4PeIeIGvQ9oK+wcikeYXLuVv4Fioo1fDU9A7UKc8fVAR+/wfuUMrBD6pPffHwLWQXaVxVTeLnocCE337iaY3fIUgXoxmAuTTmXIsnWbMv4aMANtXOyPPCqIibTJZtkAXcGInoKYBv/3Ey5yFy3KaOy/GtTdpzTraZiYWdXhOtJIyg9iJpaeis1N2+EeuNZMP/ullUeJZAVgFKmY2carxzz+336i9KPLgSj7fuk+fBCt70+WLrA8uuPf5HsnND4Dssks3bfH1n6U1b81KMsRQu8HDD5m5rGKzeUb2mJ0Ho9cQoqZMQbLukJEbB3WsmsQhX3zCvJo+05LFvdDBZsZrWyiFVmFsuQsqdrjYRCcKqDTrZnA+7dkrhsUS/ZYEFWK0yxDOcknkxu6/GXOeERK9Mrzy7ptvDoLXiuOR4t8pG7QmiVi/DrwHj6rnXQ0YbUl4DpXmvx4Tjbx2pKEk6xdnw5TXYHmdibHpE2eoOpKPNOV0J6ILK61SFZT8BOLzJDFbupdEaT67fE/nHDRbBdTCo+KRKfmI09Jta39LaHogxfX/85qyMvVoqlZ1elRtnp1dcp1/k26my3O/j17qxRYwGOq5ty+sSW+1wR/zBAfC0s48dphCrzjGbBZwUIk43cAmO5LsH0Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(83380400001)(8936002)(110136005)(31686004)(186003)(66476007)(2906002)(478600001)(956004)(6486002)(66556008)(8676002)(16576012)(66946007)(316002)(26005)(5660300002)(38350700002)(2616005)(36756003)(38100700002)(52116002)(86362001)(53546011)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUNLMmhkbVBYQ3dTdEdZbDlJVU9rMzZwT2VGdVF4LzNoTDRGbGlmNTVabnB3?=
 =?utf-8?B?RkVLenpnY2o3YUVLeC9ibm9YMnBvRTdqR2dzc1E0NW4xQmtRYnA1NTFMK292?=
 =?utf-8?B?R1FJYWFSTm4rclRYeURSN0k3SC9ObG41U25SbXRTbnA3ZUVjOUhicm8zYnFI?=
 =?utf-8?B?azlxZ2t4YUZIcE8zNnZqL2lselZqKzRlOWppd25GelBiM0JmUHpBS2RXM0d2?=
 =?utf-8?B?SzRwVm5UNTRWZzQyWVc4djJSLzQvckNuUFZXT0xRb1JpWjU2V1ptZ1J2WXht?=
 =?utf-8?B?akR4bDgyd3h6b1FiaVdWak5vZitxZW1NT0VmTlArUVdFUUdiSWFKTVNYa3h3?=
 =?utf-8?B?NjBuUXBSKzNhQmNFMWJRZlJGbXNHZFZuaE9UeUZxWG94WlJJMkF6YWZIdThx?=
 =?utf-8?B?a2p4WFRJdzJtYnhqNXFZL1hVRTM1anB4cXQ0Q2FPZTV1Z21WYjY1WDlrS0Vo?=
 =?utf-8?B?QjRvNlBwcGl0Q0xFdHVjRTNKeGpEVENtQmdYdUxPcTdLYnN5SzRZRkowbVM1?=
 =?utf-8?B?ZDBFTmtYclhwOG85WWswdnFES3NsK3pjVUZsaEVodnRtWENWMHlneFpObW9P?=
 =?utf-8?B?SXVvOEdnNVBBREMxR1BKZWR4VGdHQU05dHRIa0N4aG9tQUVKT3N4YnRJeHg5?=
 =?utf-8?B?M1BoK1BINUZzRmpBbktjOGhOMGFGc1NtTS9wbWJIL0ZNQlNKTk1wb0R3U0ZQ?=
 =?utf-8?B?T1ljNFZJUUFrZHlmOHVuVTFqSkcxeG5rVER3Z2JLSmRISXVyQXB1R1RuNmFV?=
 =?utf-8?B?bGVyRGVGL1NvVFl3eldPSVJPSlc0Ujh0RkxYWnJKWlcwOEFGM0NvZkpVZEYy?=
 =?utf-8?B?SlpJUDRtSXVzSnVjRVFBZ1NkMy9OZkhmVjk0QThFdFl3WGpsTVhxdncwd0o0?=
 =?utf-8?B?MlBEZnh6T2JMeTdkeHpEZGpXSmVNYkUzNVltcDVsZGlUOHBkWXdpUDd2UElG?=
 =?utf-8?B?S1l4SUJ2OFdPeGdZekNBTThyTU1jR2FtQzQ2NEFhVXhBQmg1cER6YVJ2THpa?=
 =?utf-8?B?eVIyNGl5d3dabHYrRXpWQXpEL3lvRG5PNUI4WjRQaWxTQUIyUjZ5QTY2R0ps?=
 =?utf-8?B?Z3RoN2ZOcUVvT2NpcmdBQ0FJTC9NdnJnYXNaVFQwRlJYMU4rM1hXWklOSmpz?=
 =?utf-8?B?eEc1UVpnVHcrelJmRHF6V2p1QW0yMlcwTnluRktxSHJrL0o3TWd3Q2c4RzdI?=
 =?utf-8?B?R0R6SUpBL2RGdVRyWnVxZkZqZ0ZFeUVwK1BCWmhaNXpibGVIa3ozVUxETjRv?=
 =?utf-8?B?MTdVZnhYN0xVVERjWWZZcUFtcVJUUnEyVkFpRnFDbUhqRmU1QkFBZEE1cyt3?=
 =?utf-8?B?N0pxdG84WkVCaUpteWRNeFIrcmx5ZHRsZFBzdXBWVnlGVjVxaHcwanVSQ1Nv?=
 =?utf-8?B?RTNCd0FTOG42TitJRkpvekxMUlJOZkVtNkZycCt6d0xnZVhNQ3J1K0p1bG9m?=
 =?utf-8?B?MERBcjFTNTZEdlJOT08yam45akFmTjY3UUpRTzhxekxiY0haQ0RONktqVzVL?=
 =?utf-8?B?S0N3ZjZSKzJaRW9NSDcrZUd4dlhvL3R3RHJIRkFERW1vM285Tm5QdVlHY2oz?=
 =?utf-8?B?aUt2d1hKV1AzSlRFV2NwbUdXY1Y2R1pRU3RmR0c0aWI5c0hvNDhWTENzWXNK?=
 =?utf-8?B?UGI2bmhmNGptKy9hRk9SanFNL2FoM0RVRTczMEI5SjNmNlRUQzBMNktORFFU?=
 =?utf-8?B?NG1FcWNPaGdVc0pFY2hmOUppdUtmUlhmRW5Kc2tzZE1ZcnhLVmpLN1lBdW40?=
 =?utf-8?Q?zIc9u8Utb4AuH5Et0/YE7wtcsIULQAVDMrunSbd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d38b68aa-2a39-4c84-6050-08d95211db16
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 21:51:29.5076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twgKAIozmUwAKyYbn5OhGKY/hHUpdgw0Dv7nGpkcu0OVUDmeISnEzRpj8Z6SCE8bXiYFDYtJd1jmBnFENXvaDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5135
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

On 7/26/2021 11:31 AM, Lennert Buytenhek wrote:
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
> 
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
> 
> Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
> ---
> Changes since v1 RFC:
> 
> - Don't call report_iommu_fault() for IRQ remapping faults.
>    (Suggested by Joerg Roedel.)
> 
>   drivers/iommu/amd/amd_iommu_types.h |  4 ++++
>   drivers/iommu/amd/iommu.c           | 29 +++++++++++++++++++++++++++++
>   2 files changed, 33 insertions(+)
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
> index a7d6d78147b7..d9fb2c22d44a 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c

What if we introduce:

+/*
+ * AMD I/O Virtualization Technology (IOMMU) Specification,
+ * revision 3.00, section 2.5.3 ("IO_PAGE_FAULT Event") says
+ * that the RW ("read-write") bit is only valid if the I/O
+ * page fault was caused by a memory transaction request
+ * referencing a page that was marked present.
+ */
+#define IO_PAGE_FAULT_MEM_MASK \
+       (EVENT_FLAG_TR | EVENT_FLAG_PR | EVENT_FLAG_I)
+#define IS_IOMMU_MEM_TRANSACTION(x)    \
+       ((x & IO_PAGE_FAULT_MEM_MASK) == EVENT_FLAG_PR)

Note that this should have already checked w/ EVENT_FLAG_I == 0.


> @@ -484,6 +484,34 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
>   	if (pdev)
>   		dev_data = dev_iommu_priv_get(&pdev->dev);
>   
> +	/*
> +	 * If this is a DMA fault (for which the I(nterrupt) bit will
> +	 * be unset), allow report_iommu_fault() to prevent logging it.
> +	 */
> +	if (dev_data && ((flags & EVENT_FLAG_I) == 0)) {
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
> +		if ((flags & (EVENT_FLAG_TR | EVENT_FLAG_PR)) ==
> +							EVENT_FLAG_PR) {
> +			if (flags & EVENT_FLAG_RW)
> +				report_flags |= IOMMU_FAULT_WRITE;
> +			else
> +				report_flags |= IOMMU_FAULT_READ;
> +		}
> +
> +		if (!report_iommu_fault(&dev_data->domain->domain,
> +					&pdev->dev, address, report_flags))
> +			goto out;
> +	}
> +
>   	if (dev_data) {

Here we do:

+               /*
+                * Since report_iommu_fault() only report DMA-remapping related fault,
+                * convert AMD IO_PAGE_FAULT flags to IOMMU_FAULT_xx flags.
+                */
+               if (IS_IOMMU_MEM_TRANSACTION(flags) &&
+                   !report_iommu_fault(&dev_data->domain->domain, &pdev->dev,
+                                       address,
+                                       (flags & EVENT_FLAG_RW) ?
+                                       IOMMU_FAULT_WRITE : IOMMU_FAULT_READ))
+                       goto out;
+

Regards,
Suravee


>   		if (__ratelimit(&dev_data->rs)) {
>   			pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
> @@ -495,6 +523,7 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
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
