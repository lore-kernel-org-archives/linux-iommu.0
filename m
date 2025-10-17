Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138C82F6925
	for <iommu@lists.linux.dev>; Fri, 17 Oct 2025 14:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760709667; cv=fail; b=KYLDqlUvVeLSXLxPQWLXH5ouBxZdrnz+wdZqMqEVdBjk2IapxkPmmtiojXef7rH/IK4PJUNHX015bBCMft1qszkGIhJpj4rPmX1s6z2qwV7Efk6ZGE3bezzDzx6ldnfMmZn1sG455Ap4LGk72xzuicehI5A+ZwFdpFIz5ezNELA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760709667; c=relaxed/simple;
	bh=/7GbMvW1e5lMkY+IoUtnn0rAwre4gqYH6PstLqTMly4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KRbhhHJVQagjqfYPDmgXvTuBht2cm3LEoMLLHyUA6HHtdsx70a18oRNBTsMAjc9wY6QtQxZ3DS2VV1DNtvzNVALXFj4BUGTPGVcKgkvmR4NdYkUlVYR3qYv/ZAmhlEl4nze9khgIJQDdcbMB7Wv3wIUYWAU0CRjDX8CoWObOM9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PkNUrePK; arc=fail smtp.client-ip=52.101.46.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PkNUrePK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJRxrpzeaS2Z/OJfTuFI/IRy76hgxqsAFycpDinxBpwTFkvOBH8HKARO6iamwXU91lcIwEAH1Xo6yAIkr9d+lYonQ+FTYpUz3CVrdPnLugC3rWcViVg4TNlzs1n3DFjj4Z8atcauoDIl5l20CU50nZ61CNtZoaCuD+5wKNSPFHay4TFM6jtO8BX1/jTGA4bCoBFT7QbiPTBsRYAFazTg/F7Ap+IPNb+74PXFH7QfS9CsheLCWum6bcvXwDbaVuuOH/pTQgxCPtConKHAZ6TrPdGygKPbu4nG/jUJ1fNTE9n76sLvzKtIcgkvVIPzLbdGGmq/Qx30zIoC7kVFbv3e+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Y2+EWYyGDXIrppbK3ITwV0N6Vxdvk1ZMIpSTGii/3w=;
 b=agfGSRxj4q94VBpqfjuZYKhCDQkzeLwbDDNj19jUhKEG0qbl2QcvWnZzCJlQgta8P5FtXzgvocz1fFmMK8j1Pqog4fwF7R1BJriUSLoSIGEd6Py3uFfttLx+p8Xe8y8dm3jp4ofz/xJRgfCNVcmVUxeR5eDDi4J8UcpgAxmrC5ohNsqF0SzW/ZdEbBDafBnWLIez2FYv/d8v+tYiuYVJjuf/9iif4kujmrNGNqRuJJlxnt6gHwkRfXyyYgqfJyXvQp8Qli030FNFSAWjtZORpkDA2pbLF3YPafUchJXIy73sXh9qjvXbRrfb2b5MJVcV74Ha2MvhVSgrXMaXibJWgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Y2+EWYyGDXIrppbK3ITwV0N6Vxdvk1ZMIpSTGii/3w=;
 b=PkNUrePKYXgT6pf5kIzGL/9RyIGtN/KtWFTMPhzFAFuk2WeWR4nX/Yu1517iPIuhFyjpcxmOa4qvOGTVu1ge0RkfmfcyTggRpsMn1lmXrQargO+VuR0MJNdNbBKYWozMg/vjFo4XnTWRwkzYxt0nEORNnBmaR7HB/jcYrvGHawhKtn6qKrAZOVJHiY+FvMWkkVoGxWJNjCwvJ2TChfl6V4nTIXuV//+SkZqUL3sm8ZHomX21MEAEHhRgyXBKo3jnpb+f/GiiVGkajVPN6qV/25iFawtph9c3ksfC1vqtAwzjJzEm6kBPlSFdJT5XVaAowdm+w8PaEmqV/T/9r//Aqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BL1PR12MB5780.namprd12.prod.outlook.com (2603:10b6:208:393::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 14:01:03 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 14:01:03 +0000
Date: Fri, 17 Oct 2025 11:01:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, iommu@lists.linux.dev,
	security@kernel.org, x86@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/7] Fix stale IOTLB entries for kernel address space
Message-ID: <20251017140101.GM3901471@nvidia.com>
References: <20251014130437.1090448-1-baolu.lu@linux.intel.com>
 <20251014174339.c7b7d2cfb9f60d225e4fe5ec@linux-foundation.org>
 <6b187b20-6017-4f85-93ac-529d5df33aa2@linux.intel.com>
 <ecee3200-c8e2-47ec-a219-c88e8e905b32@intel.com>
 <11cad2be-9402-4d45-8d2b-c92d8962edfc@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11cad2be-9402-4d45-8d2b-c92d8962edfc@linux.intel.com>
