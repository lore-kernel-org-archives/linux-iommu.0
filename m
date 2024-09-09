Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFE31B5831
	for <iommu@lists.linux.dev>; Mon,  9 Sep 2024 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893425; cv=fail; b=TcqQFccd4ZT+B11k94/bUc/dp0wo+UrkJepViy8DrCafeS+I3F/s0xnLAFNOo6rZeCHSVTRFIIhaNyR3FmLKmFCTCJBqq6gY6QYxRySEBFkV4SeAed7L4MNLPaOZupofWcP0Eiu+NgBq8j+bYeucSXuxCp//uDiSG46v8iUgaOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893425; c=relaxed/simple;
	bh=xLPgUGVgzLzimLxEU7Bd/uJAbk/cYXQZ6zK76aw1+OQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XSFI+IQYHHy/lVuBlhgZyL7XXeMOxoW2JhgymUFI2X5PRtkPIXB2iKrcEtz3JSe32hAfOu3m6PcKR2lOFJBT/oKyFg/NN7FDVAw0P36/11lu6nqg3yK4ZFV6jZXlPaUoF0fEwlQU4vS/Wv/vV44zVSrckguKmTuihgu3McFe8d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OR4KkU/s; arc=fail smtp.client-ip=40.107.96.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OR4KkU/s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQL8rrr177SwseeudZ3ZBlQBxKvC6tLJ+bLF76hiGu751uGGtH1iwOFP4a9P8YLErHaXxCPSXixleownO7M2DyoqtbBglCEWPLpqzv6ZjtsfNpIxsko9cymioI8Hj2xiyRL4fSqcNtXSoX5YqcTsy9uQDmHxEz4Xh9jta8cNQh9pMWdfUwKOlXKxTLJFz6aZSCaJHPmR53kDu/jy5xGzF1J7jQsgD/ZCJMG2DeNZGCOU8MRcpnpbogNLwYpy4okOu9KX7hAGNs4nrIoTqZXVhd20IYyLj0EBLaJwGqfc+0a9mmz/WSi0bSGk111uix0QJE2K6RwwdsN4M7w5VhQgEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5pWLEoamAgWSvfczjoc+icy4OzgAEtsMjXtdorWFDc=;
 b=uXDtaFLy6mUL6J9sPJMNVyeuw71f9tgr5dFFQFk492XsuRl90cv7/1cShS66oA2PRMJfxHCcnFaP0EKNovmowhmM1eBNgfjJQOUdPpQ8Wigm8n/h9yEkscWW9q0BHadxy6IJjadDrDi8/6MgT97bqIzeeUC7tY5db+W4302VjXDcPmSyXEmEg90J33jgS2irEUmIN7L4PUXpIWyU7GFgBb9UgSBRsdb7UyVGeCNOAD9LxDofWr8rNDYfGDbGynh2DIfQx0y9f7LX5EhN68gIJvCCkaxESv8TIzZvYYeaSUZr5P70KYPRlMRok143jo1PCzkDgE19zd98o7tK2iaSMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5pWLEoamAgWSvfczjoc+icy4OzgAEtsMjXtdorWFDc=;
 b=OR4KkU/sW8XhIMeIWOOAAuNqS4LrHgvj/6VQguUPlBVS4hmjPfj9DxiCEefRCpUUjkVDinY725WmTyfgayfZice22YsIXomHlVWNBDOAeIPlTJwRawApwj8rAUmvxpfYQrTfbDO7DORVBbotf1JaSFACAL4gGNJa7Bpuo2ZMsCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Mon, 9 Sep 2024 14:50:20 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 14:50:20 +0000
