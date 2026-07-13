Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5CA246781
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783943148; cv=fail; b=tC4JpucrcnRS3HDgD5S2RRgI9xAzWlf7sSOpyteNXsGbyZE+8dJNfrrUeFKmjDPAwGIW0TssRQKfaxrrF7Ct90Ipa6IALRvSXwAesygegcs3ztPgYS+xWJPdpIKGMiQ0f1r1LdJ4+9i9JgB0sMOM9xFm/6i77eJqNO/rS3Dyqco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783943148; c=relaxed/simple;
	bh=5p8f96g1V3G84U93b1/Dt72BwgUBiIAczgYfpBo5cUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rHSl0gS8cK3nvW0Q8416+H0fuF16Xsetg9We1o9f1K05CO07AjGVZa9MYmyOHrNcamoWlFdn4OnDGnjAPtWmt5VIUSvCMP5GLAg2P1y6Q0mJQeC6hS5o/Js4AVzKflRbI3OAV7NQPmfIR1Kaa9iU3KVQ8VzK5ncrtnA2W4ydQC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d5Vh4GoO; arc=fail smtp.client-ip=52.101.43.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d5Vh4GoO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7lWjbeSeaarzCISAZ6OT8bRzl6Nz774dsfkpDowSV9QNRW391OP7RXDhwNbi7AUAJ7Kpt4g5ZCaORVJvftiqYCPdm700kL96IyQ9traW+QdQW9giZoHTJuFXYxquEYh3rX6QsVbPECg6/O3N/RNqyl/f61ahqsALdsyBP/F3Vi5eCfbeYXqqoiKGyvH3Zr1XFJlxlLWIyR2/oe1wpKbIUl2j1f9YOIDE5JhVuiSiMJIoGwmJPzWUv3UO6dFEUdmhD1OQnS7KRlm0LI4A/ygK1mr2+Mhe0W4RzBCKnp8skk4irmmhBa8UHcwS8FKztkg2hXhEJ2M3mAsxggzoBuS2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5p8f96g1V3G84U93b1/Dt72BwgUBiIAczgYfpBo5cUc=;
 b=vBaIHjj/sBdF05j0NSvM+8s2ZoqTZQMfh5nm7uMUxl0gkLQ/ikaC5hhbzUIS5+/bILkFyaMnEAm4pUGub0DroHJXx2rwcKAxEDQtz2r0NDZdVRcECfzycll9b5cvo0dG7XH7IfiTYx6xMGSth8z6fjx2LVG3qOvvGjlnu22DEW/ESS813JhaQSWzK+QTzBcSDh/tZOMzE4MQZ/aPahqXPhy4C/+5gqqzsMnnWXsch7d/yDb0sjHJHPPf0uOdvkaideenfdZ3H3IexAQ7qJzhjVqlxRo8LOQHK0U0QRoBQWMyxsBwlgkZeRQ+mnOHQwAaNvMjIYZ5nfFww7Kt4xQFWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5p8f96g1V3G84U93b1/Dt72BwgUBiIAczgYfpBo5cUc=;
 b=d5Vh4GoODqT9Fxo7XSY5p/92suQNwBGMo5vQiTUpchwinDIbI56FYPehZqNcE+jElynYOZXw7Maaf6K14p+e2laaVxXi8Gn2molkzsK92a/dECowuktUNifvg7FcKXehzRfA36E447RmI/LLH9kc82ckCebBKqUXiuNieYrzBeuMJa1Kf93EGi9rHjs9dvJ2bqlEM/D4Xs0s0Dt0FfcIfCQpe0OROcTYfl1uA5WifXJpW5OXj2VYQImw6r8fd6Xd66XJhANrXxmBy4R5tg6C7Xn9cWiefRYf7y6KG3JEYGXupWJ+Wf/NriC8ZWvthVyqTS2MSwhvJNJZKD92nYahpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB9514.namprd12.prod.outlook.com (2603:10b6:806:458::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 11:45:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 11:45:42 +0000
Date: Mon, 13 Jul 2026 08:45:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xiong Weimin <15927021679@163.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	jean-philippe@linaro.org, xiongweimin <xiongweimin@kylinos.cn>
Subject: Re: Re: [PATCH] iommu/virtio: Report faults via report_iommu_fault()
Message-ID: <20260713114541.GG674038@nvidia.com>
References: <20260713010442.331096-1-15927021679@163.com>
 <5a220346-2beb-4456-881c-27b9825d9cc3@linux.intel.com>
 <aa9aeb3.65c5.19f5a7f59c8.Coremail.15927021679@163.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa9aeb3.65c5.19f5a7f59c8.Coremail.15927021679@163.com>
X-ClientProxiedBy: YT4P288CA0062.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d5f361-eb3a-4d1e-a982-08dee0d444a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	VZfRYSfW+93rYhE4OehmUOaKRre+EVlK2ONzJUs5Tl2CNh4UhzW/ho5Eps4DkAmDcghvMm/kOuCyUBNSSH4fvFeGYrna7A0WGlYKS2xNMEdBK9g0Sr1ep+JWRLAoHXn7OrKd1JoQtv38yM5N1YkVmvLz00n/8l3RR3FCRPLvhAUseBSkinKmL/d1qyuXhIxN2zXpR3qYGiZhnP0H74mzmyqG/xSypMUycWpTbGpc6yGL948RUI6V+N8RLuKFcWEM1NoPfeB6jPyysCPNlqMi41yVM28CiIgLZwL/3SJnTdafTaT3tZshoiLFJ3UwRr1RmgWHjfHno33U8ufBDevPIGspKKiTRza9p+nz9Ucayh7883HJyWvxYY3a3jadjpITJNr7x1/DjXTJG37QYBnLqkOMzMxjdPNELKHA+pPXJvujnrOnVP2WXWG99uBnwn3cd/LeyuXUzLY8dMG1dOW9oZZlymuRKIIJyc93PVLZCYy8wQxexXd423hn1ty5lCRgBT0BrUonezd3IY9C6se4KaS9JXLdEEddhxtV71o0YljFPDH1ooMXwO5jt3N8871ez7SKA0wwE3D+5Oge6+Tuj0Or7seWvyLoyn5ZZEpxohMDsIDHyK2qiEwK5GkQsc6YRYzdzmffKmHVcwKouIUhsSPfRC1/H8fZOfVtZ9TfcB8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFVHZENJajludms5YS80ZzRoUDJzSFpzZDRnRFJpK09RbUFVUnlIWUR1U0FC?=
 =?utf-8?B?TXIzazNXSTg3NUt1bWREOWx0YWxOaFZUcVdCU0oyL3VrVUo5MDMyZ1loZ01X?=
 =?utf-8?B?bGlUWlFCR29ReFhSSEN6UG5JSkVBMmo2aEhUQy9XYjdzYm0xV1VCYVFwUWVz?=
 =?utf-8?B?Q1FqMXlqYjA1QmNjOXBGV0RERnpJV2xDbzVCZm9ydnIrZXc4em94UGtUaDNX?=
 =?utf-8?B?cGNEb1BOWGNBVFhBdlI2L0pObUtqSWk1aGxGdE4zem0xQmNSZVRsa3NOcFlk?=
 =?utf-8?B?bUJnWkhvVnpoTHQ3eFdkcmdSTVlqZytXTEtyMmMvVTJLZzJ2Z2hDb2tGWFhY?=
 =?utf-8?B?ZGJLVjNLYUpuUzhReTB5TGVFcGwzTDY2emtLNllHK0xLK2Y4SGgvK3cvaE5h?=
 =?utf-8?B?ZjdWWlRKUWo1SnNsZDMrVGZzZ29TQmU5TU5tSVV6cVA1TWhhc1VienE5Y3lZ?=
 =?utf-8?B?cTEwd3FpOFlLMGgvRUNVeEF6Z1lkdTZtZ2UvWU5LUEtSR2JYUS8vam9wcnNt?=
 =?utf-8?B?YXJYellLTHZ2NjV0S1M2U1pNTGxITll6b2VGOXpPVmNKZkI2aHYzdFh2V2JI?=
 =?utf-8?B?eVVIUXZYT3BOSzJwOFlkc1kxeE4xRm9vMWdnKzdrTkF0a251ZlpyeTJXT3d0?=
 =?utf-8?B?S29mN0VLQWJVWkNvZldwWVdhandEZlNBNGFaZFp3Q21TQ0NBSC9pcHlZdkFD?=
 =?utf-8?B?RUVjM1BRamhjQWp5U0dPQTBXdDhscER6YlZOMldpTjNvd2h5cUJFZ2RVMm43?=
 =?utf-8?B?aVN5NmlIdExWR0djMUtHdTFDYWZKU0w4RkhTVDV4RS9vd0FRMENuRlFLeWRK?=
 =?utf-8?B?RzRtaVpTcVpLaVlBcE40WmVkSzNzUUhPQUo3RXBaajZmQ2loVUp6b0tzRHVv?=
 =?utf-8?B?dnJjaTBLeVZwM2NTaTlSMmIrUUpHVzB6OEJFUjEwUXJab3RlVDdPd2VVUzls?=
 =?utf-8?B?NjMzZmJaOUpob2FVSXlQRllQek1QUXVIQ201ZURvRnNneHZhWG1sZFhXdnpB?=
 =?utf-8?B?ci9NSjdNVkZqTFYyLzdCcnlhdzNmRjUreTdFcVpIQ0hhaE1keEpxSlpTMVk1?=
 =?utf-8?B?bFhWSUZOUDFSMTJKRFlZb2FHZm5rWFpLMnhRYXVMM1BWTU9IQ2tGWVRpWDRL?=
 =?utf-8?B?amhFQVAwcmc5Q3gwcytmdFFJd3doU3JxR1laemFNd29EL1pXaHBObWxlcHEw?=
 =?utf-8?B?Y09zcEZYN3FzK3pDTFp6TFZ2NERZb0g3THBvNlhXYXlwNE9oYUNJNDB0OGJO?=
 =?utf-8?B?VklCcUFad3BBUUtCN1BpNW9IbkVpRjVPcUZlTUlEYmQ0T3pqQWs4RmhUUHFJ?=
 =?utf-8?B?K2J4QUpScC9yRUpXeFJZcGZBSk5zN293aWRMR2RFSHEwajZrV0lwd1Bnc2Jj?=
 =?utf-8?B?OWhFNHNuUFFXQlBRWlRObEtwRVlTM0hjcURKZmZ3Z0xTSS9zL1ZFcXJkRmdL?=
 =?utf-8?B?bko0TUxHWi9vNnhCMkZOQk9sRC9PWGNCdjY0Y1hhd3JQZ1FseE5vaG5xK0FE?=
 =?utf-8?B?SUl2ZkNITVNUQUMrUnA2NFlacnQxWFRuVFJ5RjEzeDlOTnpsOUJrc21jM0Fr?=
 =?utf-8?B?V0ZMVzN5cCtQaXF1RnRocVFxckg0cnlpSjdxejl0eEZEY3NWTktqQTAwaGFz?=
 =?utf-8?B?WkJ1OTAwdlpxV0s2dU11S3dBMW1WTjBJZUR0VzBpbS9wUkRMV3JDYnBjTTF5?=
 =?utf-8?B?MlEremdCUWZscjdvaWNvUHhXNkMzWEo4REtjMGN1RnMvK3R6WVlhTzVqRFdl?=
 =?utf-8?B?NFRRM0xIUFhGcU9TV0lZVm9jSzVaZlVXd2lnUVhDcmlCNWEvQ0o1dW4vU292?=
 =?utf-8?B?LzZMSXI4L0FBR2xaNFZjckJ5ZFFiVm5MUlJTWlhmR201bm9hNVpqSUdHT3ZY?=
 =?utf-8?B?K1NnRU9JaWE4MGR0dG1IVTNLM3F4L1dHT2MxNnBqSmRTaWVkckp3TWNLZkp6?=
 =?utf-8?B?ZHpQazBaNmwvbVpMT1JjYVplbVM1SVZiUEZVd1U5NnVTVkVHdkU4OXl2djI3?=
 =?utf-8?B?NDlQUkxaczBpYi9iYVYrTEVENDhXZUQ4a3YyT3grN3N0dWxPbEhQeHp4Y0h0?=
 =?utf-8?B?MGt3dlJ1cGNmTkZJcEM0YWJJNUdsNDU2UXJUOFU5TEs0ci9Ndi8waytDc05n?=
 =?utf-8?B?S0JZTmUra1lYeE9jeEhpL29aUlN1ZGxhMk1aaUZyY1dXZFh6TkZtamV1VGtw?=
 =?utf-8?B?TnJoU3NQbkFSeUsvTWZkQWxDWFhLTjhIbllIejZLakR4UUJwSUJ4UXMrdXFx?=
 =?utf-8?B?ZVZaMVNORVVWeG5HTmhUQS9lYkdNWERScUtwVG1lMldGZHZtZmJTNFl5RW1n?=
 =?utf-8?Q?BTyI6gnhgvCnkJr+eN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d5f361-eb3a-4d1e-a982-08dee0d444a1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 11:45:42.5279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DxF1y0e3ytDYn5idn9mOBB7xhMZ9UT4jmkG792gQOnCtZm+dVpzB81NWOaiu/OI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9514

On Mon, Jul 13, 2026 at 04:02:03PM +0800, Xiong Weimin wrote:

> The consumer is whoever registered a fault handler on the IOMMU domain
> via iommu_set_fault_handler() — the same path used by other IOMMU
> drivers (e.g. ARM SMMU, AMD, MTK) when they call report_iommu_fault().

I want to remove this old API and posted a series a while back to
remove it from some drivers where it is never used.

If you don't have an actual concrete in-tree use then please don't add
new callers for this stuff.

Jason
