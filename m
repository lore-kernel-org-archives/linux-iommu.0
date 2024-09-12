Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DE95BAF0
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 04:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726116605; cv=fail; b=AGwEWpF+qD1whN+zt5uUxDhrZnN5JebvEwR/Lpa2iY0N1/BE5VYLxKHncGyvPlE3JmRXAc2UCYXOlH8NDb8alwdmGsz4+EeeqLrTq/3PntF7YXqRZ5fj3Aq7aeZHh1UI22PgR+YPHS/LRP4BpvewT1Zw82H9GzWkLRwwPY/LEbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726116605; c=relaxed/simple;
	bh=rfcoaduAehkQN9cBQHhdeKWyG98n8ifbLnNASJnxQSo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lMK4F4/5/5BlDNXlnRiuFaJ+uCYFFJknUiXn9Jjp+TMy3omr3G6mVu8zj7t8ctuTnrxSsBLDLdQ8Z/FTgKEUqU7uKjy/xZCYwmoG5I+j0dTJn+/jPI/2MiKx9cgTEwSsyKMY9C9CGPr8EVTfe8vXiC0J9gwASon9H51LqyeRqcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=30JpaB2G; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="30JpaB2G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDeXFKJyq+w2XgjYs34WxNkY59pAx5Cfx9fJQK2Kqm6zjFrPN46P1DXV2yWfIPixDND4FAkEMmxvPB45kzzaQZXNYrTVHqxowQxx+XP6oztg7VZIxaBH6ymulX4ajXj0NcAdCtPfR0uR50ywnW1OIhcb2NcbvMJAYBbq8hihZIHpXFMo9V41opUd/yzvnPaKRyYd5gmTUaGaZYSXgdKE81WwuTHqf5Z7mc+K9dfX6huERIJAT9nD83DK7uo171d3T/OPkn2LnQ6N6XxXf+yyXArCYJmfcBg9Q8uTgxEJJcFyJywMHPU2wr+WIyQ2spzAb7XPIYanhdrnzrHNliVi4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5r75DuSWK6+mFLXzUuvIJiFWKL9pl7J2HD6dXjFeqw=;
 b=mE50dHy8lLC3TXdTl4ReUj2g6hon9XQTyRlZVGz93IAU/mmueYgXUJNUk/nDLmSwyixZYfzV5uCXCXIFJi4u8rdul/se9L3dIN1JYXkbHTpOrg3iAnyWAHErLzu2OVkpF8u/247cwqluhK0soKqoMK8ZnMiJm00uVtB6IYHuKiMlG/Fglp2isPzEqGuMvLMTrUioLSE2xM/E7096ZQSlst4ZaxLWtwkk7rEYZ0tORok4L6eQU9cyHH1txwBhWsGvsuy3maYZGB/fbDkTjKySGmaJx+FKy6MMPcz+7VMEqNK4y87Zf+PFvPSbmeR8ItwqBfKjP+9l4pUhBMcJuoauvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5r75DuSWK6+mFLXzUuvIJiFWKL9pl7J2HD6dXjFeqw=;
 b=30JpaB2GsW98FspzpDMO9YO/UfuHnafBsRHKSkMozJsloJKQM5f0rZo8GY8WBYKc1J13kRaiHryFWS7BJ/InpznmAooa+a7ZooldBS232oJIvFmSXuwTU61++OnMA6FBXSIRgn5MNvytQGDZkfrRNmyBVzMEZdCQKCg2NAPtuMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH7PR12MB7185.namprd12.prod.outlook.com (2603:10b6:510:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 12 Sep
 2024 04:50:01 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7962.016; Thu, 12 Sep 2024
 04:50:01 +0000
Message-ID: <dd76524b-34d4-4092-bb04-0f7bd45f7c5c@amd.com>
Date: Thu, 12 Sep 2024 10:19:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Should the return value of the rlookup_amd_iommu be checked?
To: Qianqiang Liu <qianqiang.liu@163.com>, suravee.suthikulpanit@amd.com,
 will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <ZuJxQKseMZjTjqdt@iZbp1asjb3cy8ks0srf007Z>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZuJxQKseMZjTjqdt@iZbp1asjb3cy8ks0srf007Z>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::28) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH7PR12MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e79fba-3cfc-455a-82ea-08dcd2e65c12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUdjaVgrZ21kYlFWNEFSaytHUlRCNGhrRHdYUmc2R1pBd3FuTTRNaFE5YXZS?=
 =?utf-8?B?ZmtPYXRTNXV5dTM5V0ZBQXZydnZKOGZ4T0hUWTJwYkppdjFoS1A3Qmt1WW9k?=
 =?utf-8?B?MDI2ajhkamFJNFVwQk9LWkMyN29SV0o3Y3lhNUdEdnJUR3RadjVxa2VwOVVu?=
 =?utf-8?B?cFk0aEs2Y1E1T1pSQUVCN2hTTnNTUzhXa241VmRPV21WU3BIWk1iYnZDbGZj?=
 =?utf-8?B?cmZiMUp5Ukw4dlVCb0prNlc5S3NreFNpQ21KRHl5NkJnVkZQMHRlUHZQaFRG?=
 =?utf-8?B?RWExdDBrMmxkellTMGhHU0tyUmZaR1R3b2NTbTZjMWdQQVN0WnFnMTRNZzFy?=
 =?utf-8?B?emZqOE1qKzFOeThKSGVMeGNjd3dOV1RYWUlCSis2UWY3enFDc0pHcElVUVBn?=
 =?utf-8?B?MUVSOUxMYUpwaFZaS2FZS2dKYmpTRldrZlRuNUpiY0FqTnQyMkJOWHNuWmx3?=
 =?utf-8?B?cDdJUFhycnJVdHRNKzlpNHJTZG9xeE5ySUloRFpRbG5vbTBFMWhVa2ZWRnRV?=
 =?utf-8?B?d0l6dmdMMnNob0tmK3Z0eDBiSzg3cGp1Lzd3RzZuSUtwS2svKzFyTlF3QkQz?=
 =?utf-8?B?YUEvVkw1VzBEc1RlY0FqcHFuMk9IelVJUW9BeGdFaWtoeHBKLzM4czBoUWRU?=
 =?utf-8?B?UUs3Q285Q3MwRmhkT2wvTHZhNmh3c08xUnpWdjBZZVhvay9wUll3NThnanVE?=
 =?utf-8?B?OUhGemxYSW9PR01Da0lOVUFuenlsdVRIUkgyZC9iR3V5UloyaEx0dzd2RjRw?=
 =?utf-8?B?c0tzTHNmVFgrT04zaXYxUVNwR25jbXJrWitBL0JhQkU3ODJwTUk2U1RmUy9L?=
 =?utf-8?B?YzZjQXNOVGtlUWlGTk83V3Z5aVFMWjRxZmhtd0JGSTdMNmlxVUF6cEtyQVdI?=
 =?utf-8?B?S2E4QnJYd3FmVkkwU2YxVFMwTm5nRkFHRFZqYW1laVAvNDYxY3Z4MVBqVmdB?=
 =?utf-8?B?Q213cW8xNFRtN3RtUGZuR0FGZ0FQMnpmK2c4SndqcXZXMHZqMWdwSDJHL0RJ?=
 =?utf-8?B?Mll3MncyRjBWdSt6eks2S3RzWGVWdXk5Ri9zTDA1aEhWREhHOERTendaNndr?=
 =?utf-8?B?WDJ6VzI5WUhrUEYzTXBqUEhtc1dROXdlZnl5SlBPZElVMFQ1VFVwRFRmZXh2?=
 =?utf-8?B?Q05LcHNidU55SnFBeHo2VHhjcnlHK2VOMHpvYUE1ZkVvS3E5eE1oN3hsRnBa?=
 =?utf-8?B?dHE4ZTJRUllic21GcjVPUlB0NTB0SzlyeTljR3FpZkhYUTVDSmU3QXZXTEJ5?=
 =?utf-8?B?ajI5Y3E4aUUxc2ZjckZOcjgvZTZ3OFh2S05FVU9LS3VMZC8vM1R4QjRwbEU1?=
 =?utf-8?B?R1M4TnJpcUJUZFlMTS9XMmZ4VTRQOC9ROHlJT0NibFlOYmtVRGx6UXVsclRh?=
 =?utf-8?B?UktVV01oNTE5TzZETjg0VjBYZHZ2VXhBQ25LM3hmY3N4Uk1lVk5IM21PbE5Z?=
 =?utf-8?B?eklnSit5T2NKSkZZbEJYQkh3N1pySWVtdi9NcnVYajRqWUVpODBzOUpDa1Z5?=
 =?utf-8?B?U29MeEFNK3A1QzRRWTZpTmtOcGw0MmliUUNraldsQXVWb1FYczFRS1FVL2t2?=
 =?utf-8?B?K3R6MDZKUmNudUVoUVFNRXV2alJUWEd1OXl1WWFFRlNKK0JWVzA5WEt2K0RN?=
 =?utf-8?B?NjlJcHNMMHo3UXpkMWZzNVJzQVFKcWpCUlkzbHRzcE93eXpFaDNXaU11dXZw?=
 =?utf-8?B?RUlSKzg4bGhWQ0xraEFOVjhrMDNyVXZ1bWRSYWJuMXIvVllvcHdUTWdBY2V1?=
 =?utf-8?B?aCtwbDA1UDMwaHpOVTBoWkpiVlBkLytrOHUyK1JjRzNSVzhEdkw3VndVSU9x?=
 =?utf-8?B?M1dzSkp0SWtwT1lZMXNNQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnAvMktaeXl5ak41NzluZUxOOTB5K2F3UjFYSWlVeUJtNS9id2ZENlpBQUhl?=
 =?utf-8?B?WjZ0Q2hLajBGdFpKREJrTjBMMnBVc21wdkw1RVp2azI0ZjNDV3EvdXBadXI0?=
 =?utf-8?B?aHBWZld6OXdnMmpKcGJKd1V6MnhMazVsYWFPaS9oOERMSXdTNmdUM1krWXIv?=
 =?utf-8?B?M054eFE5T3hCRTZXaUpoaGlNS05wdGhBazFlQU84MUk0QW9XUnJpd3JOSHFY?=
 =?utf-8?B?NEM4Z3NZMENYb0VhemVnTzRpL0pjaW9BQnQ4MkNZVlVKM1d2YUp3TVVhWDc3?=
 =?utf-8?B?WTVOc0wvbnNYT29rZElpYW9UemRQMUZIY2Y4ODJHQ3BRWGc3ZUZWR3FIbFJI?=
 =?utf-8?B?cHByTnJZZmRud3J3ZkFUMUVwY2UweUc3Z0VCc0xQdmdoc0tvNmNMRUpqU2FR?=
 =?utf-8?B?Qkx0RHJzYWNqWlJoZ2VZTnpDeUczWlFISzZSTkgxMDF6VVYyQzJSem1WOVBq?=
 =?utf-8?B?SUliSSt6L24xRTFjY2Q2THJFQzB1WnBTSjVQTnlwYkFJekJmTDdxNCsxY1JG?=
 =?utf-8?B?RnE5NnBUSE55dUlpb0RwMzQ2NFZGQU5yZWVKSUxld2N2Q1FQemZLbjluYzlz?=
 =?utf-8?B?Sm1ZQjFjVXJIZCs0blRLVlEvWjVuQzJpRzVrWnRyRmZkVFprYUZ1WExlejhn?=
 =?utf-8?B?QU1YOVVjRHFUc1lGTUR5NUk2SFFCRXZDOTVzWkx3am45SE5KbEwvVWJPRWNP?=
 =?utf-8?B?S3Z5VG5NSVZ6T3hURHgvZ0tZZTRRRlFwS3NMNlFVcHREeTVhVDkremxaTGRa?=
 =?utf-8?B?WWhUR29ybFErbTNlbGRpZlZJNDJicnVFVGl6ZlQvMUtoWmlhQnpCbHhDOFhH?=
 =?utf-8?B?YXVLQzB3Mk5FYUJwL3VJVlMvT1FSYWExZGRRVE94WWZLVkx2cVIyamdsNDlP?=
 =?utf-8?B?ZGQ3T2lWTTZHc05ISHR1UXAvTXNYRFRJc0k3ZnhkMjYwblAyYThqMVZNNHBu?=
 =?utf-8?B?TjhPSldtcHYweGpCSjRkanU1cHBNNm5PYy9LYm5aQjBySkZrbFhMd09NNzZx?=
 =?utf-8?B?RG5rTzJuc1RSWTBoMWE2cUxQQktwTkg4TE4xVDh5M0hqZjV2SlcxRGswakU5?=
 =?utf-8?B?WTRRL09EaU9VNGxvT240L2RaYXVCZVppVW14WVpZei9LRVZQczVKcG1OODEv?=
 =?utf-8?B?TmdCZWdaVkxZdVVWYVJqVU1QL2RtV3NPSlNEZk1JNnFHNlVXVTc3V3BxVjRF?=
 =?utf-8?B?N3lvMldaMDArYlVOSmtqSUZOSlNFT0h3ZFFpT0ZIdGJkME42RGpPNWZ1dzVZ?=
 =?utf-8?B?aVRHYUI3dGlIM2NjcUZDaDlHT1N4c3F0TWlnbjVDbDRkNCtlcmw1ZWRqSXNW?=
 =?utf-8?B?L1ZYNmdzY3FTYU9UTXg2dTlBeHE1UlExY1V2NGowOW5OS1BIUHBaejQ2QzRE?=
 =?utf-8?B?VjAvalVpNnkwQVVpRVZ4WVpKZVV1eTNMS3VCUTdqSTg4ZWgrSEJ0KzFVMWll?=
 =?utf-8?B?dmJGY0ppY3N4YmgyWWF6MXl3S2xHVTZGNm9PV1Q5N1g3KzB0aXN2bm1mT0g4?=
 =?utf-8?B?aVhuQnpkaXJEeXpHaVFxSU5mNHB4UUhFRURzVjZybTJRMmFqWFg0WHBaR1du?=
 =?utf-8?B?OXlPV2tCTjFWT2JmUk9Wa0cwRTNLbGI2Y0VNcjlUSDhVRktHU1lqQWM5aE5Q?=
 =?utf-8?B?cGZNdzRUVWMzRE14My9UQWtJcFZxYktYMXpwRzVyazk2TjZJUkhONWNPY3gv?=
 =?utf-8?B?VUpKTFlZKzB6dzFrM1p0ZnpnN3Y4TmlWdllySXg4cVFCdEJUcmVWUkwwazhM?=
 =?utf-8?B?dkpSRTZvYjJ6TVdWUk1FUGZQV0ZRY2gwSEhBbU5sYWlXWDEvZmFqdGo5V044?=
 =?utf-8?B?OU5QellTTS9xWE1GUC9Za2g1RnJ1SWtwdXdtenJFWHhwMFRIT1A1OWJCdnRn?=
 =?utf-8?B?TXg4MTNiOGVhdXNUZmtyMHgrbFF6di8yYWN2a1ZTUm51QUV3akU2b2RkYWIy?=
 =?utf-8?B?NjdhTHRCcFh5amRtWmc3czVyb1JCendRbmt0ZDRXYi8zZXhBeVN1QXo5TElO?=
 =?utf-8?B?TmNOWW5rWUhrUEZOb0ZFMFBwYnNyMGF6WmhMUS9XRzl4bzRZelRhQnl0bGNs?=
 =?utf-8?B?TFhrTlVBMmFOL0RlR1FLeXNzOEpTL09yUWpnV1IzOWFBV21SSHlodVhMUndO?=
 =?utf-8?Q?OiIpYDwcT+vyLv5QPEcAwFrIF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e79fba-3cfc-455a-82ea-08dcd2e65c12
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 04:50:01.1867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfH/0lvI7rm3II1wdJv86Bb5Bix26oZYR4aiDk8qH/2bt0eAb0y1BgER5Y/TqK/8H3GEQC+UjFC3HydfGn3A0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7185

