Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794486717;
	b=Rfsom+NvWAu+ujfvkhv+2eGEEwddszM/jhIxYAm9DCel51eUxJql1F+XyT6UIYBKn1HA
	 d1XW53z/KaLrxyY+0msv4KaYy/YVM+1OOkAwgizp6d2eUC71l4oyGLeJHjFS9x5Oyr5fD
	 kcZFLl4kxww6LiVfC6lSKsCGg3v9JGuFW8JdMz8tmnyFiYl1C9hpK1aE04ahue2N/Vo91
	 EAQtWJSTPOE267vcF+hB14jaFPNr6eF2zLGPbVgcRrq2QO3BI5OT3VVbCFnj3KhBNXqdO
	 EtEVN+rziF+MrCPP6rpWg9rY5ev/QgiGCC3aDLUxqJXj2q1nmlcImyx9qu9RKpwVKCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486717;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=40hcbsfRsTCTynBSPAVyeWwGMEqKZqxIDXFdMQu7dxM=;
	b=LoBj3n7LZndWm9q3y3/18rtllcygX1xeOYMdIKTMHUDCxYHycbuT358CipIyIGkXRNO8
	 K3HFYl3VqtYMo6F146RTk9B62M1oMUGe0sPKUDFwX9dToISBKrTZDYn1uko0GKY3Es0oN
	 L3AYoTsT//mkFWZaeV39jZtQGxjEt2GvVmZhZ8UDHrYEOgdsgffFSMgJYJj0tWnuwLlZs
	 LmbLcsXIN0WK9/BAQhB4ynj1k8/uwmHNgslFO9xn8pBNBZTNHEQzN1hLqbH9aQrHeZRdJ
	 0UoLrkzKiKCKYB+DBJCcUSEgIP0tlF8muaktG3ckJkiASaBkAyfcfhU+iy7ZMnNi0Vg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WHTOPu6m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.64
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013064.outbound.protection.outlook.com [40.93.201.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A70F606A88F
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 12:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A70F606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WHTOPu6m
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAMmdNwro4yPYyw8Itf9jBMV91PcwTMCskdtfqcaUbyTtTYdMAcTgO9b8C4ohIQHgz5rom+UXdgNQ8exrW0+42NCuzcNFaZF1D4zMcAy+oc86dma5bRcoIbYONCU+VArNG5FjnSOe3sHBe6vOKG8D+d34bl0JDl6Gqf1AjHeR9amNk9EMWmC80xLNoSGoLl9ngX/DJfjQPfh7IMmtSHtsKK3G5UgNMQRcAIyJOtmQJkh0T3Lb6PyLv4dqb4InbPjXefXr0Ia/K2hZ2mWrYsslfDlF/y59DtmqhZ1XN/O88p0dwo+uQr4zhL/me2SA4jLJkMLWs/pPN28RqXvMGA8pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40hcbsfRsTCTynBSPAVyeWwGMEqKZqxIDXFdMQu7dxM=;
 b=qLPArlONBeP7kfZz0T27fQNJSz7YbIwk2Tzu+sid9jj5cGxv7p7VsI+ixhEc2dpUcqyydLqs5l3Vqs0HB18Ilm7Cq1TpTYly5YQIAJ/LCimdeqOCPdKJ7en9pH1jW7dPeleWvWbuKZ5e9WDMBpEGgdauutZYbB4xOvhIcx1cVm9deHEvlxd0PQywrMp4cTqcZfyIPJ3i410NR1sw9cgYfxvttyGv9rA2sW1lZJ+byqrZpBVb9bjsrbGsPrKAFXLz2MhvfBl4BR6j2oSXCCKWmTYEUk9xRbBaoySWOXwCBVC+6vL429teoXz3yiTWmX7yQAfoqui3IYE50mKFTQ00rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40hcbsfRsTCTynBSPAVyeWwGMEqKZqxIDXFdMQu7dxM=;
 b=WHTOPu6mAxuY/49CftteKxe528lFDIHtCyTBrUQnwLg3aNdO3w9zlbr9pT66CN1/iXyW/qj1zzhmBu/vDEpUUnvS3TkqluSvmC+Um3SYHvu7I8/ge+eodjnZPTz3vfcX+UK4wTcGGrX4RP2Ads46TpqnBe84WaR9SrP8tiTADyjypidnc16Q9BfO0jPkB7c2MxRPB9PTf0oqK0wUdbfnVIFUlWHaya2+ns4Zk//YmekqxQGX5XQAWFlJPfZjl9/IxEvbrcGm9lyedvTIlDirZwWGzq5fE1ljT3BaXgeNc3FJ2QlHeA40r3iryPj7yeVXC8DlhZrDzODyU413wgmL4Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA4PR12MB932075.namprd12.prod.outlook.com
 (2603:10b6:207:12d::15) by DS7PR12MB9527.namprd12.prod.outlook.com
 (2603:10b6:8:251::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Thu, 12 Nov
 2026 12:31:52 +0000
Received: from IA4PR12MB932075.namprd12.prod.outlook.com
 ([fe80::5a6f:1f74:6ccb:cf2f]) by IA4PR12MB932075.namprd12.prod.outlook.com
 ([fe80::5a6f:1f74:6ccb:cf2f%5]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 12:31:52 +0000
Message-ID: <5905b160-85f6-4967-8da7-0ab36d484654@nvidia.com>
Date: Thu, 12 Nov 2026 14:31:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] eth: mlx5: use dma_alloc_coherent_node()
To: Jakub Kicinski <kuba@kernel.org>, robin.murphy@arm.com,
 m.szyprowski@samsung.com
Cc: netdev@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 will@kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20261106184433.761422-1-kuba@kernel.org>
 <20261106184433.761422-11-kuba@kernel.org>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20261106184433.761422-11-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::18) To IA4PR12MB932075.namprd12.prod.outlook.com
 (2603:10b6:207:12d::15)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR12MB932075:EE_|DS7PR12MB9527:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f6ad2dd-0485-4a7a-2f0b-08df40b8edf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hVvccDucPm72qwzWUjcBax5PIV2tS2FMdenFm1PH5SB59wF3XFf2pPPA9DUBeuVQC+c/nodbN/Gr47CdPKZv/5lMjpfHYS6lPMp4B5eYNRIVOOOV8dy/eArJRG9V5j+fzTtROuP/Dhw0SAT6MFYFEsZ96/UtJ3L1Ybo0zhilt8xnqMTFkJqefIdqop2uIcpFf1WvNd/JIFJ2QM4KEoiqg9JcLhPnEm7R65tycRi/IoixaRR0IWocw9q6ghR9whyHoerjQud2lkX4cYt2C+jYgJo1YV39+JH3mf1CC75z8wPmEL0wBpoIQbvgOywIXGXRkT7s/mM32x6OD6h2fsfRdSGB2lPNZgoDmRDdVKDspRSx0l5PJTC3SWDTZJG+r85hTGhIuOzzClPM5DV0k6kaWO2Wdpj5KdDlYjkcUjmCylWIkN7G9quyaWcXu82VxxhnUQbXj7Jk4pBouxLKNphXcvvCmx22koCHGDXPqTV1OWggnJnk2pf2e9hlbTdVvhz9tQ69PGJlFZ6sjOL/BDJubUezDy4vAk8aSG3nrpINkLFZIL6WJVmCp8CoyS2wqVQv4i0uZ2l33jw+XYg6tucjyqOa3zpIzh3dMZnyKwGYyGfzIYjNK78u+ijoS40AuBr105MzxUdXuRvHbvClCsouz0USLU2D3w4RDKAxNm3j6NY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR12MB932075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWV3TTBLbStjVnpYQkpZd1VtTHZ0UDVxdEZLeUcxcnYwT0ZWSDVEcGJ3eEFn?=
 =?utf-8?B?MDNTSWRjeEJOMjl2TVg2Tlp0N2FGekQrNTNWbHV6TTdrNUFEZnRYT09peUYw?=
 =?utf-8?B?a0lmaHBBajljcHA3RVNFNkVOUUVSZGlaWGttZWtDdWxtQVhtbU9sZjEzTVB2?=
 =?utf-8?B?c1gwTGF5bklCMjlmaCt5UjRLUEowazl6UkJrcE1adHdDbWE3K0loc0ZrZU9W?=
 =?utf-8?B?bTZtNjV0T3VxTUQ5UUpXS0Y5d2MzWVFsTlBWUlhYdTAyMUZzYk4rOHRBSmU3?=
 =?utf-8?B?dVdrdnZFRVRPNmN1S2dnU09kTnpiT3dzTHh3NVdOdk1SR1I5dUVHOURQcFZl?=
 =?utf-8?B?K2VOclNYMGpGVTM4ZG83M0FVYjZhTFJCRW54aXNleUE2K0lqeCt6RHhPNnox?=
 =?utf-8?B?Ym1RREtFZVBWczJJMkFvMDdnTGtodjAzdUg4d0dTWS90ZytQZ0JSN1g0T0Jy?=
 =?utf-8?B?MlJySWVxOGE4NDI1cDg2NTJqaHYya3NsOGZ0Yy84eDlFSEI0SEN2NldRUGJi?=
 =?utf-8?B?R1FVTjRpcS9nWHN6M2pSUXN6UmcvdHVMMmc0dldYNy9jMG13LzRWdklmL2tt?=
 =?utf-8?B?L0JIbEpoKzdFcG84R0gyOExSa3Q4c1A5TFkvY1psNkwySVpXTENoMjkyOEVk?=
 =?utf-8?B?YWRmcHFYTEtlcmdwdUxUWFliVDlJQ2NMTzdtZHkvQndHUUd0Sldia0pUeHNv?=
 =?utf-8?B?UjVMdFdCQmtSVkhsa1gxZ3Z4UFlER2dmOERiZTFHS1c1TktlcjZ5d1pJb0xY?=
 =?utf-8?B?M0pQWnR3NlNqanp6djNmN3dnOTl0ODZGUnJNZmVZRFV0QWQ2K0l4ZkczdnFi?=
 =?utf-8?B?bkNCcnA2dCthZTRaUGliRWEzWEMvMUd2RnE1UG1CakFHN0F6RG00c2tjcVdh?=
 =?utf-8?B?KzlCOFl5QWxReW5JSlJTdjhpanArUy92VTBHT0czWlF0U2JiTGxVY0p2aURx?=
 =?utf-8?B?UmEvT3VycnFEeit6a011WUcxK2ZyZzBUOUE2TEFidTZ1TmM0KzBRbkNNcmZS?=
 =?utf-8?B?UHJ5V0pucjArTllKWHlPVHZ6T0lReVVneTB5VWxxYzQyY0l4MHh4d3NpUTVE?=
 =?utf-8?B?RDhnWmRJM0ZjVUUzOVNPRHVSaFNzSDNqbUp0M3VGV2l3TjFLUmVDQjZOT3NT?=
 =?utf-8?B?TkpuNDJ6NHdZeTQvQnIrQjNrVTBndVZNeDV2L08zRml1N3lSUjJtTVVqSWho?=
 =?utf-8?B?TkVST3UzMlkybXczRTkvZUh2Q1UrRTZoNWp4QlhNK3pvZ0FxanRoN0xnUmhZ?=
 =?utf-8?B?T01CM2F0Ty9QdlMreWpacVo0cS9sOW9YeEQwK2h2RTJWcks3bVpJWUE2YW54?=
 =?utf-8?B?Nk1COXdNT0Z3dXliVElIK1JTc2RMVUpxTFpRUWxFbEFyd2Q1WW0xNXpvajZS?=
 =?utf-8?B?ZVpYVlJzRzc5R1RSYld5UG5ZNnQ2K1lOd2poNmN3c2NUL0oySmZmdmNsREVW?=
 =?utf-8?B?MklKZ0l4RDN6b0cxc2hkSm9JZXJoMHRFRWVhWHByMENyUEZUait0WWx2dmdq?=
 =?utf-8?B?bm0vMFVxaHVTZE94bnQ2bnF1VE1VbVFLTzF4NjFJSjhQVzdudFB0WlVGdHNR?=
 =?utf-8?B?aVBYOVp6TEhRNnFBdVhBQlNWQ0ZJVFFWalliQzNBam1zbTg1dUdyR2o2QmVN?=
 =?utf-8?B?c1pUYWpoSk5KbHNmQWpJUWg1WEEzTHB3MnBnTnlrNlVhdFN5aGNyZ1hENHhT?=
 =?utf-8?B?ZHFkeEZ2UVlCZDFUK0FpSzYyWlhKKzMwSUozWXY5ZW1paDBaS09VRFdNQUpN?=
 =?utf-8?B?UGFqbUtqN001cUJKbXphaVV0TUcwQkY5VmpTbnBVZDE1M25kc1VBS0RWVk9L?=
 =?utf-8?B?di9FWC9FWWdLdDkzMEZBalBGYkFTZXRGWmNGVHBVTS9ub3dPTWZ3ZDN1cGVF?=
 =?utf-8?B?VlYwV1VadGxNZHl6MFR0LysvcVREVmU3cVA1QkhvVFFUM2VEZFE1ckZFOHF4?=
 =?utf-8?B?RUZyTnBHaDR1UXZXcWVWd0NJZ0pob1I1dnNITnZEeThSVTBkWk93b1VYMlpO?=
 =?utf-8?B?NU8wWndZMC9QQXlLSHFLQncvRmwzSC9PTnRlLysrbzlINkZCYnhWb2dEY2Ji?=
 =?utf-8?B?VEkwTjhCRGNTbkpSQld2OVpSUGd2WDNmSDVuQlk4NHROdG11NGMxWjJMMmxC?=
 =?utf-8?B?N2VTY3BjUFJ2WmhZOVBzaFNFKzZQVExzZGM1bTNoSElOdzVxYkd5SWVKeFNF?=
 =?utf-8?B?K3J3dmFUSml1SG8xcUxNdjIrazU1WTl1a202UVIwY0FWK3gvcXB4UFRLVGlR?=
 =?utf-8?B?d09EZ3VQZHg2VDJGb3pBUWY3YXBNTllXY2l0WDc4aVBBK0lHTCs2eW5ndjZF?=
 =?utf-8?B?SG1qVXpVcE93R0NkK1RINjJMVHRnRmxFeUZVYTFWckJkK21kcndKQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6ad2dd-0485-4a7a-2f0b-08df40b8edf5
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB932075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 12:31:52.0899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1L/NZSQB2IdE22KAU+d64cQgi2YFFhRd2CmqXI6i3cYcU47OihqZ6ExRPKbAnDJ3YiaPjmHzISwRBWDwzLHuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9527



On 06/11/2026 20:44, Jakub Kicinski wrote:
> Use dma_alloc_coherent_node() to allocate the DMA pool pages on the
> pool's node, instead of temporarily changing the node of the device.
> alloc_mutex only serialized those temporary changes, remove it.
> 
> Reviewed-by: Björn Töpel <bjorn@kernel.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Tariq Toukan <tariqt@nvidia.com>

