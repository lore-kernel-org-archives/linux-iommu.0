Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959B3139CFE
	for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 04:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723436625; cv=fail; b=PCtJoC+V6VxAaeCpCyXV60KtW9KQaqMffiwaZndrLCBr5m2nZat86zLwZX7xtE8fBPaLkHoCLsjffl5iTkDng0SldsBVsL/nGB5mWyf8Cq+QDhkeryKGMNEPbhS6U+Tzc+c/CTf5s3VI4ZErSQU3Jg/6ZlfKzZsxGWJ34k7VnkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723436625; c=relaxed/simple;
	bh=0vKOIx+/LH457okytopGQguUZEh5lYVBZK7ig4dbXHY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Itqp17WhNILKk3PaFGnvQqrukS1aH52kCE1k3Xa6ziXnJsFPc7xc5Y5EMjgZMLy9lKdzVVPEglTep9vaF9VghybMB7VgcTzIuOj6CGbv+jCbFvNsUl14C66fXFzSEzLqjMVzr8ZCDz50Rcrpmto8wPJIdCT71NOqVZ88TMumcfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jMF7dyN+; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jMF7dyN+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdlTQcaRwSVVoLZRXschvSWec3giXdnS9ZSnqo+lq1Oe6UROlOYNec39ICpoFnCyDbWv0CMLtkTN9M6UmGbYb/15BUc536ToOCSM89gxLOOlUtKwr7Am5GWJrYw0KGkh9HHg70R/fKbx81lzffwkDnDyan1yO+MocyGyd2C0pFEv0YH9GsI52zAbuT6Rqq/BifVbpBZwq0CwNzDaM70tHKAMmaSZZvrCPq/093YCBMHA91kUOPaawVynYMzhx5vp2gDZiFzkNP6K74G0xH4PGeRIaSlwQ3xL4ADia5XXPdu0invkcvJFrZK6w8G1MzwR2kSlwyPyy7yN7nGTbOSkJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bzt+NfQ8ejNxUcFIO21AQAq7JJPlAnq1NcmxdYMxNo4=;
 b=QEG058OCjqbaNQEXBZ/KxEZW8PJFLnrN1+Fm3hbs6KZhwRX1VLHv2I0mgjqN/oVC8iW/2myH/QvOkq5q32KQko/LM49xILiQAEgbM71W8Sz0tW8MyzOYVNIgGMpNZUz7aySXs7uqY03lYvd2mLSqIGyEX6BZIUeLB5f3ehQqo5imAEriTI4qdNOPK3+TabFyTEROijZ6GaoSQ7v8LJpCnRA8wJ6TvHwj7dsVckKqY4A1tASoetFdqtxr9fymxZO6GU4w7/qCwN3vphTwSPjd4bLazoy0BLNqIUzSw8GuPMw40Za4cMy8Hn7sA9HUJ1gjcx2+/e2ZQBEwF2hw/EsFyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bzt+NfQ8ejNxUcFIO21AQAq7JJPlAnq1NcmxdYMxNo4=;
 b=jMF7dyN+a/4oxpq0bv5F24oCHL22rk1M2stFKilT8hzsEwSpJOhaCjiBXfPRIe1JyWooUv3Qk6JnTasW6G/JTOswj97wcj0+cUP7oHBK8XYhLfmmGQHjfwT49hxoCysN9Apb4ReLxBY2p4t77i5SWlCTNk76OJgMJVRO99oEbR4f3Gcy1qirxEDDizi+uXerG1VVIZf+FusSsFCy+OV7HQWUzU5zw2PvwzF7AGyH4ZLprnjTozkVRs2QYncpWYR00m81VPNXm6euwxv0PBLNZstEgIKpJwEOZvgbyEvJB5CADotB+EhvszOoDQbH2ZPcKOEDo9bPzzRcdWNZsQKp2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL3PR12MB9052.namprd12.prod.outlook.com (2603:10b6:208:3bb::14)
 by DS0PR12MB6533.namprd12.prod.outlook.com (2603:10b6:8:c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 04:23:38 +0000
Received: from BL3PR12MB9052.namprd12.prod.outlook.com
 ([fe80::d7e1:595e:d907:90d3]) by BL3PR12MB9052.namprd12.prod.outlook.com
 ([fe80::d7e1:595e:d907:90d3%5]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 04:23:38 +0000
Message-ID: <2696ea8f-1b36-4c14-8ac0-70803de2680c@nvidia.com>
Date: Mon, 12 Aug 2024 09:53:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] iommu/io-pgtable-arm: Optimise non-coherent unmap
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20240806105135.218089-1-amhetre@nvidia.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <20240806105135.218089-1-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::17) To BL3PR12MB9052.namprd12.prod.outlook.com
 (2603:10b6:208:3bb::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9052:EE_|DS0PR12MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: a143ad09-f665-4983-ca13-08dcba868a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFk0SERYVmVYMDEyT1RsQkMvVnJ2bzlXRUlVUVgvR1RrcEQzbVFRZE5jYnQ5?=
 =?utf-8?B?VGdKRThYL0VrNGtFTDVhWW43YnBWMzBucTF2anZEUlNtWFJ5Mk1FN2ZlTVNN?=
 =?utf-8?B?eWYwQUVXNjU0VEhBYjltREp2aE9OazJINUVENXptWkpNakdIbjBQUDFFOTNa?=
 =?utf-8?B?MTdLZ3dIYzNYK0dVdzlFWmJvK3dLc0lGZUdwR1N0Z2dYVmhuRnZidjZSMHF0?=
 =?utf-8?B?ZEt1OFFDbG5rSzhINXNESTN4OWZzYmJISStXZWk4V1BUbU41dGI1c3o2aGx0?=
 =?utf-8?B?RU1MUlBGdENWb0NNemRBN3dqalVHb2tlMll2aTFpYXFoTzJpclBFVE9MdjFX?=
 =?utf-8?B?aDBZRXpNU25LR2U0aE9LaDI3MzdzNWVMSDkrQ21ucHdBS0FpS2Ztb0hDV2cw?=
 =?utf-8?B?WEZUVU90eFBPS1RtS0pXS3NWL21tbU9tM1ZLZ2h5R2JLelJocEszMzd1MFkw?=
 =?utf-8?B?TVh2cWQ3RU5Md1YzNU5PanJUMnZuQktqN0ttaDNTdHJrVkFNRVA4bGxYaDZY?=
 =?utf-8?B?SERUQWJNcmZQeGxZbzlqUGpXTjB1azJ4dFlwWW1KNENobnZBbmJxd3p5K28w?=
 =?utf-8?B?L3d0NGp0M1Z3MmRZVCtsMWdXaFQ2bUlYeDZ4ekRDQ3BySis1Vjg2MVhBaHQ2?=
 =?utf-8?B?V3pJbWx3VmQrVjN0VDBHZHFxQ3NvZVVpYXVpakZoeUNWSC91dk9SaTlOdXZN?=
 =?utf-8?B?T2M5T2JwOUtwNVlPaVZUTVdPK2pwMGZuNTVHd0R1b1ZLZWRCN2h6UkdybWll?=
 =?utf-8?B?V3FjS1dEenV0QXhyZXRCcStIN2lBT2tzcHNkc0h3REtHRG81eDMzdzZnYWNm?=
 =?utf-8?B?WmpiNk14VTkvY3BBRVgxYTJpUEJraFlxWjM0T0RpSUZqUEUwSjVmVFBsMWR1?=
 =?utf-8?B?YndLMkU1elJJUEtWcWFscXZxUXJpQjJPekxxdHhHS2NYUDRGeXNlSkJuWDZL?=
 =?utf-8?B?cEVtcVZxdlNKaDlxK1Y2NjJ1R2VMV0taWmM0VkFGbmhYM3JBQnl2NmlZY3dk?=
 =?utf-8?B?V2g5THRwWjZucFNjeWwwQ3BLU29sSlgwakN6MzRMLzlwRXVHcnB2dmdpeDVw?=
 =?utf-8?B?TkdXRk1UUDNVdzVaamNiZFh4ZXNHb3hOTDF6YUJuaUFRL2Rsb016LzZWMXZ1?=
 =?utf-8?B?eFVIMS9Tdi96ekFkQ3RncVJRZDFFRDQweVVjYjkyN3dXTUpxSWdETkJlMGhs?=
 =?utf-8?B?TkRES25uUU10WVhZaXdJYTdlS0dyTm55V1lyRW9vZnpRUFI1WGpMc2ZocjR1?=
 =?utf-8?B?bnkzN0djSUo4OVlWNE1BN1F0ai9MZVIyWmFYTXZ6ZVE2WC9TUDNuZlFaNER6?=
 =?utf-8?B?a1MvUW1wWDNaY2ZBeUFTYlU2S3hGMVpreldJa0VwL3ZNaVByQm90ZzRTaWdZ?=
 =?utf-8?B?YzFSdWVmNHFSblN3Z04xdkhvN1NTd1NzTzVhSTZoZDRxOXB3cnVqVDVxM1A0?=
 =?utf-8?B?cEJrR0k3RlVpWm5IcG9ZQ3FhdmNTKzdkcUZseHViclZhbkhNaWFwRWQycEVh?=
 =?utf-8?B?Wm02TWplMGFJakVjWXMrR3pjalBRM3NFNmYvdGlNcjRQK2o5Wlo4T2VhVlY1?=
 =?utf-8?B?aGhCMXorckpMNEYvOXBoaTJjalIwNGNJdHJaRE9DRHUxSHlsRE5OcmprMzJx?=
 =?utf-8?B?TGlWWjNZcWptVC9ZRDNoN0JUSmpGYVpjVlFCUzczUzJvQ1BaYlMzdGxYbk1W?=
 =?utf-8?B?ZEFMdHpIMldJRzMwaHpmWlZJWXJ2SmtzZXl6WDV3djZOWHJKTHNYVFROYk1s?=
 =?utf-8?B?NTNNNzJxZFlvT2ZsMWFiMFpSaHQvMkV4UzhSVHFBajBIbzZBMUNiRTFPOW92?=
 =?utf-8?B?YXBnQ0kxb1UrR0daZmJUQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9052.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SG0yNzY2Nm5PQzNld0FSVjQvR1lSTmtZcDYwZFE1djVUMkdWT0FNUTdVcThD?=
 =?utf-8?B?eWdDdXB4VnNlak1JbDBwWXpWNzZNQkEzaFFwckVQUHJjZjNpTzNPWFB0Y0Zq?=
 =?utf-8?B?THRvcHg1Y25HVFMyZGJ1SWY4ZUNsZjI1Z0gyaWlBUjF1c0pzRlE1eHpPU2RT?=
 =?utf-8?B?elV5OUZaVEYrTFhhYW9FaEV5bjBuVnZ4Z2QrVDhVbjhDS2VzKzRYam9jZnV4?=
 =?utf-8?B?ZTdCK3lhblRtV3ptWW9xci8rOXY0QWVHWFBwbTk1L3YvOHVPR2ZxeENFK3U2?=
 =?utf-8?B?RmNZRGFtWHpnTW1jYW1hNWpBdEhVdzJaV056MmJucUhlbmhJSWFWOFhuYUZ2?=
 =?utf-8?B?TnM1NzNWMmNsdTJkY0NkUWlUMjQxSWJvbDdtZUMyNFFCZGxUeW00QlNuOVRo?=
 =?utf-8?B?WkhMNDViaUZEZ3RDWjZBTnF4V0NINnhMSHJ1WUJoQXhwdjdkdDR1cnFzQzc0?=
 =?utf-8?B?VGNWNnlPdTFXQzJMekdMYWxBRjkvOVorbmVmV0xTbE1UQjFwUTBlQS82ZUVT?=
 =?utf-8?B?VktocXRpOWVZQ29WNDAxTVZXY3J1ZU1tQmNzTVNYN0FlSDVvMkFpOXBxT04z?=
 =?utf-8?B?MnRHWkQxMVR0L2VlTmoxaTlLdS90Vmx0U0crZWtFR2FwOVZvZDNGbFZJTSt4?=
 =?utf-8?B?dmo0NndRNHFLVlpvQkFRRjB4WC9tTllZWE1HOFBndEFQSUM5TmRMd1NGTnlS?=
 =?utf-8?B?Q2R2VXViMTh4ZE5TWHB0OU9acCt2WHBzTUh2eDdNODhWSlY0VWEyUWU5bkJY?=
 =?utf-8?B?eVNJSnJHWXpsdkljYllTeHJqZnk3Q0I3aUN3VDRsMDA3VHlZT3duSHlqQWJL?=
 =?utf-8?B?Ykd2M01CN1dYV1B2QTczS2pNZFlaV1dUOVNLWW5lWEpsbVBuRTZlWDZnZjZR?=
 =?utf-8?B?OUkvMFBBMW03ME9SdDI3VHc4Z1AwWmJCUTFjRnUxRTZuUlBqNTBaeTFkNlZ6?=
 =?utf-8?B?ZWwrQkRVbVNHb1NjZzU4SDMvUFRabllpdEQzQ2pydVFXSHNFWDFoSDdERkRw?=
 =?utf-8?B?ZHlmd1RWRDE4OEVSUGZ3NXFsaWFocmJMTERZV0wvbGhCZWlmWE1VcVhNUFp5?=
 =?utf-8?B?dVFMRFFqcTdjeldlV2lqVEtXeS9YS1hGRWxCT3pIS3htQ2VtUGJBRi9PbzM1?=
 =?utf-8?B?VEYyZm1mT2hrempXRHdjeUNITCtXUDZYZXR5Nm94aXRMRktKc09reWwvNVRn?=
 =?utf-8?B?Smo3Y0xsN1dvYktaSjJmdkZQcmVnU3ZFL09MS0paQlNFYW1hWlN1WDhRMHVy?=
 =?utf-8?B?S2RjekRrV2w2cjFTdTlvd3doOC9TWUdjb3N4Y0FQTDVmNzdwL0VsMU5uV0pm?=
 =?utf-8?B?SXlLdUNXRDVjTGNwT3dINnNmc3VUdW1VSTB2NXp0bVlDRUJUY3NTajhJUDFX?=
 =?utf-8?B?TzM3OWVPNjhXVkh2MDgramlaWlp5S200YXdLcGw1QWZURFJmZjJvREJhZmtv?=
 =?utf-8?B?aUJhanBxS0x6UjJDREk3U05EY05JSmVqZERFSlRrWmViMzExYTRPQ1VjY0NB?=
 =?utf-8?B?ck1SUFVjbmljem43LzJDOXB2VHk0N0FDTlJVRUhjSm51NGcxdjJtUVJJRW12?=
 =?utf-8?B?QUpleXZXZlVwRmcxSFFoNnM2Z0t3b205RmM2NnlKdGNlL0xyYms5d25zb2VB?=
 =?utf-8?B?THVheTgwTURpVWJMMlYrdVVOSFNwMUVDUmV6K1AzVUMyWENwY1gvM0FIaGRj?=
 =?utf-8?B?dXZDS29UdlZWNWVLb3A5QXZ0dm5aeFI5N0gxYUUvdUorb2YycStjRnNiSm9n?=
 =?utf-8?B?c2NtLzhrUGhsbDFWbGdCdlpET2NUaEQ5YTBYWU5ObmkrS2tYaWN5RU5ZejNp?=
 =?utf-8?B?eUdYTXBkQUFGWDg5Wk0wdnF2VDR0SUd4d1lySGlSVlBFakgveTZIVStlbTVM?=
 =?utf-8?B?MWQyc3M5d0tCM0N5eDZZN1FULzU2NHZqNGFMMTkxS1JjaWZSc3lOdmNkMmhl?=
 =?utf-8?B?ZFRxekNCNmZldHk5bDdRcnZtQmpPYVFvY0ovV1VLQmJmQ21aT01VaWhrWmpH?=
 =?utf-8?B?bEVtMnhjSmVSTHNaT1FRNkZQWTVoS0FyNEUyazNidUJueWVRQzAxUDA0S3Ja?=
 =?utf-8?B?bmJSR1Q4VzFtZXZWVlc1ZXRBWlBSWlVVREZTQkU2UjBiMVRBVEU5VTZaWG1G?=
 =?utf-8?Q?lY7jZo41bTPzS+4fHgUi67MLl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a143ad09-f665-4983-ca13-08dcba868a04
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 04:23:38.6485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RMGUyyLpMzoIOAN0JUzXnZXPNZAVOzonhOoz3j7Gkc8FC7ptUZZsjF/3c/R+3mOFzzpS9qmGad7kkkeyW6pRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6533


On 8/6/2024 4:21 PM, Ashish Mhetre wrote:
> The current __arm_lpae_unmap() function calls dma_sync() on individual
> PTEs after clearing them. Overall unmap performance can be improved by
> around 25% for large buffer sizes by combining the syncs for adjacent
> leaf entries.
> Optimize the unmap time by clearing all the leaf entries and issuing a
> single dma_sync() for them.
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
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
> Changes in V2:
> - Updated the commit message to be imperative.
> - Fixed ptep at incorrect index getting cleared for non-leaf entries.
>
> Changes in V3:
> - Used loop-local variables and removed redundant function variables.
> - Added check for zero-sized dma_sync in __arm_lpae_clear_pte().
> - Merged both patches into this single patch by adding check for a
>    NULL gather in __arm_lpae_unmap() itself.
>
> Changes in V4:
> - Updated the subject in commit message to correctly reflect the changes
>    made in this patch.
> ---
>   drivers/iommu/io-pgtable-arm.c | 31 +++++++++++++++++--------------
>   1 file changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index f5d9fd1f45bf..6fecf3d9fe67 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -274,13 +274,13 @@ static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
>   				   sizeof(*ptep) * num_entries, DMA_TO_DEVICE);
>   }
>   
> -static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg)
> +static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg, int num_entries)
>   {
> +	for (int i = 0; i < num_entries; i++)
> +		ptep[i] = 0;
>   
> -	*ptep = 0;
> -
> -	if (!cfg->coherent_walk)
> -		__arm_lpae_sync_pte(ptep, 1, cfg);
> +	if (!cfg->coherent_walk && num_entries)
> +		__arm_lpae_sync_pte(ptep, num_entries, cfg);
>   }
>   
>   static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
> @@ -654,26 +654,29 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>   		max_entries = ARM_LPAE_PTES_PER_TABLE(data) - unmap_idx_start;
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
> +				__arm_lpae_clear_pte(&ptep[i], &iop->cfg, 1);
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
> +		__arm_lpae_clear_pte(ptep, &iop->cfg, i);
> +
> +		if (gather && !iommu_iotlb_gather_queued(gather))
> +			for (int j = 0; j < i; j++)
> +				io_pgtable_tlb_add_page(iop, gather, iova + j * size, size);
> +
>   		return i * size;
>   	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
>   		/*

Hi all,

Can you please review this patch and provide feedback?

Thanks,
Ashish Mhetre

