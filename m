Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3FEC4332F
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 07:34:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DAD0840934;
	Thu, 28 Apr 2022 07:34:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WWMMghJMs2Zq; Thu, 28 Apr 2022 07:34:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 74393416D3;
	Thu, 28 Apr 2022 07:34:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40955C0032;
	Thu, 28 Apr 2022 07:34:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FCECC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 07:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 57DF640117
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 07:34:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l_i1x4BVTvtc for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 07:34:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::627])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CC31B400FB
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 07:34:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crSrzTYJI6/FGN6Fyj/s7NPUFXRMeDHjGImA5aGyr778yl2A7ikUUOebjx4Qu6AW1fDxEVWnPCvZ+4Pz7ZnXNgvBrGflFm5AmzSsmXW/lHdVqcQuEk+iHHUW2k3w6P+twQn5W5KTRAjfifAhGlNjlfJlt8s85uKnt84n3njJAPmfwo5sOV9/veLCi54zj2ihXQKAwNzGifrrKTMIJrIxhlqbtozqy0PPUsFlUTPtPOS+hKdkYBnkMxsHJHpvh7P+VWRwM67aXLhlK1tbwAvcTPPrhgAYPNuo+e+GGgfYfoMnOHLL/9IIqNW40jPNt+MWnj7xrOgJkeqFu6xPMkkFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpSFE7Ajjs+FHpIt9km8Rri70M+/RDXn1/ql1dCCXS0=;
 b=YvOv+PCqdI+j7HFcHv1g6wxJT9+8SMjw1Q4bxc8DhZuTgyrEhziAr6Dn5CIodv8m22jJKuMO+5W3509EsDlWsQ3gzea3g4qQeJa7u8QBcahfqDA9saSSiagz1qp7+glBZa+SwmjGWItbuqMwvJghL81c/tGBT/ef77sb30ARDy7/6B12nHghD5ArmsmjA5/EwNcf+5OJ4I34Ph9qFmAKIz4kysCQaO9Y11/iUSmNy4xysRbAppNjIc11bByrNEde9OpdN5zVEefurbgzzsIovEChclqWXnvMUBiVC7vDjMbSR2iipkaqasSHxB0gWmLymffAe8ujTen1MI95yk8isg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpSFE7Ajjs+FHpIt9km8Rri70M+/RDXn1/ql1dCCXS0=;
 b=j7uZp4creL8hShau6xdV9ehUKlyKFnjpVVlBTaI9Ot8A+yztYhnrkvE5fsEFcDa3CkhODzq81mcbuEJspKomIV8FvTHA24p9MQjBtHz0Tc8zo5zWL+DygdgA0nU/knmJJcseD/8rmKrRp3czYXOsFlyptdc0iEktDRNO1QWfQnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BN8PR12MB3489.namprd12.prod.outlook.com (2603:10b6:408:44::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Thu, 28 Apr 2022 07:34:34 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::309b:a704:5e87:8ce1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::309b:a704:5e87:8ce1%4]) with mapi id 15.20.5186.023; Thu, 28 Apr 2022
 07:34:31 +0000
Message-ID: <66cbb44b-290d-5a00-e6e3-4da586821e9e@amd.com>
Date: Thu, 28 Apr 2022 13:04:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu/amd: Set translation valid bit only when IO page
 tables are in used