Hi,


On 9/12/2024 10:12 AM, Qianqiang Liu wrote:
> Hi,
> 
> I reviewed the following code:
> 
> 1592 void amd_iommu_update_and_flush_device_table(struct protection_domain *domain)
> 1593 {
> 1594 	struct iommu_dev_data *dev_data;
> 1595 
> 1596 	list_for_each_entry(dev_data, &domain->dev_list, list) {
> 1597 		struct amd_iommu *iommu = rlookup_amd_iommu(dev_data->dev); <-
> 1598 
> 1599 		set_dte_entry(iommu, dev_data); <-
> 1600 		clone_aliases(iommu, dev_data->dev);
> 1601 	}
> 1602 
> 1603 	list_for_each_entry(dev_data, &domain->dev_list, list)
> 1604 		device_flush_dte(dev_data);
> 1605 
> 1606 	domain_flush_complete(domain);
> 1607 }
> 
> The "rlookup_amd_iommu" function may return NULL, and the "set_dte_entry" function
> will call "get_dev_table" which will dereference the NULL pointer.
> 
> Is this an issue that may cause panic? Or will "rlookup_amd_iommu" function never
> return NULL?

During init driver will initialize rlookup_table. rlookup_amd_iommu will not
return NULL. So its fine.

-Vasant
