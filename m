Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012066.outbound.protection.outlook.com [40.93.195.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE95A2DC791
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 23:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108040; cv=fail; b=aDphj7NbPx3nj++xOPOZCJMVSK6Lwa1HFUdbWl8d/CalIUzCBVhLwH933hKF7HK/pQCuvJBCb2ISw4OswBa+n7g+fhtHhC3ED6AZXcHHRR5/2JzMd/E2d5auPXmRJg2th66VQPrX51742PX6ieFj1IpCfeXOoP/3PydAAgCtJng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108040; c=relaxed/simple;
	bh=Q0JO8CGa40HeNh8oa4REpEoiRJIWmDGs+UI/K2EO6x0=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=kp9xcEVNdqXKujAabxMU9TJJgClUqVm2OXQmiFG7O3GK+DqXmk+/FLnkbs7APLqnb1Of4Wi1JbPZaW1MqMqTIYqYs6uyu8yPlsUzNPScTO1aaueU6G4I4WYnXUcAF5CD68YtbuJqtLcD/pK51drK2T8jJD/sUfM7AX9iVyPHdko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hBqzKVfB; arc=fail smtp.client-ip=40.93.195.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hBqzKVfB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwIg5vztIuFglRDDf33zNKAcssijexB0/JRwbAB7bYDVUjOCgK3M5FLiUff5U07dCXFAnd4hciozW4Cr5DYylYWmuBGhJyd1JlVc43QLe2y+/hm/ugvAjAMSzu85AEhBQlgpaanovZ/ihLn1vHOkJGon1PjcsZhrC4bY24woK8qGXE1Oyjp9EZ6b4QeIKiV0aQQLh5OG1/QuqgEYUCgTCULo6FV21OKwqkA0T7ZjDM/Unq3J4SlXsUcTB9SUxWiS/avmo5r/ELi8RlRPF+TXVfoxMkm7u/piP4XR+31hNn81NTEI08jlnyAHcQwZtEOMPZ7J8WxApMj7eT/P1ql/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okJ1aEqJTEUPD1qkRRawXIuMHscQXJpetToxtjeGOto=;
 b=YvcqpIt1B+YUJ/Lba+m9iDyjlB/tFLvRocG6TaG5YInoka84cR2YRsP6uGLE2HOQj8YvlAqmCrA6vu6uvNBCnGKFKaMTrdYW/dIdCf89m6dMcwIDNwxQ0HblcwbVxutlL4Gwu5CEhW4bKwsAQRPWZMVoMwYwX8ifjJ3h75dm9upJTJs4lrmF8gdVEz/v1Jxmm/uyweLtq1NBGlyTNjYs+didzW/WV5ZKvKhO1rDg/3I0wqO8rCAS6W7zH+HYQvGFgMErdwb3trfMg0G9rGxTaIKCnpwc7YeS0qR+hACTbklcVlnfdII3mCIKjwtmw4fewDebFC7/PMum9/zw5JhLNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okJ1aEqJTEUPD1qkRRawXIuMHscQXJpetToxtjeGOto=;
 b=hBqzKVfBDPDcUeAQLjL972HjcceA3v17LJDQnSxs/HEJjBLnkrHc89x+bCs0DnGDicix42RAkKyvABDNljM8BVy/0pfzacwM59DK1AGJ+iyn/It2Vi6rHSxSZ0ecJYfoFBImL+OXdJI5XRrwITCaPZ+i8wu4Lsgt2kvIpBXwP293kdWYjwdqlJNwXuF/TUrvtxTDjn0SBbt2zREi8T5QssvDpe/bHoE0apYatZTVYZbxtKSOXoN1o/vU6GCWaOu0+Sn4MlkjKuK5lMrQTXnIh66LdyHtFsQrtHJnqFuO24TMq30XJ+YI05/PTBGCyiR9fp/zG0qsMmygjoGC1Bsesg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DM4PR12MB9072.namprd12.prod.outlook.com
 (2603:10b6:8:be::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 23:47:13 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 23:47:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH v2 3/4] iommu/riscv: Add guest IMSIC GPA mapping
 helpers
From: Jason Gunthorpe <jgg@nvidia.com>
To: fangyu.yu@linux.alibaba.com
Cc: tomasz.jeznach@linux.dev, joro@8bytes.org, will@kernel.org, 
 robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com, 
 aou@eecs.berkeley.edu, alex@ghiti.fr, jroedel@suse.de, zong.li@sifive.com, 
 andrew.jones@oss.qualcomm.com, jgg@nvidia.com, jgg@ziepe.ca, 
 gsh517025@gmail.com, guoren@kernel.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 kvm-riscv@lists.infradead.org
In-Reply-To: <20261014141124.48569-4-fangyu.yu@linux.alibaba.com>
References: <20261014141124.48569-1-fangyu.yu@linux.alibaba.com>
 <20261014141124.48569-4-fangyu.yu@linux.alibaba.com>
Date: Thu, 15 Oct 2026 20:47:11 -0300
Message-Id: <179210803193.58760.10996339526486124321.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT1PR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::16) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: adbb969a-fe69-4f02-52db-08df2b16a2b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|56012099006|5023799004|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DH7VM1TALUN57+6Xw68g6FAujm8iesYFS6gVR3frBxzNs5F7TFhoqWmO5VYuIUpqR2nu+SbtXZE06mXmaPdJp2sBLXCpiFP7gfJI/zISr71mNIcZe50kFxaqFN8dxNpxTKebJcM/fCksIHu8dpB2fl5TFxZG7viBXv/IME0HNVlIzVqDmiSaarLruI7vbPIjdVrD8sW50kZk6f9YGx9wKPTdCCgfzlVWXu7WkCTvelSz/Daqsl2/A6FoOCryQreTHEjWVAdoCo7o01TPDbdv6KvifuEgkHVM1/zUX6hBQIuuCVsbmLZIF2HHt9N4x+dJVMOiIeqLkiPkY0qKX6hhzgGWm/QoxlfucpzaukH3XRzfaSknJY7NspQZMtj8gQKJ66ghkIpmatuLXG87k6Q7ocnPr0RP1FIfi42CB0lu8S6LWyTRS2bgD1OFMOAHbpZVrJdtGPv/K+sIGpVjDBJrv/uQsKPKg/C24bXwanu0nz0v0xsiLkDSE7kE13po196/8qoy7Qz2EYgDa0Pa2pndB3HRKLAaqhLfmGDa0TMGqhJD84Kr4mXcsd+BPy21rdjvxgjg+g06Jlmjb3UbSenw/quovSc6BOA9fCuH3+LC5GKPlNow/ijzwOUMopQOw37vPgFqpKpc3yhxu8ilG65+BkAcReJrhJhEr26sGXkBels=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(56012099006)(5023799004)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clhoRUVQQzJmZFpYK0RNQmlWK0NiZ1QxaTlQTmUzS0swT0p6RHNPK3l6WUFl?=
 =?utf-8?B?d3hSR0ZkY251UG90bURLTzJkbWxMUzhlQ1JSWU5maGVielZJaW85cnk4cmp0?=
 =?utf-8?B?OS95Z3ZMaTNFdTFXN2R6ZkVKMWdhK1EvTFlJdFNSTW91R09kS0srSW5XUjNv?=
 =?utf-8?B?bW55dzhGWVBWaVJhdGJZSkxLMWNXSHRqc29BRXI5RlIvK2lqMzg3OVB2L2pN?=
 =?utf-8?B?bkpjaHpUVzhpL3AzbUpITVg4bW4ra1k5UEVhbzZNT0U3WlV3U0FDczB6VjlC?=
 =?utf-8?B?WjJmd0RKWFljNnM2NzNkdEZ1VHpmRDRsRzh3dmxqOEZRMy94TWJsMnFwRzl1?=
 =?utf-8?B?aUdZaHZaYUNRNTdjUHRHRUlRNWszVnpGaDhnK09sLzJVYmFOR0k5YjRyQU16?=
 =?utf-8?B?NUpBdk00djNNNEYveHBjZFh3S1FKdnd3Qk1GMVVQcHU5dTNjcFhTbGlLcG1C?=
 =?utf-8?B?ZXhlTDh1M2VBR2R4SnNpeDJ2MEVXNTJxbWhpK0NiOGFneGN6a1laeEZzemVG?=
 =?utf-8?B?cVUxUkRZZzYyMDE1aUtaTTRSNm9XWTlxemFTQVBRU3NBRFUzWWpkTXRDLytl?=
 =?utf-8?B?S1k4N0NWUHZIK01XYXdaTEthcXAxSG5TVlJXbUdVVzFnazBXbkZiTTBhbElq?=
 =?utf-8?B?Vmt6RVFsL212NTFSZzY3WTZHVFoyLzkrS1I3WlhHTStXcVNXN3pMeTZaR0Ux?=
 =?utf-8?B?RmMwU2JWZmR1b1F2Z1FqeGJJNVVkK2pNVHZ5LzhYZmVBNGNMdXZGT1A4Y3pq?=
 =?utf-8?B?S1dXREh6cFZZSTdFdUc0OGtNeVpUQ3AyMk9RWFdYRWl5TndCQ2RQMVRiVjBp?=
 =?utf-8?B?cEw2d3kzalVBQXlSK3BaNkVOcEdxQTAvS0NIdkFrRmhLSHl6RVZ5UnhmejVH?=
 =?utf-8?B?TVlQeFFDaVF6ODY0WFVhU1ZMbjlaVU90akwrS3dmUDhYZ3BGTHE1bGFQZWNU?=
 =?utf-8?B?cHIzemNLc1pXeTFYUFMvZENMNmNBNERtdjNWc0x2bDArcFA0Lzk5TVpBWnBG?=
 =?utf-8?B?TlB3VC9HM1ZuY2pvNS91RE16NDQ0QkZpNWdraXlqZnNaTnpKQUQ4c1VOZ0J3?=
 =?utf-8?B?S2JBNWk2NW1WMlZzbHE3MVBONWdoaUpvTWF3b29UUk43SkwzSnJia1loVFlG?=
 =?utf-8?B?OUc3OHRsdVdqUWhROVUrQ3ZwdjlrNFF1T1d0d2RPUFd6Z3cyQUN1RUdlK0Mz?=
 =?utf-8?B?MGFZTm1PdENHaE9neVhvREtWMlBiSlZIZW5tcEhTbnhaMU1LN1UwbjN6UG9h?=
 =?utf-8?B?MjhGMWsvRVFQOEROWmlmY1FKa1krMlM3TnpBUzdyUkJHcU5BSWJjdFp6Y3Vj?=
 =?utf-8?B?RFZ3ZHV4RjBIajVydHBlVUtlNllGTzgwWitCZUhuWEx3b3pRWDBLaiszall3?=
 =?utf-8?B?N3ZUSjUrYnFTMkJ6TGN4YVJHeEtDdy94R0c3ZHVmdHFoTUhYVnlxQ2JCV3Y1?=
 =?utf-8?B?V2VtTHV4Z05ubWlSZEhTU0ZBSm1ZVkJJK2RUM05CSXdjZ2NZM0dpRnRXc0hw?=
 =?utf-8?B?bk5UNWV0QnhjZ1h0UnhyYUdZYnFSQm0wdXl5Vjc2QTRWei93WmxhYkIwTTJM?=
 =?utf-8?B?TlBHME13dHNCRlhtYVBvc2MrZCtRUDB5bUdwQVRKVUVlNVF4SXQxQ3grRnp6?=
 =?utf-8?B?c3RSblhUMXhVVTk1bXVZTzVzV2dNNktVcmZyYk44NWhNOWRXbHVNamhYZm5X?=
 =?utf-8?B?Ym5FeEgxMnZ0enJNbmVBQ1JjbkZSR3ZrUmtEVnZSK0F3S2FhNjdOWUFJcFNh?=
 =?utf-8?B?cTNtOU9NajA2N3k1byt1R3lMNVR6SWNKd2ZTcnVTSWhmK005cFVUb1V6N2h5?=
 =?utf-8?B?WWtYWndEbTJHK1ZkTThFM3VaNC9yM1Z2YVJRTkNQRUcza0dhTWVhNlBWNzIv?=
 =?utf-8?B?V3Q4dDdISWdFdTNpSHR3S3Zaei94UGxEQmIzR1N5NmV6OTlxTEVwLzJ3UStk?=
 =?utf-8?B?SVkvWkNkaGhJUytZQ1kxaEc2bHFpRFozRnU5TVlmc2hwUzEwL2laRzN1Mmxu?=
 =?utf-8?B?OFZwSkxTOFRnUTVJNHZoY2xwSkVyeVZkL0NiZVNQRXliWlRhUWV1eVZFZGlN?=
 =?utf-8?B?M3p3VWpCekk1TGFPN0pEQ2xNTWpIeVY3blFWT3MwV3pGS0Nub0d5ZC90QUhs?=
 =?utf-8?B?V2Ixc3JkL1BRSlF0dksxK1R0a2dDQ3laWGl2eFNuTlZHZjc3cTFCTlVzcitv?=
 =?utf-8?B?NEtHd2JPTUI5STFGTW95bWh5SVJtR0VBZlFWQjNva0tIUlROSmdwT1JLdFFD?=
 =?utf-8?B?aGdVOUNVMGFSRHR2Rzl1TFNxUFhaZEVDOHoybHdjdVVkYkwwcHZvcklGaGJp?=
 =?utf-8?Q?xymLtzzIN6mrt6PzpS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adbb969a-fe69-4f02-52db-08df2b16a2b4
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 23:47:12.9666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/fq42prmu7w8kIiDiJhymE5sg8OOLdqTMnoxXcPwsz1QnlJzPp0QnIhG6Up1Zrk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072

