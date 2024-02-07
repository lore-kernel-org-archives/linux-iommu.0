Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7543F8003D
	for <iommu@lists.linux.dev>; Wed,  7 Feb 2024 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324711; cv=fail; b=fg9deGV4OcepxM/BPKxYWJIMTXE56LWu4ZBR9X5GPWKy9hHD9jtOOqfy0ldUqa8sO5AIoYdiy49udTE295gww6pJBhCPinAUjtEqapfbKm5olj9DYW6k3995OLO9dvtwPxuQ8AhzbQlaJMdPpxwyZImPFgEAGSxVSivnFzeGphI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324711; c=relaxed/simple;
	bh=43akB5jSgNyH0DlkXodhbvo/Ue4XFTwmnnOxlj5Rkho=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YWFNDEYqb8rmJvyCKzONm9clfQGSktgL1yRP5rwxRqCvfPdJFOY9OPUAqhEWrZrPtCLoWliJ385Ekn5i5rU87dBmfaitsS8u2k1A6TuE5i6W5tMhmiS2mTA8uOuZqys54d9rb2UrWMQ8Vx4CKhsMOJYft6BaVZoxMMP14OfNRSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HUVVDKDn; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HUVVDKDn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcYRtrEIZUqqwyECTYQ+/XuyKZ2WSQHR/tUSmMSyI362dU2ydJKiTVe8eOSXbpxh9wfmrpCiN6KTsxwSlmXGhooVMv3RCq5Gv8CBDU3UJH19tAnn3CMs6fKAtDDoDU+pBRWD1c7QYqlGocC59k3PWBktnsy/zK8XwbVosvyinEhXSMQ8eBu1QtozcbEHJwD7aujxe+KzJiCIQWXt9PCDN9RQktuZ8Ma8Eg65BCmsf6Qf2NAp0M9wjZ2khiAT2j56psqmsqM5zZuO25SRWAQNtSR7yeJ63QCTPEpwiwxghMtMHPuAbFfNBYpqK0Jf3TXsjkc+KSbmu9UfCo85zVB5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43akB5jSgNyH0DlkXodhbvo/Ue4XFTwmnnOxlj5Rkho=;
 b=K9Hn73qyu3mEp+E85DWeUu5+HyGVd6VVQ+i5eizwVWwvL2zVsdLyii6fsciojMmunP/15jSSXAmNApd7oWJz2IU4j5liCKA9BkLLbWsfUeFIeGBL881tbx1cw3YeYs60MSGrExhWU0CZcWixu+CAQpAdRpsUyFDeMV+kSnTu2iqv9JeB23kkHOAytHHXYIde7+vuzHaGAupIhHxmA4+DT93u5/hD5xxwgrWX/diR+fLjRnb90vjVlkPjfI0C/YF/mAsiJk0Fo9WPAO8aAtoIWRtklzuCuuWUN2ci8eenzz0zV0Eraa4GZeEZSCD0N6zoToSHsWaatPP/wJJPSC7BkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43akB5jSgNyH0DlkXodhbvo/Ue4XFTwmnnOxlj5Rkho=;
 b=HUVVDKDnMFhUi85KJqsB/gM/pW4zIajpi65SLGHxaDzb1jo8ztb4RUwOGitTaIfDdBFUShakUAqVZQe8RB+qrSlpFEG96O3Y7th+7rvWgc5MsnuGz7XQiPXqrkcjiqvmmzSwLUZ+tjZ6Hb0VgKX360Cj4Rr0f9zSO3auEtUqIDlI4Od2qDXyBE32Q1ViXwGXr6KTs176r8M/upa6JCt8gWJrMlf0vo+9b9hL8q0+lNMDETN7jmPlPWIA4BgN5Srt5EoOXzVt8gpqLCWVtVCxAdxYr14oYOlDdJY10IT41GM51+nQInwcqyeaSbD8CdbC+VtR4RR513cl97ZCIjpvjQ==
