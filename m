Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012053.outbound.protection.outlook.com [52.101.53.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15F2292938;
	Thu, 11 Dec 2025 06:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765435288; cv=fail; b=WMuaJNmhY6jVfiRM8egfx1Zb3zsrChsjm3JftNxjWnJSKqmkwY69sL4noXZ10jMXErUq2t8VgLfZ5JGEgYhv98hpC0tEVj3brye9/pdpMlPMUkJe7EIMUiVvvEscORGKLu6+aH5OosQedJd96KESgXSJn7SDsBz4TINRwQYuUoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765435288; c=relaxed/simple;
	bh=/0dbLhK8TJ7u0LeVKYcqHk0QnbmgdXsvrHQBhMSwQwU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kltk4j4oww9b5VzJrcZI2KLtRYhR4YkcLWofoDMHm99k3C8W3Tm0chuVlYRS4OqMzEI0Qpv/J0uhpzKdx0k46A7QBz1bjTASuT8N55Fo1y/i2ZHZUdTsEz+Hwe9ttt+h+f5IsaDtb8XTUlLIrh/X+F4nUkRwm12jvokHwOarc/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CcafHi2P; arc=fail smtp.client-ip=52.101.53.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CcafHi2P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdGOQWw2XQeH+GAdfpez4OkZQ0Phni9COnGryzjha6Kn1TdpUEsEY1mvl7mlZ4IgXX3138PbZi69eCSbDelMFXx9iyc9a+Y8gzrh2XSMBcDa786bUNGfhn9yUyh81O6uf+nYH4llAAMf9ViO7fU8bhPvBjsSe0uFRK9bjBqgX62fc3b2951YW1SqQB2eko9GD7k419qTWATTKUfo0iYW2v/X+tCrVaQSsPVIkz280gOkSgopgSxfnjN2zSAFUVAJZ4MWbW+0qhph7AouyzAtwiVmTzqd9SqzrygZ19nmnR+0DkwpVpFFkJdDbxXsw6TtPRAnP83VqvHDzGhKMJFReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NBuEsrXqNHtoYOY5kBBWXtPHsB7pDtQ65JBkekI/fk=;
 b=AkpYlwOKNVcDCkzimilS7/hCt1LjNdToTw1LaX3yFO9V9x1ZGRsNwg63uVxfklCdPyAQvdVQFCjptBBHPmmzSnXBVw8dRwlq98cEApv44MoKbJPSKGBCf5IoYw+jGNcWZkngrybkmcbuA6EH1trViRbYZwljQsBoFUIATtFUGSxZq8mei4oVlKTsNebSwdIPFifkSlkDYQvcFtugtUBTeugsgcf7qCOM0rhOQ6mi+7RaDn5zZqEx0khwgC3YbCTZb6WQl+NiOJ+de4l2WWZddMN6TUlMIKY1rCAPgfb4DNLqqDDdNtVOxPsMCI8XKacna7xKXsGdCsvC+9FwMYBSVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NBuEsrXqNHtoYOY5kBBWXtPHsB7pDtQ65JBkekI/fk=;
 b=CcafHi2P5cesdkqBrI5W9akvfoQ4l5y8pL8AU1gIfSOCZeRXw/0Gp5k1uWEq9kHIMbIOtg3GkPvcfZ8QRppsCA4KuDcbTGXxHzXbTep/d1ASKW5s0iXvRehSYANsvM9y8bVhdCllt0AaWi6tVFkx/U5pTdSksFdMT8tApoB44DGn7vXipd3vFMLsiTZz8WoEI6vNR8Efqbg3Cu7qq8Fdr9fA4QkzHZYDx9Eu1kDxwBpozfNMUhDPXm9uL07tYD3/oR0OqUHaBySdQ/+FSUKpc/z5ucbb72XHbIrnFtD9fJqGmY/5E0W9KiTlymh/jV0x4owwioDSyJfNIy8OaergSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Thu, 11 Dec
 2025 06:41:23 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 06:41:23 +0000
Message-ID: <b949c36e-f72c-49be-a243-535c43189d1b@nvidia.com>
Date: Thu, 11 Dec 2025 12:11:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/3] iommu/arm-smmu-v3: Add device-tree support for
 CMDQV driver