Content-Language: en-US
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20220420112920.18091-1-suravee.suthikulpanit@amd.com>
In-Reply-To: <20220420112920.18091-1-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: PN3PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::8) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c3476d1-2d42-43c2-9078-08da28e98871
X-MS-TrafficTypeDiagnostic: BN8PR12MB3489:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB34899CE6640775EF4AF7A3F687FD9@BN8PR12MB3489.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VaJaujQjTLEhXMWW3Ivy9H+2D12bLMI4mxhXvy11LdNRi7XiYOi8bVN8VoWxwz7SPxy6ZfJWFCIXgOQIAkWXqp9osczT7u0sDe5IDIzTunykFnkqgITqz2mih3ue178zIe9aJ6oj6FZWDxyS3o00MJ8L3JY7Y4qc7+YDz9eLqd20AkPEudt9AoifRzpQiAt+17VU+cMbGEzjByCt8wKbOkbj28yiKRF/zZwSWyHGYhl7i5rfw1gcVccZoRV/EguUwals1o+nsvdbgy6TvhqlWVyAkVhosxElNBoBp+yULXBtQmAic807I6MLp7Xw4p+8M5WEtxesDsx3T+bpWjhY1WxkDoMMB6UPqvPOmrFTfxNoSCXYwb17sIBXYc41ZP2NmgA6ICk7ww2DRS7uOQzpyWwG6eVJd5CqWAqyzAadkQa1pxywicoMLqeylhmGlkTbY73tlRp+6QTtpQZ5G9M4YfVoUyMazSPayl3hy0mEykEd+BpOmQvlnC5nhA5duwmH0L6bFeEEcs1D/GrLhM5Yl2wIVsNMylG8gnj366qwxUqlUg5MT6Rrj+MDYfnLDWYH/S1cRyaPQEzIJvHo2rfCFoBHOOfV7iQ5Gse5Wsg1eimJfpSPhNngXPfw69lPUjr82Y2hBIfwpLG0rJ2OCNSWc+rX06oQu5tRuAuJti3wrTbWAh7ct8wXgXPjvLEYA1LO6GMdGLwBzx8QS5ygyvx/KNoa9UtE9RC277M8U28DgmQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(83380400001)(53546011)(508600001)(86362001)(6506007)(6486002)(36756003)(186003)(31686004)(316002)(2906002)(66946007)(8676002)(4326008)(6666004)(38100700002)(66476007)(66556008)(31696002)(6512007)(26005)(4744005)(8936002)(5660300002)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmg0M2wvcGlzRjdsWDlWWHFReDFiUzVtaDZoWWwzaERDeVE3aklzU0RXTm1O?=
 =?utf-8?B?c2lENUcwUno3aG5kNHBtbGg0U2lMR0l5MklXcGIrdGRyaWprWC9CekQzV0pK?=
 =?utf-8?B?VW45eVlrSGx6ZldiN2IxR2p1bm9ONjFLVG9HMlpaT0M4NDd2MjMrVEtlcjRO?=
 =?utf-8?B?NVBsc1kzUUtpYklMaThjMWxGYkM5MGRDYWZvbm5VamJhR2tOWUJLYStPVVEx?=
 =?utf-8?B?bnRFdWpzU3Y5VGx4aTJtMXNqaG80azBuYXRobzRweW1mL1dETGVlVU9QZTlj?=
 =?utf-8?B?ZmR0Z3YyY2J2ZzNkbjQvdTljWHg0TnJlblV2YXRtRGQvN2diamw4bU1rcEF6?=
 =?utf-8?B?N1ZIYmEvSjlqV1FYYXZIelFNVjZZVjFxR3E4dzREMVBzaUt1SFowY0lRNExw?=
 =?utf-8?B?RFN3LzNJalhUSm9wR3phc05VclFEd2tpazJVcjFiaTNScGI3Vm8zRW9aQ0ZN?=
 =?utf-8?B?em9LZlZIMFRuMFdFRUZjZm45NktzTDZkZzFidWJIVldCTndBbVhsZmxBQnJD?=
 =?utf-8?B?VjZoVkxHSlFhQllJZm9Kc0NWUTgwajNzaS8wRjdheWZiR0o5bEIvMG9meUx5?=
 =?utf-8?B?STV4MEFhbDdpOWd6R1pEaUZJS0llOVV5RngydjAvU0RraWhTNjRYZlBQbE9K?=
 =?utf-8?B?NW9FeTZwNTh3YUpoblNIRkkwRHl3ZmpxNEs3QmpCYTNPWVJGejkxVVdUeXFi?=
 =?utf-8?B?QldCOUJNOUZrQmZlRDhJaFJlVTV0NXdSS21pUDZCY0NzNTZySGJxZ29LQXRi?=
 =?utf-8?B?amZ0bG9KQTNwZTg0TzJxODBEOU93cWtWUVJFSEtxZTFXVytDNnlGM3ByYjFu?=
 =?utf-8?B?OWR0M1lUei8vbC9TL0plMVNYaHU2VHU5dUtwb0pNYlk5dzJnamt5WGdiWUda?=
 =?utf-8?B?eGE0RWFkcWRjYkNNVVNVWFVhN0xnbUJlMVFuRTJ5ZjR5RDdEa0ZKSGZjRlRX?=
 =?utf-8?B?Vm5lZWJDTEdabno3U0pGVityZW1kcHJJSEZGa00rb1Y5ZXZZN2dhOWpkKzBM?=
 =?utf-8?B?WU8xeTdhSVB3OTlUb2FXZVRWTWxoZzcyMWZjdENiKzlDN1lyZFRnNiszVEM2?=
 =?utf-8?B?UmZCRUVGSm04cUF4VlMyTkhoS2pVWGRENHRPYUZ4Z1dzQW9OeVJpZXYvajhv?=
 =?utf-8?B?M1pzOU45R01oT2JLNlZwZ1AzM2FlNFlVaTB1dUdSSjYxQXAyU3FUdHFnS3hy?=
 =?utf-8?B?OXcxbmNPVFplMVQ4Sm51UGZVd0lqMzhwK0ZVMit0REpqRk9xVlUxNjZYZDh4?=
 =?utf-8?B?bXBkSTFYMlVuODNsYXJsNDRCY3BPVk1zWFN6SE5ubmsyMjNObXZVQWJTeklJ?=
 =?utf-8?B?YTE3c0l4SmFxTEdQK05GaHlTWFhBMEJ6cTQ3cGl1WTkvMEJYd21ya2pqOGtN?=
 =?utf-8?B?VXA1MEVVYnBEOFpiaWhPc2Vid0JxdUtYcXZ0TzlUVjVVZS9hMUZlcG55UDFy?=
 =?utf-8?B?MnA0UVZpbzNveXlrdGNFMlp5Tmd3bktlb2QyMjUraENpSXcxRVdYOTRRcm9T?=
 =?utf-8?B?aU1zUDNIcEZ1Zjhtam1uRkw0TytSb2NCNFh4RkVwNWRPU2xqOVQwK0oyamhh?=
 =?utf-8?B?ZnI0MklrNGRsTkM5NjBaUHliMjNHY0pNdnF4U0RuaGdtdzNlaWVmd252S3Fu?=
 =?utf-8?B?ZlVzSEdLWkVjMS9HbTJvMTNKMC8xRjYrSDBBQ2tTd1dmdmpQS2wwRW5FWDlT?=
 =?utf-8?B?Q24yYmVkZFlKWllSY3BEYWdodjRQS2RLWXROWFo5dU8wMDd4N3RybXJIY2cw?=
 =?utf-8?B?TklzV2hMR0FENU9XRENyMERXbWhKZ1RlSzFya1oxQkxHVGRWa095RVo4WlRY?=
 =?utf-8?B?Z0VLL2E5NW5HaGdXTXk0cVdieDM4MnRVelJkdGFyVDJHWE5GSXA2ZGU1K0s1?=
 =?utf-8?B?OXZXandueG9MdjA0TjFEamw2cG9NZ3NSU1VUUWFXVEZxRU9JTzc0K01QTGc3?=
 =?utf-8?B?eXVjZ3ZYTGk1T0ZPMWh6YU1ValRzcTZuSkNkRGlMQlV6R0pjNGMyS2ZnM08x?=
 =?utf-8?B?ZGc0aWo4cXZ6K3p1cWp4ZHdIWnFYTmprZUZuZjBHQ1oxZVNBV2dYQndGdFhi?=
 =?utf-8?B?bDBidW9MRDRQL1RUNXVOMEF3VXRCTnhjTEl2T09Vb1kvODlUQUhkVlNuQXc4?=
 =?utf-8?B?YzRwa1BLVGZjWWxYVVREL2N4TDlYd0NIY091ZUx6WXYyYk9MSkkrVURaNmNL?=
 =?utf-8?B?SmFudFVoUmpmdVpKekxPc0Y4UUFPV25IdlFtZ1hJTWZ6U2FwR3ZyYUtaRWhF?=
 =?utf-8?B?eVhQYmUzVDhvV3JSKzlRNUo0OVp6QzBINGQ5eXgzQ3kzMVpRRUxFdFJzQlJ3?=
 =?utf-8?B?K21XdGVkeUwvWmRlMDgxN20xV1RwOU1VWDN3SjNPa2tpTTFqdTEzUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3476d1-2d42-43c2-9078-08da28e98871
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 07:34:31.2667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fmg+s4VssA/BMTAhZU6Vi8XZzVKDIOoH3g8ZTvSiOCaKAqwoWkigxnNmEf+bKuMOZjNXd1C/jiftji7GU+hIMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3489
Cc: jon.grimm@amd.com
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

On 4/20/2022 4:59 PM, Suravee Suthikulpanit via iommu wrote:
> On AMD system with SNP enabled, IOMMU hardware checks the host translation
> valid (TV) and guest translation valid (GV) bits in the device
> table entry (DTE) before accessing the corresponded page tables.
> 
> However, current IOMMU driver sets the TV bit for all devices
> regardless of whether the host page table is in used.
> This results in ILLEGAL_DEV_TABLE_ENTRY event for devices, which
> do not the host page table root pointer set up.
> 
> Thefore, only set TV bit when host or guest page tables are in used.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Looks good to me.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
