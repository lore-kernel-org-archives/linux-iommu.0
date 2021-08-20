Return-Path: <SRS0=ckUw=NL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978D8C4338F
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 13:31:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AEF061042
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 13:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3AEF061042
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 00A5140194;
	Fri, 20 Aug 2021 13:31:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l5yrDWniFgzj; Fri, 20 Aug 2021 13:31:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0008240107;
	Fri, 20 Aug 2021 13:30:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA009C001A;
	Fri, 20 Aug 2021 13:30:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97225C000E
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 13:30:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 78FEA613F0
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 13:30:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DGtD7H78pdBs for <iommu@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 13:30:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5B13B60034
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 13:30:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYbNohynw1dwZkENpWuS9EeVpZoOsCEeYwWfir8ADcGcV5qvruzikLkpnGYox0aflbY8M32/sgsF1ge170JhmsjQig1MRZBnwUeQtXhXiN/Ooj8ph06FQhj07dMMNbcPSRxoXhCc2vZam2T/m5ESVDWbciDCY7mQ+nMwlV62gYgG90HQHSwAZtZs39E7Fm27fM+oGXZE0ltbYz2jA2EFhqYR+cDxVT0i0uQQ87d7JYlfJX+ldZaDoUxBMZxqijkGbeW9xL/azb1/xk9CIqHc6nRtLvrOfoJoqPGmMhSfPtvsiELZrIDiBoCK2cgpQU2lZS8PLMUNOM9XnVPWlOP57Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2xoiIec73wfWq4W/xdhp0kJ0euoZbXzd3Kj0SBhyoA=;
 b=FOt1ncds7gc5flmmxmouzNnWagRE4w7c/aA6XgymUjxYuNEyLv+TiT9ZsYrBZlm8IuLEs6dK3HfyhYsojNOYlRSbKTOmXlILn/BXe29thT9M6WgGbnIS4L7f7fHt02CvZdkWXEPe0j/gUVSMchOFXgrAWEM+yd9Zoo70GdNwusEhJxug9jn7OdardKCJPdtQaHBeHgm0N4L5cX652GG4SBLh5KuJsok9zBPI03p2WfjuB2+laYl5ahfeJUWIGnqHXvQrR0bgV3RWXW/TBha1lsMAdhNcyJvIsAblp/yb4pfVreYb766NUCqzB+AeKIS1pORyPheJiyoIo0hl5+1h6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2xoiIec73wfWq4W/xdhp0kJ0euoZbXzd3Kj0SBhyoA=;
 b=OsJlYQd1i67xL9Vk4OXig18TWdkVh1rBAGSxxV8KMtvG2i8P3wHGYouyjv+0qsudX2GKN4++xoyqU7o8IHjom+bKZVHsQmGuoqNCGG3NJmk01kL5rPpwZONDWoVVODqwRwR5ASTIwieIl4Wx5UWb6ukXn7Bq6Pc23QXU4oDT4gY=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9)
 by BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Fri, 20 Aug
 2021 13:30:47 +0000
Received: from BL1PR12MB5221.namprd12.prod.outlook.com
 ([fe80::8ce1:ecac:a5bd:e463]) by BL1PR12MB5221.namprd12.prod.outlook.com
 ([fe80::8ce1:ecac:a5bd:e463%6]) with mapi id 15.20.4436.021; Fri, 20 Aug 2021
 13:30:46 +0000
Subject: Re: [PATCH V3 12/13] HV/Netvsc: Add Isolation VM support for netvsc
 driver
To: "hch@lst.de" <hch@lst.de>, Michael Kelley <mikelley@microsoft.com>
References: <20210809175620.720923-1-ltykernel@gmail.com>
 <20210809175620.720923-13-ltykernel@gmail.com>
 <MWHPR21MB15936FE72E65A62FBA3EF4F2D7C09@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210820042151.GB26450@lst.de>