To: Nicolin Chen <nicolinc@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, thierry.reding@gmail.com,
 jonathanh@nvidia.com, vdumpa@nvidia.com, jgg@ziepe.ca,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, joro@8bytes.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, kernel test robot <lkp@intel.com>,
 will@kernel.org
References: <20251205065850.3841834-2-amhetre@nvidia.com>
 <202512090331.QAFgb6vQ-lkp@intel.com>
 <2bf7bb25-9a6b-42d5-b095-978f7bb81f35@nvidia.com>
 <e7c69e9c-6af4-468a-88ed-fb8829afb92e@arm.com> <aTpgAU6FjinhclQH@nvidia.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <aTpgAU6FjinhclQH@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0251.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::17) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|CH2PR12MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: ac51bb4d-13bb-42fb-574e-08de38804ce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmtYRUMwQ1VEem56TlVscEUrNkhlbDBtYzlYbWhWWFAzVmQ3alFGS2JiVFJs?=
 =?utf-8?B?Z21SSnhxMlpOeXlNMHl5enVTK1VIRW1QekJMbllDVnhGSXRRRGVpUXZOVEhX?=
 =?utf-8?B?L0dqbGFtN2pyMFpEaFdORllmemJwdFZzSmc0MXFkWk53L3dIVWc5Y2Q0WUVC?=
 =?utf-8?B?S1FpNlFLcHNuYzdhUDREMlRSMkV6cDNUOVhGMDNYdXVrRTdVaU9hTDNUbE1x?=
 =?utf-8?B?SzFsUEZJeWRSTm9pR29QbXJoQjhpc0FJOTRVcTlvb1N1UDJoSHI2Z21HN21k?=
 =?utf-8?B?SkdqanQ5UVJJYWNRMjUxSGFqdUNrd0JsdExSc2hucmt4dVBqMTIzOFpmbEFi?=
 =?utf-8?B?ay9oR3lJVE9zYVVSZXV5M0JZS29uUjVXbGtIT1ZFNkZ6dXBtNk10WnRjMHBw?=
 =?utf-8?B?a3NOQ2YrMHVOWnV2T3JYNHZRdU9nL2o5QUtqR252SHhPSVppWTArdXpXd0Y1?=
 =?utf-8?B?YTh0OVcyTFhDNXFuTmlDUnBqK29LZm41dDZPSU83TVEvT05aUWFZU2xnRHh3?=
 =?utf-8?B?V1l2R0dWcnduN2U0RS9BYVAxNXovZVB0NklBSjQxeFBvS3Vpd0JSNDFyMXR1?=
 =?utf-8?B?bUwrSWR3TTVNVDluNVEvcmY5MjJsWTNQQitUelNXeVgzRVNZSHBWSUNtWEZr?=
 =?utf-8?B?N0ZCSDRQVzBQVmg5b1pCRTdXTjN3eDNPeDhHRVcyRTRrMmRQOVYvTm5kWkFk?=
 =?utf-8?B?YU5VcnJKTm03TDdDaU9QaEt0VUNrVGpnU1Q2N3QxL0JodExHMHFnVzdlZVg0?=
 =?utf-8?B?UE1SVlhyUDdxM01YTEw2d3htWGw2Y1pNd3RQNVhlaFRVOVEvZitIWU1XVjJJ?=
 =?utf-8?B?Y3AzWTNxQUpEa29iZCtPV2o4K2VWL0c3K05oQVQyYjhNUXdqSTJVNklCQUl4?=
 =?utf-8?B?MGQ3Tm1WV0xVZ24rVW5JeXJYcEpDTmdXNmJ4UlQ4Z0hVcjNnTTh5NFRuYktw?=
 =?utf-8?B?UWJuSlJGWE1YSGIraHZjZ0Z5ZmNFOW5KN1YxNndXaTQ3OFZaampvb21nMjZY?=
 =?utf-8?B?dVhZUHpwZWFvZ1kzOGxTTXRKMXdtcXBrMTJIMXpyellWejJvMGhDZmRRdXEr?=
 =?utf-8?B?RVpoTFZwbzMrVzJjYmhoVmtEeWdIdENKOFlyR2crWlcrdXhEUEJqaUpKaVVs?=
 =?utf-8?B?S1dUTFNLY2E4TjBFeG9BYXgyTDRiSVNoamsrd3FGSkJsS1hhNU11T3EwSC9z?=
 =?utf-8?B?eEFGUDBrZXE5T3lzNldFanJTQXZTV2lXWGI4bERVc0dCZ3h6WGVDbnhwK2hK?=
 =?utf-8?B?OXZMRkJuSEcxdHhEZ3l3REhIVnlBVjQrdUNFalNyYnhyYWZjNEVZWE5wcC9I?=
 =?utf-8?B?YUc5aG1sTzEvWG9KaFRwSC96aU9WUU9zOHNhc3l0N1l3ZlBGZmdhUENTRkVK?=
 =?utf-8?B?TFdwSGFib3VpQ2lkWWpYcTA3WWhnNkpQRTIyYjBrRGZOOXJGelJRdC9XemtD?=
 =?utf-8?B?d2hzRXpWRWV1SkJWd0VFUmw4bkFuTzQ2aHczVmlXS0k1cHVNdUgxekQxdUxK?=
 =?utf-8?B?bGtXL0h4OVZhNFFIWWVmbjRTQmVjQTdSZStib0dlRjloZTYveG9WOTNCdHpO?=
 =?utf-8?B?UE1lWWNZUEllTXcwUEtoOXhCWE9jM3JuakpRS1VGWkhmUm82VG5IRzRGaEU3?=
 =?utf-8?B?MFJxR1RmZ1lzYVZ1MDFoRjRuUUloV0IwNk10bmxtalZMMzhrbkpxSkhvTWlN?=
 =?utf-8?B?dkxGdnlQaEVKRlBYS1FrMUFNYXNwTUF4S3dDcTFGWC9uOGRYdTVxWGkwb21t?=
 =?utf-8?B?akJwd1QrbE51YXJObmxWRmRhclU2MlBlZVZvcGo4UkVqcERWclJhN1ZCQWQ0?=
 =?utf-8?B?N3dWUzFKUysrdDl4N2M0ZlZiMFhzV3lOMzN0SVZsZ3NMZGhCa2tXSHUxTUNB?=
 =?utf-8?B?NndnVEtqZmNaVXRHRHRFYUZ4QjBiZFcrcVRJMTQ4djc2VncyUi9reHh6MC9r?=
 =?utf-8?Q?KvtWIF1AlctZGK/vvUEDdxE7Hn21NrkY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWg3bjlCSHRIWi9GYUVrSFJlb3ZSTXR2NnViaEp1L2lmOGxaUXVrb3lIeko4?=
 =?utf-8?B?dWlCaWRmWStpRVJYcVJMQjFuRjd0UklVT3NOSnEzV0ZIaWxBTXVwb0lEWlVC?=
 =?utf-8?B?WkRlMk5taSt5MGprcFpsSHpoOEwxZmloRmVMSEtYdS9ja3k3QXROT29KbHlv?=
 =?utf-8?B?QlZPR0V6TDBQVkd4YmZBNnNCZE1NcDJSNS9NZTBudmtTYUV6TEF4T3hXQjI4?=
 =?utf-8?B?Z1hxTnRxcjhidjlOTi9PRHorRC9xOTMyVTVUN2E1THphdU1jeW1URC9IbE9k?=
 =?utf-8?B?OTByUFFQekZubTJoUkQ5YXMxQnRrYzRxWiszWTFONlJWOEozY29KNVZUTkpG?=
 =?utf-8?B?Z2pQZWh5K3hXUVJ2TFBEUUpCUXFCTThRMDZaeHhmMEprYXVnTzExTG9CNER1?=
 =?utf-8?B?dHZkRWVraFZFZnlySnVaRGtOVHZKR0NzbGlZV1JRd1dCa0ErL0tqNzhWR0dk?=
 =?utf-8?B?VENBVVhzVW5WVWs0UU5mUTkzYlI5aTZSV0JyMjVNY0hGdXF5WWJTdTV0N3pO?=
 =?utf-8?B?d1dFNk56aWh6L0pPQjBINjN5U1NnVHdLQ0dhSjRmMHRMMkhCalk1SlM5YU5K?=
 =?utf-8?B?RURpLzV2aGxMandHb0RaejB6U3VjTW5SdjlCWDQ1SXA0bWRNd1dUYVVyejll?=
 =?utf-8?B?YXpWZDRMcnlVcXdOcGxBTVFrOVV6RlhpSTVucVJ0N1JsSjh5L0ltVFZycHdY?=
 =?utf-8?B?ZjNoTmEyU3hJRUhybW1xME9jVkZBVGhGanh6YzZhNUdtaXdqYVdndzl5akJI?=
 =?utf-8?B?Q05kOTdybjhZM2N5OG1LUWRQSHNlNkpMemdPQVBYWGwwYnMxYlA1UUgzamx4?=
 =?utf-8?B?bXBBZGJQRmJTSnZWVnZYczRReUJZb1QybXRzZEV1RTJSVmo3dUtJWUlCK3hP?=
 =?utf-8?B?YVBZQnFCcWlrWE0remNYS1B4V3d5ZW5PSllFTlY3bC9GdXhndFpqWXVXeThs?=
 =?utf-8?B?aU1KcEdSVjFoVGZmaFJDTjBlbFN1cjRnTWM0SmdoS0tkTlBGQkYxc1pidmtE?=
 =?utf-8?B?OW1MSVBRWFdvRHJ1QXVQZXFNcm5QT0hYS3V1cldpNTB6aTNFc0hDb2ZnTkNt?=
 =?utf-8?B?MEk5Yk55ZXB3UkVLbjlaZ1VPbDFla2RpNEZBOTMyVVFNS0dQZjkxL05pNHdH?=
 =?utf-8?B?c2RGWGE2ME9zUFVmdklRcEFYUkpiQXl1OWk4QW1VQ1ZVN2llSFFmR1l5Nml0?=
 =?utf-8?B?SWFCeHBYTWtYd09tMVNMQjJFbzlDQk5HQTd2YXMzU1VFeGR4THV6V2xlQndq?=
 =?utf-8?B?Rk1SWnBBelVMdVQrZWo4M0plMHBtUkdhN1ZSTzFCeFY1MHdCcTMzOThDd0tI?=
 =?utf-8?B?c3h4bVlUbnVuRFZ4R2hsVXd0TG5zR0dPdml4ZWtCL09xamRrSXU4MDhxNXBy?=
 =?utf-8?B?VnZnTkRQUlI1bGdXS0xVNUd5Wk1UY3dSSnB6V2tIOWJYMzRGdFFqYmJFK2di?=
 =?utf-8?B?cmptbWJwOTJwNk9CK1pqY0FCUTBFcmU2K20zcFZpd1RwOFF6cDlrSUw2Nnlk?=
 =?utf-8?B?QlhhWGYzS3VVL09zSFBhSVpzZENrbFllM3JFN3kwMlNHVFRjNm0zMWJyYzNq?=
 =?utf-8?B?RkQrZmhSRGVJb0VKZ3NpZFRRN3EwQml2anpsRTFpWEd3eDBRV3QxUEhOYnpj?=
 =?utf-8?B?M2QrOS81RHIxQVJyRHR4VitRbndaMTgwYWx4a1prQXViWS91RkN2eTlTWk00?=
 =?utf-8?B?U3ZpYkoya2MwOVhlSjNaQmlPOWtNZG1ack5XVUx4NEdvRjN0aitNbVNRNFNl?=
 =?utf-8?B?cXMydVM4U3BhcDZZQ1FVSUc1SkJQVWJEclhxU1NnK0dHeENLU1R2Qm1Gblg5?=
 =?utf-8?B?RThaZXBFdzNITHpSMllISU1LZWJxRVNNcHRDa011VGFRSFNlTXp6YTQ4SXJn?=
 =?utf-8?B?WVUweUl4VFQ4bFlHQUFUMldtZEVzQnFxTXdzSmVNRUlucFRjYnFjdi9PYjFa?=
 =?utf-8?B?RXZBaUNVQTllRnlpTnhkd1B0YzV3QWpxVWx5MVh5WlFzby9EMmFJN0pmNTJQ?=
 =?utf-8?B?VnFwb3Nud2dOUVJUbURlZGRtYVNPTVV4ZFJHbytjUE9ScjFDNWlFbkZ0QjFy?=
 =?utf-8?B?TXRidG5LTjhHNDN1Z0VHcGVFN1IwWU4zOVNnWnVzbGp1U1E0YkswOFhSOFhT?=
 =?utf-8?Q?vWjEBpzi1IHs8B+PNsQcm4R8Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac51bb4d-13bb-42fb-574e-08de38804ce7
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 06:41:23.3684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+yETfJNrTkPN/wdvuQz5WGrvpmnLs4m/WADvI6W6igp3yMwrgPNNE4e54SqiyIyouAwnlPrrjsYVitY2DAbfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327


