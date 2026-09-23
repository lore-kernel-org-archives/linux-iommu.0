Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012049.outbound.protection.outlook.com [40.107.200.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263AF44A3EB
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183029; cv=fail; b=iWcAaMbQt4C8M5ANnXjhtaWnyiMIsPnpA8PzPgQVuXQTxKjgj/zBnz4oS6/6oFSLXYOHNLem6m0Z9vODVxC2NUejtqZnnw1tOOcktsvaZ3DFDC7QgRXkdC8bcG90zLwhmdASdUJHK9BdT0xxcXkbnoClQRiSjmqLHUzgjTdHDRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183029; c=relaxed/simple;
	bh=d4bmL3t+tHsCiSFSYgmIxu15gjruh8NP4wRGCKKM4tI=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=m74S1baCGVWcDnOuf/F7b/wj/S9VEyyYJQAMLGwGjsDrHtZ28ohTXUf3dCUSpOSCQdNR5bhEKxPSR2ZJgIL9EUoW8A6owjNIbFyYDhFPA/ZSkJobQFioNKximjW7pYoCwcgyPN4PtIxmel4oY9MspBodMYli1bkQE/e61b3cyFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X2odBybe; arc=fail smtp.client-ip=40.107.200.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X2odBybe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suUFYKub0KNgpT+OZDdH6wpnhUMBmGat3zGtLvaQ34uYetDLzcIMHQH4k6ZKSqhcrorRYdYEb5HzbxccuYGcAtcqRGA2HUUF5+7ZgHHMsjzguhGpUeUyouezgSxT0MTnPT8Y7usslDziw8HVTWDs8h+pkqPCxBzhypj8+RUNDeK+E7PVHETRhdjgoDKzgiN+yuh+cyM0BeMuwYffwjv/KUm7ck1qwMcy9HtcgaxXzmWlauNqqP33JcxPIJ9srvVe2WDoA8GiyJn+hN57fIAHLdF7aQu7m8pGOFrKJkVfUXWc80G/y75chHImjPXIzwy25Tr3eEsRAYChW1a+aDzxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mr9woqzfYbqxeZnpqupRyVXNn84DTPQKrjh3dY/imAg=;
 b=KO71TMMcwPoBxHO+rL3s/eZmGecf4OWWgV9ZI2a81/QtYVV5vD086E2p+WUZEOh21k7NDN00koTltiDLiyJ0zIc/4Gydz06ZC5jNjBJ3LYE2LvrACvUtcQTPp7j3wxxBGADXehUOF9ZxxQZkz7VSCE6OGELgII+UWCozWPl6gLGUvd3OZKIVNMY6vJquo37muCdyPurSsmV52ZtbTLtuvGOovjuq4kKpnfYkydqjO+p4BKYU7kRivzlvQzDCoGfOx7Du/s2liGuWWfI0aTCseYj2Zgvg3v/eNyP4WXK/ERQ82Oi3dN+44Q2PGEsSOJOiHyqIQGP10oiW9ytQ8NoRbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mr9woqzfYbqxeZnpqupRyVXNn84DTPQKrjh3dY/imAg=;
 b=X2odByberU1lI3OWeWibKhnTyeBKb/Lu581hTfZAB5Pb3LXUNfdyiI8fAi13basboEpFLrJ9No4nYranqSA+cLWEoNzLP7X1s1Rw5Iib3TcRvnhnPhfUtfmzfxO5D9vj9ueL6h5dcemKUjkM2b/pEUNymMxIYXPMQ1zvKWgbpxGxsRZJ9/I96vYAtJig+pzDbnJmPSN6F7U8+FLqrwm9X+4xTxD9AXZIQ00dW9IlqUuSZ37+ySdQ1yw3NXPZMpe4lu2me3+7CrClAc78H1NUMSgTSJ2sPpt1haqguIISZeHpG69edQi7QBOdMqZ/XBwJ6Fk6ciRN5YO5JpkJjuNDyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by DM4PR12MB7574.namprd12.prod.outlook.com
 (2603:10b6:8:10e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 17:03:39 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 17:03:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 1/2] iommu/arm-smmu-v3: Add a cmdq_max_n_shift
 module parameter
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>, 
 Jason Gunthorpe <jgg@nvidia.com>, Pranjal Shrivastava <praan@google.com>, 
 Mostafa Saleh <smostafa@google.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Breno Leitao <leitao@debian.org>, Kyle McMartin <jkkm@meta.com>, 
 Usama Arif <usama.arif@linux.dev>, kernel-team@meta.com, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260909095228.2174031-2-kas@kernel.org>
References: <20260909095228.2174031-1-kas@kernel.org>
 <20260909095228.2174031-2-kas@kernel.org>
Date: Wed, 23 Sep 2026 14:03:36 -0300
Message-Id: <179018301689.3334538.1783583175230817305.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: CH5PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::22) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|DM4PR12MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: a524c4ee-3c6c-454a-ed09-08df19949d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|6133799003|3023799007|22082099003|18002099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	HriS0LjZzGWCYGA7Uu99GbYxgogfiO8mC5K8gli8iw6Z8lj7LWUOq5RVSJkI22F514j41O7P4wAsGiuR/WHWl3/xdaA5/Q41dYjAVp6SFy45MgEuopUq5I+43i0PaFUFaqW64oi4nrwEhZKlTsVvfgNUovWzXT8LTLliglWFr3fmJJ/86IbuLtAZ7s0wmJsJ2JN+AgGQShBVbfjlmRBYg2GY9557alUSBoPhI4mAB2wYWmaJh2AaLDxAdT9FY0F2j9oIVWGrQy4NH7WaOse+S7DhycEMQV3MNSeOoDO+ADO6KstZXbo52DxkZCV2EL+dawdlmMuqDd9tKtC4gJlyxmXODSRNnmo8op17AfQU6PMuwJPH74/99Sczv4uBa/J4bEaqZVfhuTq94zPURsPJmn3DHAjupxWWGJeNhrxsPc706/EAYdjdp3GSuQqbV2taCwIzf8h3uHTnt66bB44mOs5YL8u9ALM/ulWpt/UTFvGXRhQf3lPLk4Zfo+dt2MV9v5ZGA4YIRdgYyeSDnPAYcelvLL6q7dprU0PAZOFqxnU1D10duMbCVmuV1+8mxa8d8RVlNd4pjBaK8rnw6Y2JM6JVXLgKp9rKD+E7M5VMVpBQp1Ian+7kgmTK2CXVSLTKPnZUytCp5q9pPBHixKOB8G0MjaUUljS9Q7WjitUGkKg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzJVSC9zUEF1empvc3B4aVJjOXZYYVdzRUpFL0M3cDBzTkVqbFY3OTFieTJU?=
 =?utf-8?B?Y0tuUFhFN09hWGVUZFhZVUtNTG9vOUs2Uy9WQ1hMd3p5NnNQeDBra1lkMVl1?=
 =?utf-8?B?bU9kakZLK2RmRnNUTXMrMWdjRXJ5UVdWZzRDOGFrYlVuMWlSWEtoNWxYZXF2?=
 =?utf-8?B?ZE5QRmFHTWYwai96cTNQTEdtdUJaaE5hVDRaaEdIMFFQbHdhcHh5Sk9ncWhh?=
 =?utf-8?B?UEE4REI3d0RRNmFlRlBETWFISXpUZTZlTkVRMVVubE5OM1VSN1NHVVg3emdi?=
 =?utf-8?B?ZFFvVHNqZFVkTCsxTXN2cHNlR0dMekpNSkJMTDNxeU1qbG9KRFlLWGdoZmIr?=
 =?utf-8?B?MjNHVkZBdjVmYmdtWDVJbCtNR1lRVmJHQURON0F6RWZEMnoxV3ZqWlhYS3dN?=
 =?utf-8?B?UzJnekJrOVJvTEY1SXhhN2VxTGE5dEVPQjhLZS9iZVRDRmw3NUNWQkJEdDZt?=
 =?utf-8?B?QU90eHYrVWs1cTNyNEZsWVpGcG9XaU12aWIralRlMFlUZ1QyaUNSWm0zSEln?=
 =?utf-8?B?ZjR3SlVBQ3NtZ1ByNlFTWmF4QitIY1d0N1FhS2l5MGZYU0dEQW9NK3NKOEJi?=
 =?utf-8?B?SWFqVXpkUmMrSE81S3krQTRVTU9XazVvQmVMM2VLUmE0cFhDVnpaZnZROXEr?=
 =?utf-8?B?MERLQXlPMm1RWC9KUS8rekdEWXE0RXBKWHU3K3MzQW0zTElZL2Rxc0YzUVRX?=
 =?utf-8?B?MmF0ZnhsR3M3UG1XUTZiend4RkNmdjhUS1loMTVyeEV0Yk5IbjNZMEJ3V09t?=
 =?utf-8?B?RDZrb0tEc0JSSU0rczVQa1pIREVxWEo5WDdFUmZIUWFhVE8wcElDdWZiaHdy?=
 =?utf-8?B?MHgzRFBBeUlPQUgzcmRzOExNWmhZRC9XNEY3ZFQ0aUNPS1ZLUE1ORzBXMDRs?=
 =?utf-8?B?VVlBei9zWTU4U1V4ZDFEREpYcXI3bHAvaVZUbm5EMFVEZSsyUWFQM01iQWJM?=
 =?utf-8?B?U0dFZjFWMVVmWlJxUzQ4NlU5a1lmZk9NNUV3dDk3YUxQRGFldUxJL3BON1Jx?=
 =?utf-8?B?UlBKSStYSEZ3ajBZK2tvb3pMYklySjRUZ3YwNFlRRk9mOFNQbkloMDJCL1N3?=
 =?utf-8?B?bmJ6MVZ5QitsY2ROZWV6UkhMZjdsNVpQWFlPWG5WTkZEVW9vNWl6VVZWMnU5?=
 =?utf-8?B?dGlrVHZiVWM4MWIyeGcvczRmYncxVkljb3ptZHE0SGJrejVKWW5jSXRXY0R5?=
 =?utf-8?B?Wm1ibnA3SnEzaHNYc09wejhoRnRyUFltQ3ZRSnVBSkdyUk5VeWxUaEUraTJu?=
 =?utf-8?B?YkgrSnJ1RWwwT1pqTUpVYmExc1JyTDZxRFd6MHpLdTNDOW5JN2YveVZZKzNP?=
 =?utf-8?B?SndQT2d6RGlmQ3RnZ1lRcVAva250c1p4REs3bzdmbHA4Ykx6dEJWRWlsbEVF?=
 =?utf-8?B?QmlMTThxZkNBRnRiWU1Ed2k0R1RFbjdleHF0Y1NpYUFGZVA0cE5pWEoxUWo0?=
 =?utf-8?B?Wk01eUFPNnQvU0hEcndiZVE2MWVsSWZYU3o4LzljbUhzVUo5VWdZV2NXRWdx?=
 =?utf-8?B?MGJJMDhUUGVCYzZqa1l2SHN5bUVVMjlTWVZabGw0NE9CL0s4c2l5T2xwVTBv?=
 =?utf-8?B?MHZiRUJMcUFTK2R1T0hXMEV4TkUvRmlxZ1ZHZ3VQUStXNmUwRjdjZnNuOXkx?=
 =?utf-8?B?MC8raTI1aGRrRk5wV1d5bFBybnhlcTV5eWo2elFQaTlJQldwMUlSak5iSDM1?=
 =?utf-8?B?bmZaaWFyRVdqei8raVFNM2tZL01YdjkvVUpEaE1PcjF3OWhhcGg4RGdRT3Fi?=
 =?utf-8?B?dm1vd0JDK3NhQ2g4Y21zUGI5MTZaQUNqNzVEeUFoNHB0ZHZqcTZRMUtNVlNp?=
 =?utf-8?B?NHdldE9FN0ZtbzRHZ2ZRMzlNTEd3dHlpZkZDelFJbG1iVlNodlNWd1VKUmtq?=
 =?utf-8?B?YmR6NUhkNjNPZ21XMDMvQUFKVURoY1dlQUd5WGpxTjJ3YnlmZTJFQzUxM2Fs?=
 =?utf-8?B?MGU3S3RKRjZ1SUtndFRQdy8zbGhOa21sOHFFdmJTWUJhcW5nMFJCN2l2UjlW?=
 =?utf-8?B?RWRkOEhwK0JhUDhlQ3IweVRRRkVTV2V4eEMvYW84YmlaOHNUbnM5cjBMbUVs?=
 =?utf-8?B?Q2FHS3pHeUlFc3RwKzQzSVFINGxKT05uYWVpYUJndGFJdlN3OFovSVFwMlZ0?=
 =?utf-8?B?RTVTLytSYmNQblp4NzB5cUZ5K2V3aGlGVlRLRHczUTFYYS9zNHJRVVVoSmg1?=
 =?utf-8?B?bXpnNzR1ZTdVL0FuM09oMGZnN0FzeGVRWTMrcU5acTdvdGw1T05JK1VZREVW?=
 =?utf-8?B?aEZZbVlSWmRiaWcyYWd6dzJ5d3NvS3dVMnVGcll4NUN1aENBTXN3ZDhOcklE?=
 =?utf-8?Q?5D7Zpg00ikR3qfgqnA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a524c4ee-3c6c-454a-ed09-08df19949d31
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 17:03:39.3877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59B+EOprCOEZZcrjqhg37ZKNdrScffwFgX5x6nI3UDEbdYclKoeB0LqvYqC6aHKj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574