On 2026-10-14 22:11 +0800, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> IOMMU implementations without the MSI_FLAT capability translate MSI
> writes through the second-stage page table, so IRQ forwarding on them
> will need guest IMSIC pages mapped into the second-stage domain.
> 
> Add an xarray to the MSI table that tracks the HPA installed for each
> mapped guest IMSIC GPA, and two helpers for use with the MSI table lock
> held: riscv_iommu_msi_table_map_gpa() installs the initial 4 KiB
> mapping, and riscv_iommu_msi_table_replace_gpa() repoints the leaf PTE
> when a vCPU's VS-file host page moves, using the generic page table
> replace_leaf op instead of walking the table in the driver.
> 
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  drivers/iommu/riscv/iommu.c | 43 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/riscv/iommu.h | 12 +++++++++++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index e2e77469ea3c..88e131ce96c1 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1217,6 +1217,42 @@ void riscv_iommu_msi_table_inval_all(struct riscv_iommu_msi_table *msi_table)
>  	riscv_iommu_iotlb_inval(domain, &gather);
>  }
>  
> +int riscv_iommu_msi_table_map_gpa(struct riscv_iommu_msi_table *msi_table,
> +				  dma_addr_t gpa, phys_addr_t hpa)
> +{
> +	struct riscv_iommu_domain *domain =
> +		container_of(msi_table, struct riscv_iommu_domain, msi_table);
> +	const int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> +
> +	/* Guest IMSIC GPA mapping only exists in second-stage translations. */
> +	if (!domain->gscid)
> +		return -EOPNOTSUPP;
> +
> +	return iommu_map(&domain->domain, gpa, hpa, IMSIC_MMIO_PAGE_SZ, prot,
> +			 GFP_ATOMIC);
> +}

Andrew has moved well past a v3

I shouldn't be seeing code in iommu or irq drivers directly mapping into
domains. That doesn't work, Andrew's latest series don't do this.

It still needs to use the SW_MSI mechanism and related.

Nothing in the commit messages clearly explained what this is actually for
without having to go dig up the riscv manuals again. Please explain how the
interrupt translation works and what actual user visible problem this is
trying to solve is.

-- 
Jason