On 12/11/2025 11:39 AM, Nicolin Chen wrote:
> On Wed, Dec 10, 2025 at 12:39:49PM +0000, Robin Murphy wrote:
>> On 2025-12-10 5:19 am, Ashish Mhetre wrote:
>> [...]
>>> Hi Robin, Nic,
>>> We removed ACPI dependency in Kconfig but driver still depends
>>> on ACPI for these functions. I will be protecting ACPIspecific
>>> tegra241-cmdqv code under CONFIG_ACPI similar to what is done
>>> in arm-smmu-v3 driver. Is this the correct thing to do or do you
>>> have any other suggestions?
>> Yes, when I commented that "depends on ACPI || OF" was functionally the same
>> as just removing "depends on ACPI", I didn't mean to suggest that wasn't
>> necessarily a genuine dependency still.
>>
>> I guess if you can wrap the ACPI-specific functions in a single #ifdef block
>> that's reasonable, however I do now wonder whether things couldn't be
>> factored out a bit more - if it's a standard DSDT/SSDT namespace device,
>> shouldn't there also be a corresponding platform device created for it,
>> which we could look up instead of delving directly into the _CRS of the ACPI
>> node itself? (not sure off-hand if there's a straightforward inverse of
>> ACPI_COMPANION()...)
> Ah, I did a quick tracer at acpi_create_platform_device(). And I
> do see platform devices being created. So, we could have made it
> ACPI-independent from the beginning, as you expected :)
>
> Ashish, let's attach the following patch in your series:

