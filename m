Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16189331EDF
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787354153; cv=fail; b=dNcWfNE6o/6cuk8Uwh4s/yXRJqc1SBmvY3H7DdgVGAYrBOPuiqn3i5UUvxWLrzorJCBnb9ZE5Ah48bWhrMjgNC4osWi+i1RBW591yBQIz/vwhXQfhRL11M1zwrat5Du1NdIAQTeqzFZKQXSBV2FbDPaD12uwOTBongrd8n6FF4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787354153; c=relaxed/simple;
	bh=lSNOgp2y8rZzxzXoqKe6m2g4wfXh+IVnkVVIWx9BdEM=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=ew8FodTWZqdH8ejUK7/HjK6rvd6SgUjjDB9wiBefZheJYGv3yORTFdgmY3FAE0M6QrhwdZyy00pAed6zGsUgxheghLPIJ63PDxJlPuIyNNAqL+NJ6TwF0rQGbYTX8cHBUr56PWeR11FC58+qgh2CzHdImEDKX6x9HXsgpgVAoYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R58zp7lR; arc=fail smtp.client-ip=52.101.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R58zp7lR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPdYL34iGlL7ImgT7KL+OuW/gnOHZsVdqpsDRAZt8YEaaJSWqttygeAqQNlFmv47XafKYdKVU+bGzXovviV9EVT/QDr5RveNyWy+uqYn0/Abq8KaykDUyq8IeYxafIzVADzq7/k8+kSEYFAMwmbRY/XxaLGUXGxHgNkFiGB71r6H7VofZp8eU/Szz7KGK0b/ipKxrvGUEvXTyeQk5aw984db4NtXjw0metrTkzfGKayTEmbzaNf6qvNp2CIoVmngSeMFINlFbALYPxKsHVV+pktsgPodMhdGUg5NJMk90MB1xD+uhrcb5iu6vveb1lq/Zdzmce2mJSgWdhYupLEaSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8O0WVEBHiXGNshdM/WCAdDIzg2Gb1cvsbwUdVR2CAiI=;
 b=aQwZK8SodRCl5cJSnYbiuI+z02o6eEQrr/1fpkqkNQX1wgipAJxVQ+SlripTTK8T5n+UoOo0L9B/Jo27ld7JP6LGb078P7JufI6JculDQuDVaORV7e7uYCRzccMIC67xvpdzNRbjILdcr17+cngv9Veu9hLfH2j4SzS7e8n5JNWqs8SZR5qSXV38mkSg3gaUv04nbo0vxDG9XFPYuFAmhZmW3jIKMsCB9c0fbpjrSq8ka7Ev33E2gzcCsrEa77ScL7/V38Z++FmTWCzdvprjEYmx8Vz/Mwqsexv4pZmQ2tAiGIDlA24BMSLq26LI2lfWhz76Mpz5E3x/CfvQ48YjDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8O0WVEBHiXGNshdM/WCAdDIzg2Gb1cvsbwUdVR2CAiI=;
 b=R58zp7lRg62fm4ElSn0vnz96ZyWrxnOHUbKH2VSeksjEuxbhPoTwbWvTHQkD2Np1E8jVsVmCuC7oPomRzktWTjvBxUPFgVUMtJ6LS/zelJYTiRrRBHVg6hambDbrQHYTIphANyjjYh9rDO0TcNw3E4QsH+KZTkNXwmZtWAOtcEwRRk6K3/q+i4HqaMvpGkNqtnvHYd7SlHMYn3PWIVVMY2952qMgar0Izcp8c4bBRF0KKTVGkfowO0WZLIu0zq2dVWKbmbXqDVCXnvBukZueNVt0QV3+Y7wfT3tt2HRTcCj5gQEz5eQesasjNxfsqa16FIFKDOdWuPq33ubJrf9Jcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 23:15:33 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 23:15:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 03/12] iommu/arm-smmu-v3: Add strtab parse helpers
 to a new arm-smmu-v3-kexec.c
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org, 
 praan@google.com, kevin.tian@intel.com, smostafa@google.com, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, jamien@nvidia.com
In-Reply-To: <c6a0e50e73989b48d3669bdb342027c612794cd4.1784663184.git.nicolinc@nvidia.com>
References: <cover.1784663183.git.nicolinc@nvidia.com>
 <c6a0e50e73989b48d3669bdb342027c612794cd4.1784663184.git.nicolinc@nvidia.com>