X-ClientProxiedBy: BL1P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::8) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BL1PR12MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: 7642ef7f-2c6c-4b90-b2b2-08de0d859bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0xtWmpLdWdDK3dVbHZEVGNkWjF4MzhFa1NXUjN4TnJXS1VBYS9UdnFxSjRR?=
 =?utf-8?B?QVdXRVU3TmhVVURtWWdaYzBGaFhjaUg0NTUxamdvQnV4VFdJa0lubEsyUjRw?=
 =?utf-8?B?NVpVQm5aVE1zb2tON3RmZFNVM2g3bEsrYW90Y2dma0ZRVWVWcGRtbFFzSGRU?=
 =?utf-8?B?QmNIU215MzF0WkZiRzRmNm9XS2FZZ1Z2OGRZaDhGMEFidW9rekhSNFdQN1pC?=
 =?utf-8?B?anpkUGcxa2NvU2g1a3VXclpRMmpqSGloZHBvSmJkbHFRVWtaMndvQnNxTlE2?=
 =?utf-8?B?MUxhZTYrTkVXWFlwZ00yWWpyYnF4TEVkOUU5TE5lRWkwcG5DTHBObko0eVhO?=
 =?utf-8?B?RTBQRWQ5eWF2azlCSjh1SkdhdkI1eGUxbExoUUVTb0JZMlRtdCtvOFo5Qm91?=
 =?utf-8?B?eEkvSXlmQzlocnBjbU1DTkNHSloySEpXY1d6NmdtdG5KOFdPdlVGZUVMNmVa?=
 =?utf-8?B?TWRyd0V0MEpUcVorREk0TG5YSU9GcUFjcEtvSmJmaWRwTERjYnorZW1qbW1R?=
 =?utf-8?B?T1pUY2NVYlVVK0ppUXBvMExpR1dPb3dTYzJENUE3ajgwNnpVVmkxWjUyRjRQ?=
 =?utf-8?B?cldiRFVZeUVxejMwbFF5blBVaVhQcW5UcHc0empIMjJKQkRINGVXWUJrYnAw?=
 =?utf-8?B?Y2g3T3I0dDVoWXFyVXByQXhjL2I5YWFQVEJPa2Q1TlBXTzh5Ny9VYWZoUS9M?=
 =?utf-8?B?TUlKb25WQ2E2cXQyai81MUVQK2tSTzJhZEtHOVhEMmRrQlFoNjhFNFlkVnFV?=
 =?utf-8?B?UDdldStpbWgwWklCbTZuTmtacjYvaFNGZ0hkUUZFbEo2aVlMMUFlTEV6emtl?=
 =?utf-8?B?MEt3Sld0d1p2SXlEOWliNlJwOXlQTDlKRW94VVo5cUhtNjV3KzUzN3NRTDBO?=
 =?utf-8?B?aThHcWFpYU9XU3kwQmgzZGRMamNFN2VOL1k2NGZrdnhCTmwzeXNUTytDU2pJ?=
 =?utf-8?B?OFdJeUV1alA5SXNqUkcvYnUxVjRYSEp4SXovbFVhYnRPbGZFVXlJclpEbHND?=
 =?utf-8?B?T21XbEdUZlVFZzFtVDRma1lBdnJmb0VXQUJSc2lHMm1EZy91UFA3TDA3QmFk?=
 =?utf-8?B?cGRFZlhqKzgvakNOZDFRK3BQSXhRNUpyanBQS2hDaVdXaDUrQm5oaU5XUGhr?=
 =?utf-8?B?UFN4TzVadUdSZUlqQ2hSKzgxOWRoVE5zanhGSUMyZUZSekpyamxiUUxqTmxy?=
 =?utf-8?B?ejVJcUloQys2Zlo0RklqNHVySERCNU4vbFdpSE5FcklBRzVTME1hU3JXaFFP?=
 =?utf-8?B?VUlRejFtQWE4a3BPdTVmY0lNRXU5MFA2dFcrdEVnSE9BY0dWZWhTdkVoTk1W?=
 =?utf-8?B?ejY5UzRkZ2EweTJteXhUaXJDWDMxZ1hRZUNWYVVwZkdQcWFKWTZDN0VQSE5O?=
 =?utf-8?B?ZDBZRyt1MkU3Q2hGeWMzYlVUekZqRWd2enJKMkFjRnFoVnNVK2NqdU9uV0xB?=
 =?utf-8?B?cStRZUJJc1hFQlFhVFZ2a3ZVOUtsL1JjSUVZSndWblRBV3NlRVBBREZtakNa?=
 =?utf-8?B?bTNzUUhjdHNhdm0wdWs0bHJvTTA2d2QvMkZXYWdmZDZPSzl4Sm55dFYwSVNp?=
 =?utf-8?B?a0t2MVdoMzZ1a1JkTzBlbEgxLzN0MXJTYjdpMmdPK0U2S09hMlBCd2RYZFVw?=
 =?utf-8?B?Y1FiYnFDV1NLeW1lOVpYcnBaT2FrV2cwdDVXU00yZ3pUM3luZ2NjUWVzYi9n?=
 =?utf-8?B?Wk1OTzgrRWZPWEMvWFdpY2o0YTdYWDhqSVlHYzI3THNiWUFNbGpnT29tUlZF?=
 =?utf-8?B?aWtJVW9oeTZWYXY2WFc1SERCYVprd1dpV05lRFU3bkVhUWhEV2pPUmhaYnE5?=
 =?utf-8?B?aUx1S1hlVlFVNmRsYkI0ekdCL2FtVWo5QTJ0MXEwd2xBRXlDS05IYUl1Y0hQ?=
 =?utf-8?B?RHJMM21LeUN6SzhEOGx4SGpqaDgzeEcrckcyUUp6YTJKd1FKNDBpQTJwRGVR?=
 =?utf-8?Q?60mJwNSxcZiIxGuYZbf8+uoVP5V8AZVs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHZibkQwdGJlMHJhNlZFcUQxMHhNM25WWGZQdkovdGNEQ0pFdE02elI2TWFB?=
 =?utf-8?B?TTlRSnIwWDJCem4veWZoYmdXTVlMbFpyVjVjLzFZMmJBV3RsNmdLaERHY3g0?=
 =?utf-8?B?N2hxN2pOdWZ4ZlcydERmemo4SHRTTEE1Nm9ZWkVpeHNjMnFPVVkxVFpuTkI4?=
 =?utf-8?B?eGNCNFdKNkllbHJqNEg2NDZHc1pObG54cTUxWWdhaFdYRk9TZnVyVlFVR24y?=
 =?utf-8?B?azBmUGZEM3lXOVV2SysrcWR5MWY5TmxTWTlyamhNUkJ0Y3dKVmY4ZWlyNnZi?=
 =?utf-8?B?MlBHT1BNU05xNXl2cWhISzVRSWw0S3ZjU2lualU2QXFtdzlndnppZG4yQ3lM?=
 =?utf-8?B?Y29IeEFPUS80QitBTlJaZnJJMitwclNwbVFOSmJWNTBEMHRRa2pqSU9wNW5s?=
 =?utf-8?B?OEJTRlNhMmczZThuTEhPbE9lZ0lwUVllS0l2bVVETDZUclhUMmJjdEVRVisx?=
 =?utf-8?B?eVJHbS85aWxIa254MmYvM1Q5Z2NDc0pVWVpaSVBoQm05SDJNYno0VWo0RmZO?=
 =?utf-8?B?MXZpNndyN29FQkhyR2ZiOVVPOTVEVHRZV1FMZ3NvSVk2UC9UMUVub1Q0eGtJ?=
 =?utf-8?B?MVdmMXg1WDV3NHhzUksvV2plQVFHOU9LdncramM1VThhZjVOL1ZCWVBZTWdq?=
 =?utf-8?B?OEhmWFo2bWc2NTVKNDB6Wi9nbWZSUFpRY1NFdkdRZVdzejVycVJCakR5MXdK?=
 =?utf-8?B?dGJaTkJrLzdldlh6L0ZWcTl1Z1JDM3VteVdnM0NFZjZlMEpnM2hhMG9YTGNF?=
 =?utf-8?B?amdpK1l6UUxyTW9FenNCYnFYT0tLQng1a1Jib0txZ0V5ZXdQRWgwQm1ZVFNv?=
 =?utf-8?B?RURTdTA3bzNCUm9DZzBGUC9vK3ZabStOTVZ1MDRWNjF0ai9RWGp6Z3dRWHhO?=
 =?utf-8?B?aWN1N0dQTkJ1SkZKcGYwZUwzNnR1YTBWUmJwL0crY1RVUDg4ZzBXQUtmZ2FY?=
 =?utf-8?B?ak1GblFCazFFUytOZE91dmxDdWlRUUN0UHBLeUJGN3h2bDZqTmpoei9Xa2Ur?=
 =?utf-8?B?anZOdWcyTmtSUzdBcHpQRnFZUlhsbjkvMWhXaTJJZElSTzdkeEUxbGFyR1Za?=
 =?utf-8?B?M0dNSmRhOFR2VUhVYWJOM0tCd0hPNzUwK2gzRWQvTEhkMEhYRTJRaVJlays1?=
 =?utf-8?B?azRBM2ptbDZnUG4zdWxkbHl5dk1kZzBZN3lqWFVTV2J3ejlpSHRna1ljaElj?=
 =?utf-8?B?RTlXWllDU3NEV2xNVGhnRHRvcExybUVoNzlLbXBqMFlnWmNUV1Q0dTRDZDdq?=
 =?utf-8?B?cXpRcnVCUzM1SWltVDFuYklxWEh4LzRIUm5NMDBzMGVWajlEOW1BYUJkMm5s?=
 =?utf-8?B?U3plYUY3Nml0TWxINldPMWYwdmxaZ0Nza0FISmRkc3hEd0dLU3I0UkdHWGNy?=
 =?utf-8?B?ODAvajNKQnBKVVlXanJUeHphU3htMldHOXN4UDNVdlZ5ZWEzL283TzlGdTdB?=
 =?utf-8?B?ZUhrRGNSaVk3QXUreHV6cnAvL0xFZWRuaWU1Vlk5Wnp6SzJSeEIxY1NvYlJa?=
 =?utf-8?B?RFRFMEtmWHNkdWQ0NUl0SU5OcUJZY0FvVktLVk00eW9wT01IYlo4dTRNT215?=
 =?utf-8?B?UUhJbFJNeXI2TTlKOUNWZVdUbHAxMjZRczFsc3VSQThWR1F0V2ZPWERxMk9E?=
 =?utf-8?B?Y1ZZSFZ6TDBVSVBJTk95dmx5amZPMTM2cjdqL1c5ZGI2Sm9VaVFjS1Z6Rkc1?=
 =?utf-8?B?ZmIzblp5S2dGU3MxNjVleWhGMjlYUzJSS3RYeGhBNldRTkdhSklUZFNWbGk4?=
 =?utf-8?B?UXFnQ2w4T29XZWdaN0R2NUxkR1RJWFpMbjlvKyszeTJ5TE9LS01TenExanlp?=
 =?utf-8?B?bFoxeDZxNFFzOVoyQkFKMXlLUk1LWjZyMTRMSmdsa2NRb0h3Z0lJaU5rSmg1?=
 =?utf-8?B?RmhieElpR1BFbzVJcjFwYzFOdDg5SlhVd01tQkhyd2xGdTlSZWhIeC9EU09y?=
 =?utf-8?B?SXZra2RvMTBWSjlWSHJJaFBVRXJwUUs0eTFLaHI5R2FCTmgxTlhwOWo4K3RE?=
 =?utf-8?B?UTRKcFp3UFhlRUx5Y0ErVmUzZlZwU1IycXEycXFQSHUyZnUyZHVpdHM5aHMx?=
 =?utf-8?B?ZG5hSnBiWkVob09FVzdQcDNXQU9laTAyUmpmVGcvZFRqc3FPTmxBc1RDSTND?=
 =?utf-8?Q?ob39x2ePKMQoPq+8Dncc/GEY2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7642ef7f-2c6c-4b90-b2b2-08de0d859bed
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 14:01:03.2947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQee9GQZgoJ2CoC06LkyB4+8vTFA+9x9DcvCAVbanYLPclZiOuyicpZYnXI1iOcz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5780

On Fri, Oct 17, 2025 at 09:42:10AM +0800, Baolu Lu wrote:
> On 10/15/25 23:55, Dave Hansen wrote:
> > > > Only [7/7] has acc:stable, even though that patch is not at all
> > > > backportable.  Please give some thought and suggestions regarding
> > > > whether you think we should backport this into earlier kernels.
> > > Yes. We should backport this series to stable kernels.
> > > 
> > > > If "yes" then the size and scope of the series looks problematic.  Is
> > > > it possible to put together something simple and expedient just to plug
> > > > the hole in older kernels?
> > > Squashing some patches is one way. But would it be workable to backport
> > > this series manually? Say, could we send a pull request to the stable
> > > mailing list after this series has landed?
> > I honestly think we should just disable SVA in old kernels at compile
> > time, or at least default it to be disabled at runtime. That's the
> > simplest thing.
> > 
> > The other alternative is to have arch_vmap_pmd_supported() return false
> > when SVA is active, or maybe when it's supported on the platform.
> > 
> > Either of those are 10-ish lines of code and easy to backport.
> 
> Hi iommu folks, any insights on this?

IDK, the only SVA user on x86 I know is IDXD, so if you do the above
plan you break IDXD in all stable kernels. Doesn't sound OK?

Jason