Message-ID: <73703ae1-f4ca-4f78-b8c3-e912f398b485@amd.com>
Date: Mon, 9 Sep 2024 20:20:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add kernel parameters to limit V1 page-sizes
To: Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, linux-doc@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Joerg Roedel <jroedel@suse.de>
References: <20240905072240.253313-1-joro@8bytes.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240905072240.253313-1-joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::22) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY8PR12MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: e40f3902-3f15-4e87-8851-08dcd0deba28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDNGR211Zm0zMWQ4bTFwVkZYWFF6SmpyZzcwNUJWN0JWZnI2QW9sZUNpME0x?=
 =?utf-8?B?aHpkbXgrdzl6TkFrckh4Z0FyMTBGK2hERjUyREtjSFJKNmpiZ2tMN0RiK0ZT?=
 =?utf-8?B?cFlJSHk3THF6Tk5VOTY0aHJXSG9HZGtoQ3lqK20rR1FTanlVWlI1MWdoM095?=
 =?utf-8?B?azU3Z29IS0hOTldpN0VQS0NWSzNvbmZLTFIybHAxbU5BVGVUZnl4L2FpWURz?=
 =?utf-8?B?L3N1ZUxSS2FCNmJYVC9MQWR2MG5hRzFabkNUK0JPbWZRTy8ybHBaYVNrRWs4?=
 =?utf-8?B?UjkreXErNGg1N2dxeFU3S3hOWXNzWUNKK0F2aXQ0dTBHUlIrcE1JSjFLOHhQ?=
 =?utf-8?B?RnhyQnltK0cvOEZNMnEvOUxmaTJuZjZwY1lqcEc3ZlM3WEQxODZvTHA0OU5Y?=
 =?utf-8?B?dUVFY1FRRlkzYkt3Q3VjWTVZcmdyNTNtZEEyZ3lXNU9FKzJ4KzllclhqT2ZP?=
 =?utf-8?B?ZXREVERsSHpOUmlzcE1EWjNCb3ZSMTluNHNFNkFCVDlpMUIvcldUSGxlYlh0?=
 =?utf-8?B?Y1dMQkpmYUY1a3VPZm1YNVoydFRXUEgrZ2lYaVRQdlVobm92YmVINis0Ukxx?=
 =?utf-8?B?d0t4TGRvM1RDN2M2MzlUZmJ2VWVpcHF5MCs4QmdTbjdxTmliZ1UzN2ZTWlpO?=
 =?utf-8?B?UC9qWGhnTDYra3JtRmxuNzd5OUs4ZitGNDFXck5hZXpmdi9UYld4aG5CWGg1?=
 =?utf-8?B?OS9yYWNSSkU4YnRQcVd2VHN0Y1BuNmM4cEpsREN1WTc4NXdWK0NhMFYrbERH?=
 =?utf-8?B?LzJNWVBxU3BEK1hUVGtWdCtIQUdmNnQyTGRrRDk1djZJZWdTL2RFN2tvMTNX?=
 =?utf-8?B?TW1tYVBvVmdoR2J5RFJzR1dIWThwQU1jUnR2N2lpSWJBQzRrcXUwanZCVFNG?=
 =?utf-8?B?OHFOWGtrOHN2QUFqL0FlTWV6eGtPSEhvSGxNcG40NzVXWGZjVEFvU05DeU1h?=
 =?utf-8?B?cnppWG4xRytZM0xpb1NrdFRtRDF3OERHbkRUYURzNXRTenR1eC9oME5OTGlE?=
 =?utf-8?B?Q1FIZVF1azlJWDVkMUV6bkFKcndxbWV1dG05V1RSZnhMNjkxT2dIdDFoTmx2?=
 =?utf-8?B?ZnlZbE5NMHhvMTFEakRReWhzbzl2QWZ5eGJZL0plYXl3aGdyODRsd2tKN29J?=
 =?utf-8?B?ZXNKQVJtUE1pdTZIZWkyVHFlWHljUFlJU2JnUVdDcWw4ZmQ1WVlsMDdRNXRt?=
 =?utf-8?B?aXdGVldSSVN4Zjd1VHg0Z1BOVWNDSWFCNFRodGhreXFuV28wcHRRVFFzaGtD?=
 =?utf-8?B?RU1jdTBTbzV2clE0cFpvMmVhVzhGOFVnM1JabGw0U2c1VUo2ZTRDWE1nYVY5?=
 =?utf-8?B?Q2RkcWowd1RwYWIyUDVZNlBoNmQrSUo4UXB3eUpraS9KU0hjT3NySjNDRUo0?=
 =?utf-8?B?NzRwM0wvR0NXUndFL1VEU1VWMVB4T2czblh6NjZiNys1REw5WXhBS2VZNGFV?=
 =?utf-8?B?V2pJc1ErWEsrY1hGY1ZpczU0TE9Fc3lRb0RZSStoNEo0cS9sNnNQYlJaS1d3?=
 =?utf-8?B?S3ErWExlNVBjZUdYR3E2WlNqZ0FFT1FiNW5naTNHM2M1aUEzeEhmMlZUL0NV?=
 =?utf-8?B?VTFBZjlXRWhNbk1nUHZuaVZnQnFwZHBiZXlteGhWNW1hMnJlWjZmcEsvb0Y1?=
 =?utf-8?B?ZEphOUNXRXVtTHJDVUt6Vk9GZ2dSYkFibW1rVjdTRHVVaG9PaHJuRGNxNmZC?=
 =?utf-8?B?WkVNNGZSTFN6aTZFRUZ3YWRXUUc3TEpRSTh1VHRvenF6d2trN0k4UWpmNVgr?=
 =?utf-8?B?cFk2aWhzWUltQ0pJNkFkZFBQSjBuYXRKWGRiVTlwVFNlU1pIQzZWNnVXNDlN?=
 =?utf-8?B?UkUzRXgwbTJVRzBxc21FZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nlh6UHRUTmNSMVl6TUZIVVZiT2pYamoyM3doSlk1TFlNMTVEQVpmVlhMcXI4?=
 =?utf-8?B?LzhoNVd5eEZhRkcwdmV5ZWRpMFBCTTVwRVU3NDc4Mm4zZW9YRGdDc2RCQlF4?=
 =?utf-8?B?aHA5M0xNRDFnMjJ1b3lOVERKcWNVTVJtK29PNkphTmVVMTlDM1l3ZEtDaEpM?=
 =?utf-8?B?cnY1UXZUUk5Md0V3YUorbXppM3lzZEhwemRBd0E0dUVQSkoySWdNNkxnTWtG?=
 =?utf-8?B?VzZGTklCTEdhQ3pRQUIzZUtINUljakZpejJXYWZZN2drT282eGlrdFFJdUxQ?=
 =?utf-8?B?MXo4Vy91S25vMEFacjMxZWx6MnBTclg3RHQxdTdjM1UzSUphWFpRRTZxSVlw?=
 =?utf-8?B?THVjbGc0UDRkNFhYZStXTk9EU2F1NXdhTmJxYWVLOU9MQmVpbHhKd2NiM2RP?=
 =?utf-8?B?MkhpaUxQd1NEdkJOS1AyQ1lLTzJ1YVFadU5yaXl5NGVySzFKNEpWcTJWTlJ1?=
 =?utf-8?B?Q1JYQVhoekNUUjNTb2tZVnJZaEpkdXdEellaQzIvc3U2b3hRRXZpejhCZjBs?=
 =?utf-8?B?eVMvQ1B5Y2FURTBwMFNtQkFkRVEyVlRwQS80c3ZCYjliaHM1eTJzZmJLeS9M?=
 =?utf-8?B?TXRNdXR2M0VTOXhnbTlpVm9LdU5OVDNwR29UenBTeXdZbWlFVUpSVmxuekQz?=
 =?utf-8?B?QTg5Nzd6QzNpZ2xOUFFlTi9wVlYvYlUxOGx5U3VTd1hEN0JxWi9XSGV1WldF?=
 =?utf-8?B?UmlxeUpUSG85NGZDcDBGVExDMEFNN3E2TkxBc081c1RvUzVuMDJvWkNSS2E4?=
 =?utf-8?B?Q2h3ZnpTd0dqbWVjWUtlSEVteFNBeGZZK3dlY2JZMW1RRUhldzBBc2VKTmlB?=
 =?utf-8?B?ckdqN2xzaVZwb3kzUUVuRDRzeDNyemVMaHdZaXFXRXN0VWF6cHZUck5EYkxH?=
 =?utf-8?B?bW5JNDJ3VnFjSXVkZnZzZHdTRWZYUTZaNnhoelhyUzdmaXRibklmVE0yRXkx?=
 =?utf-8?B?Q09NaVlLa3dISk1FTGRVa0FQdTRXb0RlbXNObE1OaHl4WEFQd2tKZlRtMkNF?=
 =?utf-8?B?VEszcWRzVjFxMHVheDBiTUtYZzVQWHMzYURGSDg3RGRaQmNOK3hGZFE5UE1P?=
 =?utf-8?B?TDJ4dVhJZE40ejAvN0hyMVFQTHZ1OGpPS21mZWZueFhubkl1aDBVRVh5WEJO?=
 =?utf-8?B?RlBaYUM0M0RuQS96bGZhYnlFSGJzMStjVUtnUGYyKy9zcVpNT2ExdHRoSjdp?=
 =?utf-8?B?RTd6cFhjUyt0a0JvU0J4YU9KM2J1TGxTM1FLWmNsblgvYVdIdUgzRnh1ellw?=
 =?utf-8?B?cHJBUWNKeHM0QUpyZlF4SlQwV3B5SHkwU3dEYmRpZG80TFFXWDg2WUhCbEUy?=
 =?utf-8?B?cVNhTGovTUp5aHRCZEdlOXBlNldRN0VnZ05NRlhDN3VmQWtsTUdDK1BlWkxM?=
 =?utf-8?B?RzM2NG9rVkpoSzhXaXFRQ3FrekRyQmt6T0pyU3JsVlNIQnRWNjZGWi9TRVg1?=
 =?utf-8?B?dkU1aDgzM0pVZGVNbzY3dG5vamQzK3VEMk1idmNNNVprVy9EQ1o3YW5uTUdC?=
 =?utf-8?B?ZEQwdnlhWU9pdmNvSmFtd0xobnQrS3FPeFRQZzNUcm9vUnNvbHdHaS9MYnB1?=
 =?utf-8?B?bzB4c2FCdlFkUXZOc1lvdW9JakdhNFBlbUJNTVpSYTVFS3JFVk9CTWE3cGtK?=
 =?utf-8?B?S010TE9mRVVRbE9iTDZ3di9FL2MxaEhHN0xJbFNISUdMNlFsZzhjS0FtYjFD?=
 =?utf-8?B?NzJETk8vTWpBRFZkUWFrd3phWW1VNHd6K0pIUTRoSjdIckUxOHJSV3ZkM241?=
 =?utf-8?B?bmNlRUlzcm5FNkYxZ2hKT3R3S1BJekg0Ukw5UmlJS2h1eFVFTjNHeEl0a0p4?=
 =?utf-8?B?Z1Y0cU5nTDJTMnVKM25QWUM1N1d4clRRbDM4RWpGOGpzTFdLa0NzUWJjOFBY?=
 =?utf-8?B?ZjhOaVFuc3JNV001VTZVSXhTcXcxYzhtVXJsblpGdkxNU2VjTGVCYzBTQmhp?=
 =?utf-8?B?YjhjU3p5ZUhpYmgxa1QwWHNLZlRLUm40bEVqTk1LOXlRcHh1cUxkS1pQckUy?=
 =?utf-8?B?K0hVOTF0VHJGQ1ozVVc2QmRhdU1RYTJHMGFqSDVLdVBmeENsY2R0TGxFYWpY?=
 =?utf-8?B?SGRlWERGTko3S3VCbXo5b29HQzZ5VW1ZNTQ2UW4wcDVaOVlzMDJpV1Q5RmV1?=
 =?utf-8?Q?Fq3n6NHjLnVxBukYdkxbqErNh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40f3902-3f15-4e87-8851-08dcd0deba28
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 14:50:20.8523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANBjoIG4qtscCLLULa+ai5ECsjknvLdXYbI8DrjQLvlGRK/PboaV5CYZYbLKFRKtYxmPneD0Z/B+lmbZM4XE8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244