> [ ... 34 lines skipped ... ]
> @@ -40,6 +40,11 @@ module_param(disable_msipolling, bool, 0444);
>  MODULE_PARM_DESC(disable_msipolling,
>  	"Disable MSI-based polling for CMD_SYNC completion.");
>  
> +static unsigned int cmdq_max_n_shift;
> +module_param(cmdq_max_n_shift, uint, 0444);
> +MODULE_PARM_DESC(cmdq_max_n_shift,
> +	"Cap on the command queue depth, as log2 of the number of entries. Zero means the hardware maximum; the queue never shrinks below one page.");

The patch looks ok

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

But I'd rather use lg2 as name, especially user visible, instead of
n_shift. "shift" is a word for bitwise stuff, this is a 2**N log2
encoded value.

> [ ... 9 lines skipped ... ]
> +/**
> + * arm_smmu_queue_max_n_shift() - pick the log2 depth of a queue
> + * @ceiling: default log2 depth ceiling of the queue
> + * @ent_sz_shift: log2 of the queue entry size in bytes
> + * @shift: log2 depth asked for, or zero for the default
> + *
> + * @shift is floored at one page, because coherent DMA is page granular: a
> + * shallower queue occupies the same memory as one that fills the page, and
> + * arm_smmu_init_one_queue() stops shrinking at a page too.
> + */
> +static u32 arm_smmu_queue_max_n_shift(u32 ceiling, u32 ent_sz_shift, u32 shift)

These names took me a while to figure out. Something like this seems
much clearer:

 hw_max_lg2
 ent_size_lg2
 user_limit_lg2

And the flow can be simplified alot:

static u32 arm_smmu_queue_max_lg2(u32 hw_max_lg2, u32 ent_sz_lg2,
				  u32 user_limit_lg2)
{
	u32 floor_lg2 = PAGE_SHIFT - ent_sz_lg2;

	if (is_kdump_kernel())
		return min(hw_max_lg2, floor_lg2);
	user_limit_lg2 = max(user_limit_lg2, floor_lg2);
	return min(hw_max_lg2, user_limit_lg2);

Just pass the MAX's as the user limit:

static inline u32 arm_smmu_evtq_max_n_shift(u32 ceiling)
{
	return arm_smmu_queue_max_lg2(ceiling, EVTQ_ENT_SZ_SHIFT,
				      EVTQ_MAX_SZ_SHIFT);
With only one min:

	return arm_smmu_queue_max_lg2(ceiling, CMDQ_ENT_SZ_SHIFT,
				      min(CMDQ_MAX_SZ_SHIFT, cmdq_max_n_shift));

Jason

-- 
Jason