Received: from IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10)
 by PH0PR12MB5632.namprd12.prod.outlook.com (2603:10b6:510:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Wed, 7 Feb
 2024 16:51:45 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.13; Wed, 7 Feb
 2024 16:51:39 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7270.016; Wed, 7 Feb 2024
 16:51:39 +0000
Message-ID: <62dcdaa3-936c-460a-8a54-edf7fa212599@nvidia.com>
Date: Wed, 7 Feb 2024 18:51:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/9] iommufd/iova_bitmap: Handle recording beyond the
 mapped pages
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
References: <20240202133415.23819-1-joao.m.martins@oracle.com>
 <20240202133415.23819-5-joao.m.martins@oracle.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240202133415.23819-5-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::12) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	DM6PR12MB5549:EE_|IA1PR12MB8405:EE_|PH0PR12MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a33eee-e62c-4681-890c-08dc27fd0db0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	duxDmTIJ4a4GdBodUTd8QwcZLcThwvjXO/8cAgWHyf+kRibOV6rZBhOIl1VWIeusHffOhg04W0vFHd77mJRyhv8d6jnfUzHyJ8irkaI1qXm7m+0WQ1izFo/jkgpC6PiSXi4aaTpB0VgoMNKA+d/JlUZdWo9mR4UDxbrop2wc/QTLgGVU2KyVNaLCSNl2HU60vfSwBacSD6PT3OIVHvVHgVTbQhRJm6NBnS5HBjnS2fy5/FzncVkE7GoJM7dEo4AhvKXAPQJD8VD9673zu4UVyPHc4lyltf4QMxkUUIrhC7QPKuan1WPlDy+FnX9UnrmFfxur+sx8t7p5WxnQ0CxRAuzvV1XJcH0zmVsAmOYLEnl+Knb7BGZCU7qYhMHBogx9ax0Fct0WwzugV5MEkNwKbsgw/BNU4QAuiXH4t1xhk40tB3xhs8nxfh2B9OLBRqZkQPQeJ0PpimopPOdBQbAmOLXnPdxU/Id1VmR6yHigWgyWFh/H3FNY7kkcPxBG+saYagvoLu/Nd3K0Y643wL+I19+CBWg2WHh+vhjk2530D1Jo3vAuEtTIplqS9ON/VnLszORZIFo4OLGlp53m7ekckZFuDyQhI9WoZ6bRCXLTLLK2TgZCdNd+zcYZDD9ZUXN78BWH3q5K62IlfSsEOnCaQQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(39860400002)(376002)(230922051799003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(6506007)(26005)(86362001)(6512007)(5660300002)(66946007)(8676002)(8936002)(31696002)(4326008)(31686004)(2616005)(53546011)(6486002)(54906003)(316002)(478600001)(83380400001)(38100700002)(2906002)(66556008)(66476007)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGdUdUU5QnJLcThvY3NacFp5VU1EOTcybmIwbkVadG9pbFh3eEdhTWg4UHdR?=
 =?utf-8?B?UXdsZTZhV0F4MFBUdys4MHpkUzhtQTRBQWRJWkdKa3VMOFFEZm9sb2Z2RFlW?=
 =?utf-8?B?ZEFsUEFja2VmWFFMd1ovbXlaSkJYRWVTelhjcnlxMktzVXB2eFBrMHdIY05V?=
 =?utf-8?B?UzhFSXowVVQ0cXR3eHAwTEJHUWxrL2xjWlA0ZkVSUHdVTHBDMjdPYUJXa2dK?=
 =?utf-8?B?ZkRDNld5Uks5QlFZcVN4TktHQjREZkpwbkk4U3ZKS3pnNFNpYmJyRGY2em5s?=
 =?utf-8?B?QzYwL0FsSVY4ZmVIbVZiMktPaTBqam9iN2pjamxvb3RneHpWZ0thRFVRbWMx?=
 =?utf-8?B?NTM2anFYSXAzMXhVK0xITFh6eTNCdCs0NGFBNkdNNHNjZ0w5UFFQMDdrdDds?=
 =?utf-8?B?eEFZRGlLSzFLa3EvajRwdE9xcUloU2RJOHJ5WTdkMEZVaGhlL1lBUXRsTnB4?=
 =?utf-8?B?Z3p0WnhFZHlYTDFXMW5WSitISmNWczFZL01IRFdzSFJJTkk3V0g4cVZFd0xN?=
 =?utf-8?B?RUx1R2dEQnBYUDErVDcwbzhSYnM4WUlQa3VrUkhsbnZWcFJuSTJ0RXllZmU2?=
 =?utf-8?B?N0ZFYURpSTNFMmpvUENCVEx3UVpZaXlNSERyY1FCRlFKSloyRzkvYUE5S2I5?=
 =?utf-8?B?N3Fub2NBQ0h0UW1BNThHVytseEQwcVAwUUlFZUR4V1dqaGdwbE0yZktBYm5v?=
 =?utf-8?B?TktnMmxFZ1RPaTF5NVg2VUVLeGVaUXBSYzR3S0E2YjBKdHYvOGI1TUJiODlm?=
 =?utf-8?B?d2ltb2VWZnZrNVdGeDlNdEdMMHVGcENmRCs1Znl4WXFxY1JmK1pOQkY4UGhH?=
 =?utf-8?B?aFM4M3BXclMrUmpqV2Rvai85Vnl0Z0NUZVdQRWFxTnJ3dTlFZ2dwcTBrOTJO?=
 =?utf-8?B?aldhR2Y4UFJPQ1dVRzZjNUlUdGdrR2xWTGtIM1FlVXM0WWpHVlA5WWs2UGNG?=
 =?utf-8?B?anlSdXR3cC8wbjB5WThxeEFKZXE4T2wva1F6QVp2dU5nTlJWTzdWTXZiNkNM?=
 =?utf-8?B?NzlWNGtlQ3lhRFp3aVAvUkM2eUtXM3ZsYWpzZ2c4K2N3ekppblVzT1ZjZm1v?=
 =?utf-8?B?TFN5Znp2MkhvVEJJM3hvcm5GbWlLNWFVV0pVdWhLNjBWYkkxTnFIWG9CSGQr?=
 =?utf-8?B?a1hxOWZvMU90OTVMTUJzNk5ybm1SQ0xRSXBBV2tMNW9LZ1lzWTZIK1dNMTEy?=
 =?utf-8?B?THZzRjkwS25SZFQwczAyWmsycUt4OVgzbEhCMXVOYURoVkt6SjN0ZFV3aDM0?=
 =?utf-8?B?dGZPQ2p2R3h4TEFiUnhCcVczMXVzZWZnQ0F1Wm1qMmVqdGxKOEF5TEUvaHRF?=
 =?utf-8?B?VnRPMTR2YVdHc2lNRGZhUm5mQnJNdXhCMEFycXpVK3JDRC8waE1JVGJXZVd2?=
 =?utf-8?B?ajZlZnNHQXlBUFJaZGMzbUlUV21YaEpRNzdRZURtbGpPY1ZJNHpSWEdqOGNZ?=
 =?utf-8?B?K1V6Tko5a253Ni9KeEl1MzNwdnJFenpFN2R6OWZiRVRVcXRkaHRXQWtYdkRW?=
 =?utf-8?B?SmthYUpCN2R2d3BBRG5MNXJjQVN1MlcxYlVEY0U4QkZJOEwzeGprRUQxMGoz?=
 =?utf-8?B?V2tUUGJlajVJd3QzMXFLL3RwN3RVQjVSOGhTanc1bXR5djV2UHpBZG0xZHI3?=
 =?utf-8?B?bXlMdlI4c2pUZ21ZRW9TM2k0RWszOTJhUGtwQzVqS0duZ3U4TVYxM1NHd0oz?=
 =?utf-8?B?Y1RadFJXeHhZQzQrajFkNmszajdNanM0M3dmaEl4SHVZeG4xR2xzcmRBQUs3?=
 =?utf-8?B?UHpCWGNuZjNMZlBueThNMjlIQTNYS1JOT2ViOUdSaFZYcndFVlJxcGRkN2Yr?=
 =?utf-8?B?dXc4cG5wV2xabzAvakhvTjRBM1VESU96V1dkaTUwdHBmaHNlSzZKUzBRNzJU?=
 =?utf-8?B?RnhYa2Z2N2paQTdDK2pubUFNNVBqNHVHQ2p6a3RCWitCMWtpTFdXeFBEOTVG?=
 =?utf-8?B?Z2lWNnFmbWo4NUFpbGpKakxkTGhpWDhOT0d3OUpJbGZRUU1qeURzR3hsWmtx?=
 =?utf-8?B?OFBsMDVhczdnYWtOWFVBYm5Xb0RRL09BZjBSaXA2L3BhaWk5QzFoeUl6SWll?=
 =?utf-8?B?N1lDRlUrRUNxUzJpbmRyWHZkd2laVk0vYVZNR0tWVlNpZWFGYlhlUVBSV3ZT?=
 =?utf-8?Q?4COU50ugSfmVHyWtnSGav1Nxv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a33eee-e62c-4681-890c-08dc27fd0db0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 16:51:39.1732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWdL5lzycbrxdYIf3tJKtrWwgPWnQIWPWEd/WFxwx40/ap02iphmqFoxDaELoxgVPy2lFpw/8WUTfsqsUYlumw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5632


On 02/02/2024 15:34, Joao Martins wrote:
> External email: Use caution opening links or attachments
>
>
> IOVA bitmap is a zerocopy scheme of recording dirty bits that iterate the
> different bitmap user pages at chunks of maximum of PAGE_SIZE/sizeof(struct
> page*) pages.
>
> When the iterations are split up into 64G, the end of the range may be
> broken up in a way that's aligned with a non base page PTE size. This leads
> to only part of the huge page being recorded in the bitmap. Note that in
> pratice this is only a problem for IOMMU dirty tracking i.e. when the
> backing PTEs are in IOMMU hugepages and the bitmap is in base page
> granularity. So far this not something that affects VF dirty trackers
> (which reports and records at the same granularity).
>
> To fix that, if there is a remainder of bits left to set in which the
> current IOVA bitmap doesn't cover, make a copy of the bitmap structure and
> iterate-and-set the rest of the bits remaining. Finally, when advancing the
> iterator, skip all the bits that were set ahead.
>
> Reported-by: Avihai Horon <avihaih@nvidia.com>
> Fixes: f35f22cc760e ("iommu/vt-d: Access/Dirty bit support for SS domains")
> Fixes: 421a511a293f ("iommu/amd: Access/Dirty bit support in IOPTEs")
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Tested-by: Avihai Horon <avihaih@nvidia.com>
