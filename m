Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692BC163
	for <iommu@lists.linux.dev>; Mon, 29 Jul 2024 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722241284; cv=fail; b=TlEnD9nC0ep4PljXMoTOWCkBO9BpUC7NTkvmeT4GfVhzM2ZbXH8nJChJwOuc7y4VjANoytL8eVrLIqZUZByhxqwRxfNixme05RBXR6GSZneN4jHzAeF4pfMhIFOYM/0D5QKIFvZ8DL4qj7tsuISorx7P3gA0+/qFsGLM+ZjgFzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722241284; c=relaxed/simple;
	bh=q1I4ka1X6QLvik3qEpucVwqq30K2JEcE/Dk6LKoDb/U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h6NjMdO3nQ/+GK8vAkbHuIWnMws+9vz5QTCZxp8BHPgsi49j9DYm8qHEGHonLQ3KVyXns0ERUB067//924HRXIoPrVIHI23v4TR4MljQdbF0UfizXacfj7Miaw+tfa0e1EFHkmdGth0DS6N5/1JEiV0ihYpwJj7GZsCY6lsHiNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JwmAoOy7; arc=fail smtp.client-ip=40.107.95.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JwmAoOy7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8PTWv3XFZzvP8UPOn3l6wEAHjAqXIxhrzDO2QOS2SItUM5YfHws6sYl6WRgBljiRakOWoiL/yAfbb0e0zIfuLrL6FT8wDKg7QmTFU8YevBHho7Ku1Bgttlku0q8RgjWDaZ38AQY1AXAvkiu0vjeukyq9db11Swe4OTqvrygAc89YtxAFRXtzag1GfwoESun6nSAL0r5Vz9sjViCLw/1JNaTOgmFur5zEP8o4P9jTtiEFrBQUtAbIszuJhtINTJ93+Azi33r5DeqvWhoZ1QPglizdVhOEK+qxC6YowWyzX2CXRCcv2nnXU3bbT8nGRh0pTJkEAZk46PdF9kWN+BvKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmO+J4gWLKOjtTrDFgGIwPcNZ6+PZiskAbLdM1ney8s=;
 b=mAPAWPdimoy9wLTcp8F/ktuEkciXJlVdH5MW5xFFD+MlxvQifBZJYg9riuF6z814AzCNSTdEi4mshOyY61yuzzqGKaJ2BnpG36xX6Xz4+EsSABUWg7lvsfPeCNgjey/X11rFoh57I6Hq4Owc8bwS6za/TI2DUqOb4VpD/ukmLhD/cT8qY/HhUwt4n4jhq0LSziZ+5vBlr2h3cYivWoIYNFUfddHQ6e+7YOb4xhIwbYT4qMHk0valJ8fcdnDhx1SbcIuDjLNV97xAiJWsMbzo6vKuHHzqi34JR13OvRotPMmJVpzr8FljyX2KluWnGr3QnNTVRAKvvUm5lK1gtwbuhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmO+J4gWLKOjtTrDFgGIwPcNZ6+PZiskAbLdM1ney8s=;
 b=JwmAoOy7pAJnFMWBER8mA2kq9K+dNlIKGnDbsbT+YW8Sk0KkQ904u598lC2DAKjomoynunJ5Uj2NSUDhtkYnpZdtLb8YR0dLRwrXzIn3YmWJGmieInp9XBtokSgFmk3FYTYB6wXKh3Q5M8ojfWHGA4/797XcMDVUdOWUNKExrxqC4M5dMak+Zaug12xEEEOn40sxT3fQpJ3P/sMti72QLmLoi3vTCi84wxTRmHjQH+SywEwX6W1sl0K9PpxHgUolMz+/PmEHadTomAcgBG8hGNVAI/5Oghjkb/+QsmXw5sr7yJepkpbdXI4lbF9KBa/aHobxQHVUBaR381lOmjtWCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18)
 by CH3PR12MB8901.namprd12.prod.outlook.com (2603:10b6:610:180::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Mon, 29 Jul
 2024 08:21:17 +0000
Received: from PH7PR12MB7426.namprd12.prod.outlook.com
 ([fe80::6fdd:1491:4d83:ac33]) by PH7PR12MB7426.namprd12.prod.outlook.com
 ([fe80::6fdd:1491:4d83:ac33%6]) with mapi id 15.20.7762.027; Mon, 29 Jul 2024
 08:21:17 +0000
Message-ID: <05b76fd3-74ca-45ad-a5c6-31719f5e1f0f@nvidia.com>
Date: Mon, 29 Jul 2024 13:51:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu: Optimize IOMMU UnMap
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20240717100619.108250-1-amhetre@nvidia.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <20240717100619.108250-1-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::28) To PH7PR12MB7426.namprd12.prod.outlook.com
 (2603:10b6:510:201::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7426:EE_|CH3PR12MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: 6431e3e9-9dda-4b20-4a75-08dcafa76b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0hHMDUvQmZ5N0ZrbG1KaHI4TFRmUjM5WlZ5ZkplQlVhSUVWeUtDUlBFQVZX?=
 =?utf-8?B?alZ1NHVzbmtKclFpcVhPcENSQXVMZUU3SnRYekxQQm52YS93R1J0Nk41d1g2?=
 =?utf-8?B?azlJa1l6N1l3a0UzTDBWQUJLQ0VFTVhqMklKNjgzekQ0dUhtRHNPbmF0Y0dJ?=
 =?utf-8?B?bSttYlB4S1l6K1BDM2FFNU1BL3NHaXRnVjlsYXBuajlBNWxkL1Q0TTRlNTBO?=
 =?utf-8?B?enlQOEdiY2QxK2xtZzZPdmxtYnh5NFowdXVvMXNHNDAzdk5IS3l4T0g0a2NE?=
 =?utf-8?B?WVFNWStZeGh6bFZiYk04cUl1NXpyaFd4MXpUUnM4d2k4UDAvTUoxeFJ4aS9N?=
 =?utf-8?B?cHdWZ05vQ1VydGxDejV4SVlCTGcwVis1UXBNZ3FSbDI1c295T2w1WFhha1d6?=
 =?utf-8?B?TVZlaThndDBmQngwV0NTK2FORzFCQ0tuYnVQNDk2dWVKWmRjWE9yRW9aM0ly?=
 =?utf-8?B?TVVUcnlmMkNXMXg2US9OZTI3aElaTm93VlNGWTJ4NHBiT0QwRm9odmc3VVFU?=
 =?utf-8?B?QmhYSk9OT2xGeXNzOWRBMjhVN2hnc3l2OEpTWENmaERlVm5rWXlhNXRxbWxi?=
 =?utf-8?B?Ni9MajByVS9UczVZdTNhSHJ4QzdDKzlzVEtwSFRUdEtRWXpTOGtQcDdkUC9z?=
 =?utf-8?B?SUg0VlRWd3NNNUppYTh4YWJrNXpkdndjYjRoUk02ei9XUHh2UnQ4QytLVDdG?=
 =?utf-8?B?Unk4WFkwSU12UEZvQnMvL0tadlBIeXg4bVdwSDk2bXpLdy9XSEFoMElwM0pC?=
 =?utf-8?B?MkVtYUpmS3lwZ0UwM3QzODVOeSt2L09LTC9SYlZTY2RzMjUreFdEYlg3VmlN?=
 =?utf-8?B?bWptcjRtcGppbVpuRDlSeHR1V1FidFpSLzN3eHNzcWlJczREV0FzSzJIUDdp?=
 =?utf-8?B?TW5uMEgrT3RReFQ5RjNxUUlEWVNsNG1NajFlMitFVGxicmtqY1FWZVluTE9Y?=
 =?utf-8?B?QURFS05QOUNVdTNOQkYxUHJUNDlySFVSaHF5aFhjb1VlY3VTNUFBUVdZVEJz?=
 =?utf-8?B?eXhmRE1zSTlhaS82VDdSSDhvOXRVZW9xSDhMN3pMZVZsUHhYeTBkZkJGbVZm?=
 =?utf-8?B?SUx5RU1yS0p2Vk4rNmRXb2VUVVZnV0JRR1BRbEk2a1BxbTViK21Nb1lNL2VS?=
 =?utf-8?B?aXFhc2lNd2xwMGFSN3hkbERxa25ob0tjZy9vYWRCQVpKUFV5VkppMGU0eVlD?=
 =?utf-8?B?cXN5cEViRmF3QzhoN3o0MnJ1dWRpMDRxNDJRTjBzWWVlSitxSVJTbGROWGZW?=
 =?utf-8?B?bzFab3QvUlExcElyRnhjWXpWck9wY0loUXJ5Rk84aDNPWWlqdVJYMWx2L1U1?=
 =?utf-8?B?N2F0RzExaU5ZbFRzbkxCYWYvYjR5SWxFRklZQmRYbGpyWFZsV2lVc1Ywd1dS?=
 =?utf-8?B?QTJLVVlwd2ZjSTIxMnNMdjNiakhOY2t1cjVSbE9nMW01WXhnUndGNWg1aGt6?=
 =?utf-8?B?cGVsNUZmelpQa1NleTFvSk9Qc1BnWUZmU2N6NU9HZ0hhMG1HdzZUeldrdjdw?=
 =?utf-8?B?RHVQQWlXR2pkU2ppaFpMWllhcHFKQm43VFkzR0NwYVRGVk8vNlpyMnRpMWx0?=
 =?utf-8?B?ZGVjK2g1dkhPbS80MzRmRnVkWFhIblozMndKYklaVUVaU2hxQkZmaFFDRGho?=
 =?utf-8?B?LyszbFIwcFRYWDJZNUdHYzVhRllIUThlL0pqUmxwZXh6Q205M3hkeTQ2aytI?=
 =?utf-8?B?VmxQOTJocnRaLzJrek92VHpDeHphV3pqVDNuMXRuTklWdU43T2U1TVlPaGV6?=
 =?utf-8?B?NkdpcE1qd2s0MjJ3NmdvU2Q2QXBIOUpOVWFDamp6N0xwTm5jL2ZUQS9HZ0d3?=
 =?utf-8?B?Mm5GUFZWQ1BFdnd5Sk5xdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7426.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0F5b3p3djhxWlk1RXNIYTB4eHp3bG01NjFWTEZVRE1DSC84T0tjUmhmYlcy?=
 =?utf-8?B?dnU3RVZleG1jT2RmUm9Gb1NrVFFqL25EbnVtSStJQlBvNXI3cnloWTZrdThw?=
 =?utf-8?B?aE9hMHN5aGlpSVlJRmlpb2pRQVlSdW5mMTd2aTVZWlVkbWd6MjdBM0xvODVx?=
 =?utf-8?B?OUxkdlhhVmVNckkzMVZFV053OUx4cmQwTGhrU2oxWE0raTRwV0xXYWVqeVJN?=
 =?utf-8?B?NmVObkZwUWI4OG5YZ3BjRjBWbTRKRDhGMjdYUzBqR25rcnZBRWR1OGVuZ3ZS?=
 =?utf-8?B?NG05N050a3VYYUNIbWkvcEpQdW8zdGVic0k0MmdtSXh6SUJxYlZCbmw1V2tH?=
 =?utf-8?B?eTVocFIvamVva2NqRGwrWjIrbWtLQ0svckR4TytEcW5leWpZQUF5c2ZGN3Bx?=
 =?utf-8?B?WnNrbWExVXRPMHg2WG1md3J0SFdZcWtCbVY5TE5TS3pRVUxFUVM5NWdsU255?=
 =?utf-8?B?djRoNnVrazVFRzV3UEpLSzhUdHl5dkxlNVQ4VTVUVksrS2NJd01vL09GQ05z?=
 =?utf-8?B?aDVhQVZ0MDI4TXlPYVFQR2FpMm5WWGRqbTlLTW9GMkFVTzZRT0ttMFp4bWdi?=
 =?utf-8?B?bkdDNmU2MHoxcEZWaXAvUTlwNDZjamJXTm9YT2dQRWlMWkkzLzhPVlJsTFo0?=
 =?utf-8?B?V0xOMFZpRkY3Znc3aEQxMEMrTzYvZmJ3cWRsUkdySVNBQk5XaHY0ZWhLVVJt?=
 =?utf-8?B?SWZWZ3o1UlIvMlRwaVZhWWJZTEpVUFllL2huZFJ4VUFvYjhWd1hvV2dCbzdk?=
 =?utf-8?B?SzBoS1loNWpHTDhjSEdwYzRGa290bkE2MldkaXhSSXZmbk15RVFjZ1R5ck0x?=
 =?utf-8?B?S3V4UGI3U3VQUVhQTWhNczF0UU1MS2t1VjBoaUtiTk5tTVFGS1E1U0lsTDYv?=
 =?utf-8?B?OFdxWFpvU05qVFpWN1BQdmdHQmV2eTc0UG1IYllsT1E3di9qMEFmTGtRUkVT?=
 =?utf-8?B?TDBEemI0OFZGNmFtTStncy9hMXdRanpxTHVxVHFkQlhzZitrUTJNaFo3ZlUz?=
 =?utf-8?B?NDJEaE9ybU9ZMUl0Z1prN1h0bUdsdHZKb3NMQVFtbENzSEs5ZHB0WDdUOXll?=
 =?utf-8?B?aXJabm5Ra3JVV0FQRzVmR3RwNlFtYWhZeEZJTGZDc1EranVyalRoSnM4ZGdZ?=
 =?utf-8?B?eUVScGk3czBwZU9FNXJvSmp1b0xjUzI2WDBaRk1TcEs1MDVQRGVobU9jZEho?=
 =?utf-8?B?RzRzdzFIZm1KT0RMdWtJWEtnT3hSQVhuZlNTVzY4b1hUa2FuMkh3NCtjNVQ1?=
 =?utf-8?B?dHZCdkNqeDVMNXhNYWkxbWVjeTNwcGc4WXFqQk5FV3hUYkxLb1cya0FrUjVn?=
 =?utf-8?B?VXdmd0pwOFFyVkxxSzZGdmFYYWQvZ0VrUmQxNkpKSTl1M1dMbUdlZlk3ZitV?=
 =?utf-8?B?dGZ1eVAzUjlISW9GcjZIZTVsRG8rb0xyeXFhb3lFMWVXU1ExWFlMK01oZnRT?=
 =?utf-8?B?SXp5YmZQQzdEZ0IraDgwWE5leUppSytvdENSTVZ0SWFNdmRiNW41aFVyRmIx?=
 =?utf-8?B?VFB1eUpZdk1meEkwTU9ST2E3bHpaZzNwYkpsRE1vYm9lY0N0NlI4d1pVS1kz?=
 =?utf-8?B?L29pMVBsL3lESlh0VVlpb0RqMk9DSm8xM0pKWWxpeVplSEwvWXc4OWRsT0Nt?=
 =?utf-8?B?ZzgxRTdQeFAyWTdtOVkyZElUWDd6dVJIUjNQcWhZbUJ5YitEV0d3NUFUbU1P?=
 =?utf-8?B?b2dDVThvek9xRUlNQnc4U2RPN2VMQkpZQkxYRmdIWkpmR2JCL3p2NTE0UUVT?=
 =?utf-8?B?RExPU3Y1a215b3N4cEw3U0owVTFpR3JkZythbFU3ZWM4ZXhidjBFZnkyeEtY?=
 =?utf-8?B?bWFMbGVaa2VITUJXZlcxRDAyQjF4eWMvc2tQWGxXQ0UzYnNTNFRRejUxTVJw?=
 =?utf-8?B?WDFUWVBBa2UzRTdKZTdPR2NneXZDeGNpclFxdEVBeGFsUS9uemZZWjQxTTBu?=
 =?utf-8?B?TTNJQmExNVFzYWVXM0psU2ZkekVzQnFnanVta09EZm54RGl6TFoxbDBVVWhO?=
 =?utf-8?B?LzZkVUJxNG0wc0xjVmN5ZzdEVlRUTDRhZ1Fla2I3bldTdEczcFBSRC9SUzN1?=
 =?utf-8?B?aEtDd2wxNk5kVWdjTHlsNEdnYlB5V05NSkxVVHJ2OFlVcTJWWTBOUkZWNDV3?=
 =?utf-8?Q?mmXsaarkZpQEDyLqge1n/JFg3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6431e3e9-9dda-4b20-4a75-08dcafa76b0e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7426.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 08:21:17.4305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgCJDFLxdZ0pj8eP7H/WwN/QnUwGym8riAOXEjL1/ngG7y+JZVRSqQ3Sw3RVLxOL2XZDwY/X9e3+h/Uz3XDB4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901


On 7/17/2024 3:36 PM, Ashish Mhetre wrote:
> The current __arm_lpae_unmap() function calls dma_sync() on individual
> PTEs after clearing them. Overall unmap performance can be improved by
> around 25% for large buffer sizes by combining the syncs for adjacent
> leaf entries.
> This patch optimizes the unmap time by clearing all the leaf entries and
> issuing a single dma_sync() for them.
> Below is detailed analysis of average unmap latency(in us) with and
> without this optimization obtained by running dma_map_benchmark for
> different buffer sizes.
>
> 		UnMap Latency(us)
> Size	Without		With		% gain with
> 	optimiztion	optimization	optimization
>
> 4KB	3		3		0
> 8KB	4		3.8		5
> 16KB	6.1		5.4		11.48
> 32KB	10.2		8.5		16.67
> 64KB	18.5		14.9		19.46
> 128KB	35		27.5		21.43
> 256KB	67.5		52.2		22.67
> 512KB	127.9		97.2		24.00
> 1MB	248.6		187.4		24.62
> 2MB	65.5		65.5		0
> 4MB	119.2		119		0.17
>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>   drivers/iommu/io-pgtable-arm.c | 34 +++++++++++++++++++++-------------
>   1 file changed, 21 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index f5d9fd1f45bf..1787615eec24 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -274,13 +274,15 @@ static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
>   				   sizeof(*ptep) * num_entries, DMA_TO_DEVICE);
>   }
>   
> -static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg)
> +static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg, int num_entries)
>   {
> +	int i;
>   
> -	*ptep = 0;
> +	for (i = 0; i < num_entries; i++)
> +		ptep[i] = 0;
>   
>   	if (!cfg->coherent_walk)
> -		__arm_lpae_sync_pte(ptep, 1, cfg);
> +		__arm_lpae_sync_pte(ptep, num_entries, cfg);
>   }
>   
>   static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
> @@ -635,9 +637,10 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>   			       unsigned long iova, size_t size, size_t pgcount,
>   			       int lvl, arm_lpae_iopte *ptep)
>   {
> +	bool gather_queued;
>   	arm_lpae_iopte pte;
>   	struct io_pgtable *iop = &data->iop;
> -	int i = 0, num_entries, max_entries, unmap_idx_start;
> +	int i = 0, j = 0, num_entries, max_entries, unmap_idx_start;
>   
>   	/* Something went horribly wrong and we ran out of page table */
>   	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
> @@ -652,28 +655,33 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>   	/* If the size matches this level, we're in the right place */
>   	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
>   		max_entries = ARM_LPAE_PTES_PER_TABLE(data) - unmap_idx_start;
> +		gather_queued = iommu_iotlb_gather_queued(gather);
>   		num_entries = min_t(int, pgcount, max_entries);
>   
> -		while (i < num_entries) {
> -			pte = READ_ONCE(*ptep);
> +		/* Find and handle non-leaf entries */
> +		for (i = 0; i < num_entries; i++) {
> +			pte = READ_ONCE(ptep[i]);
>   			if (WARN_ON(!pte))
>   				break;
>   
> -			__arm_lpae_clear_pte(ptep, &iop->cfg);
> -
>   			if (!iopte_leaf(pte, lvl, iop->fmt)) {
> +				__arm_lpae_clear_pte(ptep, &iop->cfg, 1);
> +
>   				/* Also flush any partial walks */
>   				io_pgtable_tlb_flush_walk(iop, iova + i * size, size,
>   							  ARM_LPAE_GRANULE(data));
>   				__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
> -			} else if (!iommu_iotlb_gather_queued(gather)) {
> -				io_pgtable_tlb_add_page(iop, gather, iova + i * size, size);
>   			}
> -
> -			ptep++;
> -			i++;
>   		}
>   
> +		/* Clear the remaining entries */
> +		if (i)
> +			__arm_lpae_clear_pte(ptep, &iop->cfg, i);
> +
> +		if (!gather_queued)
> +			for (j = 0; j < i; j++)
> +				io_pgtable_tlb_add_page(iop, gather, iova + j * size, size);
> +
>   		return i * size;
>   	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
>   		/*
Hi all,

Can you please review the patches and provide feedback?
Thanks,
Ashish Mhetre