Message-ID: <276f30b6-d741-f88b-ae93-f3d6653498cb@amd.com>
Date: Fri, 20 Aug 2021 08:30:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210820042151.GB26450@lst.de>
Content-Language: en-US
X-ClientProxiedBy: SN7PR04CA0076.namprd04.prod.outlook.com
 (2603:10b6:806:121::21) To BL1PR12MB5221.namprd12.prod.outlook.com
 (2603:10b6:208:30b::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-ryzen.texastahm.com (67.79.209.213) by
 SN7PR04CA0076.namprd04.prod.outlook.com (2603:10b6:806:121::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 20 Aug 2021 13:30:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f130b86-2f2b-4289-9e36-08d963deb7af
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB5505050EC4C321D2C86CD03AECC19@BL0PR12MB5505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2gfyETn3qPjvqavDCPew+TbbzgP+8XxltXMx17ZYNVD/4NlalSsAa+KKIR5Urkr1sSmB3/cwDqgdMmq/6tIOrYHz3HUDWAJ1jRNk83r8L7ctDyM5orPKlCNMPJE0k2NYF57OQkPDPQX67Z2cWpCBiFGajyWwuk5ERFLtMHAR0frKoScRPP0Ib166timsFJDDm4TIfcApAH4jBVneW2eco07NnbT8RMMS0P5zH3T4YjMtY8afcND9BJkYrLRpbOIRfq3u6mHGT8MNI/7VCMsVlSS2PRY7MQrovF9YajDJuyULwIDlDB6sn7ypAEH8lRok36nSZ1YgRkJlJREdc+hqKaQgYgWIL69OOwyNSC9OE+KAXOc2uv5TFK2ofy7YP2H2ueuPDrYSH3lVXvYfF7hGCyQzIqcUvaICv1OeePXtWS6Ca9UZG5uIhmWA7AgMHZ8Y2jJFZ+HeJSNsm5QPQrwoDiwV2kK3CIpWu4wThn57uOulGOqMfWXVkX3Jt6bVadIyHnoj/6FYbTI74Dh8kr86w6JEnzwTX/Tc34GTPethoDCh9kuVYLTNKdmaddsQ/IbVgcRi5pbEb/V/+p3BFtlAdCQc7QKzjkKmnzMVoGce4+AruedyzRFY2qttWyH3AYFcci3qlakIY1mygl4fcfzNG6YjBTAOEe9B359sdcQlR9uxhErmU2HrYhY6c5JX2XdLDgdhRnPBva7vzYeIJ+lVWnAduHgWqkhLxtMGrPYVoi28hUqIBdlWm37bQ6+fm5KONCejKiNDWleqCg0FK6JHcOkeFHG9eym4dN6mMHmbF8HDC58Be8feZt+3ShZbk0w1GZ2SNV6ZC8d6fpMsCU6LhgB7ge0ZPvT1StHBWHpv3Ms=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5221.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(478600001)(6486002)(26005)(31696002)(6512007)(186003)(2906002)(38100700002)(5660300002)(53546011)(6506007)(36756003)(4326008)(66946007)(966005)(86362001)(66476007)(8676002)(2616005)(7416002)(956004)(54906003)(8936002)(316002)(110136005)(83380400001)(31686004)(66556008)(7366002)(7406005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnJtTlQzdEo1eThEUWNGZ3VZaTBsbnRkRGorRHNWVHhvN2VKdnV4cWpyaDM4?=
 =?utf-8?B?MVBIL2VnR3lRVWJiZ2ZGc081dFkrZ29pdTlvOXZZY1JoN1dSU1dqbm5VNlpB?=
 =?utf-8?B?L3dmMzVDb2MzeWVNSU02bmRydlFNRkc5WGFMMjhGanh3TzhFVzNUWnAzWXpO?=
 =?utf-8?B?YVpuTkJFQTV0aG1wL2Nmek93TVdGWGZ6R1BOcjlSdGFWNzVpOGpKYXFjak5j?=
 =?utf-8?B?WjF2ZHVuUFUzcHNXYzJvRVVkci96MWxVWmFmVnFkN2FwTzNGbjZWNmh4emFF?=
 =?utf-8?B?V0Z5NUFxRWdYREk4WDdydjJ1dnJ1ZlloSXFPTmdmYXlBZyt2aXRyVGhaM01w?=
 =?utf-8?B?VDBRUmRMSi9XTU9kMS84MFNIdG44YWVIdGdmeUpERjVpRGV5MU1ETGRVZWQy?=
 =?utf-8?B?RWRBbER3bExYU0p2SzVTSEZWZ1N0MXE0MGMvZit3NUpWbk1GdlFLT1VCY3dQ?=
 =?utf-8?B?MjFhQjlQYmM3bCtmcUYzMkJkbm5RQlhvcys2UHlUSExvZUNtWXJpc1ZGK09w?=
 =?utf-8?B?cVFDbDlTcjFUWmF6RERGZk9qQzBMcllDaytaZWk2RXZoaDROTTJjNERCS2s5?=
 =?utf-8?B?SWVtMW1xRTV5QnNoTUxTOHY5b3hxTEZjVlBtT0dCRUZGM0NsQ0ZkaUx4N010?=
 =?utf-8?B?U3JwWG01Zmo4Z0RNei9Eb0ljSjJiU3doNWoyYUljcVBBZGZqZlJwZkY2bG5h?=
 =?utf-8?B?RDhkRSttWE1zZjFUQjRDWnpDVS8wd0ozaUZKMEh6SVF1N0FqaVc4TVA3TStF?=
 =?utf-8?B?VkhXN01MSHc2eHFrZUZJMU1LOE4rUmMwT05IZnFQTG5JVlM2Mzc0TWs0Ymd6?=
 =?utf-8?B?azZTNytNS08yNkszRU9mWUVnSERGVlI3Y0dQbUVITFJRRmVUREpmQUR2L1A0?=
 =?utf-8?B?c3lYaWRVV3F0d3FRSTJ6QmdGTTBHYWlrd0hLckpHUkxCZDA4VmlQTjFEUExI?=
 =?utf-8?B?SUFxQjdSQ3pmMldEdE1OTDFEK0UyWUxBQWVBMWxKVk8yRkJubzRRSDVmalNa?=
 =?utf-8?B?dmpmem1kaVhyejE1RGpWYkNJV0dYbXpuQ1RTWXFvaHFOcTlOZ2pmbFZDNnFO?=
 =?utf-8?B?b2toU1BXU2VSRURSOXVYdDJmOGdQQis5UG9CUDVXd3VEa1paRWdtbzV1QkFx?=
 =?utf-8?B?Mjl3QXBqZm9PeUp1aWtmcTRPcjFwdjFmdTFzK3lHRjFjbmV5UHRUZkt0OGRC?=
 =?utf-8?B?eUszOHdYdUI1WlVJaU84OGJoVmJ3bzZReHZZK3ZPbXJrakl3Z1hhUG9FYVQv?=
 =?utf-8?B?RjI2WjhqZlBsZEpkbEFHT245aS9sVE5ZWEVsVUFFYlNLcDdtMWc3YXdLeEE3?=
 =?utf-8?B?aHBGZ1QxVGkxRDlxd0JLYVlXSGRFVFFzUDNTNUhxRUxWbkR6LytjYUJzMms1?=
 =?utf-8?B?NE5TeC9YcVRZRng5dmUwdzdTNUdzRVo2TkZOT1F1cUdJbE9USFVTTDV6alpl?=
 =?utf-8?B?K2lKZlhxamRiUEpKMk14aXh1RmZyK3VPb09lalJaK1RTdlhjVXBuTW0wdmhy?=
 =?utf-8?B?Uy9pamFZTDlMMGlpSitMdUpiU0lSa1ZLOVREd2hwOGt0eWZ5Q3REZGVEbnFF?=
 =?utf-8?B?WlFWTzc1L0FBWTA0MDg2NnFoeXRtbFNKeDZ5b1lmN3orNk5nQkpTZ2EyOWVV?=
 =?utf-8?B?ckJLUTdlOExXeHpSamRqa0t4aHRnUTIwblRNTDdGTUgzNXJIZEQvZVkrTnlQ?=
 =?utf-8?B?cjFrMFNxWWJPNEZLMFZ4cmRzeC9YVXN6SXAvWFlSeHl4Q2Z6cnBXbWY3RXZU?=
 =?utf-8?Q?hfuG64VcprR6WNR3AoY7QKRoELfMUz5I9Lk+qaJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f130b86-2f2b-4289-9e36-08d963deb7af
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5221.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 13:30:46.7933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8hF636Kko5E5awL4utZAAnAsHYUJ8Xk+OiOcjEEkkOPM6jQoYTv0V+JT3OSFZsDActObVEyU8+GN5p2WRrXMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5505
Cc: "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "dave.hansen@intel.com" <dave.hansen@intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
 "will@kernel.org" <will@kernel.org>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
 "x86@kernel.org" <x86@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Tianyu Lan <ltykernel@gmail.com>, "ardb@kernel.org" <ardb@kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "pgonda@google.com" <pgonda@google.com>,
 "rientjes@google.com" <rientjes@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "martin.b.radev@gmail.com" <martin.b.radev@gmail.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "bp@alien8.de" <bp@alien8.de>,
 "luto@kernel.org" <luto@kernel.org>,
 "krish.sadhukhan@oracle.com" <krish.sadhukhan@oracle.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, vkuznets <vkuznets@redhat.com>,
 "jgross@suse.com" <jgross@suse.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "saravanand@fb.com" <saravanand@fb.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "rppt@kernel.org" <rppt@kernel.org>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
 "tj@kernel.org" <tj@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
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
From: Tom Lendacky via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Lendacky <thomas.lendacky@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 8/19/21 11:21 PM, hch@lst.de wrote:
> On Thu, Aug 19, 2021 at 06:14:51PM +0000, Michael Kelley wrote:
>>> +	if (!pfns)
>>> +		return NULL;
>>> +
>>> +	for (i = 0; i < size / HV_HYP_PAGE_SIZE; i++)
>>> +		pfns[i] = virt_to_hvpfn(buf + i * HV_HYP_PAGE_SIZE)
>>> +			+ (ms_hyperv.shared_gpa_boundary >> HV_HYP_PAGE_SHIFT);
>>> +
>>> +	vaddr = vmap_pfn(pfns, size / HV_HYP_PAGE_SIZE, PAGE_KERNEL_IO);
>>> +	kfree(pfns);
>>> +
>>> +	return vaddr;
>>> +}
>>
>> This function appears to be a duplicate of hv_map_memory() in Patch 11 of this
>> series.  Is it possible to structure things so there is only one implementation?  In
> 
> So right now it it identical, but there is an important difference:
> the swiotlb memory is physically contiguous to start with, so we can
> do the simple remap using vmap_range as suggested in the last mail.
> The cases here are pretty weird in that netvsc_remap_buf is called right
> after vzalloc.  That is we create _two_ mappings in vmalloc space right
> after another, where the original one is just used for establishing the
> "GPADL handle" and freeing the memory.  In other words, the obvious thing
> to do here would be to use a vmalloc variant that allows to take the
> shared_gpa_boundary into account when setting up the PTEs.
> 
> And here is somthing I need help from the x86 experts:  does the CPU
> actually care about this shared_gpa_boundary?  Or does it just matter
> for the generated DMA address?  Does somehow have a good pointer to
> how this mechanism works?

The CPU does care. Here's some info:

APM Volume 2, Section 15.36.8:
https://www.amd.com/system/files/TechDocs/24593.pdf

AMD SEV-SNP Whitepaper, Virtual Machine Privilege Levels (~page 14):
https://www.amd.com/system/files/TechDocs/SEV-SNP-strengthening-vm-isolation-with-integrity-protection-and-more.pdf

Thanks,
Tom

> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
