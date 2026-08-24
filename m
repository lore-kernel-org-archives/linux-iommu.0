Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ACD3F54D3
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787592312; cv=fail; b=bxm/xEqrqhb04mIG4Pl7YtgYwIIBwq1q2no+HvU4/q7mMqgws0WavGtQIpXpBqD4JPpUbyqNUBnVte2UcYjK2s7v10TQRexSZs+dMtFv8Dk3PuxBi+Q9E7yukMQaiC3V7Wkg9OTIOWzx0I7T5vbdCJ+4G2jR/H76oXaTxFnDmq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787592312; c=relaxed/simple;
	bh=X4LJ0foUW0AafJQmyOCvybFtdX2HawTnadkUFnYwSek=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=qy8yIFSMxqxAFLB9FI1YAvM55f2GDRC4DnAloB+icHS07HUfoJgzct50sNZFSRDa2PJLRAk2CacxVt/W42CURS+f2gCDqj4yb8lpuOAT45CuTRQYy2pwyrKCj3b0fRw2xC75WTNDvKdo8TxbwR0gNQDw8A95Kj6+TWkfYDLv1Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bib0U5It; arc=fail smtp.client-ip=52.101.53.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bib0U5It"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itJ/4ar0ebsk/AXfffZjjAcHe50HTNPHUNgIxA54pPF2EoS68aMhVR3UKbzSxrIj3Z06IClvLVIiSZN1Cqdem3YqyA+6WRzF/dqTpG89OeiIX5ClJ7jgkJInuCQ0qAn3cOC933hsGyq69Oz1Xi4csesju0LHucgSlP1ilPCin1js67e8HzWn6osSqP+apItoi+HoUO2efyLByZVNthWbU2DSZ47yh/D9OVNUPtlAtNoSDSQO3FqnUpsPoQBadVU0SlHI4JNvJ/2DfuwfjwjmPypVuZ09vl8Zeo7v24BB/K6Wt66ABGtJWZWQGvtm+KghhmhRl8bMNeC36dvwHrbnHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+se8b8u3wizJjgUb1gAGprXs7jtTv4FAypvrbdhMnc=;
 b=G+gzzjQpde3dyQbbOuDguO49MEmwxwyj04+CqlSzsMyvkqMXo4LmUYb9z+EDRGF2KCya3IlqSoYFpSfeHByF0MZYwzKXVARK55dTDooTSbCvBTf4px5vno2EeW5jBRx/7f4pM6xGN9UHqNaZDwX3eiyT/fwI74IjSGZ7wR9vIo8rs/7OcH58j7+lqNiU4zSDynangRnY8n5Mo9+brKDKXnmS9dJpbUUHNPIV8AVus81JNKkj/zzUofvX4ILRUlLkBOjlUQjNv7CdJwVecqmKEkuTnX1LL2vT++wPRFIMv3GRJjkTQXjuHpAtU8pFSQp4S+cEhl0rPMyX/AI+Zm1MIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+se8b8u3wizJjgUb1gAGprXs7jtTv4FAypvrbdhMnc=;
 b=Bib0U5ItkiKjs8S5v3rccXYBuOzhphpEN6FdMPod1jqbC5mct12ZI5kDpREK2UOYNl+LDjC8OWzdR7jW0ae1g9kQc84pATjomdx6p+mmkdmeESM40t3L7OF5CV78QSyyfs+X/AUPt6ZeSAmty/alDbnoT4wPyOztEjFhLz120pMfHAq69b/DLIHBMmHr5wcZTVk8uZE6EYS+HkM4sX7vIXR+QFxtErrlEt1hj/neN/fkrqkIx1hn45hdfMQ3nu3gTX/PncD4Xt/CGGq646aZgTC4mpBn/hCsG6sHIheWp0T79Yq+agxRZJi3mqtQGp4oSMHVWCat6g1H+BmsTw08og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 17:25:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 17:25:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 12/24] iommu/amd: Pass iommu and devid to
 amd_iommu_make_clear_dte()
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org, 
 jgg@nvidia.com, yi.l.liu@intel.com, kevin.tian@intel.com, 
 nicolinc@nvidia.com, vasant.hegde@amd.com, jon.grimm@amd.com, 
 santosh.shukla@amd.com, Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, 
 wnliu@google.com, dantuluris@google.com, chriscli@google.com, 
 kpsingh@google.com, alejandro.j.jimenez@oracle.com, 
 joao.m.martins@oracle.com