On 9/5/2024 12:52 PM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Add two new kernel command line parameters to limit the page-sizes
> used for v1 page-tables:
> 
> 	nohugepages     - Limits page-sizes to 4KiB
> 
> 	v2_pgsizes_only - Limits page-sizes to 4Kib/2Mib/1GiB; The
> 	                  same as the sizes used with v2 page-tables
> 
> This is needed for multiple scenarios. When assigning devices to
> SEV-SNP guests the IOMMU page-sizes need to match the sizes in the RMP
> table, otherwise the device will not be able to access all shared
> memory.
> 
> Also, some ATS devices do not work properly with arbitrary IO
> page-sizes as supported by AMD-Vi, so limiting the sizes used by the
> driver is a suitable workaround.
> 
> All-in-all, these parameters are only workarounds until the IOMMU core
> and related APIs gather the ability to negotiate the page-sizes in a
> better way.

Thanks! Patch looks good to me.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 17 +++++++++++------
>  drivers/iommu/amd/amd_iommu.h                   |  1 +
>  drivers/iommu/amd/amd_iommu_types.h             |  4 ++++
>  drivers/iommu/amd/init.c                        |  8 ++++++++
>  drivers/iommu/amd/io_pgtable.c                  |  2 +-
>  5 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 09126bb8cc9f..6d6630aec46c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -333,12 +333,17 @@
>  					  allowed anymore to lift isolation
>  					  requirements as needed. This option
>  					  does not override iommu=pt
> -			force_enable - Force enable the IOMMU on platforms known
> -				       to be buggy with IOMMU enabled. Use this
> -				       option with care.
> -			pgtbl_v1     - Use v1 page table for DMA-API (Default).
> -			pgtbl_v2     - Use v2 page table for DMA-API.
> -			irtcachedis  - Disable Interrupt Remapping Table (IRT) caching.
> +			force_enable    - Force enable the IOMMU on platforms known
> +				          to be buggy with IOMMU enabled. Use this
> +				          option with care.
> +			pgtbl_v1        - Use v1 page table for DMA-API (Default).
> +			pgtbl_v2        - Use v2 page table for DMA-API.
> +			irtcachedis     - Disable Interrupt Remapping Table (IRT) caching.
> +			nohugepages     - Limit page-sizes used for v1 page-tables
> +				          to 4 KiB.
> +			v2_pgsizes_only - Limit page-sizes used for v1 page-tables
> +				          to 4KiB/2Mib/1GiB.
> +
>  
>  	amd_iommu_dump=	[HW,X86-64]
>  			Enable AMD IOMMU driver option to dump the ACPI table
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 29e6e71f7f9a..6386fa4556d9 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -43,6 +43,7 @@ int amd_iommu_enable_faulting(unsigned int cpu);
>  extern int amd_iommu_guest_ir;
>  extern enum io_pgtable_fmt amd_iommu_pgtable;
>  extern int amd_iommu_gpt_level;
> +extern unsigned long amd_iommu_pgsize_bitmap;
>  
>  /* Protection domain ops */
>  struct protection_domain *protection_domain_alloc(unsigned int type, int nid);
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 35aa4ff020f5..601fb4ee6900 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -293,6 +293,10 @@
>   * Page sizes >= the 52 bit max physical address of the CPU are not supported.
>   */
>  #define AMD_IOMMU_PGSIZES	(GENMASK_ULL(51, 12) ^ SZ_512G)
> +
> +/* Special mode where page-sizes are limited to 4 KiB */
> +#define AMD_IOMMU_PGSIZES_4K	(PAGE_SIZE)
> +
>  /* 4K, 2MB, 1G page sizes are supported */
>  #define AMD_IOMMU_PGSIZES_V2	(PAGE_SIZE | (1ULL << 21) | (1ULL << 30))
>  
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 6b15ce09e78d..43131c3a2172 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -192,6 +192,8 @@ bool amdr_ivrs_remap_support __read_mostly;
>  
>  bool amd_iommu_force_isolation __read_mostly;
>  
> +unsigned long amd_iommu_pgsize_bitmap __ro_after_init = AMD_IOMMU_PGSIZES;
> +
>  /*
>   * AMD IOMMU allows up to 2^16 different protection domains. This is a bitmap
>   * to know which ones are already in use.
> @@ -3492,6 +3494,12 @@ static int __init parse_amd_iommu_options(char *str)
>  			amd_iommu_pgtable = AMD_IOMMU_V2;
>  		} else if (strncmp(str, "irtcachedis", 11) == 0) {
>  			amd_iommu_irtcachedis = true;
> +		} else if (strncmp(str, "nohugepages", 11) == 0) {
> +			pr_info("Restricting V1 page-sizes to 4KiB");
> +			amd_iommu_pgsize_bitmap = AMD_IOMMU_PGSIZES_4K;
> +		} else if (strncmp(str, "v2_pgsizes_only", 15) == 0) {
> +			pr_info("Restricting V1 page-sizes to 4KiB/2MiB/1GiB");
> +			amd_iommu_pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
>  		} else {
>  			pr_notice("Unknown option - '%s'\n", str);
>  		}
> diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
> index 14f62c420e4a..804b788f3f16 100644
> --- a/drivers/iommu/amd/io_pgtable.c
> +++ b/drivers/iommu/amd/io_pgtable.c
> @@ -548,7 +548,7 @@ static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
>  		return NULL;
>  	pgtable->mode = PAGE_MODE_3_LEVEL;
>  
> -	cfg->pgsize_bitmap  = AMD_IOMMU_PGSIZES;
> +	cfg->pgsize_bitmap  = amd_iommu_pgsize_bitmap;
>  	cfg->ias            = IOMMU_IN_ADDR_BIT_SIZE;
>  	cfg->oas            = IOMMU_OUT_ADDR_BIT_SIZE;
>  
