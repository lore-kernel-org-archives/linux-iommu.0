Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EC8C433F5
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 17:04:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A045C813E4;
	Tue,  8 Feb 2022 17:04:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WJc-wWUuEiV0; Tue,  8 Feb 2022 17:04:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4236E813C8;
	Tue,  8 Feb 2022 17:04:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23B6CC001A;
	Tue,  8 Feb 2022 17:04:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99BB0C000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 17:04:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 88FC960B45
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 17:04:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F0fmh0ueNpuy for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 17:04:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::62b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B8EF460593
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 17:04:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGKJyioasQEJOedFfkNoMTovFhg7amt3NvvwN8rNiblXq4yIyIvxFRo039CA2vgK8BFbGJtPakjWDVknJJKa3+bMjuVcwslNudcK531XzhXuMMeu6jtEqCQ+S1aq6Xa5t/MeaAZARzzasFy0+6opfBaEosgdDA6jLrUm/Q6Lrw0W8h28nEbL/3kESwSje4zZalfpxM79tBTN6BL0W+UCvtEa0YuGcu7T4Oie3u8L4KPHQTR4PLXFfAdKHbneQe/fvBFn1aRMruISS7KTfmbd6a1JVHaZxNaIf+Xg7iFHFAWdpPT0ESJzI9kcGf/7rZiS7N17banxG5gSS7gQEFe5pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWf3aYhC8+dgWIkA8btpIKQwEe8mBKUboRsQKeCK2fo=;
 b=U0g/6oRXl1J1AXuCQDIIVDztH89JssQey87+LmBEfdywrD/rVGkkgIYsLFCGQor/ylm7vYXWYdC0PY6LXqts7YmJSnnVb8Xr3+o/F/ssMgXXHbFiBj5cv0COIIzLfFo1wOvFTTLn5RoQNCf0AcKSkLX3kD4r7DhrMeA+ZK75OP/9ybxvex7p/K03KnQQEJEfSFmTSpsKg3sdnfQSa0UldSKsFgHxIjFreFv/FThwsgx18Q0V8aDnTfC8eXhDWnJOhMKCokH61B25c3JUypx661WbvaQXJoDWmIVoFIpVYUgkhRvz2hdTvcNc2q/R8VdRDdTLZLzeDJ2o5OfY1ijXHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWf3aYhC8+dgWIkA8btpIKQwEe8mBKUboRsQKeCK2fo=;
 b=1fvm5/uZmHoDV0tRUFx+hb8AEcs5mCgaHyMXaWhHAi28spYaeU5hWE/cdy7GCSAKXNUhBTafrN5wyumBk0o8DI+TK3cpv8zHE+5WQAbreCNVH/t8u7Htf7qwKa6ZYLChSfT276kToGcKXakWgraBEtNTh0Wq9Jyyi+JvBiqIuvU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM5PR12MB1803.namprd12.prod.outlook.com (2603:10b6:3:10d::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.18; Tue, 8 Feb 2022 17:04:48 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::389b:4009:8efc:8643]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::389b:4009:8efc:8643%8]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 17:04:48 +0000
Message-ID: <02aa873f-ad42-f310-a3ae-453a95ba8063@amd.com>
Date: Wed, 9 Feb 2022 00:04:40 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: iommu/amd: bug report: page table memory leak
Content-Language: en-US
To: Daniel Jordan <daniel.m.jordan@oracle.com>,
 iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>