In-Reply-To: <20260727132913.22475-13-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-13-suravee.suthikulpanit@amd.com>
Date: Mon, 24 Aug 2026 14:24:56 -0300
Message-Id: <178759229635.3131778.2412049716468944453.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BL1PR13CA0447.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::32) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: 44fec382-9194-4789-8bb1-08df0204a2c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sYM0W5KHehNWVRExQ4SVOypq0pMle/LdgyMCKc4UYL85da+hSGtuqJAy5YiLeuKOlIddwtND0yZms94I0MzQG41TdG3fUv5uTXz4N2Bwof7mQQcgXAHyR4cyZCyLj/KaczQAdlDe4GaAMDU4NdEb91WDRU+qCCH0oP4Y0pveAGOovuxPbLGHlkrEG9dHZg7P5OmOs7NKMVN/yjPMVV+eTEER5A4hSBrmpyTkHp2yIdNk+IICyRjqUaivm5gQPkLVZgCL78t5ZBH1oFUWoobrmvivpTKV/2a7es3V+fmhviqH55ndvNF/me5UaQ52eXT/6OggNiBTrBdy7EJ5Ruc6HRwMG7cwwtq6cQt0asUj+5E9oHlDRX0iQaVmjm3jMeOOYOWnLsx3ib5aVgbYjkDW9XqbHpGCgaTcRlDGjtrBtapMVWCPHp9NA3TmKZkL7d28OND+5gbpiCuDeeTV4/flOGw34CMFgGe3mRXfLmAhKMnX/DyYWI+0+ZHnex4bAnHD1gwsq6XFQaVxCfP7UqKNohGWwV+p/WjiRHxId8VdlqTuLUX7ymrnTudiSKIWA+LILXZILf0iYUfp86nzUYUI54SptQpe7sapYLmQvM3cprcWp9ycuo/xETUQElCa3Z02LN+nDLSsonPbIKRylW7q/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NklTOFlSU3ZLSjJ4NkFiVVFjMjQ5UUp3MFhMZThSeWNEKzZvcHhyYTNMUlNh?=
 =?utf-8?B?dGpPNTF6V2VXcDNqTjA0VjRXekN2VDNnOHc3emVoeHgyQWw1VVNhM1pZQnk0?=
 =?utf-8?B?YjA3SS8yYVlxaUJMWTdlbmxiOHpxeWVQMGpOS1FqV2haUXQxN1BHSjdCMG0v?=
 =?utf-8?B?MFVVZ2JYTXREQzJ4YVRteHZOdUtCRFNwVDBrL2dVd2MvcG1hTjQ0TnA0S0h0?=
 =?utf-8?B?bEoxZjlHem05RFZ0dms1dlRLWCswZXIvMWNkOFd6Z1lzZ0N2U0xYZ2t6dFds?=
 =?utf-8?B?aXVqZXpub2hvRXgyTklpWmZaa3ZzYVJ1MlVhVTF3eWlFSjM3ckowSlFtTWNy?=
 =?utf-8?B?SFdUd01DV2NLdzBkSnRtWmJWV3FjQUt6cUFjcGJPNnJRRmZjSElJc3UvcHpy?=
 =?utf-8?B?MG5ldFk4MmY5cnowdHNocVg2dk5tKzMxT0t4L0JaaVNPbWg1ajE0RUhuRENW?=
 =?utf-8?B?RjV3S0hiTDhTbGlMd2RyR3MyYVA4MnBPQUdpRmF2cmM1czRPVE1udUYwZlY3?=
 =?utf-8?B?ckxuSzc1V1ZGUmdRNkpPUDlvSDVrdC95Wkd3NE5xTnhNc1F5dmJsNGxCWldl?=
 =?utf-8?B?S3BwU0VraUllUW0ySGRLWmd3Zm1jYVNab2k0QmtoZUplR3NQTHFVWk4xTDEz?=
 =?utf-8?B?S2pscENzRTd4UEpUVU1NcVNxS1Y1NERNbXZxTi9maFR5cnMxNHFpYnhWZjR3?=
 =?utf-8?B?cVIyYVVsWmtzZXBBQlNKbGwzL1lBNGxxdC9vTnRCV3JCZ1ptczBjVEVWYjhX?=
 =?utf-8?B?UUlIVDJsRWZuQXpIYmJhcTdGaHJGWlVpYnh1TU1RaHJ4aXdLazJOWmkzTUhX?=
 =?utf-8?B?MkdUZlpJNWErVHc5YUlqS0gwVnZLSDE4U3kycmhpeXpzb1FhdUtMZTdHenRZ?=
 =?utf-8?B?QllVS1JlaGx6NTZpN2lyYlF2NXpFUHplL3ppZ2xZQng4eVFIK055OXRHVHIv?=
 =?utf-8?B?SEZMQjJOak9FU3UwNERzZUVsQ3Ryb3gyU1ZMOWhUd1lFaDEyc00wVHNDNEJN?=
 =?utf-8?B?UXI3MnFVZHZVbFAyVzBjM3hoakx0bGU5QXdPZ1E3Mi9HZzJnTEVONDZHZnJq?=
 =?utf-8?B?Q0E1ZlpKaFUrWW1rcm15R2NmVFdUc1NhNjlYMy9KY2puM1JmNHB6RVpFN1hs?=
 =?utf-8?B?MjRhSE1MYzdwOGJMWHp1RTFPRmF3TlRiZTZodmhWaWJwbVk3WFZLME9hMHVD?=
 =?utf-8?B?SWo4b1l6c2MyeTF5SUY0d2wwS0JlTTA2T2tSL1dyL0c1V0ZKSHdpME1PeXlh?=
 =?utf-8?B?R29lUEFIWEx6bVhlQ0F4QnpHVUJkTEY5aE9EMXhab0M3ODhUTE1Hb3ZQbUtS?=
 =?utf-8?B?OFp4NENCWW9Gc2dobm83Vit3ZGxZRmtqcWdvaUo1cXBJdUVWelpLb3hwUW9E?=
 =?utf-8?B?QUdubTN2dGVrV28ySjhUUWxXaVJveE9mdDRpVDRRWW81YndJUnR1YTZmZW83?=
 =?utf-8?B?aGg2ckdqOHFNV2JPeG5Fa2Z0RDFrRzBzMENrbXhOOVluMWZEcW0ycG1lY1dZ?=
 =?utf-8?B?RU55NlRmL0JNVlNNRHg0U3JJaGpuazVGMDlidXNmbC9ySTdKMExYeVBBU3RI?=
 =?utf-8?B?QU5WMUx6TGc4ZzFWSzcra250ZTJzUkFYUTYxdWJrbmJocjRLekFQYzBYWU8y?=
 =?utf-8?B?UVhpaThUczJEU2RtSVF3MTNzeVBlQmh3QXlNWU14UC9Ody9PZk5XUFYrV3U1?=
 =?utf-8?B?NmZrZmVnOFphNGdwLzc0QTlKUFRoa3g2YUdka2pkRWpwaElOb3UvTHlMejIy?=
 =?utf-8?B?c1JPT3NYK3B0cWdzRDBNb080YVpJMlVQWDVaOGVlNm16UWhTenJEMHRLQXVm?=
 =?utf-8?B?bHRuKy9JcXlEQlRsTEdsdmhyM1lreVkxS1hyUW1ST0JPYkNFZWwybHZuRVJq?=
 =?utf-8?B?NU1YUnZRbzBxdnVhRjZBK1A3Mjl4cGFJQ1U0V1NXMWJPbW5oSHd4eWZsRjUy?=
 =?utf-8?B?WGM0Rkg1Ty9JMGRKQXZRZEJrekxZa3dMa0lZMlhPUFRYZXRHaDM2VFlaTVVC?=
 =?utf-8?B?SHpERFhTUEVmaHdQczB2VjVqSWhQa3RvcmZPaW1JMTVHaWFnSHoxeFh4VXFG?=
 =?utf-8?B?anBXWWNnVDU1N2t6N2pwQUU1dHVqckRaK01BRFZ0VkVLYnRWTmRkMUpXN1Fx?=
 =?utf-8?B?TVhMcVJFeCtkRnkyMk92VkhobDdkMFFQT1c1YkVFdFdpMkxXZjRwSHJDM2V5?=
 =?utf-8?B?TDZnMFVOanlaSXQ4byszai9McXNwMnlEUVVNYkZFQTQyUlJuOGlTd3NKR2k3?=
 =?utf-8?B?M0w5STZKekxDREsxVzZDVEszWEVBRDV6d0p0TUxWTlRncUphb2RLYU1jM0Z6?=
 =?utf-8?Q?0DLmBMl99jjzJ4/Q1E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44fec382-9194-4789-8bb1-08df0204a2c6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 17:25:04.7887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvvjis21PFIIYOKgdRkDkoDg14PWofJND+4wAubDNF6azOZQanBp5WKtltak2jYS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302

On Mon, 27 Jul 2026 13:29:01 +0000, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:
> Take struct amd_iommu and device ID explicitly instead of deriving
> the IOMMU from struct iommu_dev_data.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
