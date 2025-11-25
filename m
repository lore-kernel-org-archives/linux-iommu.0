Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C307E273805
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764084396; cv=fail; b=TeoV0NkDizwmUL+92jdCeZtdmxHlI5wEQ2VR4RyUNiQYopxjluaHJgAruheqB28qUsHyKlgmK/FT8dh0VKR4B1bH5OiM64jM9yRitd2J0233ThwM0boqQ6neke9wbfCbZhxJOrMIfRYFpFzNtEUQGG9A9sTqN8UROuTphx+CIIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764084396; c=relaxed/simple;
	bh=Nq7WSBUhSm2SV/nl/WsdLfzkTz/BKFOpxzUVLoUs5jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q1IKbnL3BeXv3WHiwTzEuEfp3d3tehgMFKGVzmOvPJXhMiifEDlLGaVHDnNsVt3YB0ZrmCWu9cMqWd7++NdTjbr9YGrwrlZgLEfqPPGuOK2zZGiw5tfxA4YuXtqqMfoUX0eRjbQIYHCTxetKFoWdGE4hf2PsTOmV5KfNazg0YgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a7007+FH; arc=fail smtp.client-ip=52.101.56.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a7007+FH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRvKx83CowfdOVTHzDcm4ddlYlM9MzOmTRR6l2vpOEb1mmTQPKAKbdzmvOVLdk9+MrQCNy0uYszD7AELJw/zeQBObuIV+jbND3I9Q3OslU47I+YfbT9LtfOHpLdDZZUl3sNZesUY1UdgB/qgDfgYD5uMzyKJWUIb0chy7wbHUPspsjhJMLNPl4IzPWBe2x7yUmHqHriCaaH3kboBZxnv7z9kTNs6VZR5Vym6S97UWsDkZby0kZNKwAjUT7DzIBX2Tpy95rkMaJQLUpOljgE3FhNHNB1njYWgXOsv75G4hMBcKBLDSzzWc0fC/JFqUreKUYqgWHlvQ3r6SAWUd1iMsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8Lx3bq6cNQvTUFjgvP8twaMwIpGwBSDJABWjwedhcQ=;
 b=Q91u/cEK7vnO9vIUvIxFEzAOWVVBjh5S4/4z36FAwIZ1rmqUwpzfGe1Pl2hbv5oklFXMQxHuGJsnHsO9xZSjHPuk4z6lGYr7a69xI6XDLwE7vddgQXYhQPjN2iWH2xJsxZGpMtTyiEpRm8OK8aWPTDGXLAeOJ1eTI1jAhzOkS/uhHBQbYib0pZNPUGsG3or/OjOuIdB3t+KQsHh0sLY1GB1rOPbJWQuvHk+0aOWMeX9OYGL1fVVUiLPdU7sEVKejXTcECrbPJ38yJsG57Tm4k2zrN5i2/7lmYHRidgwVINe279+tkRNq45Sogho6vhy7KGOoHyyii3G9nRHF6uylrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8Lx3bq6cNQvTUFjgvP8twaMwIpGwBSDJABWjwedhcQ=;
 b=a7007+FHLFw/YOyw4SUf2fcjYDbXWHd5LOCNbZ4Ag9cS7Fsdh1iGnXREUTF7x/hltWWi5LHPrkLMG34wh1KdrW3n3uBfNy/ZYy7lHapuZZwMpttB57ldj5d+7ZmKAN0JeyV5fH8kZXyedv9b8NRD75743dmZ9HnWX8DbkqLVZcJjIaEvkNVrqrUwHTDiuttCa8dU5/FRv8T03L/RIWapQgo9Vmy7gFMjVfPhP8qg3yYTg0Gbcaa1tNVjO864KGxBxjq+6kjeT1aQQ2r6N6tl46/+AfLcD8UNEjZmGiZ1aGPbJx9fZ6D8LkpVSPoOWwER575oQmUT+eOWZUb4uJEgSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BN7PPF3C1137D8A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.16; Tue, 25 Nov
 2025 15:26:30 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Tue, 25 Nov 2025
 15:26:30 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: will@kernel.org,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com,
	joro@8bytes.org,
	kevin.tian@intel.com,
	praan@google.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skolothumtho@nvidia.com
