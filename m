Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010064.outbound.protection.outlook.com [40.93.198.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756EB3126D8
	for <iommu@lists.linux.dev>; Mon,  3 Nov 2025 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762175192; cv=fail; b=XMZFfQAdmz6pJktBswl5wrlNE1TtmY4QxKnPfESwzLasvsvGKwJnR93qNzc3cCWZoYZdhxAk1MypXyRVbsyYnXoTNurRIsb0kdlOFl8bZ1UKVMjuK5gZyT20w2+XwwPeC2CdMV/QI0ZQt5nomu/B9g+Oo3ys0Nj3K6i0fMs/X8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762175192; c=relaxed/simple;
	bh=XIzRxB23y8vOnlVWUAq/YOiCzaoZVgWpQmYPqbPOlhQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qYDDPnQwwt0Fhl6qqa/QTDduz3eoRqS77yFM69QZGoGmA6BDRoVEajjKN/mfkIk8Mjo2F9EYjOBzhZgI0T1G0XmI/pGMMGQOXljxRsY8OsQH9r+mA3uupdUySITswGnMLMrveL6IF0wgkfikLn3GKO1jKAjHcrBUM8JptJvbsqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dygQ0GI+; arc=fail smtp.client-ip=40.93.198.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dygQ0GI+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNVyt+BpdltTk0Kccrr84LRtwj6D810PJbljuOTL4/iQ5Rsp9CH2toxK80iPtW1goX4NDzS0Zmtdbeui5HPvtgOmS2LcT32O3IHjm8jIAobz7MU4IHM+n3dUzouUlM5vrQd+35bUmzgc/b4J5hQ7sT+FSVM9PXZcHn8FTTfMOVRpamcsHajLPInBFb3sMkCR2zLKWpMypvZl1qaZwdLw0dVx1Y2Hlf5Ds59ZMhQlp9MYVgMpKHOgdIEecVBrkJcxLR/ooqB/0Kh+eejZigjfoQP/E6Z0DVJLZNNCmevVwji5Hbbg17Q2V+v/vp5S/sOr7/NcRLOb331PfA55uBbVdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWK5lfxcE8N9re200G1ZSSNW1CLnQ/q42SOEWkcMuU8=;
 b=U0NgRSUIkI/fev0+KfVA0vSxLWvLbZUk62YKjeW/WiqU+jY0nQLJ0R4qhMfX1GfKG+gW2o6tSa0xLToRokhNMLZP5pHn3WTeX61SEAhG9TTPNqhjIiqD2rlPpDvjBR8LQ+mvh5hQbFEMxTbZMRJQdHPAuFRajUz5gopj4Kz8lCLA9EcTGP5X0UOo/K+84o5GPFuLIOpbe5+TQZ9aBoX+42f62zil71Nl5hQdXzNksTVnD+8u9yZkQ4tmz1wgjmNGagmiCtxupcCvFVv+HFVb1FWSXTts/M9jztr6bQAQAArBHFW7VxNTebmmeNQVpozeSazjeeqsLB5E6+Ty58Mj0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWK5lfxcE8N9re200G1ZSSNW1CLnQ/q42SOEWkcMuU8=;
 b=dygQ0GI+6KGrTflqBq5qGMktZ3wx+fHl/gODBON3BIxH/5GKOAFhsx+zx3ft4qHREus59ZeMRyk2789uk8dHJJvqcwlWiULtDn90ywYymnAJl/KfuJODyiZDH8uYtcJj5q7YnFmu/Fjk79bInimej/Qmvjzg3inaYxGJsbStg2bhE2sD5RIN8xhQchdJpmYYC0y8uY3lWNhegK13IEtXq62jb8nzSxQzt5WeVQgwzwdKk+dG/hzl/mYjkLlgb/BwEBSPfXy4UGt5oXQLJvEFhZhKskhqR98UyNJriKuDXvJ0cqrb50UGxHHXUAagOGPcO1jc9K/SKV05A9wJ0uwdaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB9056.namprd12.prod.outlook.com (2603:10b6:930:34::5)
 by CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 13:06:25 +0000
Received: from CY5PR12MB9056.namprd12.prod.outlook.com
 ([fe80::9a15:4da5:cfae:f5c6]) by CY5PR12MB9056.namprd12.prod.outlook.com
 ([fe80::9a15:4da5:cfae:f5c6%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 13:06:25 +0000
Message-ID: <ac51c86e-775f-46c3-8767-c373d68c5522@nvidia.com>
Date: Mon, 3 Nov 2025 18:36:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iommu/arm-smmu-v3: Add device-tree support for CMDQV
 driver
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
 jonathanh@nvidia.com, jgg@ziepe.ca, linux-tegra@nvidia.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20251031062959.1521704-1-amhetre@nvidia.com>
 <20251031062959.1521704-2-amhetre@nvidia.com>
 <aQTyBBF0IoE+pcXW@Asurada-Nvidia>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <aQTyBBF0IoE+pcXW@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0244.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::10) To CY5PR12MB9056.namprd12.prod.outlook.com
 (2603:10b6:930:34::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB9056:EE_|CH2PR12MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: 651f81ec-0961-48da-d60e-08de1ad9cb1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGVvQXpzemE2TUZJQ2VUZG1oQzV2VWdVTlZIeVdlNmI5cmQvN1I2eFNBc09G?=
 =?utf-8?B?enlFUm93TzFsQVFXbDg3L0M1NHBTSnpleGE0VTUyQjlWQ081Y3Ava1VBUStp?=
 =?utf-8?B?d0RmR2VEcllrSkh1aCs3dWlnRHBkRWZYQW41S2NVSUxpMDNnMDF0bHZrWEtu?=
 =?utf-8?B?bmxIVUpsZk1ZTmRTYTJsY1FMbDZTaWhTTTE5OCtwNjNHZ1JWQWFpR1ZUL1hI?=
 =?utf-8?B?a2lKT1RmcExhMDBLVkk0dk9GLzV4eXQ2d0E0QVMzenZNa1d1QnB4NXFvNG5n?=
 =?utf-8?B?eVNRYmNmNDFCeWJBdmFLcG5ZVHlSMTBmK3hTSU14N0g1a2hJUzdxbTA1UVVR?=
 =?utf-8?B?aU1NZFVid0w2RkFWV0tpcVh2eWFYbm12dnZJYTZ3S2ZYVWo1c3gySHZSWHRF?=
 =?utf-8?B?WUFBZmwyWFpXY0J5VVhsSW1NQWhrS0V5S3FHUjdBRVNDR1Ztd2dpSUl4dlBu?=
 =?utf-8?B?eEhmM1Fnd1pVbUFRNkFIcGM5bUNaRzNGU082MzRBaFVoTFMyR3hhSG84RzZa?=
 =?utf-8?B?QXhaM1QxaUJGTUxaNjJQZE9FQXE1OXRvd1NWS1Y1Mmp1SVJKUDRYT3B2aUww?=
 =?utf-8?B?dll4a1Z6WGVVbVYwYkRSemROeU0rMEI2Vzlscy90Q1N1WXJZZE01T1MwODJW?=
 =?utf-8?B?clBlUGdjZnM2dmdXTWRsd0xITFZNNjIrT0hRaDlpWVpkQ1UxakthYkFleTlG?=
 =?utf-8?B?Vy9odGpYMUUydS85NUtlUGliajg4TlpNMDdsT0tBWFB0ME9Yazh0SDRjQXdE?=
 =?utf-8?B?OGpGN1kxTlJ1Z3JBaXRwNmVHSEJhYUNXRE9QQlBZQ0FoRVZFSDdBQ2g4aStr?=
 =?utf-8?B?dlRnVVZLTmtlYk0xL3EyZGJ2VmVFbitjU2lEUUhpS094UGJQSTNHYXo1ekZp?=
 =?utf-8?B?UjBqVnd5WFgzZm0rSmxYUk5zcW1WOEZ2Z0hRaXZuR3Y1SVhPMkhvbDl1bmcr?=
 =?utf-8?B?K2tzTEpUTVZnY2VrK2Rhck93V3o4SWI5dTlNWUhCckxCQ0NuS0tYZmtHK0d6?=
 =?utf-8?B?d2QwVXRWdkRuVTVoZFZhRVFIL2tmdSsrKzd2aHdmbXgxeFl5VE9wa3pOZFQ0?=
 =?utf-8?B?QlpGNDFMdnZoTlE3VWw1Ym40TjhyY3FTQnhja28rRVZrLzFnM0tEQU5pb3lw?=
 =?utf-8?B?dG9pYTF6Rml2SEVtenJuNDRwNGN3aHh2empsOHN3LzVkb3FDRTNlenQrUVFR?=
 =?utf-8?B?MGFEWHB6K3JyeGtqYkYzMDF6cm9FcDJtSHFORFU1S2lJOVRHY0wzS0tkTy84?=
 =?utf-8?B?cjJ3V3R0cHFOODNIK3A5bldkd0JENVhSMXdhc3ZkcUd1R1dMZ3Nlb3Q3b2c1?=
 =?utf-8?B?YXRBKzI5TlZxTTdkeWNYUlFWM2E4cHJOM0hLMlBaUGNYNFlPSzdFblE1N2k2?=
 =?utf-8?B?UnpYN3MwY1B4cDBHc0NaVDdxdUIrT1hHSElVTGVjblZwVE00ZCtpNVlpbXdW?=
 =?utf-8?B?Y3p0ZGNWa3ozdEV1dlRucHBnNnJCelBPVVFSMVpzMGxBK3ZacTJVNlZadlZS?=
 =?utf-8?B?MktDWU1VMlNZdFByRisyekdxL1VwWTVJYjdLUEVvbk5DRUwrYkdWa1JaVDgx?=
 =?utf-8?B?Q29sd3JRZmk0RVV0TXRhVjI4SlYzMlpWNzYrN255ZUoyc2lqOEtKRU5CN3ZW?=
 =?utf-8?B?SVNaR01mb1U3NkMyYVlUL3BKNWYwRWRTR0FIUC9La0p1Ymd1QTEzRXRNeUdh?=
 =?utf-8?B?Y1pYbER1WGtQTSs4SjhPbVJ3ZlZvckMvRldsbG1hT1NsQWpnTmR3bkZVWTlE?=
 =?utf-8?B?QkpSNVdwRzFJTE1nV3I0dUN3T2ZEeDdVQUZQMnJPeVo3c0JJSmNaUnRJamxU?=
 =?utf-8?B?SUljTlZFSmptRnBEbm1TUStlMDJOUGIwUmxuS0NMV3FNVkpqOWZLa1J0NDBK?=
 =?utf-8?B?R2RVcWNaaURxTllGTjJIeVpLZTRELyt2YXc4OWw2dTVpK0hZT3JjRUgyeUE3?=
 =?utf-8?Q?/9HJyQZJq7nLrBxhMXp6G4zwn5GbF33q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB9056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFFZdVl3S2FHQ2hEUXZKT21KM3hXbm9LY1dXYzdpYlE5ZmhIT0xJbE5WaUV3?=
 =?utf-8?B?TkxQR2UzLzkwa2dvayt0MjloNUN0T2xoU1FjZy83UjA5czd6eGdiTDBVa29h?=
 =?utf-8?B?c2hKUTBPNXhCVjZwY2hMNWl5QXU4MkgzUXF0aExmUWJWRURWaHVwM2VmNEkr?=
 =?utf-8?B?aVB4ZjM4dUdvVHZoYUpDbTF1eUlRT293RlFyTjFxUHczV28zRm1xL3JIcjYx?=
 =?utf-8?B?NmxZUm0wbC9FalJHS0NwUWZVSHZiM0prWkh6c01IdXJjNnRXUEhheHplZmxB?=
 =?utf-8?B?RmFlMWNuR2J2U201aE5UYVFRNXY1a0paWWVqN2VoaXowYklBNW9OK2lHTW56?=
 =?utf-8?B?ODhUN1BWZXU2OVhCL0dnNS9sKzZ0T0tNc2prREpLa2F6a2Eyb0t6Mis2S0hL?=
 =?utf-8?B?R3dHN09JaGxacFRYNk4vY2M2MjhjaGNPZFNkWllNMmpiOTZSODNBR2dVQTlB?=
 =?utf-8?B?clpYS292aDdXalpmZk84S2tLaU9YYVFMMlZ6dys3a3pUUWl1anl1cDRyMVl1?=
 =?utf-8?B?b2tEcTQ0MGsvRnBuWE5rbktIbmpXZE9WL0hLaVFNZTZNWFgwTjhuZDdWYjBv?=
 =?utf-8?B?aU4rN0x0RGozTmtoY1pGT2Rwc2VNdnFlVkY4b05GRFlPQmNxaFRPUTA4S3VR?=
 =?utf-8?B?NDRPVG1WWXUzMlhreVR6bzNJbHd3UEY3ZjdObVd6MDJoc3NnT0R1VDJLdU4v?=
 =?utf-8?B?TXJtK3BXL2Q2RTVDRTJ2R2Ywa2NzVmtnNTk0YjF0bTBFcm12RlY3dHpodmpR?=
 =?utf-8?B?NnNtSTFrVHNYdEs0VlY4QWpCd0h0bTIwRGJtN0ZVd1JaQVNqQ1BNOFJIdUI5?=
 =?utf-8?B?M09uZFk2aGZRRHNDczFDN1YySmxUWHZPUlRQdzBDY2F2allPb2djUmJzaWJ4?=
 =?utf-8?B?SmRvaEVua1hGa2xLb0V0SlhCcTQ4Tm9Rek9uQVNDWlZaTzdJL3VzbGgwQlVN?=
 =?utf-8?B?Y2NkanQ0dG9QM1h6RG92QkdRUGIxbjEvVGU1VndRaG1kYXcwbWdEN0tJVVBw?=
 =?utf-8?B?b0VRN1Q5VEhGVjlvcnJhQ0pVTlhFT05wZmZXamZyZkV6VFNyNnN5Ylh5azhq?=
 =?utf-8?B?WG12cEhOUFhGUXNmcmRveUNmYmtjWDVSNG83VUE4NndFT3RmWStIT0p0YW1I?=
 =?utf-8?B?UEZBNUthSnNqNDlmSUltT2tnRUpONVhiK2FQcUZKZ3RIRW1ZYitZMktLdi93?=
 =?utf-8?B?bXVOdTV4bDkzYnJod3dmaG1sR05mNFZJTXpLam1TUkhyY2hJNVBkS0tOdnVv?=
 =?utf-8?B?MVhEdW53RnNScEJEY0toTmFsWVVYYXpybVNnVmxMVitEQkxWbE1pNFBxTUlX?=
 =?utf-8?B?eEhKTEZEUHFMYTl6UGZpRTNWUzYzZ05lM1ZVaU51VXdGOTFMb1BQYk9ZTDFG?=
 =?utf-8?B?Nzd5UGNya25jNzNUMWdENUxSRCthK1BPcmVWdVIxNk9jcmdKSDJxb1BnYS9o?=
 =?utf-8?B?N0pWZzNyMEFKcjIxNkZJQ2RrbmRabHVXMjlQTkk3VlcrU1FrMjhITklBcXM3?=
 =?utf-8?B?Y2cyWGFvVEpIWDkwMWZKcStQQVFuRGI2MVBPNFh0QUxLS0dGQVoyZms3NUww?=
 =?utf-8?B?MkNtR3Nya1lpNytiVGg2Rnc2MWJ5ZGNhS0hyQy9nU2k2NVZHQ2hkY2NCSXBE?=
 =?utf-8?B?eGtKT0FjWlhkSTlscmN6QWZJQ3l0V3dDQkdkYmRZaDJUM1RkTlgrZWRrU3Ar?=
 =?utf-8?B?R1JUakRHVUovRW1FSkFZR1REeUZFUWovRmlpVkpqdk9MZEdjN2w1MkR6S0hi?=
 =?utf-8?B?dXhmZk1sbCtNTUdUNXV5ME5RM0gyd0RPcUNSb1JvbHozZFdpbmJmcWhmNG41?=
 =?utf-8?B?N1FIbzhZYkNpMGRvWlRWOC9qY3JxbGtseXcrMkRsZTh4cEVZaUNjSENUcHlk?=
 =?utf-8?B?a1dRYXQ1RWV0VjhVNm16clA0M0JObWZSSk43bEN1cXVxcjBkS29OYUhwVDIr?=
 =?utf-8?B?MXhFc1BDT0h2amtSdGtXb1drUkhsOFEveFJhWkV3Q25BTTM5NFNTTE82TjR3?=
 =?utf-8?B?T3hGZ0V6OWkrTXhlelQ0bXJnT0h0OXZ4dUZCK1d6dFV4MTZyZzZGb2szcStR?=
 =?utf-8?B?QS93OXdma3RUc0ZUZjd4Vm42NXJLbHVuMzNjVnM0U3lVcUlVQTVUTVdNdDVL?=
 =?utf-8?Q?8brtE1NiXuTC6KlWXfVw0zbnL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651f81ec-0961-48da-d60e-08de1ad9cb1d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB9056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 13:06:25.3005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqz7zRk6V9pHX+ihKkPft8O2kNazaF1U74xF90sei4Tj/bdItv5pUWdBz8KOV91nHdj4Qzkopyl4TWENf0fooQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038


On 10/31/2025 10:59 PM, Nicolin Chen wrote:
> On Fri, Oct 31, 2025 at 06:29:57AM +0000, Ashish Mhetre wrote:
>> Add device tree support to the CMDQV driver to enable usage on Tegra264
>> SoCs. The implementation mirrors the existing ACPI probe path, parsing
>> the nvidia,cmdqv phandle from the SMMU device tree node to associate
>> each SMMU with its corresponding CMDQV instance.
>>
>> Remove the ACPI dependency from Kconfig as the driver now supports both
>> ACPI and device tree initialization through conditional compilation.
>>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>
> With two nits:

Thanks Nic, I'll address these in next version and add reviewed by.
>> diff --git a/drivers/iommu/arm/Kconfig b/drivers/iommu/arm/Kconfig
>> index ef42bbe07dbe..5fac08b89dee 100644
>> --- a/drivers/iommu/arm/Kconfig
>> +++ b/drivers/iommu/arm/Kconfig
>> @@ -121,7 +121,6 @@ config ARM_SMMU_V3_KUNIT_TEST
>>   
>>   config TEGRA241_CMDQV
>>   	bool "NVIDIA Tegra241 CMDQ-V extension support for ARM SMMUv3"
>> -	depends on ACPI
> Perhaps:
> depends on OF || ACPI
>
> and update the commit message.

Sure, I will fix this in V2.
>> +static void tegra_cmdqv_dt_probe(struct device_node *smmu_node,
>> +				 struct arm_smmu_device *smmu)
>> +{
>> +	struct platform_device *pdev;
>> +	struct device_node *np;
>> +
>> +	np = of_parse_phandle(smmu_node, "nvidia,cmdqv", 0);
>> +	if (!np)
>> +		return;
>> +
>> +	pdev = of_find_device_by_node(np);
>> +	of_node_put(np);
>> +	if (!pdev)
>> +		return;
>> +
>> +	smmu->impl_dev = &pdev->dev;
>> +	smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
>> +	dev_info(smmu->dev, "found companion CMDQV device: %s\n",
>> +			dev_name(smmu->impl_dev));
> 	dev_info(smmu->dev, "found companion CMDQV device: %s\n",
> 		 dev_name(smmu->impl_dev));

Ack,  I'll fix this in next version
> Nicolin