References: <20220118194720.urjgi73b7c3tq2o6@oracle.com>
In-Reply-To: <20220118194720.urjgi73b7c3tq2o6@oracle.com>
X-ClientProxiedBy: HKAPR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:203:d0::19) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53569039-bafa-4b20-3677-08d9eb251d09
X-MS-TrafficTypeDiagnostic: DM5PR12MB1803:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1803109B19CE951AABE2C600F32D9@DM5PR12MB1803.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rn68jASqsXhZ3gBV7518NmS6doWaYJsCLMIyAzHLG/wOnkiKdvxVGBKCiOyuLHoG2MyeMVIsPvbclCImZBEborCCKe6RK0Q/iI/8WFmi4X6gxY7OERYW7HFvFJhNLJrjGoDIgksXYYqBUgg+DfKAqw5kNZgxRvn2VZJ07xBfQoC3sU10Iq+0/W7NlpfLHV7wcQzJ+SvsoWtIRbrpu31uOnfqQPkqI3SdEjTASKNK/oxeI1RDu7RNosfRkoqDJtMEbm0zN4yb4A8cHXRWmhlCG9al1TOJP7uAo1KPkDpPFnqFf9hXj3WLdq4XXG7GM4sLE1RC1dQNo3smUPIbH9jzFjp2M7vhX5tQIZUWN9Kn1wwURC5hoSO1aEetMwiarIqzsAW+oK68LU64ypfqHQS6xMb/TkWoUIpmDqLn+2brNCEiDX1tvTvVb1EEOWA39G7mee0qbbyQaBkMkBylU6l/HdxdFtfEYC7vZmGtWqSlOJYiE8iizBoqsy0F+RFRfhV+EmihBC+HGXIAr/gEiTT4MO/1nzV5caGLlhlPITr2KHbgUT7CAVHq31iCZf3UjWukEBY8pPUKOJktKsUKoG/JTZQSOmafaq0de898XCqdBA/1bUJo4hrp6ADNdwNMzMIj6NVaHyseD4gFR2sSgXq/wmXNNLlTEU/Qnvg/3Z6fUzDlDAweyyOLisvOMbnvajITFWPjFiyaUVjrc5jpvdviqk2ssa5GR7xp3YxyKRJ7FLuCQiUhbKfjro5Md8xlorD7lcli89nxxloswtV25LxX8lTlftHIV+WfYflfgfK82Yldkvw8240P1BZnuykF0ihC1uvqdV0auBcDfXiEYQgc6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(966005)(5660300002)(8936002)(508600001)(66946007)(66556008)(66476007)(110136005)(6666004)(6506007)(53546011)(86362001)(2616005)(316002)(31696002)(186003)(45080400002)(31686004)(38100700002)(36756003)(6486002)(2906002)(6512007)(83380400001)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU8yK0F3Q014cUUyVnZJUVlvdWJ1bG1XdWNNVHE2RTVUbEF2WUF2QVdnZEVr?=
 =?utf-8?B?ZjVBQW5GTXlJM2x5SFM5dWRwZW9qZHVPZEk4NGpHUm1NQmtGYXlXdTNNNUMr?=
 =?utf-8?B?dFFxejUwa1RSNzBBbzBPRnVLMUt0UHZFZVhmWnJXa3FTZ2lNMFVXMmdodjRN?=
 =?utf-8?B?bXd1MzBVYUdoK0pDRm9IcGdjOUVqc3oyR3FKQkNiWTV5U3dLRzZSemtXcDYv?=
 =?utf-8?B?OVphc1IwNGIyM2hBTDBjc3lzT2ppV2lEMEpQNkR4Z2ZuZnhQNXdTYU1abE5h?=
 =?utf-8?B?bjMxaGJLYTZ3cTQycm9zRXBFYlFPWDUxU2hHeTJtT0Y2c1dDd2k4bm4zSnBF?=
 =?utf-8?B?RHk3c1JoVW4ybmR5YUlFV2pRNnF5UFRSUWZGTllYb3ptam9GMFVSSmVrOXRa?=
 =?utf-8?B?VGU4ZytUZ1N3UW1Hc3pkMDM5eHd5Y0tJQzlOUy9pZW1zZDRoamNpL3NxbWt0?=
 =?utf-8?B?Z3haYXJJUS9LTDFSZmxtb3VnREJBT2Q5a3BLN1M3blJvRTg5QksvZWlZNnk5?=
 =?utf-8?B?dC9TZ0lnQ2NjcXRlbENtQnJsRDUyb1Zza2xlSlBwWE5rVFF6T3lGTk0rZDZU?=
 =?utf-8?B?RVMvWVBzeGcrZnFzRS9EKzhSSTBxTnk4WWx4WUs1TXNjOHV1RjRybGZNV2Z1?=
 =?utf-8?B?dnZiMDFqQzJTRzJ4TjRSOC9OVC9oN0NVanQyc3FIUllpc0NDbXZWVkYyY1Ja?=
 =?utf-8?B?TFc4YVBkbVkxemlWWHZVb0xQWGoxYllqYmJ6UW1FNC9wclpJRmRFWTZLVlNQ?=
 =?utf-8?B?QUppZk9yTFZjbkVlYUNIQStCeUJjWVZ4aWR1elBYS0dvU3hCWkwvaENTMUpv?=
 =?utf-8?B?dm1yZnJmQlVPTGV0ejhPWkM5bGpudFJCVE9QMjRVejQ3N0pvRys2VDRQZWU4?=
 =?utf-8?B?VHlpWGdtbG9lc2R3SFVTUmRWQVpvT3pvbmNGamhNRU1KMzg1N0NuN2hlWlZQ?=
 =?utf-8?B?b3pzQWZEcVUxNjFMR3gvMHJ0RHI4TFZCSlMvd0dhRXBnSzlVKys5NU4zRkRZ?=
 =?utf-8?B?a253ZTBjY05Fc0daWUVUZ0xpSnA1RHRZaHN3c096Kzg3R3YzaVAySHpCd3hN?=
 =?utf-8?B?TEN0VU1ZaFZZVXVOdUoyKzFPejdIZ3lXY2JBaERkUThkcVpYUmJObU9DQ3hp?=
 =?utf-8?B?amdKZ1dvUW13YjdPbjdncUthcUlHOUtXNzE4NkZCZ2o5MHdIUzJyNEp2bFpK?=
 =?utf-8?B?MXRtLzdhMDNhS0R1bDZ6QzExNHp2Mk5ESlliaWpiaVA1Zi9BbDhNM1BvdExv?=
 =?utf-8?B?ZWNTc2psYTZnVlU2L0xtNk1mdks2NXNQdS9IdjlBVWg1emVWVVM2WWRoNFJl?=
 =?utf-8?B?NTU5alNydWpPUXF5cFl6WHVqdnc0em85WHhzVlVFZm5PRGI0QTVUaEFJaDF3?=
 =?utf-8?B?WWxJeEJvZGpqK0d1Z0x1UmVYZHR2VDNhbmh3dlNCYXZMRC9LVXZaVWkwQ09C?=
 =?utf-8?B?bExiSWNMUVRQQS9DOFIxb0xMdVV1MEhKOVdXT0MwbTZuQzJ0TG1FWGQxY2Uw?=
 =?utf-8?B?cXZHcW0yaVY1R3VzS1V0bTRSN3hpVDdDaDhwZUk1bTBncTJwZjkvSHRNZ09U?=
 =?utf-8?B?YTBEQk5Ga2JVWFg3VGhQZFBxdExHS0xGRUxzREFROENQTVI5ZkJjRGQ2dyta?=
 =?utf-8?B?aS9xcHVNVkExbHpSRm1mdk5NTTYxK2FMeHRJVFI5UDhEVElabUxaZVdXdmxX?=
 =?utf-8?B?ejJSQ3daVStMWFg2Mmxrb1FocnRqUzBaSm44N01sQ1Y0aHg4Nk8weGZsZjFL?=
 =?utf-8?B?cnd1RW9WNWsrK3I5UUZ2VElsY1VCVGlROW5ieEVXSnFOcnpLQ3ppVGdPT0dI?=
 =?utf-8?B?VVlWQWNtaG1IN1JDeUZSK1IxVm5oUW5Tc2FkUzdEOHYrTGEyM0d4dWFKK0Ez?=
 =?utf-8?B?SGdzRXBvZjY4cU94WEFQOWgwRGFYaHZkL0pKQ1RUZEkyeXNHdnUxQlk1aGc3?=
 =?utf-8?B?M2dZVlVIQTJGTDBrSDZjUERFZ3Fudmd1NDYzMUtPUWd3dkZMWXIrVWsrM0xu?=
 =?utf-8?B?MUJHZEZEVEsyZFVCb2ZvVG1xMllyMkYweElBQmVsQ3lyS0xKc0loUUppNXor?=
 =?utf-8?B?N3d5OXZFKzFUT3dPRXdRaXkrbENtZng2dkVWbVl2dWRNK2ZOc2tIcXExeUZk?=
 =?utf-8?B?a3FnMDZTUnp5L2JLOVdSMWx0SCtneHVFT01KaUlnMkRZNjF2UlhZWk9WaGlG?=
 =?utf-8?Q?1OOk0We5H/sEKZ/g+MLSnDs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53569039-bafa-4b20-3677-08d9eb251d09
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 17:04:48.7782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEvFko3pvfP4qjX64LbuSBFKkqmihyFqUOswaDLYLAhPF16B/Gq5V/dDoTucLPhsanTkFVjHhJVTtGeXjHITug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1803
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