Subject: Re: [PATCH v2] iommu/arm-smmu-v3-iommufd: Allow attaching nested domain for GBPA cases
Date: Tue, 25 Nov 2025 11:26:11 -0400
Message-ID: <176408432658.533561.11326321438945922716.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103172755.2026145-1-nicolinc@nvidia.com>
References: <20251103172755.2026145-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAP220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::26) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BN7PPF3C1137D8A:EE_
X-MS-Office365-Filtering-Correlation-Id: d23054e5-3984-4ebf-0331-08de2c37024b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VG5wem1KS1VTM2drNWw3dVArK2JnZ0V2SEVaSFJaUVlsenpRMkcrN3gwMm85?=
 =?utf-8?B?cUU5Rmttby9hMHUrZVhyNlV1a05sazlQVG9meHFTT29BK0VhTVY3dFZ0R0Zw?=
 =?utf-8?B?MGhxSmlvaFpXZVNZSVZLbGVqSDI0T1NrV1ZOVUF2Q1cwMjNqazhJS21iUzdB?=
 =?utf-8?B?bnJFcm9XVzcyaGwreUtvaVZGSTBiUkZJYlNjT3UrR3pIY0U0M0NVb09HTExT?=
 =?utf-8?B?VWExZG41MTNVejd5ZU41dndsR096K3cxSWk4Q3U0T08yMTJZSEloMHFBZEYr?=
 =?utf-8?B?V28rVk9GUlN4Mnh2eU04UTBWYW1PUys1cGd5MHRWQmFJVlBmUElVNTNlVnZ2?=
 =?utf-8?B?SUo4NmZPQ1RXMFU2cWdSQnd5ckRJZ0s3VjZ5UnNPaTljeXU0bWVDZ3pxdU54?=
 =?utf-8?B?d1JsZTV2Mnd0VEdJTWFpdEdlVHE4aHNHYUVvcFNRQjlVOGdVRDRXYlFpOVRT?=
 =?utf-8?B?SXhWdGowSWcyRzFrOHlTV2ZtaTIra2FQWExuZTU0Z3JXZmdBZUgrcitZRzZM?=
 =?utf-8?B?ck1rSFQ0cmVocCt0Z285RXJCODBaWEZoTklWZFZuVFV6cTlPUklyZWlkSHla?=
 =?utf-8?B?SE1TQXZhcXZ2aWNrSzRRYnRRUkZneUIrNFFyNjhuUjZsZ0I5a2ZBK3NWd1N0?=
 =?utf-8?B?dXRBUytTTVZGM0R1M2Q3ay9FUStlZ1VsMDZmWDFzdlB3UWhLbzVDa0pEaEFz?=
 =?utf-8?B?dUQ0U0M2dlo0VHJYdDNoVCtwSFBBRzVicmxtbDhVNys2OFhCZTdkTXVUNGQz?=
 =?utf-8?B?cmc4RlhYMElnMTZ4VW94a01MREZMemI3bkJuWmp0aEE3K1RMZTFxb2dWQ0la?=
 =?utf-8?B?OWxMQ3NRUVFTaC9SR3E1YlovNjZldExPUEx5eDkzQWo3K2FpZEUzek54Mi8x?=
 =?utf-8?B?aVNlOGRLS2E3R2JrZGxoU1FMZE1oV3hDTE5DcDdBL3BKOVowSE9aRTV6WXZ1?=
 =?utf-8?B?Nkt1aTluSFRiaDFnRG1VNFhwTTNnTDgzVlh3NzJJcE1KTnFLQ1lHRll3K0JB?=
 =?utf-8?B?S3JmRENCTWtwb1VOZEtNaWo2UDQrdCtId2E4WnZFU0ZUcnVVcXV2K0hiRnpD?=
 =?utf-8?B?UUE5QVhyTWFaejBCVFEzZkl0WGRkRGZmLytEdnhGU0NRUFlrMFk0ZVJ0SGI1?=
 =?utf-8?B?dWQrZDdITWFWVVhLVzB3a0hUelNhejE1NHByR3NHb09iRHB2c3BHTG5KRjdi?=
 =?utf-8?B?SHdMa2R1akQrZ0JXV2xsN2ZKa3hEcWZaWUtKdzNHQlhiTnJlQlV2VTdpV1hm?=
 =?utf-8?B?ZEdORFZkN0xmSzFyL3Fpbmp4K2ZRNzdJOVVLZ285RzF1UGVJUWZVSjB5WU5M?=
 =?utf-8?B?WVAreHJLZ3JXNFY1WWpwOEwvVjRoTkU0bDN3ZFozanlibDdhUWV1aXN2aWJB?=
 =?utf-8?B?N3pGem9ZT0R5WXZab3E2MjZMazBScjd3Qmw4TjNDZW9ZamdDdnFZUUtJRFZo?=
 =?utf-8?B?cU5hTUhHZ0Z4c0JCNXpuK3lVLzdseCs0UlhaVHBKR0k1NzVwWFI0OXdSMmFX?=
 =?utf-8?B?QTduZ3ZpdGl2aXpLRDRYdFpXcEZSNEhnNDBWMkdISWd0V3I2cytGNjdESlR4?=
 =?utf-8?B?QWtralJNbE0vSjZxZUZlaSs3Mi91OGtwdkdJbEpwc3ZWY09vbWQvdDJiS0Z2?=
 =?utf-8?B?MnpVNWpmZFR4NGJ5dUJuTWZ2dW1DSlIxcGU1MGxOYm9lNnVlNnlrcHcwTThn?=
 =?utf-8?B?WmsxeHdVVFAyemFmUGlkZDNObW5LOVN1YnhJZnJsMXdFTllxZXFlOXY0MEcz?=
 =?utf-8?B?cEE0MXlHRjZiMEdueUR5eDlnQitxVDBLOWphQjh4a0JpSDJodTI0MWZOQ3Rh?=
 =?utf-8?B?bmZ3aWt4OHBvK3ZoNVVWeFVURVl4Wi9obzE3eXhMcUJmMVRkZFhXKzFmcUVW?=
 =?utf-8?B?L1VLRVFIU0xiUm04cTlqY2F2MXhYaWhnL0JSYmRVSEhVTFozUHk3NkgwQWVq?=
 =?utf-8?B?aTFLMnRMZEpNRlhsNDBtMDdFSEc3ZlpidUxLQ3RHVEhHQ3lQeEFrMDdkbkgz?=
 =?utf-8?B?NzltbTB2T3pBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjFZckMxcTkvZG55NFhwQW9nLzR4V2s1cE9FOE00ZGhpQjNyU20rL0NpZnE4?=
 =?utf-8?B?M29TY2xhNC9oSVlBczlIYVpnd3FibW80bnRxenpaS0JTU2d1dGw4bVI5cEFN?=
 =?utf-8?B?d3NZUzZ3MTF3enNTbXpsWllDMHNnck1pVUNKN0VlY2VWb0JzTmZRSW1FM2dw?=
 =?utf-8?B?b0U5Z2szL1U4MUVVb0FnZCtENjJmUzRPWGJqTEJNdTVqZlNLak9YUTd5d0NM?=
 =?utf-8?B?TGh1VU0yMTU2NzgzZFhUS1RDbWdMUkZCUm91ZS8rZ1VMYnRXVjdnaVdSeTVl?=
 =?utf-8?B?UXBlcER6b0IxbFp0VWFnd2VhOG94dk8rWE9FVTFpUFhORFEzMUtHaisvSU1j?=
 =?utf-8?B?UHY2QXNxUlp5V0ZMUG1NTm16Nm5iNVVVcnF1NnRFdS9LdkdZSDNHVjhIUzFh?=
 =?utf-8?B?eld3dEl6Ujkzd3BmVmo4dkd1STU5Q2hFc256UXYvK29rNEgwVWZ2THBBcU1V?=
 =?utf-8?B?WkNpc05ET2RWSVl3TS8wMFpTSUdCVE9rbGVRMmxYRDFMd1E3di9NYnl3ZnZN?=
 =?utf-8?B?a3plZExFUFpuWWZGZGhramJxWkhLbDg2TjI1eHBCbExMVk1DazNWVkd5ZzBt?=
 =?utf-8?B?TmpnOXEzd0h2VUovQmpuanpVTEcrbjgraGo2R3E5UFpRMTZxZFVDWWVvbXlU?=
 =?utf-8?B?ZW54UHFkdHkwa3hsd3U5MFluMGVBSzRJRGxabFZYZTRjY2xyR2xXOWw5aDlZ?=
 =?utf-8?B?UW9xTTIycUN4dFpMYVRmTGFzc3RYZDBzTThlQkowK3FwTGdyaWdqbDZYYUNy?=
 =?utf-8?B?c1JNc2ZHeG9xWWZhYVpOU2EzRGpnTGwxRFE4T2cySDcxMWJBRFVGNFJyUVJC?=
 =?utf-8?B?ZWE2dzVzcVcrNTVRb2NhSEVaeWxBd2lydkxxNTZ6aDdIcC9id0xVcWZ6eVI2?=
 =?utf-8?B?TzRYeDB2UCtSZlZmcXkxU2JMNVcyanprYjJMOEFvUlkyNldYZEN5N1VLV1d2?=
 =?utf-8?B?czJldnlFSVZDMEhEaHMzZUlrbHpoYXJQS3E4WmNYTmhlWmtrSDZJc0pvTXVN?=
 =?utf-8?B?Y1BuMHR4OENmZXNwbUpUNEJqSGhZK1JKUmJpZHFSdnN4Y2RHa0pLc0lra1Ra?=
 =?utf-8?B?QTltV2t1eXdCMmloSWk3c2ZaU1B4Ulg5SmlHNXhPT253R1VlS2NMU200M21W?=
 =?utf-8?B?QjF5QmkzKzRGK0hpaG5tbysvUUsza1czY1B2T2tUOG1iM1lxcUIxZVY4ZVht?=
 =?utf-8?B?ZXlDazdKWGtCWm9vVnNZTkp3SjVhUmhLd1pRY3VhWXBTNm9sL0k1d0N4cTRG?=
 =?utf-8?B?K29ON0J0cTZkYkRnREFZY3ZkM3g0WHB1Qll2MDhzZ0VmZkFNWlNRTkNFQnIv?=
 =?utf-8?B?b3Y4Sm1jejB2cnIrVm13aFNqQk9nTk9PYXdLK2ZyUkpzbHd1N0RXR0ZzKzE5?=
 =?utf-8?B?ZHNqVHR3TzdtcDZxdkFzR0trNWVrdUdaeGdYNnd6YnE0czFGMUVCY3M2YnJE?=
 =?utf-8?B?OVZQcnhvNStSdTNXZ3R1MVZ1VXRDVjFUeVM0SVRMSVZITSs0aEpKUmI2aW55?=
 =?utf-8?B?dnY1NTJkR2twQWZwRTUvakZNVmpXU3RpdXNQZUpEbXM4L0xpN1MwTi9QUDVM?=
 =?utf-8?B?Y1NzZEhVUXJXVFcvVzJ1ak9KbldsQllvU3M4MDRBd1hNa2tBVW1LTEs1NER2?=
 =?utf-8?B?MkRZYzhLSys0eVQ4ZktmOUUzSi9yYXhVdEF5QnhCeFo4ZnlQUFFFc0JaWEpw?=
 =?utf-8?B?UkRPb0ZTZEtRckJhUDBIcFd0ZFY3SE1yL0RBdDJUREJYc05kWjhaejl4YTdt?=
 =?utf-8?B?cW8zeitIM1VPdXNTQjYrVDFCVDVsVU1kb0dqRHFBRHZTRXFyL2N3QS92VmMw?=
 =?utf-8?B?aC96eE85YUtxNDloZEw0eVRST2ozbWU3Z1FXN3p5STNiTnRjaHNURmQyM0Yv?=
 =?utf-8?B?anNlT1NKWFdvUzgxa3JYRW4xNm45eFRnUDZ3ZWFyOUVtQVZuVXhOS3B3aHhY?=
 =?utf-8?B?UFFiZW1ubmNSVnJZOE9GS3hjNjN5K05RWG5xL1ExS3d1WFVUV3RaSUZIQzNE?=
 =?utf-8?B?bVJwS0JZMUdkcW1reXpBMVl4ejNoQXpubjZyMUVkL0s2blZ2SnpTdDdZQ0tC?=
 =?utf-8?B?UlgvaWNBMUp2SWVIYWFEUXFDeDhJaWlZYUo4Nk40L2xtaXVweGoyZThpNFJI?=
 =?utf-8?Q?gSmY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23054e5-3984-4ebf-0331-08de2c37024b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 15:26:30.7943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlShNIV52KtvIonascJ4tiKooIY3NgpsThtDL9Wi9Trw986MmTxc9OHh6LuNelWi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF3C1137D8A


On Mon, 03 Nov 2025 09:27:55 -0800, Nicolin Chen wrote:
> A vDEVICE has been a hard requirement for attaching a nested domain to the
> device. This makes sense when installing a guest STE, since a vSID must be
> present and given to the kernel during the vDEVICE allocation.
> 
> But, when CR0.SMMUEN is disabled, VM doesn't really need a vSID to program
> the vSMMU behavior as GBPA will take effect, in which case the vSTE in the
> nested domain could have carried the bypass or abort configuration in GBPA
> register. Thus, having such a hard requirement doesn't work well for GBPA.
> 
> [...]

Applied, thanks!

[1/1] iommu/arm-smmu-v3-iommufd: Allow attaching nested domain for GBPA cases
      https://git.kernel.org/jgg/iommufd/c/9f0b286fe40130

Best regards,
-- 
Jason Gunthorpe <jgg@nvidia.com>