Date: Fri, 21 Aug 2026 20:15:25 -0300
Message-Id: <178735412599.18212.17979807434141096326.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT3PR01CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 280b6c56-999f-4bc2-e7d2-08deffda180f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|56012099006|10067099003|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	vXMzZWvQSl+HFV94T9djxiApAJ7w6jCBO5lPq2YbgIlLwFjPvH9JS4f02yEInb0cQHzpTjPWc7ps9u7friGGZSfgGuMCfs9AhgL7tqOpUQHoxl98iTEuCqu7INJ9MTTFyxRbkcF68WInofbuXsj4xHWm03SiQxjQUjaQgeUgoVS0xv2oitFRimdNjkfN8VmxWsYeSD0UWoRfdfFYmwVzE481ZQOBgalCTEDaUMjRPTldU3pFY3MI8JjZ+L7CPdjR0YUXSVVrL0dsqVpYx+5a3moeXzHLGUtdc4i0ZB5rGeq4/D4YEwIBnmBIGqqfAuhPudzIrJBKx71jkMSS7QxveIh8nNczRsF1vskpST9tj/+JBHVNPhTwIhps1FHji2pVTU/seaI549Bs/tZrgv86kHH5CbCYSAExAwQ0IlKSdC68JCU4Hit/4ueb1HLNZ18C74o5OaoZlMUeA+87odPn8RkroaPdgN4k2myOacmqqE3KRSRcgXtNViMItAoFx7oRHaAcObHwHXqZw6byXB+dyWqfOgmN6AO/hay69vVsBLovkwq0ddtpgPweLd2/fj5Peh2XldbF8h67DaopeKirTzBxThUXQA9GfHgM7pQKPdIqpUrJy0dxUDrW8OZxnUo7Ai4Wn/kIU2LwGVnqeJep+XK4hq3qdwz3VULGTiHhP+Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzM1VWp0QlVlYzZKWGNBMUFnN2dZSS9kUTVxY3ZjVmJ2MVVRNFN5d3cyZmVJ?=
 =?utf-8?B?U3FWMWVyUm9Kdnd2V2lYdC9DRW9ZU1UwaGk5azRITStPQXpabDZRN2JYdGJh?=
 =?utf-8?B?NldyYmN3bmo0NEJxUnpLRGoyY1FiVUd4aE1TRlc0RUd0S2YxMmROVjJvL2N1?=
 =?utf-8?B?NytFcjFpd0NuQi9jNlFjTDIvTVZySnVJSTZ3c0tXUTlCWHNIb3EwOWJhWXI4?=
 =?utf-8?B?Z2lKVGhrQldiMURPY3cvSHBzSG1OUmRzbG5mTElhenFLSVZoRXIxWFJIK2RQ?=
 =?utf-8?B?Z05SLyt3QW9FdmJJUnlwWktUTDNNVzduVEkxWXdMaVlrRUtLQnVidXVvQmdz?=
 =?utf-8?B?WlFnRzliTm9sZDEwVUVVZXByMTlDeUt6eGVGQ2VjR2FTNjVxekxDQTBCVk01?=
 =?utf-8?B?dHU0YTRQVmFTeGd0aXNFazdxMFo0YVVOTzVwemtFa2hIMU1PeVUyUXNMWTNF?=
 =?utf-8?B?NzRLMjMzOVlkYitGc01vLzI3V040VjN0U3NoQXRuMWlWbmlHSDNxN3BzWFRY?=
 =?utf-8?B?cUtqN0xDME1wSUIvY3M0OW13ZWdrMGlwNTdRM2E1emV1a042VEJvVi8yYU1F?=
 =?utf-8?B?TFVOV3hBb2g0VERqSWVHWjZFcXh3WTBPdUdqeU5tOGt0elZ2SzlZemRlRWRX?=
 =?utf-8?B?SklCRFhIc2wrMEdQM2NTTU92QjlyWUtjK3JlUlhsZGxiNXE3NnMxSWpuTGdh?=
 =?utf-8?B?SWZWV0RFQk1RZzRBMU5IRitNVk1CN1BHcnpOTVYxTnRHdHRNV1RBR1IrMEgv?=
 =?utf-8?B?SWpHeGFYVVNzL2RzWmdLSWE0Q2s1K0R4dXA5b0lBRUtXcEdmRk5nZ1NhM0Na?=
 =?utf-8?B?em12Z1pVY0hCbmM2ZlVPd29xcmNEaURBU216N3VxVjk4dTg2OUs4QUtEMVE2?=
 =?utf-8?B?Nkc4Zi9ZSVMyZVc2L2tiVmZRT05JcGZ3N1FmVU40Y3lETTZ1VEZWcjJKaTB0?=
 =?utf-8?B?b0x0T2lWczB5SVU0RndiWnpGdFBwSFl5ejRHUHNlS3ZsU0R0OFAyNyt4LzRK?=
 =?utf-8?B?OTR5WiswZThYWXF6NlFON3lWMUtPdVpNL1NuSTVMUzgwSnQ4MjlhV2lhaXdE?=
 =?utf-8?B?Y0tpYWU5UktaWXIvL2p1bHE3aVMvQU0zQ0ptQ1plenZZU3FpaUVMcVJFa1RQ?=
 =?utf-8?B?eTRFZDhXalV3ZHFldlpZdU05b3ZOMjdncU1yRit2VDQwRmJXbjBlT2tpVDU1?=
 =?utf-8?B?UWYxWVJBdEVzcWx6R3JpWHdTZjZXSG9CdmlpcHV2NEEwRE1pYzJHR0M1MHFo?=
 =?utf-8?B?WEsvM01zMDZvY1Z1aE1WVkZ2TElCQ2JYNUwyZy96UnJKcTZIZ21UT29adTgz?=
 =?utf-8?B?dGxJTFgzNk5CYU1zOXlqS3pLV1hwZGEzcyttZThRUHV4M0ltSUVwR0h6WWZW?=
 =?utf-8?B?S292NEJ0eUJ3bHljUExsazljcGljOUY3dTBoZjVNQU00ZWZPaDA3WE0vUm54?=
 =?utf-8?B?eGp2d3VLNFc5dWcvR29oWGFMbTNnb2xkV0lmRUZ6bUdwN1FieHowVFIrNTA2?=
 =?utf-8?B?V3ZzSjVwNEdUekJVRWlCRWtkUDRBeENmVDJBRktWa0JXQVJLd3NmWnpZN2VZ?=
 =?utf-8?B?aWlQaDJKanEwdkxVOU9RVDhmMFJxd3pGRjZWUEx3Vk1acjlWSFgwaWpCdnow?=
 =?utf-8?B?RDl1Qk9oaFhrZlhiaVFRbnhoeWpkOHZjRXh1Z2JUaDFHMDlXTHVLamxzaFNj?=
 =?utf-8?B?WEhyNWk0VjRoNHJyUVJaQVpsL2VFd2IwTTdYY2d5TVFyV2wwamlWZFRVUDN0?=
 =?utf-8?B?T2Qyclg3YWlXWkJIS1JKTEEzNlBMZG8zYS8zcTdyLzhlZThDK1J0cWNaN0pV?=
 =?utf-8?B?RlQyc1QraU1oTm1oV3VvVmt1ZTVMYXU3RDdXWFJsdVVzemlzcmtWY05iSjBY?=
 =?utf-8?B?TDhSaSs2UWliNzFhR3o0NFNoUElwQlpvQi9wSnVoRVowNWtjdnN2bzJGL1hU?=
 =?utf-8?B?RFBSZTJ5bDVqVFdBYy9lYVY0RVlHaDIzR2IrK0VOTWcwMU1Ic1FTUVJJc3Fx?=
 =?utf-8?B?QVNNYTdLaDBETkFIU0FvbWdDWWc4ME5WUmlOa1NGQy8zaUovek4xUGJKZVJF?=
 =?utf-8?B?bzJGNXEwK2hjckZnU04wVmZJUUVZNFBhUk1NZzVZZ2VRYUs5eTNVemV5a09Q?=
 =?utf-8?B?Q1BKQkZZV1JpWXo0a05IYUNFT1MwZ2ZkdGpNcjFCbldteHUxa29weHc0NHFh?=
 =?utf-8?B?S2d6cjVFclhzWFB3WTd5blhhQ1dSNVFkc044VElIZnpKd1RhTk5maHNSNDJU?=
 =?utf-8?B?YmNGQmswUUlScmRzL3hKeXpyZ2NCQTBiVENYTkZPeGJBY0lOYjVmK3FEbjZI?=
 =?utf-8?Q?zU2tINKa/3t4A8hzeg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280b6c56-999f-4bc2-e7d2-08deffda180f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 23:15:30.7316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+yeWetVmOe+HhRiiZJcP0sN5u5vYipjXVe92uwNwYRcDOELD/e4i0ycw9Q4jv6m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402

On Tue, 21 Jul 2026 12:48:12 -0700, Nicolin Chen <nicolinc@nvidia.com> wrote:
> When booting after a kexec, both the kdump adoption and also the in-flight
> SMMUv3 live-update restoration built on the Kexec Handover (KHO) framework
> need to parse the previous kernel's STRTAB_BASE/STRTAB_BASE_CFG registers,
> in order to retain the stream table translating any in-flight DMAs.
> 
> Add a new arm-smmu-v3-kexec.c holding the common read-only helpers:
>  - arm_smmu_kexec_parse_strtab_2lvl()
>  - arm_smmu_kexec_parse_strtab_linear()
>  - arm_smmu_kexec_check_strtab_l1_desc()
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