Hi Daniel,

On 1/19/2022 2:47 AM, Daniel Jordan wrote:
> Hi,
> 
> I've hit a memory leak while testing qemu v6.2.0-rc4 on an AMD EPYC 7J13
> (Milan) system.  Starting an almost 1T guest, the leak is over 1.5G per
> qemu invocation.  I haven't checked whether the leak is proportional to
> guest size.  It happens with a vfio device, and only when the guest's
> memory is preallocated using qemu prealloc (this latter part is kinda
> strange).  It happens when the guest memory uses THP but not hugetlb.
> 
> Bisection:
> 
> # bad: [df0cc57e057f18e44dac8e6c18aba47ab53202f9] Linux 5.16
> # good: [f40ddce88593482919761f74910f42f4b84c004b] Linux 5.11
> git bisect start 'df0cc57e057f1' 'f40ddce885934' '--' 'drivers/vfio' 'drivers/iommu' 'include/linux/amd-iommu.h' 'include/linux/dma-iommu.h' 'include/linux/intel-iommu.h' 'include/linux/iommu-helper.h' 'include/linux/of_iommu.h' 'include/
> linux/omap-iommu.h' 'include/linux/platform_data/iommu-omap.h' 'include/linux/iommu.h' 'include/trace/events/intel_iommu.h' 'include/trace/events/iommu.h' 'include/uapi/linux/iommu.h' 'include/uapi/linux/virtio_iommu.h' 'arch/x86/events/a
> md/iommu.h' 'arch/x86/events/amd/iommu.c' 'arch/x86/include/asm/iommu.h' 'arch/x86/include/asm/iommu_table.h' 'arch/x86/kernel/pci-iommu_table.c'
> # bad: [cee57d4fe74e82e784f6566bad3e3bb1ca51a211] iommu/vt-d: Remove unnecessary braces
> git bisect bad cee57d4fe74e82e784f6566bad3e3bb1ca51a211
> # bad: [9fb5fad562fa0a41c84691714d99c23f54168a9e] iommu: remove DOMAIN_ATTR_PAGING
> git bisect bad 9fb5fad562fa0a41c84691714d99c23f54168a9e
> # bad: [45e606f2726926b04094e1c9bf809bca4884c57f] Merge branches 'arm/renesas', 'arm/smmu', 'x86/amd', 'x86/vt-d' and 'core' into next
> git bisect bad 45e606f2726926b04094e1c9bf809bca4884c57f
> # good: [7060377ce06f9cd3ed6274c0f2310463feb5baec] Merge branch 'for-joerg/mtk' into for-joerg/arm-smmu/updates
> git bisect good 7060377ce06f9cd3ed6274c0f2310463feb5baec
> # bad: [6778ff5b21bd8e78c8bd547fd66437cf2657fd9b] iommu/amd: Fix performance counter initialization
> git bisect bad 6778ff5b21bd8e78c8bd547fd66437cf2657fd9b
> # good: [f9b4df790aa4372bfa11b7d212e537b763295429] iommu/amd: Declare functions as extern
> git bisect good f9b4df790aa4372bfa11b7d212e537b763295429
> # bad: [33aef9786046d9a5744cd1e8d5d0ce800d611fdc] iommu/amd: Rename variables to be consistent with struct io_pgtable_ops
> git bisect bad 33aef9786046d9a5744cd1e8d5d0ce800d611fdc
> # bad: [e42ba0633064ef23eb1c8c21edf96bac1541bd4b] iommu/amd: Restructure code for freeing page table
> git bisect bad e42ba0633064ef23eb1c8c21edf96bac1541bd4b
> # good: [18954252a1d0b12e1b77087b55c37fb43b09e12a] iommu/amd: Move IO page table related functions
> git bisect good 18954252a1d0b12e1b77087b55c37fb43b09e12a
> # first bad commit: [e42ba0633064ef23eb1c8c21edf96bac1541bd4b] iommu/amd: Restructure code for freeing page table
> 
> commit e42ba0633064ef23eb1c8c21edf96bac1541bd4b
> Author: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Date:   Tue Dec 15 01:36:59 2020 -0600
>                                                                                           
>      iommu/amd: Restructure code for freeing page table
>                                                                                           
>      By consolidate logic into v1_free_pgtable helper function,
>      which is called from IO page table framework.
>                                                                              
>      Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>      Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fr%2F20201215073705.123786-8-suravee.suthikulpanit%40amd.com&amp;data=04%7C01%7Csuravee.suthikulpanit%40amd.com%7C143de50116b0431302ce08d9dabb5dab%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637781323390114388%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=RK%2F8spS7L5qdvaBYx0OE9T75TOfb9QiA8%2BKk4C00Jqo%3D&amp;reserved=0
>      Signed-off-by: Joerg Roedel <jroedel@suse.de>
>                                                                              
>   drivers/iommu/amd/amd_iommu.h  |  1 -
>   drivers/iommu/amd/io_pgtable.c | 41 ++++++++++++++++++++++++-----------------
>   drivers/iommu/amd/iommu.c      | 21 ++++-----------------
>   3 files changed, 28 insertions(+), 35 deletions(-)
> 
> Qemu command line:
> 
> numactl -m 1 -N 1 "$QEMU" \
>      -name vmol74 \
>      -machine q35,accel=kvm,usb=off,dump-guest-core=off,memory-backend=pc.ram \
>      -cpu host,host-phys-bits=true \
>      -smp cpus=32 \
>      -no-user-config \
>      -nodefaults \
>      -rtc base=utc,driftfix=slew \
>      -global kvm-pit.lost_tick_policy=delay \
>      -no-hpet \
>      -no-shutdown \
>      -boot strict=on \
>      -drive file=${vm_image},format=raw,if=none,id=drive-ide0-0-0 \
>      -device ide-hd,bus=ide.0,unit=0,drive=drive-ide0-0-0,id=ide0-0-0,bootindex=2 \
>      -device vfio-pci,host=${pci_addr},id=net2,bus=pcie.0 \
>      -msg timestamp=on \
>      -nographic \
>      -object memory-backend-ram,id=pc.ram,size=980g,prealloc=on,prealloc-threads=16 -m 980g \
>      -daemonize
> 
> Kernel config attached, and I can provide other details too if I left
> anything out.
> 
> thanks,
> Daniel

Could you please try the following change to see if this fix the problem?

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 182c93a43efd..1eddf557636d 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -519,12 +519,6 @@ static void v1_free_pgtable(struct io_pgtable *iop)

         dom = container_of(pgtable, struct protection_domain, iop);

-       /* Update data structure */
-       amd_iommu_domain_clr_pt_root(dom);
-
-       /* Make changes visible to IOMMUs */
-       amd_iommu_domain_update(dom);
-
         /* Page-table is not visible to IOMMU anymore, so free it */
         BUG_ON(pgtable->mode < PAGE_MODE_NONE ||
                pgtable->mode > PAGE_MODE_6_LEVEL);
@@ -532,6 +526,12 @@ static void v1_free_pgtable(struct io_pgtable *iop)
         root = (unsigned long)pgtable->root;
         freelist = free_sub_pt(root, pgtable->mode, freelist);

+       /* Update data structure */
+       amd_iommu_domain_clr_pt_root(dom);
+
+       /* Make changes visible to IOMMUs */
+       amd_iommu_domain_update(dom);
+
         free_page_list(freelist);
  }

---

Thanks,
Suravee
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