Ack, thanks Robin and Nic. I'll update my patches on top of Nic's patch
and re-post.

>  From 7b69a638276e66b16b923b0ce1743d3efc85a04c Mon Sep 17 00:00:00 2001
> From: Nicolin Chen <nicolinc@nvidia.com>
> Date: Thu, 11 Dec 2025 05:47:05 +0000
> Subject: [PATCH] iommu/tegra241-cmdqv: Decouple driver from ACPI
>
> A platform device is created by acpi_create_platform_device() per CMDQV's
> adev. That means there is no point in going through _CRS of ACPI.
>
> Replace all the ACPI functions with standard platform functions. And drop
> all ACPI dependencies. This will make the driver compatible with DT also.
>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/arm/Kconfig                     |  1 -
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  2 +-
>   .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 84 +++----------------
>   3 files changed, 13 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/iommu/arm/Kconfig b/drivers/iommu/arm/Kconfig
> index ef42bbe07dbef..5fac08b89deea 100644
> --- a/drivers/iommu/arm/Kconfig
> +++ b/drivers/iommu/arm/Kconfig
> @@ -121,7 +121,6 @@ config ARM_SMMU_V3_KUNIT_TEST
>   
>   config TEGRA241_CMDQV
>   	bool "NVIDIA Tegra241 CMDQ-V extension support for ARM SMMUv3"
> -	depends on ACPI
>   	help
>   	  Support for NVIDIA CMDQ-Virtualization extension for ARM SMMUv3. The
>   	  CMDQ-V extension is similar to v3.3 ECMDQ for multi command queues
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 38028e4a52f7f..0c98be3135c63 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -5280,7 +5280,7 @@ static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
>   	adev = acpi_dev_get_first_match_dev("NVDA200C", uid, -1);
>   	if (adev) {
>   		/* Tegra241 CMDQV driver is responsible for put_device() */
> -		smmu->impl_dev = &adev->dev;
> +		smmu->impl_dev = acpi_get_first_physical_node(adev);
>   		smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
>   		dev_info(smmu->dev, "found companion CMDQV device: %s\n",
>   			 dev_name(smmu->impl_dev));
> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> index 378104cd395e5..1fc03b72beb88 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> @@ -3,17 +3,15 @@
>   
>   #define dev_fmt(fmt) "tegra241_cmdqv: " fmt
>   
> -#include <linux/acpi.h>
>   #include <linux/debugfs.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/interrupt.h>
>   #include <linux/iommu.h>
>   #include <linux/iommufd.h>
>   #include <linux/iopoll.h>
> +#include <linux/platform_device.h>
>   #include <uapi/linux/iommufd.h>
>   
> -#include <acpi/acpixf.h>
> -
>   #include "arm-smmu-v3.h"
>   
>   /* CMDQV register page base and size defines */
> @@ -854,69 +852,6 @@ static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
>   
>   /* Probe Functions */
>   
> -static int tegra241_cmdqv_acpi_is_memory(struct acpi_resource *res, void *data)
> -{
> -	struct resource_win win;
> -
> -	return !acpi_dev_resource_address_space(res, &win);
> -}
> -
> -static int tegra241_cmdqv_acpi_get_irqs(struct acpi_resource *ares, void *data)
> -{
> -	struct resource r;
> -	int *irq = data;
> -
> -	if (*irq <= 0 && acpi_dev_resource_interrupt(ares, 0, &r))
> -		*irq = r.start;
> -	return 1; /* No need to add resource to the list */
> -}
> -
> -static struct resource *
> -tegra241_cmdqv_find_acpi_resource(struct device *dev, int *irq)
> -{
> -	struct acpi_device *adev = to_acpi_device(dev);
> -	struct list_head resource_list;
> -	struct resource_entry *rentry;
> -	struct resource *res = NULL;
> -	int ret;
> -
> -	INIT_LIST_HEAD(&resource_list);
> -	ret = acpi_dev_get_resources(adev, &resource_list,
> -				     tegra241_cmdqv_acpi_is_memory, NULL);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to get memory resource: %d\n", ret);
> -		return NULL;
> -	}
> -
> -	rentry = list_first_entry_or_null(&resource_list,
> -					  struct resource_entry, node);
> -	if (!rentry) {
> -		dev_err(dev, "failed to get memory resource entry\n");
> -		goto free_list;
> -	}
> -
> -	/* Caller must free the res */
> -	res = kzalloc(sizeof(*res), GFP_KERNEL);
> -	if (!res)
> -		goto free_list;
> -
> -	*res = *rentry->res;
> -
> -	acpi_dev_free_resource_list(&resource_list);
> -
> -	INIT_LIST_HEAD(&resource_list);
> -
> -	if (irq)
> -		ret = acpi_dev_get_resources(adev, &resource_list,
> -					     tegra241_cmdqv_acpi_get_irqs, irq);
> -	if (ret < 0 || !irq || *irq <= 0)
> -		dev_warn(dev, "no interrupt. errors will not be reported\n");
> -
> -free_list:
> -	acpi_dev_free_resource_list(&resource_list);
> -	return res;
> -}
> -
>   static int tegra241_cmdqv_init_structures(struct arm_smmu_device *smmu)
>   {
>   	struct tegra241_cmdqv *cmdqv =
> @@ -1042,18 +977,23 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
>   
>   struct arm_smmu_device *tegra241_cmdqv_probe(struct arm_smmu_device *smmu)
>   {
> +	struct platform_device *pdev = to_platform_device(smmu->impl_dev);
>   	struct arm_smmu_device *new_smmu;
> -	struct resource *res = NULL;
> +	struct resource *res;
>   	int irq;
>   
> -	if (!smmu->dev->of_node)
> -		res = tegra241_cmdqv_find_acpi_resource(smmu->impl_dev, &irq);
> -	if (!res)
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "no memory resource found for CMDQV\n");
>   		goto out_fallback;
> +	}
>   
> -	new_smmu = __tegra241_cmdqv_probe(smmu, res, irq);
> -	kfree(res);
> +	irq = platform_get_irq_optional(pdev, 0);
> +	if (irq <= 0)
> +		dev_warn(&pdev->dev,
> +			 "no interrupt. errors will not be reported\n");
>   
> +	new_smmu = __tegra241_cmdqv_probe(smmu, res, irq);
>   	if (new_smmu)
>   		return new_smmu;
>   
