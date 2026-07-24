Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013064.outbound.protection.outlook.com [40.93.196.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE60039CCF8
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 07:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878523; cv=fail; b=Zy7LiGi6Nvu3eKcVQah4FvRALKMzrA1+do/Dufv1d0CqGF3VlnG9XJvH5jQl8GIWgS6YmD3xyziK0545/2rDKYlQGrpfto0pfKCXq67SbhNmfIoCOgQjgO18phsyksYVzPLmVNQSQA9kxafzoXj8cIJ3dcVfSkGcwdi9Zwb3kAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878523; c=relaxed/simple;
	bh=NIYi+73/qQIikaUwKX+NpxBhk0qAWrz90xVPl/cknkg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=G1CT+5BvM1ignXQn3/pyScIIXpeDuOyRG1yohLNc8dKXjkgEXfPOECCs8HnAh/pXCeGnzaovPNS0eY0rdYu9IJ2vFHxWXwiiH0+3Neksevam1Ls8dSzmrEfcWIqct8mXdgFSR80hgf+3I1ia4mUPiUiatELlMX7N9KO6C8nJ/f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z1kLCIQA; arc=fail smtp.client-ip=40.93.196.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z1kLCIQA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlgMMIEXy+bukH6wWck/8Ygw5VzUnDRIt5hPr4vbHiqpTzuVheufFdR+JiMRcbZYE4eDAKMazzdVdXtLpayyodvpD8cJC6+aRV3H2Amv+fhrI6fKuOgLpQCnI+OCHzr2+sRrQUaow9iDUK5Xvu29lkHwQvEv1d3ZO1IAeScanpstTC8el1G4zmYE1PY9gHPgy+CtYWN1bMMzKy5fRe5rbUm7Dq7YMAsh1xwTEMzzuCpQEDeNDGpiPX6WUJNUxuidGdTTpfNebnImmCcRw//UT7jY/M2vMQIA5UdVy/O8AM1UmZbdEs1K0rJnidOm8OjjSDcDkIY68weXf1jq6mNcVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmNs6zlLLLzTGshwkLKmVl3NgvLBspeik4teEj7aPpQ=;
 b=CrHFitWPFa33mHL8zKucndprshRVTFjhVUPqw1b7eyOXvKtSf0aqb6s/3AVkwwTziknw0D7m1wx6QDhirUA6uBHor9jju1R67BBsS2Gbfsz9lgvLo4pA//EDa4cNqVBVVEtZbh5GM4vLILjM2YneOE1Q/3Nzeb1pux1oonXnZJcpcaXvYbN3WEqtFPWYVuUzBpmWORe85YlWWloypX2VHkpXPdYTITZqLQXI3sw2HABh0wcvWTtsTrqjQ2ljb6XkrB2Fyfoc5IkbmLOVG3atRvoanL+6CyS0wid2M6W/vfC3r5pFXzKq9TobH7oF20g3MhpBtY2TeoWsODM+5NW/Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmNs6zlLLLzTGshwkLKmVl3NgvLBspeik4teEj7aPpQ=;
 b=Z1kLCIQAOUPce/cY4K9ASQJMQJExCzHHvYU+T6D+QpSsc7wDYzOs6mZLhWb7mf4APHp4qnSchKJRNnisjdRiK/1JzniD0TSTxfIpYzkbB4HhT6LgKLF6hpuEvqi8HvENWEuDony2c/vAypWEYX9QgaFsoUHiWhl8Yt4iWo2Gp8Zo5/yXs8LWbPYJfzva8HBGcEBvJG8nGAeMshfBihRdTPuy7AKj2kg2J5RgQY7/CXLxciTeLERX0CjWAcgYEET4FguTLYStch/OmkP/luP7O6DQeXYmJEXqOM46JpKenXAoaKGk3BjH/svRQNr1DNB8qd/wxropUXBjsPN2y9osIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS0PR12MB8217.namprd12.prod.outlook.com (2603:10b6:8:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 07:35:17 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 07:35:16 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-tegra@vger.kernel.org, "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject:
 Fixing TegraDRM on multi_v7_defconfig / Enabling DMA API with tegra-smmu
Date: Fri, 24 Jul 2026 16:35:07 +0900
Message-ID: <erKxvAxkSpOaODz6rOpDbQ@nvidia.com>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP301CA0077.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::19) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS0PR12MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: 1488706a-adcb-445f-dbec-08dee9561b2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|366016|376014|1800799024|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Hu8+6CZDYIGkj3c1DSMsYtNXohkcndP/eBIAmC+u069pDGGJYmpqsU6xgZCTFE61NJ4ufWIVytqCYwytk2YTeQ31UsEwfg5gbX9OgBipQeSsoWydjjlhDgiAqdH6VisJ5Nnj45o/+kEVxlcmCen2tt9esWoQLE6igo6xXYoV3Ux2SQB8cHQzwDmHux4naK8CrxIBZgy0qG6Ap6fxdLeoZ4Re32kM8XZDaGaUgnEOeaw/bDXoaidDsitFVAeo+iavqGGxSo905G8ZCZ8zi2QQcd/WRLO0/+FqyBiXup8cRjVtWOvDrbFPlwRFlHEhKDnbqAgGUXXecWFRz3I7KjJvwezcNu0n9vrgWE03dZgHzTsuf0shEDKo08/0mqqDNic9s4Igyxaryjplb5Xu1bb0UZXuLKKrr5t9d6nrcTx3bEdiDOrgqYTQ5CLt9IATi7BKuUexQs5gH4qHkV/m1QVTglnVRyCIhJxEINHDSuM+XNrIxNeywPhpOXc4/3pTw5C56RLsKuJzKnvedj1JxLFDP2z648ybmxfyTgMCUArFFRrhJj/waxzwX/yysVfhkd0uXFmSSArqntVRgGMyAoq2xT2UgmsaLe8eIWWyDjrRDBCcvzLihomwRrUpYJRlJ0vKAnWjdN+EYjxoIQ9lAyG1SiHh98ieKuiTmhpd/1SBmXM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(366016)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0dTT1RqdjErRnhmL2RwdW92MHM3b2JWOVhLUUJiWmZjOCsxSC9kemZnZkll?=
 =?utf-8?B?RE9kNnFSSzlMb29aS1hLY1NuWU0yWDNlUE82a1hnVmcxUEovSWlScms0empt?=
 =?utf-8?B?SFpIYjNuNVpPTXVjNGJYZC9wRmRIZ2pmYmxkYXhtMSt1SGVHUjZ3bzVGMVhC?=
 =?utf-8?B?YldYUlo3ak5JNVQ4bG9jbkI2WERZL2JRZkJzcTFvbmNlbFZhYktBMUVjVE1H?=
 =?utf-8?B?ZGJKdTgrZjUxK252QzgvTlNlaEdER2Y2Q25ER3pwZ291c3UvZUY0OVc0a0ZQ?=
 =?utf-8?B?dUJ3NmVNejJDZlN5dXJpREpTbUJLVThEQllxQzc1eEFpb0VxNklWWGNwT2Rp?=
 =?utf-8?B?RTVsRE5iSjRhZ1lPSEJXZG85Q1g2cVhFM3NQT29WRHl4UWNvYm1IVCt5bzhq?=
 =?utf-8?B?RXh0elRHeGtNSnJkSi94WnptT1daeHp4d3RBOEUxcVdZWEkzdVRNUFl5WmZO?=
 =?utf-8?B?SGFDODBtd0Mva2NIKzBpTmYwTGFGVVBYandCaytSMzRodU02cXh6emh1QXJz?=
 =?utf-8?B?YWR5ck9Qa1NUUHlzcWJZTkdtWDA0TWdVQ2tDYVQ4SitmZFNnZS85bGw4UFRG?=
 =?utf-8?B?MnNTdDF1dWVacitJdCswcmZtN2ZHaDBBRGRLc2pva29uVit2SkdjNFJ6K2s0?=
 =?utf-8?B?MjRHa0hrYUtudFNIUXdiZ2VObmZRbmp4VW91SGhLWTExdHNhNzZ3bzY0OEJB?=
 =?utf-8?B?bkRRc1BBTkI3NmtxWVhoL0wwVVpnMkIxR0szQ2dhTzNra2lxeTBPcDZSZElt?=
 =?utf-8?B?eVBYQ1FNRnoxTmw5SEV6ZUdWbmUyQXQxcHJoZ0JRMDZva1BKcFA1UWtvcGIx?=
 =?utf-8?B?em52SU13RmNoVW00OHZCRGFZUG1xblVXSG8xQitlazNtRGpRcUc0cFhYNHVK?=
 =?utf-8?B?S2pjNEtGZ2ZGaGp2QmJxSUVaNm4rU0xaNUNtNEVyVW4zRmo1WjVvR2w3UDRT?=
 =?utf-8?B?V2VkekFoTTMvUmFoVm93dVgvQnJ5RWl3WTMzblhqbm5iZzhvbmsyVjRCVldP?=
 =?utf-8?B?TW1pSEtBVDJsanl0VThtOTNncXE3WjBURlgzS2VIbGRoN2h0UTltc0Rya2Mr?=
 =?utf-8?B?UW9hTUd0MVkxQUE5SXJjOWxaeDgzSFJDQ3dnejNQMjBzNk5zRkVXb0FyVTMz?=
 =?utf-8?B?N1FEcWhXS1hjZEF0YzVRb3E1MDhnSmUzKzBSU0xMNFdzRDZiV0czUnZNcDdp?=
 =?utf-8?B?VGM3K1ZudEpROWdvV2grUGRPQlNNMnRUc0FoemI4c2ZxVEJGd3YrRlhiRWtS?=
 =?utf-8?B?TEw5MDRod29FcHoyeDJXeE1RVUM1UjNFNkFXQUJ5STlTT3dMS09vbEJTS1dG?=
 =?utf-8?B?VDk4Tkltd2hJbDJHWGpvN2JQU3VuYlNIVDNUYTVYWEo2eHppdUZEVnBpN0tn?=
 =?utf-8?B?Q2xPcS9LU0VJdE45ZUJnc3Z6bFZzaDArb0tlclBVT21IRVBQTmdkck9FWHpo?=
 =?utf-8?B?MWw3WXNSTjZKcnQwa29JQXM1K2pYVVpzTG84czhWbGpyb2tEMm5XcVdianIy?=
 =?utf-8?B?UVZkeUhVVm5NZzRNeXdDRERRNUZQcXdFM3IrSkdoYURyaWxzNDFDdlVucExO?=
 =?utf-8?B?dFZEZXVQVzhQbTNKeE0xQUhHT1pHeUVZakhOYkRLRFpLamMxcGdnM0pwL1Yy?=
 =?utf-8?B?MWJSMGQ3QjNvMVkyYXBKcXgweHpaUEpNUW5hTW1RZ3ZqbmErZEU1QUxsbDhW?=
 =?utf-8?B?ZDAyaTY4TTNSRTFvdkhTaHB0UVBsS1VJQXFTMzRFYTFOVEY3c3Q3TEtjMk9F?=
 =?utf-8?B?UHE5WllGb1lMK3NtVzlmb1JlSWlwcEx3dEtoTHBuMXg5djhxUVozYktHK3JQ?=
 =?utf-8?B?amN4RGRmcFYwVUFIUWluT1hWQVo1VkIreXpiNXZHR1AvZCtpekszMUtyYkF0?=
 =?utf-8?B?L1l0RnNmMUVJeEZlVHkwSDZ3cGtEVkU4VHhNZXlOazN3aE1KazNwckRZcUpI?=
 =?utf-8?B?T2NBL1RWVEJCZm1XZnpmcmdNSE51Q0dVSEdsUjBjdlJqdXhJQm9UTUl4c3NB?=
 =?utf-8?B?ckJoUzlBZDZ0Q3Z5c280eW1EczJheGtNTlN2L1NPTU01Y1BPVEVtUlpOTGR5?=
 =?utf-8?B?T3JLMFM5SjMxNzJycEJiN1RFZ2ZhS2lSVFJYMzkrWmh6UE1mMlFmUXplYWZq?=
 =?utf-8?B?azdVcytnU2dJS0xEWjBTOFQyRHVpK0Y0MmltYmtBYStrdUMxejNxMjg4bVRu?=
 =?utf-8?B?OXFJSGlIZW1pZmo2SzR2Y2JaeERRQ2tHR2NweTB0YjNsdXVabzR4aHlmVlVI?=
 =?utf-8?B?YWFpTDE1ajRCdkJ5T1ZwK0t4dlIwSUQ4dEs3dXI4MTdnMXlIK253Z1lGWHVE?=
 =?utf-8?B?N2p3VVAwZWxTaW1lMlo5SVZlQ3FGOGdITEVrY0lUUitXbTAxRVpDYjBBVzZJ?=
 =?utf-8?Q?P++snRqUunK1zPjV3lAB097LMiLb0q09mXJD4d/bPPSw5?=
X-MS-Exchange-AntiSpam-MessageData-1: Z1BwZi/vVFBiRA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1488706a-adcb-445f-dbec-08dee9561b2d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 07:35:16.8894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fmwq+h7o17tMRxUexYyZRR35tsz5X3M9M/BFkkLUtN4R3Vel6agqwBkpsYT+6fgFqiZa3FCq4NzTImrULBViIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217

Greetings everyone.

I've been looking at enabling more CI for 32-bit Tegra platforms 
recently, and I ran into a problem with TegraDRM not probing on 
tegra30-cardhu, but only on multi_v7_defconfig.

I traced the issue to the following sequence of events:

1. On multi_v7_defconfig, CONFIG_ARM_DMA_USE_IOMMU is enabled, while on 
   tegra_defconfig it is not. This causes arm_setup_iommu_dma_ops to run 
   on TegraDRM devices.

2. Some of these devices will be placed in a single IOMMU group by the 
   tegra-smmu driver. When arm_setup_iommu_dma_ops is called, depending 
   on probe deferrals, the group may have only the currently probing 
   device, or a previously deferred device and the new device.

   arm_setup_iommu_dma_ops calls iommu_attach_device. If the device is 
   alone in its group, this succeeds. If not, this fails. If 
   iommu_attach_device fails for every device in the group, everything 
   is "fine" and TegraDRM goes to probe and work fine. Hence let's 
   assume we have one device that succeeded the attach.

3. iommu_device_use_default_domain gets called and succeeds on the first 
   device in the group. On the second device in the group, it fails 
   since group->owner_cnt was already 1. The custom ARM DMA IOMMU 
   implementation uses a custom UNMANAGED domain so the domain != 
   default_domain check evaluates to true.

4. Devices fail to probe which leads TegraDRM overall not to probe.

I've thought of the following options to fix this:

1. Match behavior with tegra_defconfig: Figure out a way to not run 
   arm_setup_iommu_dma_ops for this situation (ideally any multi-device 
   group situation). However, I'd also like to enable DMA API with 
   tegra-smmu to get rid of the manual IOMMU API code paths in TegraDRM, 
   so this is not a particularly satisfying route.

2. Improve the legacy path: Fix the ARM IOMMU DMA code to support 
   groups, and add an exception in iommu_device_use_default_domain. But 
   I presume we don't want such non-trivial modifications to that code 
   at this point.

3. Modernize: Support CONFIG_IOMMU_DMA on ARM -- since there is an issue 
   with per-SoC quirks, I think this should be done one SoC at a time. 
   So come up with a way to dynamically pick between the legacy and 
   IOMMU_DMA paths. Perhaps if the SMMU driver explicitly requests the 
   DMA domain type, use the modern path. Currently, CONFIG_IOMMU_DMA and 
   CONFIG_ARM_DMA_USE_IOMMU are mutually exclusive so that has to be 
   changed.

FWIW, if we are to move to using DMA API with TegraDRM, one blocker 
would have to be resolved: boot splashes scanning out while the DMA 
domain is being set up. Since we cannot really use the iommu-addresses 
reserved-region device tree bindings with these old devices, my thought 
is to leave the display memory clients in bypass in tegra-smmu until the 
display driver has quiesced the hardware and can then call into 
tegra-smmu to enable translation.

Please let me know what you think and whom I missed in the To/Cc fields.

Thank you
Mikko



